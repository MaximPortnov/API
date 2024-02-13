--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1 (Debian 16.1-1.pgdg120+1)
-- Dumped by pg_dump version 16.1 (Debian 16.1-1.pgdg120+1)

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
-- Name: Cars; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Cars" (
    "CarID" bigint NOT NULL,
    "Model" text NOT NULL,
    "Color" text NOT NULL,
    "Number" text NOT NULL,
    "IsFree" boolean NOT NULL,
    "LocationX" double precision NOT NULL,
    "LocationY" double precision NOT NULL
);


ALTER TABLE public."Cars" OWNER TO postgres;

--
-- Name: History; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."History" (
    "HistoryID" bigint NOT NULL,
    "UserID" bigint NOT NULL,
    "CarID" bigint NOT NULL,
    "TravelTime" time(6) without time zone NOT NULL
);


ALTER TABLE public."History" OWNER TO postgres;

--
-- Name: Users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Users" (
    "UserID" bigint NOT NULL,
    "UserName" text NOT NULL,
    "Email" text NOT NULL,
    "Password" text NOT NULL,
    "Login" boolean NOT NULL,
    "Token" text NOT NULL
);


ALTER TABLE public."Users" OWNER TO postgres;

--
-- Data for Name: Cars; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Cars" ("CarID", "Model", "Color", "Number", "IsFree", "LocationX", "LocationY") FROM stdin;
\.


--
-- Data for Name: History; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."History" ("HistoryID", "UserID", "CarID", "TravelTime") FROM stdin;
\.


--
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Users" ("UserID", "UserName", "Email", "Password", "Login", "Token") FROM stdin;
1       maxim   portmaxalex@mail.ru     123     t       29aed7075d238cdde703d61bd4ac3ffe
2       maxim   portmaxalex@mail.ru     123     t       29aed7075d238cdde703d61bd4ac3ffe
3       jeka    email@email.com 11      f       cbb406ba208462a50e194e10c2063f91
4       qwerty  string  qwerty  t       26faa272c5f99d2b0b6e6c41b6e9d295
5       qwerty1 email@gmail     qwerty1 t       5b7405c2b4f90ce9256246e4d7ba1f50
6       a       a       12345   f       cbb406ba208462a50e194e10c2063f91
7       Passha  main@mail.ru    123     t       7f70a9323837cf31a014703d890bfd84
8       Serg23  Serg@mail.ru    321     t       5040a039a9ec9d56ec4d6428bb7dae1e
9       Serg231 Serg23@mail.ru  321     f       cbb406ba208462a50e194e10c2063f91
10      Stepan  space@stepan.cum        88005553535     t       55b9d9dc129119ba0dd7db99e458da19
11      1       1       1       f          cbb406ba208462a50e194e10c2063f91
12      ega     ega     1       t       cbb406ba208462a50e194e10c2063f91
13      kiri22  kiri22@mail.ru  123     t       004fde6b11fdbdcf8a0d07c304bc2dfc
14      Alex    wer@mail.ru     123     f       cbb406ba208462a50e194e10c2063f91
15      kirill  kirill@mail.ru  123     t       48a75b0730b2d7bd9f7c692ceda2477c
16      kir     kir@mail.ru     123     f       cbb406ba208462a50e194e10c2063f91
17      dd      dd      dd      f       cbb406ba208462a50e194e10c2063f91
18      kirr    kirmail 123     t       1e8e1039e6e993481da8ec2936e6aba5
19      kir2    kirfjwl 123     f       cbb406ba208462a50e194e10c2063f91
\.


--
-- Name: Cars Cars_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cars"
    ADD CONSTRAINT "Cars_pkey" PRIMARY KEY ("CarID");


--
-- Name: History History_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."History"
    ADD CONSTRAINT "History_pkey" PRIMARY KEY ("HistoryID");


--
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY ("UserID");


--
-- PostgreSQL database dump complete
--