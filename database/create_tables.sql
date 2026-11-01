CREATE TABLE country (
    cname VARCHAR(60) PRIMARY KEY,
    population BIGINT
);

CREATE TABLE users (
    email VARCHAR(60) PRIMARY KEY,
    name VARCHAR(30),
    surname VARCHAR(40),
    salary INTEGER,
    phone VARCHAR(20),
    cname VARCHAR(50),
    FOREIGN KEY (cname) REFERENCES country(cname) ON DELETE RESTRICT
);

CREATE TABLE patients (
    email VARCHAR(60) PRIMARY KEY REFERENCES users(email)
);

CREATE TABLE disease_type (
    id INTEGER PRIMARY KEY,
    description VARCHAR(140)
);

CREATE TABLE disease (
    disease_code VARCHAR(50) PRIMARY KEY,
    pathogen VARCHAR(20),
    description VARCHAR(140),
    id INTEGER REFERENCES disease_type(id)
);

CREATE TABLE discover (
    cname VARCHAR(50),
    disease_code VARCHAR(50), 
    first_enc_date DATE,
    FOREIGN KEY (cname) REFERENCES country(cname),
    FOREIGN KEY (disease_code) REFERENCES disease(disease_code),
    PRIMARY KEY (cname, disease_code)

);

CREATE TABLE patient_disease (
    email VARCHAR(60),
    disease_code VARCHAR(50),
    FOREIGN KEY (email) REFERENCES users(email),
    FOREIGN KEY (disease_code) REFERENCES disease(disease_code),
    PRIMARY KEY (email, disease_code)
);

CREATE TABLE public_servant (
    email VARCHAR(60) PRIMARY KEY REFERENCES users(email),
    department VARCHAR(50)
);

CREATE TABLE doctor (
    email VARCHAR(60) PRIMARY KEY REFERENCES users(email),
    degree VARCHAR(20)
);

CREATE TABLE specialize (
    id INTEGER REFERENCES disease_type(id),
    email VARCHAR(60) REFERENCES doctor(email),
    PRIMARY KEY (id, email)
);
CREATE TABLE record(
	email VARCHAR(60) REFERENCES public_servant(email), 
	cname VARCHAR(50) REFERENCES country(cname), 
	disease_code VARCHAR(50) REFERENCES disease(disease_code), 
	total_deaths INTEGER,
	total_patients INTEGER,
	PRIMARY KEY (email, cname, disease_code)
);

