--
-- PostgreSQL database dump
--

-- Dumped from database version 14.13 (Ubuntu 14.13-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.13 (Ubuntu 14.13-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: country; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.country (
    cname character varying(60) NOT NULL,
    population bigint
);


ALTER TABLE public.country OWNER TO postgres;

--
-- Name: discover; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.discover (
    cname character varying(50) NOT NULL,
    disease_code character varying(50) NOT NULL,
    first_enc_date date
);


ALTER TABLE public.discover OWNER TO postgres;

--
-- Name: disease; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.disease (
    disease_code character varying(50) NOT NULL,
    pathogen character varying(20),
    description character varying(140),
    id integer
);


ALTER TABLE public.disease OWNER TO postgres;

--
-- Name: disease_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.disease_type (
    id integer NOT NULL,
    description character varying(140)
);


ALTER TABLE public.disease_type OWNER TO postgres;

--
-- Name: doctor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doctor (
    email character varying(60) NOT NULL,
    degree character varying(20)
);


ALTER TABLE public.doctor OWNER TO postgres;

--
-- Name: patient_disease; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patient_disease (
    email character varying(60) NOT NULL,
    disease_code character varying(50) NOT NULL
);


ALTER TABLE public.patient_disease OWNER TO postgres;

--
-- Name: patients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patients (
    email character varying(60) NOT NULL
);


ALTER TABLE public.patients OWNER TO postgres;

--
-- Name: public_servant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.public_servant (
    email character varying(60) NOT NULL,
    department character varying(50)
);


ALTER TABLE public.public_servant OWNER TO postgres;

--
-- Name: record; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.record (
    email character varying(60) NOT NULL,
    cname character varying(50) NOT NULL,
    disease_code character varying(50) NOT NULL,
    total_deaths integer,
    total_patients integer
);


ALTER TABLE public.record OWNER TO postgres;

--
-- Name: specialize; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.specialize (
    id integer NOT NULL,
    email character varying(60) NOT NULL
);


ALTER TABLE public.specialize OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    email character varying(60) NOT NULL,
    name character varying(30),
    surname character varying(40),
    salary integer,
    phone character varying(20),
    cname character varying(50)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.country (cname, population) FROM stdin;
USA	331000000
Canada	38000000
Mexico	126000000
France	67000000
Germany	83000000
UK	66000000
Italy	60000000
Spain	47000000
Australia	25000000
Japan	125000000
\.


--
-- Data for Name: discover; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.discover (cname, disease_code, first_enc_date) FROM stdin;
USA	D001	1900-01-01
Canada	D002	1920-01-01
Mexico	D003	1950-01-01
France	D004	1975-01-01
Germany	D005	1980-01-01
UK	D006	1753-01-01
Italy	D007	2000-01-01
Spain	D008	1985-01-01
Australia	D009	2019-01-01
Japan	D010	1990-01-01
Japan	D001	1990-01-01
Germany	D001	2000-01-01
\.


--
-- Data for Name: disease; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.disease (disease_code, pathogen, description, id) FROM stdin;
D001	Bacteria	Tuberculosis	1
D002	Virus	Influenza	2
D003	Parasite	Malaria	3
D004	Fungus	Candidiasis	4
D005	Genetic	Cystic Fibrosis	5
D006	Nutrition	Scurvy	6
D007	Environmental	Asthma	7
D008	Chronic	Diabetes	8
D009	Virus	COVID-19	2
D010	Degenerative	Alzheimer’s Disease	10
\.


--
-- Data for Name: disease_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.disease_type (id, description) FROM stdin;
1	Bacterial
2	Viral
3	Parasitic
4	Fungal
5	Genetic
6	Nutritional
7	Environmental
8	Chronic
9	Infectious
10	Degenerative
\.


--
-- Data for Name: doctor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.doctor (email, degree) FROM stdin;
alice@example.com	MD
bob@example.com	DO
carol@example.com	PhD
dave@example.com	MD
eve@example.com	MD
frank@example.com	PhD
grace@example.com	MD
henry@example.com	DO
irene@example.com	MD
jack@example.com	PhD
\.


--
-- Data for Name: patient_disease; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patient_disease (email, disease_code) FROM stdin;
alice@example.com	D001
bob@example.com	D002
carol@example.com	D003
dave@example.com	D004
eve@example.com	D005
frank@example.com	D006
grace@example.com	D007
henry@example.com	D008
irene@example.com	D009
jack@example.com	D010
\.


--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patients (email) FROM stdin;
alice@example.com
bob@example.com
carol@example.com
dave@example.com
eve@example.com
frank@example.com
grace@example.com
henry@example.com
irene@example.com
jack@example.com
lucy@example.com
mark@example.com
nina@example.com
oliver@example.com
paul@example.com
quinn@example.com
rachel@example.com
sam@example.com
tina@example.com
uma@example.com
\.


--
-- Data for Name: public_servant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.public_servant (email, department) FROM stdin;
alice@example.com	Health
bob@example.com	Public Safety
carol@example.com	Environmental Protection
dave@example.com	Education
eve@example.com	Transportation
frank@example.com	Housing
grace@example.com	Urban Development
henry@example.com	Energy
irene@example.com	Labor
jack@example.com	Commerce
lucy@example.com	Health
mark@example.com	Public Safety
nina@example.com	Education
oliver@example.com	Transportation
paul@example.com	Housing
quinn@example.com	Energy
rachel@example.com	Urban Development
sam@example.com	Labor
tina@example.com	Commerce
uma@example.com	Health
\.


--
-- Data for Name: record; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.record (email, cname, disease_code, total_deaths, total_patients) FROM stdin;
alice@example.com	USA	D001	200	1000
bob@example.com	Canada	D002	150	1200
carol@example.com	Mexico	D003	100	900
dave@example.com	France	D004	80	300
eve@example.com	Germany	D005	60	400
frank@example.com	UK	D006	50	500
grace@example.com	Italy	D007	40	600
henry@example.com	Spain	D008	30	700
irene@example.com	Australia	D009	1000	10000
jack@example.com	Japan	D010	120	800
bob@example.com	Canada	D009	100	2000
frank@example.com	Australia	D009	50	1500
henry@example.com	Spain	D009	25	800
frank@example.com	France	D009	75	900
carol@example.com	Mexico	D009	120	1000
jack@example.com	Japan	D008	10	3000
\.


--
-- Data for Name: specialize; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.specialize (id, email) FROM stdin;
1	alice@example.com
2	bob@example.com
3	carol@example.com
4	dave@example.com
5	eve@example.com
6	frank@example.com
7	grace@example.com
8	henry@example.com
9	irene@example.com
10	jack@example.com
4	frank@example.com
5	grace@example.com
6	alice@example.com
7	alice@example.com
2	frank@example.com
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (email, name, surname, salary, phone, cname) FROM stdin;
alice@example.com	Alice	Smith	70000	123-456-7890	USA
dave@example.com	Dave	Johnson	50000	123-456-7893	France
eve@example.com	Eve	Williams	65000	123-456-7894	Germany
grace@example.com	Grace	Miller	70000	123-456-7896	Italy
jack@example.com	Jack	Garcia	71000	123-456-7899	Japan
lucy@example.com	Lucy	Adams	69000	123-555-7890	USA
mark@example.com	Mark	Lee	71000	123-555-7891	Canada
nina@example.com	Nina	Kim	72000	123-555-7892	Mexico
oliver@example.com	Oliver	Martinez	52000	123-555-7893	France
paul@example.com	Paul	Thomas	63000	123-555-7894	Germany
quinn@example.com	Quinn	Robinson	61000	123-555-7895	UK
rachel@example.com	Rachel	Perez	70000	123-555-7896	Italy
sam@example.com	Sam	Evans	58000	123-555-7897	Spain
tina@example.com	Tina	Walker	67000	123-555-7898	Australia
uma@example.com	Uma	Harris	71000	123-555-7899	Japan
victor@example.com	Victor	Clark	75000	123-555-7800	USA
wendy@example.com	Wendy	Young	62000	123-555-7801	Canada
xavier@example.com	Xavier	Allen	67000	123-555-7802	Mexico
yara@example.com	Yara	Scott	53000	123-555-7803	France
zane@example.com	Zane	Torres	66000	123-555-7804	Germany
anna@example.com	Anna	Nguyen	64000	123-555-7805	UK
ben@example.com	Ben	Morris	71000	123-555-7806	Italy
carla@example.com	Carla	Reed	60000	123-555-7807	Spain
derek@example.com	Derek	Cruz	68000	123-555-7808	Australia
elsa@example.com	Elsa	Ramirez	72000	123-555-7809	Japan
bob@example.com	Bob	Brown	136000	123-456-7891	Canada
carol@example.com	Carol	White	144000	123-456-7892	Mexico
frank@example.com	Frank	Jones	124000	123-456-7895	UK
henry@example.com	Henry	Wilson	116000	123-456-7897	Spain
irene@example.com	Irene	Davis	136000	123-456-7898	Australia
\.


--
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (cname);


--
-- Name: discover discover_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discover
    ADD CONSTRAINT discover_pkey PRIMARY KEY (cname, disease_code);


--
-- Name: disease disease_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disease
    ADD CONSTRAINT disease_pkey PRIMARY KEY (disease_code);


--
-- Name: disease_type disease_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disease_type
    ADD CONSTRAINT disease_type_pkey PRIMARY KEY (id);


--
-- Name: doctor doctor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_pkey PRIMARY KEY (email);


--
-- Name: patient_disease patient_disease_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient_disease
    ADD CONSTRAINT patient_disease_pkey PRIMARY KEY (email, disease_code);


--
-- Name: patients patients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (email);


--
-- Name: public_servant public_servant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.public_servant
    ADD CONSTRAINT public_servant_pkey PRIMARY KEY (email);


--
-- Name: record record_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.record
    ADD CONSTRAINT record_pkey PRIMARY KEY (email, cname, disease_code);


--
-- Name: specialize specialize_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialize
    ADD CONSTRAINT specialize_pkey PRIMARY KEY (id, email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (email);


--
-- Name: idx_disease_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_disease_code ON public.disease USING btree (disease_code);


--
-- Name: discover discover_cname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discover
    ADD CONSTRAINT discover_cname_fkey FOREIGN KEY (cname) REFERENCES public.country(cname) ON DELETE RESTRICT;


--
-- Name: discover discover_disease_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.discover
    ADD CONSTRAINT discover_disease_code_fkey FOREIGN KEY (disease_code) REFERENCES public.disease(disease_code) ON DELETE CASCADE;


--
-- Name: disease disease_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disease
    ADD CONSTRAINT disease_id_fkey FOREIGN KEY (id) REFERENCES public.disease_type(id) ON DELETE CASCADE;


--
-- Name: doctor doctor_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_email_fkey FOREIGN KEY (email) REFERENCES public.users(email) ON DELETE CASCADE;


--
-- Name: patient_disease patient_disease_disease_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient_disease
    ADD CONSTRAINT patient_disease_disease_code_fkey FOREIGN KEY (disease_code) REFERENCES public.disease(disease_code) ON DELETE CASCADE;


--
-- Name: patient_disease patient_disease_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient_disease
    ADD CONSTRAINT patient_disease_email_fkey FOREIGN KEY (email) REFERENCES public.users(email) ON DELETE CASCADE;


--
-- Name: patients patients_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_email_fkey FOREIGN KEY (email) REFERENCES public.users(email) ON DELETE CASCADE;


--
-- Name: public_servant public_servant_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.public_servant
    ADD CONSTRAINT public_servant_email_fkey FOREIGN KEY (email) REFERENCES public.users(email) ON DELETE CASCADE;


--
-- Name: record record_cname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.record
    ADD CONSTRAINT record_cname_fkey FOREIGN KEY (cname) REFERENCES public.country(cname) ON DELETE RESTRICT;


--
-- Name: record record_disease_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.record
    ADD CONSTRAINT record_disease_code_fkey FOREIGN KEY (disease_code) REFERENCES public.disease(disease_code) ON DELETE CASCADE;


--
-- Name: record record_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.record
    ADD CONSTRAINT record_email_fkey FOREIGN KEY (email) REFERENCES public.public_servant(email) ON DELETE CASCADE;


--
-- Name: specialize specialize_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialize
    ADD CONSTRAINT specialize_email_fkey FOREIGN KEY (email) REFERENCES public.doctor(email) ON DELETE CASCADE;


--
-- Name: specialize specialize_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specialize
    ADD CONSTRAINT specialize_id_fkey FOREIGN KEY (id) REFERENCES public.disease_type(id) ON DELETE CASCADE;


--
-- Name: users users_cname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_cname_fkey FOREIGN KEY (cname) REFERENCES public.country(cname) ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

