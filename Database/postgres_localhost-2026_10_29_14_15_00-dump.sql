--
-- PostgreSQL database dump
--

\restrict LMewmnVKTWTnF0Yahd4Abb3PQtvnGE6ICHdSDmHmVLDdeUsuJMgtBPvsJaiNxUR

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
-- Name: classes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.classes (
    id integer NOT NULL,
    name character varying(120) NOT NULL
);


ALTER TABLE public.classes OWNER TO postgres;

--
-- Name: classes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.classes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.classes_id_seq OWNER TO postgres;

--
-- Name: classes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.classes_id_seq OWNED BY public.classes.id;


--
-- Name: houses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.houses (
    id integer NOT NULL,
    name character varying(120) NOT NULL,
    house_ghost integer,
    head_of_house integer
);


ALTER TABLE public.houses OWNER TO postgres;

--
-- Name: houses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.houses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.houses_id_seq OWNER TO postgres;

--
-- Name: houses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.houses_id_seq OWNED BY public.houses.id;


--
-- Name: staff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.staff (
    id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100),
    role character varying(100)
);


ALTER TABLE public.staff OWNER TO postgres;

--
-- Name: staff_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.staff_id_seq OWNER TO postgres;

--
-- Name: staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.staff_id_seq OWNED BY public.staff.id;


--
-- Name: student_classes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.student_classes (
    student_id integer NOT NULL,
    class_id integer NOT NULL,
    year integer NOT NULL
);


ALTER TABLE public.student_classes OWNER TO postgres;

--
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100),
    house integer
);


ALTER TABLE public.students OWNER TO postgres;

--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.students_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.students_id_seq OWNER TO postgres;

--
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.students_id_seq OWNED BY public.students.id;


--
-- Name: teacher_classes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teacher_classes (
    teacher_id integer NOT NULL,
    class_id integer NOT NULL
);


ALTER TABLE public.teacher_classes OWNER TO postgres;

--
-- Name: classes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes ALTER COLUMN id SET DEFAULT nextval('public.classes_id_seq'::regclass);


--
-- Name: houses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.houses ALTER COLUMN id SET DEFAULT nextval('public.houses_id_seq'::regclass);


--
-- Name: staff id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff ALTER COLUMN id SET DEFAULT nextval('public.staff_id_seq'::regclass);


--
-- Name: students id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students ALTER COLUMN id SET DEFAULT nextval('public.students_id_seq'::regclass);


--
-- Data for Name: classes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.classes VALUES (1, 'Astronomy');
INSERT INTO public.classes VALUES (2, 'Charms');
INSERT INTO public.classes VALUES (3, 'Defence Against the Dark Arts');
INSERT INTO public.classes VALUES (4, 'Herbology');
INSERT INTO public.classes VALUES (5, 'History of Magic');
INSERT INTO public.classes VALUES (6, 'Potions');
INSERT INTO public.classes VALUES (7, 'Transfiguration');
INSERT INTO public.classes VALUES (8, 'Flying');
INSERT INTO public.classes VALUES (9, 'Arithmancy');
INSERT INTO public.classes VALUES (10, 'Care of Magical Creatures');
INSERT INTO public.classes VALUES (11, 'Divination');
INSERT INTO public.classes VALUES (12, 'Muggle Studies');
INSERT INTO public.classes VALUES (13, 'Study of Ancient Runes');
INSERT INTO public.classes VALUES (14, 'Alchemy');
INSERT INTO public.classes VALUES (15, 'Apparition');


--
-- Data for Name: houses; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.houses VALUES (1, 'Gryffindor', 4, 3);
INSERT INTO public.houses VALUES (2, 'Slytherin', 6, 1);
INSERT INTO public.houses VALUES (3, 'Ravenclaw', 7, 8);
INSERT INTO public.houses VALUES (4, 'Hufflepuff', 5, 9);


--
-- Data for Name: staff; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.staff VALUES (1, 'Severus', 'Snape', 'Teacher');
INSERT INTO public.staff VALUES (2, 'Albus', 'Dumbledore', 'Head Master');
INSERT INTO public.staff VALUES (4, 'Nicholas de Mimsy', 'Porpington', 'Ghost');
INSERT INTO public.staff VALUES (5, 'The Fat Friar', '', 'Ghost');
INSERT INTO public.staff VALUES (6, 'The Bloody Baron', '', 'Ghost');
INSERT INTO public.staff VALUES (7, 'Helena', 'Ravenclaw', 'Ghost');
INSERT INTO public.staff VALUES (8, 'Filius', 'Flitwick', 'Teacher');
INSERT INTO public.staff VALUES (9, 'Pomona', 'Sprout', 'Teacher');
INSERT INTO public.staff VALUES (3, 'Minerva', 'McGonagall', 'Teacher');


