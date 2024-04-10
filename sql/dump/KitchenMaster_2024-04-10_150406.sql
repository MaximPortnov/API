--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.1

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
-- Name: Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Category" (
    id integer NOT NULL,
    "Title" integer
);


ALTER TABLE public."Category" OWNER TO postgres;

--
-- Name: Category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Category_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Category_id_seq" OWNER TO postgres;

--
-- Name: Category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Category_id_seq" OWNED BY public."Category".id;


--
-- Name: CookStep; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CookStep" (
    id integer NOT NULL,
    "id_Recipe" integer,
    step_num integer,
    step_text character varying,
    step_image character varying
);


ALTER TABLE public."CookStep" OWNER TO postgres;

--
-- Name: CookStep_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."CookStep_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."CookStep_id_seq" OWNER TO postgres;

--
-- Name: CookStep_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."CookStep_id_seq" OWNED BY public."CookStep".id;


--
-- Name: MeasureType; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."MeasureType" (
    id integer NOT NULL,
    title text
);


ALTER TABLE public."MeasureType" OWNER TO postgres;

--
-- Name: MeasureType_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."MeasureType_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."MeasureType_id_seq" OWNER TO postgres;

--
-- Name: MeasureType_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."MeasureType_id_seq" OWNED BY public."MeasureType".id;


--
-- Name: Product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Product" (
    id integer NOT NULL,
    "id_productType" integer,
    "Title" character varying
);


ALTER TABLE public."Product" OWNER TO postgres;

--
-- Name: ProductType; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ProductType" (
    id integer NOT NULL,
    "Title" character varying
);


ALTER TABLE public."ProductType" OWNER TO postgres;

--
-- Name: ProductType_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."ProductType_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ProductType_id_seq" OWNER TO postgres;

--
-- Name: ProductType_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."ProductType_id_seq" OWNED BY public."ProductType".id;


--
-- Name: Product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Product_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Product_id_seq" OWNER TO postgres;

--
-- Name: Product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Product_id_seq" OWNED BY public."Product".id;


--
-- Name: Recipe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Recipe" (
    id integer NOT NULL,
    title character varying,
    cooking_time time without time zone,
    kkal integer,
    "id_CreatorUser" integer,
    image_url character varying
);


ALTER TABLE public."Recipe" OWNER TO postgres;

--
-- Name: RecipeCategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."RecipeCategory" (
    id integer NOT NULL,
    "id_Recipe" integer,
    "id_Category" integer
);


ALTER TABLE public."RecipeCategory" OWNER TO postgres;

--
-- Name: RecipeCategory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."RecipeCategory_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."RecipeCategory_id_seq" OWNER TO postgres;

--
-- Name: RecipeCategory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."RecipeCategory_id_seq" OWNED BY public."RecipeCategory".id;


--
-- Name: RecipeIngredient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."RecipeIngredient" (
    id integer NOT NULL,
    "id_Product" integer,
    "id_Recipe" integer,
    "id_MeasureType" integer,
    count integer
);


ALTER TABLE public."RecipeIngredient" OWNER TO postgres;

--
-- Name: RecipeIngredient_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."RecipeIngredient_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."RecipeIngredient_id_seq" OWNER TO postgres;

--
-- Name: RecipeIngredient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."RecipeIngredient_id_seq" OWNED BY public."RecipeIngredient".id;


--
-- Name: Recipe_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Recipe_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Recipe_id_seq" OWNER TO postgres;

--
-- Name: Recipe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Recipe_id_seq" OWNED BY public."Recipe".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    "id_userRole" integer,
    name character varying,
    region character varying,
    birth_date date,
    created_date timestamp without time zone
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- Name: UserCredential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserCredential" (
    id integer NOT NULL,
    "Login" character varying,
    "Password" character varying,
    email character varying,
    "refreshToken" character varying,
    "refreshTokenDate" timestamp without time zone
);


ALTER TABLE public."UserCredential" OWNER TO postgres;

--
-- Name: UserCredential_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UserCredential_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."UserCredential_id_seq" OWNER TO postgres;

--
-- Name: UserCredential_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UserCredential_id_seq" OWNED BY public."UserCredential".id;


--
-- Name: UserProduct; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserProduct" (
    id integer NOT NULL,
    "id_User" integer,
    "id_Product" integer
);


ALTER TABLE public."UserProduct" OWNER TO postgres;

--
-- Name: UserProduct_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UserProduct_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."UserProduct_id_seq" OWNER TO postgres;

--
-- Name: UserProduct_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UserProduct_id_seq" OWNED BY public."UserProduct".id;


--
-- Name: UserRecipe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserRecipe" (
    id integer NOT NULL,
    "id_User" integer,
    "id_Recipe" integer
);


