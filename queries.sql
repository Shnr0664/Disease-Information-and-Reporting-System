-- 1. Basic Retrieval Queries

-- List all diseases caused by "bacteria" that were discovered before 2020.
SELECT DISTINCT D.disease_code, D.description 
FROM disease AS D
JOIN discover ON D.disease_code = discover.disease_code
WHERE pathogen = 'Bacteria' AND first_enc_date < '2020-01-01';

--Retrieve the names and degrees of doctors who are not specialized in “infectious diseases.”
SELECT u.name, u.surname, d.degree 
FROM doctor d
JOIN users u ON d.email = u.email
WHERE d.email NOT IN (
    SELECT email FROM specialize WHERE id = (SELECT id FROM disease_type WHERE description = 'Infectious')
);

-- List the name, surname and degree of doctors who are specialized in more than 2 disease types.

SELECT u.name, u.surname, d.degree
FROM doctor d
JOIN users u ON d.email = u.email
WHERE d.email IN (
    SELECT email FROM specialize GROUP BY email HAVING COUNT(id) > 2
);

--2. Complex Queries with Aggregation
-- List countries and the average salary of doctors specialized in "virology."

SELECT c.cname, AVG(u.salary) AS avg_salary
FROM doctor d
JOIN users u ON d.email = u.email
JOIN specialize s ON d.email = s.email
JOIN country c ON u.cname = c.cname
WHERE s.id = (SELECT id FROM disease_type WHERE description = 'Viral')
GROUP BY c.cname;

--Find departments with public servants reporting "covid-19" cases across multiple countries, counting such employees per department. (i.e “Dept1 8” means that in the “Dept1” department there are 8 such employees.)

SELECT ps.department, COUNT(DISTINCT ps.email) AS employees
FROM public_servant ps
JOIN record r ON ps.email = r.email
WHERE r.disease_code = (SELECT disease_code FROM disease WHERE description = 'COVID-19')
GROUP BY ps.department
HAVING COUNT(DISTINCT r.cname) > 1;


--3. Update and Maintenance Queries
--Double the salary of public servants who have recorded more than three “covid-19” patients.
UPDATE users 
SET salary = salary *2
WHERE email IN (
    SELECT email 
    FROM record
    WHERE disease_code = (SELECT disease_code FROM disease WHERE description = 'COVID-19')
    GROUP BY email HAVING SUM(total_patients) > 3
);

INSERT INTO users (email, name, surname, salary, phone, cname) VALUES
('almagul@example.com', 'Almagul', 'Smith', 75000, '123-456-7890', 'USA'),
('asylbek@example.com', 'Asylbek', 'Smanov', 50000, '123-456-7889', 'Germany');
--Delete users whose name contains the substring “bek” or “gul.”
DELETE FROM users
WHERE name ILIKE '%bek%' OR name ILIKE '%gul%';

-- 4. Indexing
--Create a primary indexing on the “email” field in the Users table. 
ALTER TABLE users ADD PRIMARY KEY (email);
 --o Create a secondary indexing on the “disease_code” field in the Disease table.
CREATE INDEX idx_disease_code ON disease(disease_code);


--5. Additional Analysis
--List the top 2 countries with the highest number of total patients recorded.
SELECT cname, SUM(total_patients) AS total_patients
FROM record
GROUP BY cname
ORDER BY total_patients DESC
LIMIT 2;

--6.Query with a Derived Attribute
--Calculate the total number of patients who have covid-19 disease.
SELECT SUM(total_patients) AS total_covid_patients
FROM record
WHERE disease_code = 'D009';

--View Operation
-- Create a view with all patients’ names and surnames along with their respective diseases.

CREATE VIEW patient_with_disease_name AS
SELECT u.name, u.surname, d.description AS disease
FROM patient_disease pd
JOIN users u ON pd.email = u.email
JOIN disease d ON pd.disease_code = d.disease_code;

--8. Querying the View just created
SELECT * FROM patient_with_disease_name;
