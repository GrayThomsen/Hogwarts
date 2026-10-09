--
-- PostgreSQL database dump
--

\restrict 920PXncdZ59AvLh9HHOTzOl6GLWVegZ90XFZne02zUwlLEO9v6pGIRPevEWTgea

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

COPY public.classes (id, name) FROM stdin;
1	Astronomy
2	Charms
3	Defence Against the Dark Arts
4	Herbology
5	History of Magic
6	Potions
7	Transfiguration
8	Flying
9	Arithmancy
10	Care of Magical Creatures
11	Divination
12	Muggle Studies
13	Study of Ancient Runes
14	Alchemy
15	Apparition
\.


--
-- Data for Name: houses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.houses (id, name, house_ghost, head_of_house) FROM stdin;
1	Gryffindor	4	3
2	Slytherin	6	1
3	Ravenclaw	7	8
4	Hufflepuff	5	9
\.


--
-- Data for Name: staff; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.staff (id, first_name, last_name, role) FROM stdin;
1	Severus	Snape	Teacher
2	Albus	Dumbledore	Head Master
4	Nicholas de Mimsy	Porpington	Ghost
5	The Fat Friar		Ghost
6	The Bloody Baron		Ghost
7	Helena	Ravenclaw	Ghost
8	Filius	Flitwick	Teacher
9	Pomona	Sprout	Teacher
3	Minerva	McGonagall	Teacher
\.


--
-- Data for Name: student_classes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.student_classes (student_id, class_id, year) FROM stdin;
1	8	1
1	7	1
1	4	1
1	3	1
1	6	1
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.students (id, first_name, last_name, house) FROM stdin;
1	Harry	Potter	1
2	Ron	Weasley	1
3	Hermione	Granger	1
4	Neville	Longbottom	1
5	Seamus	Finnigan	1
6	Dean	Thomas	1
7	Parvati	Patil	1
8	Draco	Malfoy	2
9	Vincent	Crabbe	2
10	Gregory	Goyle	2
11	Terry	Boot	3
12	Padma	Patil	3
13	Justin	Finch-Fletchley	4
\.


--
-- Data for Name: teacher_classes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teacher_classes (teacher_id, class_id) FROM stdin;
1	3
1	6
\.


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

SELECT pg_catalog.setval('public.students_id_seq', 13, true);


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

\unrestrict 920PXncdZ59AvLh9HHOTzOl6GLWVegZ90XFZne02zUwlLEO9v6pGIRPevEWTgea

