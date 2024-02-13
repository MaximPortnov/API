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
2	maxim	po	123	f	
3	maxsim	pso	123	f	
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

