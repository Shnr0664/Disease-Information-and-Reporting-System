# Disease-Information-and-Reporting-System

# Healthcare Resource Allocation & Disease Burden Analysis

A healthcare data analysis project developed using PostgreSQL, SQL, Python, and Power BI as an extension of the **Disease Information and Reporting System** created for CSCI 341: Database Systems at Nazarbayev University.

The project transforms relational healthcare data into analytical insights to explore reported disease burden, geographic differences, and the distribution of registered medical specialists across countries.

## 1. Business Problem

### Project Scenario

A hypothetical public health organization monitors disease cases, mortality, and healthcare workforce distribution across multiple countries.

However, relevant information is stored across several relational database tables, making it difficult to identify countries with the highest reported disease burden, compare disease categories, and assess the distribution of medical specialists.

**Business question:**

How can a public health organization use disease reporting data to identify high-priority areas for further investigation and support evidence-informed healthcare resource planning?

**My role:** Data Analyst

The objective was to develop an analytical reporting solution that transforms relational healthcare data into meaningful KPIs, identifies patterns in disease reporting, and presents findings through an interactive Power BI dashboard.

_This is a hypothetical educational scenario. The database contains synthetic data and does not represent a real public health organization or actual epidemiological statistics._

## 2. Project Objectives

- Design and work with a relational healthcare database.
- Validate data quality and investigate potentially duplicated reports.
- Use SQL to extract, aggregate, and analyze healthcare information.
- Calculate key performance indicators (KPIs).
- Explore disease burden and registered healthcare workforce distribution.
- Identify countries and disease categories that may warrant further investigation.
- Communicate analytical findings through an interactive Power BI dashboard.

## 3. Database Design

The project uses a PostgreSQL relational database consisting of 11 interconnected tables.

| Table            | Description                                              |
| ---------------- | -------------------------------------------------------- |
| `Country`        | Country names and population information                 |
| `Users`          | General user information                                 |
| `Patients`       | Users registered as patients                             |
| `DiseaseType`    | Disease categories                                       |
| `Disease`        | Disease information, including pathogen and description  |
| `Discover`       | Countries and dates associated with disease discovery    |
| `PatientDisease` | Relationships between patients and diseases              |
| `PublicServant`  | Public servant information and departments               |
| `Doctor`         | Registered doctors and their degrees                     |
| `Specialize`     | Doctors' disease-type specializations                    |
| `Record`         | Reported patient and death counts by country and disease |

Primary keys and foreign keys establish relationships between the tables and maintain referential integrity.

## 4. Data Analysis

The analysis is organized into four main business areas.

### A. Disease Burden Analysis

Explores the distribution of reported patients and deaths across countries and disease categories.

Key questions:

- How many patients and deaths are reported across all countries?
- Which five countries have the highest reported patient counts?
- Which diseases account for the largest share of reported patients?
- What is the reported case fatality ratio for each disease?
- How do reported patient counts compare relative to country population?

### B. Healthcare Workforce Analysis

Examines the distribution of registered doctors and medical specializations.

Key questions:

- How many doctors are registered in each country?
- Which disease types have the most and fewest registered specialists?
- Which countries have the lowest number of registered doctors per 100,000 residents?
- Is there an association between registered doctor counts and reported patient burden?

### C. Reporting & Geographic Analysis

Explores geographical differences in disease reporting.

Key questions:

- Which countries report the greatest variety of diseases?
- How do reported deaths compare across countries?
- Which country-disease combinations have the highest reported deaths per 100,000 residents?
- Which diseases have been recorded as first encountered in the greatest number of countries?

### D. Decision Support

Combines disease burden and workforce indicators to identify areas for further investigation.

Key questions:

- Which countries combine high reported disease burden with relatively low registered doctor availability?
- Which disease categories may warrant additional specialist-capacity review?
- What recommendations can be made based on the analytical findings and data limitations?

## 5. Key Performance Indicators

The project calculates six main dashboard KPIs.

| KPI                          | Calculation                    |
| ---------------------------- | ------------------------------ |
| Total Reported Patients      | `SUM(total_patients)`          |
| Total Reported Deaths        | `SUM(total_deaths)`            |
| Reported Case Fatality Ratio | `Deaths / Patients × 100`      |
| Countries Covered            | `COUNT(DISTINCT cname)`        |
| Diseases Tracked             | `COUNT(DISTINCT disease_code)` |
| Registered Doctors           | `COUNT(*)` from `Doctor`       |

Additional population-adjusted indicators include:

- Reported patients per 100,000 residents.
- Reported deaths per 100,000 residents.
- Registered doctors per 100,000 residents.

## 6. Data Validation

Before performing the analysis, data validation queries were used to investigate the quality and consistency of the database.

Validation checks include:

- Repeated country-disease reporting combinations.
- Differences in patient and death totals between reports.
- Negative patient or death counts.
- Death counts exceeding reported patient counts.
- Missing values in important fields.
- Missing or non-positive country population values.

Multiple reports for the same country and disease were examined rather than automatically removed.

For this synthetic dataset, the reports are treated as separate additive records according to the intended sample-data construction. Consequently, `SUM()` is used for reported patient and death totals.

## 7. Tools & Technologies

| Technology   | Purpose                                                |
| ------------ | ------------------------------------------------------ |
| PostgreSQL   | Relational database management                         |
| SQL          | Data validation, extraction, aggregation, and analysis |
| Python 3     | Database connectivity and query execution              |
| SQLAlchemy   | Connecting Python to PostgreSQL                        |
| Pandas       | Data exploration and analysis                          |
| Power BI     | Interactive dashboards and data visualization          |
| Git & GitHub | Version control and project documentation              |