ALTER TABLE public."UserRecipe" OWNER TO postgres;

--
-- Name: UserRecipe_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UserRecipe_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."UserRecipe_id_seq" OWNER TO postgres;

--
-- Name: UserRecipe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UserRecipe_id_seq" OWNED BY public."UserRecipe".id;


--
-- Name: UserRole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UserRole" (
    id integer NOT NULL,
    title character varying
);


ALTER TABLE public."UserRole" OWNER TO postgres;

--
-- Name: UserRole_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."UserRole_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."UserRole_id_seq" OWNER TO postgres;

--
-- Name: UserRole_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."UserRole_id_seq" OWNED BY public."UserRole".id;


--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."User_id_seq" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: Category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category" ALTER COLUMN id SET DEFAULT nextval('public."Category_id_seq"'::regclass);


--
-- Name: CookStep id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CookStep" ALTER COLUMN id SET DEFAULT nextval('public."CookStep_id_seq"'::regclass);


--
-- Name: MeasureType id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MeasureType" ALTER COLUMN id SET DEFAULT nextval('public."MeasureType_id_seq"'::regclass);


--
-- Name: Product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product" ALTER COLUMN id SET DEFAULT nextval('public."Product_id_seq"'::regclass);


--
-- Name: ProductType id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductType" ALTER COLUMN id SET DEFAULT nextval('public."ProductType_id_seq"'::regclass);


--
-- Name: Recipe id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Recipe" ALTER COLUMN id SET DEFAULT nextval('public."Recipe_id_seq"'::regclass);


--
-- Name: RecipeCategory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RecipeCategory" ALTER COLUMN id SET DEFAULT nextval('public."RecipeCategory_id_seq"'::regclass);


--
-- Name: RecipeIngredient id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RecipeIngredient" ALTER COLUMN id SET DEFAULT nextval('public."RecipeIngredient_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Name: UserCredential id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserCredential" ALTER COLUMN id SET DEFAULT nextval('public."UserCredential_id_seq"'::regclass);


--
-- Name: UserProduct id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserProduct" ALTER COLUMN id SET DEFAULT nextval('public."UserProduct_id_seq"'::regclass);


--
-- Name: UserRecipe id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRecipe" ALTER COLUMN id SET DEFAULT nextval('public."UserRecipe_id_seq"'::regclass);


--
-- Name: UserRole id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRole" ALTER COLUMN id SET DEFAULT nextval('public."UserRole_id_seq"'::regclass);


--
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Category" (id, "Title") FROM stdin;
\.


--
-- Data for Name: CookStep; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."CookStep" (id, "id_Recipe", step_num, step_text, step_image) FROM stdin;
1	1	1	Спагетти варить 7-10 минут в кипящей подсоленной воде и откинуть на дуршлаг.	https://telegra.ph/file/d8093794d3c21315adeea.jpg
2	1	2	В сковороде разогрейте оливковое масло, положите чеснок и слегка подрумяньте.	https://telegra.ph/file/d8093794d3c21315adeea.jpg
3	1	3	Ветчину/бекон мелко нарежьте, добавьте к чесноку и обжаривайте 5 минут.	https://telegra.ph/file/d8093794d3c21315adeea.jpg
4	1	4	Смешайте эту адскую смесь	https://telegra.ph/file/d8093794d3c21315adeea.jpg
5	1	5	Блюдо готово!	\N
6	1	0	приготовьте ингредиенты	\N
\.


--
-- Data for Name: MeasureType; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."MeasureType" (id, title) FROM stdin;
1	мл
2	гр
3	кг
4	шт
\.


--
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Product" (id, "id_productType", "Title") FROM stdin;
1	\N	Молоко
2	\N	Мясо
3	\N	Сливки
4	\N	Сыр
5	\N	Колбаса
6	\N	Хлеб
7	\N	Вино
8	\N	Масло
9	\N	Ветчина
10	\N	Укроп
11	\N	Помидор
12	\N	Кукуруза
13	\N	Яблоко
14	\N	Яйца
15	\N	Огурец
\.


--
-- Data for Name: ProductType; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ProductType" (id, "Title") FROM stdin;
\.


--
-- Data for Name: Recipe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Recipe" (id, title, cooking_time, kkal, "id_CreatorUser", image_url) FROM stdin;
1	Карбонара	00:20:00	248	\N	\N
2	Болоньезе	00:40:00	248	\N	\N
3	Салат "у моря"	00:20:00	148	\N	\N
4	Суп "Харчо"	01:04:00	666	\N	\N
5	Божественный поцелуй	12:57:00	777	\N	\N
\.


