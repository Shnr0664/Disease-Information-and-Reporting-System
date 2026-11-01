


/* ============================================================================
   0. DATA VALIDATION
   Run these checks before interpreting dashboard KPIs.
   ============================================================================ */


/* 0.1. Row counts for all 11 tables.
   Purpose: confirm that the expected sample data has been loaded. */
SELECT 'country' AS table_name, COUNT(*) AS row_count FROM country
UNION ALL
SELECT 'users', COUNT(*) FROM users
UNION ALL
SELECT 'patients', COUNT(*) FROM patients
UNION ALL
SELECT 'disease_type', COUNT(*) FROM disease_type
UNION ALL
SELECT 'disease', COUNT(*) FROM disease
UNION ALL
SELECT 'discover', COUNT(*) FROM discover
UNION ALL
SELECT 'patient_disease', COUNT(*) FROM patient_disease
UNION ALL
SELECT 'public_servant', COUNT(*) FROM public_servant
UNION ALL
SELECT 'doctor', COUNT(*) FROM doctor
UNION ALL
SELECT 'specialize', COUNT(*) FROM specialize
UNION ALL
SELECT 'record', COUNT(*) FROM record
ORDER BY table_name;


/* 0.2. Check for repeated country-disease combinations.
   Purpose: identify combinations reported by more than one employee.
   A repeated combination is not automatically an error: inspect the
   reporting logic and the values before deciding how to aggregate it. */
SELECT
    cname,
    disease_code,
    COUNT(*) AS report_count,
    COUNT(DISTINCT email) AS reporting_employees,
    COUNT(DISTINCT total_patients) AS different_patient_totals,
    COUNT(DISTINCT total_deaths) AS different_death_totals,
    SUM(total_patients) AS sum_patients,
    MAX(total_patients) AS max_patients,
    SUM(total_deaths) AS sum_deaths,
    MAX(total_deaths) AS max_deaths
FROM record
GROUP BY cname, disease_code
HAVING COUNT(*) > 1
ORDER BY report_count DESC, cname, disease_code;


/* 0.3. Inspect the two Australia / COVID-19 reports from populate.sql.
   Purpose: verify which employees submitted the reports and their values.
   Expected from the supplied sample data:
   Irene: 10,000 patients / 1,000 deaths
   Frank:  1,500 patients /    50 deaths */
SELECT
    r.email,
    u.name,
    u.surname,
    r.cname,
    r.disease_code,
    d.description AS disease,
    r.total_patients,
    r.total_deaths
FROM record AS r
JOIN users AS u
    ON u.email = r.email
JOIN disease AS d
    ON d.disease_code = r.disease_code
WHERE r.cname = 'Australia'
  AND r.disease_code = 'D009'
ORDER BY r.total_patients DESC;


/* 0.4. Check impossible or suspicious patient/death values.
   Purpose: deaths should not be negative or exceed reported patients;
   patient counts should not be negative. */
SELECT *
FROM record
WHERE total_patients < 0
   OR total_deaths < 0
   OR total_deaths > total_patients;


/* 0.5. Check required fields for NULL values in Record.
   Purpose: find records that cannot be fully grouped or analyzed.
   Note: primary-key and NOT NULL constraints may already prevent some
   of these cases, but this query documents the validation check. */
SELECT *
FROM record
WHERE email IS NULL
   OR cname IS NULL
   OR disease_code IS NULL
   OR total_patients IS NULL
   OR total_deaths IS NULL;


/* 0.6. Check whether any country has a missing or non-positive population.
   Purpose: population-adjusted indicators require a valid positive population. */
SELECT *
FROM country
WHERE population IS NULL
   OR population <= 0;


/* ============================================================================
   A. DISEASE BURDEN ANALYSIS
   ============================================================================ */


/* A1. Overall reported patients, deaths, and case fatality ratio.
   Formula: reported deaths / reported patients * 100.
   Interpretation: this is a ratio calculated from the synthetic reports,
   not a clinically verified mortality rate. */
SELECT
    SUM(total_patients) AS total_reported_patients,
    SUM(total_deaths) AS total_reported_deaths,
    ROUND(
        100.0 * SUM(total_deaths)
        / NULLIF(SUM(total_patients), 0),
        2
    ) AS reported_case_fatality_pct
FROM record;


