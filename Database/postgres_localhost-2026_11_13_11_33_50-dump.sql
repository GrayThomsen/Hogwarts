--
-- PostgreSQL database dump
--

\restrict j1xEAWbgSUtJgjtxcCf0kYYoQSBHhlzTeuQgoc2vY1TLT8e5w55RU97jDTh4kvd

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: exams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exams (
    fk_student_id integer NOT NULL,
    fk_subject_id integer NOT NULL,
    date timestamp without time zone NOT NULL,
    fk_grade_id integer,
    fk_qualifications integer,
    fk_regulators integer
);


ALTER TABLE public.exams OWNER TO postgres;

--
-- Name: grades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grades (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    symbol character varying(1) NOT NULL,
    outcome character varying(20) NOT NULL
);


ALTER TABLE public.grades OWNER TO postgres;

--
-- Name: grades_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.grades ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.grades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: houses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.houses (
    id integer NOT NULL,
    name character varying(255),
    fk_founder integer,
    fk_head_of_house integer,
    fk_house_ghost integer,
    sigil character varying(255),
    colours text
);


ALTER TABLE public.houses OWNER TO postgres;

--
-- Name: houses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.houses ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.houses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: qualifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.qualifications (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text
);


ALTER TABLE public.qualifications OWNER TO postgres;

--
-- Name: qualifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.qualifications ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.qualifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: regulators; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regulators (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    authority_level character varying(255) NOT NULL
);


ALTER TABLE public.regulators OWNER TO postgres;

--
-- Name: regulators_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.regulators ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.regulators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: staff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.staff (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    fk_house integer,
    active_status boolean NOT NULL,
    health_status character varying(100) NOT NULL,
    birthday timestamp without time zone,
    date_of_hiring timestamp without time zone,
    final_day timestamp without time zone,
    CONSTRAINT staff_check CHECK ((date_of_hiring < final_day)),
    CONSTRAINT staff_check1 CHECK (((NULLIF(TRIM(BOTH FROM first_name), ''::text) IS NOT NULL) OR (NULLIF(TRIM(BOTH FROM last_name), ''::text) IS NOT NULL)))
);


ALTER TABLE public.staff OWNER TO postgres;

--
-- Name: staff_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.staff ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.staff_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: staff_subjects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.staff_subjects (
    fk_staff_id integer NOT NULL,
    fk_subject_id integer NOT NULL,
    role character varying(255)
);


ALTER TABLE public.staff_subjects OWNER TO postgres;

--
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    id integer NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    fk_house integer,
    birthday timestamp without time zone,
    CONSTRAINT students_check CHECK (((NULLIF(TRIM(BOTH FROM first_name), ''::text) IS NOT NULL) OR (NULLIF(TRIM(BOTH FROM last_name), ''::text) IS NOT NULL)))
);


ALTER TABLE public.students OWNER TO postgres;

--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.students ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.students_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: students_subjects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students_subjects (
    fk_student_id integer NOT NULL,
    fk_subject_id integer NOT NULL,
    year integer NOT NULL,
    CONSTRAINT students_subjects_year_check CHECK (((year >= 1) AND (year <= 7)))
);


ALTER TABLE public.students_subjects OWNER TO postgres;

--
-- Name: subject_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subject_type (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    ects integer NOT NULL
);


ALTER TABLE public.subject_type OWNER TO postgres;

--
-- Name: subject_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.subject_type ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.subject_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: subjects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subjects (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    start_year integer NOT NULL,
    end_year integer NOT NULL,
    fk_type integer,
    fk_required_grade integer,
    CONSTRAINT subjects_check CHECK (((end_year >= start_year) AND (end_year <= 7))),
    CONSTRAINT subjects_start_year_check CHECK (((start_year >= 1) AND (start_year <= 7)))
);


ALTER TABLE public.subjects OWNER TO postgres;

--
-- Name: subjects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.subjects ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.subjects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: wands; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wands (
    id integer NOT NULL,
    wood character varying(100) NOT NULL,
    core character varying(100) NOT NULL,
    length double precision NOT NULL,
    fk_student_owner integer,
    fk_staff_owner integer,
    CONSTRAINT wands_at_most_one_owner CHECK (((fk_student_owner IS NULL) OR (fk_staff_owner IS NULL)))
);


ALTER TABLE public.wands OWNER TO postgres;

