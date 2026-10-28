from sqlalchemy import create_engine, text
from sqlalchemy.orm import sessionmaker

db_user = 'postgres'
db_password = 'postgres'
db_host = 'localhost'
db_port = '5432'
db_name = 'health_reporting_1'

DATABASE_URL = f'postgresql://{db_user}:{db_password}@{db_host}:{db_port}/{db_name}'
engine = create_engine(DATABASE_URL)
Session = sessionmaker(bind=engine)
session = Session()

# Query 1a: List all diseases caused by "bacteria" that were discovered before 2020.
query1a = text("""
SELECT DISTINCT D.disease_code, D.description 
FROM disease AS D
JOIN discover ON D.disease_code = discover.disease_code
WHERE pathogen = 'Bacteria' AND first_enc_date < '2020-01-01';
""")

print("\nQuery 1a: Diseases caused by 'bacteria' discovered before 2020:")
result1a = session.execute(query1a).mappings()
for row in result1a:
    print(f"Disease Code: {row['disease_code']}, Description: {row['description']}")


# Query 1b: Retrieve the names and degrees of doctors who are not specialized in “infectious diseases.”
query1b = text("""
SELECT u.name, u.surname, d.degree 
FROM doctor d
JOIN users u ON d.email = u.email
WHERE d.email NOT IN (
    SELECT email FROM specialize WHERE id = (SELECT id FROM disease_type WHERE description = 'Infectious')
);
""")

print("\nQuery 1b: Retrieve the names and degrees of doctors who are not specialized in “infectious diseases.")
result1a = session.execute(query1b).mappings()
for row in result1a:
    print(f"User name: {row['name']}, surname: {row['surname']}, degree: {row['degree']}")


# Query 1c: List the name, surname and degree of doctors who are specialized in more than 2 disease types.
query1c = text("""
SELECT u.name, u.surname, d.degree
FROM doctor d
JOIN users u ON d.email = u.email
WHERE d.email IN (
    SELECT email FROM specialize GROUP BY email HAVING COUNT(id) > 2
);
""")

print("\n Query 1c: List the name, surname and degree of doctors who are specialized in more than 2 disease types.")
result1a = session.execute(query1c).mappings()
for row in result1a:
    print(f"User name: {row['name']}, surname: {row['surname']}, degree: {row['degree']}")



# Query 2a: List countries and the average salary of doctors specialized in "virology."
query2a= text("""
SELECT c.cname, AVG(u.salary) AS avg_salary
FROM doctor d
JOIN users u ON d.email = u.email
JOIN specialize s ON d.email = s.email
JOIN country c ON u.cname = c.cname
WHERE s.id = (SELECT id FROM disease_type WHERE description = 'Viral')
GROUP BY c.cname;
""")

print("\nQuery 2a: Average salary of doctors specialized in 'virology' by country:")
result2a = session.execute(query2a).mappings()
for row in result2a:
    print(f"Country: {row['cname']}, Average Salary: {row['avg_salary']}")


# Query 2b: Find departments with public servants reporting "covid-19" cases across multiple countries, counting such employees per department.
query2b = text("""
SELECT ps.department, COUNT(DISTINCT ps.email) AS employees
FROM public_servant ps
JOIN record r ON ps.email = r.email
WHERE r.disease_code = (SELECT disease_code FROM disease WHERE description = 'COVID-19')
GROUP BY ps.department
HAVING COUNT(DISTINCT r.cname) > 1;
""")

print("\nQuery 2b: Departments with public servants reporting COVID-19 cases across multiple countries:")
result2b = session.execute(query2b).mappings()
for row in result2b:
    print(f"Department: {row['department']}, Employees: {row['employees']}")

# Query 3a: Double the salary of public servants who have recorded more than three “covid-19” patients.
query_fetch_before = text("""
SELECT email, salary
FROM users 
WHERE email IN (
    SELECT email 
    FROM record
    WHERE disease_code = 'D009'
    GROUP BY email HAVING SUM(total_patients) > 3
);
""")

print("\nFetching salaries before the update...")
salaries_before = session.execute(query_fetch_before).mappings()
salaries_before_dict = {row['email']: row['salary'] for row in salaries_before}

print("\nSalaries before the update:")
for email, salary in salaries_before_dict.items():
    print(f"Email: {email}, Salary: {salary}")


query3a = text("""
UPDATE users 
SET salary = salary * 2
WHERE email IN (
    SELECT email 
    FROM record
    WHERE disease_code = (SELECT disease_code FROM disease WHERE description = 'COVID-19')
    GROUP BY email HAVING SUM(total_patients) > 3
);
""")