/* A2. Top five countries by reported patients.
   Purpose: identify countries with the largest reported patient totals. */
SELECT
    c.cname AS country,
    SUM(r.total_patients) AS total_patients,
    SUM(r.total_deaths) AS total_deaths
FROM country AS c
JOIN record AS r
    ON r.cname = c.cname
GROUP BY c.cname
ORDER BY total_patients DESC
LIMIT 5;


/* A3. Disease contribution to all reported patients.
   Purpose: calculate each disease's percentage share of the total.
   The denominator uses all Record rows under the additive-report assumption. */
SELECT
    d.disease_code,
    d.description AS disease,
    SUM(r.total_patients) AS total_patients,
    ROUND(
        100.0 * SUM(r.total_patients)
        / NULLIF((SELECT SUM(total_patients) FROM record), 0),
        2
    ) AS patient_share_pct
FROM disease AS d
JOIN record AS r
    ON r.disease_code = d.disease_code
GROUP BY d.disease_code, d.description
ORDER BY total_patients DESC;


/* A4. Reported case fatality ratio by disease.
   Purpose: compare reported deaths with reported patients for each disease. */
SELECT
    d.disease_code,
    d.description AS disease,
    SUM(r.total_patients) AS total_patients,
    SUM(r.total_deaths) AS total_deaths,
    ROUND(
        100.0 * SUM(r.total_deaths)
        / NULLIF(SUM(r.total_patients), 0),
        2
    ) AS case_fatality_ratio_pct
FROM disease AS d
JOIN record AS r
    ON r.disease_code = d.disease_code
GROUP BY d.disease_code, d.description
ORDER BY case_fatality_ratio_pct DESC;


/* A5. Reported patients per 100,000 residents by country.
   Formula: reported patients / country population * 100,000.
   Purpose: compare reported patient counts while accounting for population. */
SELECT
    c.cname AS country,
    c.population,
    SUM(r.total_patients) AS total_patients,
    ROUND(
        100000.0 * SUM(r.total_patients)
        / NULLIF(c.population, 0),
        2
    ) AS patients_per_100k
FROM country AS c
JOIN record AS r
    ON r.cname = c.cname
GROUP BY c.cname, c.population
ORDER BY patients_per_100k DESC;


/* ============================================================================
   B. HEALTHCARE WORKFORCE ANALYSIS
   ============================================================================ */


/* B1. Number of registered doctors in each country.
   DISTINCT prevents a doctor from being counted more than once if that
   doctor has multiple rows in another related table. */
SELECT
    c.cname AS country,
    COUNT(DISTINCT doc.email) AS registered_doctors
FROM country AS c
LEFT JOIN users AS u
    ON u.cname = c.cname
LEFT JOIN doctor AS doc
    ON doc.email = u.email
GROUP BY c.cname
ORDER BY registered_doctors DESC, c.cname;


/* B2. Number of registered specialists by disease type.
   LEFT JOIN keeps disease types that currently have no registered specialists.
   Specialize.id references DiseaseType.id. */
SELECT
    dt.id AS disease_type_id,
    dt.description AS disease_type,
    COUNT(DISTINCT s.email) AS registered_specialists
FROM disease_type AS dt
LEFT JOIN specialize AS s
    ON s.id = dt.id
GROUP BY dt.id, dt.description
ORDER BY registered_specialists DESC, dt.description;


/* B3. Registered doctors per 100,000 residents by country.
   LEFT JOIN keeps countries with zero registered doctors in the result. */
SELECT
    c.cname AS country,
    c.population,
    COUNT(DISTINCT doc.email) AS registered_doctors,
    ROUND(
        100000.0 * COUNT(DISTINCT doc.email)
        / NULLIF(c.population, 0),
        2
    ) AS doctors_per_100k
FROM country AS c
LEFT JOIN users AS u
    ON u.cname = c.cname
LEFT JOIN doctor AS doc
    ON doc.email = u.email
GROUP BY c.cname, c.population
ORDER BY doctors_per_100k ASC, c.cname;


/* B4. Compare reported patient burden with registered doctor counts.
   Purpose: produce one row per country for a scatter plot or further
   correlation analysis in Python / Power BI.
   This query shows association only; it does not establish causation. */
