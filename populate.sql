-- Populate `country` table
INSERT INTO country (cname, population) VALUES
('USA', 331000000),
('Canada', 38000000),
('Mexico', 126000000),
('France', 67000000),
('Germany', 83000000),
('UK', 66000000),
('Italy', 60000000),
('Spain', 47000000),
('Australia', 25000000),
('Japan', 125000000);

-- Populate `users` table with 30 users
INSERT INTO users (email, name, surname, salary, phone, cname) VALUES
('alice@example.com', 'Alice', 'Smith', 70000, '123-456-7890', 'USA'),
('bob@example.com', 'Bob', 'Brown', 68000, '123-456-7891', 'Canada'),
('carol@example.com', 'Carol', 'White', 72000, '123-456-7892', 'Mexico'),
('dave@example.com', 'Dave', 'Johnson', 50000, '123-456-7893', 'France'),
('eve@example.com', 'Eve', 'Williams', 65000, '123-456-7894', 'Germany'),
('frank@example.com', 'Frank', 'Jones', 62000, '123-456-7895', 'UK'),
('grace@example.com', 'Grace', 'Miller', 70000, '123-456-7896', 'Italy'),
('henry@example.com', 'Henry', 'Wilson', 58000, '123-456-7897', 'Spain'),
('irene@example.com', 'Irene', 'Davis', 68000, '123-456-7898', 'Australia'),
('jack@example.com', 'Jack', 'Garcia', 71000, '123-456-7899', 'Japan'),
('lucy@example.com', 'Lucy', 'Adams', 69000, '123-555-7890', 'USA'),
('mark@example.com', 'Mark', 'Lee', 71000, '123-555-7891', 'Canada'),
('nina@example.com', 'Nina', 'Kim', 72000, '123-555-7892', 'Mexico'),
('oliver@example.com', 'Oliver', 'Martinez', 52000, '123-555-7893', 'France'),
('paul@example.com', 'Paul', 'Thomas', 63000, '123-555-7894', 'Germany'),
('quinn@example.com', 'Quinn', 'Robinson', 61000, '123-555-7895', 'UK'),
('rachel@example.com', 'Rachel', 'Perez', 70000, '123-555-7896', 'Italy'),
('sam@example.com', 'Sam', 'Evans', 58000, '123-555-7897', 'Spain'),
('tina@example.com', 'Tina', 'Walker', 67000, '123-555-7898', 'Australia'),
('uma@example.com', 'Uma', 'Harris', 71000, '123-555-7899', 'Japan'),
('victor@example.com', 'Victor', 'Clark', 75000, '123-555-7800', 'USA'),
('wendy@example.com', 'Wendy', 'Young', 62000, '123-555-7801', 'Canada'),
('xavier@example.com', 'Xavier', 'Allen', 67000, '123-555-7802', 'Mexico'),
('yara@example.com', 'Yara', 'Scott', 53000, '123-555-7803', 'France'),
('zane@example.com', 'Zane', 'Torres', 66000, '123-555-7804', 'Germany'),
('anna@example.com', 'Anna', 'Nguyen', 64000, '123-555-7805', 'UK'),
('ben@example.com', 'Ben', 'Morris', 71000, '123-555-7806', 'Italy'),
('carla@example.com', 'Carla', 'Reed', 60000, '123-555-7807', 'Spain'),
('derek@example.com', 'Derek', 'Cruz', 68000, '123-555-7808', 'Australia'),
('elsa@example.com', 'Elsa', 'Ramirez', 72000, '123-555-7809', 'Japan');

-- Populate `patients` table
INSERT INTO patients (email) VALUES
('alice@example.com'), 
('bob@example.com'), 
('carol@example.com'), ('dave@example.com'),
('eve@example.com'), ('frank@example.com'), ('grace@example.com'), ('henry@example.com'),
('irene@example.com'), ('jack@example.com'), ('lucy@example.com'), ('mark@example.com'),
('nina@example.com'), ('oliver@example.com'), ('paul@example.com'), ('quinn@example.com'),
('rachel@example.com'), ('sam@example.com'), ('tina@example.com'), ('uma@example.com');

-- Populate `public_servant` table
INSERT INTO public_servant (email, department) VALUES
('alice@example.com', 'Health'), ('bob@example.com', 'Public Safety'), 
('carol@example.com', 'Environmental Protection'), ('dave@example.com', 'Education'), 
('eve@example.com', 'Transportation'), ('frank@example.com', 'Housing'), 
('grace@example.com', 'Urban Development'), ('henry@example.com', 'Energy'), 
('irene@example.com', 'Labor'), ('jack@example.com', 'Commerce'), 
('lucy@example.com', 'Health'), ('mark@example.com', 'Public Safety'), 
('nina@example.com', 'Education'), ('oliver@example.com', 'Transportation'), 
('paul@example.com', 'Housing'), ('quinn@example.com', 'Energy'), 
('rachel@example.com', 'Urban Development'), ('sam@example.com', 'Labor'), 
('tina@example.com', 'Commerce'), ('uma@example.com', 'Health');