--
-- Name: wands_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.wands ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.wands_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: exams; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.exams VALUES (7, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (7, 13, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (7, 20, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (7, 22, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (7, 28, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (7, 31, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (7, 32, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (7, 34, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (7, 37, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (8, 11, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (8, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (8, 20, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (8, 22, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (8, 29, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (8, 31, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (8, 32, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (8, 34, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (8, 37, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (9, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (9, 12, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (9, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (9, 14, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (9, 19, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (9, 20, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (9, 26, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (9, 28, '1996-06-15 00:00:00', 16, 10, 10);
INSERT INTO public.exams VALUES (9, 29, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (9, 31, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (9, 32, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (9, 33, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (9, 34, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (9, 37, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (10, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (10, 13, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (10, 14, '1996-06-15 00:00:00', 16, 10, 10);
INSERT INTO public.exams VALUES (10, 20, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (10, 29, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (10, 31, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (10, 32, '1996-06-15 00:00:00', 16, 10, 10);
INSERT INTO public.exams VALUES (10, 34, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (10, 37, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (11, 11, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (11, 12, '1998-06-15 00:00:00', 16, 11, 10);
INSERT INTO public.exams VALUES (11, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (11, 14, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (11, 15, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (11, 20, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (11, 26, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (11, 29, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (11, 30, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (11, 31, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (11, 32, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (11, 34, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (11, 37, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (12, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (12, 12, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (12, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (12, 14, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (12, 20, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (12, 24, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (12, 27, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (12, 30, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (12, 31, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (12, 32, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (12, 34, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (12, 35, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (12, 37, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (13, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (13, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (13, 15, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (13, 19, '1998-06-15 00:00:00', 17, 11, 10);
INSERT INTO public.exams VALUES (13, 20, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (13, 24, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (13, 27, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (13, 29, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (13, 31, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (13, 32, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (13, 34, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (13, 36, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (13, 37, '1996-06-15 00:00:00', 16, 10, 10);
INSERT INTO public.exams VALUES (14, 11, '1996-06-15 00:00:00', 17, 10, 10);
INSERT INTO public.exams VALUES (14, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (14, 14, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (14, 15, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (14, 20, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (14, 26, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (14, 29, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (14, 30, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (14, 31, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (14, 32, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (14, 34, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (14, 36, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (14, 37, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (15, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (15, 12, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (15, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (15, 15, '1998-06-15 00:00:00', 16, 11, 10);
INSERT INTO public.exams VALUES (15, 20, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (15, 22, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (15, 28, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (15, 30, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (15, 31, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (15, 32, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (15, 34, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (15, 36, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (15, 37, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (16, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (16, 12, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (16, 13, '1996-06-15 00:00:00', 16, 10, 10);
INSERT INTO public.exams VALUES (16, 20, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (16, 26, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (16, 28, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (16, 29, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (16, 31, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (16, 32, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (16, 33, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (16, 34, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (16, 36, '1998-06-15 00:00:00', 17, 11, 10);
INSERT INTO public.exams VALUES (16, 37, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (17, 11, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (17, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (17, 19, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (17, 20, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (17, 21, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (17, 22, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (17, 27, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (17, 30, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (17, 31, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (17, 32, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (17, 33, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (17, 34, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (17, 37, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (18, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (18, 13, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (18, 14, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (18, 18, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (18, 19, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (18, 20, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (18, 27, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (18, 31, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (18, 32, '1996-06-15 00:00:00', 16, 10, 10);
INSERT INTO public.exams VALUES (18, 33, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (18, 34, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (18, 36, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (18, 37, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (19, 11, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (19, 12, '1998-06-15 00:00:00', 16, 11, 10);
INSERT INTO public.exams VALUES (19, 13, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (19, 19, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (19, 20, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (19, 21, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (19, 22, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (19, 28, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (19, 31, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (19, 32, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (19, 33, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (19, 34, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (19, 37, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (20, 11, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (20, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (20, 15, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (20, 20, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (20, 22, '1996-06-15 00:00:00', 16, 10, 10);
INSERT INTO public.exams VALUES (20, 25, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (20, 28, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (20, 31, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (20, 32, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (20, 33, '1998-06-15 00:00:00', 18, 11, 10);
INSERT INTO public.exams VALUES (20, 34, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (20, 36, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (20, 37, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (21, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (21, 12, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (21, 13, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (21, 15, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (21, 19, '1998-06-15 00:00:00', 18, 11, 10);
INSERT INTO public.exams VALUES (21, 20, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (21, 27, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (21, 28, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (21, 31, '1996-06-15 00:00:00', 17, 10, 10);
INSERT INTO public.exams VALUES (21, 32, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (21, 34, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (21, 35, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (21, 37, '1996-06-15 00:00:00', 16, 10, 10);
INSERT INTO public.exams VALUES (22, 11, '1996-06-15 00:00:00', 18, 10, 10);
INSERT INTO public.exams VALUES (22, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (22, 15, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (22, 20, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (22, 21, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (22, 22, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (22, 26, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (22, 29, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (22, 31, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (22, 32, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (22, 34, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (22, 36, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (22, 37, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (23, 11, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (23, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (23, 14, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (23, 15, '1998-06-15 00:00:00', 16, 11, 10);
INSERT INTO public.exams VALUES (23, 18, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (23, 19, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (23, 20, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (23, 22, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (23, 30, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (23, 31, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (23, 32, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (23, 34, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (23, 37, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (24, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (24, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (24, 14, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (24, 15, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (24, 20, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (24, 21, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (24, 22, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (24, 30, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (24, 31, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (24, 32, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (24, 34, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (24, 35, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (24, 37, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (25, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (25, 12, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (25, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (25, 15, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (25, 19, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (25, 20, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (25, 24, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (25, 27, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (25, 28, '1996-06-15 00:00:00', 18, 10, 10);
INSERT INTO public.exams VALUES (25, 31, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (25, 32, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (25, 34, '1996-06-15 00:00:00', 17, 10, 10);
INSERT INTO public.exams VALUES (25, 37, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (26, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (26, 12, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (26, 13, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (26, 15, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (26, 20, '1996-06-15 00:00:00', 17, 10, 10);
INSERT INTO public.exams VALUES (26, 22, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (26, 28, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (26, 31, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (26, 32, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (26, 34, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (26, 35, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (26, 36, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (26, 37, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (27, 11, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (27, 12, '1998-06-15 00:00:00', 17, 11, 10);
INSERT INTO public.exams VALUES (27, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (27, 14, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (27, 15, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (27, 20, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (27, 21, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (27, 22, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (27, 31, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (27, 32, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (27, 34, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (27, 35, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (27, 37, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (28, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (28, 12, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (28, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (28, 14, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (28, 20, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (28, 26, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (28, 29, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (28, 30, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (28, 31, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (28, 32, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (28, 34, '1996-06-15 00:00:00', 16, 10, 10);
INSERT INTO public.exams VALUES (28, 35, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (28, 37, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (29, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (29, 13, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (29, 19, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (29, 20, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (29, 27, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (29, 29, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (29, 31, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (29, 32, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (29, 33, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (29, 34, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (29, 35, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (29, 36, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (29, 37, '1996-06-15 00:00:00', 17, 10, 10);
INSERT INTO public.exams VALUES (30, 11, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (30, 12, '1998-06-15 00:00:00', 16, 11, 10);
INSERT INTO public.exams VALUES (30, 13, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (30, 20, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (30, 26, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (30, 27, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (30, 29, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (30, 31, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (30, 32, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (30, 33, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (30, 34, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (30, 35, '1998-06-15 00:00:00', 17, 11, 10);
INSERT INTO public.exams VALUES (30, 37, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (31, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (31, 12, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (31, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (31, 15, '1998-06-15 00:00:00', 17, 11, 10);
INSERT INTO public.exams VALUES (31, 20, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (31, 22, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (31, 24, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (31, 27, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (31, 31, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (31, 32, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (31, 34, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (31, 36, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (31, 37, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (32, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (32, 12, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (32, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (32, 14, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (32, 15, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (32, 20, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (32, 24, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (32, 27, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (32, 30, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (32, 31, '1996-06-15 00:00:00', 16, 10, 10);
INSERT INTO public.exams VALUES (32, 32, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (32, 34, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (32, 37, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (33, 11, '1996-06-15 00:00:00', 16, 10, 10);
INSERT INTO public.exams VALUES (33, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (33, 15, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (33, 20, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (33, 22, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (33, 29, '1996-06-15 00:00:00', 16, 10, 10);
INSERT INTO public.exams VALUES (33, 30, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (33, 31, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (33, 32, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (33, 34, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (33, 35, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (33, 36, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (33, 37, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (34, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (34, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (34, 15, '1998-06-15 00:00:00', 16, 11, 10);
INSERT INTO public.exams VALUES (34, 19, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (34, 20, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (34, 22, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (34, 29, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (34, 30, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (34, 31, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (34, 32, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (34, 34, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (34, 35, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (34, 37, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (35, 11, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (35, 13, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (35, 14, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (35, 19, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (35, 20, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (35, 26, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (35, 29, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (35, 31, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (35, 32, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (35, 33, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (35, 34, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (35, 35, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (35, 37, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (36, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (36, 12, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (36, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (36, 14, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (36, 15, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (36, 20, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (36, 29, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (36, 30, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (36, 31, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (36, 32, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (36, 34, '1996-06-15 00:00:00', 16, 10, 10);
INSERT INTO public.exams VALUES (36, 35, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (36, 37, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (37, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (37, 13, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (37, 15, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (37, 19, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (37, 20, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (37, 21, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (37, 22, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (37, 29, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (37, 31, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (37, 32, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (37, 34, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (37, 35, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (37, 37, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (38, 11, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (38, 12, '1998-06-15 00:00:00', 16, 11, 10);
INSERT INTO public.exams VALUES (38, 13, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (38, 14, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (38, 18, '1998-06-15 00:00:00', 16, 11, 10);
INSERT INTO public.exams VALUES (38, 20, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (38, 22, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (38, 30, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (38, 31, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (38, 32, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (38, 34, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (38, 35, '1998-06-15 00:00:00', 18, 11, 10);
INSERT INTO public.exams VALUES (38, 37, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (39, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (39, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (39, 14, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (39, 20, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (39, 22, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (39, 31, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (39, 32, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (39, 34, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (39, 37, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (40, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (40, 13, '1996-06-15 00:00:00', 18, 10, 10);
INSERT INTO public.exams VALUES (40, 19, '1998-06-15 00:00:00', 17, 11, 10);
INSERT INTO public.exams VALUES (40, 20, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (40, 21, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (40, 22, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (40, 24, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (40, 27, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (40, 30, '1998-06-15 00:00:00', 13, 11, 10);
INSERT INTO public.exams VALUES (40, 31, '1996-06-15 00:00:00', 16, 10, 10);
INSERT INTO public.exams VALUES (40, 32, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (40, 34, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (40, 37, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (41, 11, '1996-06-15 00:00:00', 17, 10, 10);
INSERT INTO public.exams VALUES (41, 13, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (41, 19, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (41, 20, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (41, 26, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (41, 27, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (41, 29, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (41, 30, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (41, 31, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (41, 32, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (41, 34, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (41, 36, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (41, 37, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (42, 11, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (42, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (42, 15, '1998-06-15 00:00:00', 16, 11, 10);
INSERT INTO public.exams VALUES (42, 20, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (42, 21, '1998-06-15 00:00:00', 16, 11, 10);
INSERT INTO public.exams VALUES (42, 22, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (42, 27, '1996-06-15 00:00:00', 16, 10, 10);
INSERT INTO public.exams VALUES (42, 31, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (42, 32, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (42, 33, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (42, 34, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (42, 36, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (42, 37, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (43, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (43, 13, '1996-06-15 00:00:00', 16, 10, 10);
INSERT INTO public.exams VALUES (43, 20, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (43, 27, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (43, 28, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (43, 31, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (43, 32, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (43, 34, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (43, 37, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (44, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (44, 12, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (44, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (44, 14, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (44, 18, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (44, 19, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (44, 20, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (44, 27, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (44, 31, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (44, 32, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (44, 34, '1996-06-15 00:00:00', 16, 10, 10);
INSERT INTO public.exams VALUES (44, 36, '1998-06-15 00:00:00', 15, 11, 10);
INSERT INTO public.exams VALUES (44, 37, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (45, 11, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (45, 13, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (45, 20, '1996-06-15 00:00:00', 17, 10, 10);
INSERT INTO public.exams VALUES (45, 22, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (45, 27, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (45, 31, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (45, 32, '1996-06-15 00:00:00', 16, 10, 10);
INSERT INTO public.exams VALUES (45, 34, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (45, 37, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (46, 11, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (46, 12, '1998-06-15 00:00:00', 16, 11, 10);
INSERT INTO public.exams VALUES (46, 13, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (46, 14, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (46, 15, '1998-06-15 00:00:00', 14, 11, 10);
INSERT INTO public.exams VALUES (46, 18, '1998-06-15 00:00:00', 16, 11, 10);
INSERT INTO public.exams VALUES (46, 20, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (46, 24, '1998-06-15 00:00:00', 16, 11, 10);
INSERT INTO public.exams VALUES (46, 27, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (46, 31, '1996-06-15 00:00:00', 15, 10, 10);
INSERT INTO public.exams VALUES (46, 32, '1996-06-15 00:00:00', 14, 10, 10);
INSERT INTO public.exams VALUES (46, 34, '1996-06-15 00:00:00', 13, 10, 10);
INSERT INTO public.exams VALUES (46, 37, '1996-06-15 00:00:00', 15, 10, 10);


--
-- Data for Name: grades; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.grades OVERRIDING SYSTEM VALUE VALUES (13, 'Outstanding', 'O', 'Pass');
INSERT INTO public.grades OVERRIDING SYSTEM VALUE VALUES (14, 'Exceeds Expectations', 'E', 'Pass');
INSERT INTO public.grades OVERRIDING SYSTEM VALUE VALUES (15, 'Acceptable', 'A', 'Pass');
INSERT INTO public.grades OVERRIDING SYSTEM VALUE VALUES (16, 'Poor', 'P', 'Fail / Retry');
INSERT INTO public.grades OVERRIDING SYSTEM VALUE VALUES (17, 'Dreadful', 'D', 'Fail');
INSERT INTO public.grades OVERRIDING SYSTEM VALUE VALUES (18, 'Troll', 'T', 'Fail');


--
-- Data for Name: houses; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.houses OVERRIDING SYSTEM VALUE VALUES (9, 'Gryffindor', 36, 5, 33, 'Lion', 'Scarlet and gold');
INSERT INTO public.houses OVERRIDING SYSTEM VALUE VALUES (12, 'Slytherin', 40, 6, 38, 'Serpent', 'Green and silver');
INSERT INTO public.houses OVERRIDING SYSTEM VALUE VALUES (10, 'Hufflepuff', 37, 12, 35, 'Badger', 'Yellow and black');
INSERT INTO public.houses OVERRIDING SYSTEM VALUE VALUES (11, 'Ravenclaw', 34, 24, 39, 'Eagle', 'Blue and bronze');


--
-- Data for Name: qualifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.qualifications OVERRIDING SYSTEM VALUE VALUES (10, 'O.W.L.', 'Ordinary Wizarding Level');
INSERT INTO public.qualifications OVERRIDING SYSTEM VALUE VALUES (11, 'N.E.W.T.', 'Nastily Exhausting Wizarding Test');
INSERT INTO public.qualifications OVERRIDING SYSTEM VALUE VALUES (12, 'Certification', 'A lesser diploma of allowance or gratification');


--
-- Data for Name: regulators; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.regulators OVERRIDING SYSTEM VALUE VALUES (10, 'Wizarding Examinations Authority', 'International');
INSERT INTO public.regulators OVERRIDING SYSTEM VALUE VALUES (11, 'Department of Magical Transportation', 'National');
INSERT INTO public.regulators OVERRIDING SYSTEM VALUE VALUES (12, 'Hogwarts School of Witchcraft and Wizardry', 'Regional');


--
-- Data for Name: staff; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (7, 'Wilkie', 'Twycross', NULL, false, 'Healthy', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (9, 'Charity', 'Burbage', NULL, true, 'Healthy', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (10, 'Bathsheba', 'Babbling', NULL, true, 'Healthy', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (11, 'Argus', 'Filch', NULL, true, 'Healthy', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (12, 'Pomona', 'Sprout', 10, true, 'Healthy', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (13, 'Septima', 'Vector', NULL, true, 'Healthy', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (16, 'Horace', 'Slughorn', 12, true, 'Healthy', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (17, 'Poppy', 'Pomfrey', NULL, true, 'Healthy', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (18, 'Rolanda', 'Hooch', NULL, true, 'Healthy', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (19, 'Silvanus', 'Kettleburn', 10, false, 'Healthy', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (22, 'Aurora', 'Sinistra', NULL, true, 'Healthy', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (23, 'Sybill', 'Trelawney', 11, true, 'Healthy', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (24, 'Filius', 'Flitwick', 11, true, 'Healthy', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (26, 'Irma', 'Pince', NULL, true, 'Healthy', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (28, 'Wilhelmina', 'Grubbly-Plank', NULL, false, 'Healthy', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (29, 'Firenze', NULL, NULL, true, 'Healthy', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (32, 'Quirinus', 'Quirrell', 11, false, 'Deceased', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (5, 'Minerva', 'McGonagall', 9, true, 'Healthy', '1935-10-04 00:00:00', NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (14, 'Dolores', 'Umbridge', 12, false, 'Healthy', NULL, '1995-09-01 00:00:00', NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (15, 'Cuthbert', 'Binns', NULL, true, 'Deceased', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (25, 'Rubeus', 'Hagrid', 9, true, 'Healthy', '1928-12-06 00:00:00', NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (27, 'Gilderoy', 'Lockhart', 11, false, 'Memory loss', '1964-01-26 00:00:00', '1992-09-01 00:00:00', '1993-05-29 00:00:00');
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (30, 'Amycus', 'Carrow', 12, false, 'Healthy', NULL, '1997-09-01 00:00:00', NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (31, 'Alecto', 'Carrow', 12, false, 'Healthy', NULL, '1997-09-01 00:00:00', NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (33, 'Nicholas', 'de Mimsy Porpington', 9, true, 'Deceased', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (34, 'Rowena', 'Ravenclaw', 11, false, 'Deceased', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (35, 'Fat Friar', NULL, 10, true, 'Deceased', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (36, 'Godric', 'Gryffindor', 9, false, 'Deceased', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (37, 'Helga', 'Hufflepuff', 10, false, 'Deceased', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (38, 'Bloody Baron', NULL, 12, true, 'Deceased', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (39, 'Helena', 'Ravenclaw', 11, true, 'Deceased', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (40, 'Salazar', 'Slytherin', 12, false, 'Deceased', NULL, NULL, NULL);
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (6, 'Severus', 'Snape', 12, true, 'Deceased', '1960-01-09 00:00:00', NULL, '1998-05-02 00:00:00');
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (8, 'Barty', 'Crouch Jr.', NULL, false, 'Deceased', NULL, '1994-09-01 00:00:00', '1995-06-24 00:00:00');
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (20, 'Albus', 'Dumbledore', 9, true, 'Deceased', NULL, NULL, '1997-06-30 00:00:00');
INSERT INTO public.staff OVERRIDING SYSTEM VALUE VALUES (21, 'Remus', 'Lupin', 9, false, 'Deceased', '1960-03-10 00:00:00', '1993-09-01 00:00:00', '1994-06-07 00:00:00');


--
-- Data for Name: staff_subjects; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.staff_subjects VALUES (5, 13, 'Teacher');
INSERT INTO public.staff_subjects VALUES (6, 11, 'Teacher');
INSERT INTO public.staff_subjects VALUES (7, 17, 'Teacher');
INSERT INTO public.staff_subjects VALUES (9, 24, 'Teacher');
INSERT INTO public.staff_subjects VALUES (9, 27, 'Teacher');
INSERT INTO public.staff_subjects VALUES (10, 25, 'Teacher');
INSERT INTO public.staff_subjects VALUES (10, 28, 'Teacher');
INSERT INTO public.staff_subjects VALUES (12, 35, 'Teacher');
INSERT INTO public.staff_subjects VALUES (12, 32, 'Teacher');
INSERT INTO public.staff_subjects VALUES (13, 21, 'Teacher');
INSERT INTO public.staff_subjects VALUES (13, 22, 'Teacher');
INSERT INTO public.staff_subjects VALUES (16, 12, 'Teacher');
INSERT INTO public.staff_subjects VALUES (16, 11, 'Teacher');
INSERT INTO public.staff_subjects VALUES (18, 23, 'Teacher');
INSERT INTO public.staff_subjects VALUES (18, 45, 'Teacher');
INSERT INTO public.staff_subjects VALUES (19, 18, 'Teacher');
INSERT INTO public.staff_subjects VALUES (19, 14, 'Teacher');
INSERT INTO public.staff_subjects VALUES (22, 19, 'Teacher');
INSERT INTO public.staff_subjects VALUES (22, 20, 'Teacher');
INSERT INTO public.staff_subjects VALUES (23, 26, 'Teacher');
INSERT INTO public.staff_subjects VALUES (23, 29, 'Teacher');
INSERT INTO public.staff_subjects VALUES (24, 48, 'Teacher');
INSERT INTO public.staff_subjects VALUES (24, 43, 'Teacher');
INSERT INTO public.staff_subjects VALUES (24, 33, 'Teacher');
INSERT INTO public.staff_subjects VALUES (24, 34, 'Teacher');
INSERT INTO public.staff_subjects VALUES (28, 14, 'Teacher');
INSERT INTO public.staff_subjects VALUES (29, 29, 'Teacher');
INSERT INTO public.staff_subjects VALUES (32, 24, 'Teacher');
INSERT INTO public.staff_subjects VALUES (32, 27, 'Teacher');
INSERT INTO public.staff_subjects VALUES (32, 30, 'Teacher');
INSERT INTO public.staff_subjects VALUES (32, 37, 'Teacher');
INSERT INTO public.staff_subjects VALUES (5, 15, 'Teacher');
INSERT INTO public.staff_subjects VALUES (14, 30, 'Teacher');
INSERT INTO public.staff_subjects VALUES (14, 37, 'Teacher');
INSERT INTO public.staff_subjects VALUES (15, 36, 'Teacher');
INSERT INTO public.staff_subjects VALUES (15, 31, 'Teacher');
INSERT INTO public.staff_subjects VALUES (25, 18, 'Teacher');
INSERT INTO public.staff_subjects VALUES (25, 14, 'Teacher');
INSERT INTO public.staff_subjects VALUES (27, 30, 'Teacher');
INSERT INTO public.staff_subjects VALUES (27, 37, 'Teacher');
INSERT INTO public.staff_subjects VALUES (30, 30, 'Teacher');
INSERT INTO public.staff_subjects VALUES (30, 37, 'Teacher');
INSERT INTO public.staff_subjects VALUES (31, 24, 'Teacher');
INSERT INTO public.staff_subjects VALUES (31, 27, 'Teacher');
INSERT INTO public.staff_subjects VALUES (6, 30, 'Teacher');
INSERT INTO public.staff_subjects VALUES (6, 37, 'Teacher');
INSERT INTO public.staff_subjects VALUES (6, 12, 'Teacher');
INSERT INTO public.staff_subjects VALUES (8, 30, 'Teacher');
INSERT INTO public.staff_subjects VALUES (8, 37, 'Teacher');
INSERT INTO public.staff_subjects VALUES (21, 30, 'Teacher');
INSERT INTO public.staff_subjects VALUES (21, 37, 'Teacher');


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (10, 'Dean', 'Thomas', 9, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (11, 'Millicent', 'Bulstrode', 12, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (12, 'Theodore', 'Nott', 12, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (13, 'Terry', 'Boot', 11, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (14, 'Justin', 'Finch-Fletchley', 10, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (15, 'Blaise', 'Zabini', 12, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (16, 'Fred', 'Weasley', 9, '1978-04-01 00:00:00');
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (17, 'Padma', 'Patil', 11, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (18, 'Angelina', 'Johnson', 9, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (19, 'Gregory', 'Goyle', 12, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (20, 'Graham', 'Montague', 12, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (21, 'Anthony', 'Goldstein', 11, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (22, 'Oliver', 'Wood', 9, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (23, 'Neville', 'Longbottom', 9, '1980-07-30 00:00:00');
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (24, 'Penelope', 'Clearwater', 11, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (25, 'Susan', 'Bones', 10, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (26, 'Katie', 'Bell', 9, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (27, 'Michael', 'Corner', 11, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (28, 'Hannah', 'Abbott', 10, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (29, 'Pansy', 'Parkinson', 12, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (30, 'Ernie', 'Macmillan', 10, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (31, 'Zacharias', 'Smith', 10, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (32, 'Parvati', 'Patil', 9, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (33, 'Luna', 'Lovegood', 11, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (34, 'Ginny', 'Weasley', 9, '1981-08-11 00:00:00');
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (35, 'Marietta', 'Edgecombe', 11, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (36, 'Cho', 'Chang', 11, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (37, 'Seamus', 'Finnigan', 9, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (38, 'Lavender', 'Brown', 9, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (39, 'Ron', 'Weasley', 9, '1980-03-01 00:00:00');
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (40, 'Lee', 'Jordan', 9, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (41, 'Dennis', 'Creevey', 9, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (42, 'Vincent', 'Crabbe', 12, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (43, 'Colin', 'Creevey', 9, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (44, 'George', 'Weasley', 9, '1978-04-01 00:00:00');
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (45, 'Cedric', 'Diggory', 10, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (46, 'Alicia', 'Spinnet', 9, NULL);
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (7, 'Harry', 'Potter', 9, '1980-07-31 00:00:00');
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (8, 'Hermione', 'Granger', 9, '1979-09-19 00:00:00');
INSERT INTO public.students OVERRIDING SYSTEM VALUE VALUES (9, 'Draco', 'Malfoy', 12, '1980-06-05 00:00:00');


--
-- Data for Name: students_subjects; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.students_subjects VALUES (7, 11, 5);
INSERT INTO public.students_subjects VALUES (8, 12, 6);
INSERT INTO public.students_subjects VALUES (9, 14, 5);
INSERT INTO public.students_subjects VALUES (10, 11, 1);
INSERT INTO public.students_subjects VALUES (10, 11, 2);
INSERT INTO public.students_subjects VALUES (10, 11, 3);
INSERT INTO public.students_subjects VALUES (10, 11, 4);
INSERT INTO public.students_subjects VALUES (10, 11, 5);
INSERT INTO public.students_subjects VALUES (10, 13, 1);
INSERT INTO public.students_subjects VALUES (10, 13, 2);
INSERT INTO public.students_subjects VALUES (10, 13, 3);
INSERT INTO public.students_subjects VALUES (10, 13, 4);
INSERT INTO public.students_subjects VALUES (10, 13, 5);
INSERT INTO public.students_subjects VALUES (10, 20, 1);
INSERT INTO public.students_subjects VALUES (10, 20, 2);
INSERT INTO public.students_subjects VALUES (10, 20, 3);
INSERT INTO public.students_subjects VALUES (10, 20, 4);
INSERT INTO public.students_subjects VALUES (10, 20, 5);
INSERT INTO public.students_subjects VALUES (10, 31, 1);
INSERT INTO public.students_subjects VALUES (10, 31, 2);
INSERT INTO public.students_subjects VALUES (10, 31, 3);
INSERT INTO public.students_subjects VALUES (10, 31, 4);
INSERT INTO public.students_subjects VALUES (10, 31, 5);
INSERT INTO public.students_subjects VALUES (10, 32, 1);
INSERT INTO public.students_subjects VALUES (10, 32, 2);
INSERT INTO public.students_subjects VALUES (10, 32, 3);
INSERT INTO public.students_subjects VALUES (10, 32, 4);
INSERT INTO public.students_subjects VALUES (10, 32, 5);
INSERT INTO public.students_subjects VALUES (10, 34, 1);
INSERT INTO public.students_subjects VALUES (10, 34, 2);
INSERT INTO public.students_subjects VALUES (10, 34, 3);
INSERT INTO public.students_subjects VALUES (10, 34, 4);
INSERT INTO public.students_subjects VALUES (10, 34, 5);
INSERT INTO public.students_subjects VALUES (10, 37, 1);
INSERT INTO public.students_subjects VALUES (10, 37, 2);
INSERT INTO public.students_subjects VALUES (10, 37, 3);
INSERT INTO public.students_subjects VALUES (10, 37, 4);
INSERT INTO public.students_subjects VALUES (10, 37, 5);
INSERT INTO public.students_subjects VALUES (10, 29, 3);
INSERT INTO public.students_subjects VALUES (10, 29, 4);
INSERT INTO public.students_subjects VALUES (10, 29, 5);
INSERT INTO public.students_subjects VALUES (10, 14, 3);
INSERT INTO public.students_subjects VALUES (10, 14, 4);
INSERT INTO public.students_subjects VALUES (10, 14, 5);
INSERT INTO public.students_subjects VALUES (11, 11, 1);
INSERT INTO public.students_subjects VALUES (11, 11, 2);
INSERT INTO public.students_subjects VALUES (11, 11, 3);
INSERT INTO public.students_subjects VALUES (11, 11, 4);
INSERT INTO public.students_subjects VALUES (11, 11, 5);
INSERT INTO public.students_subjects VALUES (11, 13, 1);
INSERT INTO public.students_subjects VALUES (11, 13, 2);
INSERT INTO public.students_subjects VALUES (11, 13, 3);
INSERT INTO public.students_subjects VALUES (11, 13, 4);
INSERT INTO public.students_subjects VALUES (11, 13, 5);
INSERT INTO public.students_subjects VALUES (11, 20, 1);
INSERT INTO public.students_subjects VALUES (11, 20, 2);
INSERT INTO public.students_subjects VALUES (11, 20, 3);
INSERT INTO public.students_subjects VALUES (11, 20, 4);
INSERT INTO public.students_subjects VALUES (11, 20, 5);
INSERT INTO public.students_subjects VALUES (11, 31, 1);
INSERT INTO public.students_subjects VALUES (11, 31, 2);
INSERT INTO public.students_subjects VALUES (11, 31, 3);
INSERT INTO public.students_subjects VALUES (11, 31, 4);
INSERT INTO public.students_subjects VALUES (11, 31, 5);
INSERT INTO public.students_subjects VALUES (11, 32, 1);
INSERT INTO public.students_subjects VALUES (11, 32, 2);
INSERT INTO public.students_subjects VALUES (11, 32, 3);
INSERT INTO public.students_subjects VALUES (11, 32, 4);
INSERT INTO public.students_subjects VALUES (11, 32, 5);
INSERT INTO public.students_subjects VALUES (11, 34, 1);
INSERT INTO public.students_subjects VALUES (11, 34, 2);
INSERT INTO public.students_subjects VALUES (11, 34, 3);
INSERT INTO public.students_subjects VALUES (11, 34, 4);
INSERT INTO public.students_subjects VALUES (11, 34, 5);
INSERT INTO public.students_subjects VALUES (11, 37, 1);
INSERT INTO public.students_subjects VALUES (11, 37, 2);
INSERT INTO public.students_subjects VALUES (11, 37, 3);
INSERT INTO public.students_subjects VALUES (11, 37, 4);
INSERT INTO public.students_subjects VALUES (11, 37, 5);
INSERT INTO public.students_subjects VALUES (11, 14, 3);
INSERT INTO public.students_subjects VALUES (11, 14, 4);
INSERT INTO public.students_subjects VALUES (11, 14, 5);
INSERT INTO public.students_subjects VALUES (11, 29, 3);
INSERT INTO public.students_subjects VALUES (11, 29, 4);
INSERT INTO public.students_subjects VALUES (11, 29, 5);
INSERT INTO public.students_subjects VALUES (12, 11, 1);
INSERT INTO public.students_subjects VALUES (12, 11, 2);
INSERT INTO public.students_subjects VALUES (12, 11, 3);
INSERT INTO public.students_subjects VALUES (12, 11, 4);
INSERT INTO public.students_subjects VALUES (12, 11, 5);
INSERT INTO public.students_subjects VALUES (12, 13, 1);
INSERT INTO public.students_subjects VALUES (12, 13, 2);
INSERT INTO public.students_subjects VALUES (12, 13, 3);
INSERT INTO public.students_subjects VALUES (12, 13, 4);
INSERT INTO public.students_subjects VALUES (12, 13, 5);
INSERT INTO public.students_subjects VALUES (12, 20, 1);
INSERT INTO public.students_subjects VALUES (12, 20, 2);
INSERT INTO public.students_subjects VALUES (12, 20, 3);
INSERT INTO public.students_subjects VALUES (12, 20, 4);
INSERT INTO public.students_subjects VALUES (12, 20, 5);
INSERT INTO public.students_subjects VALUES (12, 31, 1);
INSERT INTO public.students_subjects VALUES (12, 31, 2);
INSERT INTO public.students_subjects VALUES (12, 31, 3);
INSERT INTO public.students_subjects VALUES (12, 31, 4);
INSERT INTO public.students_subjects VALUES (12, 31, 5);
INSERT INTO public.students_subjects VALUES (12, 32, 1);
INSERT INTO public.students_subjects VALUES (12, 32, 2);
INSERT INTO public.students_subjects VALUES (12, 32, 3);
INSERT INTO public.students_subjects VALUES (12, 32, 4);
INSERT INTO public.students_subjects VALUES (12, 32, 5);
INSERT INTO public.students_subjects VALUES (12, 34, 1);
INSERT INTO public.students_subjects VALUES (12, 34, 2);
INSERT INTO public.students_subjects VALUES (12, 34, 3);
INSERT INTO public.students_subjects VALUES (12, 34, 4);
INSERT INTO public.students_subjects VALUES (12, 34, 5);
INSERT INTO public.students_subjects VALUES (12, 37, 1);
INSERT INTO public.students_subjects VALUES (12, 37, 2);
INSERT INTO public.students_subjects VALUES (12, 37, 3);
INSERT INTO public.students_subjects VALUES (12, 37, 4);
INSERT INTO public.students_subjects VALUES (12, 37, 5);
INSERT INTO public.students_subjects VALUES (12, 27, 3);
INSERT INTO public.students_subjects VALUES (12, 27, 4);
INSERT INTO public.students_subjects VALUES (12, 27, 5);
INSERT INTO public.students_subjects VALUES (12, 14, 3);
INSERT INTO public.students_subjects VALUES (12, 14, 4);
INSERT INTO public.students_subjects VALUES (12, 14, 5);
INSERT INTO public.students_subjects VALUES (13, 11, 1);
INSERT INTO public.students_subjects VALUES (13, 11, 2);
INSERT INTO public.students_subjects VALUES (13, 11, 3);
INSERT INTO public.students_subjects VALUES (13, 11, 4);
INSERT INTO public.students_subjects VALUES (13, 11, 5);
INSERT INTO public.students_subjects VALUES (13, 13, 1);
INSERT INTO public.students_subjects VALUES (13, 13, 2);
INSERT INTO public.students_subjects VALUES (13, 13, 3);
INSERT INTO public.students_subjects VALUES (13, 13, 4);
INSERT INTO public.students_subjects VALUES (13, 13, 5);
INSERT INTO public.students_subjects VALUES (13, 20, 1);
INSERT INTO public.students_subjects VALUES (13, 20, 2);
INSERT INTO public.students_subjects VALUES (13, 20, 3);
INSERT INTO public.students_subjects VALUES (13, 20, 4);
INSERT INTO public.students_subjects VALUES (13, 20, 5);
INSERT INTO public.students_subjects VALUES (13, 31, 1);
INSERT INTO public.students_subjects VALUES (13, 31, 2);
INSERT INTO public.students_subjects VALUES (13, 31, 3);
INSERT INTO public.students_subjects VALUES (13, 31, 4);
INSERT INTO public.students_subjects VALUES (13, 31, 5);
INSERT INTO public.students_subjects VALUES (13, 32, 1);
INSERT INTO public.students_subjects VALUES (13, 32, 2);
INSERT INTO public.students_subjects VALUES (13, 32, 3);
INSERT INTO public.students_subjects VALUES (13, 32, 4);
INSERT INTO public.students_subjects VALUES (13, 32, 5);
INSERT INTO public.students_subjects VALUES (13, 34, 1);
INSERT INTO public.students_subjects VALUES (13, 34, 2);
INSERT INTO public.students_subjects VALUES (13, 34, 3);
INSERT INTO public.students_subjects VALUES (13, 34, 4);
INSERT INTO public.students_subjects VALUES (13, 34, 5);
INSERT INTO public.students_subjects VALUES (13, 37, 1);
INSERT INTO public.students_subjects VALUES (13, 37, 2);
INSERT INTO public.students_subjects VALUES (13, 37, 3);
INSERT INTO public.students_subjects VALUES (13, 37, 4);
INSERT INTO public.students_subjects VALUES (13, 37, 5);
INSERT INTO public.students_subjects VALUES (13, 29, 3);
INSERT INTO public.students_subjects VALUES (13, 29, 4);
INSERT INTO public.students_subjects VALUES (13, 29, 5);
INSERT INTO public.students_subjects VALUES (13, 27, 3);
INSERT INTO public.students_subjects VALUES (13, 27, 4);
INSERT INTO public.students_subjects VALUES (13, 27, 5);
INSERT INTO public.students_subjects VALUES (14, 11, 1);
INSERT INTO public.students_subjects VALUES (14, 11, 2);
INSERT INTO public.students_subjects VALUES (14, 11, 3);
INSERT INTO public.students_subjects VALUES (14, 11, 4);
INSERT INTO public.students_subjects VALUES (14, 11, 5);
INSERT INTO public.students_subjects VALUES (14, 13, 1);
INSERT INTO public.students_subjects VALUES (14, 13, 2);
INSERT INTO public.students_subjects VALUES (14, 13, 3);
INSERT INTO public.students_subjects VALUES (14, 13, 4);
INSERT INTO public.students_subjects VALUES (14, 13, 5);
INSERT INTO public.students_subjects VALUES (14, 20, 1);
INSERT INTO public.students_subjects VALUES (14, 20, 2);
INSERT INTO public.students_subjects VALUES (14, 20, 3);
INSERT INTO public.students_subjects VALUES (14, 20, 4);
INSERT INTO public.students_subjects VALUES (14, 20, 5);
INSERT INTO public.students_subjects VALUES (14, 31, 1);
INSERT INTO public.students_subjects VALUES (14, 31, 2);
INSERT INTO public.students_subjects VALUES (14, 31, 3);
INSERT INTO public.students_subjects VALUES (14, 31, 4);
INSERT INTO public.students_subjects VALUES (14, 31, 5);
INSERT INTO public.students_subjects VALUES (14, 32, 1);
INSERT INTO public.students_subjects VALUES (14, 32, 2);
INSERT INTO public.students_subjects VALUES (14, 32, 3);
INSERT INTO public.students_subjects VALUES (14, 32, 4);
INSERT INTO public.students_subjects VALUES (14, 32, 5);
INSERT INTO public.students_subjects VALUES (14, 34, 1);
INSERT INTO public.students_subjects VALUES (14, 34, 2);
INSERT INTO public.students_subjects VALUES (14, 34, 3);
INSERT INTO public.students_subjects VALUES (14, 34, 4);
INSERT INTO public.students_subjects VALUES (14, 34, 5);
INSERT INTO public.students_subjects VALUES (14, 37, 1);
INSERT INTO public.students_subjects VALUES (14, 37, 2);
INSERT INTO public.students_subjects VALUES (14, 37, 3);
INSERT INTO public.students_subjects VALUES (14, 37, 4);
INSERT INTO public.students_subjects VALUES (14, 37, 5);
INSERT INTO public.students_subjects VALUES (14, 29, 3);
INSERT INTO public.students_subjects VALUES (14, 29, 4);
INSERT INTO public.students_subjects VALUES (14, 29, 5);
INSERT INTO public.students_subjects VALUES (14, 14, 3);
INSERT INTO public.students_subjects VALUES (14, 14, 4);
INSERT INTO public.students_subjects VALUES (14, 14, 5);
INSERT INTO public.students_subjects VALUES (15, 11, 1);
INSERT INTO public.students_subjects VALUES (15, 11, 2);
INSERT INTO public.students_subjects VALUES (15, 11, 3);
INSERT INTO public.students_subjects VALUES (15, 11, 4);
INSERT INTO public.students_subjects VALUES (15, 11, 5);
INSERT INTO public.students_subjects VALUES (15, 13, 1);
INSERT INTO public.students_subjects VALUES (15, 13, 2);
INSERT INTO public.students_subjects VALUES (15, 13, 3);
INSERT INTO public.students_subjects VALUES (15, 13, 4);
INSERT INTO public.students_subjects VALUES (15, 13, 5);
INSERT INTO public.students_subjects VALUES (15, 20, 1);
INSERT INTO public.students_subjects VALUES (15, 20, 2);
INSERT INTO public.students_subjects VALUES (15, 20, 3);
INSERT INTO public.students_subjects VALUES (15, 20, 4);
INSERT INTO public.students_subjects VALUES (15, 20, 5);
INSERT INTO public.students_subjects VALUES (15, 31, 1);
INSERT INTO public.students_subjects VALUES (15, 31, 2);
INSERT INTO public.students_subjects VALUES (15, 31, 3);
INSERT INTO public.students_subjects VALUES (15, 31, 4);
INSERT INTO public.students_subjects VALUES (15, 31, 5);
INSERT INTO public.students_subjects VALUES (15, 32, 1);
INSERT INTO public.students_subjects VALUES (15, 32, 2);
INSERT INTO public.students_subjects VALUES (15, 32, 3);
INSERT INTO public.students_subjects VALUES (15, 32, 4);
INSERT INTO public.students_subjects VALUES (15, 32, 5);
INSERT INTO public.students_subjects VALUES (15, 34, 1);
INSERT INTO public.students_subjects VALUES (15, 34, 2);
INSERT INTO public.students_subjects VALUES (15, 34, 3);
INSERT INTO public.students_subjects VALUES (15, 34, 4);
INSERT INTO public.students_subjects VALUES (15, 34, 5);
INSERT INTO public.students_subjects VALUES (15, 37, 1);
INSERT INTO public.students_subjects VALUES (15, 37, 2);
INSERT INTO public.students_subjects VALUES (15, 37, 3);
INSERT INTO public.students_subjects VALUES (15, 37, 4);
INSERT INTO public.students_subjects VALUES (15, 37, 5);
INSERT INTO public.students_subjects VALUES (15, 28, 3);
INSERT INTO public.students_subjects VALUES (15, 28, 4);
INSERT INTO public.students_subjects VALUES (15, 28, 5);
INSERT INTO public.students_subjects VALUES (15, 22, 3);
INSERT INTO public.students_subjects VALUES (15, 22, 4);
INSERT INTO public.students_subjects VALUES (15, 22, 5);
INSERT INTO public.students_subjects VALUES (16, 11, 1);
INSERT INTO public.students_subjects VALUES (16, 11, 2);
INSERT INTO public.students_subjects VALUES (16, 11, 3);
INSERT INTO public.students_subjects VALUES (16, 11, 4);
INSERT INTO public.students_subjects VALUES (16, 11, 5);
INSERT INTO public.students_subjects VALUES (16, 13, 1);
INSERT INTO public.students_subjects VALUES (16, 13, 2);
INSERT INTO public.students_subjects VALUES (16, 13, 3);
INSERT INTO public.students_subjects VALUES (16, 13, 4);
INSERT INTO public.students_subjects VALUES (16, 13, 5);
INSERT INTO public.students_subjects VALUES (16, 20, 1);
INSERT INTO public.students_subjects VALUES (16, 20, 2);
INSERT INTO public.students_subjects VALUES (16, 20, 3);
INSERT INTO public.students_subjects VALUES (16, 20, 4);
INSERT INTO public.students_subjects VALUES (16, 20, 5);
INSERT INTO public.students_subjects VALUES (16, 31, 1);
INSERT INTO public.students_subjects VALUES (16, 31, 2);
INSERT INTO public.students_subjects VALUES (16, 31, 3);
INSERT INTO public.students_subjects VALUES (16, 31, 4);
INSERT INTO public.students_subjects VALUES (16, 31, 5);
INSERT INTO public.students_subjects VALUES (16, 32, 1);
INSERT INTO public.students_subjects VALUES (16, 32, 2);
INSERT INTO public.students_subjects VALUES (16, 32, 3);
INSERT INTO public.students_subjects VALUES (16, 32, 4);
INSERT INTO public.students_subjects VALUES (16, 32, 5);
INSERT INTO public.students_subjects VALUES (16, 34, 1);
INSERT INTO public.students_subjects VALUES (16, 34, 2);
INSERT INTO public.students_subjects VALUES (16, 34, 3);
INSERT INTO public.students_subjects VALUES (16, 34, 4);
INSERT INTO public.students_subjects VALUES (16, 34, 5);
INSERT INTO public.students_subjects VALUES (16, 37, 1);
INSERT INTO public.students_subjects VALUES (16, 37, 2);
INSERT INTO public.students_subjects VALUES (16, 37, 3);
INSERT INTO public.students_subjects VALUES (16, 37, 4);
INSERT INTO public.students_subjects VALUES (16, 37, 5);
INSERT INTO public.students_subjects VALUES (16, 29, 3);
INSERT INTO public.students_subjects VALUES (16, 29, 4);
INSERT INTO public.students_subjects VALUES (16, 29, 5);
INSERT INTO public.students_subjects VALUES (16, 28, 3);
INSERT INTO public.students_subjects VALUES (16, 28, 4);
INSERT INTO public.students_subjects VALUES (16, 28, 5);
INSERT INTO public.students_subjects VALUES (17, 11, 1);
INSERT INTO public.students_subjects VALUES (17, 11, 2);
INSERT INTO public.students_subjects VALUES (17, 11, 3);
INSERT INTO public.students_subjects VALUES (17, 11, 4);
INSERT INTO public.students_subjects VALUES (17, 11, 5);
INSERT INTO public.students_subjects VALUES (17, 13, 1);
INSERT INTO public.students_subjects VALUES (17, 13, 2);
INSERT INTO public.students_subjects VALUES (17, 13, 3);
INSERT INTO public.students_subjects VALUES (17, 13, 4);
INSERT INTO public.students_subjects VALUES (17, 13, 5);
INSERT INTO public.students_subjects VALUES (17, 20, 1);
INSERT INTO public.students_subjects VALUES (17, 20, 2);
INSERT INTO public.students_subjects VALUES (17, 20, 3);
INSERT INTO public.students_subjects VALUES (17, 20, 4);
INSERT INTO public.students_subjects VALUES (17, 20, 5);
INSERT INTO public.students_subjects VALUES (17, 31, 1);
INSERT INTO public.students_subjects VALUES (17, 31, 2);
INSERT INTO public.students_subjects VALUES (17, 31, 3);
INSERT INTO public.students_subjects VALUES (17, 31, 4);
INSERT INTO public.students_subjects VALUES (17, 31, 5);
INSERT INTO public.students_subjects VALUES (17, 32, 1);
INSERT INTO public.students_subjects VALUES (17, 32, 2);
INSERT INTO public.students_subjects VALUES (17, 32, 3);
INSERT INTO public.students_subjects VALUES (17, 32, 4);
INSERT INTO public.students_subjects VALUES (17, 32, 5);
INSERT INTO public.students_subjects VALUES (17, 34, 1);
INSERT INTO public.students_subjects VALUES (17, 34, 2);
INSERT INTO public.students_subjects VALUES (17, 34, 3);
INSERT INTO public.students_subjects VALUES (17, 34, 4);
INSERT INTO public.students_subjects VALUES (17, 34, 5);
INSERT INTO public.students_subjects VALUES (17, 37, 1);
INSERT INTO public.students_subjects VALUES (17, 37, 2);
INSERT INTO public.students_subjects VALUES (17, 37, 3);
INSERT INTO public.students_subjects VALUES (17, 37, 4);
INSERT INTO public.students_subjects VALUES (17, 37, 5);
INSERT INTO public.students_subjects VALUES (17, 22, 3);
INSERT INTO public.students_subjects VALUES (17, 22, 4);
INSERT INTO public.students_subjects VALUES (17, 22, 5);
INSERT INTO public.students_subjects VALUES (17, 27, 3);
INSERT INTO public.students_subjects VALUES (17, 27, 4);
INSERT INTO public.students_subjects VALUES (17, 27, 5);
INSERT INTO public.students_subjects VALUES (18, 11, 1);
INSERT INTO public.students_subjects VALUES (18, 11, 2);
INSERT INTO public.students_subjects VALUES (18, 11, 3);
INSERT INTO public.students_subjects VALUES (18, 11, 4);
INSERT INTO public.students_subjects VALUES (18, 11, 5);
INSERT INTO public.students_subjects VALUES (18, 13, 1);
INSERT INTO public.students_subjects VALUES (18, 13, 2);
INSERT INTO public.students_subjects VALUES (18, 13, 3);
INSERT INTO public.students_subjects VALUES (18, 13, 4);
INSERT INTO public.students_subjects VALUES (18, 13, 5);
INSERT INTO public.students_subjects VALUES (18, 20, 1);
INSERT INTO public.students_subjects VALUES (18, 20, 2);
INSERT INTO public.students_subjects VALUES (18, 20, 3);
INSERT INTO public.students_subjects VALUES (18, 20, 4);
INSERT INTO public.students_subjects VALUES (18, 20, 5);
INSERT INTO public.students_subjects VALUES (18, 31, 1);
INSERT INTO public.students_subjects VALUES (18, 31, 2);
INSERT INTO public.students_subjects VALUES (18, 31, 3);
INSERT INTO public.students_subjects VALUES (18, 31, 4);
INSERT INTO public.students_subjects VALUES (18, 31, 5);
INSERT INTO public.students_subjects VALUES (18, 32, 1);
INSERT INTO public.students_subjects VALUES (18, 32, 2);
INSERT INTO public.students_subjects VALUES (18, 32, 3);
INSERT INTO public.students_subjects VALUES (18, 32, 4);
INSERT INTO public.students_subjects VALUES (18, 32, 5);
INSERT INTO public.students_subjects VALUES (18, 34, 1);
INSERT INTO public.students_subjects VALUES (18, 34, 2);
INSERT INTO public.students_subjects VALUES (18, 34, 3);
INSERT INTO public.students_subjects VALUES (18, 34, 4);
INSERT INTO public.students_subjects VALUES (18, 34, 5);
INSERT INTO public.students_subjects VALUES (18, 37, 1);
INSERT INTO public.students_subjects VALUES (18, 37, 2);
INSERT INTO public.students_subjects VALUES (18, 37, 3);
INSERT INTO public.students_subjects VALUES (18, 37, 4);
INSERT INTO public.students_subjects VALUES (18, 37, 5);
INSERT INTO public.students_subjects VALUES (18, 27, 3);
INSERT INTO public.students_subjects VALUES (18, 27, 4);
INSERT INTO public.students_subjects VALUES (18, 27, 5);
INSERT INTO public.students_subjects VALUES (18, 14, 3);
INSERT INTO public.students_subjects VALUES (18, 14, 4);
INSERT INTO public.students_subjects VALUES (18, 14, 5);
INSERT INTO public.students_subjects VALUES (19, 11, 1);
INSERT INTO public.students_subjects VALUES (19, 11, 2);
INSERT INTO public.students_subjects VALUES (19, 11, 3);
INSERT INTO public.students_subjects VALUES (19, 11, 4);
INSERT INTO public.students_subjects VALUES (19, 11, 5);
INSERT INTO public.students_subjects VALUES (19, 13, 1);
INSERT INTO public.students_subjects VALUES (19, 13, 2);
INSERT INTO public.students_subjects VALUES (19, 13, 3);
INSERT INTO public.students_subjects VALUES (19, 13, 4);
INSERT INTO public.students_subjects VALUES (19, 13, 5);
INSERT INTO public.students_subjects VALUES (19, 20, 1);
INSERT INTO public.students_subjects VALUES (19, 20, 2);
INSERT INTO public.students_subjects VALUES (19, 20, 3);
INSERT INTO public.students_subjects VALUES (19, 20, 4);
INSERT INTO public.students_subjects VALUES (19, 20, 5);
INSERT INTO public.students_subjects VALUES (19, 31, 1);
INSERT INTO public.students_subjects VALUES (19, 31, 2);
INSERT INTO public.students_subjects VALUES (19, 31, 3);
INSERT INTO public.students_subjects VALUES (19, 31, 4);
INSERT INTO public.students_subjects VALUES (19, 31, 5);
INSERT INTO public.students_subjects VALUES (19, 32, 1);
INSERT INTO public.students_subjects VALUES (19, 32, 2);
INSERT INTO public.students_subjects VALUES (19, 32, 3);
INSERT INTO public.students_subjects VALUES (19, 32, 4);
INSERT INTO public.students_subjects VALUES (19, 32, 5);
INSERT INTO public.students_subjects VALUES (19, 34, 1);
INSERT INTO public.students_subjects VALUES (19, 34, 2);
INSERT INTO public.students_subjects VALUES (19, 34, 3);
INSERT INTO public.students_subjects VALUES (19, 34, 4);
INSERT INTO public.students_subjects VALUES (19, 34, 5);
INSERT INTO public.students_subjects VALUES (19, 37, 1);
INSERT INTO public.students_subjects VALUES (19, 37, 2);
INSERT INTO public.students_subjects VALUES (19, 37, 3);
INSERT INTO public.students_subjects VALUES (19, 37, 4);
INSERT INTO public.students_subjects VALUES (19, 37, 5);
INSERT INTO public.students_subjects VALUES (19, 28, 3);
INSERT INTO public.students_subjects VALUES (19, 28, 4);
INSERT INTO public.students_subjects VALUES (19, 28, 5);
INSERT INTO public.students_subjects VALUES (19, 22, 3);
INSERT INTO public.students_subjects VALUES (19, 22, 4);
INSERT INTO public.students_subjects VALUES (19, 22, 5);
INSERT INTO public.students_subjects VALUES (20, 11, 1);
INSERT INTO public.students_subjects VALUES (20, 11, 2);
INSERT INTO public.students_subjects VALUES (20, 11, 3);
INSERT INTO public.students_subjects VALUES (20, 11, 4);
INSERT INTO public.students_subjects VALUES (20, 11, 5);
INSERT INTO public.students_subjects VALUES (20, 13, 1);
INSERT INTO public.students_subjects VALUES (20, 13, 2);
INSERT INTO public.students_subjects VALUES (20, 13, 3);
INSERT INTO public.students_subjects VALUES (20, 13, 4);
INSERT INTO public.students_subjects VALUES (20, 13, 5);
INSERT INTO public.students_subjects VALUES (20, 20, 1);
INSERT INTO public.students_subjects VALUES (20, 20, 2);
INSERT INTO public.students_subjects VALUES (20, 20, 3);
INSERT INTO public.students_subjects VALUES (20, 20, 4);
INSERT INTO public.students_subjects VALUES (20, 20, 5);
INSERT INTO public.students_subjects VALUES (20, 31, 1);
INSERT INTO public.students_subjects VALUES (20, 31, 2);
INSERT INTO public.students_subjects VALUES (20, 31, 3);
INSERT INTO public.students_subjects VALUES (20, 31, 4);
INSERT INTO public.students_subjects VALUES (20, 31, 5);
INSERT INTO public.students_subjects VALUES (20, 32, 1);
INSERT INTO public.students_subjects VALUES (20, 32, 2);
INSERT INTO public.students_subjects VALUES (20, 32, 3);
INSERT INTO public.students_subjects VALUES (20, 32, 4);
INSERT INTO public.students_subjects VALUES (20, 32, 5);
INSERT INTO public.students_subjects VALUES (20, 34, 1);
INSERT INTO public.students_subjects VALUES (20, 34, 2);
INSERT INTO public.students_subjects VALUES (20, 34, 3);
INSERT INTO public.students_subjects VALUES (20, 34, 4);
INSERT INTO public.students_subjects VALUES (20, 34, 5);
INSERT INTO public.students_subjects VALUES (20, 37, 1);
INSERT INTO public.students_subjects VALUES (20, 37, 2);
INSERT INTO public.students_subjects VALUES (20, 37, 3);
INSERT INTO public.students_subjects VALUES (20, 37, 4);
INSERT INTO public.students_subjects VALUES (20, 37, 5);
INSERT INTO public.students_subjects VALUES (20, 28, 3);
INSERT INTO public.students_subjects VALUES (20, 28, 4);
INSERT INTO public.students_subjects VALUES (20, 28, 5);
INSERT INTO public.students_subjects VALUES (20, 22, 3);
INSERT INTO public.students_subjects VALUES (20, 22, 4);
INSERT INTO public.students_subjects VALUES (20, 22, 5);
INSERT INTO public.students_subjects VALUES (21, 11, 1);
INSERT INTO public.students_subjects VALUES (21, 11, 2);
INSERT INTO public.students_subjects VALUES (21, 11, 3);
INSERT INTO public.students_subjects VALUES (21, 11, 4);
INSERT INTO public.students_subjects VALUES (21, 11, 5);
INSERT INTO public.students_subjects VALUES (21, 13, 1);
INSERT INTO public.students_subjects VALUES (21, 13, 2);
INSERT INTO public.students_subjects VALUES (21, 13, 3);
INSERT INTO public.students_subjects VALUES (21, 13, 4);
INSERT INTO public.students_subjects VALUES (21, 13, 5);
INSERT INTO public.students_subjects VALUES (21, 20, 1);
INSERT INTO public.students_subjects VALUES (21, 20, 2);
INSERT INTO public.students_subjects VALUES (21, 20, 3);
INSERT INTO public.students_subjects VALUES (21, 20, 4);
INSERT INTO public.students_subjects VALUES (21, 20, 5);
INSERT INTO public.students_subjects VALUES (21, 31, 1);
INSERT INTO public.students_subjects VALUES (21, 31, 2);
INSERT INTO public.students_subjects VALUES (21, 31, 3);
INSERT INTO public.students_subjects VALUES (21, 31, 4);
INSERT INTO public.students_subjects VALUES (21, 31, 5);
INSERT INTO public.students_subjects VALUES (21, 32, 1);
INSERT INTO public.students_subjects VALUES (21, 32, 2);
INSERT INTO public.students_subjects VALUES (21, 32, 3);
INSERT INTO public.students_subjects VALUES (21, 32, 4);
INSERT INTO public.students_subjects VALUES (21, 32, 5);
INSERT INTO public.students_subjects VALUES (21, 34, 1);
INSERT INTO public.students_subjects VALUES (21, 34, 2);
INSERT INTO public.students_subjects VALUES (21, 34, 3);
INSERT INTO public.students_subjects VALUES (21, 34, 4);
INSERT INTO public.students_subjects VALUES (21, 34, 5);
INSERT INTO public.students_subjects VALUES (21, 37, 1);
INSERT INTO public.students_subjects VALUES (21, 37, 2);
INSERT INTO public.students_subjects VALUES (21, 37, 3);
INSERT INTO public.students_subjects VALUES (21, 37, 4);
INSERT INTO public.students_subjects VALUES (21, 37, 5);
INSERT INTO public.students_subjects VALUES (21, 27, 3);
INSERT INTO public.students_subjects VALUES (21, 27, 4);
INSERT INTO public.students_subjects VALUES (21, 27, 5);
INSERT INTO public.students_subjects VALUES (21, 28, 3);
INSERT INTO public.students_subjects VALUES (21, 28, 4);
INSERT INTO public.students_subjects VALUES (21, 28, 5);
INSERT INTO public.students_subjects VALUES (22, 11, 1);
INSERT INTO public.students_subjects VALUES (22, 11, 2);
INSERT INTO public.students_subjects VALUES (22, 11, 3);
INSERT INTO public.students_subjects VALUES (22, 11, 4);
INSERT INTO public.students_subjects VALUES (22, 11, 5);
INSERT INTO public.students_subjects VALUES (22, 13, 1);
INSERT INTO public.students_subjects VALUES (22, 13, 2);
INSERT INTO public.students_subjects VALUES (22, 13, 3);
INSERT INTO public.students_subjects VALUES (22, 13, 4);
INSERT INTO public.students_subjects VALUES (22, 13, 5);
INSERT INTO public.students_subjects VALUES (22, 20, 1);
INSERT INTO public.students_subjects VALUES (22, 20, 2);
INSERT INTO public.students_subjects VALUES (22, 20, 3);
INSERT INTO public.students_subjects VALUES (22, 20, 4);
INSERT INTO public.students_subjects VALUES (22, 20, 5);
INSERT INTO public.students_subjects VALUES (22, 31, 1);
INSERT INTO public.students_subjects VALUES (22, 31, 2);
INSERT INTO public.students_subjects VALUES (22, 31, 3);
INSERT INTO public.students_subjects VALUES (22, 31, 4);
INSERT INTO public.students_subjects VALUES (22, 31, 5);
INSERT INTO public.students_subjects VALUES (22, 32, 1);
INSERT INTO public.students_subjects VALUES (22, 32, 2);
INSERT INTO public.students_subjects VALUES (22, 32, 3);
INSERT INTO public.students_subjects VALUES (22, 32, 4);
INSERT INTO public.students_subjects VALUES (22, 32, 5);
INSERT INTO public.students_subjects VALUES (22, 34, 1);
INSERT INTO public.students_subjects VALUES (22, 34, 2);
INSERT INTO public.students_subjects VALUES (22, 34, 3);
INSERT INTO public.students_subjects VALUES (22, 34, 4);
INSERT INTO public.students_subjects VALUES (22, 34, 5);
INSERT INTO public.students_subjects VALUES (22, 37, 1);
INSERT INTO public.students_subjects VALUES (22, 37, 2);
INSERT INTO public.students_subjects VALUES (22, 37, 3);
INSERT INTO public.students_subjects VALUES (22, 37, 4);
INSERT INTO public.students_subjects VALUES (22, 37, 5);
INSERT INTO public.students_subjects VALUES (22, 29, 3);
INSERT INTO public.students_subjects VALUES (22, 29, 4);
INSERT INTO public.students_subjects VALUES (22, 29, 5);
INSERT INTO public.students_subjects VALUES (22, 22, 3);
INSERT INTO public.students_subjects VALUES (22, 22, 4);
INSERT INTO public.students_subjects VALUES (22, 22, 5);
INSERT INTO public.students_subjects VALUES (23, 11, 1);
INSERT INTO public.students_subjects VALUES (23, 11, 2);
INSERT INTO public.students_subjects VALUES (23, 11, 3);
INSERT INTO public.students_subjects VALUES (23, 11, 4);
INSERT INTO public.students_subjects VALUES (23, 11, 5);
INSERT INTO public.students_subjects VALUES (23, 13, 1);
INSERT INTO public.students_subjects VALUES (23, 13, 2);
INSERT INTO public.students_subjects VALUES (23, 13, 3);
INSERT INTO public.students_subjects VALUES (23, 13, 4);
INSERT INTO public.students_subjects VALUES (23, 13, 5);
INSERT INTO public.students_subjects VALUES (23, 20, 1);
INSERT INTO public.students_subjects VALUES (23, 20, 2);
INSERT INTO public.students_subjects VALUES (23, 20, 3);
INSERT INTO public.students_subjects VALUES (23, 20, 4);
INSERT INTO public.students_subjects VALUES (23, 20, 5);
INSERT INTO public.students_subjects VALUES (23, 31, 1);
INSERT INTO public.students_subjects VALUES (23, 31, 2);
INSERT INTO public.students_subjects VALUES (23, 31, 3);
INSERT INTO public.students_subjects VALUES (23, 31, 4);
INSERT INTO public.students_subjects VALUES (23, 31, 5);
INSERT INTO public.students_subjects VALUES (23, 32, 1);
INSERT INTO public.students_subjects VALUES (23, 32, 2);
INSERT INTO public.students_subjects VALUES (23, 32, 3);
INSERT INTO public.students_subjects VALUES (23, 32, 4);
INSERT INTO public.students_subjects VALUES (23, 32, 5);
INSERT INTO public.students_subjects VALUES (23, 34, 1);
INSERT INTO public.students_subjects VALUES (23, 34, 2);
INSERT INTO public.students_subjects VALUES (23, 34, 3);
INSERT INTO public.students_subjects VALUES (23, 34, 4);
INSERT INTO public.students_subjects VALUES (23, 34, 5);
INSERT INTO public.students_subjects VALUES (23, 37, 1);
INSERT INTO public.students_subjects VALUES (23, 37, 2);
INSERT INTO public.students_subjects VALUES (23, 37, 3);
INSERT INTO public.students_subjects VALUES (23, 37, 4);
INSERT INTO public.students_subjects VALUES (23, 37, 5);
INSERT INTO public.students_subjects VALUES (23, 14, 3);
INSERT INTO public.students_subjects VALUES (23, 14, 4);
INSERT INTO public.students_subjects VALUES (23, 14, 5);
INSERT INTO public.students_subjects VALUES (23, 22, 3);
INSERT INTO public.students_subjects VALUES (23, 22, 4);
INSERT INTO public.students_subjects VALUES (23, 22, 5);
INSERT INTO public.students_subjects VALUES (24, 11, 1);
INSERT INTO public.students_subjects VALUES (24, 11, 2);
INSERT INTO public.students_subjects VALUES (24, 11, 3);
INSERT INTO public.students_subjects VALUES (24, 11, 4);
INSERT INTO public.students_subjects VALUES (24, 11, 5);
INSERT INTO public.students_subjects VALUES (24, 13, 1);
INSERT INTO public.students_subjects VALUES (24, 13, 2);
INSERT INTO public.students_subjects VALUES (24, 13, 3);
INSERT INTO public.students_subjects VALUES (24, 13, 4);
INSERT INTO public.students_subjects VALUES (24, 13, 5);
INSERT INTO public.students_subjects VALUES (24, 20, 1);
INSERT INTO public.students_subjects VALUES (24, 20, 2);
INSERT INTO public.students_subjects VALUES (24, 20, 3);
INSERT INTO public.students_subjects VALUES (24, 20, 4);
INSERT INTO public.students_subjects VALUES (24, 20, 5);
INSERT INTO public.students_subjects VALUES (24, 31, 1);
INSERT INTO public.students_subjects VALUES (24, 31, 2);
INSERT INTO public.students_subjects VALUES (24, 31, 3);
INSERT INTO public.students_subjects VALUES (24, 31, 4);
INSERT INTO public.students_subjects VALUES (24, 31, 5);
INSERT INTO public.students_subjects VALUES (24, 32, 1);
INSERT INTO public.students_subjects VALUES (24, 32, 2);
INSERT INTO public.students_subjects VALUES (24, 32, 3);
INSERT INTO public.students_subjects VALUES (24, 32, 4);
INSERT INTO public.students_subjects VALUES (24, 32, 5);
INSERT INTO public.students_subjects VALUES (24, 34, 1);
INSERT INTO public.students_subjects VALUES (24, 34, 2);
INSERT INTO public.students_subjects VALUES (24, 34, 3);
INSERT INTO public.students_subjects VALUES (24, 34, 4);
INSERT INTO public.students_subjects VALUES (24, 34, 5);
INSERT INTO public.students_subjects VALUES (24, 37, 1);
INSERT INTO public.students_subjects VALUES (24, 37, 2);
INSERT INTO public.students_subjects VALUES (24, 37, 3);
INSERT INTO public.students_subjects VALUES (24, 37, 4);
INSERT INTO public.students_subjects VALUES (24, 37, 5);
INSERT INTO public.students_subjects VALUES (24, 22, 3);
INSERT INTO public.students_subjects VALUES (24, 22, 4);
INSERT INTO public.students_subjects VALUES (24, 22, 5);
INSERT INTO public.students_subjects VALUES (24, 14, 3);
INSERT INTO public.students_subjects VALUES (24, 14, 4);
INSERT INTO public.students_subjects VALUES (24, 14, 5);
INSERT INTO public.students_subjects VALUES (25, 11, 1);
INSERT INTO public.students_subjects VALUES (25, 11, 2);
INSERT INTO public.students_subjects VALUES (25, 11, 3);
INSERT INTO public.students_subjects VALUES (25, 11, 4);
INSERT INTO public.students_subjects VALUES (25, 11, 5);
INSERT INTO public.students_subjects VALUES (25, 13, 1);
INSERT INTO public.students_subjects VALUES (25, 13, 2);
INSERT INTO public.students_subjects VALUES (25, 13, 3);
INSERT INTO public.students_subjects VALUES (25, 13, 4);
INSERT INTO public.students_subjects VALUES (25, 13, 5);
INSERT INTO public.students_subjects VALUES (25, 20, 1);
INSERT INTO public.students_subjects VALUES (25, 20, 2);
INSERT INTO public.students_subjects VALUES (25, 20, 3);
INSERT INTO public.students_subjects VALUES (25, 20, 4);
INSERT INTO public.students_subjects VALUES (25, 20, 5);
INSERT INTO public.students_subjects VALUES (25, 31, 1);
INSERT INTO public.students_subjects VALUES (25, 31, 2);
INSERT INTO public.students_subjects VALUES (25, 31, 3);
INSERT INTO public.students_subjects VALUES (25, 31, 4);
INSERT INTO public.students_subjects VALUES (25, 31, 5);
INSERT INTO public.students_subjects VALUES (25, 32, 1);
INSERT INTO public.students_subjects VALUES (25, 32, 2);
INSERT INTO public.students_subjects VALUES (25, 32, 3);
INSERT INTO public.students_subjects VALUES (25, 32, 4);
INSERT INTO public.students_subjects VALUES (25, 32, 5);
INSERT INTO public.students_subjects VALUES (25, 34, 1);
INSERT INTO public.students_subjects VALUES (25, 34, 2);
INSERT INTO public.students_subjects VALUES (25, 34, 3);
INSERT INTO public.students_subjects VALUES (25, 34, 4);
INSERT INTO public.students_subjects VALUES (25, 34, 5);
INSERT INTO public.students_subjects VALUES (25, 37, 1);
INSERT INTO public.students_subjects VALUES (25, 37, 2);
INSERT INTO public.students_subjects VALUES (25, 37, 3);
INSERT INTO public.students_subjects VALUES (25, 37, 4);
INSERT INTO public.students_subjects VALUES (25, 37, 5);
INSERT INTO public.students_subjects VALUES (25, 28, 3);
INSERT INTO public.students_subjects VALUES (25, 28, 4);
INSERT INTO public.students_subjects VALUES (25, 28, 5);
INSERT INTO public.students_subjects VALUES (25, 27, 3);
INSERT INTO public.students_subjects VALUES (25, 27, 4);
INSERT INTO public.students_subjects VALUES (25, 27, 5);
INSERT INTO public.students_subjects VALUES (26, 11, 1);
INSERT INTO public.students_subjects VALUES (26, 11, 2);
INSERT INTO public.students_subjects VALUES (26, 11, 3);
INSERT INTO public.students_subjects VALUES (26, 11, 4);
INSERT INTO public.students_subjects VALUES (26, 11, 5);
INSERT INTO public.students_subjects VALUES (26, 13, 1);
INSERT INTO public.students_subjects VALUES (26, 13, 2);
INSERT INTO public.students_subjects VALUES (26, 13, 3);
INSERT INTO public.students_subjects VALUES (26, 13, 4);
INSERT INTO public.students_subjects VALUES (26, 13, 5);
INSERT INTO public.students_subjects VALUES (26, 20, 1);
INSERT INTO public.students_subjects VALUES (26, 20, 2);
INSERT INTO public.students_subjects VALUES (26, 20, 3);
INSERT INTO public.students_subjects VALUES (26, 20, 4);
INSERT INTO public.students_subjects VALUES (26, 20, 5);
INSERT INTO public.students_subjects VALUES (26, 31, 1);
INSERT INTO public.students_subjects VALUES (26, 31, 2);
INSERT INTO public.students_subjects VALUES (26, 31, 3);
INSERT INTO public.students_subjects VALUES (26, 31, 4);
INSERT INTO public.students_subjects VALUES (26, 31, 5);
INSERT INTO public.students_subjects VALUES (26, 32, 1);
INSERT INTO public.students_subjects VALUES (26, 32, 2);
INSERT INTO public.students_subjects VALUES (26, 32, 3);
INSERT INTO public.students_subjects VALUES (26, 32, 4);
INSERT INTO public.students_subjects VALUES (26, 32, 5);
INSERT INTO public.students_subjects VALUES (26, 34, 1);
INSERT INTO public.students_subjects VALUES (26, 34, 2);
INSERT INTO public.students_subjects VALUES (26, 34, 3);
INSERT INTO public.students_subjects VALUES (26, 34, 4);
INSERT INTO public.students_subjects VALUES (26, 34, 5);
INSERT INTO public.students_subjects VALUES (26, 37, 1);
INSERT INTO public.students_subjects VALUES (26, 37, 2);
INSERT INTO public.students_subjects VALUES (26, 37, 3);
INSERT INTO public.students_subjects VALUES (26, 37, 4);
INSERT INTO public.students_subjects VALUES (26, 37, 5);
INSERT INTO public.students_subjects VALUES (26, 22, 3);
INSERT INTO public.students_subjects VALUES (26, 22, 4);
INSERT INTO public.students_subjects VALUES (26, 22, 5);
INSERT INTO public.students_subjects VALUES (26, 28, 3);
INSERT INTO public.students_subjects VALUES (26, 28, 4);
INSERT INTO public.students_subjects VALUES (26, 28, 5);
INSERT INTO public.students_subjects VALUES (27, 11, 1);
INSERT INTO public.students_subjects VALUES (27, 11, 2);
INSERT INTO public.students_subjects VALUES (27, 11, 3);
INSERT INTO public.students_subjects VALUES (27, 11, 4);
INSERT INTO public.students_subjects VALUES (27, 11, 5);
INSERT INTO public.students_subjects VALUES (27, 13, 1);
INSERT INTO public.students_subjects VALUES (27, 13, 2);
INSERT INTO public.students_subjects VALUES (27, 13, 3);
INSERT INTO public.students_subjects VALUES (27, 13, 4);
INSERT INTO public.students_subjects VALUES (27, 13, 5);
INSERT INTO public.students_subjects VALUES (27, 20, 1);
INSERT INTO public.students_subjects VALUES (27, 20, 2);
INSERT INTO public.students_subjects VALUES (27, 20, 3);
INSERT INTO public.students_subjects VALUES (27, 20, 4);
INSERT INTO public.students_subjects VALUES (27, 20, 5);
INSERT INTO public.students_subjects VALUES (27, 31, 1);
INSERT INTO public.students_subjects VALUES (27, 31, 2);
INSERT INTO public.students_subjects VALUES (27, 31, 3);
INSERT INTO public.students_subjects VALUES (27, 31, 4);
INSERT INTO public.students_subjects VALUES (27, 31, 5);
INSERT INTO public.students_subjects VALUES (27, 32, 1);
INSERT INTO public.students_subjects VALUES (27, 32, 2);
INSERT INTO public.students_subjects VALUES (27, 32, 3);
INSERT INTO public.students_subjects VALUES (27, 32, 4);
INSERT INTO public.students_subjects VALUES (27, 32, 5);
INSERT INTO public.students_subjects VALUES (27, 34, 1);
INSERT INTO public.students_subjects VALUES (27, 34, 2);
INSERT INTO public.students_subjects VALUES (27, 34, 3);
INSERT INTO public.students_subjects VALUES (27, 34, 4);
INSERT INTO public.students_subjects VALUES (27, 34, 5);
INSERT INTO public.students_subjects VALUES (27, 37, 1);
INSERT INTO public.students_subjects VALUES (27, 37, 2);
INSERT INTO public.students_subjects VALUES (27, 37, 3);
INSERT INTO public.students_subjects VALUES (27, 37, 4);
INSERT INTO public.students_subjects VALUES (27, 37, 5);
INSERT INTO public.students_subjects VALUES (27, 14, 3);
INSERT INTO public.students_subjects VALUES (27, 14, 4);
INSERT INTO public.students_subjects VALUES (27, 14, 5);
INSERT INTO public.students_subjects VALUES (27, 22, 3);
INSERT INTO public.students_subjects VALUES (27, 22, 4);
INSERT INTO public.students_subjects VALUES (27, 22, 5);
INSERT INTO public.students_subjects VALUES (28, 11, 1);
INSERT INTO public.students_subjects VALUES (28, 11, 2);
INSERT INTO public.students_subjects VALUES (28, 11, 3);
INSERT INTO public.students_subjects VALUES (28, 11, 4);
INSERT INTO public.students_subjects VALUES (28, 11, 5);
INSERT INTO public.students_subjects VALUES (28, 13, 1);
INSERT INTO public.students_subjects VALUES (28, 13, 2);
INSERT INTO public.students_subjects VALUES (28, 13, 3);
INSERT INTO public.students_subjects VALUES (28, 13, 4);
INSERT INTO public.students_subjects VALUES (28, 13, 5);
INSERT INTO public.students_subjects VALUES (28, 20, 1);
INSERT INTO public.students_subjects VALUES (28, 20, 2);
INSERT INTO public.students_subjects VALUES (28, 20, 3);
INSERT INTO public.students_subjects VALUES (28, 20, 4);
INSERT INTO public.students_subjects VALUES (28, 20, 5);
INSERT INTO public.students_subjects VALUES (28, 31, 1);
INSERT INTO public.students_subjects VALUES (28, 31, 2);
INSERT INTO public.students_subjects VALUES (28, 31, 3);
INSERT INTO public.students_subjects VALUES (28, 31, 4);
INSERT INTO public.students_subjects VALUES (28, 31, 5);
INSERT INTO public.students_subjects VALUES (28, 32, 1);
INSERT INTO public.students_subjects VALUES (28, 32, 2);
INSERT INTO public.students_subjects VALUES (28, 32, 3);
INSERT INTO public.students_subjects VALUES (28, 32, 4);
INSERT INTO public.students_subjects VALUES (28, 32, 5);
INSERT INTO public.students_subjects VALUES (28, 34, 1);
INSERT INTO public.students_subjects VALUES (28, 34, 2);
INSERT INTO public.students_subjects VALUES (28, 34, 3);
INSERT INTO public.students_subjects VALUES (28, 34, 4);
INSERT INTO public.students_subjects VALUES (28, 34, 5);
INSERT INTO public.students_subjects VALUES (28, 37, 1);
INSERT INTO public.students_subjects VALUES (28, 37, 2);
INSERT INTO public.students_subjects VALUES (28, 37, 3);
INSERT INTO public.students_subjects VALUES (28, 37, 4);
INSERT INTO public.students_subjects VALUES (28, 37, 5);
INSERT INTO public.students_subjects VALUES (28, 29, 3);
INSERT INTO public.students_subjects VALUES (28, 29, 4);
INSERT INTO public.students_subjects VALUES (28, 29, 5);
INSERT INTO public.students_subjects VALUES (28, 14, 3);
INSERT INTO public.students_subjects VALUES (28, 14, 4);
INSERT INTO public.students_subjects VALUES (28, 14, 5);
INSERT INTO public.students_subjects VALUES (29, 11, 1);
INSERT INTO public.students_subjects VALUES (29, 11, 2);
INSERT INTO public.students_subjects VALUES (29, 11, 3);
INSERT INTO public.students_subjects VALUES (29, 11, 4);
INSERT INTO public.students_subjects VALUES (29, 11, 5);
INSERT INTO public.students_subjects VALUES (29, 13, 1);
INSERT INTO public.students_subjects VALUES (29, 13, 2);
INSERT INTO public.students_subjects VALUES (29, 13, 3);
INSERT INTO public.students_subjects VALUES (29, 13, 4);
INSERT INTO public.students_subjects VALUES (29, 13, 5);
INSERT INTO public.students_subjects VALUES (29, 20, 1);
INSERT INTO public.students_subjects VALUES (29, 20, 2);
INSERT INTO public.students_subjects VALUES (29, 20, 3);
INSERT INTO public.students_subjects VALUES (29, 20, 4);
INSERT INTO public.students_subjects VALUES (29, 20, 5);
INSERT INTO public.students_subjects VALUES (29, 31, 1);
INSERT INTO public.students_subjects VALUES (29, 31, 2);
INSERT INTO public.students_subjects VALUES (29, 31, 3);
INSERT INTO public.students_subjects VALUES (29, 31, 4);
INSERT INTO public.students_subjects VALUES (29, 31, 5);
INSERT INTO public.students_subjects VALUES (29, 32, 1);
INSERT INTO public.students_subjects VALUES (29, 32, 2);
INSERT INTO public.students_subjects VALUES (29, 32, 3);
INSERT INTO public.students_subjects VALUES (29, 32, 4);
INSERT INTO public.students_subjects VALUES (29, 32, 5);
INSERT INTO public.students_subjects VALUES (29, 34, 1);
INSERT INTO public.students_subjects VALUES (29, 34, 2);
INSERT INTO public.students_subjects VALUES (29, 34, 3);
INSERT INTO public.students_subjects VALUES (29, 34, 4);
INSERT INTO public.students_subjects VALUES (29, 34, 5);
INSERT INTO public.students_subjects VALUES (29, 37, 1);
INSERT INTO public.students_subjects VALUES (29, 37, 2);
INSERT INTO public.students_subjects VALUES (29, 37, 3);
INSERT INTO public.students_subjects VALUES (29, 37, 4);
INSERT INTO public.students_subjects VALUES (29, 37, 5);
INSERT INTO public.students_subjects VALUES (29, 29, 3);
INSERT INTO public.students_subjects VALUES (29, 29, 4);
INSERT INTO public.students_subjects VALUES (29, 29, 5);
INSERT INTO public.students_subjects VALUES (29, 27, 3);
INSERT INTO public.students_subjects VALUES (29, 27, 4);
INSERT INTO public.students_subjects VALUES (29, 27, 5);
INSERT INTO public.students_subjects VALUES (30, 11, 1);
INSERT INTO public.students_subjects VALUES (30, 11, 2);
INSERT INTO public.students_subjects VALUES (30, 11, 3);
INSERT INTO public.students_subjects VALUES (30, 11, 4);
INSERT INTO public.students_subjects VALUES (30, 11, 5);
INSERT INTO public.students_subjects VALUES (30, 13, 1);
INSERT INTO public.students_subjects VALUES (30, 13, 2);
INSERT INTO public.students_subjects VALUES (30, 13, 3);
INSERT INTO public.students_subjects VALUES (30, 13, 4);
INSERT INTO public.students_subjects VALUES (30, 13, 5);
INSERT INTO public.students_subjects VALUES (30, 20, 1);
INSERT INTO public.students_subjects VALUES (30, 20, 2);
INSERT INTO public.students_subjects VALUES (30, 20, 3);
INSERT INTO public.students_subjects VALUES (30, 20, 4);
INSERT INTO public.students_subjects VALUES (30, 20, 5);
INSERT INTO public.students_subjects VALUES (30, 31, 1);
INSERT INTO public.students_subjects VALUES (30, 31, 2);
INSERT INTO public.students_subjects VALUES (30, 31, 3);
INSERT INTO public.students_subjects VALUES (30, 31, 4);
INSERT INTO public.students_subjects VALUES (30, 31, 5);
INSERT INTO public.students_subjects VALUES (30, 32, 1);
INSERT INTO public.students_subjects VALUES (30, 32, 2);
INSERT INTO public.students_subjects VALUES (30, 32, 3);
INSERT INTO public.students_subjects VALUES (30, 32, 4);
INSERT INTO public.students_subjects VALUES (30, 32, 5);
INSERT INTO public.students_subjects VALUES (30, 34, 1);
INSERT INTO public.students_subjects VALUES (30, 34, 2);
INSERT INTO public.students_subjects VALUES (30, 34, 3);
INSERT INTO public.students_subjects VALUES (30, 34, 4);
INSERT INTO public.students_subjects VALUES (30, 34, 5);
INSERT INTO public.students_subjects VALUES (30, 37, 1);
INSERT INTO public.students_subjects VALUES (30, 37, 2);
INSERT INTO public.students_subjects VALUES (30, 37, 3);
INSERT INTO public.students_subjects VALUES (30, 37, 4);
INSERT INTO public.students_subjects VALUES (30, 37, 5);
INSERT INTO public.students_subjects VALUES (30, 29, 3);
INSERT INTO public.students_subjects VALUES (30, 29, 4);
INSERT INTO public.students_subjects VALUES (30, 29, 5);
INSERT INTO public.students_subjects VALUES (30, 27, 3);
INSERT INTO public.students_subjects VALUES (30, 27, 4);
INSERT INTO public.students_subjects VALUES (30, 27, 5);
INSERT INTO public.students_subjects VALUES (31, 11, 1);
INSERT INTO public.students_subjects VALUES (31, 11, 2);
INSERT INTO public.students_subjects VALUES (31, 11, 3);
INSERT INTO public.students_subjects VALUES (31, 11, 4);
INSERT INTO public.students_subjects VALUES (31, 11, 5);
INSERT INTO public.students_subjects VALUES (31, 13, 1);
INSERT INTO public.students_subjects VALUES (31, 13, 2);
INSERT INTO public.students_subjects VALUES (31, 13, 3);
INSERT INTO public.students_subjects VALUES (31, 13, 4);
INSERT INTO public.students_subjects VALUES (31, 13, 5);
INSERT INTO public.students_subjects VALUES (31, 20, 1);
INSERT INTO public.students_subjects VALUES (31, 20, 2);
INSERT INTO public.students_subjects VALUES (31, 20, 3);
INSERT INTO public.students_subjects VALUES (31, 20, 4);
INSERT INTO public.students_subjects VALUES (31, 20, 5);
INSERT INTO public.students_subjects VALUES (31, 31, 1);
INSERT INTO public.students_subjects VALUES (31, 31, 2);
INSERT INTO public.students_subjects VALUES (31, 31, 3);
INSERT INTO public.students_subjects VALUES (31, 31, 4);
INSERT INTO public.students_subjects VALUES (31, 31, 5);
INSERT INTO public.students_subjects VALUES (31, 32, 1);
INSERT INTO public.students_subjects VALUES (31, 32, 2);
INSERT INTO public.students_subjects VALUES (31, 32, 3);
INSERT INTO public.students_subjects VALUES (31, 32, 4);
INSERT INTO public.students_subjects VALUES (31, 32, 5);
INSERT INTO public.students_subjects VALUES (31, 34, 1);
INSERT INTO public.students_subjects VALUES (31, 34, 2);
INSERT INTO public.students_subjects VALUES (31, 34, 3);
INSERT INTO public.students_subjects VALUES (31, 34, 4);
INSERT INTO public.students_subjects VALUES (31, 34, 5);
INSERT INTO public.students_subjects VALUES (31, 37, 1);
INSERT INTO public.students_subjects VALUES (31, 37, 2);
INSERT INTO public.students_subjects VALUES (31, 37, 3);
INSERT INTO public.students_subjects VALUES (31, 37, 4);
INSERT INTO public.students_subjects VALUES (31, 37, 5);
INSERT INTO public.students_subjects VALUES (31, 22, 3);
INSERT INTO public.students_subjects VALUES (31, 22, 4);
INSERT INTO public.students_subjects VALUES (31, 22, 5);
INSERT INTO public.students_subjects VALUES (31, 27, 3);
INSERT INTO public.students_subjects VALUES (31, 27, 4);
INSERT INTO public.students_subjects VALUES (31, 27, 5);
INSERT INTO public.students_subjects VALUES (32, 11, 1);
INSERT INTO public.students_subjects VALUES (32, 11, 2);
INSERT INTO public.students_subjects VALUES (32, 11, 3);
INSERT INTO public.students_subjects VALUES (32, 11, 4);
INSERT INTO public.students_subjects VALUES (32, 11, 5);
INSERT INTO public.students_subjects VALUES (32, 13, 1);
INSERT INTO public.students_subjects VALUES (32, 13, 2);
INSERT INTO public.students_subjects VALUES (32, 13, 3);
INSERT INTO public.students_subjects VALUES (32, 13, 4);
INSERT INTO public.students_subjects VALUES (32, 13, 5);
INSERT INTO public.students_subjects VALUES (32, 20, 1);
INSERT INTO public.students_subjects VALUES (32, 20, 2);
INSERT INTO public.students_subjects VALUES (32, 20, 3);
INSERT INTO public.students_subjects VALUES (32, 20, 4);
INSERT INTO public.students_subjects VALUES (32, 20, 5);
INSERT INTO public.students_subjects VALUES (32, 31, 1);
INSERT INTO public.students_subjects VALUES (32, 31, 2);
INSERT INTO public.students_subjects VALUES (32, 31, 3);
INSERT INTO public.students_subjects VALUES (32, 31, 4);
INSERT INTO public.students_subjects VALUES (32, 31, 5);
INSERT INTO public.students_subjects VALUES (32, 32, 1);
INSERT INTO public.students_subjects VALUES (32, 32, 2);
INSERT INTO public.students_subjects VALUES (32, 32, 3);
INSERT INTO public.students_subjects VALUES (32, 32, 4);
INSERT INTO public.students_subjects VALUES (32, 32, 5);
INSERT INTO public.students_subjects VALUES (32, 34, 1);
INSERT INTO public.students_subjects VALUES (32, 34, 2);
INSERT INTO public.students_subjects VALUES (32, 34, 3);
INSERT INTO public.students_subjects VALUES (32, 34, 4);
INSERT INTO public.students_subjects VALUES (32, 34, 5);
INSERT INTO public.students_subjects VALUES (32, 37, 1);
INSERT INTO public.students_subjects VALUES (32, 37, 2);
INSERT INTO public.students_subjects VALUES (32, 37, 3);
INSERT INTO public.students_subjects VALUES (32, 37, 4);
INSERT INTO public.students_subjects VALUES (32, 37, 5);
INSERT INTO public.students_subjects VALUES (32, 27, 3);
INSERT INTO public.students_subjects VALUES (32, 27, 4);
INSERT INTO public.students_subjects VALUES (32, 27, 5);
INSERT INTO public.students_subjects VALUES (32, 14, 3);
INSERT INTO public.students_subjects VALUES (32, 14, 4);
INSERT INTO public.students_subjects VALUES (32, 14, 5);
INSERT INTO public.students_subjects VALUES (33, 11, 1);
INSERT INTO public.students_subjects VALUES (33, 11, 2);
INSERT INTO public.students_subjects VALUES (33, 11, 3);
INSERT INTO public.students_subjects VALUES (33, 11, 4);
INSERT INTO public.students_subjects VALUES (33, 11, 5);
INSERT INTO public.students_subjects VALUES (33, 13, 1);
INSERT INTO public.students_subjects VALUES (33, 13, 2);
INSERT INTO public.students_subjects VALUES (33, 13, 3);
INSERT INTO public.students_subjects VALUES (33, 13, 4);
INSERT INTO public.students_subjects VALUES (33, 13, 5);
INSERT INTO public.students_subjects VALUES (33, 20, 1);
INSERT INTO public.students_subjects VALUES (33, 20, 2);
INSERT INTO public.students_subjects VALUES (33, 20, 3);
INSERT INTO public.students_subjects VALUES (33, 20, 4);
INSERT INTO public.students_subjects VALUES (33, 20, 5);
INSERT INTO public.students_subjects VALUES (33, 31, 1);
INSERT INTO public.students_subjects VALUES (33, 31, 2);
INSERT INTO public.students_subjects VALUES (33, 31, 3);
INSERT INTO public.students_subjects VALUES (33, 31, 4);
INSERT INTO public.students_subjects VALUES (33, 31, 5);
INSERT INTO public.students_subjects VALUES (33, 32, 1);
INSERT INTO public.students_subjects VALUES (33, 32, 2);
INSERT INTO public.students_subjects VALUES (33, 32, 3);
INSERT INTO public.students_subjects VALUES (33, 32, 4);
INSERT INTO public.students_subjects VALUES (33, 32, 5);
INSERT INTO public.students_subjects VALUES (33, 34, 1);
INSERT INTO public.students_subjects VALUES (33, 34, 2);
INSERT INTO public.students_subjects VALUES (33, 34, 3);
INSERT INTO public.students_subjects VALUES (33, 34, 4);
INSERT INTO public.students_subjects VALUES (33, 34, 5);
INSERT INTO public.students_subjects VALUES (33, 37, 1);
INSERT INTO public.students_subjects VALUES (33, 37, 2);
INSERT INTO public.students_subjects VALUES (33, 37, 3);
INSERT INTO public.students_subjects VALUES (33, 37, 4);
INSERT INTO public.students_subjects VALUES (33, 37, 5);
INSERT INTO public.students_subjects VALUES (33, 29, 3);
INSERT INTO public.students_subjects VALUES (33, 29, 4);
INSERT INTO public.students_subjects VALUES (33, 29, 5);
INSERT INTO public.students_subjects VALUES (33, 22, 3);
INSERT INTO public.students_subjects VALUES (33, 22, 4);
INSERT INTO public.students_subjects VALUES (33, 22, 5);
INSERT INTO public.students_subjects VALUES (34, 11, 1);
INSERT INTO public.students_subjects VALUES (34, 11, 2);
INSERT INTO public.students_subjects VALUES (34, 11, 3);
INSERT INTO public.students_subjects VALUES (34, 11, 4);
INSERT INTO public.students_subjects VALUES (34, 11, 5);
INSERT INTO public.students_subjects VALUES (34, 13, 1);
INSERT INTO public.students_subjects VALUES (34, 13, 2);
INSERT INTO public.students_subjects VALUES (34, 13, 3);
INSERT INTO public.students_subjects VALUES (34, 13, 4);
INSERT INTO public.students_subjects VALUES (34, 13, 5);
INSERT INTO public.students_subjects VALUES (34, 20, 1);
INSERT INTO public.students_subjects VALUES (34, 20, 2);
INSERT INTO public.students_subjects VALUES (34, 20, 3);
INSERT INTO public.students_subjects VALUES (34, 20, 4);
INSERT INTO public.students_subjects VALUES (34, 20, 5);
INSERT INTO public.students_subjects VALUES (34, 31, 1);
INSERT INTO public.students_subjects VALUES (34, 31, 2);
INSERT INTO public.students_subjects VALUES (34, 31, 3);
INSERT INTO public.students_subjects VALUES (34, 31, 4);
INSERT INTO public.students_subjects VALUES (34, 31, 5);
INSERT INTO public.students_subjects VALUES (34, 32, 1);
INSERT INTO public.students_subjects VALUES (34, 32, 2);
INSERT INTO public.students_subjects VALUES (34, 32, 3);
INSERT INTO public.students_subjects VALUES (34, 32, 4);
INSERT INTO public.students_subjects VALUES (34, 32, 5);
INSERT INTO public.students_subjects VALUES (34, 34, 1);
INSERT INTO public.students_subjects VALUES (34, 34, 2);
INSERT INTO public.students_subjects VALUES (34, 34, 3);
INSERT INTO public.students_subjects VALUES (34, 34, 4);
INSERT INTO public.students_subjects VALUES (34, 34, 5);
INSERT INTO public.students_subjects VALUES (34, 37, 1);
INSERT INTO public.students_subjects VALUES (34, 37, 2);
INSERT INTO public.students_subjects VALUES (34, 37, 3);
INSERT INTO public.students_subjects VALUES (34, 37, 4);
INSERT INTO public.students_subjects VALUES (34, 37, 5);
INSERT INTO public.students_subjects VALUES (34, 29, 3);
INSERT INTO public.students_subjects VALUES (34, 29, 4);
INSERT INTO public.students_subjects VALUES (34, 29, 5);
INSERT INTO public.students_subjects VALUES (34, 22, 3);
INSERT INTO public.students_subjects VALUES (34, 22, 4);
INSERT INTO public.students_subjects VALUES (34, 22, 5);
INSERT INTO public.students_subjects VALUES (35, 11, 1);
INSERT INTO public.students_subjects VALUES (35, 11, 2);
INSERT INTO public.students_subjects VALUES (35, 11, 3);
INSERT INTO public.students_subjects VALUES (35, 11, 4);
INSERT INTO public.students_subjects VALUES (35, 11, 5);
INSERT INTO public.students_subjects VALUES (35, 13, 1);
INSERT INTO public.students_subjects VALUES (35, 13, 2);
INSERT INTO public.students_subjects VALUES (35, 13, 3);
INSERT INTO public.students_subjects VALUES (35, 13, 4);
INSERT INTO public.students_subjects VALUES (35, 13, 5);
INSERT INTO public.students_subjects VALUES (35, 20, 1);
INSERT INTO public.students_subjects VALUES (35, 20, 2);
INSERT INTO public.students_subjects VALUES (35, 20, 3);
INSERT INTO public.students_subjects VALUES (35, 20, 4);
INSERT INTO public.students_subjects VALUES (35, 20, 5);
INSERT INTO public.students_subjects VALUES (35, 31, 1);
INSERT INTO public.students_subjects VALUES (35, 31, 2);
INSERT INTO public.students_subjects VALUES (35, 31, 3);
INSERT INTO public.students_subjects VALUES (35, 31, 4);
INSERT INTO public.students_subjects VALUES (35, 31, 5);
INSERT INTO public.students_subjects VALUES (35, 32, 1);
INSERT INTO public.students_subjects VALUES (35, 32, 2);
INSERT INTO public.students_subjects VALUES (35, 32, 3);
INSERT INTO public.students_subjects VALUES (35, 32, 4);
INSERT INTO public.students_subjects VALUES (35, 32, 5);
INSERT INTO public.students_subjects VALUES (35, 34, 1);
INSERT INTO public.students_subjects VALUES (35, 34, 2);
INSERT INTO public.students_subjects VALUES (35, 34, 3);
INSERT INTO public.students_subjects VALUES (35, 34, 4);
INSERT INTO public.students_subjects VALUES (35, 34, 5);
INSERT INTO public.students_subjects VALUES (35, 37, 1);
INSERT INTO public.students_subjects VALUES (35, 37, 2);
INSERT INTO public.students_subjects VALUES (35, 37, 3);
INSERT INTO public.students_subjects VALUES (35, 37, 4);
INSERT INTO public.students_subjects VALUES (35, 37, 5);
INSERT INTO public.students_subjects VALUES (35, 29, 3);
INSERT INTO public.students_subjects VALUES (35, 29, 4);
INSERT INTO public.students_subjects VALUES (35, 29, 5);
INSERT INTO public.students_subjects VALUES (35, 14, 3);
INSERT INTO public.students_subjects VALUES (35, 14, 4);
INSERT INTO public.students_subjects VALUES (35, 14, 5);
INSERT INTO public.students_subjects VALUES (36, 11, 1);
INSERT INTO public.students_subjects VALUES (36, 11, 2);
INSERT INTO public.students_subjects VALUES (36, 11, 3);
INSERT INTO public.students_subjects VALUES (36, 11, 4);
INSERT INTO public.students_subjects VALUES (36, 11, 5);
INSERT INTO public.students_subjects VALUES (36, 13, 1);
INSERT INTO public.students_subjects VALUES (36, 13, 2);
INSERT INTO public.students_subjects VALUES (36, 13, 3);
INSERT INTO public.students_subjects VALUES (36, 13, 4);
INSERT INTO public.students_subjects VALUES (36, 13, 5);
INSERT INTO public.students_subjects VALUES (36, 20, 1);
INSERT INTO public.students_subjects VALUES (36, 20, 2);
INSERT INTO public.students_subjects VALUES (36, 20, 3);
INSERT INTO public.students_subjects VALUES (36, 20, 4);
INSERT INTO public.students_subjects VALUES (36, 20, 5);
INSERT INTO public.students_subjects VALUES (36, 31, 1);
INSERT INTO public.students_subjects VALUES (36, 31, 2);
INSERT INTO public.students_subjects VALUES (36, 31, 3);
INSERT INTO public.students_subjects VALUES (36, 31, 4);
INSERT INTO public.students_subjects VALUES (36, 31, 5);
INSERT INTO public.students_subjects VALUES (36, 32, 1);
INSERT INTO public.students_subjects VALUES (36, 32, 2);
INSERT INTO public.students_subjects VALUES (36, 32, 3);
INSERT INTO public.students_subjects VALUES (36, 32, 4);
INSERT INTO public.students_subjects VALUES (36, 32, 5);
INSERT INTO public.students_subjects VALUES (36, 34, 1);
INSERT INTO public.students_subjects VALUES (36, 34, 2);
INSERT INTO public.students_subjects VALUES (36, 34, 3);
INSERT INTO public.students_subjects VALUES (36, 34, 4);
INSERT INTO public.students_subjects VALUES (36, 34, 5);
INSERT INTO public.students_subjects VALUES (36, 37, 1);
INSERT INTO public.students_subjects VALUES (36, 37, 2);
INSERT INTO public.students_subjects VALUES (36, 37, 3);
INSERT INTO public.students_subjects VALUES (36, 37, 4);
INSERT INTO public.students_subjects VALUES (36, 37, 5);
INSERT INTO public.students_subjects VALUES (36, 14, 3);
INSERT INTO public.students_subjects VALUES (36, 14, 4);
INSERT INTO public.students_subjects VALUES (36, 14, 5);
INSERT INTO public.students_subjects VALUES (36, 29, 3);
INSERT INTO public.students_subjects VALUES (36, 29, 4);
INSERT INTO public.students_subjects VALUES (36, 29, 5);
INSERT INTO public.students_subjects VALUES (37, 11, 1);
INSERT INTO public.students_subjects VALUES (37, 11, 2);
INSERT INTO public.students_subjects VALUES (37, 11, 3);
INSERT INTO public.students_subjects VALUES (37, 11, 4);
INSERT INTO public.students_subjects VALUES (37, 11, 5);
INSERT INTO public.students_subjects VALUES (37, 13, 1);
INSERT INTO public.students_subjects VALUES (37, 13, 2);
INSERT INTO public.students_subjects VALUES (37, 13, 3);
INSERT INTO public.students_subjects VALUES (37, 13, 4);
INSERT INTO public.students_subjects VALUES (37, 13, 5);
INSERT INTO public.students_subjects VALUES (37, 20, 1);
INSERT INTO public.students_subjects VALUES (37, 20, 2);
INSERT INTO public.students_subjects VALUES (37, 20, 3);
INSERT INTO public.students_subjects VALUES (37, 20, 4);
INSERT INTO public.students_subjects VALUES (37, 20, 5);
INSERT INTO public.students_subjects VALUES (37, 31, 1);
INSERT INTO public.students_subjects VALUES (37, 31, 2);
INSERT INTO public.students_subjects VALUES (37, 31, 3);
INSERT INTO public.students_subjects VALUES (37, 31, 4);
INSERT INTO public.students_subjects VALUES (37, 31, 5);
INSERT INTO public.students_subjects VALUES (37, 32, 1);
INSERT INTO public.students_subjects VALUES (37, 32, 2);
INSERT INTO public.students_subjects VALUES (37, 32, 3);
INSERT INTO public.students_subjects VALUES (37, 32, 4);
INSERT INTO public.students_subjects VALUES (37, 32, 5);
INSERT INTO public.students_subjects VALUES (37, 34, 1);
INSERT INTO public.students_subjects VALUES (37, 34, 2);
INSERT INTO public.students_subjects VALUES (37, 34, 3);
INSERT INTO public.students_subjects VALUES (37, 34, 4);
INSERT INTO public.students_subjects VALUES (37, 34, 5);
INSERT INTO public.students_subjects VALUES (37, 37, 1);
INSERT INTO public.students_subjects VALUES (37, 37, 2);
INSERT INTO public.students_subjects VALUES (37, 37, 3);
INSERT INTO public.students_subjects VALUES (37, 37, 4);
INSERT INTO public.students_subjects VALUES (37, 37, 5);
INSERT INTO public.students_subjects VALUES (37, 22, 3);
INSERT INTO public.students_subjects VALUES (37, 22, 4);
INSERT INTO public.students_subjects VALUES (37, 22, 5);
INSERT INTO public.students_subjects VALUES (37, 29, 3);
INSERT INTO public.students_subjects VALUES (37, 29, 4);
INSERT INTO public.students_subjects VALUES (37, 29, 5);
INSERT INTO public.students_subjects VALUES (38, 11, 1);
INSERT INTO public.students_subjects VALUES (38, 11, 2);
INSERT INTO public.students_subjects VALUES (38, 11, 3);
INSERT INTO public.students_subjects VALUES (38, 11, 4);
INSERT INTO public.students_subjects VALUES (38, 11, 5);
INSERT INTO public.students_subjects VALUES (38, 13, 1);
INSERT INTO public.students_subjects VALUES (38, 13, 2);
INSERT INTO public.students_subjects VALUES (38, 13, 3);
INSERT INTO public.students_subjects VALUES (38, 13, 4);
INSERT INTO public.students_subjects VALUES (38, 13, 5);
INSERT INTO public.students_subjects VALUES (38, 20, 1);
INSERT INTO public.students_subjects VALUES (38, 20, 2);
INSERT INTO public.students_subjects VALUES (38, 20, 3);
INSERT INTO public.students_subjects VALUES (38, 20, 4);
INSERT INTO public.students_subjects VALUES (38, 20, 5);
INSERT INTO public.students_subjects VALUES (38, 31, 1);
INSERT INTO public.students_subjects VALUES (38, 31, 2);
INSERT INTO public.students_subjects VALUES (38, 31, 3);
INSERT INTO public.students_subjects VALUES (38, 31, 4);
INSERT INTO public.students_subjects VALUES (38, 31, 5);
INSERT INTO public.students_subjects VALUES (38, 32, 1);
INSERT INTO public.students_subjects VALUES (38, 32, 2);
INSERT INTO public.students_subjects VALUES (38, 32, 3);
INSERT INTO public.students_subjects VALUES (38, 32, 4);
INSERT INTO public.students_subjects VALUES (38, 32, 5);
INSERT INTO public.students_subjects VALUES (38, 34, 1);
INSERT INTO public.students_subjects VALUES (38, 34, 2);
INSERT INTO public.students_subjects VALUES (38, 34, 3);
INSERT INTO public.students_subjects VALUES (38, 34, 4);
INSERT INTO public.students_subjects VALUES (38, 34, 5);
INSERT INTO public.students_subjects VALUES (38, 37, 1);
INSERT INTO public.students_subjects VALUES (38, 37, 2);
INSERT INTO public.students_subjects VALUES (38, 37, 3);
INSERT INTO public.students_subjects VALUES (38, 37, 4);
INSERT INTO public.students_subjects VALUES (38, 37, 5);
INSERT INTO public.students_subjects VALUES (38, 14, 3);
INSERT INTO public.students_subjects VALUES (38, 14, 4);
INSERT INTO public.students_subjects VALUES (38, 14, 5);
INSERT INTO public.students_subjects VALUES (38, 22, 3);
INSERT INTO public.students_subjects VALUES (38, 22, 4);
INSERT INTO public.students_subjects VALUES (38, 22, 5);
INSERT INTO public.students_subjects VALUES (39, 11, 1);
INSERT INTO public.students_subjects VALUES (39, 11, 2);
INSERT INTO public.students_subjects VALUES (39, 11, 3);
INSERT INTO public.students_subjects VALUES (39, 11, 4);
INSERT INTO public.students_subjects VALUES (39, 11, 5);
INSERT INTO public.students_subjects VALUES (39, 13, 1);
INSERT INTO public.students_subjects VALUES (39, 13, 2);
INSERT INTO public.students_subjects VALUES (39, 13, 3);
INSERT INTO public.students_subjects VALUES (39, 13, 4);
INSERT INTO public.students_subjects VALUES (39, 13, 5);
INSERT INTO public.students_subjects VALUES (39, 20, 1);
INSERT INTO public.students_subjects VALUES (39, 20, 2);
INSERT INTO public.students_subjects VALUES (39, 20, 3);
INSERT INTO public.students_subjects VALUES (39, 20, 4);
INSERT INTO public.students_subjects VALUES (39, 20, 5);
INSERT INTO public.students_subjects VALUES (39, 31, 1);
INSERT INTO public.students_subjects VALUES (39, 31, 2);
INSERT INTO public.students_subjects VALUES (39, 31, 3);
INSERT INTO public.students_subjects VALUES (39, 31, 4);
INSERT INTO public.students_subjects VALUES (39, 31, 5);
INSERT INTO public.students_subjects VALUES (39, 32, 1);
INSERT INTO public.students_subjects VALUES (39, 32, 2);
INSERT INTO public.students_subjects VALUES (39, 32, 3);
INSERT INTO public.students_subjects VALUES (39, 32, 4);
INSERT INTO public.students_subjects VALUES (39, 32, 5);
INSERT INTO public.students_subjects VALUES (39, 34, 1);
INSERT INTO public.students_subjects VALUES (39, 34, 2);
INSERT INTO public.students_subjects VALUES (39, 34, 3);
INSERT INTO public.students_subjects VALUES (39, 34, 4);
INSERT INTO public.students_subjects VALUES (39, 34, 5);
INSERT INTO public.students_subjects VALUES (39, 37, 1);
INSERT INTO public.students_subjects VALUES (39, 37, 2);
INSERT INTO public.students_subjects VALUES (39, 37, 3);
INSERT INTO public.students_subjects VALUES (39, 37, 4);
INSERT INTO public.students_subjects VALUES (39, 37, 5);
INSERT INTO public.students_subjects VALUES (39, 22, 3);
INSERT INTO public.students_subjects VALUES (39, 22, 4);
INSERT INTO public.students_subjects VALUES (39, 22, 5);
INSERT INTO public.students_subjects VALUES (39, 14, 3);
INSERT INTO public.students_subjects VALUES (39, 14, 4);
INSERT INTO public.students_subjects VALUES (39, 14, 5);
INSERT INTO public.students_subjects VALUES (40, 11, 1);
INSERT INTO public.students_subjects VALUES (40, 11, 2);
INSERT INTO public.students_subjects VALUES (40, 11, 3);
INSERT INTO public.students_subjects VALUES (40, 11, 4);
INSERT INTO public.students_subjects VALUES (40, 11, 5);
INSERT INTO public.students_subjects VALUES (40, 13, 1);
INSERT INTO public.students_subjects VALUES (40, 13, 2);
INSERT INTO public.students_subjects VALUES (40, 13, 3);
INSERT INTO public.students_subjects VALUES (40, 13, 4);
INSERT INTO public.students_subjects VALUES (40, 13, 5);
INSERT INTO public.students_subjects VALUES (40, 20, 1);
INSERT INTO public.students_subjects VALUES (40, 20, 2);
INSERT INTO public.students_subjects VALUES (40, 20, 3);
INSERT INTO public.students_subjects VALUES (40, 20, 4);
INSERT INTO public.students_subjects VALUES (40, 20, 5);
INSERT INTO public.students_subjects VALUES (40, 31, 1);
INSERT INTO public.students_subjects VALUES (40, 31, 2);
INSERT INTO public.students_subjects VALUES (40, 31, 3);
INSERT INTO public.students_subjects VALUES (40, 31, 4);
INSERT INTO public.students_subjects VALUES (40, 31, 5);
INSERT INTO public.students_subjects VALUES (40, 32, 1);
INSERT INTO public.students_subjects VALUES (40, 32, 2);
INSERT INTO public.students_subjects VALUES (40, 32, 3);
INSERT INTO public.students_subjects VALUES (40, 32, 4);
INSERT INTO public.students_subjects VALUES (40, 32, 5);
INSERT INTO public.students_subjects VALUES (40, 34, 1);
INSERT INTO public.students_subjects VALUES (40, 34, 2);
INSERT INTO public.students_subjects VALUES (40, 34, 3);
INSERT INTO public.students_subjects VALUES (40, 34, 4);
INSERT INTO public.students_subjects VALUES (40, 34, 5);
INSERT INTO public.students_subjects VALUES (40, 37, 1);
INSERT INTO public.students_subjects VALUES (40, 37, 2);
INSERT INTO public.students_subjects VALUES (40, 37, 3);
INSERT INTO public.students_subjects VALUES (40, 37, 4);
INSERT INTO public.students_subjects VALUES (40, 37, 5);
INSERT INTO public.students_subjects VALUES (40, 27, 3);
INSERT INTO public.students_subjects VALUES (40, 27, 4);
INSERT INTO public.students_subjects VALUES (40, 27, 5);
INSERT INTO public.students_subjects VALUES (40, 22, 3);
INSERT INTO public.students_subjects VALUES (40, 22, 4);
INSERT INTO public.students_subjects VALUES (40, 22, 5);
INSERT INTO public.students_subjects VALUES (41, 11, 1);
INSERT INTO public.students_subjects VALUES (41, 11, 2);
INSERT INTO public.students_subjects VALUES (41, 11, 3);
INSERT INTO public.students_subjects VALUES (41, 11, 4);
INSERT INTO public.students_subjects VALUES (41, 11, 5);
INSERT INTO public.students_subjects VALUES (41, 13, 1);
INSERT INTO public.students_subjects VALUES (41, 13, 2);
INSERT INTO public.students_subjects VALUES (41, 13, 3);
INSERT INTO public.students_subjects VALUES (41, 13, 4);
INSERT INTO public.students_subjects VALUES (41, 13, 5);
INSERT INTO public.students_subjects VALUES (41, 20, 1);
INSERT INTO public.students_subjects VALUES (41, 20, 2);
INSERT INTO public.students_subjects VALUES (41, 20, 3);
INSERT INTO public.students_subjects VALUES (41, 20, 4);
INSERT INTO public.students_subjects VALUES (41, 20, 5);
INSERT INTO public.students_subjects VALUES (41, 31, 1);
INSERT INTO public.students_subjects VALUES (41, 31, 2);
INSERT INTO public.students_subjects VALUES (41, 31, 3);
INSERT INTO public.students_subjects VALUES (41, 31, 4);
INSERT INTO public.students_subjects VALUES (41, 31, 5);
INSERT INTO public.students_subjects VALUES (41, 32, 1);
INSERT INTO public.students_subjects VALUES (41, 32, 2);
INSERT INTO public.students_subjects VALUES (41, 32, 3);
INSERT INTO public.students_subjects VALUES (41, 32, 4);
INSERT INTO public.students_subjects VALUES (41, 32, 5);
INSERT INTO public.students_subjects VALUES (41, 34, 1);
INSERT INTO public.students_subjects VALUES (41, 34, 2);
INSERT INTO public.students_subjects VALUES (41, 34, 3);
INSERT INTO public.students_subjects VALUES (41, 34, 4);
INSERT INTO public.students_subjects VALUES (41, 34, 5);
INSERT INTO public.students_subjects VALUES (41, 37, 1);
INSERT INTO public.students_subjects VALUES (41, 37, 2);
INSERT INTO public.students_subjects VALUES (41, 37, 3);
INSERT INTO public.students_subjects VALUES (41, 37, 4);
INSERT INTO public.students_subjects VALUES (41, 37, 5);
INSERT INTO public.students_subjects VALUES (41, 29, 3);
INSERT INTO public.students_subjects VALUES (41, 29, 4);
INSERT INTO public.students_subjects VALUES (41, 29, 5);
INSERT INTO public.students_subjects VALUES (41, 27, 3);
INSERT INTO public.students_subjects VALUES (41, 27, 4);
INSERT INTO public.students_subjects VALUES (41, 27, 5);
INSERT INTO public.students_subjects VALUES (42, 11, 1);
INSERT INTO public.students_subjects VALUES (42, 11, 2);
INSERT INTO public.students_subjects VALUES (42, 11, 3);
INSERT INTO public.students_subjects VALUES (42, 11, 4);
INSERT INTO public.students_subjects VALUES (42, 11, 5);
INSERT INTO public.students_subjects VALUES (42, 13, 1);
INSERT INTO public.students_subjects VALUES (42, 13, 2);
INSERT INTO public.students_subjects VALUES (42, 13, 3);
INSERT INTO public.students_subjects VALUES (42, 13, 4);
INSERT INTO public.students_subjects VALUES (42, 13, 5);
INSERT INTO public.students_subjects VALUES (42, 20, 1);
INSERT INTO public.students_subjects VALUES (42, 20, 2);
INSERT INTO public.students_subjects VALUES (42, 20, 3);
INSERT INTO public.students_subjects VALUES (42, 20, 4);
INSERT INTO public.students_subjects VALUES (42, 20, 5);
INSERT INTO public.students_subjects VALUES (42, 31, 1);
INSERT INTO public.students_subjects VALUES (42, 31, 2);
INSERT INTO public.students_subjects VALUES (42, 31, 3);
INSERT INTO public.students_subjects VALUES (42, 31, 4);
INSERT INTO public.students_subjects VALUES (42, 31, 5);
INSERT INTO public.students_subjects VALUES (42, 32, 1);
INSERT INTO public.students_subjects VALUES (42, 32, 2);
INSERT INTO public.students_subjects VALUES (42, 32, 3);
INSERT INTO public.students_subjects VALUES (42, 32, 4);
INSERT INTO public.students_subjects VALUES (42, 32, 5);
INSERT INTO public.students_subjects VALUES (42, 34, 1);
INSERT INTO public.students_subjects VALUES (42, 34, 2);
INSERT INTO public.students_subjects VALUES (42, 34, 3);
INSERT INTO public.students_subjects VALUES (42, 34, 4);
INSERT INTO public.students_subjects VALUES (42, 34, 5);
INSERT INTO public.students_subjects VALUES (42, 37, 1);
INSERT INTO public.students_subjects VALUES (42, 37, 2);
INSERT INTO public.students_subjects VALUES (42, 37, 3);
INSERT INTO public.students_subjects VALUES (42, 37, 4);
INSERT INTO public.students_subjects VALUES (42, 37, 5);
INSERT INTO public.students_subjects VALUES (42, 22, 3);
INSERT INTO public.students_subjects VALUES (42, 22, 4);
INSERT INTO public.students_subjects VALUES (42, 22, 5);
INSERT INTO public.students_subjects VALUES (42, 27, 3);
INSERT INTO public.students_subjects VALUES (42, 27, 4);
INSERT INTO public.students_subjects VALUES (42, 27, 5);
INSERT INTO public.students_subjects VALUES (43, 11, 1);
INSERT INTO public.students_subjects VALUES (43, 11, 2);
INSERT INTO public.students_subjects VALUES (43, 11, 3);
INSERT INTO public.students_subjects VALUES (43, 11, 4);
INSERT INTO public.students_subjects VALUES (43, 11, 5);
INSERT INTO public.students_subjects VALUES (43, 13, 1);
INSERT INTO public.students_subjects VALUES (43, 13, 2);
INSERT INTO public.students_subjects VALUES (43, 13, 3);
INSERT INTO public.students_subjects VALUES (43, 13, 4);
INSERT INTO public.students_subjects VALUES (43, 13, 5);
INSERT INTO public.students_subjects VALUES (43, 20, 1);
INSERT INTO public.students_subjects VALUES (43, 20, 2);
INSERT INTO public.students_subjects VALUES (43, 20, 3);
INSERT INTO public.students_subjects VALUES (43, 20, 4);
INSERT INTO public.students_subjects VALUES (43, 20, 5);
INSERT INTO public.students_subjects VALUES (43, 31, 1);
INSERT INTO public.students_subjects VALUES (43, 31, 2);
INSERT INTO public.students_subjects VALUES (43, 31, 3);
INSERT INTO public.students_subjects VALUES (43, 31, 4);
INSERT INTO public.students_subjects VALUES (43, 31, 5);
INSERT INTO public.students_subjects VALUES (43, 32, 1);
INSERT INTO public.students_subjects VALUES (43, 32, 2);
INSERT INTO public.students_subjects VALUES (43, 32, 3);
INSERT INTO public.students_subjects VALUES (43, 32, 4);
INSERT INTO public.students_subjects VALUES (43, 32, 5);
INSERT INTO public.students_subjects VALUES (43, 34, 1);
INSERT INTO public.students_subjects VALUES (43, 34, 2);
INSERT INTO public.students_subjects VALUES (43, 34, 3);
INSERT INTO public.students_subjects VALUES (43, 34, 4);
INSERT INTO public.students_subjects VALUES (43, 34, 5);
INSERT INTO public.students_subjects VALUES (43, 37, 1);
INSERT INTO public.students_subjects VALUES (43, 37, 2);
INSERT INTO public.students_subjects VALUES (43, 37, 3);
INSERT INTO public.students_subjects VALUES (43, 37, 4);
INSERT INTO public.students_subjects VALUES (43, 37, 5);
INSERT INTO public.students_subjects VALUES (43, 27, 3);
INSERT INTO public.students_subjects VALUES (43, 27, 4);
INSERT INTO public.students_subjects VALUES (43, 27, 5);
INSERT INTO public.students_subjects VALUES (43, 28, 3);
INSERT INTO public.students_subjects VALUES (43, 28, 4);
INSERT INTO public.students_subjects VALUES (43, 28, 5);
INSERT INTO public.students_subjects VALUES (44, 11, 1);
INSERT INTO public.students_subjects VALUES (44, 11, 2);
INSERT INTO public.students_subjects VALUES (44, 11, 3);
INSERT INTO public.students_subjects VALUES (44, 11, 4);
INSERT INTO public.students_subjects VALUES (44, 11, 5);
INSERT INTO public.students_subjects VALUES (44, 13, 1);
INSERT INTO public.students_subjects VALUES (44, 13, 2);
INSERT INTO public.students_subjects VALUES (44, 13, 3);
INSERT INTO public.students_subjects VALUES (44, 13, 4);
INSERT INTO public.students_subjects VALUES (44, 13, 5);
INSERT INTO public.students_subjects VALUES (44, 20, 1);
INSERT INTO public.students_subjects VALUES (44, 20, 2);
INSERT INTO public.students_subjects VALUES (44, 20, 3);
INSERT INTO public.students_subjects VALUES (44, 20, 4);
INSERT INTO public.students_subjects VALUES (44, 20, 5);
INSERT INTO public.students_subjects VALUES (44, 31, 1);
INSERT INTO public.students_subjects VALUES (44, 31, 2);
INSERT INTO public.students_subjects VALUES (44, 31, 3);
INSERT INTO public.students_subjects VALUES (44, 31, 4);
INSERT INTO public.students_subjects VALUES (44, 31, 5);
INSERT INTO public.students_subjects VALUES (44, 32, 1);
INSERT INTO public.students_subjects VALUES (44, 32, 2);
INSERT INTO public.students_subjects VALUES (44, 32, 3);
INSERT INTO public.students_subjects VALUES (44, 32, 4);
INSERT INTO public.students_subjects VALUES (44, 32, 5);
INSERT INTO public.students_subjects VALUES (44, 34, 1);
INSERT INTO public.students_subjects VALUES (44, 34, 2);
INSERT INTO public.students_subjects VALUES (44, 34, 3);
INSERT INTO public.students_subjects VALUES (44, 34, 4);
INSERT INTO public.students_subjects VALUES (44, 34, 5);
INSERT INTO public.students_subjects VALUES (44, 37, 1);
INSERT INTO public.students_subjects VALUES (44, 37, 2);
INSERT INTO public.students_subjects VALUES (44, 37, 3);
INSERT INTO public.students_subjects VALUES (44, 37, 4);
INSERT INTO public.students_subjects VALUES (44, 37, 5);
INSERT INTO public.students_subjects VALUES (44, 14, 3);
INSERT INTO public.students_subjects VALUES (44, 14, 4);
INSERT INTO public.students_subjects VALUES (44, 14, 5);
INSERT INTO public.students_subjects VALUES (44, 27, 3);
INSERT INTO public.students_subjects VALUES (44, 27, 4);
INSERT INTO public.students_subjects VALUES (44, 27, 5);
INSERT INTO public.students_subjects VALUES (45, 11, 1);
INSERT INTO public.students_subjects VALUES (45, 11, 2);
INSERT INTO public.students_subjects VALUES (45, 11, 3);
INSERT INTO public.students_subjects VALUES (45, 11, 4);
INSERT INTO public.students_subjects VALUES (45, 11, 5);
INSERT INTO public.students_subjects VALUES (45, 13, 1);
INSERT INTO public.students_subjects VALUES (45, 13, 2);
INSERT INTO public.students_subjects VALUES (45, 13, 3);
INSERT INTO public.students_subjects VALUES (45, 13, 4);
INSERT INTO public.students_subjects VALUES (45, 13, 5);
INSERT INTO public.students_subjects VALUES (45, 20, 1);
INSERT INTO public.students_subjects VALUES (45, 20, 2);
INSERT INTO public.students_subjects VALUES (45, 20, 3);
INSERT INTO public.students_subjects VALUES (45, 20, 4);
INSERT INTO public.students_subjects VALUES (45, 20, 5);
INSERT INTO public.students_subjects VALUES (45, 31, 1);
INSERT INTO public.students_subjects VALUES (45, 31, 2);
INSERT INTO public.students_subjects VALUES (45, 31, 3);
INSERT INTO public.students_subjects VALUES (45, 31, 4);
INSERT INTO public.students_subjects VALUES (45, 31, 5);
INSERT INTO public.students_subjects VALUES (45, 32, 1);
INSERT INTO public.students_subjects VALUES (45, 32, 2);
INSERT INTO public.students_subjects VALUES (45, 32, 3);
INSERT INTO public.students_subjects VALUES (45, 32, 4);
INSERT INTO public.students_subjects VALUES (45, 32, 5);
INSERT INTO public.students_subjects VALUES (45, 34, 1);
INSERT INTO public.students_subjects VALUES (45, 34, 2);
INSERT INTO public.students_subjects VALUES (45, 34, 3);
INSERT INTO public.students_subjects VALUES (45, 34, 4);
INSERT INTO public.students_subjects VALUES (45, 34, 5);
INSERT INTO public.students_subjects VALUES (45, 37, 1);
INSERT INTO public.students_subjects VALUES (45, 37, 2);
INSERT INTO public.students_subjects VALUES (45, 37, 3);
INSERT INTO public.students_subjects VALUES (45, 37, 4);
INSERT INTO public.students_subjects VALUES (45, 37, 5);
INSERT INTO public.students_subjects VALUES (45, 22, 3);
INSERT INTO public.students_subjects VALUES (45, 22, 4);
INSERT INTO public.students_subjects VALUES (45, 22, 5);
INSERT INTO public.students_subjects VALUES (45, 27, 3);
INSERT INTO public.students_subjects VALUES (45, 27, 4);
INSERT INTO public.students_subjects VALUES (45, 27, 5);
INSERT INTO public.students_subjects VALUES (46, 11, 1);
INSERT INTO public.students_subjects VALUES (46, 11, 2);
INSERT INTO public.students_subjects VALUES (46, 11, 3);
INSERT INTO public.students_subjects VALUES (46, 11, 4);
INSERT INTO public.students_subjects VALUES (46, 11, 5);
INSERT INTO public.students_subjects VALUES (46, 13, 1);
INSERT INTO public.students_subjects VALUES (46, 13, 2);
INSERT INTO public.students_subjects VALUES (46, 13, 3);
INSERT INTO public.students_subjects VALUES (46, 13, 4);
INSERT INTO public.students_subjects VALUES (46, 13, 5);
INSERT INTO public.students_subjects VALUES (46, 20, 1);
INSERT INTO public.students_subjects VALUES (46, 20, 2);
INSERT INTO public.students_subjects VALUES (46, 20, 3);
INSERT INTO public.students_subjects VALUES (46, 20, 4);
INSERT INTO public.students_subjects VALUES (46, 20, 5);
INSERT INTO public.students_subjects VALUES (46, 31, 1);
INSERT INTO public.students_subjects VALUES (46, 31, 2);
INSERT INTO public.students_subjects VALUES (46, 31, 3);
INSERT INTO public.students_subjects VALUES (46, 31, 4);
INSERT INTO public.students_subjects VALUES (46, 31, 5);
INSERT INTO public.students_subjects VALUES (46, 32, 1);
INSERT INTO public.students_subjects VALUES (46, 32, 2);
INSERT INTO public.students_subjects VALUES (46, 32, 3);
INSERT INTO public.students_subjects VALUES (46, 32, 4);
INSERT INTO public.students_subjects VALUES (46, 32, 5);
INSERT INTO public.students_subjects VALUES (46, 34, 1);
INSERT INTO public.students_subjects VALUES (46, 34, 2);
INSERT INTO public.students_subjects VALUES (46, 34, 3);
INSERT INTO public.students_subjects VALUES (46, 34, 4);
INSERT INTO public.students_subjects VALUES (46, 34, 5);
INSERT INTO public.students_subjects VALUES (46, 37, 1);
INSERT INTO public.students_subjects VALUES (46, 37, 2);
INSERT INTO public.students_subjects VALUES (46, 37, 3);
INSERT INTO public.students_subjects VALUES (46, 37, 4);
INSERT INTO public.students_subjects VALUES (46, 37, 5);
INSERT INTO public.students_subjects VALUES (46, 14, 3);
INSERT INTO public.students_subjects VALUES (46, 14, 4);
INSERT INTO public.students_subjects VALUES (46, 14, 5);
INSERT INTO public.students_subjects VALUES (46, 27, 3);
INSERT INTO public.students_subjects VALUES (46, 27, 4);
INSERT INTO public.students_subjects VALUES (46, 27, 5);
INSERT INTO public.students_subjects VALUES (7, 11, 1);
INSERT INTO public.students_subjects VALUES (7, 11, 2);
INSERT INTO public.students_subjects VALUES (7, 11, 3);
INSERT INTO public.students_subjects VALUES (7, 11, 4);
INSERT INTO public.students_subjects VALUES (7, 13, 1);
INSERT INTO public.students_subjects VALUES (7, 13, 2);
INSERT INTO public.students_subjects VALUES (7, 13, 3);
INSERT INTO public.students_subjects VALUES (7, 13, 4);
INSERT INTO public.students_subjects VALUES (7, 13, 5);
INSERT INTO public.students_subjects VALUES (7, 20, 1);
INSERT INTO public.students_subjects VALUES (7, 20, 2);
INSERT INTO public.students_subjects VALUES (7, 20, 3);
INSERT INTO public.students_subjects VALUES (7, 20, 4);
INSERT INTO public.students_subjects VALUES (7, 20, 5);
INSERT INTO public.students_subjects VALUES (7, 31, 1);
INSERT INTO public.students_subjects VALUES (7, 31, 2);
INSERT INTO public.students_subjects VALUES (7, 31, 3);
INSERT INTO public.students_subjects VALUES (7, 31, 4);
INSERT INTO public.students_subjects VALUES (7, 31, 5);
INSERT INTO public.students_subjects VALUES (7, 32, 1);
INSERT INTO public.students_subjects VALUES (7, 32, 2);
INSERT INTO public.students_subjects VALUES (7, 32, 3);
INSERT INTO public.students_subjects VALUES (7, 32, 4);
INSERT INTO public.students_subjects VALUES (7, 32, 5);
INSERT INTO public.students_subjects VALUES (7, 34, 1);
INSERT INTO public.students_subjects VALUES (7, 34, 2);
INSERT INTO public.students_subjects VALUES (7, 34, 3);
INSERT INTO public.students_subjects VALUES (7, 34, 4);
INSERT INTO public.students_subjects VALUES (7, 34, 5);
INSERT INTO public.students_subjects VALUES (7, 37, 1);
INSERT INTO public.students_subjects VALUES (7, 37, 2);
INSERT INTO public.students_subjects VALUES (7, 37, 3);
INSERT INTO public.students_subjects VALUES (7, 37, 4);
INSERT INTO public.students_subjects VALUES (7, 37, 5);
INSERT INTO public.students_subjects VALUES (7, 22, 3);
INSERT INTO public.students_subjects VALUES (7, 22, 4);
INSERT INTO public.students_subjects VALUES (7, 22, 5);
INSERT INTO public.students_subjects VALUES (7, 28, 3);
INSERT INTO public.students_subjects VALUES (7, 28, 4);
INSERT INTO public.students_subjects VALUES (7, 28, 5);
INSERT INTO public.students_subjects VALUES (8, 11, 1);
INSERT INTO public.students_subjects VALUES (8, 11, 2);
INSERT INTO public.students_subjects VALUES (8, 11, 3);
INSERT INTO public.students_subjects VALUES (8, 11, 4);
INSERT INTO public.students_subjects VALUES (8, 11, 5);
INSERT INTO public.students_subjects VALUES (8, 13, 1);
INSERT INTO public.students_subjects VALUES (8, 13, 2);
INSERT INTO public.students_subjects VALUES (8, 13, 3);
INSERT INTO public.students_subjects VALUES (8, 13, 4);
INSERT INTO public.students_subjects VALUES (8, 13, 5);
INSERT INTO public.students_subjects VALUES (8, 20, 1);
INSERT INTO public.students_subjects VALUES (8, 20, 2);
INSERT INTO public.students_subjects VALUES (8, 20, 3);
INSERT INTO public.students_subjects VALUES (8, 20, 4);
INSERT INTO public.students_subjects VALUES (8, 20, 5);
INSERT INTO public.students_subjects VALUES (8, 31, 1);
INSERT INTO public.students_subjects VALUES (8, 31, 2);
INSERT INTO public.students_subjects VALUES (8, 31, 3);
INSERT INTO public.students_subjects VALUES (8, 31, 4);
INSERT INTO public.students_subjects VALUES (8, 31, 5);
INSERT INTO public.students_subjects VALUES (8, 32, 1);
INSERT INTO public.students_subjects VALUES (8, 32, 2);
INSERT INTO public.students_subjects VALUES (8, 32, 3);
INSERT INTO public.students_subjects VALUES (8, 32, 4);
INSERT INTO public.students_subjects VALUES (8, 32, 5);
INSERT INTO public.students_subjects VALUES (8, 34, 1);
INSERT INTO public.students_subjects VALUES (8, 34, 2);
INSERT INTO public.students_subjects VALUES (8, 34, 3);
INSERT INTO public.students_subjects VALUES (8, 34, 4);
INSERT INTO public.students_subjects VALUES (8, 34, 5);
INSERT INTO public.students_subjects VALUES (8, 37, 1);
INSERT INTO public.students_subjects VALUES (8, 37, 2);
INSERT INTO public.students_subjects VALUES (8, 37, 3);
INSERT INTO public.students_subjects VALUES (8, 37, 4);
INSERT INTO public.students_subjects VALUES (8, 37, 5);
INSERT INTO public.students_subjects VALUES (8, 29, 3);
INSERT INTO public.students_subjects VALUES (8, 29, 4);
INSERT INTO public.students_subjects VALUES (8, 29, 5);
INSERT INTO public.students_subjects VALUES (8, 22, 3);
INSERT INTO public.students_subjects VALUES (8, 22, 4);
INSERT INTO public.students_subjects VALUES (8, 22, 5);
INSERT INTO public.students_subjects VALUES (9, 11, 1);
INSERT INTO public.students_subjects VALUES (9, 11, 2);
INSERT INTO public.students_subjects VALUES (9, 11, 3);
INSERT INTO public.students_subjects VALUES (9, 11, 4);
INSERT INTO public.students_subjects VALUES (9, 11, 5);
INSERT INTO public.students_subjects VALUES (9, 13, 1);
INSERT INTO public.students_subjects VALUES (9, 13, 2);
INSERT INTO public.students_subjects VALUES (9, 13, 3);
INSERT INTO public.students_subjects VALUES (9, 13, 4);
INSERT INTO public.students_subjects VALUES (9, 13, 5);
INSERT INTO public.students_subjects VALUES (9, 20, 1);
INSERT INTO public.students_subjects VALUES (9, 20, 2);
INSERT INTO public.students_subjects VALUES (9, 20, 3);
INSERT INTO public.students_subjects VALUES (9, 20, 4);
INSERT INTO public.students_subjects VALUES (9, 20, 5);
INSERT INTO public.students_subjects VALUES (9, 31, 1);
INSERT INTO public.students_subjects VALUES (9, 31, 2);
INSERT INTO public.students_subjects VALUES (9, 31, 3);
INSERT INTO public.students_subjects VALUES (9, 31, 4);
INSERT INTO public.students_subjects VALUES (9, 31, 5);
INSERT INTO public.students_subjects VALUES (9, 32, 1);
INSERT INTO public.students_subjects VALUES (9, 32, 2);
INSERT INTO public.students_subjects VALUES (9, 32, 3);
INSERT INTO public.students_subjects VALUES (9, 32, 4);
INSERT INTO public.students_subjects VALUES (9, 32, 5);
INSERT INTO public.students_subjects VALUES (9, 34, 1);
INSERT INTO public.students_subjects VALUES (9, 34, 2);
INSERT INTO public.students_subjects VALUES (9, 34, 3);
INSERT INTO public.students_subjects VALUES (9, 34, 4);
INSERT INTO public.students_subjects VALUES (9, 34, 5);
INSERT INTO public.students_subjects VALUES (9, 37, 1);
INSERT INTO public.students_subjects VALUES (9, 37, 2);
INSERT INTO public.students_subjects VALUES (9, 37, 3);
INSERT INTO public.students_subjects VALUES (9, 37, 4);
INSERT INTO public.students_subjects VALUES (9, 37, 5);
INSERT INTO public.students_subjects VALUES (9, 28, 3);
INSERT INTO public.students_subjects VALUES (9, 28, 4);
INSERT INTO public.students_subjects VALUES (9, 28, 5);
INSERT INTO public.students_subjects VALUES (9, 29, 3);
INSERT INTO public.students_subjects VALUES (9, 29, 4);
INSERT INTO public.students_subjects VALUES (9, 29, 5);
INSERT INTO public.students_subjects VALUES (10, 23, 1);
INSERT INTO public.students_subjects VALUES (11, 23, 1);
INSERT INTO public.students_subjects VALUES (12, 23, 1);
INSERT INTO public.students_subjects VALUES (13, 23, 1);
INSERT INTO public.students_subjects VALUES (14, 23, 1);
INSERT INTO public.students_subjects VALUES (15, 23, 1);
INSERT INTO public.students_subjects VALUES (16, 23, 1);
INSERT INTO public.students_subjects VALUES (17, 23, 1);
INSERT INTO public.students_subjects VALUES (18, 23, 1);
INSERT INTO public.students_subjects VALUES (19, 23, 1);
INSERT INTO public.students_subjects VALUES (20, 23, 1);
INSERT INTO public.students_subjects VALUES (21, 23, 1);
INSERT INTO public.students_subjects VALUES (22, 23, 1);
INSERT INTO public.students_subjects VALUES (23, 23, 1);
INSERT INTO public.students_subjects VALUES (24, 23, 1);
INSERT INTO public.students_subjects VALUES (25, 23, 1);
INSERT INTO public.students_subjects VALUES (26, 23, 1);
INSERT INTO public.students_subjects VALUES (27, 23, 1);
INSERT INTO public.students_subjects VALUES (28, 23, 1);
INSERT INTO public.students_subjects VALUES (29, 23, 1);
INSERT INTO public.students_subjects VALUES (30, 23, 1);
INSERT INTO public.students_subjects VALUES (31, 23, 1);
INSERT INTO public.students_subjects VALUES (32, 23, 1);
INSERT INTO public.students_subjects VALUES (33, 23, 1);
INSERT INTO public.students_subjects VALUES (34, 23, 1);
INSERT INTO public.students_subjects VALUES (35, 23, 1);
INSERT INTO public.students_subjects VALUES (36, 23, 1);
INSERT INTO public.students_subjects VALUES (37, 23, 1);
INSERT INTO public.students_subjects VALUES (38, 23, 1);
INSERT INTO public.students_subjects VALUES (39, 23, 1);
INSERT INTO public.students_subjects VALUES (40, 23, 1);
INSERT INTO public.students_subjects VALUES (41, 23, 1);
INSERT INTO public.students_subjects VALUES (42, 23, 1);
INSERT INTO public.students_subjects VALUES (43, 23, 1);
INSERT INTO public.students_subjects VALUES (44, 23, 1);
INSERT INTO public.students_subjects VALUES (45, 23, 1);
INSERT INTO public.students_subjects VALUES (46, 23, 1);
INSERT INTO public.students_subjects VALUES (7, 23, 1);
INSERT INTO public.students_subjects VALUES (8, 23, 1);
INSERT INTO public.students_subjects VALUES (9, 23, 1);
INSERT INTO public.students_subjects VALUES (7, 35, 6);
INSERT INTO public.students_subjects VALUES (7, 15, 6);
INSERT INTO public.students_subjects VALUES (7, 33, 6);
INSERT INTO public.students_subjects VALUES (7, 19, 6);
INSERT INTO public.students_subjects VALUES (8, 15, 6);
INSERT INTO public.students_subjects VALUES (8, 19, 6);
INSERT INTO public.students_subjects VALUES (8, 36, 6);
INSERT INTO public.students_subjects VALUES (8, 33, 6);
INSERT INTO public.students_subjects VALUES (9, 33, 6);
INSERT INTO public.students_subjects VALUES (9, 33, 7);
INSERT INTO public.students_subjects VALUES (9, 26, 6);
INSERT INTO public.students_subjects VALUES (9, 26, 7);
INSERT INTO public.students_subjects VALUES (9, 12, 6);
INSERT INTO public.students_subjects VALUES (9, 12, 7);
INSERT INTO public.students_subjects VALUES (9, 19, 6);
INSERT INTO public.students_subjects VALUES (9, 19, 7);
INSERT INTO public.students_subjects VALUES (10, 15, 6);
INSERT INTO public.students_subjects VALUES (10, 26, 6);
INSERT INTO public.students_subjects VALUES (10, 36, 6);
INSERT INTO public.students_subjects VALUES (10, 19, 6);
INSERT INTO public.students_subjects VALUES (11, 30, 6);
INSERT INTO public.students_subjects VALUES (11, 30, 7);
INSERT INTO public.students_subjects VALUES (11, 15, 6);
INSERT INTO public.students_subjects VALUES (11, 15, 7);
INSERT INTO public.students_subjects VALUES (11, 26, 6);
INSERT INTO public.students_subjects VALUES (11, 26, 7);
INSERT INTO public.students_subjects VALUES (11, 12, 6);
INSERT INTO public.students_subjects VALUES (11, 12, 7);
INSERT INTO public.students_subjects VALUES (12, 35, 6);
INSERT INTO public.students_subjects VALUES (12, 35, 7);
INSERT INTO public.students_subjects VALUES (12, 12, 6);
INSERT INTO public.students_subjects VALUES (12, 12, 7);
INSERT INTO public.students_subjects VALUES (12, 30, 6);
INSERT INTO public.students_subjects VALUES (12, 30, 7);
INSERT INTO public.students_subjects VALUES (12, 24, 6);
INSERT INTO public.students_subjects VALUES (12, 24, 7);
INSERT INTO public.students_subjects VALUES (13, 36, 6);
INSERT INTO public.students_subjects VALUES (13, 36, 7);
INSERT INTO public.students_subjects VALUES (13, 19, 6);
INSERT INTO public.students_subjects VALUES (13, 19, 7);
INSERT INTO public.students_subjects VALUES (13, 15, 6);
INSERT INTO public.students_subjects VALUES (13, 15, 7);
INSERT INTO public.students_subjects VALUES (13, 24, 6);
INSERT INTO public.students_subjects VALUES (13, 24, 7);
INSERT INTO public.students_subjects VALUES (14, 26, 6);
INSERT INTO public.students_subjects VALUES (14, 26, 7);
INSERT INTO public.students_subjects VALUES (14, 30, 6);
INSERT INTO public.students_subjects VALUES (14, 30, 7);
INSERT INTO public.students_subjects VALUES (14, 15, 6);
INSERT INTO public.students_subjects VALUES (14, 15, 7);
INSERT INTO public.students_subjects VALUES (14, 36, 6);
INSERT INTO public.students_subjects VALUES (14, 36, 7);
INSERT INTO public.students_subjects VALUES (15, 12, 6);
INSERT INTO public.students_subjects VALUES (15, 12, 7);
INSERT INTO public.students_subjects VALUES (15, 15, 6);
INSERT INTO public.students_subjects VALUES (15, 15, 7);
INSERT INTO public.students_subjects VALUES (15, 36, 6);
INSERT INTO public.students_subjects VALUES (15, 36, 7);
INSERT INTO public.students_subjects VALUES (15, 30, 6);
INSERT INTO public.students_subjects VALUES (15, 30, 7);
INSERT INTO public.students_subjects VALUES (16, 12, 6);
INSERT INTO public.students_subjects VALUES (16, 12, 7);
INSERT INTO public.students_subjects VALUES (16, 26, 6);
INSERT INTO public.students_subjects VALUES (16, 26, 7);
INSERT INTO public.students_subjects VALUES (16, 36, 6);
INSERT INTO public.students_subjects VALUES (16, 36, 7);
INSERT INTO public.students_subjects VALUES (16, 33, 6);
INSERT INTO public.students_subjects VALUES (16, 33, 7);
INSERT INTO public.students_subjects VALUES (17, 19, 6);
INSERT INTO public.students_subjects VALUES (17, 19, 7);
INSERT INTO public.students_subjects VALUES (17, 21, 6);
INSERT INTO public.students_subjects VALUES (17, 21, 7);
INSERT INTO public.students_subjects VALUES (17, 30, 6);
INSERT INTO public.students_subjects VALUES (17, 30, 7);
INSERT INTO public.students_subjects VALUES (17, 33, 6);
INSERT INTO public.students_subjects VALUES (17, 33, 7);
INSERT INTO public.students_subjects VALUES (18, 19, 6);
INSERT INTO public.students_subjects VALUES (18, 19, 7);
INSERT INTO public.students_subjects VALUES (18, 36, 6);
INSERT INTO public.students_subjects VALUES (18, 36, 7);
INSERT INTO public.students_subjects VALUES (18, 33, 6);
INSERT INTO public.students_subjects VALUES (18, 33, 7);
INSERT INTO public.students_subjects VALUES (18, 18, 6);
INSERT INTO public.students_subjects VALUES (18, 18, 7);
INSERT INTO public.students_subjects VALUES (19, 33, 6);
INSERT INTO public.students_subjects VALUES (19, 33, 7);
INSERT INTO public.students_subjects VALUES (19, 19, 6);
INSERT INTO public.students_subjects VALUES (19, 19, 7);
INSERT INTO public.students_subjects VALUES (19, 12, 6);
INSERT INTO public.students_subjects VALUES (19, 12, 7);
INSERT INTO public.students_subjects VALUES (19, 21, 6);
INSERT INTO public.students_subjects VALUES (19, 21, 7);
INSERT INTO public.students_subjects VALUES (20, 33, 6);
INSERT INTO public.students_subjects VALUES (20, 33, 7);
INSERT INTO public.students_subjects VALUES (20, 36, 6);
INSERT INTO public.students_subjects VALUES (20, 36, 7);
INSERT INTO public.students_subjects VALUES (20, 15, 6);
INSERT INTO public.students_subjects VALUES (20, 15, 7);
INSERT INTO public.students_subjects VALUES (20, 25, 6);
INSERT INTO public.students_subjects VALUES (20, 25, 7);
INSERT INTO public.students_subjects VALUES (21, 19, 6);
INSERT INTO public.students_subjects VALUES (21, 19, 7);
INSERT INTO public.students_subjects VALUES (21, 35, 6);
INSERT INTO public.students_subjects VALUES (21, 35, 7);
INSERT INTO public.students_subjects VALUES (21, 15, 6);
INSERT INTO public.students_subjects VALUES (21, 15, 7);
INSERT INTO public.students_subjects VALUES (21, 12, 6);
INSERT INTO public.students_subjects VALUES (21, 12, 7);
INSERT INTO public.students_subjects VALUES (22, 26, 6);
INSERT INTO public.students_subjects VALUES (22, 26, 7);
INSERT INTO public.students_subjects VALUES (22, 21, 6);
INSERT INTO public.students_subjects VALUES (22, 21, 7);
INSERT INTO public.students_subjects VALUES (22, 36, 6);
INSERT INTO public.students_subjects VALUES (22, 36, 7);
INSERT INTO public.students_subjects VALUES (22, 15, 6);
INSERT INTO public.students_subjects VALUES (22, 15, 7);
INSERT INTO public.students_subjects VALUES (23, 15, 6);
INSERT INTO public.students_subjects VALUES (23, 15, 7);
INSERT INTO public.students_subjects VALUES (23, 30, 6);
INSERT INTO public.students_subjects VALUES (23, 30, 7);
INSERT INTO public.students_subjects VALUES (23, 18, 6);
INSERT INTO public.students_subjects VALUES (23, 18, 7);
INSERT INTO public.students_subjects VALUES (23, 19, 6);
INSERT INTO public.students_subjects VALUES (23, 19, 7);
INSERT INTO public.students_subjects VALUES (24, 30, 6);
INSERT INTO public.students_subjects VALUES (24, 30, 7);
INSERT INTO public.students_subjects VALUES (24, 21, 6);
INSERT INTO public.students_subjects VALUES (24, 21, 7);
INSERT INTO public.students_subjects VALUES (24, 35, 6);
INSERT INTO public.students_subjects VALUES (24, 35, 7);
INSERT INTO public.students_subjects VALUES (24, 15, 6);
INSERT INTO public.students_subjects VALUES (24, 15, 7);
INSERT INTO public.students_subjects VALUES (25, 24, 6);
INSERT INTO public.students_subjects VALUES (25, 24, 7);
INSERT INTO public.students_subjects VALUES (25, 15, 6);
INSERT INTO public.students_subjects VALUES (25, 15, 7);
INSERT INTO public.students_subjects VALUES (25, 12, 6);
INSERT INTO public.students_subjects VALUES (25, 12, 7);
INSERT INTO public.students_subjects VALUES (25, 19, 6);
INSERT INTO public.students_subjects VALUES (25, 19, 7);
INSERT INTO public.students_subjects VALUES (26, 12, 6);
INSERT INTO public.students_subjects VALUES (26, 12, 7);
INSERT INTO public.students_subjects VALUES (26, 15, 6);
INSERT INTO public.students_subjects VALUES (26, 15, 7);
INSERT INTO public.students_subjects VALUES (26, 36, 6);
INSERT INTO public.students_subjects VALUES (26, 36, 7);
INSERT INTO public.students_subjects VALUES (26, 35, 6);
INSERT INTO public.students_subjects VALUES (26, 35, 7);
INSERT INTO public.students_subjects VALUES (27, 12, 6);
INSERT INTO public.students_subjects VALUES (27, 12, 7);
INSERT INTO public.students_subjects VALUES (27, 35, 6);
INSERT INTO public.students_subjects VALUES (27, 35, 7);
INSERT INTO public.students_subjects VALUES (27, 21, 6);
INSERT INTO public.students_subjects VALUES (27, 21, 7);
INSERT INTO public.students_subjects VALUES (27, 15, 6);
INSERT INTO public.students_subjects VALUES (27, 15, 7);
INSERT INTO public.students_subjects VALUES (28, 26, 6);
INSERT INTO public.students_subjects VALUES (28, 26, 7);
INSERT INTO public.students_subjects VALUES (28, 35, 6);
INSERT INTO public.students_subjects VALUES (28, 35, 7);
INSERT INTO public.students_subjects VALUES (28, 12, 6);
INSERT INTO public.students_subjects VALUES (28, 12, 7);
INSERT INTO public.students_subjects VALUES (28, 30, 6);
INSERT INTO public.students_subjects VALUES (28, 30, 7);
INSERT INTO public.students_subjects VALUES (29, 19, 6);
INSERT INTO public.students_subjects VALUES (29, 19, 7);
INSERT INTO public.students_subjects VALUES (29, 36, 6);
INSERT INTO public.students_subjects VALUES (29, 36, 7);
INSERT INTO public.students_subjects VALUES (29, 35, 6);
INSERT INTO public.students_subjects VALUES (29, 35, 7);
INSERT INTO public.students_subjects VALUES (29, 33, 6);
INSERT INTO public.students_subjects VALUES (29, 33, 7);
INSERT INTO public.students_subjects VALUES (30, 26, 6);
INSERT INTO public.students_subjects VALUES (30, 26, 7);
INSERT INTO public.students_subjects VALUES (30, 35, 6);
INSERT INTO public.students_subjects VALUES (30, 35, 7);
INSERT INTO public.students_subjects VALUES (30, 33, 6);
INSERT INTO public.students_subjects VALUES (30, 33, 7);
INSERT INTO public.students_subjects VALUES (30, 12, 6);
INSERT INTO public.students_subjects VALUES (30, 12, 7);
INSERT INTO public.students_subjects VALUES (31, 15, 6);
INSERT INTO public.students_subjects VALUES (31, 15, 7);
INSERT INTO public.students_subjects VALUES (31, 36, 6);
INSERT INTO public.students_subjects VALUES (31, 36, 7);
INSERT INTO public.students_subjects VALUES (31, 24, 6);
INSERT INTO public.students_subjects VALUES (31, 24, 7);
INSERT INTO public.students_subjects VALUES (31, 12, 6);
INSERT INTO public.students_subjects VALUES (31, 12, 7);
INSERT INTO public.students_subjects VALUES (32, 30, 6);
INSERT INTO public.students_subjects VALUES (32, 30, 7);
INSERT INTO public.students_subjects VALUES (32, 12, 6);
INSERT INTO public.students_subjects VALUES (32, 12, 7);
INSERT INTO public.students_subjects VALUES (32, 24, 6);
INSERT INTO public.students_subjects VALUES (32, 24, 7);
INSERT INTO public.students_subjects VALUES (32, 15, 6);
INSERT INTO public.students_subjects VALUES (32, 15, 7);
INSERT INTO public.students_subjects VALUES (33, 30, 6);
INSERT INTO public.students_subjects VALUES (33, 30, 7);
INSERT INTO public.students_subjects VALUES (33, 35, 6);
INSERT INTO public.students_subjects VALUES (33, 35, 7);
INSERT INTO public.students_subjects VALUES (33, 15, 6);
INSERT INTO public.students_subjects VALUES (33, 15, 7);
INSERT INTO public.students_subjects VALUES (33, 36, 6);
INSERT INTO public.students_subjects VALUES (33, 36, 7);
INSERT INTO public.students_subjects VALUES (34, 35, 6);
INSERT INTO public.students_subjects VALUES (34, 35, 7);
INSERT INTO public.students_subjects VALUES (34, 15, 6);
INSERT INTO public.students_subjects VALUES (34, 15, 7);
INSERT INTO public.students_subjects VALUES (34, 19, 6);
INSERT INTO public.students_subjects VALUES (34, 19, 7);
INSERT INTO public.students_subjects VALUES (34, 30, 6);
INSERT INTO public.students_subjects VALUES (34, 30, 7);
INSERT INTO public.students_subjects VALUES (35, 19, 6);
INSERT INTO public.students_subjects VALUES (35, 19, 7);
INSERT INTO public.students_subjects VALUES (35, 26, 6);
INSERT INTO public.students_subjects VALUES (35, 26, 7);
INSERT INTO public.students_subjects VALUES (35, 35, 6);
INSERT INTO public.students_subjects VALUES (35, 35, 7);
INSERT INTO public.students_subjects VALUES (35, 33, 6);
INSERT INTO public.students_subjects VALUES (35, 33, 7);
INSERT INTO public.students_subjects VALUES (36, 30, 6);
INSERT INTO public.students_subjects VALUES (36, 30, 7);
INSERT INTO public.students_subjects VALUES (36, 35, 6);
INSERT INTO public.students_subjects VALUES (36, 35, 7);
INSERT INTO public.students_subjects VALUES (36, 15, 6);
INSERT INTO public.students_subjects VALUES (36, 15, 7);
INSERT INTO public.students_subjects VALUES (36, 12, 6);
INSERT INTO public.students_subjects VALUES (36, 12, 7);
INSERT INTO public.students_subjects VALUES (37, 19, 6);
INSERT INTO public.students_subjects VALUES (37, 19, 7);
INSERT INTO public.students_subjects VALUES (37, 15, 6);
INSERT INTO public.students_subjects VALUES (37, 15, 7);
INSERT INTO public.students_subjects VALUES (37, 21, 6);
INSERT INTO public.students_subjects VALUES (37, 21, 7);
INSERT INTO public.students_subjects VALUES (37, 35, 6);
INSERT INTO public.students_subjects VALUES (37, 35, 7);
INSERT INTO public.students_subjects VALUES (38, 12, 6);
INSERT INTO public.students_subjects VALUES (38, 12, 7);
INSERT INTO public.students_subjects VALUES (38, 35, 6);
INSERT INTO public.students_subjects VALUES (38, 35, 7);
INSERT INTO public.students_subjects VALUES (38, 30, 6);
INSERT INTO public.students_subjects VALUES (38, 30, 7);
INSERT INTO public.students_subjects VALUES (38, 18, 6);
INSERT INTO public.students_subjects VALUES (38, 18, 7);
INSERT INTO public.students_subjects VALUES (39, 15, 6);
INSERT INTO public.students_subjects VALUES (39, 12, 6);
INSERT INTO public.students_subjects VALUES (39, 21, 6);
INSERT INTO public.students_subjects VALUES (39, 19, 6);
INSERT INTO public.students_subjects VALUES (40, 19, 6);
INSERT INTO public.students_subjects VALUES (40, 19, 7);
INSERT INTO public.students_subjects VALUES (40, 30, 6);
INSERT INTO public.students_subjects VALUES (40, 30, 7);
INSERT INTO public.students_subjects VALUES (40, 21, 6);
INSERT INTO public.students_subjects VALUES (40, 21, 7);
INSERT INTO public.students_subjects VALUES (40, 24, 6);
INSERT INTO public.students_subjects VALUES (40, 24, 7);
INSERT INTO public.students_subjects VALUES (41, 19, 6);
INSERT INTO public.students_subjects VALUES (41, 19, 7);
INSERT INTO public.students_subjects VALUES (41, 30, 6);
INSERT INTO public.students_subjects VALUES (41, 30, 7);
INSERT INTO public.students_subjects VALUES (41, 36, 6);
INSERT INTO public.students_subjects VALUES (41, 36, 7);
INSERT INTO public.students_subjects VALUES (41, 26, 6);
INSERT INTO public.students_subjects VALUES (41, 26, 7);
INSERT INTO public.students_subjects VALUES (42, 33, 6);
INSERT INTO public.students_subjects VALUES (42, 33, 7);
INSERT INTO public.students_subjects VALUES (42, 15, 6);
INSERT INTO public.students_subjects VALUES (42, 15, 7);
INSERT INTO public.students_subjects VALUES (42, 36, 6);
INSERT INTO public.students_subjects VALUES (42, 36, 7);
INSERT INTO public.students_subjects VALUES (42, 21, 6);
INSERT INTO public.students_subjects VALUES (42, 21, 7);
INSERT INTO public.students_subjects VALUES (44, 18, 6);
INSERT INTO public.students_subjects VALUES (44, 18, 7);
INSERT INTO public.students_subjects VALUES (44, 36, 6);
INSERT INTO public.students_subjects VALUES (44, 36, 7);
INSERT INTO public.students_subjects VALUES (44, 12, 6);
INSERT INTO public.students_subjects VALUES (44, 12, 7);
INSERT INTO public.students_subjects VALUES (44, 19, 6);
INSERT INTO public.students_subjects VALUES (44, 19, 7);
INSERT INTO public.students_subjects VALUES (45, 30, 6);
INSERT INTO public.students_subjects VALUES (45, 21, 6);
INSERT INTO public.students_subjects VALUES (45, 36, 6);
INSERT INTO public.students_subjects VALUES (45, 15, 6);
INSERT INTO public.students_subjects VALUES (46, 12, 6);
INSERT INTO public.students_subjects VALUES (46, 12, 7);
INSERT INTO public.students_subjects VALUES (46, 18, 6);
INSERT INTO public.students_subjects VALUES (46, 18, 7);
INSERT INTO public.students_subjects VALUES (46, 15, 6);
INSERT INTO public.students_subjects VALUES (46, 15, 7);
INSERT INTO public.students_subjects VALUES (46, 24, 6);
INSERT INTO public.students_subjects VALUES (46, 24, 7);


--
-- Data for Name: subject_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.subject_type OVERRIDING SYSTEM VALUE VALUES (11, 'Mandatory', 15);
INSERT INTO public.subject_type OVERRIDING SYSTEM VALUE VALUES (12, 'Elective', 15);
INSERT INTO public.subject_type OVERRIDING SYSTEM VALUE VALUES (13, 'Course', 0);
INSERT INTO public.subject_type OVERRIDING SYSTEM VALUE VALUES (14, 'Practical', 5);
INSERT INTO public.subject_type OVERRIDING SYSTEM VALUE VALUES (15, 'Extracurricular', 10);


--
-- Data for Name: subjects; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (11, 'Potions', 1, 5, 11, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (12, 'Potions', 6, 7, 12, 14);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (13, 'Transfiguration', 1, 5, 11, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (14, 'Care of Magical Creatures', 3, 5, 12, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (17, 'Apparition', 6, 6, 13, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (20, 'Astronomy', 1, 5, 11, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (22, 'Arithmancy', 3, 5, 12, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (23, 'Flying', 1, 1, 14, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (27, 'Muggle Studies', 3, 5, 12, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (28, 'Study of Ancient Runes', 3, 5, 12, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (29, 'Divination', 3, 5, 12, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (31, 'History of Magic', 1, 5, 11, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (32, 'Herbology', 1, 5, 11, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (34, 'Charms', 1, 5, 11, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (37, 'Defence Against the Dark Arts', 1, 5, 11, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (15, 'Transfiguration', 6, 7, 12, 14);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (38, 'Ghoul Studies', 1, 7, 15, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (39, 'Ancient Studies', 1, 7, 15, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (40, 'Xylomancy', 1, 7, 15, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (41, 'Muggle Music', 1, 7, 15, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (42, 'Art', 3, 7, 15, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (43, 'Frog Choir', 1, 7, 15, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (44, 'Magical Theory', 1, 7, 15, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (45, 'Flying', 2, 7, 15, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (46, 'Music', 3, 7, 15, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (47, 'Muggle Art', 1, 7, 15, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (48, 'Hogwarts Orchestra', 1, 7, 15, NULL);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (16, 'Alchemy', 6, 7, 12, 14);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (18, 'Care of Magical Creatures', 6, 7, 12, 15);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (19, 'Astronomy', 6, 7, 12, 15);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (21, 'Arithmancy', 6, 7, 12, 14);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (24, 'Muggle Studies', 6, 7, 12, 15);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (25, 'Study of Ancient Runes', 6, 7, 12, 14);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (26, 'Divination', 6, 7, 12, 15);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (30, 'Defence Against the Dark Arts', 6, 7, 12, 14);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (33, 'Charms', 6, 7, 12, 14);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (35, 'Herbology', 6, 7, 12, 14);
INSERT INTO public.subjects OVERRIDING SYSTEM VALUE VALUES (36, 'History of Magic', 6, 7, 12, 15);


--
-- Data for Name: wands; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (7, 'Holly', 'Phoenix feather', 11, 7, NULL);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (8, 'Fir', 'Dragon heartstring', 9.5, NULL, 5);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (9, 'Ash', 'Unicorn hair', 10, NULL, NULL);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (10, 'Ash', 'Unicorn hair', 8.5, 7, NULL);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (11, 'Blackthorn', 'Dragon heartstring', 10.25, 7, NULL);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (12, 'Cedar', 'Phoenix feather', 12, 8, NULL);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (13, 'Cherry', 'Veela hair', 13.75, 8, NULL);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (14, 'Cypress', 'Thestral tail hair', 9.25, 8, NULL);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (15, 'Ebony', 'Kelpie hair', 11, 9, NULL);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (16, 'Elm', 'Kneazle whisker', 12.75, 9, NULL);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (17, 'Fir', 'Unicorn hair', 14.5, 9, NULL);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (18, 'Hawthorn', 'Dragon heartstring', 10, NULL, 5);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (19, 'Hazel', 'Phoenix feather', 11.75, NULL, 5);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (20, 'Holly', 'Veela hair', 13.5, NULL, 9);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (21, 'Maple', 'Thestral tail hair', 9, NULL, 9);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (22, 'Oak', 'Kelpie hair', 10.75, NULL, 9);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (23, 'Rowan', 'Kneazle whisker', 12.5, NULL, 10);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (24, 'Willow', 'Unicorn hair', 14.25, NULL, 10);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (25, 'Yew', 'Dragon heartstring', 9.75, NULL, 10);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (26, 'Ash', 'Veela hair', 11.5, NULL, 11);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (27, 'Blackthorn', 'Thestral tail hair', 13.25, NULL, 11);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (28, 'Cedar', 'Kelpie hair', 8.75, NULL, 11);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (29, 'Cherry', 'Kneazle whisker', 10.5, NULL, 12);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (30, 'Cypress', 'Unicorn hair', 12.25, NULL, 12);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (31, 'Ebony', 'Dragon heartstring', 14, NULL, 12);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (32, 'Elm', 'Phoenix feather', 9.5, NULL, 13);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (33, 'Fir', 'Veela hair', 11.25, NULL, 13);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (34, 'Hawthorn', 'Thestral tail hair', 13, NULL, 13);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (35, 'Hazel', 'Kelpie hair', 8.5, NULL, 16);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (36, 'Holly', 'Kneazle whisker', 10.25, NULL, 16);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (37, 'Maple', 'Unicorn hair', 12, NULL, 16);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (38, 'Oak', 'Dragon heartstring', 13.75, NULL, 17);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (39, 'Rowan', 'Phoenix feather', 9.25, NULL, 17);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (40, 'Willow', 'Veela hair', 11, NULL, 17);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (41, 'Yew', 'Thestral tail hair', 12.75, NULL, 18);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (42, 'Ash', 'Kneazle whisker', 14.5, NULL, 18);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (43, 'Blackthorn', 'Unicorn hair', 10, NULL, 18);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (44, 'Cedar', 'Dragon heartstring', 11.75, NULL, 22);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (45, 'Cherry', 'Phoenix feather', 13.5, NULL, 22);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (46, 'Cypress', 'Veela hair', 9, NULL, 22);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (47, 'Ebony', 'Thestral tail hair', 10.75, NULL, 23);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (48, 'Elm', 'Kelpie hair', 12.5, NULL, 23);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (49, 'Fir', 'Kneazle whisker', 14.25, NULL, 23);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (50, 'Hawthorn', 'Unicorn hair', 9.75, NULL, 24);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (51, 'Hazel', 'Dragon heartstring', 11.5, NULL, 24);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (52, 'Holly', 'Phoenix feather', 13.25, NULL, 24);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (53, 'Maple', 'Veela hair', 8.75, NULL, 25);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (54, 'Oak', 'Thestral tail hair', 10.5, NULL, 25);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (55, 'Rowan', 'Kelpie hair', 12.25, NULL, 25);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (56, 'Willow', 'Kneazle whisker', 14, NULL, 26);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (57, 'Yew', 'Unicorn hair', 9.5, NULL, 26);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (58, 'Ash', 'Phoenix feather', 11.25, NULL, 26);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (59, 'Blackthorn', 'Veela hair', 13, NULL, 29);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (60, 'Cedar', 'Thestral tail hair', 8.5, NULL, 29);
INSERT INTO public.wands OVERRIDING SYSTEM VALUE VALUES (61, 'Cherry', 'Kelpie hair', 10.25, NULL, 29);


--
-- Name: grades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grades_id_seq', 18, true);


--
-- Name: houses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.houses_id_seq', 12, true);


--
-- Name: qualifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.qualifications_id_seq', 12, true);


--
-- Name: regulators_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.regulators_id_seq', 12, true);


--
-- Name: staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.staff_id_seq', 40, true);


--
-- Name: students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.students_id_seq', 46, true);


--
-- Name: subject_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subject_type_id_seq', 15, true);


--
-- Name: subjects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subjects_id_seq', 48, true);


--
-- Name: wands_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wands_id_seq', 61, true);


--
-- Name: exams exams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exams
    ADD CONSTRAINT exams_pkey PRIMARY KEY (fk_subject_id, fk_student_id, date);


--
-- Name: grades grades_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_name_key UNIQUE (name);


--
-- Name: grades grades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_pkey PRIMARY KEY (id);


--
-- Name: grades grades_symbol_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_symbol_key UNIQUE (symbol);


--
-- Name: houses houses_fk_founder_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.houses
    ADD CONSTRAINT houses_fk_founder_key UNIQUE (fk_founder);


--
-- Name: houses houses_fk_head_of_house_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.houses
    ADD CONSTRAINT houses_fk_head_of_house_key UNIQUE (fk_head_of_house);


--
-- Name: houses houses_fk_house_ghost_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.houses
    ADD CONSTRAINT houses_fk_house_ghost_key UNIQUE (fk_house_ghost);


--
-- Name: houses houses_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.houses
    ADD CONSTRAINT houses_name_key UNIQUE (name);


--
-- Name: houses houses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.houses
    ADD CONSTRAINT houses_pkey PRIMARY KEY (id);


--
-- Name: qualifications qualifications_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qualifications
    ADD CONSTRAINT qualifications_name_key UNIQUE (name);


--
-- Name: qualifications qualifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.qualifications
    ADD CONSTRAINT qualifications_pkey PRIMARY KEY (id);


--
-- Name: regulators regulators_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regulators
    ADD CONSTRAINT regulators_name_key UNIQUE (name);


--
-- Name: regulators regulators_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regulators
    ADD CONSTRAINT regulators_pkey PRIMARY KEY (id);


--
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (id);


--
-- Name: staff_subjects staff_subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff_subjects
    ADD CONSTRAINT staff_subjects_pkey PRIMARY KEY (fk_subject_id, fk_staff_id);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: students_subjects students_subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students_subjects
    ADD CONSTRAINT students_subjects_pkey PRIMARY KEY (fk_student_id, fk_subject_id, year);


--
-- Name: subjects subject_grade_level; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT subject_grade_level UNIQUE (name, fk_required_grade);


--
-- Name: subject_type subject_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subject_type
    ADD CONSTRAINT subject_type_pkey PRIMARY KEY (id);


--
-- Name: subjects subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT subjects_pkey PRIMARY KEY (id);


--
-- Name: wands wands_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wands
    ADD CONSTRAINT wands_pkey PRIMARY KEY (id);


--
-- Name: exams exams_fk_grade_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exams
    ADD CONSTRAINT exams_fk_grade_id_fkey FOREIGN KEY (fk_grade_id) REFERENCES public.grades(id);


--
-- Name: exams exams_fk_qualifications_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exams
    ADD CONSTRAINT exams_fk_qualifications_fkey FOREIGN KEY (fk_qualifications) REFERENCES public.qualifications(id);


--
-- Name: exams exams_fk_regulators_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exams
    ADD CONSTRAINT exams_fk_regulators_fkey FOREIGN KEY (fk_regulators) REFERENCES public.regulators(id);


--
-- Name: exams exams_fk_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exams
    ADD CONSTRAINT exams_fk_student_id_fkey FOREIGN KEY (fk_student_id) REFERENCES public.students(id);


--
-- Name: exams exams_fk_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exams
    ADD CONSTRAINT exams_fk_subject_id_fkey FOREIGN KEY (fk_subject_id) REFERENCES public.subjects(id);


--
-- Name: houses houses_founder_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.houses
    ADD CONSTRAINT houses_founder_fk FOREIGN KEY (fk_founder) REFERENCES public.staff(id);


--
-- Name: houses houses_head_of_house_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.houses
    ADD CONSTRAINT houses_head_of_house_fk FOREIGN KEY (fk_head_of_house) REFERENCES public.staff(id);


--
-- Name: houses houses_house_ghost_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.houses
    ADD CONSTRAINT houses_house_ghost_fk FOREIGN KEY (fk_house_ghost) REFERENCES public.staff(id);


--
-- Name: staff staff_fk_house_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_fk_house_fkey FOREIGN KEY (fk_house) REFERENCES public.houses(id);


--
-- Name: staff_subjects staff_subjects_fk_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff_subjects
    ADD CONSTRAINT staff_subjects_fk_staff_id_fkey FOREIGN KEY (fk_staff_id) REFERENCES public.staff(id);


--
-- Name: staff_subjects staff_subjects_fk_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff_subjects
    ADD CONSTRAINT staff_subjects_fk_subject_id_fkey FOREIGN KEY (fk_subject_id) REFERENCES public.subjects(id);


--
-- Name: students students_fk_house_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_fk_house_fkey FOREIGN KEY (fk_house) REFERENCES public.houses(id);


--
-- Name: students_subjects students_subjects_fk_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students_subjects
    ADD CONSTRAINT students_subjects_fk_student_id_fkey FOREIGN KEY (fk_student_id) REFERENCES public.students(id);


--
-- Name: students_subjects students_subjects_fk_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students_subjects
    ADD CONSTRAINT students_subjects_fk_subject_id_fkey FOREIGN KEY (fk_subject_id) REFERENCES public.subjects(id);


--
-- Name: subjects subjects_fk_required_grade_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT subjects_fk_required_grade_fkey FOREIGN KEY (fk_required_grade) REFERENCES public.grades(id);


--
-- Name: subjects subjects_fk_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT subjects_fk_type_fkey FOREIGN KEY (fk_type) REFERENCES public.subject_type(id);


--
-- Name: wands wands_fk_staff_owner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wands
    ADD CONSTRAINT wands_fk_staff_owner_fkey FOREIGN KEY (fk_staff_owner) REFERENCES public.staff(id);


--
-- Name: wands wands_fk_student_owner_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wands
    ADD CONSTRAINT wands_fk_student_owner_fkey FOREIGN KEY (fk_student_owner) REFERENCES public.students(id);


--
-- PostgreSQL database dump complete
--

\unrestrict j1xEAWbgSUtJgjtxcCf0kYYoQSBHhlzTeuQgoc2vY1TLT8e5w55RU97jDTh4kvd