WITH country_patients AS (
    SELECT
        cname,
        SUM(total_patients) AS total_patients
    FROM record
    GROUP BY cname
),
country_doctors AS (
    SELECT
        u.cname,
        COUNT(DISTINCT doc.email) AS registered_doctors
    FROM users AS u
    JOIN doctor AS doc
        ON doc.email = u.email
    GROUP BY u.cname
)
SELECT
    c.cname AS country,
    COALESCE(cp.total_patients, 0) AS total_patients,
    COALESCE(cd.registered_doctors, 0) AS registered_doctors
FROM country AS c
LEFT JOIN country_patients AS cp
    ON cp.cname = c.cname
LEFT JOIN country_doctors AS cd
    ON cd.cname = c.cname
ORDER BY total_patients DESC;


/* ============================================================================
   C. REPORTING AND GEOGRAPHIC ANALYSIS
   ============================================================================ */


/* C1. Number of distinct diseases reported in each country.
   Purpose: compare the variety of diseases represented in the reports. */
SELECT
    c.cname AS country,
    COUNT(DISTINCT r.disease_code) AS disease_variety
FROM country AS c
LEFT JOIN record AS r
    ON r.cname = c.cname
GROUP BY c.cname
ORDER BY disease_variety DESC, c.cname;


/* C2. Reported deaths and case fatality ratio by country. */
SELECT
    c.cname AS country,
    SUM(r.total_deaths) AS total_deaths,
    SUM(r.total_patients) AS total_patients,
    ROUND(
        100.0 * SUM(r.total_deaths)
        / NULLIF(SUM(r.total_patients), 0),
        2
    ) AS case_fatality_ratio_pct
FROM country AS c
JOIN record AS r
    ON r.cname = c.cname
GROUP BY c.cname
ORDER BY total_deaths DESC;


/* C3. Reported deaths per 100,000 residents for each country-disease pair.
   This is a population-adjusted reported count, not a time-based mortality rate. */
SELECT
    c.cname AS country,
    d.disease_code,
    d.description AS disease,
    c.population,
    SUM(r.total_deaths) AS total_deaths,
    ROUND(
        100000.0 * SUM(r.total_deaths)
        / NULLIF(c.population, 0),
        2
    ) AS deaths_per_100k
FROM record AS r
JOIN country AS c
    ON c.cname = r.cname
JOIN disease AS d
    ON d.disease_code = r.disease_code
GROUP BY
    c.cname,
    d.disease_code,
    d.description,
    c.population
ORDER BY deaths_per_100k DESC;


/* C4. Diseases discovered in the greatest number of countries.
   Uses Discover records, not Record reports.
   COUNT(DISTINCT) avoids counting the same country more than once per disease. */
SELECT
    d.disease_code,
    d.description AS disease,
    COUNT(DISTINCT dis.cname) AS countries_discovered,
    MIN(dis.first_enc_date) AS earliest_discovery_date
FROM disease AS d
JOIN discover AS dis
    ON dis.disease_code = d.disease_code
GROUP BY d.disease_code, d.description
ORDER BY countries_discovered DESC, d.description;


/* ============================================================================
   D. DECISION SUPPORT
   ============================================================================ */


/* D1. Countries with relatively high reported patient burden and low doctor
   availability.

   The two ranks are relative to countries in this dataset:
   - disease_burden_rank = 1 means the highest patients per 100,000;
   - doctor_availability_rank = 1 means the lowest doctors per 100,000.

   Countries with low rank numbers in both columns may be prioritized for
   further investigation. These ranks are not official healthcare thresholds. */
WITH country_patients AS (
    SELECT
        cname,
        SUM(total_patients) AS total_patients
    FROM record
    GROUP BY cname
),
country_doctors AS (
    SELECT
        u.cname,
        COUNT(DISTINCT doc.email) AS registered_doctors
    FROM users AS u
    JOIN doctor AS doc
        ON doc.email = u.email
    GROUP BY u.cname
),
country_metrics AS (
    SELECT
        c.cname AS country,
        c.population,
        COALESCE(cp.total_patients, 0) AS total_patients,
        COALESCE(cd.registered_doctors, 0) AS registered_doctors,
        ROUND(
            100000.0 * COALESCE(cp.total_patients, 0)
            / NULLIF(c.population, 0),
            2
        ) AS patients_per_100k,
        ROUND(
            100000.0 * COALESCE(cd.registered_doctors, 0)
            / NULLIF(c.population, 0),
            2
        ) AS doctors_per_100k
    FROM country AS c
    LEFT JOIN country_patients AS cp
        ON cp.cname = c.cname
    LEFT JOIN country_doctors AS cd
        ON cd.cname = c.cname
)
SELECT
    *,
    RANK() OVER (ORDER BY patients_per_100k DESC) AS disease_burden_rank,
    RANK() OVER (ORDER BY doctors_per_100k ASC) AS doctor_availability_rank