print("\nQuery 3a: Doubling salary for public servants with more than 3 COVID-19 patients.")
result3a = session.execute(query3a)
session.commit()

# Use rowcount to check how many rows were updated
print(f"Number of salaries updated: {result3a.rowcount}")

# Query to get the salaries after the update
query_fetch_after = text("""
SELECT email, salary
FROM users 
WHERE email IN (
    SELECT email 
    FROM record
    WHERE disease_code = 'D009'
    GROUP BY email HAVING SUM(total_patients) > 3
);
""")

print("\nFetching salaries after the update...")
salaries_after = session.execute(query_fetch_after).mappings()
salaries_after_dict = {row['email']: row['salary'] for row in salaries_after}

print("\nSalaries after the update:")
for email, salary in salaries_after_dict.items():
    print(f"Email: {email}, Salary: {salary}")


#Query3b: Delete users whose name contains the substring “bek” or “gul.”
insert3b= text("""
INSERT INTO users (email, name, surname, salary, phone, cname) VALUES
('almagul@example.com', 'Almagul', 'Smith', 700200, '122-323-2432', 'USA'),
('asylbek@example.com', 'Asylbek', 'Beckel', 68202, '123-456-7891', 'Germany');
""")
result3 = session.execute(insert3b)
session.commit()



query3b = text("""
DELETE FROM users
WHERE name ILIKE '%bek%' OR name ILIKE '%gul%';

""")

print("\nQuery 3b: Delete users whose name contains the substring “bek” or “gul.”")
result3b = session.execute(query3b)
session.commit()


# 4. Indexing


# Query 4a: Create a primary index on the “email” field in the Users table.

query4a = text("ALTER TABLE users ADD PRIMARY KEY (email);")
print("\nQuery 4a: Creating primary index on 'email' field.")
#session.execute(query4a)
#print("Primary index created.")
# but I have already created primary index, thus this code will crash--> thus commented

# Query 4b: Create a secondary index on the “disease_code” field in the Disease table.
query_delete_secondary_index = text("""
DROP INDEX IF EXISTS idx_disease_code;
""")
session.execute(query_delete_secondary_index)
session.commit()

query4b = text("CREATE INDEX idx_disease_code ON disease(disease_code);")
print("\nQuery 4b: Creating secondary index on 'disease_code' field.")
session.execute(query4b)
print("Secondary index created.")


# 5. Additional Analysis

# Query 5: List the top 2 countries with the highest number of total patients recorded.
query5 = text("""
SELECT cname, SUM(total_patients) AS total_patients
FROM record
GROUP BY cname
ORDER BY total_patients DESC
LIMIT 2;
""")

print("\nQuery 5: Top 2 countries with the highest number of total patients recorded:")
result5 = session.execute(query5).mappings()
for row in result5:
    print(f"Country: {row['cname']}, Total Patients: {row['total_patients']}")


# 6. Query with a Derived Attribute

# Query 6: Calculate the total number of patients who have COVID-19 disease.
query6 = text("""
SELECT SUM(total_patients) AS total_covid_patients
FROM record
WHERE disease_code = 'D009';
""")

print("\nQuery 6: Total number of COVID-19 patients:")
result6 = session.execute(query6).mappings()
for row in result6:
    print(f"Total COVID-19 Patients: {row['total_covid_patients']}")



# 7. View Operation

# Query 7: Create a view with all patients’ names and surnames along with their respective diseases.
# Step 1: Drop the view if it already exists
query_drop_view = text("""
DROP VIEW IF EXISTS patient_with_disease_name;
""")

print("\nDropping the view 'patient_with_disease_name' if it exists...")
session.execute(query_drop_view)
session.commit()

query7 = text("""
CREATE VIEW patient_with_disease_name AS
SELECT u.name, u.surname, d.description AS disease
FROM patient_disease pd
JOIN users u ON pd.email = u.email
JOIN disease d ON pd.disease_code = d.disease_code;
""")

print("\nQuery 7: Creating view for patients and their diseases.")
session.execute(query7)
print("View created.")


# 8. Querying the View

# Query 8: Query the view just created.
query8 = text("SELECT * FROM patient_with_disease_name;")
print("\nQuery 8: Patients and their diseases from the view:")
result8 = session.execute(query8).mappings()
for row in result8:
    print(f"Name: {row['name']} {row['surname']}, Disease: {row['disease']}")