-- Populate `doctor` table
INSERT INTO doctor (email, degree) VALUES
('alice@example.com', 'MD'), ('bob@example.com', 'DO'), ('carol@example.com', 'PhD'), 
('dave@example.com', 'MD'), ('eve@example.com', 'MD'), ('frank@example.com', 'PhD'), 
('grace@example.com', 'MD'), ('henry@example.com', 'DO'), ('irene@example.com', 'MD'), 
('jack@example.com', 'PhD');

-- Populate `disease_type` table
INSERT INTO disease_type (id, description) VALUES
(1, 'Bacterial'), (2, 'Viral'), (3, 'Parasitic'), (4, 'Fungal'), 
(5, 'Genetic'), (6, 'Nutritional'), (7, 'Environmental'), 
(8, 'Chronic'), (9, 'Infectious'), (10, 'Degenerative');

-- Populate `disease` table
INSERT INTO disease (disease_code, pathogen, description, id) VALUES
('D001', 'Bacteria', 'Tuberculosis', 1), ('D002', 'Virus', 'Influenza', 2), 
('D003', 'Parasite', 'Malaria', 3), ('D004', 'Fungus', 'Candidiasis', 4), 
('D005', 'Genetic', 'Cystic Fibrosis', 5), ('D006', 'Nutrition', 'Scurvy', 6), 
('D007', 'Environmental', 'Asthma', 7), ('D008', 'Chronic', 'Diabetes', 8), 
('D009', 'Virus', 'COVID-19', 2), ('D010', 'Degenerative', 'Alzheimer’s Disease', 10);

-- Populate `discover` table
INSERT INTO discover (cname, disease_code, first_enc_date) VALUES
('USA', 'D001', '1900-01-01'), ('Canada', 'D002', '1920-01-01'), 
('Mexico', 'D003', '1950-01-01'), ('France', 'D004', '1975-01-01'), 
('Germany', 'D005', '1980-01-01'), ('UK', 'D006', '1753-01-01'), 
('Italy', 'D007', '2000-01-01'), ('Spain', 'D008', '1985-01-01'), 
('Australia', 'D009', '2019-01-01'), ('Japan', 'D010', '1990-01-01');

-- Populate `patient_disease` table
INSERT INTO patient_disease (email, disease_code) VALUES
('alice@example.com', 'D001'), ('bob@example.com', 'D002'), ('carol@example.com', 'D003'), 
('dave@example.com', 'D004'), ('eve@example.com', 'D005'), ('frank@example.com', 'D006'), 
('grace@example.com', 'D007'), ('henry@example.com', 'D008'), ('irene@example.com', 'D009'), 
('jack@example.com', 'D010');

-- Populate `specialize` table
INSERT INTO specialize (id, email) VALUES
(1, 'alice@example.com'), (2, 'bob@example.com'), (3, 'carol@example.com'), 
(4, 'dave@example.com'), (5, 'eve@example.com'), (6, 'frank@example.com'), 
(7, 'grace@example.com'), (8, 'henry@example.com'), (9, 'irene@example.com'), 
(10, 'jack@example.com');

-- Populate `record` table
INSERT INTO record (email, cname, disease_code, total_deaths, total_patients) VALUES
('alice@example.com', 'USA', 'D001', 200, 1000), ('bob@example.com', 'Canada', 'D002', 150, 1200), 
('carol@example.com', 'Mexico', 'D003', 100, 900), ('dave@example.com', 'France', 'D004', 80, 300), 
('eve@example.com', 'Germany', 'D005', 60, 400), ('frank@example.com', 'UK', 'D006', 50, 500), 
('grace@example.com', 'Italy', 'D007', 40, 600), ('henry@example.com', 'Spain', 'D008', 30, 700), 
('irene@example.com', 'Australia', 'D009', 1000, 10000), ('jack@example.com', 'Japan', 'D010', 120, 800);



-- Update the `discover` table for diseases caused by "bacteria" discovered before 2020
INSERT INTO discover (cname, disease_code, first_enc_date) VALUES
('Japan', 'D001', '1990-01-01'), -- Tuberculosis (bacteria)
('Germany', 'D001', '2000-01-01');

-- Add specializations to doctors excluding "infectious diseases"
INSERT INTO specialize (id, email) VALUES
(4, 'frank@example.com'), -- Fungal Diseases
(5, 'grace@example.com'); -- Genetic Diseases


-- Add doctors specialized in multiple disease types
INSERT INTO specialize (id, email) VALUES
(6, 'alice@example.com'), -- Additional specialization for Alice
(7, 'alice@example.com'), -- Environmental
(2, 'frank@example.com');-- Viral (for Virology query)

-- Populate the `record` table for "covid-19" (D009) cases reported in multiple countries
INSERT INTO record (email, cname, disease_code, total_deaths, total_patients) VALUES
('bob@example.com', 'Canada', 'D009', 100, 2000),
('frank@example.com', 'Australia', 'D009', 50, 1500),
('henry@example.com', 'Spain', 'D009', 25, 800),
('frank@example.com', 'France', 'D009', 75, 900),
('carol@example.com', 'Mexico', 'D009', 120, 1000);



-- Additional entry for total patients across countries
INSERT INTO record (email, cname, disease_code, total_deaths, total_patients) VALUES
('jack@example.com', 'Japan', 'D008', 10, 3000); -- Chronic Disease