FROM country_metrics
ORDER BY disease_burden_rank, doctor_availability_rank;


/* D2. Compare disease burden with registered specialist counts by disease type.
   Disease.id and Specialize.id both reference DiseaseType.id.
   A high patient count and low specialist count can flag a category for review,
   but does not prove that the category is understaffed. */
WITH disease_patients AS (
    SELECT
        d.id AS disease_type_id,
        SUM(r.total_patients) AS total_patients,
        SUM(r.total_deaths) AS total_deaths
    FROM disease AS d
    JOIN record AS r
        ON r.disease_code = d.disease_code
    GROUP BY d.id
),
specialist_counts AS (
    SELECT
        id AS disease_type_id,
        COUNT(DISTINCT email) AS registered_specialists
    FROM specialize
    GROUP BY id
)
SELECT
    dt.id AS disease_type_id,
    dt.description AS disease_type,
    COALESCE(dp.total_patients, 0) AS total_patients,
    COALESCE(dp.total_deaths, 0) AS total_deaths,
    COALESCE(sc.registered_specialists, 0) AS registered_specialists
FROM disease_type AS dt
LEFT JOIN disease_patients AS dp
    ON dp.disease_type_id = dt.id
LEFT JOIN specialist_counts AS sc
    ON sc.disease_type_id = dt.id
ORDER BY total_patients DESC, registered_specialists ASC;


/* ============================================================================
   E. DASHBOARD KPI QUERIES
   These are separate queries so each result can be used in a Power BI card.
   ============================================================================ */


/* E1. KPI: Total Reported Patients */
SELECT
    SUM(total_patients) AS total_reported_patients
FROM record;


/* E2. KPI: Total Reported Deaths */
SELECT
    SUM(total_deaths) AS total_reported_deaths
FROM record;


/* E3. KPI: Reported Case Fatality Ratio (%) */
SELECT
    ROUND(
        100.0 * SUM(total_deaths)
        / NULLIF(SUM(total_patients), 0),
        2
    ) AS reported_case_fatality_pct
FROM record;


/* E4. KPI: Countries Covered by Reports */
SELECT
    COUNT(DISTINCT cname) AS countries_covered
FROM record;


/* E5. KPI: Diseases Tracked in Reports */
SELECT
    COUNT(DISTINCT disease_code) AS diseases_tracked
FROM record;


/* E6. KPI: Registered Doctors */
SELECT
    COUNT(*) AS registered_doctors
FROM doctor;


/* ============================================================================
   F. OPTIONAL: ONE-ROW KPI SUMMARY
   Convenience query: returns all six dashboard KPIs in a single result row.
   ============================================================================ */
SELECT
    (SELECT SUM(total_patients) FROM record)
        AS total_reported_patients,
    (SELECT SUM(total_deaths) FROM record)
        AS total_reported_deaths,
    (
        SELECT ROUND(
            100.0 * SUM(total_deaths)
            / NULLIF(SUM(total_patients), 0),
            2
        )
        FROM record
    ) AS reported_case_fatality_pct,
    (SELECT COUNT(DISTINCT cname) FROM record)
        AS countries_covered,
    (SELECT COUNT(DISTINCT disease_code) FROM record)
        AS diseases_tracked,
    (SELECT COUNT(*) FROM doctor)
        AS registered_doctors;


/* ============================================================================
   END OF ANALYSIS QUERIES

   Interpretation reminders:
   1. SUM() assumes each Record row is an additive report.
   2. The dataset is synthetic and should not be presented as real health data.
   3. Registered doctors/specialists are only those represented in these tables.
   4. No time-series trend analysis is supported by the current schema.
   5. Do not make causal claims from country-level comparisons.
   ============================================================================ */