--
-- Data for Name: student_classes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.student_classes VALUES (1, 8, 1);
INSERT INTO public.student_classes VALUES (1, 7, 1);
INSERT INTO public.student_classes VALUES (1, 4, 1);
INSERT INTO public.student_classes VALUES (1, 3, 1);
INSERT INTO public.student_classes VALUES (1, 6, 1);


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.students VALUES (1, 'Harry', 'Potter', 1);
INSERT INTO public.students VALUES (2, 'Ron', 'Weasley', 1);
INSERT INTO public.students VALUES (3, 'Hermione', 'Granger', 1);
INSERT INTO public.students VALUES (4, 'Neville', 'Longbottom', 1);
INSERT INTO public.students VALUES (5, 'Seamus', 'Finnigan', 1);
INSERT INTO public.students VALUES (6, 'Dean', 'Thomas', 1);
INSERT INTO public.students VALUES (7, 'Parvati', 'Patil', 1);
INSERT INTO public.students VALUES (8, 'Draco', 'Malfoy', 2);
INSERT INTO public.students VALUES (9, 'Vincent', 'Crabbe', 2);
INSERT INTO public.students VALUES (10, 'Gregory', 'Goyle', 2);
INSERT INTO public.students VALUES (11, 'Terry', 'Boot', 3);
INSERT INTO public.students VALUES (12, 'Padma', 'Patil', 3);
INSERT INTO public.students VALUES (13, 'Justin', 'Finch-Fletchley', 4);
INSERT INTO public.students VALUES (16, 'Emil', 'Thomsen', 2);


--
-- Data for Name: teacher_classes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.teacher_classes VALUES (1, 3);
INSERT INTO public.teacher_classes VALUES (1, 6);


--
-- Name: classes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.classes_id_seq', 15, true);


--
-- Name: houses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.houses_id_seq', 4, true);


--
-- Name: staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.staff_id_seq', 9, true);


--
-- Name: students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.students_id_seq', 16, true);


--
-- Name: classes classes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_pkey PRIMARY KEY (id);


--
-- Name: houses houses_head_of_house_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.houses
    ADD CONSTRAINT houses_head_of_house_key UNIQUE (head_of_house);


--
-- Name: houses houses_house_ghost_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.houses
    ADD CONSTRAINT houses_house_ghost_key UNIQUE (house_ghost);


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
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (id);


--
-- Name: student_classes student_classes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_classes
    ADD CONSTRAINT student_classes_pkey PRIMARY KEY (student_id, class_id, year);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: teacher_classes teacher_classes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_classes
    ADD CONSTRAINT teacher_classes_pkey PRIMARY KEY (teacher_id, class_id);


--
-- Name: houses houses_head_of_house_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.houses
    ADD CONSTRAINT houses_head_of_house_fkey FOREIGN KEY (head_of_house) REFERENCES public.staff(id);


--
-- Name: houses houses_house_ghost_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.houses
    ADD CONSTRAINT houses_house_ghost_fkey FOREIGN KEY (house_ghost) REFERENCES public.staff(id);


--
-- Name: student_classes student_classes_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_classes
    ADD CONSTRAINT student_classes_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.classes(id);


--
-- Name: student_classes student_classes_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.student_classes
    ADD CONSTRAINT student_classes_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(id);


--
-- Name: students students_house_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_house_fkey FOREIGN KEY (house) REFERENCES public.houses(id);


--
-- Name: teacher_classes teacher_classes_class_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_classes
    ADD CONSTRAINT teacher_classes_class_id_fkey FOREIGN KEY (class_id) REFERENCES public.classes(id);


--
-- Name: teacher_classes teacher_classes_teacher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teacher_classes
    ADD CONSTRAINT teacher_classes_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES public.staff(id);


--
-- PostgreSQL database dump complete
--

\unrestrict LMewmnVKTWTnF0Yahd4Abb3PQtvnGE6ICHdSDmHmVLDdeUsuJMgtBPvsJaiNxUR