## 8. Power BI Dashboard

The Power BI dashboard presents the results of the SQL analysis in an interactive reporting environment.

The dashboard is organized around the project's main analytical areas:

**Disease Burden Overview**

- Total reported patients and deaths.
- Reported case fatality ratio.
- Top countries by reported patients.
- Disease distribution and patient share.
- Population-adjusted reported patient counts.

**Healthcare Workforce**

- Registered doctors by country.
- Registered specialists by disease type.
- Doctors per 100,000 residents.
- Comparison of doctor availability and reported patient burden.

**Decision Support**

- Countries with relatively high reported disease burden and low registered doctor availability.
- Disease categories with potentially limited specialist representation.
- Analytical findings and recommendations for further investigation.

The dashboard is intended to support exploration and comparison of the synthetic dataset, rather than provide real-world healthcare policy recommendations.

## 9. Repository Structure

```text
Disease-Reporting-System/
│
├── database/
│   ├── health_reporting_1.sql
│   ├── create_tables.sql
│   ├── populate.sql
│   ├── queries.sql
│   └── healthcare_disease_analysis_queries.sql
│
├── src/
│   └── database_connect.py
│
├── reports/
│   └── Executive Summary.docx
│
├── README.md
├── requirements.txt
├── .env.example
└── .gitignore
```

### File descriptions

| File                                      | Purpose                                                       |
| ----------------------------------------- | ------------------------------------------------------------- |
| `create_tables.sql`                       | Creates the relational database tables and constraints        |
| `populate.sql`                            | Inserts synthetic sample data into the database               |
| `health_reporting_1.sql`                  | Database SQL export                                           |
| `queries.sql`                             | SQL queries developed for the original database assignment    |
| `healthcare_disease_analysis_queries.sql` | Data validation, business analysis, and dashboard KPI queries |
| `database_connect.py`                     | Python script for connecting to PostgreSQL using SQLAlchemy   |
| `Executive Summary.docx`                  | Summary of the project, implementation, and results           |
| `requirements.txt`                        | Python dependencies                                           |
| `.env.example`                            | Example environment variable configuration                    |

## 10. Getting Started

### Prerequisites

- PostgreSQL
- Python 3
- pip

### Step 1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/Disease-Reporting-System.git
cd Disease-Reporting-System
```

### Step 2. Create the PostgreSQL database

```sql
CREATE DATABASE disease_reporting;
```

### Step 3. Create the database schema

Connect to the newly created database and execute:

```bash
psql -U postgres -d disease_reporting -f database/create_tables.sql
```

### Step 4. Populate the database

```bash
psql -U postgres -d disease_reporting -f database/populate.sql
```

**Note:** `health_reporting_1.sql` is a database export. It may contain schema and data definitions, so use it as an alternative restoration source rather than executing it after the separate table-creation and population scripts.

### Step 5. Install Python dependencies

```bash
pip install -r requirements.txt
```

### Step 6. Configure database credentials

Create a `.env` file in the project root based on `.env.example`.

Example:

```env
DB_USER=postgres
DB_PASSWORD=your_password
DB_HOST=localhost
DB_PORT=5432
DB_NAME=disease_reporting
```

Do not commit your actual `.env` file or expose database credentials publicly.

### Step 7. Run the Python script

```bash
python src/database_connect.py
```

### Step 8. Execute SQL analysis

Open PostgreSQL through pgAdmin or another SQL client and execute:

```text
database/healthcare_disease_analysis_queries.sql
```

The file contains commented explanations for the validation checks, analytical queries, and KPI calculations.

### Step 9. Explore the Power BI dashboard

Connect Power BI to the PostgreSQL database, load the required analytical datasets, and explore the dashboard pages and visualizations.

## 11. Key Findings and Recommendations

The analysis is intended to help identify:

- Countries with relatively high reported disease burden.
- Differences in disease distribution across countries.
- Differences in registered doctor and specialist availability.
- Country-disease combinations that may require further investigation.
- Potential gaps between reported disease burden and registered specialist availability.

Recommendations should be based on the actual query results and interpreted within the limitations of the dataset.

## 12. Limitations

Several limitations should be considered when interpreting the results:

1. **Synthetic data:** The database was populated with sample data for educational purposes. Findings do not represent actual epidemiological conditions.
2. **Reporting assumptions:** Multiple employees can report the same country-disease combination. The analysis treats the inserted reports as additive, based on the intended construction of the sample dataset.
3. **Workforce coverage:** The `Doctor` and `Specialize` tables represent registered doctors and their recorded specializations in the database, not necessarily the entire healthcare workforce.
4. **Limited temporal information:** The database does not contain a complete time series of patient and death counts, so reliable disease trends over time cannot be established.
5. **No causal inference:** Associations between reported disease burden and doctor availability do not demonstrate causal relationships.

## 13. Learning Outcomes

Through this project, I gained practical experience in:

- Relational database design and implementation.
- PostgreSQL database management.
- Writing SQL queries using joins, subqueries, CTEs, aggregation, and window functions.
- Data validation and quality assessment.
- Healthcare-related KPI development.
- Connecting Python applications to PostgreSQL using SQLAlchemy.
- Preparing analytical datasets for business intelligence reporting.
- Communicating analytical results through Power BI dashboards.

---

## Author

**Shynarai Sagidullayeva**  
Computer Science Graduate, Nazarbayev University

**Course:** CSCI 341 – Database Systems

**Project:** Disease Information and Reporting System / Healthcare Resource Allocation & Disease Burden Analysis

---

_This project is an academic portfolio project and uses synthetic data for demonstration purposes._