--
-- Data for Name: RecipeCategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."RecipeCategory" (id, "id_Recipe", "id_Category") FROM stdin;
\.


--
-- Data for Name: RecipeIngredient; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."RecipeIngredient" (id, "id_Product", "id_Recipe", "id_MeasureType", count) FROM stdin;
1	1	1	1	200
2	2	1	1	200
3	3	1	1	200
4	4	1	1	200
5	5	1	1	200
6	1	2	1	5
7	6	3	1	5
8	6	4	1	5
9	6	5	1	5
10	7	5	1	5
11	8	5	1	5
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, "id_userRole", name, region, birth_date, created_date) FROM stdin;
\.


--
-- Data for Name: UserCredential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserCredential" (id, "Login", "Password", email, "refreshToken", "refreshTokenDate") FROM stdin;
\.


--
-- Data for Name: UserProduct; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserProduct" (id, "id_User", "id_Product") FROM stdin;
\.


--
-- Data for Name: UserRecipe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserRecipe" (id, "id_User", "id_Recipe") FROM stdin;
\.


--
-- Data for Name: UserRole; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."UserRole" (id, title) FROM stdin;
\.


--
-- Name: Category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Category_id_seq"', 1, false);


--
-- Name: CookStep_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."CookStep_id_seq"', 6, true);


--
-- Name: MeasureType_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."MeasureType_id_seq"', 4, true);


--
-- Name: ProductType_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ProductType_id_seq"', 1, false);


--
-- Name: Product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Product_id_seq"', 15, true);


--
-- Name: RecipeCategory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."RecipeCategory_id_seq"', 1, false);


--
-- Name: RecipeIngredient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."RecipeIngredient_id_seq"', 11, true);


--
-- Name: Recipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Recipe_id_seq"', 5, true);


--
-- Name: UserCredential_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UserCredential_id_seq"', 1, false);


--
-- Name: UserProduct_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UserProduct_id_seq"', 1, false);


--
-- Name: UserRecipe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UserRecipe_id_seq"', 1, false);


--
-- Name: UserRole_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UserRole_id_seq"', 1, false);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 1, false);


--
-- Name: Category Category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_pkey" PRIMARY KEY (id);


--
-- Name: CookStep CookStep_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CookStep"
    ADD CONSTRAINT "CookStep_pkey" PRIMARY KEY (id);


--
-- Name: MeasureType MeasureType_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MeasureType"
    ADD CONSTRAINT "MeasureType_pkey" PRIMARY KEY (id);


--
-- Name: ProductType ProductType_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductType"
    ADD CONSTRAINT "ProductType_pkey" PRIMARY KEY (id);


--
-- Name: Product Product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (id);


--
-- Name: RecipeCategory RecipeCategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RecipeCategory"
    ADD CONSTRAINT "RecipeCategory_pkey" PRIMARY KEY (id);


--
-- Name: RecipeIngredient RecipeIngredient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RecipeIngredient"
    ADD CONSTRAINT "RecipeIngredient_pkey" PRIMARY KEY (id);


--
-- Name: Recipe Recipe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Recipe"
    ADD CONSTRAINT "Recipe_pkey" PRIMARY KEY (id);


--
-- Name: UserCredential UserCredential_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserCredential"
    ADD CONSTRAINT "UserCredential_pkey" PRIMARY KEY (id);


--
-- Name: UserProduct UserProduct_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserProduct"
    ADD CONSTRAINT "UserProduct_pkey" PRIMARY KEY (id);


--
-- Name: UserRecipe UserRecipe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRecipe"
    ADD CONSTRAINT "UserRecipe_pkey" PRIMARY KEY (id);


--
-- Name: UserRole UserRole_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRole"
    ADD CONSTRAINT "UserRole_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: CookStep CookStep_id_Recipe_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CookStep"
    ADD CONSTRAINT "CookStep_id_Recipe_fkey" FOREIGN KEY ("id_Recipe") REFERENCES public."Recipe"(id);


--
-- Name: Product Product_id_productType_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_id_productType_fkey" FOREIGN KEY ("id_productType") REFERENCES public."ProductType"(id);


--
-- Name: RecipeCategory RecipeCategory_id_Category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RecipeCategory"
    ADD CONSTRAINT "RecipeCategory_id_Category_fkey" FOREIGN KEY ("id_Category") REFERENCES public."Category"(id);


--
-- Name: RecipeCategory RecipeCategory_id_Recipe_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RecipeCategory"
    ADD CONSTRAINT "RecipeCategory_id_Recipe_fkey" FOREIGN KEY ("id_Recipe") REFERENCES public."Recipe"(id);


--
-- Name: RecipeIngredient RecipeIngredient_id_MeasureType_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RecipeIngredient"
    ADD CONSTRAINT "RecipeIngredient_id_MeasureType_fkey" FOREIGN KEY ("id_MeasureType") REFERENCES public."MeasureType"(id);


--
-- Name: RecipeIngredient RecipeIngredient_id_Product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RecipeIngredient"
    ADD CONSTRAINT "RecipeIngredient_id_Product_fkey" FOREIGN KEY ("id_Product") REFERENCES public."Product"(id);


--
-- Name: RecipeIngredient RecipeIngredient_id_Recipe_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RecipeIngredient"
    ADD CONSTRAINT "RecipeIngredient_id_Recipe_fkey" FOREIGN KEY ("id_Recipe") REFERENCES public."Recipe"(id);


--
-- Name: Recipe Recipe_id_CreatorUser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Recipe"
    ADD CONSTRAINT "Recipe_id_CreatorUser_fkey" FOREIGN KEY ("id_CreatorUser") REFERENCES public."User"(id);


--
-- Name: UserCredential UserCredential_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserCredential"
    ADD CONSTRAINT "UserCredential_id_fkey" FOREIGN KEY (id) REFERENCES public."User"(id);


--
-- Name: UserProduct UserProduct_id_Product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserProduct"
    ADD CONSTRAINT "UserProduct_id_Product_fkey" FOREIGN KEY ("id_Product") REFERENCES public."Product"(id);


--
-- Name: UserProduct UserProduct_id_User_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserProduct"
    ADD CONSTRAINT "UserProduct_id_User_fkey" FOREIGN KEY ("id_User") REFERENCES public."User"(id);


--
-- Name: UserRecipe UserRecipe_id_Recipe_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRecipe"
    ADD CONSTRAINT "UserRecipe_id_Recipe_fkey" FOREIGN KEY ("id_Recipe") REFERENCES public."Recipe"(id);


--
-- Name: UserRecipe UserRecipe_id_User_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UserRecipe"
    ADD CONSTRAINT "UserRecipe_id_User_fkey" FOREIGN KEY ("id_User") REFERENCES public."User"(id);


--
-- Name: User User_id_userRole_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_id_userRole_fkey" FOREIGN KEY ("id_userRole") REFERENCES public."UserRole"(id);


--
-- Name: TABLE "Category"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Category" TO dimon;


--
-- Name: SEQUENCE "Category_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public."Category_id_seq" TO dimon;


--
-- Name: TABLE "CookStep"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."CookStep" TO dimon;


--
-- Name: SEQUENCE "CookStep_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public."CookStep_id_seq" TO dimon;


--
-- Name: TABLE "MeasureType"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."MeasureType" TO dimon;


--
-- Name: SEQUENCE "MeasureType_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public."MeasureType_id_seq" TO dimon;


--
-- Name: TABLE "Product"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Product" TO dimon;


--
-- Name: TABLE "ProductType"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."ProductType" TO dimon;


--
-- Name: SEQUENCE "ProductType_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public."ProductType_id_seq" TO dimon;


--
-- Name: SEQUENCE "Product_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public."Product_id_seq" TO dimon;


--
-- Name: TABLE "Recipe"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."Recipe" TO dimon;


--
-- Name: TABLE "RecipeCategory"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."RecipeCategory" TO dimon;


--
-- Name: SEQUENCE "RecipeCategory_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public."RecipeCategory_id_seq" TO dimon;


--
-- Name: TABLE "RecipeIngredient"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."RecipeIngredient" TO dimon;


--
-- Name: SEQUENCE "RecipeIngredient_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public."RecipeIngredient_id_seq" TO dimon;


--
-- Name: SEQUENCE "Recipe_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public."Recipe_id_seq" TO dimon;


--
-- Name: TABLE "User"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."User" TO dimon;


--
-- Name: TABLE "UserCredential"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."UserCredential" TO dimon;


--
-- Name: SEQUENCE "UserCredential_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public."UserCredential_id_seq" TO dimon;


--
-- Name: TABLE "UserProduct"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."UserProduct" TO dimon;


--
-- Name: SEQUENCE "UserProduct_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public."UserProduct_id_seq" TO dimon;


--
-- Name: TABLE "UserRecipe"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."UserRecipe" TO dimon;


--
-- Name: SEQUENCE "UserRecipe_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public."UserRecipe_id_seq" TO dimon;


--
-- Name: TABLE "UserRole"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public."UserRole" TO dimon;


--
-- Name: SEQUENCE "UserRole_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public."UserRole_id_seq" TO dimon;


--
-- Name: SEQUENCE "User_id_seq"; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public."User_id_seq" TO dimon;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO dimon;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO dimon;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO dimon;


--
-- PostgreSQL database dump complete
--

