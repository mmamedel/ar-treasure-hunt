--
-- PostgreSQL database dump
--

\restrict Z2WvOWtjfudcZbcY0bob8Ltkvrkoz3CJs0gEsQNLkxOicgTMprMVdL78kCCYWvI

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.7 (Homebrew)

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

ALTER TABLE IF EXISTS ONLY public."Treasure" DROP CONSTRAINT IF EXISTS "Treasure_gameSessionId_fkey";
DROP INDEX IF EXISTS public."GameSession_playerName_key";
ALTER TABLE IF EXISTS ONLY public._prisma_migrations DROP CONSTRAINT IF EXISTS _prisma_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public."Treasure" DROP CONSTRAINT IF EXISTS "Treasure_pkey";
ALTER TABLE IF EXISTS ONLY public."GameSession" DROP CONSTRAINT IF EXISTS "GameSession_pkey";
ALTER TABLE IF EXISTS ONLY public."GameConfig" DROP CONSTRAINT IF EXISTS "GameConfig_pkey";
ALTER TABLE IF EXISTS public."Treasure" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public."GameSession" ALTER COLUMN id DROP DEFAULT;
DROP TABLE IF EXISTS public._prisma_migrations;
DROP SEQUENCE IF EXISTS public."Treasure_id_seq";
DROP TABLE IF EXISTS public."Treasure";
DROP SEQUENCE IF EXISTS public."GameSession_id_seq";
DROP TABLE IF EXISTS public."GameSession";
DROP TABLE IF EXISTS public."GameConfig";
-- *not* dropping schema, since initdb creates it
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: GameConfig; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."GameConfig" (
    id integer DEFAULT 1 NOT NULL,
    "startTime" timestamp(3) without time zone NOT NULL,
    "endTime" timestamp(3) without time zone NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: GameSession; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."GameSession" (
    id integer NOT NULL,
    "playerName" text NOT NULL,
    start timestamp(3) without time zone NOT NULL,
    "end" timestamp(3) without time zone,
    "hasReceivedPrize" boolean DEFAULT false NOT NULL,
    "hasFinished" boolean DEFAULT false NOT NULL,
    "durationMs" integer,
    "nameOverride" text
);


--
-- Name: GameSession_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."GameSession_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: GameSession_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."GameSession_id_seq" OWNED BY public."GameSession".id;


--
-- Name: Treasure; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Treasure" (
    id integer NOT NULL,
    "gameSessionId" integer NOT NULL,
    "treasureNumber" integer NOT NULL,
    start timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "end" timestamp(3) without time zone,
    found boolean DEFAULT false NOT NULL
);


--
-- Name: Treasure_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."Treasure_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Treasure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."Treasure_id_seq" OWNED BY public."Treasure".id;


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


--
-- Name: GameSession id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."GameSession" ALTER COLUMN id SET DEFAULT nextval('public."GameSession_id_seq"'::regclass);


--
-- Name: Treasure id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Treasure" ALTER COLUMN id SET DEFAULT nextval('public."Treasure_id_seq"'::regclass);


--
-- Data for Name: GameConfig; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."GameConfig" (id, "startTime", "endTime", "createdAt", "updatedAt") FROM stdin;
1	2025-11-29 11:50:00	2025-11-29 22:00:00	2025-11-27 20:34:07.581	2025-11-29 11:49:25.668
\.


--
-- Data for Name: GameSession; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."GameSession" (id, "playerName", start, "end", "hasReceivedPrize", "hasFinished", "durationMs", "nameOverride") FROM stdin;
169	Luciano	2025-11-29 11:53:35.44	\N	f	f	\N	\N
71	Aline Lins	2025-11-29 11:27:29.275	\N	f	f	\N	\N
72	Andreza Teles	2025-11-29 11:44:49.111	\N	f	f	\N	\N
73	Tchiarles e Juliana	2025-11-29 11:44:52.897	\N	f	f	\N	\N
74	Lucas Faria	2025-11-29 11:44:58.648	\N	f	f	\N	\N
75	Bruno Rodrigues	2025-11-29 11:45:08.792	\N	f	f	\N	\N
90	Sarah silva	2025-11-29 11:50:09.92	\N	f	f	\N	\N
93	Aline Ribeiro Santos	2025-11-29 11:50:12.113	\N	f	f	\N	\N
96	Rafaela Brunetti	2025-11-29 11:50:19.509	\N	f	f	\N	\N
98	Cindy	2025-11-29 11:50:22.001	\N	f	f	\N	\N
100	Henrique	2025-11-29 11:50:24.824	\N	f	f	\N	\N
101	Lucas Filho	2025-11-29 11:50:27.997	\N	f	f	\N	\N
102	Ana Claudia	2025-11-29 11:50:35.006	\N	f	f	\N	\N
106	Thiago Lodetti	2025-11-29 11:50:42.37	\N	f	f	\N	\N
112	Samanta	2025-11-29 11:50:53.393	\N	f	f	\N	\N
114	Gustavo Junior Prate	2025-11-29 11:50:59.793	\N	f	f	\N	\N
115	Lucimauro	2025-11-29 11:51:02.674	\N	f	f	\N	\N
116	João Marcelo	2025-11-29 11:51:04.634	\N	f	f	\N	\N
117	Erick Crisanto	2025-11-29 11:51:09.322	\N	f	f	\N	\N
120	Andreia Crivellari	2025-11-29 11:51:15.297	\N	f	f	\N	\N
121	Diego	2025-11-29 11:51:19.497	\N	f	f	\N	\N
123	Henrique Costa	2025-11-29 11:51:26.369	\N	f	f	\N	\N
125	Gabriely Crisanto	2025-11-29 11:53:04.872	\N	f	f	\N	\N
130	Harli Rodrigues	2025-11-29 11:51:51.67	\N	f	f	\N	\N
131	Emerson de Lima	2025-11-29 11:51:46.141	\N	f	f	\N	\N
132	Otávio Costa	2025-11-29 11:51:58.576	\N	f	f	\N	\N
134	Jaqueline Grande	2025-11-29 11:52:00.134	\N	f	f	\N	\N
135	Thiago novais	2025-11-29 11:52:00.062	\N	f	f	\N	\N
136	Millena Alves	2025-11-29 11:52:06.225	\N	f	f	\N	\N
138	Laura Siqueira	2025-11-29 11:52:14.578	\N	f	f	\N	\N
139	Déborah Silvério	2025-11-29 11:52:15.517	\N	f	f	\N	\N
140	Yasmin	2025-11-29 11:52:19.007	\N	f	f	\N	\N
141	Caroline Lima	2025-11-29 11:52:19.153	\N	f	f	\N	\N
142	Graziele	2025-11-29 11:52:23.75	\N	f	f	\N	\N
144	Lívia Costa	2025-11-29 11:52:31.133	\N	f	f	\N	\N
146	Rafael	2025-11-29 11:52:33.594	\N	f	f	\N	\N
149	Vinicius Lima	2025-11-29 11:52:40.601	\N	f	f	\N	\N
152	Grupo lestou	2025-11-29 11:52:44.708	\N	f	f	\N	\N
155	Joselma	2025-11-29 11:52:58.715	\N	f	f	\N	\N
156	Daniele Cintra	2025-11-29 11:53:02.701	\N	f	f	\N	\N
161	Jesus	2025-11-29 11:53:10.598	\N	f	f	\N	\N
162	Ronalo	2025-11-29 11:53:23.801	\N	f	f	\N	\N
170	Gisele	2025-11-29 11:53:37.319	\N	f	f	\N	\N
171	Cassepp	2025-11-29 11:53:43.923	\N	f	f	\N	\N
173	Natalia Monteiro	2025-11-29 11:53:56.22	\N	f	f	\N	\N
175	Goi	2025-11-29 11:54:00.658	\N	f	f	\N	\N
176	Keila	2025-11-29 11:54:01.213	\N	f	f	\N	\N
177	Henrique Freitas	2025-11-29 11:54:01.392	\N	f	f	\N	\N
178	Rodrigo Monteiro	2025-11-29 11:54:05.496	\N	f	f	\N	\N
179	Doni. Crivellari	2025-11-29 11:54:10.822	\N	f	f	\N	\N
186	Juliana	2025-11-29 11:54:45.662	\N	f	f	\N	\N
91	Karla Prando	2025-11-29 11:50:11.076	2025-11-29 12:12:05.525	t	t	1314449	\N
76	Victor hugo	2025-11-29 11:50:05.183	2025-11-29 12:09:39.26	t	t	1174077	\N
79	Marcelo Rocchi	2025-11-29 11:50:07.285	2025-11-29 12:08:57.638	t	t	1130353	\N
82	Juliana Lima	2025-11-29 11:50:08.319	2025-11-29 12:22:24.968	f	t	1936649	\N
166	Jaqueline SilvSantos	2025-11-29 11:53:32.695	2025-11-29 12:28:36.294	f	t	2103599	\N
78	Leandra	2025-11-29 11:50:05.744	2025-11-29 12:10:38.794	t	t	1233050	\N
111	Hudson Santos	2025-11-29 11:50:52.445	2025-11-29 12:25:44.015	f	t	2091570	\N
165	Andrews e Rhuana	2025-11-29 11:53:32.973	2025-11-29 12:19:27.827	f	t	1554854	\N
129	Luís Fernando Costa	2025-11-29 11:51:45.554	2025-11-29 12:16:59.069	t	t	1513515	\N
108	Fernanda prates	2025-11-29 11:50:41.988	2025-11-29 12:22:39.939	f	t	1917951	\N
88	Danielle	2025-11-29 11:50:09.717	2025-11-29 12:30:38.875	f	t	2429158	\N
80	Isabelle Tajarol	2025-11-29 11:50:08.205	2025-11-29 12:32:04.985	f	t	2516780	\N
105	Thays barbosa	2025-11-29 11:50:41.342	2025-11-29 12:25:25.541	f	t	2084199	\N
84	Paula Santos	2025-11-29 11:50:08.621	2025-11-29 12:25:32.012	f	t	2123391	\N
87	Aline Santos	2025-11-29 11:50:12.79	2025-11-29 12:18:18.43	t	t	1685640	\N
119	Thamires	2025-11-29 11:51:12.04	2025-11-29 12:28:54.525	t	t	2262485	\N
95	Augusto Rodrigues	2025-11-29 11:50:16.09	2025-11-29 12:26:12.802	f	t	2156712	\N
113	Karoline Calbo	2025-11-29 11:50:59.952	2025-11-29 12:18:03.742	t	t	1623790	\N
127	Izabely Mendes	2025-11-29 11:51:40.511	2025-11-29 12:36:47.804	f	t	2707293	\N
164	Barbara lins	2025-11-29 11:53:29.974	2025-11-29 12:28:43.827	t	t	2113853	\N
151	Franklin&Jennifer	2025-11-29 11:52:44.947	2025-11-29 12:28:53.316	f	t	2168369	\N
143	Milena Goi	2025-11-29 11:52:24.192	2025-11-29 12:34:08.642	f	t	2504450	\N
77	Diego Silva	2025-11-29 11:50:05.044	2025-11-29 12:29:23.478	f	t	2358434	\N
153	Nicole farias	2025-11-29 11:52:49.15	2025-11-29 12:31:21.46	f	t	2312310	\N
92	Andressa Fernandes	2025-11-29 11:50:11.83	2025-11-29 12:25:26.162	t	t	2114332	\N
109	Jenifer vivian curi	2025-11-29 11:50:44.771	2025-11-29 12:32:24.243	f	t	2499472	\N
83	DvD	2025-11-29 11:50:08.405	2025-11-29 12:25:54.609	t	t	2146204	\N
145	Kemyllin	2025-11-29 11:52:33.272	2025-11-29 12:34:15.714	f	t	2502442	\N
181	Nayana Barreto	2025-11-29 11:54:17.848	2025-11-29 12:34:56.808	f	t	2438960	\N
122	Bruna Rodrigues	2025-11-29 11:51:21.925	2025-11-29 12:38:05.361	f	t	2803436	\N
148	Letticia Custódio	2025-11-29 11:52:39.4	2025-11-29 12:49:12.281	t	t	3392881	\N
103	Jess Lodetti	2025-11-29 11:50:35.665	2025-11-29 12:54:09.443	f	t	3813778	\N
158	Tayná Nascimento	2025-11-29 11:53:05.671	2025-11-29 12:50:11.233	f	t	3425562	\N
81	Aline Barros	2025-11-29 11:50:06.943	2025-11-29 13:10:09.672	t	t	4802729	\N
126	Elaine Shizue	2025-11-29 11:51:30.752	2025-11-29 12:45:15.416	f	t	3224664	\N
157	Emeara Correia	2025-11-29 11:53:04.304	2025-11-29 12:46:37.385	t	t	3213081	\N
167	Sandro	2025-11-29 11:53:35.515	2025-11-29 13:00:09.519	t	t	3994004	\N
118	Pedro Luz	2025-11-29 11:50:01.871	2025-11-29 12:50:56.838	t	t	3654967	\N
97	Luana e Carlos Ponte	2025-11-29 11:50:18.64	2025-11-29 12:41:49.218	t	t	3090578	\N
163	Carolina Virissimo	2025-11-29 11:53:27.812	2025-11-29 12:42:34.938	t	t	2947126	\N
174	Fernanda Andrades	2025-11-29 11:53:55.96	2025-11-29 12:52:43.534	f	t	3527574	\N
107	Nelsy	2025-11-29 11:50:42.276	2025-11-29 12:38:51.832	t	t	2889556	\N
147	Oriana	2025-11-29 11:52:36.308	2025-11-29 12:38:47.652	t	t	2771344	\N
124	Daniela Damasio	2025-11-29 11:51:06.2	2025-11-29 13:00:01.754	t	t	4135554	\N
150	Heitor pestana	2025-11-29 11:52:43.727	2025-11-29 14:20:37.129	f	t	8873402	\N
180	Milena Inamara	2025-11-29 11:54:12.395	2025-11-29 12:46:25.476	t	t	3133081	\N
160	Amanda Almeida	2025-11-29 11:53:10.189	2025-11-29 13:05:18.415	f	t	4328226	\N
172	Barbara	2025-11-29 11:53:48.277	2025-11-29 13:05:21.995	f	t	4293718	\N
99	Francisca	2025-11-29 11:50:23.573	2025-11-29 13:00:18.195	t	t	4194622	\N
168	Catarine e Erick	2025-11-29 11:53:34.192	2025-11-29 13:59:37.934	t	t	7563742	\N
182	André e nathaniele	2025-11-29 11:54:25.761	\N	f	f	\N	\N
184	Jessica	2025-11-29 11:54:32.579	\N	f	f	\N	\N
191	Lucas Prado	2025-11-29 11:54:55.577	\N	f	f	\N	\N
201	Priscila Santos	2025-11-29 11:55:30.521	\N	f	f	\N	\N
203	Caroline Silva	2025-11-29 11:55:33.224	\N	f	f	\N	\N
206	Luiza	2025-11-29 11:55:41.252	\N	f	f	\N	\N
214	Jimena Rafaelle	2025-11-29 11:56:17.205	\N	f	f	\N	\N
215	Artur Barbosa	2025-11-29 11:56:10.207	\N	f	f	\N	\N
217	Aquino	2025-11-29 11:56:34.545	\N	f	f	\N	\N
218	Cláudio Musskopf	2025-11-29 11:56:30.539	\N	f	f	\N	\N
221	Jessica Fernandes	2025-11-29 11:56:59.337	\N	f	f	\N	\N
222	Sara; Matheus; Iury	2025-11-29 11:57:02.884	\N	f	f	\N	\N
223	Luana Gomes Teixeira	2025-11-29 11:57:00.581	\N	f	f	\N	\N
231	Jessica Gonzaga	2025-11-29 11:57:39.527	\N	f	f	\N	\N
232	Geovane	2025-11-29 11:57:41.815	\N	f	f	\N	\N
236	Thiago Gonzaga	2025-11-29 11:58:00.376	\N	f	f	\N	\N
238	Edvaldo Sousa	2025-11-29 11:58:02.357	\N	f	f	\N	\N
183	Pedro Pinto	2025-11-29 11:54:31.219	2025-11-29 12:14:31.601	f	t	1200382	\N
237	Renata Brito	2025-11-29 11:58:02.652	2025-11-29 12:28:59.354	f	t	1856702	\N
200	César Anselmini	2025-11-29 11:55:27.983	2025-11-29 12:33:28.866	t	t	2280883	\N
234	Joise	2025-11-29 11:57:43.861	2025-11-29 12:41:41.012	f	t	2637151	\N
185	Welberty	2025-11-29 11:54:19.847	2025-11-29 12:40:50.071	t	t	2790224	\N
202	Dhouglas Soldado	2025-11-29 11:55:31.804	2025-11-29 12:39:34.118	t	t	2642314	\N
233	Otávio Lima	2025-11-29 11:57:43.318	2025-11-29 13:52:26.965	t	t	6883647	\N
187	Ronaldo Júnior	2025-11-29 11:54:47.643	\N	f	f	\N	\N
189	Eduardo Leonardo	2025-11-29 11:54:51.951	\N	f	f	\N	\N
192	Naíra	2025-11-29 11:55:01.631	\N	f	f	\N	\N
194	Ana Luiza	2025-11-29 11:55:08.015	\N	f	f	\N	\N
195	Silvia	2025-11-29 11:55:07.537	\N	f	f	\N	\N
197	Fabio cuco	2025-11-29 11:55:13.373	\N	f	f	\N	\N
198	Lorraine Domingos	2025-11-29 11:55:20.482	\N	f	f	\N	\N
204	Larissa Mancabeli	2025-11-29 11:55:38.77	\N	f	f	\N	\N
205	Mailson	2025-11-29 11:55:40.128	\N	f	f	\N	\N
207	Bruno Félix	2025-11-29 11:55:42.43	\N	f	f	\N	\N
208	David	2025-11-29 11:55:54.728	\N	f	f	\N	\N
209	Luciene	2025-11-29 11:54:52.67	\N	f	f	\N	\N
212	Lestou	2025-11-29 11:56:09.314	\N	f	f	\N	\N
213	Jennifer e David	2025-11-29 11:56:16.04	\N	f	f	\N	\N
216	Alessandra	2025-11-29 11:56:27.257	\N	f	f	\N	\N
219	Francimaria Santos	2025-11-29 11:56:53.854	\N	f	f	\N	\N
220	Cadu	2025-11-29 11:56:57.531	\N	f	f	\N	\N
224	Diego Lima	2025-11-29 11:57:06.704	\N	f	f	\N	\N
225	Wilson Leandro	2025-11-29 11:57:09.031	\N	f	f	\N	\N
226	Vagner Gamba	2025-11-29 11:57:10.757	\N	f	f	\N	\N
227	Caroline A	2025-11-29 11:57:15.594	\N	f	f	\N	\N
228	Baracho	2025-11-29 11:57:30.667	\N	f	f	\N	\N
230	William Ferreira	2025-11-29 11:57:35.938	\N	f	f	\N	\N
241	Rafael pinheiro	2025-11-29 11:58:18.319	\N	f	f	\N	\N
242	Leia	2025-11-29 11:58:22.302	\N	f	f	\N	\N
243	Ricardo Lima	2025-11-29 11:58:23.364	\N	f	f	\N	\N
244	Fernanda Lopes	2025-11-29 11:58:26.066	\N	f	f	\N	\N
246	Joelso	2025-11-29 11:58:32.978	\N	f	f	\N	\N
249	Maiane	2025-11-29 11:58:41.784	\N	f	f	\N	\N
250	Claudio	2025-11-29 11:58:46.395	\N	f	f	\N	\N
252	Leidielen Sanches	2025-11-29 11:59:01.487	\N	f	f	\N	\N
253	Priscila lopes	2025-11-29 11:59:04.688	\N	f	f	\N	\N
254	Jussara Nerys	2025-11-29 11:59:05.408	\N	f	f	\N	\N
255	Amanda Maciel	2025-11-29 11:59:10.584	\N	f	f	\N	\N
256	Beatriz	2025-11-29 11:59:29.167	\N	f	f	\N	\N
257	Ian	2025-11-29 11:59:31.366	\N	f	f	\N	\N
258	So Young Hong	2025-11-29 11:59:32.155	\N	f	f	\N	\N
260	Kevin e Prin	2025-11-29 11:59:51.55	\N	f	f	\N	\N
265	Vanderlany	2025-11-29 12:00:06.438	\N	f	f	\N	\N
267	Nicole	2025-11-29 12:00:08.651	\N	f	f	\N	\N
268	Marcelo Scheid	2025-11-29 12:00:10.875	\N	f	f	\N	\N
269	André Oliveira	2025-11-29 12:00:09.759	\N	f	f	\N	\N
271	Cleyton e Queite	2025-11-29 12:00:22.778	\N	f	f	\N	\N
272	Boris Burlacenko	2025-11-29 12:00:26.342	\N	f	f	\N	\N
273	Marcílio Guedes	2025-11-29 12:00:30	\N	f	f	\N	\N
275	BLopes	2025-11-29 12:00:57.783	\N	f	f	\N	\N
278	Camily	2025-11-29 12:01:11.13	\N	f	f	\N	\N
279	Fran	2025-11-29 12:01:22.583	\N	f	f	\N	\N
284	Milena	2025-11-29 12:01:47.431	\N	f	f	\N	\N
285	Priscila S Santos	2025-11-29 12:01:49.716	\N	f	f	\N	\N
286	Jean Rafael Santos j	2025-11-29 12:01:52.08	\N	f	f	\N	\N
292	Lucas Alves	2025-11-29 12:02:38.372	\N	f	f	\N	\N
298	Matheus lima	2025-11-29 12:03:54.277	\N	f	f	\N	\N
299	Fabrício Lima	2025-11-29 12:04:01.002	\N	f	f	\N	\N
300	Daniel Dalla	2025-11-29 12:04:03.229	\N	f	f	\N	\N
302	Márcio Grande	2025-11-29 12:04:20.167	\N	f	f	\N	\N
305	Jonathas Santos agui	2025-11-29 12:04:28.387	\N	f	f	\N	\N
306	Sudário	2025-11-29 12:04:35.013	\N	f	f	\N	\N
307	Lívia	2025-11-29 12:04:39.008	\N	f	f	\N	\N
308	Vanderlany Alves	2025-11-29 12:04:44.811	\N	f	f	\N	\N
312	Priscila	2025-11-29 12:04:59.873	\N	f	f	\N	\N
313	Gizele Santos	2025-11-29 12:05:08.769	\N	f	f	\N	\N
314	Caroline Nakamura	2025-11-29 12:05:12.634	\N	f	f	\N	\N
315	Denis	2025-11-29 12:05:23.469	\N	f	f	\N	\N
316	Ana Lemos	2025-11-29 12:05:31.397	\N	f	f	\N	\N
317	Valentín	2025-11-29 12:05:49.922	\N	f	f	\N	\N
318	Felipe e Pamela	2025-11-29 12:06:09.145	\N	f	f	\N	\N
245	Jefferson Parison	2025-11-29 11:58:29.083	2025-11-29 12:28:25.489	f	t	1796406	\N
264	Matheus Almeida	2025-11-29 12:00:04.218	2025-11-29 12:17:34.308	t	t	1050090	\N
283	Paulo Roberto	2025-11-29 12:01:42.278	2025-11-29 12:29:32.826	f	t	1670548	\N
287	Bianca Rascov	2025-11-29 12:01:55.284	2025-11-29 12:29:33.936	f	t	1658652	\N
295	Carol Dias	2025-11-29 12:03:38.771	2025-11-29 12:29:37.704	f	t	1558933	\N
239	Juan Brito	2025-11-29 11:58:12.013	2025-11-29 12:29:51.572	f	t	1899559	\N
311	Lucas V	2025-11-29 12:04:52.932	2025-11-29 12:30:42.838	f	t	1549906	\N
297	Josielem Terra	2025-11-29 12:03:53.496	2025-11-29 12:33:32.197	f	t	1778701	\N
309	Sara	2025-11-29 12:04:45.099	2025-11-29 12:33:45.12	f	t	1740021	\N
301	Tássio Terra	2025-11-29 12:04:16.252	2025-11-29 12:33:59.062	f	t	1782810	\N
277	Joicy	2025-11-29 12:01:03.783	2025-11-29 12:34:55.506	f	t	2031723	\N
280	Mayara	2025-11-29 12:01:25.682	2025-11-29 12:36:49.823	f	t	2124141	\N
289	Daiana Portal	2025-11-29 12:02:23.389	2025-11-29 12:57:23.777	f	t	3300388	\N
296	Andre Scruph	2025-11-29 12:03:43.17	2025-11-29 12:40:10.631	f	t	2187461	\N
270	Amanda Bizarrias	2025-11-29 12:00:16.915	2025-11-29 12:40:36.873	f	t	2419958	\N
247	MARCZAK	2025-11-29 11:58:31.739	2025-11-29 12:48:24.713	f	t	2992974	\N
281	Wagner Portal	2025-11-29 12:01:35.074	2025-11-29 12:44:57.127	f	t	2602053	\N
229	Erasmo e Lorena	2025-11-29 11:57:32.194	2025-11-29 13:00:13.131	f	t	3760937	\N
190	Kevin, Prin, Dal, Ba	2025-11-29 11:54:57.67	2025-11-29 12:43:07.685	t	t	2890015	\N
240	Pedro Paulo	2025-11-29 11:58:13.472	2025-11-29 12:49:18.887	f	t	3065415	\N
303	Pholiana e Elenilson	2025-11-29 12:04:25.518	2025-11-29 12:35:28.325	f	t	1862807	\N
251	Tamara	2025-11-29 11:58:54.179	2025-11-29 13:11:18.588	t	t	4344409	\N
261	Maurian	2025-11-29 11:59:54.828	2025-11-29 12:38:44.171	t	t	2329343	\N
188	Ewelyn Lorena	2025-11-29 11:54:47.913	2025-11-29 12:47:12.092	t	t	3144179	\N
262	Poliana	2025-11-29 11:59:58.434	2025-11-29 14:55:19.71	f	t	10521276	\N
310	Carlos Manoel Lopes	2025-11-29 12:04:48.138	2025-11-29 12:35:58.128	f	t	1869990	\N
291	Rubia Chiarello	2025-11-29 12:02:32.696	2025-11-29 13:13:34.424	t	t	4261728	\N
210	Bianca Brach	2025-11-29 11:56:00.077	2025-11-29 13:47:38.22	t	t	6698143	\N
319	Kellen Gabriela	2025-11-29 12:06:27.378	2025-11-29 13:51:47.179	t	t	6319801	\N
294	Rodrigo Bucis	2025-11-29 12:03:25.075	2025-11-29 13:56:54.642	t	t	6809567	\N
266	Ruana	2025-11-29 12:00:07.081	2025-11-29 13:52:38.182	t	t	6751101	\N
211	Bruno	2025-11-29 11:56:08.762	2025-11-29 14:17:03.959	t	t	8455197	\N
248	Wilian	2025-11-29 12:04:45.686	2025-11-29 17:43:49.888	t	t	20344202	\N
293	Dani Lima	2025-11-29 12:02:43.496	2025-11-29 12:36:05.172	f	t	2001676	\N
282	Rafa Cortez	2025-11-29 12:01:39.606	2025-11-29 20:43:14.287	f	t	31294681	\N
193	Ana Carolina	2025-11-29 11:55:03.283	2025-11-29 20:04:52.165	t	t	29388882	\N
304	Abraão	2025-11-29 12:04:24.942	2025-11-29 13:52:23.056	f	t	6478114	\N
321	Melindre	2025-11-29 12:06:32.904	\N	f	f	\N	\N
322	Melindré	2025-11-29 12:06:34.617	\N	f	f	\N	\N
325	Danilo Farias	2025-11-29 12:06:50.097	\N	f	f	\N	\N
320	Mário e Bia	2025-11-29 12:06:31.479	2025-11-29 12:35:17.295	f	t	1725816	\N
323	TAMTaije	2025-11-29 12:06:42.807	\N	f	f	\N	\N
327	Anderson Santos	2025-11-29 12:07:19.883	\N	f	f	\N	\N
328	Karla Mayra	2025-11-29 12:07:23.187	\N	f	f	\N	\N
329	Victor R	2025-11-29 12:07:29.613	\N	f	f	\N	\N
330	Fabiana Dresch Casse	2025-11-29 12:07:42.048	\N	f	f	\N	\N
331	Francisco	2025-11-29 12:07:48.309	\N	f	f	\N	\N
333	Clívia	2025-11-29 12:08:12.602	\N	f	f	\N	\N
335	Bueno	2025-11-29 12:08:40.859	\N	f	f	\N	\N
337	Caroline Marques	2025-11-29 12:08:57.216	\N	f	f	\N	\N
339	Caio Verônico	2025-11-29 12:09:01.53	\N	f	f	\N	\N
340	Eduardo Marques	2025-11-29 12:09:18.08	\N	f	f	\N	\N
341	Diego Fróes	2025-11-29 12:09:20.554	\N	f	f	\N	\N
343	LAIS	2025-11-29 12:09:16.815	\N	f	f	\N	\N
344	Kethy e lucas	2025-11-29 12:09:47.672	\N	f	f	\N	\N
346	Sula	2025-11-29 12:10:00.637	\N	f	f	\N	\N
347	Wellingta Pereira	2025-11-29 12:10:12.267	\N	f	f	\N	\N
349	Izabella	2025-11-29 12:10:44.257	\N	f	f	\N	\N
351	Pamela Souza	2025-11-29 12:10:57.685	\N	f	f	\N	\N
353	Ingryd Santos	2025-11-29 12:11:29.123	\N	f	f	\N	\N
357	Gian Duarte	2025-11-29 12:11:40.987	\N	f	f	\N	\N
358	Sanderliza	2025-11-29 12:11:43.874	\N	f	f	\N	\N
360	Lucas	2025-11-29 12:11:51.339	\N	f	f	\N	\N
362	Guilherme Penha	2025-11-29 12:11:56.989	\N	f	f	\N	\N
363	Camila Zukeram Ribei	2025-11-29 12:12:01.79	\N	f	f	\N	\N
364	Dayvid Willian	2025-11-29 12:24:09.609	\N	f	f	\N	\N
365	Rascov	2025-11-29 12:12:04.242	\N	f	f	\N	\N
366	Yuko	2025-11-29 12:12:10.136	\N	f	f	\N	\N
367	Aline	2025-11-29 12:12:10.064	\N	f	f	\N	\N
368	Maher	2025-11-29 12:12:29.801	\N	f	f	\N	\N
370	Aline Goes	2025-11-29 12:12:47.216	\N	f	f	\N	\N
371	Janete	2025-11-29 12:13:00.896	\N	f	f	\N	\N
374	Amanda	2025-11-29 12:13:17.606	\N	f	f	\N	\N
375	Del Rio	2025-11-29 12:13:19.842	\N	f	f	\N	\N
376	Michele Boaretto	2025-11-29 12:13:18.992	\N	f	f	\N	\N
159	Dayse Lima	2025-11-29 11:53:04.335	2025-11-29 12:08:47.421	t	t	943086	\N
378	Matheus	2025-11-29 12:13:41.48	\N	f	f	\N	\N
379	Amanda carvalho	2025-11-29 12:13:43.486	\N	f	f	\N	\N
86	Guilherme Paes	2025-11-29 11:50:07.768	2025-11-29 12:08:52.64	t	t	1124872	\N
381	JuFruchi	2025-11-29 12:14:17.31	\N	f	f	\N	\N
383	Guilherme Nojosa	2025-11-29 12:14:39.606	\N	f	f	\N	\N
110	Camila rocchi	2025-11-29 11:50:50.508	2025-11-29 12:09:04.718	t	t	1094210	\N
385	Silvana Fontes	2025-11-29 12:14:57.065	\N	f	f	\N	\N
387	Valentín Álvarez	2025-11-29 12:15:20.541	\N	f	f	\N	\N
389	Sheila Falcão	2025-11-29 12:15:37.269	\N	f	f	\N	\N
390	Raquel	2025-11-29 12:15:52.63	\N	f	f	\N	\N
393	Mariane F R Santos	2025-11-29 12:16:15.221	\N	f	f	\N	\N
394	Duda	2025-11-29 12:16:40.243	\N	f	f	\N	\N
395	João	2025-11-29 12:16:43.328	\N	f	f	\N	\N
396	Luis Soares Vieira J	2025-11-29 12:16:51.974	\N	f	f	\N	\N
397	Gabriela	2025-11-29 12:17:10.467	\N	f	f	\N	\N
399	Caio Cesar Amaro	2025-11-29 12:17:20.557	\N	f	f	\N	\N
400	Derlan	2025-11-29 12:17:38.94	\N	f	f	\N	\N
401	Natália Souto	2025-11-29 12:17:39.436	\N	f	f	\N	\N
402	Ingryd Cia	2025-11-29 12:17:39.699	\N	f	f	\N	\N
404	Jéssica/Vi	2025-11-29 12:17:56.704	\N	f	f	\N	\N
405	Carla e André	2025-11-29 12:18:02.067	\N	f	f	\N	\N
406	Talita Gomes	2025-11-29 12:18:02.606	\N	f	f	\N	\N
408	Márcia	2025-11-29 12:18:37.05	\N	f	f	\N	\N
409	Nicolas	2025-11-29 12:18:45.649	\N	f	f	\N	\N
410	Simone	2025-11-29 12:18:53.47	\N	f	f	\N	\N
414	Letícia Morais	2025-11-29 12:19:27.289	\N	f	f	\N	\N
415	Rodrigo	2025-11-29 12:19:37.915	\N	f	f	\N	\N
417	Vanessa Braz	2025-11-29 12:20:37.261	\N	f	f	\N	\N
196	Wirllem Ferreira	2025-11-29 11:55:08.84	2025-11-29 12:14:36.17	t	t	1167330	\N
418	MICHELE	2025-11-29 12:20:54.877	\N	f	f	\N	\N
419	Bea	2025-11-29 12:21:10.488	\N	f	f	\N	\N
421	Luan e Carol	2025-11-29 12:21:21.106	\N	f	f	\N	\N
422	Milene	2025-11-29 12:21:31.497	\N	f	f	\N	\N
423	Caroline	2025-11-29 12:21:35.112	\N	f	f	\N	\N
424	Cauan Saile	2025-11-29 12:22:06.409	\N	f	f	\N	\N
425	Fábio Almeida	2025-11-29 12:22:11.318	\N	f	f	\N	\N
426	Edmilson  santos	2025-11-29 12:22:43.4	\N	f	f	\N	\N
427	Eduardo	2025-11-29 12:22:51.984	\N	f	f	\N	\N
431	Victor Neves	2025-11-29 12:23:58.728	\N	f	f	\N	\N
420	Hiroito	2025-11-29 12:21:19.858	2025-11-29 13:20:11.508	t	t	3531650	\N
354	Maísa Fróes	2025-11-29 12:11:28.394	2025-11-29 12:45:22.659	f	t	2034265	\N
324	Tereza Prado	2025-11-29 12:06:46.397	2025-11-29 12:55:55.369	f	t	2948972	\N
352	Jonne Santos	2025-11-29 12:11:02.14	2025-11-29 12:51:01.796	f	t	2399656	\N
356	Natanael e Bianca	2025-11-29 12:11:35.5	2025-11-29 12:46:01.14	f	t	2065640	\N
334	Mari Vieira	2025-11-29 12:08:20.166	2025-11-29 12:47:10.181	f	t	2330015	\N
332	Lucas e Doug	2025-11-29 12:07:53.845	2025-11-29 12:45:28.058	t	t	2254213	\N
391	Alessandra martins	2025-11-29 12:15:59.525	2025-11-29 12:58:18.077	f	t	2538552	\N
384	Pedro Mercuroo	2025-11-29 12:14:51.705	2025-11-29 12:38:32.001	f	t	1420296	\N
416	Geovana Garcia	2025-11-29 12:20:01.196	2025-11-29 12:44:53.142	t	t	1491946	\N
338	Evilasio e Nata	2025-11-29 12:08:58.11	2025-11-29 12:59:18.482	f	t	3020372	\N
392	Neriane	2025-11-29 12:16:13.588	2025-11-29 12:53:31.068	f	t	2237480	\N
359	Bianca ferreira	2025-11-29 12:11:49.184	2025-11-29 12:48:28.179	t	t	2198995	\N
350	Dilson	2025-11-29 12:10:50.787	2025-11-29 12:46:18.91	t	t	2128123	\N
398	Letícia Miranda	2025-11-29 12:17:13.711	2025-11-29 12:57:47.045	f	t	2433334	\N
380	Alysson Martins	2025-11-29 12:14:09.767	2025-11-29 12:58:08.017	f	t	2638250	\N
388	Gabriel Pinheiro	2025-11-29 12:15:20.835	2025-11-29 12:48:58.988	t	t	2018153	\N
361	Juliana S	2025-11-29 12:11:52.412	2025-11-29 12:58:48.694	f	t	2816282	\N
407	Musa do verao	2025-11-29 12:18:33.193	2025-11-29 12:51:23.99	t	t	1970797	\N
413	Gabriel Lucas	2025-11-29 12:19:22.562	2025-11-29 12:56:22.027	t	t	2219465	\N
412	Andréia	2025-11-29 12:19:20.025	2025-11-29 13:30:27.582	t	t	4267557	\N
372	Douglas Jr	2025-11-29 12:13:08.382	2025-11-29 12:51:19.849	t	t	2291467	\N
428	Allan e Lud	2025-11-29 12:23:01.192	2025-11-29 13:04:09.312	t	t	2468120	\N
377	Gabi Tannous	2025-11-29 12:13:20.519	2025-11-29 14:30:48.15	f	t	8247631	\N
429	Nícolas	2025-11-29 12:23:24.778	2025-11-29 13:13:08.575	t	t	2983797	\N
373	Juliana Evaristo	2025-11-29 12:13:13.415	2025-11-29 13:11:49.847	t	t	3516432	\N
411	Emelly menezes	2025-11-29 12:19:04.773	2025-11-29 13:28:40.962	t	t	4176189	\N
355	Guilherme Silva	2025-11-29 12:11:31.585	2025-11-29 13:46:54.179	t	t	5722594	\N
430	Júnior	2025-11-29 12:23:37.61	2025-11-29 15:59:41.724	f	t	12964114	\N
326	Paulo e adrielle	2025-11-29 12:07:04.926	2025-11-29 14:43:07.039	t	t	9362113	\N
348	Lilian Guedes	2025-11-29 12:10:18.144	2025-11-29 20:14:18.96	t	t	29040816	\N
432	Andressa Oh	2025-11-29 12:24:13.213	\N	f	f	\N	\N
94	Renata Pereira	2025-11-29 11:50:12.99	2025-11-29 12:26:16.095	f	t	2163105	\N
433	David Oh	2025-11-29 12:24:27.769	\N	f	f	\N	\N
434	Juliane Gomes	2025-11-29 12:24:29.181	\N	f	f	\N	\N
435	Larissa's	2025-11-29 12:24:46.678	\N	f	f	\N	\N
436	Renan Queiroz	2025-11-29 12:25:25.083	\N	f	f	\N	\N
437	Adelmo Santos da Sil	2025-11-29 12:25:55.052	\N	f	f	\N	\N
438	Patrícia e Edmar	2025-11-29 12:26:27.702	\N	f	f	\N	\N
439	Diego Francisco	2025-11-29 12:28:35.113	\N	f	f	\N	\N
440	Wagner Silva	2025-11-29 12:28:43.849	\N	f	f	\N	\N
276	Nicolas Willians	2025-11-29 12:01:01.397	2025-11-29 12:28:49.913	f	t	1668516	\N
442	Daniel sales	2025-11-29 12:28:59.457	\N	f	f	\N	\N
89	Maicon Fernandes	2025-11-29 11:50:09.691	2025-11-29 12:24:41.36	t	t	2071669	\N
444	Flávio/ Cris Bonatel	2025-11-29 12:30:16.941	\N	f	f	\N	\N
448	Larissa	2025-11-29 12:31:55.314	\N	f	f	\N	\N
450	Adriano	2025-11-29 12:32:50.305	\N	f	f	\N	\N
133	Fabiano Rubinho	2025-11-29 11:52:01.033	2025-11-29 12:25:08.372	t	t	1987339	\N
451	Nayarah	2025-11-29 12:33:18.443	\N	f	f	\N	\N
452	Fabiano	2025-11-29 12:33:23.92	\N	f	f	\N	\N
259	Jaqueline	2025-11-29 11:59:44.877	2025-11-29 12:34:01.955	f	t	2057078	\N
453	Era	2025-11-29 12:34:18.449	\N	f	f	\N	\N
454	Fabio	2025-11-29 12:34:26.445	\N	f	f	\N	\N
85	Pedro Mitsuaki	2025-11-29 11:50:08.698	2025-11-29 12:28:46.11	t	t	2317412	\N
455	Vanessa e Marcos	2025-11-29 12:35:05.278	\N	f	f	\N	\N
456	Marcos Abreu	2025-11-29 12:35:30.539	\N	f	f	\N	\N
457	Hugo	2025-11-29 12:35:36.066	\N	f	f	\N	\N
458	Stella Cristina	2025-11-29 12:36:28.829	\N	f	f	\N	\N
459	Matheus segatto	2025-11-29 12:36:43.262	\N	f	f	\N	\N
460	Thiago Ferreira	2025-11-29 12:37:24.297	\N	f	f	\N	\N
274	Daniela Paisano	2025-11-29 12:00:32.656	2025-11-29 12:40:13.476	f	t	2380820	\N
369	Hede	2025-11-29 12:12:33.657	2025-11-29 12:40:19.319	f	t	1665662	\N
462	Stephanie  Cardozo	2025-11-29 12:41:09.488	\N	f	f	\N	\N
463	Eryc e Ju	2025-11-29 12:41:31.167	\N	f	f	\N	\N
464	Brenno de Jesus	2025-11-29 12:41:32.702	\N	f	f	\N	\N
465	José Fragoso Júnior	2025-11-29 12:41:44.099	\N	f	f	\N	\N
467	Juliana Santos	2025-11-29 12:43:12.497	\N	f	f	\N	\N
471	Lucas Zagueti	2025-11-29 12:44:25.791	\N	f	f	\N	\N
446	Marcos Bulla Jr	2025-11-29 12:30:41.498	2025-11-29 12:44:27.973	f	t	826475	\N
472	Filipe Janesel	2025-11-29 12:44:36.425	\N	f	f	\N	\N
403	Yara Segreto	2025-11-29 12:17:54.135	2025-11-29 12:37:47.947	t	t	1193812	\N
474	Carlos Alberto	2025-11-29 12:49:00.772	\N	f	f	\N	\N
342	Douglas Alves	2025-11-29 12:09:22.335	2025-11-29 12:43:10.407	t	t	2028072	\N
288	David Sanches	2025-11-29 12:02:04.419	2025-11-29 12:50:20.006	f	t	2895587	\N
477	Ana Zarbin	2025-11-29 12:50:32.646	\N	f	f	\N	\N
137	Gilberto Custódio	2025-11-29 11:52:10.77	2025-11-29 12:45:52.252	t	t	3221482	\N
479	Aline Oliveira	2025-11-29 12:51:04.295	\N	f	f	\N	\N
481	Eli	2025-11-29 12:52:42.908	\N	f	f	\N	\N
104	Fran Rodrigues	2025-11-29 11:55:55.78	2025-11-29 12:59:10.207	f	t	3794427	\N
382	Vitor Cartura	2025-11-29 12:14:26.938	2025-11-29 12:54:16.547	f	t	2389609	\N
483	Luana	2025-11-29 12:55:23.428	\N	f	f	\N	\N
484	Ellen	2025-11-29 12:55:44.677	\N	f	f	\N	\N
485	Milton Junior	2025-11-29 12:56:40.285	\N	f	f	\N	\N
445	Carol Batalha Bulla	2025-11-29 12:30:36.741	2025-11-29 12:57:39.37	f	t	1622629	\N
345	Carlinhos	2025-11-29 12:10:00.467	2025-11-29 12:58:55.713	f	t	2935246	\N
486	Matheus Souza	2025-11-29 12:59:02.734	\N	f	f	\N	\N
489	Patrick Santos	2025-11-29 12:59:56.052	\N	f	f	\N	\N
491	Juarez	2025-11-29 13:00:31.542	\N	f	f	\N	\N
493	João Arruda	2025-11-29 13:02:54.864	\N	f	f	\N	\N
523	Larissa Laura	2025-11-29 13:15:57.084	\N	f	f	\N	\N
441	Arthur Soares	2025-11-29 12:28:52.296	2025-11-29 13:07:27.29	f	t	2314994	\N
498	Kelle	2025-11-29 13:07:53.504	\N	f	f	\N	\N
499	Tiago	2025-11-29 13:08:37.411	\N	f	f	\N	\N
128	Milena Bom	2025-11-29 11:51:44.897	2025-11-29 13:02:26.149	t	t	4241252	\N
500	Cowboy	2025-11-29 13:09:30.706	\N	f	f	\N	\N
502	Tarso	2025-11-29 13:10:57.14	\N	f	f	\N	\N
503	Juliana crusco	2025-11-29 13:11:01.778	\N	f	f	\N	\N
504	Jane	2025-11-29 13:11:04.935	\N	f	f	\N	\N
506	Lucca Capozzi	2025-11-29 13:11:15.633	\N	f	f	\N	\N
508	Josiene Sena	2025-11-29 13:11:56.443	\N	f	f	\N	\N
513	Guias e Sasá	2025-11-29 13:12:45.242	\N	f	f	\N	\N
515	Jeanne silva	2025-11-29 13:13:42.303	\N	f	f	\N	\N
517	Victor Domingues	2025-11-29 13:14:02.856	\N	f	f	\N	\N
518	Fernanda e Evrrton	2025-11-29 13:14:07.45	\N	f	f	\N	\N
522	Wagner	2025-11-29 13:15:29.242	\N	f	f	\N	\N
449	Thayani	2025-11-29 12:32:32.827	2025-11-29 13:05:18.533	t	t	1965706	\N
524	Renato	2025-11-29 13:15:55.68	\N	f	f	\N	\N
490	Savio	2025-11-29 13:00:29.791	2025-11-29 13:29:36.606	t	t	1746815	\N
475	Renan e Daiane C	2025-11-29 12:48:56.933	2025-11-29 13:32:44.618	t	t	2627685	\N
466	Larissasss	2025-11-29 12:42:16.931	2025-11-29 13:28:17.158	t	t	2760227	\N
468	Vitor Serra	2025-11-29 12:43:25.397	2025-11-29 13:22:03.18	t	t	2317783	\N
496	Ana Luiza Machado	2025-11-29 13:06:23.088	2025-11-29 13:31:18.984	f	t	1495896	\N
514	Valeska	2025-11-29 13:13:04.135	2025-11-29 13:45:49.968	t	t	1965833	\N
488	Cleide	2025-11-29 12:59:39.952	2025-11-29 13:30:12.732	t	t	1832780	\N
495	Andréa	2025-11-29 13:03:49.5	2025-11-29 13:52:29.928	t	t	2920428	\N
512	Caroline Albergaria	2025-11-29 13:12:30.348	2025-11-29 13:49:40.695	t	t	2230347	\N
476	Bertrand	2025-11-29 12:50:32.132	2025-11-29 13:55:48.068	t	t	3915936	\N
519	Henrique Carvalho	2025-11-29 13:14:11.921	2025-11-29 13:45:46.333	t	t	1894412	\N
478	Ivan Mendes	2025-11-29 12:50:48.19	2025-11-29 13:45:49.897	f	t	3301707	\N
482	Guarani	2025-11-29 12:54:16.891	2025-11-29 14:45:42.597	f	t	6685706	\N
511	Skrzek	2025-11-29 13:12:18.22	2025-11-29 13:40:45.543	t	t	1707323	\N
516	Isabela Domingues	2025-11-29 13:13:43.692	2025-11-29 13:45:20.73	t	t	1897038	\N
386	André Evaristo	2025-11-29 12:14:56.78	2025-11-29 13:11:57.241	t	t	3420461	\N
492	Otavio	2025-11-29 13:00:42.861	2025-11-29 13:46:01.188	t	t	2718327	\N
497	Jacqueline e Luan	2025-11-29 13:06:33.851	2025-11-29 13:52:07.181	t	t	2733330	\N
521	Tamiris Weirich	2025-11-29 13:15:30.685	2025-11-29 13:52:32.273	t	t	2221588	\N
501	Felipe	2025-11-29 13:10:04.89	2025-11-29 13:51:43.363	t	t	2498473	\N
507	Abigail Chaga	2025-11-29 13:11:52.95	2025-11-29 14:09:18.925	f	t	3445975	\N
510	Danilo Sampaio	2025-11-29 13:12:12.538	2025-11-29 14:09:23.2	f	t	3430662	\N
509	Noelle Sampaio	2025-11-29 13:12:06.342	2025-11-29 14:09:58.762	f	t	3472420	\N
473	Paula	2025-11-29 12:46:19.253	2025-11-29 14:01:24.455	t	t	4505202	\N
469	Fernanda Martins	2025-11-29 12:43:32.106	2025-11-29 14:13:08.042	f	t	5375936	\N
526	Guilherme Iotti	2025-11-29 13:16:57.434	2025-11-29 14:19:33.671	f	t	3756237	\N
527	Maria	2025-11-29 13:17:03.55	2025-11-29 14:32:24.189	f	t	4520639	\N
525	Felipe Gaffo	2025-11-29 13:16:20.887	2025-11-29 14:09:13	t	t	3172113	\N
494	Larissa Lemos	2025-11-29 13:03:04.477	2025-11-29 17:29:40.781	t	t	15996304	\N
447	Vinicius Delgado	2025-11-29 12:31:04.413	2025-11-29 13:07:05.775	t	t	2161362	\N
540	Nayara C C Silva	2025-11-29 13:19:28.56	\N	f	f	\N	\N
541	Roger	2025-11-29 13:19:28.414	\N	f	f	\N	\N
546	Bianca	2025-11-29 13:19:57.956	\N	f	f	\N	\N
547	Renan e Lelê	2025-11-29 13:20:15.011	\N	f	f	\N	\N
461	Akemy	2025-11-29 12:39:09.367	2025-11-29 13:19:31.48	t	t	2422113	\N
528	Mary	2025-11-29 13:17:11.716	\N	f	f	\N	\N
532	Marcelo Alcalde	2025-11-29 13:17:43.814	\N	f	f	\N	\N
533	passarelli	2025-11-29 13:17:51.659	\N	f	f	\N	\N
531	Rimena Y Silva	2025-11-29 13:17:34.907	2025-11-29 19:11:17.848	t	t	21222941	\N
529	Sasá e Guias	2025-11-29 13:17:14.249	\N	f	f	\N	\N
530	Vinicius Weirich	2025-11-29 13:17:16.587	\N	f	f	\N	\N
534	Gleycy	2025-11-29 13:18:03.831	\N	f	f	\N	\N
199	Jacob ba	2025-11-29 11:55:23.721	2025-11-29 12:54:04.997	t	t	3521276	\N
536	Tiago brito	2025-11-29 13:18:45.304	\N	f	f	\N	\N
538	Henrique Paiva	2025-11-29 13:19:05.988	\N	f	f	\N	\N
542	Danny e Lucas	2025-11-29 13:19:50.724	\N	f	f	\N	\N
543	Karina Almeida	2025-11-29 13:19:53.392	\N	f	f	\N	\N
549	Gleide Anne Constant	2025-11-29 13:20:52.23	\N	f	f	\N	\N
550	Fabiano Souza	2025-11-29 13:21:17.189	\N	f	f	\N	\N
551	Núbia	2025-11-29 13:21:24.824	\N	f	f	\N	\N
552	Victor	2025-11-29 13:21:33.717	\N	f	f	\N	\N
553	Danúbia	2025-11-29 13:22:04.5	\N	f	f	\N	\N
554	Ohanna	2025-11-29 13:22:12.399	\N	f	f	\N	\N
555	Lindberg Paulino	2025-11-29 13:22:17.092	\N	f	f	\N	\N
556	Liene	2025-11-29 13:22:18.483	\N	f	f	\N	\N
558	Gislane	2025-11-29 13:23:01.048	\N	f	f	\N	\N
559	Julia Ferreira	2025-11-29 13:23:21.637	\N	f	f	\N	\N
560	Jéssica Ilnara	2025-11-29 13:23:45.823	\N	f	f	\N	\N
561	Daiane dos Santos Si	2025-11-29 13:24:02.183	\N	f	f	\N	\N
562	Jonatã Sena	2025-11-29 13:25:00.125	\N	f	f	\N	\N
563	Ingrid Candido	2025-11-29 13:27:20.331	\N	f	f	\N	\N
564	Laura	2025-11-29 13:27:43.055	\N	f	f	\N	\N
565	Matheus e Milena	2025-11-29 13:27:59.197	\N	f	f	\N	\N
568	Cadu soares	2025-11-29 13:29:14.101	\N	f	f	\N	\N
470	Vini Martins	2025-11-29 12:43:45.377	2025-11-29 13:21:59.437	t	t	2294060	\N
570	Marcos e Luana	2025-11-29 13:32:11.382	\N	f	f	\N	\N
571	Arthur	2025-11-29 13:32:27.884	\N	f	f	\N	\N
572	Fernanda e Vagner	2025-11-29 13:33:17.038	\N	f	f	\N	\N
573	Gabriela Rafaldini	2025-11-29 13:34:09.437	\N	f	f	\N	\N
578	Leandro Almeida dos	2025-11-29 13:37:45.425	\N	f	f	\N	\N
579	Fernanda	2025-11-29 13:37:53.904	\N	f	f	\N	\N
580	Laís e Eduardo Paiva	2025-11-29 13:38:21.454	\N	f	f	\N	\N
635	Gabi Zequim	2025-11-29 14:58:34.051	\N	f	f	\N	\N
582	Leonardo Almeida dos	2025-11-29 13:40:31.244	\N	f	f	\N	\N
586	Claudinei	2025-11-29 13:46:05.78	\N	f	f	\N	\N
480	Flavinha Mendes	2025-11-29 12:52:16.14	2025-11-29 13:40:50.62	t	t	2914480	\N
535	Matheus Saggin	2025-11-29 13:18:39.551	2025-11-29 13:39:59.611	t	t	1280060	\N
537	Thiago Bryan	2025-11-29 13:18:54.314	2025-11-29 13:40:01.718	t	t	1267404	\N
590	Adrian Falasca	2025-11-29 13:50:17.565	\N	f	f	\N	\N
591	Equipe	2025-11-29 13:50:21.466	\N	f	f	\N	\N
592	Alberto e Mirian	2025-11-29 13:52:01.052	\N	f	f	\N	\N
575	Anderson Martins	2025-11-29 13:34:53.808	2025-11-29 14:19:45.808	f	t	2692000	\N
487	Mateus Zanarolli	2025-11-29 12:59:34.694	2025-11-29 13:43:51.849	t	t	2657155	\N
593	Luís  Carlos	2025-11-29 13:55:46.556	\N	f	f	\N	\N
594	Tasca	2025-11-29 13:56:01.441	\N	f	f	\N	\N
595	Jacinto Junior	2025-11-29 13:57:09.05	\N	f	f	\N	\N
596	Lidiane	2025-11-29 13:58:39.841	\N	f	f	\N	\N
597	Miranda	2025-11-29 13:58:47.292	\N	f	f	\N	\N
567	sistemáticos e GJ	2025-11-29 13:29:09.553	2025-11-29 13:51:43.535	t	t	1353982	\N
599	Vania Miranda	2025-11-29 14:00:33.358	\N	f	f	\N	\N
520	Raphael Albergaria	2025-11-29 13:14:23.578	2025-11-29 13:46:40.706	t	t	1937128	\N
600	Denise	2025-11-29 14:02:50.651	\N	f	f	\N	\N
601	Eduardo Israel da Si	2025-11-29 14:02:54.368	\N	f	f	\N	\N
602	Paulo	2025-11-29 14:03:17.533	\N	f	f	\N	\N
603	Louise Silva	2025-11-29 14:04:26.754	\N	f	f	\N	\N
612	Fabio do Amaral Oliv	2025-11-29 14:20:02.495	\N	f	f	\N	\N
606	DBC	2025-11-29 14:08:58.945	\N	f	f	\N	\N
613	Rosiane	2025-11-29 14:20:03.861	\N	f	f	\N	\N
539	Cristiane	2025-11-29 13:19:09.485	2025-11-29 13:52:42.542	t	t	2013057	\N
505	Lidiane e Patrik	2025-11-29 13:11:15.683	2025-11-29 14:11:02.783	t	t	3587100	\N
608	Amanda Farias	2025-11-29 14:14:58.938	\N	f	f	\N	\N
609	Flavio Farias	2025-11-29 14:14:59.099	\N	f	f	\N	\N
577	Fernando Matos	2025-11-29 13:36:28.987	2025-11-29 14:09:21.612	t	t	1972625	\N
557	Ponce	2025-11-29 13:22:55.575	2025-11-29 14:16:18.835	f	t	3203260	\N
585	Vagner e Fernanda	2025-11-29 13:45:45.032	2025-11-29 14:16:26.332	f	t	1841300	\N
584	Tamiris	2025-11-29 13:42:35.845	2025-11-29 14:07:10.291	t	t	1474446	\N
589	Maristela	2025-11-29 13:48:12.289	2025-11-29 14:17:42.863	t	t	1770574	\N
581	Carpetes	2025-11-29 13:40:02.506	2025-11-29 14:20:08.687	f	t	2406181	\N
614	Caroline Castelhano	2025-11-29 14:20:16.149	\N	f	f	\N	\N
615	Vivi	2025-11-29 14:21:32.449	\N	f	f	\N	\N
616	Thiago	2025-11-29 14:21:33.909	\N	f	f	\N	\N
617	Emanuel Bormann	2025-11-29 14:22:15.637	\N	f	f	\N	\N
587	Geo e Felipe	2025-11-29 13:46:52.721	2025-11-29 14:22:20.727	f	t	2128006	\N
618	Andreia Machado	2025-11-29 14:22:40.391	\N	f	f	\N	\N
619	Alessandra Beligni	2025-11-29 14:23:15.824	\N	f	f	\N	\N
544	Glauciani	2025-11-29 13:19:38.53	2025-11-29 14:19:00.375	t	t	3561845	\N
583	Fernanda Moreira	2025-11-29 13:41:37.98	2025-11-29 14:30:18.206	f	t	2920226	\N
626	Julia Ellen Ferreira	2025-11-29 14:31:28.987	\N	f	f	\N	\N
627	Leão Ananda	2025-11-29 14:32:29.726	\N	f	f	\N	\N
637	יהוה.	2025-11-29 15:01:41.504	2025-11-29 15:12:38.028	f	t	656524	\N
598	Kenji Iso	2025-11-29 14:00:27.382	2025-11-29 14:33:30.901	f	t	1983519	\N
611	Robert Rocha Sanches	2025-11-29 14:17:58.334	2025-11-29 14:33:42.506	f	t	944172	\N
629	Speed run	2025-11-29 14:34:36.303	\N	f	f	\N	\N
548	Larissa Ferreira	2025-11-29 13:20:48.602	2025-11-29 14:36:43.648	f	t	4555046	\N
588	Douglas Nomizo	2025-11-29 13:47:19.353	2025-11-29 14:17:31.54	t	t	1812187	\N
622	Heitor Gonçalves	2025-11-29 14:29:54.699	2025-11-29 14:41:48.041	t	t	713342	\N
631	Amanda Souza	2025-11-29 14:44:17.78	\N	f	f	\N	\N
336	Ianka susinha e mike	2025-11-29 12:08:48.224	2025-11-29 14:45:40.491	f	t	9412267	\N
604	Syllvester Justino	2025-11-29 14:07:31.516	2025-11-29 14:45:40.977	f	t	2289461	\N
623	Lucas (Barril)	2025-11-29 14:29:56.607	2025-11-29 14:43:00.381	t	t	783774	\N
574	Daniel Lima	2025-11-29 13:34:27.441	2025-11-29 14:33:22.509	t	t	3535068	\N
633	Jamis Azevedo	2025-11-29 14:51:14.8	\N	f	f	\N	\N
634	יהוה	2025-11-29 14:55:04.031	\N	f	f	\N	\N
605	Edivam Castro	2025-11-29 14:08:20.577	2025-11-29 14:45:48.372	t	t	2247795	\N
636	Meninas Pam/Van/Nand	2025-11-29 14:58:34.117	\N	f	f	\N	\N
628	Julia Ellen	2025-11-29 14:32:47.767	2025-11-29 15:00:20.481	f	t	1652714	\N
638	Gabrielly	2025-11-29 15:02:27.452	\N	f	f	\N	\N
625	Elton	2025-11-29 14:31:17.372	2025-11-29 15:17:17.92	f	t	2760548	\N
621	Romeu	2025-11-29 14:28:21.545	2025-11-29 15:17:55.357	f	t	2973812	\N
632	Tiago otoni	2025-11-29 14:44:33.434	2025-11-29 15:44:59.048	t	t	3625614	\N
630	Gabriela mota	2025-11-29 14:42:32.615	2025-11-29 15:30:16.367	t	t	2863752	\N
620	Mayana	2025-11-29 14:26:28.079	2025-11-29 17:03:03.394	t	t	9395315	\N
566	Weliton	2025-11-29 13:28:44.065	2025-11-29 17:26:14.615	t	t	14250550	\N
607	Milene e Júdison	2025-11-29 14:10:57.698	2025-11-29 15:03:29.512	f	t	3151814	\N
640	Camilla	2025-11-29 15:05:06.591	\N	f	f	\N	\N
569	Mateus Costa	2025-11-29 13:31:44.433	2025-11-29 14:48:28.111	t	t	4603678	\N
641	MP1	2025-11-29 15:10:28.564	\N	f	f	\N	\N
639	Equipe flash	2025-11-29 15:05:04.391	2025-11-29 15:13:39.675	f	t	515284	\N
644	Smiguel	2025-11-29 15:15:46.979	\N	f	f	\N	\N
645	Yahweh	2025-11-29 15:16:19.642	\N	f	f	\N	\N
646	Laís Fernandes	2025-11-29 15:55:20.014	\N	f	f	\N	\N
643	Leandro e Francyelle	2025-11-29 15:14:32.712	2025-11-29 16:00:26.03	f	t	2753318	\N
649	Mel coda	2025-11-29 16:42:08.109	\N	f	f	\N	\N
651	Super Gemeos	2025-11-29 16:46:34.113	\N	f	f	\N	\N
656	Jeová em 1° lugar	2025-11-29 16:57:38.598	2025-11-29 16:58:36.343	f	t	57745	\N
657	Caíque	2025-11-29 17:00:56.331	\N	f	f	\N	\N
263	Felipe Messias	2025-11-29 12:00:04.377	2025-11-29 15:23:12.706	t	t	12188329	\N
650	Gabriel	2025-11-29 16:42:50.707	2025-11-29 17:04:33.744	t	t	1303037	\N
653	Marquinho	2025-11-29 16:51:50.704	2025-11-29 17:11:04.694	f	t	1153990	\N
648	Maykon Dalmoro	2025-11-29 16:41:26.241	2025-11-29 17:25:29.91	t	t	2643669	\N
642	Pedro Henrique Abreu	2025-11-29 15:12:51.501	2025-11-29 16:30:35.299	t	t	4663798	\N
659	Vinicius Kfouri	2025-11-29 17:43:47.603	\N	f	f	\N	\N
660	lara e vinícius	2025-11-29 17:44:07.629	\N	f	f	\N	\N
647	Gutemberg	2025-11-29 16:03:43.648	2025-11-29 16:51:44.247	t	t	2880599	\N
661	Emerson /  Brenda	2025-11-29 17:48:23.961	\N	f	f	\N	\N
664	Helenzita	2025-11-29 17:54:42.867	\N	f	f	\N	\N
652	Vinicius Santos de L	2025-11-29 16:50:52.409	2025-11-29 18:18:02.88	t	t	5230471	\N
654	Nadia Raquel Murbach	2025-11-29 16:56:56.391	2025-11-29 18:17:22.456	t	t	4826065	\N
655	Fulvio Murbach	2025-11-29 16:56:58.166	2025-11-29 18:17:54.99	t	t	4856824	\N
665	Sheila	2025-11-29 17:57:26.086	2025-11-29 18:37:23.295	f	t	2397209	\N
658	JAMERSON LIMA	2025-11-29 17:12:00.474	2025-11-29 18:56:44.118	f	t	6283644	\N
666	João Pedro	2025-11-29 18:09:18.948	2025-11-29 18:57:15.08	f	t	2876132	\N
663	Bia	2025-11-29 17:50:43.932	2025-11-29 19:04:24.85	f	t	4420918	\N
668	Nicole Cunha	2025-11-29 19:21:47.783	\N	f	f	\N	\N
671	Eu	2025-11-29 19:40:54.715	\N	f	f	\N	\N
669	lucas Silva	2025-11-29 19:26:17.253	2025-11-29 19:57:13.467	t	t	1856214	\N
667	Wellington Costa	2025-11-29 18:59:58.872	2025-11-29 20:03:14.057	t	t	3795185	\N
674	Flavio e Natalis	2025-11-29 20:16:42.39	\N	f	f	\N	\N
676	Itamar	2025-11-29 20:38:03.628	\N	f	f	\N	\N
672	Jhoww e Gabii	2025-11-29 19:54:02.156	2025-11-29 20:38:43.978	t	t	2681822	\N
675	Carlos Manoel Lopes!	2025-11-29 20:37:06.474	2025-11-29 20:51:19.733	t	t	853259	\N
677	Fonseca, Diego	2025-11-29 21:07:38.866	\N	f	f	\N	\N
670	Jessica e Eduardo Si	2025-11-29 19:38:11.545	2025-11-29 20:56:44.71	t	t	4713165	\N
673	Jean e Krol vicente	2025-11-29 20:16:42.093	2025-11-29 21:20:15.516	t	t	3813423	\N
678	Bulla e Thiago	2025-11-29 21:10:14.42	2025-11-29 21:21:02.827	t	t	648407	\N
290	Sara- Matheus - Iury	2025-11-29 12:02:27.727	2025-11-29 12:50:45.215	f	t	2897488	\N
\.


--
-- Data for Name: Treasure; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Treasure" (id, "gameSessionId", "treasureNumber", start, "end", found) FROM stdin;
1657	279	0	2025-11-29 12:01:22.583	\N	f
1658	279	5	2025-11-29 12:01:21.381	\N	f
1659	279	4	2025-11-29 12:01:21.381	\N	f
1660	279	3	2025-11-29 12:01:21.381	\N	f
1661	279	2	2025-11-29 12:01:21.381	\N	f
1662	279	1	2025-11-29 12:01:21.381	\N	f
529	89	0	2025-11-29 11:50:09.691	2025-11-29 11:50:48.805	t
445	75	0	2025-11-29 11:45:08.792	2025-11-29 11:51:47.182	t
523	88	0	2025-11-29 11:50:09.717	2025-11-29 11:53:29.135	t
511	86	0	2025-11-29 11:50:07.768	2025-11-29 11:53:30.175	t
451	76	0	2025-11-29 11:50:05.183	2025-11-29 11:53:41.969	t
463	78	0	2025-11-29 11:50:05.744	2025-11-29 11:53:57.888	t
421	71	0	2025-11-29 11:27:29.275	\N	f
422	71	5	2025-11-29 11:27:29.548	\N	f
423	71	4	2025-11-29 11:27:29.548	\N	f
424	71	3	2025-11-29 11:27:29.548	\N	f
425	71	2	2025-11-29 11:27:29.548	\N	f
426	71	1	2025-11-29 11:27:29.548	\N	f
427	72	0	2025-11-29 11:44:49.111	\N	f
428	72	1	2025-11-29 11:44:49.297	\N	f
429	72	2	2025-11-29 11:44:49.297	\N	f
430	72	3	2025-11-29 11:44:49.297	\N	f
431	72	4	2025-11-29 11:44:49.297	\N	f
432	72	5	2025-11-29 11:44:49.297	\N	f
433	73	0	2025-11-29 11:44:52.897	\N	f
434	73	5	2025-11-29 11:44:53.074	\N	f
435	73	4	2025-11-29 11:44:53.074	\N	f
436	73	3	2025-11-29 11:44:53.074	\N	f
437	73	2	2025-11-29 11:44:53.074	\N	f
438	73	1	2025-11-29 11:44:53.074	\N	f
439	74	0	2025-11-29 11:44:58.648	\N	f
440	74	1	2025-11-29 11:44:57.431	\N	f
441	74	2	2025-11-29 11:44:57.431	\N	f
442	74	3	2025-11-29 11:44:57.431	\N	f
443	74	4	2025-11-29 11:44:57.431	\N	f
444	74	5	2025-11-29 11:44:57.431	\N	f
446	75	5	2025-11-29 11:45:08.721	\N	f
447	75	4	2025-11-29 11:45:08.721	\N	f
448	75	3	2025-11-29 11:45:08.721	\N	f
449	75	2	2025-11-29 11:45:08.721	\N	f
450	75	1	2025-11-29 11:45:08.721	\N	f
457	77	0	2025-11-29 11:50:05.044	\N	f
458	77	1	2025-11-29 11:50:06.006	\N	f
459	77	2	2025-11-29 11:50:06.006	\N	f
460	77	3	2025-11-29 11:50:06.006	\N	f
461	77	4	2025-11-29 11:50:06.006	\N	f
462	77	5	2025-11-29 11:50:06.006	\N	f
469	79	0	2025-11-29 11:50:07.285	\N	f
470	79	1	2025-11-29 11:50:07.488	\N	f
471	79	2	2025-11-29 11:50:07.488	\N	f
472	79	3	2025-11-29 11:50:07.488	\N	f
473	79	4	2025-11-29 11:50:07.488	\N	f
474	79	5	2025-11-29 11:50:07.488	\N	f
475	80	0	2025-11-29 11:50:08.205	\N	f
476	80	5	2025-11-29 11:50:08.38	\N	f
477	80	4	2025-11-29 11:50:08.38	\N	f
478	80	3	2025-11-29 11:50:08.38	\N	f
479	80	2	2025-11-29 11:50:08.38	\N	f
480	80	1	2025-11-29 11:50:08.38	\N	f
481	81	0	2025-11-29 11:50:06.943	\N	f
482	81	1	2025-11-29 11:50:08.411	\N	f
483	81	2	2025-11-29 11:50:08.411	\N	f
484	81	3	2025-11-29 11:50:08.411	\N	f
485	81	4	2025-11-29 11:50:08.411	\N	f
486	81	5	2025-11-29 11:50:08.411	\N	f
487	82	0	2025-11-29 11:50:08.319	\N	f
488	82	5	2025-11-29 11:50:08.499	\N	f
489	82	4	2025-11-29 11:50:08.499	\N	f
490	82	3	2025-11-29 11:50:08.499	\N	f
491	82	2	2025-11-29 11:50:08.499	\N	f
492	82	1	2025-11-29 11:50:08.499	\N	f
499	85	0	2025-11-29 11:50:08.698	\N	f
500	85	5	2025-11-29 11:50:09.123	\N	f
501	85	4	2025-11-29 11:50:09.123	\N	f
502	85	3	2025-11-29 11:50:09.123	\N	f
503	85	2	2025-11-29 11:50:09.123	\N	f
504	85	1	2025-11-29 11:50:09.123	\N	f
505	84	0	2025-11-29 11:50:08.621	\N	f
506	84	5	2025-11-29 11:50:09.122	\N	f
507	84	4	2025-11-29 11:50:09.122	\N	f
508	84	3	2025-11-29 11:50:09.122	\N	f
509	84	2	2025-11-29 11:50:09.122	\N	f
510	84	1	2025-11-29 11:50:09.122	\N	f
517	87	0	2025-11-29 11:50:12.79	\N	f
518	87	5	2025-11-29 11:50:09.833	\N	f
519	87	4	2025-11-29 11:50:09.833	\N	f
520	87	3	2025-11-29 11:50:09.833	\N	f
521	87	2	2025-11-29 11:50:09.833	\N	f
522	87	1	2025-11-29 11:50:09.833	\N	f
535	90	0	2025-11-29 11:50:09.92	\N	f
536	90	5	2025-11-29 11:50:10.041	\N	f
537	90	4	2025-11-29 11:50:10.041	\N	f
493	83	0	2025-11-29 11:50:08.405	2025-11-29 11:54:24.244	t
452	76	1	2025-11-29 11:53:53.107	2025-11-29 11:58:11.176	t
524	88	1	2025-11-29 11:53:35.301	2025-11-29 11:58:12.414	t
464	78	1	2025-11-29 11:54:27.313	2025-11-29 11:58:13.956	t
512	86	1	2025-11-29 11:53:39.493	2025-11-29 11:59:19.289	t
465	78	2	2025-11-29 11:58:23.092	2025-11-29 12:00:41.987	t
513	86	2	2025-11-29 11:59:25.918	2025-11-29 12:01:03.368	t
1687	284	0	2025-11-29 12:01:47.431	\N	f
1688	284	5	2025-11-29 12:01:47.874	\N	f
1689	284	4	2025-11-29 12:01:47.874	\N	f
1690	284	3	2025-11-29 12:01:47.874	\N	f
466	78	3	2025-11-29 12:00:44.534	2025-11-29 12:03:52.195	t
514	86	3	2025-11-29 12:01:07.653	2025-11-29 12:05:19.473	t
494	83	5	2025-11-29 11:54:31.78	2025-11-29 12:05:52.139	t
453	76	2	2025-11-29 11:58:18.087	2025-11-29 12:06:21.218	t
515	86	4	2025-11-29 12:05:22.624	2025-11-29 12:06:31.101	t
454	76	3	2025-11-29 12:06:24.2	2025-11-29 12:06:33.092	t
455	76	4	2025-11-29 12:06:35.085	2025-11-29 12:06:56.116	t
530	89	5	2025-11-29 11:50:51.358	2025-11-29 12:08:57.671	t
495	83	4	2025-11-29 12:05:56.544	2025-11-29 12:09:21.417	t
456	76	5	2025-11-29 12:06:58.033	2025-11-29 12:09:39.26	t
468	78	5	2025-11-29 12:05:38.991	2025-11-29 12:10:38.794	t
1664	280	5	2025-11-29 12:03:16.848	2025-11-29 12:12:28.925	t
531	89	4	2025-11-29 12:10:42.904	2025-11-29 12:20:42.851	t
532	89	3	2025-11-29 12:20:44.824	2025-11-29 12:20:56.506	t
525	88	2	2025-11-29 11:58:14.76	2025-11-29 12:22:30.446	t
533	89	2	2025-11-29 12:20:58.628	2025-11-29 12:24:11.21	t
497	83	2	2025-11-29 12:19:34.169	2025-11-29 12:24:54.054	t
526	88	3	2025-11-29 12:22:33.403	2025-11-29 12:25:28.138	t
498	83	1	2025-11-29 12:24:58.791	2025-11-29 12:25:54.609	t
527	88	4	2025-11-29 12:25:30.894	2025-11-29 12:27:07.759	t
1665	280	4	2025-11-29 12:12:32.109	2025-11-29 12:28:42.239	t
1666	280	3	2025-11-29 12:28:45.19	2025-11-29 12:30:44.892	t
1667	280	2	2025-11-29 12:30:47.773	2025-11-29 12:34:55.64	t
1668	280	1	2025-11-29 12:34:58.34	2025-11-29 12:36:49.823	t
538	90	3	2025-11-29 11:50:10.041	\N	f
539	90	2	2025-11-29 11:50:10.041	\N	f
540	90	1	2025-11-29 11:50:10.041	\N	f
1669	281	0	2025-11-29 12:01:35.074	\N	f
3230	542	5	2025-11-29 13:19:50.907	\N	f
547	92	0	2025-11-29 11:50:11.83	\N	f
548	92	1	2025-11-29 11:50:11.604	\N	f
549	92	2	2025-11-29 11:50:11.604	\N	f
550	92	3	2025-11-29 11:50:11.604	\N	f
551	92	4	2025-11-29 11:50:11.604	\N	f
552	92	5	2025-11-29 11:50:11.604	\N	f
553	93	0	2025-11-29 11:50:12.113	\N	f
554	93	1	2025-11-29 11:50:12.234	\N	f
555	93	2	2025-11-29 11:50:12.234	\N	f
556	93	3	2025-11-29 11:50:12.234	\N	f
557	93	4	2025-11-29 11:50:12.234	\N	f
558	93	5	2025-11-29 11:50:12.234	\N	f
565	95	0	2025-11-29 11:50:16.09	\N	f
566	95	5	2025-11-29 11:50:16.325	\N	f
567	95	4	2025-11-29 11:50:16.325	\N	f
568	95	3	2025-11-29 11:50:16.325	\N	f
569	95	2	2025-11-29 11:50:16.325	\N	f
570	95	1	2025-11-29 11:50:16.325	\N	f
571	96	0	2025-11-29 11:50:19.509	\N	f
572	96	5	2025-11-29 11:50:19.935	\N	f
573	96	4	2025-11-29 11:50:19.935	\N	f
574	96	3	2025-11-29 11:50:19.935	\N	f
575	96	2	2025-11-29 11:50:19.935	\N	f
576	96	1	2025-11-29 11:50:19.935	\N	f
658	110	3	2025-11-29 12:00:45.457	2025-11-29 12:03:55.022	t
3231	542	4	2025-11-29 13:19:50.907	\N	f
584	98	5	2025-11-29 11:50:22.79	\N	f
585	98	4	2025-11-29 11:50:22.79	\N	f
586	98	3	2025-11-29 11:50:22.79	\N	f
587	98	2	2025-11-29 11:50:22.79	\N	f
588	98	1	2025-11-29 11:50:22.79	\N	f
589	99	0	2025-11-29 11:50:23.573	\N	f
590	99	1	2025-11-29 11:50:23.572	\N	f
591	99	2	2025-11-29 11:50:23.572	\N	f
592	99	3	2025-11-29 11:50:23.572	\N	f
593	99	4	2025-11-29 11:50:23.572	\N	f
594	99	5	2025-11-29 11:50:23.572	\N	f
595	100	0	2025-11-29 11:50:24.824	\N	f
596	100	1	2025-11-29 11:50:25.687	\N	f
597	100	2	2025-11-29 11:50:25.687	\N	f
598	100	3	2025-11-29 11:50:25.687	\N	f
599	100	4	2025-11-29 11:50:25.687	\N	f
600	100	5	2025-11-29 11:50:25.687	\N	f
601	101	0	2025-11-29 11:50:27.997	\N	f
602	101	1	2025-11-29 11:50:29.659	\N	f
603	101	2	2025-11-29 11:50:29.659	\N	f
604	101	3	2025-11-29 11:50:29.659	\N	f
605	101	4	2025-11-29 11:50:29.659	\N	f
606	101	5	2025-11-29 11:50:29.659	\N	f
607	102	0	2025-11-29 11:50:35.006	\N	f
608	102	1	2025-11-29 11:50:34.651	\N	f
609	102	2	2025-11-29 11:50:34.651	\N	f
610	102	3	2025-11-29 11:50:34.651	\N	f
611	102	4	2025-11-29 11:50:34.651	\N	f
612	102	5	2025-11-29 11:50:34.651	\N	f
613	103	0	2025-11-29 11:50:35.665	\N	f
614	103	1	2025-11-29 11:50:35.813	\N	f
615	103	2	2025-11-29 11:50:35.813	\N	f
616	103	3	2025-11-29 11:50:35.813	\N	f
617	103	4	2025-11-29 11:50:35.813	\N	f
618	103	5	2025-11-29 11:50:35.813	\N	f
619	104	0	2025-11-29 11:55:55.78	\N	f
620	104	1	2025-11-29 11:50:37.586	\N	f
621	104	2	2025-11-29 11:50:37.586	\N	f
622	104	3	2025-11-29 11:50:37.586	\N	f
623	104	4	2025-11-29 11:50:37.586	\N	f
624	104	5	2025-11-29 11:50:37.586	\N	f
659	110	4	2025-11-29 12:03:57.263	2025-11-29 12:05:39.566	t
631	106	0	2025-11-29 11:50:42.37	\N	f
632	106	5	2025-11-29 11:50:42.949	\N	f
633	106	4	2025-11-29 11:50:42.949	\N	f
634	106	3	2025-11-29 11:50:42.949	\N	f
635	106	2	2025-11-29 11:50:42.949	\N	f
636	106	1	2025-11-29 11:50:42.949	\N	f
637	107	0	2025-11-29 11:50:42.276	\N	f
638	107	5	2025-11-29 11:50:43.025	\N	f
639	107	4	2025-11-29 11:50:43.025	\N	f
640	107	3	2025-11-29 11:50:43.025	\N	f
641	107	2	2025-11-29 11:50:43.025	\N	f
642	107	1	2025-11-29 11:50:43.025	\N	f
643	108	0	2025-11-29 11:50:41.988	\N	f
644	108	5	2025-11-29 11:50:43.083	\N	f
645	108	4	2025-11-29 11:50:43.083	\N	f
646	108	3	2025-11-29 11:50:43.083	\N	f
647	108	2	2025-11-29 11:50:43.083	\N	f
648	108	1	2025-11-29 11:50:43.083	\N	f
649	109	0	2025-11-29 11:50:44.771	\N	f
650	109	5	2025-11-29 11:50:45.146	\N	f
651	109	4	2025-11-29 11:50:45.146	\N	f
652	109	3	2025-11-29 11:50:45.146	\N	f
653	109	2	2025-11-29 11:50:45.146	\N	f
654	109	1	2025-11-29 11:50:45.146	\N	f
661	111	0	2025-11-29 11:50:52.445	\N	f
662	111	1	2025-11-29 11:50:52.809	\N	f
663	111	2	2025-11-29 11:50:52.809	\N	f
664	111	3	2025-11-29 11:50:52.809	\N	f
665	111	4	2025-11-29 11:50:52.809	\N	f
666	111	5	2025-11-29 11:50:52.809	\N	f
667	112	0	2025-11-29 11:50:53.393	\N	f
668	112	1	2025-11-29 11:50:53.247	\N	f
669	112	2	2025-11-29 11:50:53.247	\N	f
670	112	3	2025-11-29 11:50:53.247	\N	f
671	112	4	2025-11-29 11:50:53.247	\N	f
672	112	5	2025-11-29 11:50:53.247	\N	f
655	110	0	2025-11-29 11:50:50.508	2025-11-29 11:54:20.606	t
541	91	0	2025-11-29 11:50:11.076	2025-11-29 11:54:53.115	t
559	94	0	2025-11-29 11:50:12.99	2025-11-29 11:55:10.037	t
673	113	0	2025-11-29 11:50:59.952	2025-11-29 11:55:16.622	t
656	110	1	2025-11-29 11:54:25.294	2025-11-29 11:58:11.045	t
583	98	0	2025-11-29 11:50:22.001	2025-11-29 12:00:12.733	t
560	94	1	2025-11-29 11:55:14.283	2025-11-29 12:00:25.084	t
657	110	2	2025-11-29 11:58:14.582	2025-11-29 12:00:43.172	t
543	91	2	2025-11-29 11:59:29.248	2025-11-29 12:00:48.777	t
545	91	4	2025-11-29 12:05:19.573	2025-11-29 12:07:12.329	t
626	105	5	2025-11-29 11:54:27.732	2025-11-29 12:08:50.729	t
660	110	5	2025-11-29 12:05:41.954	2025-11-29 12:09:04.718	t
546	91	5	2025-11-29 12:07:15.766	2025-11-29 12:12:05.525	t
561	94	2	2025-11-29 12:00:30.985	2025-11-29 12:18:33.811	t
628	105	3	2025-11-29 12:18:08.743	2025-11-29 12:20:57.987	t
562	94	3	2025-11-29 12:18:37.047	2025-11-29 12:22:31.279	t
629	105	2	2025-11-29 12:20:59.783	2025-11-29 12:23:55.326	t
563	94	4	2025-11-29 12:22:35.654	2025-11-29 12:23:59.606	t
564	94	5	2025-11-29 12:24:02.365	2025-11-29 12:26:16.095	t
579	97	2	2025-11-29 12:01:45.274	2025-11-29 12:27:46.955	t
580	97	3	2025-11-29 12:27:50.437	2025-11-29 12:31:33.554	t
581	97	4	2025-11-29 12:31:38.413	2025-11-29 12:33:04.728	t
679	114	0	2025-11-29 11:50:59.793	\N	f
680	114	5	2025-11-29 11:51:00.312	\N	f
681	114	4	2025-11-29 11:51:00.312	\N	f
682	114	3	2025-11-29 11:51:00.312	\N	f
683	114	2	2025-11-29 11:51:00.312	\N	f
684	114	1	2025-11-29 11:51:00.312	\N	f
685	115	0	2025-11-29 11:51:02.674	\N	f
686	115	5	2025-11-29 11:51:02.803	\N	f
687	115	4	2025-11-29 11:51:02.803	\N	f
688	115	3	2025-11-29 11:51:02.803	\N	f
689	115	2	2025-11-29 11:51:02.803	\N	f
690	115	1	2025-11-29 11:51:02.803	\N	f
691	116	0	2025-11-29 11:51:04.634	\N	f
692	116	5	2025-11-29 11:51:05.207	\N	f
693	116	4	2025-11-29 11:51:05.207	\N	f
694	116	3	2025-11-29 11:51:05.207	\N	f
695	116	2	2025-11-29 11:51:05.207	\N	f
696	116	1	2025-11-29 11:51:05.207	\N	f
698	117	5	2025-11-29 11:51:09.579	\N	f
699	117	4	2025-11-29 11:51:09.579	\N	f
700	117	3	2025-11-29 11:51:09.579	\N	f
701	117	2	2025-11-29 11:51:09.579	\N	f
702	117	1	2025-11-29 11:51:09.579	\N	f
3232	542	3	2025-11-29 13:19:50.907	\N	f
706	118	3	2025-11-29 11:51:09.774	\N	f
3233	542	2	2025-11-29 13:19:50.907	\N	f
715	120	0	2025-11-29 11:51:15.297	\N	f
716	120	5	2025-11-29 11:51:14.764	\N	f
717	120	4	2025-11-29 11:51:14.764	\N	f
718	120	3	2025-11-29 11:51:14.764	\N	f
719	120	2	2025-11-29 11:51:14.764	\N	f
720	120	1	2025-11-29 11:51:14.764	\N	f
721	121	0	2025-11-29 11:51:19.497	\N	f
722	121	1	2025-11-29 11:51:19.736	\N	f
723	121	2	2025-11-29 11:51:19.736	\N	f
724	121	3	2025-11-29 11:51:19.736	\N	f
725	121	4	2025-11-29 11:51:19.736	\N	f
726	121	5	2025-11-29 11:51:19.736	\N	f
734	123	1	2025-11-29 11:51:26.478	\N	f
735	123	2	2025-11-29 11:51:26.478	\N	f
736	123	3	2025-11-29 11:51:26.478	\N	f
737	123	4	2025-11-29 11:51:26.478	\N	f
738	123	5	2025-11-29 11:51:26.478	\N	f
739	124	0	2025-11-29 11:51:06.2	\N	f
740	124	1	2025-11-29 11:51:29.558	\N	f
741	124	2	2025-11-29 11:51:29.558	\N	f
742	124	3	2025-11-29 11:51:29.558	\N	f
743	124	4	2025-11-29 11:51:29.558	\N	f
744	124	5	2025-11-29 11:51:29.558	\N	f
745	125	0	2025-11-29 11:53:04.872	\N	f
746	125	1	2025-11-29 11:51:30.843	\N	f
747	125	2	2025-11-29 11:51:30.843	\N	f
748	125	3	2025-11-29 11:51:30.843	\N	f
749	125	4	2025-11-29 11:51:30.843	\N	f
750	125	5	2025-11-29 11:51:30.843	\N	f
751	126	0	2025-11-29 11:51:30.752	\N	f
752	126	1	2025-11-29 11:51:31.753	\N	f
753	126	2	2025-11-29 11:51:31.753	\N	f
754	126	3	2025-11-29 11:51:31.753	\N	f
755	126	4	2025-11-29 11:51:31.753	\N	f
756	126	5	2025-11-29 11:51:31.753	\N	f
1670	281	1	2025-11-29 12:01:35.772	\N	f
674	113	5	2025-11-29 11:55:24.856	2025-11-29 12:05:19.371	t
776	130	5	2025-11-29 11:51:51.506	\N	f
777	130	4	2025-11-29 11:51:51.506	\N	f
778	130	3	2025-11-29 11:51:51.506	\N	f
779	130	2	2025-11-29 11:51:51.506	\N	f
780	130	1	2025-11-29 11:51:51.506	\N	f
781	131	0	2025-11-29 11:51:46.141	\N	f
782	131	1	2025-11-29 11:51:55.059	\N	f
783	131	2	2025-11-29 11:51:55.059	\N	f
784	131	3	2025-11-29 11:51:55.059	\N	f
785	131	4	2025-11-29 11:51:55.059	\N	f
786	131	5	2025-11-29 11:51:55.059	\N	f
787	132	0	2025-11-29 11:51:58.576	\N	f
788	132	5	2025-11-29 11:51:59.123	\N	f
789	132	4	2025-11-29 11:51:59.123	\N	f
790	132	3	2025-11-29 11:51:59.123	\N	f
791	132	2	2025-11-29 11:51:59.123	\N	f
792	132	1	2025-11-29 11:51:59.123	\N	f
764	128	1	2025-11-29 11:58:58.152	2025-11-29 12:06:32.66	t
799	134	0	2025-11-29 11:52:00.134	\N	f
800	134	5	2025-11-29 11:52:00.113	\N	f
801	134	4	2025-11-29 11:52:00.113	\N	f
802	134	3	2025-11-29 11:52:00.113	\N	f
803	134	2	2025-11-29 11:52:00.113	\N	f
804	134	1	2025-11-29 11:52:00.113	\N	f
805	135	0	2025-11-29 11:52:00.062	\N	f
806	135	5	2025-11-29 11:52:00.19	\N	f
807	135	4	2025-11-29 11:52:00.19	\N	f
808	135	3	2025-11-29 11:52:00.19	\N	f
809	135	2	2025-11-29 11:52:00.19	\N	f
709	119	0	2025-11-29 11:51:12.04	2025-11-29 11:55:17.434	t
733	123	0	2025-11-29 11:51:26.369	2025-11-29 11:57:14.897	t
770	129	1	2025-11-29 11:54:15.707	2025-11-29 11:57:42.025	t
757	127	0	2025-11-29 11:51:40.511	2025-11-29 11:58:39.462	t
763	128	0	2025-11-29 11:51:44.897	2025-11-29 11:58:53.462	t
697	117	0	2025-11-29 11:51:09.322	2025-11-29 12:00:03.404	t
727	122	0	2025-11-29 11:51:21.925	2025-11-29 12:00:08.26	t
703	118	0	2025-11-29 11:50:01.871	2025-11-29 12:05:40.661	t
794	133	5	2025-11-29 11:59:36.162	2025-11-29 12:07:46.471	t
711	119	4	2025-11-29 12:05:20.235	2025-11-29 12:08:31.673	t
675	113	4	2025-11-29 12:05:23.138	2025-11-29 12:10:08.45	t
771	129	2	2025-11-29 11:57:45.301	2025-11-29 12:10:12.033	t
712	119	3	2025-11-29 12:08:37.915	2025-11-29 12:12:12.035	t
676	113	3	2025-11-29 12:10:11.642	2025-11-29 12:12:47.191	t
772	129	3	2025-11-29 12:10:14.577	2025-11-29 12:13:32.229	t
773	129	4	2025-11-29 12:13:34.345	2025-11-29 12:13:48.617	t
796	133	3	2025-11-29 12:12:44.827	2025-11-29 12:14:59.641	t
677	113	2	2025-11-29 12:12:49.26	2025-11-29 12:16:29.754	t
728	122	5	2025-11-29 12:00:14.853	2025-11-29 12:17:09.303	t
758	127	5	2025-11-29 11:58:42.766	2025-11-29 12:17:30.999	t
678	113	1	2025-11-29 12:16:31.83	2025-11-29 12:18:03.742	t
797	133	2	2025-11-29 12:15:02.592	2025-11-29 12:23:15.735	t
704	118	5	2025-11-29 12:05:45.098	2025-11-29 12:23:38.627	t
798	133	1	2025-11-29 12:23:26.748	2025-11-29 12:25:08.372	t
713	119	2	2025-11-29 12:12:20.714	2025-11-29 12:27:32.693	t
759	127	4	2025-11-29 12:17:35.079	2025-11-29 12:28:16.296	t
714	119	1	2025-11-29 12:27:37.343	2025-11-29 12:28:54.525	t
730	122	3	2025-11-29 12:24:33.059	2025-11-29 12:29:57.057	t
760	127	3	2025-11-29 12:28:21.122	2025-11-29 12:30:57.423	t
731	122	2	2025-11-29 12:30:00.077	2025-11-29 12:34:34.046	t
761	127	2	2025-11-29 12:30:59.719	2025-11-29 12:35:04.84	t
762	127	1	2025-11-29 12:35:07.982	2025-11-29 12:36:47.804	t
766	128	3	2025-11-29 12:07:41.563	2025-11-29 12:38:47.885	t
767	128	4	2025-11-29 12:38:50.423	2025-11-29 12:41:56.856	t
707	118	2	2025-11-29 12:31:22.44	2025-11-29 12:48:19.797	t
708	118	1	2025-11-29 12:48:22.744	2025-11-29 12:50:56.838	t
810	135	1	2025-11-29 11:52:00.19	\N	f
812	136	5	2025-11-29 11:52:06.617	\N	f
813	136	4	2025-11-29 11:52:06.617	\N	f
814	136	3	2025-11-29 11:52:06.617	\N	f
815	136	2	2025-11-29 11:52:06.617	\N	f
816	136	1	2025-11-29 11:52:06.617	\N	f
811	136	0	2025-11-29 11:52:06.225	2025-11-29 11:56:28.631	t
1671	281	2	2025-11-29 12:01:35.772	\N	f
1672	281	3	2025-11-29 12:01:35.772	\N	f
1673	281	4	2025-11-29 12:01:35.772	\N	f
1674	281	5	2025-11-29 12:01:35.772	\N	f
1681	283	0	2025-11-29 12:01:42.278	\N	f
1682	283	1	2025-11-29 12:01:42.515	\N	f
1683	283	2	2025-11-29 12:01:42.515	\N	f
1684	283	3	2025-11-29 12:01:42.515	\N	f
1685	283	4	2025-11-29 12:01:42.515	\N	f
1686	283	5	2025-11-29 12:01:42.515	\N	f
578	97	1	2025-11-29 11:54:00.336	2025-11-29 12:01:41.377	t
1694	285	5	2025-11-29 12:01:49.881	\N	f
1695	285	4	2025-11-29 12:01:49.881	\N	f
1696	285	3	2025-11-29 12:01:49.881	\N	f
1697	285	2	2025-11-29 12:01:49.881	\N	f
1698	285	1	2025-11-29 12:01:49.881	\N	f
1700	286	1	2025-11-29 12:01:50.327	\N	f
1701	286	2	2025-11-29 12:01:50.327	\N	f
1702	286	3	2025-11-29 12:01:50.327	\N	f
1703	286	4	2025-11-29 12:01:50.327	\N	f
1704	286	5	2025-11-29 12:01:50.327	\N	f
3234	542	1	2025-11-29 13:19:50.907	\N	f
1711	288	0	2025-11-29 12:02:04.419	\N	f
1712	288	1	2025-11-29 12:02:04.989	\N	f
1713	288	2	2025-11-29 12:02:04.989	\N	f
1714	288	3	2025-11-29 12:02:04.989	\N	f
1715	288	4	2025-11-29 12:02:04.989	\N	f
1716	288	5	2025-11-29 12:02:04.989	\N	f
1717	289	0	2025-11-29 12:02:23.389	\N	f
1718	289	5	2025-11-29 12:02:24.5	\N	f
1719	289	4	2025-11-29 12:02:24.5	\N	f
1720	289	3	2025-11-29 12:02:24.5	\N	f
1721	289	2	2025-11-29 12:02:24.5	\N	f
1722	289	1	2025-11-29 12:02:24.5	\N	f
1663	280	0	2025-11-29 12:01:25.682	2025-11-29 12:03:12.912	t
1750	294	3	2025-11-29 13:43:03.473	2025-11-29 13:48:58.759	t
1075	181	0	2025-11-29 11:54:17.848	2025-11-29 12:03:32.053	t
1751	294	4	2025-11-29 13:49:01.776	2025-11-29 13:51:24.819	t
1752	294	5	2025-11-29 13:51:31.453	2025-11-29 13:56:54.642	t
1774	298	3	2025-11-29 12:03:54.556	\N	f
1775	298	4	2025-11-29 12:03:54.556	\N	f
1776	298	5	2025-11-29 12:03:54.556	\N	f
1789	301	0	2025-11-29 12:04:16.252	\N	f
1790	301	1	2025-11-29 12:04:16.417	\N	f
1791	301	2	2025-11-29 12:04:16.417	\N	f
1792	301	3	2025-11-29 12:04:16.417	\N	f
1793	301	4	2025-11-29 12:04:16.417	\N	f
1794	301	5	2025-11-29 12:04:16.417	\N	f
1699	286	0	2025-11-29 12:01:52.08	2025-11-29 12:04:22.283	t
1771	298	0	2025-11-29 12:03:54.277	2025-11-29 12:05:45.261	t
1759	296	0	2025-11-29 12:03:43.17	2025-11-29 12:06:56.67	t
1945	327	0	2025-11-29 12:07:19.883	\N	f
1946	327	5	2025-11-29 12:07:20.115	\N	f
1947	327	4	2025-11-29 12:07:20.115	\N	f
1948	327	3	2025-11-29 12:07:20.115	\N	f
1949	327	2	2025-11-29 12:07:20.115	\N	f
1950	327	1	2025-11-29 12:07:20.115	\N	f
2001	336	4	2025-11-29 13:04:08.039	2025-11-29 14:05:47.693	t
1953	328	2	2025-11-29 12:07:24.042	\N	f
1954	328	3	2025-11-29 12:07:24.042	\N	f
1955	328	4	2025-11-29 12:07:24.042	\N	f
1956	328	5	2025-11-29 12:07:24.042	\N	f
1765	297	0	2025-11-29 12:03:53.496	2025-11-29 12:07:22.684	t
1963	330	0	2025-11-29 12:07:42.048	\N	f
1964	330	1	2025-11-29 12:07:47.066	\N	f
1965	330	2	2025-11-29 12:07:47.066	\N	f
1966	330	3	2025-11-29 12:07:47.066	\N	f
1967	330	4	2025-11-29 12:07:47.066	\N	f
1968	330	5	2025-11-29 12:07:47.066	\N	f
1969	331	0	2025-11-29 12:07:48.309	\N	f
1970	331	5	2025-11-29 12:07:48.024	\N	f
1971	331	4	2025-11-29 12:07:48.024	\N	f
1972	331	3	2025-11-29 12:07:48.024	\N	f
1973	331	2	2025-11-29 12:07:48.024	\N	f
1974	331	1	2025-11-29 12:07:48.024	\N	f
1941	326	4	2025-11-29 14:06:26.282	2025-11-29 14:12:57.032	t
1942	326	3	2025-11-29 14:12:58.708	2025-11-29 14:29:47.984	t
1184	199	1	2025-11-29 12:01:34.377	2025-11-29 12:08:02.396	t
1995	335	2	2025-11-29 12:08:39.88	\N	f
1996	335	3	2025-11-29 12:08:39.88	\N	f
1997	335	4	2025-11-29 12:08:39.88	\N	f
1998	335	5	2025-11-29 12:08:39.88	\N	f
1693	285	0	2025-11-29 12:01:49.716	2025-11-29 12:08:50.846	t
2007	337	2	2025-11-29 12:08:57.353	\N	f
1705	287	0	2025-11-29 12:01:55.284	2025-11-29 12:09:30.452	t
1772	298	1	2025-11-29 12:05:50.605	2025-11-29 12:09:51.561	t
2005	337	0	2025-11-29 12:08:57.216	2025-11-29 12:13:42.529	t
1766	297	1	2025-11-29 12:07:31.294	2025-11-29 12:14:18.019	t
1760	296	1	2025-11-29 12:07:07.882	2025-11-29 12:14:41.182	t
1773	298	2	2025-11-29 12:09:54.625	2025-11-29 12:15:48.627	t
1761	296	2	2025-11-29 12:14:57.667	2025-11-29 12:17:11.78	t
1999	336	0	2025-11-29 12:08:48.224	2025-11-29 12:20:43.022	t
1706	287	5	2025-11-29 12:10:02.419	2025-11-29 12:24:00.898	t
2006	337	1	2025-11-29 12:13:47.359	2025-11-29 12:24:16.837	t
1768	297	3	2025-11-29 12:16:23.543	2025-11-29 12:25:23.637	t
1769	297	4	2025-11-29 12:25:28.217	2025-11-29 12:28:05.986	t
1707	287	4	2025-11-29 12:24:05.206	2025-11-29 12:28:32.068	t
1708	287	3	2025-11-29 12:28:57.727	2025-11-29 12:29:05.405	t
1675	282	0	2025-11-29 12:01:39.606	2025-11-29 12:29:16.289	t
1709	287	2	2025-11-29 12:29:10.135	2025-11-29 12:29:20.15	t
1976	332	1	2025-11-29 12:11:02.019	2025-11-29 12:29:55.954	t
1762	296	3	2025-11-29 12:17:14.418	2025-11-29 12:31:50.612	t
1977	332	2	2025-11-29 12:31:23.632	2025-11-29 12:32:29.258	t
1770	297	5	2025-11-29 12:28:09.462	2025-11-29 12:33:32.197	t
1978	332	3	2025-11-29 12:32:31.925	2025-11-29 12:37:38.085	t
1979	332	4	2025-11-29 12:37:41.169	2025-11-29 12:40:09.481	t
1764	296	5	2025-11-29 12:35:01.907	2025-11-29 12:40:10.631	t
1676	282	1	2025-11-29 12:29:20.974	2025-11-29 12:41:19.592	t
1748	294	1	2025-11-29 12:33:34.561	2025-11-29 12:44:42.174	t
2000	336	5	2025-11-29 12:21:15.845	2025-11-29 13:04:00.76	t
1952	328	1	2025-11-29 12:09:33.928	2025-11-29 13:09:01.478	t
1943	326	2	2025-11-29 14:29:52.821	2025-11-29 14:40:36.788	t
2003	336	2	2025-11-29 14:09:07.935	2025-11-29 14:40:50.077	t
1944	326	1	2025-11-29 14:40:38.589	2025-11-29 14:43:07.039	t
1677	282	2	2025-11-29 12:41:23.109	2025-11-29 15:19:51.093	t
1678	282	3	2025-11-29 15:19:53.936	2025-11-29 15:33:05.244	t
1679	282	4	2025-11-29 15:33:07.465	2025-11-29 15:36:17.81	t
1680	282	5	2025-11-29 15:36:19.817	2025-11-29 20:43:14.287	t
817	137	0	2025-11-29 11:52:10.77	\N	f
818	137	1	2025-11-29 11:52:11.024	\N	f
819	137	2	2025-11-29 11:52:11.024	\N	f
820	137	3	2025-11-29 11:52:11.024	\N	f
821	137	4	2025-11-29 11:52:11.024	\N	f
822	137	5	2025-11-29 11:52:11.024	\N	f
823	138	0	2025-11-29 11:52:14.578	\N	f
824	138	5	2025-11-29 11:52:15.48	\N	f
825	138	4	2025-11-29 11:52:15.48	\N	f
826	138	3	2025-11-29 11:52:15.48	\N	f
827	138	2	2025-11-29 11:52:15.48	\N	f
828	138	1	2025-11-29 11:52:15.48	\N	f
829	139	0	2025-11-29 11:52:15.517	\N	f
830	139	5	2025-11-29 11:52:15.673	\N	f
831	139	4	2025-11-29 11:52:15.673	\N	f
832	139	3	2025-11-29 11:52:15.673	\N	f
833	139	2	2025-11-29 11:52:15.673	\N	f
834	139	1	2025-11-29 11:52:15.673	\N	f
835	140	0	2025-11-29 11:52:19.007	\N	f
836	140	1	2025-11-29 11:52:19.179	\N	f
837	140	2	2025-11-29 11:52:19.179	\N	f
838	140	3	2025-11-29 11:52:19.179	\N	f
839	140	4	2025-11-29 11:52:19.179	\N	f
840	140	5	2025-11-29 11:52:19.179	\N	f
841	141	0	2025-11-29 11:52:19.153	\N	f
842	141	1	2025-11-29 11:52:19.329	\N	f
843	141	2	2025-11-29 11:52:19.329	\N	f
844	141	3	2025-11-29 11:52:19.329	\N	f
845	141	4	2025-11-29 11:52:19.329	\N	f
846	141	5	2025-11-29 11:52:19.329	\N	f
848	142	5	2025-11-29 11:52:23.887	\N	f
849	142	4	2025-11-29 11:52:23.887	\N	f
850	142	3	2025-11-29 11:52:23.887	\N	f
851	142	2	2025-11-29 11:52:23.887	\N	f
852	142	1	2025-11-29 11:52:23.887	\N	f
853	143	0	2025-11-29 11:52:24.192	\N	f
854	143	1	2025-11-29 11:52:24.323	\N	f
855	143	2	2025-11-29 11:52:24.323	\N	f
856	143	3	2025-11-29 11:52:24.323	\N	f
857	143	4	2025-11-29 11:52:24.323	\N	f
858	143	5	2025-11-29 11:52:24.323	\N	f
859	144	0	2025-11-29 11:52:31.133	\N	f
860	144	5	2025-11-29 11:52:31.316	\N	f
861	144	4	2025-11-29 11:52:31.316	\N	f
862	144	3	2025-11-29 11:52:31.316	\N	f
863	144	2	2025-11-29 11:52:31.316	\N	f
864	144	1	2025-11-29 11:52:31.316	\N	f
1691	284	2	2025-11-29 12:01:47.874	\N	f
1692	284	1	2025-11-29 12:01:47.874	\N	f
871	146	0	2025-11-29 11:52:33.594	\N	f
872	146	1	2025-11-29 11:52:34.561	\N	f
873	146	2	2025-11-29 11:52:34.561	\N	f
874	146	3	2025-11-29 11:52:34.561	\N	f
875	146	4	2025-11-29 11:52:34.561	\N	f
876	146	5	2025-11-29 11:52:34.561	\N	f
877	147	0	2025-11-29 11:52:36.308	\N	f
878	147	5	2025-11-29 11:52:36.483	\N	f
879	147	4	2025-11-29 11:52:36.483	\N	f
880	147	3	2025-11-29 11:52:36.483	\N	f
881	147	2	2025-11-29 11:52:36.483	\N	f
882	147	1	2025-11-29 11:52:36.483	\N	f
3235	543	0	2025-11-29 13:19:53.392	2025-11-29 13:30:10.091	t
890	149	5	2025-11-29 11:52:40.81	\N	f
891	149	4	2025-11-29 11:52:40.81	\N	f
892	149	3	2025-11-29 11:52:40.81	\N	f
893	149	2	2025-11-29 11:52:40.81	\N	f
894	149	1	2025-11-29 11:52:40.81	\N	f
897	150	4	2025-11-29 13:22:37.246	2025-11-29 14:09:51.495	t
907	152	0	2025-11-29 11:52:44.708	\N	f
908	152	1	2025-11-29 11:52:45.552	\N	f
909	152	2	2025-11-29 11:52:45.552	\N	f
910	152	3	2025-11-29 11:52:45.552	\N	f
911	152	4	2025-11-29 11:52:45.552	\N	f
912	152	5	2025-11-29 11:52:45.552	\N	f
903	151	4	2025-11-29 12:04:59.114	2025-11-29 12:08:23.979	t
898	150	3	2025-11-29 14:09:54.337	2025-11-29 14:13:25.509	t
919	155	0	2025-11-29 11:52:58.715	\N	f
920	155	1	2025-11-29 11:52:58.449	\N	f
921	155	2	2025-11-29 11:52:58.449	\N	f
922	155	3	2025-11-29 11:52:58.449	\N	f
923	155	4	2025-11-29 11:52:58.449	\N	f
924	155	5	2025-11-29 11:52:58.449	\N	f
899	150	2	2025-11-29 14:13:31.165	2025-11-29 14:20:14.07	t
927	156	2	2025-11-29 11:53:01.507	\N	f
928	156	3	2025-11-29 11:53:01.507	\N	f
929	156	4	2025-11-29 11:53:01.507	\N	f
930	156	5	2025-11-29 11:53:01.507	\N	f
931	157	0	2025-11-29 11:53:04.304	\N	f
932	157	5	2025-11-29 11:53:04.109	\N	f
933	157	4	2025-11-29 11:53:04.109	\N	f
934	157	3	2025-11-29 11:53:04.109	\N	f
935	157	2	2025-11-29 11:53:04.109	\N	f
936	157	1	2025-11-29 11:53:04.109	\N	f
937	158	0	2025-11-29 11:53:05.671	\N	f
938	158	1	2025-11-29 11:53:05.819	\N	f
939	158	2	2025-11-29 11:53:05.819	\N	f
940	158	3	2025-11-29 11:53:05.819	\N	f
941	158	4	2025-11-29 11:53:05.819	\N	f
942	158	5	2025-11-29 11:53:05.819	\N	f
943	159	0	2025-11-29 11:53:04.335	\N	f
944	159	1	2025-11-29 11:53:05.833	\N	f
945	159	2	2025-11-29 11:53:05.833	\N	f
946	159	3	2025-11-29 11:53:05.833	\N	f
947	159	4	2025-11-29 11:53:05.833	\N	f
948	159	5	2025-11-29 11:53:05.833	\N	f
949	160	0	2025-11-29 11:53:10.189	\N	f
950	160	5	2025-11-29 11:53:10.125	\N	f
951	160	4	2025-11-29 11:53:10.125	\N	f
952	160	3	2025-11-29 11:53:10.125	\N	f
847	142	0	2025-11-29 11:52:23.75	2025-11-29 11:54:33.608	t
895	150	0	2025-11-29 11:52:43.727	2025-11-29 11:55:07.977	t
901	151	0	2025-11-29 11:52:44.947	2025-11-29 11:55:14.289	t
925	156	0	2025-11-29 11:53:02.701	2025-11-29 11:55:25.746	t
889	149	0	2025-11-29 11:52:40.601	2025-11-29 11:56:09.137	t
883	148	0	2025-11-29 11:52:39.4	2025-11-29 12:12:40.742	t
914	153	5	2025-11-29 11:54:00.906	2025-11-29 12:13:26.801	t
904	151	3	2025-11-29 12:08:26.245	2025-11-29 12:17:31.512	t
884	148	5	2025-11-29 12:12:54.247	2025-11-29 12:19:42.707	t
867	145	2	2025-11-29 11:59:32.666	2025-11-29 12:21:54.284	t
916	153	3	2025-11-29 12:21:56.177	2025-11-29 12:24:21.438	t
905	151	2	2025-11-29 12:18:01.488	2025-11-29 12:27:34.684	t
906	151	1	2025-11-29 12:27:36.451	2025-11-29 12:28:53.316	t
917	153	2	2025-11-29 12:24:24.801	2025-11-29 12:30:10.508	t
918	153	1	2025-11-29 12:30:14.331	2025-11-29 12:31:21.46	t
869	145	4	2025-11-29 12:31:18.836	2025-11-29 12:33:52.486	t
870	145	5	2025-11-29 12:33:55.66	2025-11-29 12:34:15.714	t
885	148	4	2025-11-29 12:20:17.664	2025-11-29 12:40:50.655	t
887	148	2	2025-11-29 12:42:52.552	2025-11-29 12:47:18.185	t
888	148	1	2025-11-29 12:47:20.4	2025-11-29 12:49:12.281	t
953	160	2	2025-11-29 11:53:10.125	\N	f
954	160	1	2025-11-29 11:53:10.125	\N	f
955	161	0	2025-11-29 11:53:10.598	\N	f
956	161	5	2025-11-29 11:53:11.607	\N	f
957	161	4	2025-11-29 11:53:11.607	\N	f
958	161	3	2025-11-29 11:53:11.607	\N	f
959	161	2	2025-11-29 11:53:11.607	\N	f
960	161	1	2025-11-29 11:53:11.607	\N	f
962	162	5	2025-11-29 11:53:23.986	\N	f
963	162	4	2025-11-29 11:53:23.986	\N	f
964	162	3	2025-11-29 11:53:23.986	\N	f
965	162	2	2025-11-29 11:53:23.986	\N	f
966	162	1	2025-11-29 11:53:23.986	\N	f
967	163	0	2025-11-29 11:53:27.812	\N	f
968	163	1	2025-11-29 11:53:28.258	\N	f
969	163	2	2025-11-29 11:53:28.258	\N	f
970	163	3	2025-11-29 11:53:28.258	\N	f
971	163	4	2025-11-29 11:53:28.258	\N	f
972	163	5	2025-11-29 11:53:28.258	\N	f
1105	186	0	2025-11-29 11:54:45.662	2025-11-29 12:01:38.257	t
979	165	0	2025-11-29 11:53:32.973	\N	f
980	165	1	2025-11-29 11:53:32.806	\N	f
981	165	2	2025-11-29 11:53:32.806	\N	f
982	165	3	2025-11-29 11:53:32.806	\N	f
983	165	4	2025-11-29 11:53:32.806	\N	f
984	165	5	2025-11-29 11:53:32.806	\N	f
992	168	0	2025-11-29 11:53:34.192	\N	f
926	156	1	2025-11-29 11:55:32.312	2025-11-29 12:02:19.288	t
998	168	1	2025-11-29 11:53:35.774	\N	f
999	168	2	2025-11-29 11:53:35.774	\N	f
1000	168	3	2025-11-29 11:53:35.774	\N	f
1001	168	4	2025-11-29 11:53:35.774	\N	f
1002	168	5	2025-11-29 11:53:35.774	\N	f
1003	169	0	2025-11-29 11:53:35.44	\N	f
1004	169	5	2025-11-29 11:53:36.343	\N	f
1005	169	4	2025-11-29 11:53:36.343	\N	f
1006	169	3	2025-11-29 11:53:36.343	\N	f
1007	169	2	2025-11-29 11:53:36.343	\N	f
1008	169	1	2025-11-29 11:53:36.343	\N	f
1009	170	0	2025-11-29 11:53:37.319	\N	f
1010	170	5	2025-11-29 11:53:39.001	\N	f
1011	170	4	2025-11-29 11:53:39.001	\N	f
1012	170	3	2025-11-29 11:53:39.001	\N	f
1013	170	2	2025-11-29 11:53:39.001	\N	f
1014	170	1	2025-11-29 11:53:39.001	\N	f
1015	171	0	2025-11-29 11:53:43.923	\N	f
1016	171	1	2025-11-29 11:53:44.573	\N	f
1017	171	2	2025-11-29 11:53:44.573	\N	f
1018	171	3	2025-11-29 11:53:44.573	\N	f
1019	171	4	2025-11-29 11:53:44.573	\N	f
1020	171	5	2025-11-29 11:53:44.573	\N	f
1027	173	0	2025-11-29 11:53:56.22	\N	f
1028	173	5	2025-11-29 11:53:56.44	\N	f
1029	173	4	2025-11-29 11:53:56.44	\N	f
1030	173	3	2025-11-29 11:53:56.44	\N	f
1031	173	2	2025-11-29 11:53:56.44	\N	f
1032	173	1	2025-11-29 11:53:56.44	\N	f
1033	174	0	2025-11-29 11:53:55.96	\N	f
1034	174	5	2025-11-29 11:53:57.011	\N	f
1035	174	4	2025-11-29 11:53:57.011	\N	f
1036	174	3	2025-11-29 11:53:57.011	\N	f
1037	174	2	2025-11-29 11:53:57.011	\N	f
1038	174	1	2025-11-29 11:53:57.011	\N	f
577	97	0	2025-11-29 11:50:18.64	2025-11-29 11:53:55.787	t
913	153	0	2025-11-29 11:52:49.15	2025-11-29 11:53:57.906	t
1039	175	0	2025-11-29 11:54:00.658	\N	f
1040	175	1	2025-11-29 11:54:00.84	\N	f
1041	175	2	2025-11-29 11:54:00.84	\N	f
1042	175	3	2025-11-29 11:54:00.84	\N	f
1043	175	4	2025-11-29 11:54:00.84	\N	f
1044	175	5	2025-11-29 11:54:00.84	\N	f
1046	176	5	2025-11-29 11:54:02.14	\N	f
1047	176	4	2025-11-29 11:54:02.14	\N	f
1048	176	3	2025-11-29 11:54:02.14	\N	f
1049	176	2	2025-11-29 11:54:02.14	\N	f
1050	176	1	2025-11-29 11:54:02.14	\N	f
1051	177	0	2025-11-29 11:54:01.392	\N	f
1052	177	1	2025-11-29 11:54:02.525	\N	f
1053	177	2	2025-11-29 11:54:02.525	\N	f
1054	177	3	2025-11-29 11:54:02.525	\N	f
1055	177	4	2025-11-29 11:54:02.525	\N	f
1056	177	5	2025-11-29 11:54:02.525	\N	f
769	129	0	2025-11-29 11:51:45.554	2025-11-29 11:54:05.471	t
1057	178	0	2025-11-29 11:54:05.496	\N	f
1058	178	1	2025-11-29 11:54:06.794	\N	f
1059	178	2	2025-11-29 11:54:06.794	\N	f
1060	178	3	2025-11-29 11:54:06.794	\N	f
1061	178	4	2025-11-29 11:54:06.794	\N	f
1062	178	5	2025-11-29 11:54:06.794	\N	f
1063	179	0	2025-11-29 11:54:10.822	\N	f
1064	179	1	2025-11-29 11:54:10.217	\N	f
1065	179	2	2025-11-29 11:54:10.217	\N	f
1066	179	3	2025-11-29 11:54:10.217	\N	f
1067	179	4	2025-11-29 11:54:10.217	\N	f
1068	179	5	2025-11-29 11:54:10.217	\N	f
1069	180	0	2025-11-29 11:54:12.395	\N	f
1070	180	5	2025-11-29 11:54:13.826	\N	f
1071	180	4	2025-11-29 11:54:13.826	\N	f
1072	180	3	2025-11-29 11:54:13.826	\N	f
1073	180	2	2025-11-29 11:54:13.826	\N	f
1074	180	1	2025-11-29 11:54:13.826	\N	f
775	130	0	2025-11-29 11:51:51.67	2025-11-29 11:54:15.815	t
625	105	0	2025-11-29 11:50:41.342	2025-11-29 11:54:17.367	t
961	162	0	2025-11-29 11:53:23.801	2025-11-29 11:54:25.17	t
1081	182	0	2025-11-29 11:54:25.761	\N	f
985	166	0	2025-11-29 11:53:32.695	2025-11-29 11:58:37.004	t
974	164	1	2025-11-29 11:58:55.477	2025-11-29 12:04:16.541	t
986	166	1	2025-11-29 11:58:55.881	2025-11-29 12:04:18.133	t
987	166	2	2025-11-29 12:04:41.425	2025-11-29 12:05:41.949	t
993	167	1	2025-11-29 11:59:01.495	2025-11-29 12:06:39.309	t
994	167	2	2025-11-29 12:06:44.004	2025-11-29 12:07:09.214	t
1021	172	0	2025-11-29 11:53:48.277	2025-11-29 12:07:25.46	t
1045	176	0	2025-11-29 11:54:01.213	2025-11-29 12:08:06.054	t
1076	181	5	2025-11-29 12:03:34.83	2025-11-29 12:15:00.327	t
988	166	3	2025-11-29 12:05:46.359	2025-11-29 12:24:26.275	t
1077	181	4	2025-11-29 12:15:05.949	2025-11-29 12:24:31.904	t
976	164	3	2025-11-29 12:06:00.289	2025-11-29 12:24:44.152	t
989	166	4	2025-11-29 12:24:34.449	2025-11-29 12:28:06.175	t
1078	181	3	2025-11-29 12:24:46.868	2025-11-29 12:28:14.519	t
990	166	5	2025-11-29 12:28:10.266	2025-11-29 12:28:36.294	t
978	164	5	2025-11-29 12:28:24.968	2025-11-29 12:28:43.827	t
1079	181	2	2025-11-29 12:28:16.675	2025-11-29 12:32:42.359	t
1080	181	1	2025-11-29 12:32:44.912	2025-11-29 12:34:56.808	t
995	167	3	2025-11-29 12:07:11.558	2025-11-29 12:38:49.225	t
996	167	4	2025-11-29 12:38:51.01	2025-11-29 12:41:58.698	t
1024	172	3	2025-11-29 12:38:43.417	2025-11-29 12:55:31.148	t
997	167	5	2025-11-29 12:42:00.268	2025-11-29 13:00:09.519	t
1025	172	2	2025-11-29 12:55:35.339	2025-11-29 13:03:10.861	t
1082	182	5	2025-11-29 11:54:26.209	\N	f
1083	182	4	2025-11-29 11:54:26.209	\N	f
1084	182	3	2025-11-29 11:54:26.209	\N	f
1085	182	2	2025-11-29 11:54:26.209	\N	f
1086	182	1	2025-11-29 11:54:26.209	\N	f
865	145	0	2025-11-29 11:52:33.272	2025-11-29 11:54:31.698	t
1087	183	0	2025-11-29 11:54:31.219	\N	f
1088	183	5	2025-11-29 11:54:31.334	\N	f
1089	183	4	2025-11-29 11:54:31.334	\N	f
1090	183	3	2025-11-29 11:54:31.334	\N	f
1091	183	2	2025-11-29 11:54:31.334	\N	f
1092	183	1	2025-11-29 11:54:31.334	\N	f
1094	184	5	2025-11-29 11:54:32.732	\N	f
1095	184	4	2025-11-29 11:54:32.732	\N	f
1096	184	3	2025-11-29 11:54:32.732	\N	f
1097	184	2	2025-11-29 11:54:32.732	\N	f
1098	184	1	2025-11-29 11:54:32.732	\N	f
1135	191	0	2025-11-29 11:54:55.577	\N	f
1136	191	1	2025-11-29 11:54:59.635	\N	f
1137	191	2	2025-11-29 11:54:59.635	\N	f
1138	191	3	2025-11-29 11:54:59.635	\N	f
1139	191	4	2025-11-29 11:54:59.635	\N	f
1140	191	5	2025-11-29 11:54:59.635	\N	f
1195	201	0	2025-11-29 11:55:30.521	\N	f
1196	201	1	2025-11-29 11:55:30.665	\N	f
1197	201	2	2025-11-29 11:55:30.665	\N	f
1198	201	3	2025-11-29 11:55:30.665	\N	f
1199	201	4	2025-11-29 11:55:30.665	\N	f
1200	201	5	2025-11-29 11:55:30.665	\N	f
3238	543	3	2025-11-29 13:19:53.557	\N	f
1728	290	1	2025-11-29 12:46:07.017	2025-11-29 12:50:45.215	t
1207	203	0	2025-11-29 11:55:33.224	\N	f
1208	203	5	2025-11-29 11:55:33.412	\N	f
1209	203	4	2025-11-29 11:55:33.412	\N	f
1210	203	3	2025-11-29 11:55:33.412	\N	f
1211	203	2	2025-11-29 11:55:33.412	\N	f
1212	203	1	2025-11-29 11:55:33.412	\N	f
1225	206	0	2025-11-29 11:55:41.252	\N	f
1226	206	5	2025-11-29 11:55:42.288	\N	f
1227	206	4	2025-11-29 11:55:42.288	\N	f
1228	206	3	2025-11-29 11:55:42.288	\N	f
1229	206	2	2025-11-29 11:55:42.288	\N	f
1230	206	1	2025-11-29 11:55:42.288	\N	f
1189	200	0	2025-11-29 11:55:27.983	2025-11-29 11:55:59.512	t
1099	185	0	2025-11-29 11:54:19.847	2025-11-29 12:01:26.829	t
1726	290	3	2025-11-29 12:02:28.076	\N	f
1729	291	0	2025-11-29 12:02:32.696	\N	f
1730	291	1	2025-11-29 12:02:32.892	\N	f
1731	291	2	2025-11-29 12:02:32.892	\N	f
1732	291	3	2025-11-29 12:02:32.892	\N	f
1733	291	4	2025-11-29 12:02:32.892	\N	f
1734	291	5	2025-11-29 12:02:32.892	\N	f
1736	292	5	2025-11-29 12:02:38.665	\N	f
1737	292	4	2025-11-29 12:02:38.665	\N	f
1738	292	3	2025-11-29 12:02:38.665	\N	f
1739	292	2	2025-11-29 12:02:38.665	\N	f
1740	292	1	2025-11-29 12:02:38.665	\N	f
1723	290	0	2025-11-29 12:02:27.727	2025-11-29 12:02:53.311	t
1351	227	0	2025-11-29 11:57:15.594	2025-11-29 12:03:25.782	t
1777	299	0	2025-11-29 12:04:01.002	\N	f
1778	299	5	2025-11-29 12:04:01.863	\N	f
1779	299	4	2025-11-29 12:04:01.863	\N	f
1780	299	3	2025-11-29 12:04:01.863	\N	f
1781	299	2	2025-11-29 12:04:01.863	\N	f
1782	299	1	2025-11-29 12:04:01.863	\N	f
1783	300	0	2025-11-29 12:04:03.229	\N	f
1784	300	5	2025-11-29 12:04:03.685	\N	f
1785	300	4	2025-11-29 12:04:03.685	\N	f
1786	300	3	2025-11-29 12:04:03.685	\N	f
1787	300	2	2025-11-29 12:04:03.685	\N	f
1788	300	1	2025-11-29 12:04:03.685	\N	f
1798	302	3	2025-11-29 12:04:21.32	\N	f
1799	302	4	2025-11-29 12:04:21.32	\N	f
1800	302	5	2025-11-29 12:04:21.32	\N	f
1735	292	0	2025-11-29 12:02:38.372	2025-11-29 12:04:25.175	t
1741	293	0	2025-11-29 12:02:43.496	2025-11-29 12:06:32.561	t
1201	202	0	2025-11-29 11:55:31.804	2025-11-29 12:07:15.057	t
1981	333	0	2025-11-29 12:08:12.602	\N	f
1982	333	5	2025-11-29 12:08:12.845	\N	f
1983	333	4	2025-11-29 12:08:12.845	\N	f
1984	333	3	2025-11-29 12:08:12.845	\N	f
1985	333	2	2025-11-29 12:08:12.845	\N	f
1986	333	1	2025-11-29 12:08:12.845	\N	f
1987	334	0	2025-11-29 12:08:20.166	\N	f
1988	334	1	2025-11-29 12:08:20.422	\N	f
1989	334	2	2025-11-29 12:08:20.422	\N	f
1990	334	3	2025-11-29 12:08:20.422	\N	f
1991	334	4	2025-11-29 12:08:20.422	\N	f
1992	334	5	2025-11-29 12:08:20.422	\N	f
1795	302	0	2025-11-29 12:04:20.167	2025-11-29 12:08:50.327	t
516	86	5	2025-11-29 12:06:34.242	2025-11-29 12:08:52.64	t
1279	215	0	2025-11-29 11:56:10.207	2025-11-29 12:08:52.924	t
2008	337	3	2025-11-29 12:08:57.353	\N	f
2009	337	4	2025-11-29 12:08:57.353	\N	f
2010	337	5	2025-11-29 12:08:57.353	\N	f
1801	303	0	2025-11-29 12:04:25.518	2025-11-29 12:08:58.183	t
1753	295	0	2025-11-29 12:03:38.771	2025-11-29 12:09:23.232	t
1725	290	4	2025-11-29 12:09:02.808	2025-11-29 12:11:42.872	t
1093	184	0	2025-11-29 11:54:32.579	2025-11-29 12:12:16.114	t
2011	338	0	2025-11-29 12:08:58.11	2025-11-29 12:12:59.536	t
1100	185	5	2025-11-29 12:01:32.092	2025-11-29 12:13:15.341	t
1796	302	1	2025-11-29 12:08:59.835	2025-11-29 12:18:12.925	t
1101	185	4	2025-11-29 12:13:23.003	2025-11-29 12:19:20.75	t
1743	293	2	2025-11-29 12:16:43.058	2025-11-29 12:20:23.677	t
1797	302	2	2025-11-29 12:18:19.383	2025-11-29 12:20:39.719	t
2012	338	1	2025-11-29 12:13:08.675	2025-11-29 12:23:05.567	t
1754	295	5	2025-11-29 12:09:58.741	2025-11-29 12:23:51.53	t
1190	200	5	2025-11-29 11:56:07.67	2025-11-29 12:24:16.757	t
1744	293	3	2025-11-29 12:20:26.508	2025-11-29 12:25:31.822	t
1191	200	4	2025-11-29 12:24:19.757	2025-11-29 12:27:07.673	t
1755	295	4	2025-11-29 12:23:56.968	2025-11-29 12:28:33.382	t
1756	295	3	2025-11-29 12:28:50.133	2025-11-29 12:28:59.976	t
1192	200	3	2025-11-29 12:27:53.317	2025-11-29 12:29:04.588	t
1757	295	2	2025-11-29 12:29:05.313	2025-11-29 12:29:26.193	t
1758	295	1	2025-11-29 12:29:29.975	2025-11-29 12:29:37.704	t
2013	338	2	2025-11-29 12:23:13.222	2025-11-29 12:31:42.854	t
1193	200	2	2025-11-29 12:29:09.079	2025-11-29 12:32:37.162	t
1204	202	3	2025-11-29 12:30:36.546	2025-11-29 12:32:55.623	t
1102	185	3	2025-11-29 12:19:35.98	2025-11-29 12:32:59.471	t
1194	200	1	2025-11-29 12:32:39.782	2025-11-29 12:33:28.866	t
2014	338	3	2025-11-29 12:31:46.458	2025-11-29 12:35:59.982	t
1103	185	2	2025-11-29 12:33:08.259	2025-11-29 12:40:12.325	t
1104	185	1	2025-11-29 12:40:15.315	2025-11-29 12:40:50.071	t
1206	202	5	2025-11-29 12:34:11.445	2025-11-29 12:39:34.118	t
2015	338	4	2025-11-29 12:36:05.52	2025-11-29 12:49:59.378	t
2016	338	5	2025-11-29 12:50:02.809	2025-11-29 12:59:18.482	t
1106	186	5	2025-11-29 11:54:45.834	\N	f
1107	186	4	2025-11-29 11:54:45.834	\N	f
1108	186	3	2025-11-29 11:54:45.834	\N	f
1109	186	2	2025-11-29 11:54:45.834	\N	f
1110	186	1	2025-11-29 11:54:45.834	\N	f
1111	187	0	2025-11-29 11:54:47.643	\N	f
1112	187	1	2025-11-29 11:54:47.894	\N	f
1113	187	2	2025-11-29 11:54:47.894	\N	f
1114	187	3	2025-11-29 11:54:47.894	\N	f
1115	187	4	2025-11-29 11:54:47.894	\N	f
1116	187	5	2025-11-29 11:54:47.894	\N	f
1117	188	0	2025-11-29 11:54:47.913	\N	f
1118	188	1	2025-11-29 11:54:47.996	\N	f
1119	188	2	2025-11-29 11:54:47.996	\N	f
1120	188	3	2025-11-29 11:54:47.996	\N	f
1121	188	4	2025-11-29 11:54:47.996	\N	f
1122	188	5	2025-11-29 11:54:47.996	\N	f
1125	189	2	2025-11-29 11:54:52.11	\N	f
1126	189	3	2025-11-29 11:54:52.11	\N	f
1127	189	4	2025-11-29 11:54:52.11	\N	f
1128	189	5	2025-11-29 11:54:52.11	\N	f
3239	543	4	2025-11-29 13:19:53.557	\N	f
1142	192	1	2025-11-29 11:55:01.765	\N	f
1143	192	2	2025-11-29 11:55:01.765	\N	f
1144	192	3	2025-11-29 11:55:01.765	\N	f
1145	192	4	2025-11-29 11:55:01.765	\N	f
1146	192	5	2025-11-29 11:55:01.765	\N	f
1147	193	0	2025-11-29 11:55:03.283	\N	f
1148	193	5	2025-11-29 11:55:03.408	\N	f
1149	193	4	2025-11-29 11:55:03.408	\N	f
1150	193	3	2025-11-29 11:55:03.408	\N	f
1151	193	2	2025-11-29 11:55:03.408	\N	f
1152	193	1	2025-11-29 11:55:03.408	\N	f
1183	199	0	2025-11-29 11:55:23.721	2025-11-29 12:01:28.659	t
1154	194	1	2025-11-29 11:55:06.927	\N	f
1155	194	2	2025-11-29 11:55:06.927	\N	f
1156	194	3	2025-11-29 11:55:06.927	\N	f
1157	194	4	2025-11-29 11:55:06.927	\N	f
1158	194	5	2025-11-29 11:55:06.927	\N	f
1159	195	0	2025-11-29 11:55:07.537	\N	f
1160	195	1	2025-11-29 11:55:07.678	\N	f
1161	195	2	2025-11-29 11:55:07.678	\N	f
1162	195	3	2025-11-29 11:55:07.678	\N	f
1163	195	4	2025-11-29 11:55:07.678	\N	f
1164	195	5	2025-11-29 11:55:07.678	\N	f
1165	196	0	2025-11-29 11:55:08.84	\N	f
1166	196	5	2025-11-29 11:55:08.989	\N	f
1167	196	4	2025-11-29 11:55:08.989	\N	f
1168	196	3	2025-11-29 11:55:08.989	\N	f
1169	196	2	2025-11-29 11:55:08.989	\N	f
1170	196	1	2025-11-29 11:55:08.989	\N	f
1171	197	0	2025-11-29 11:55:13.373	\N	f
1172	197	5	2025-11-29 11:55:13.54	\N	f
1173	197	4	2025-11-29 11:55:13.54	\N	f
1174	197	3	2025-11-29 11:55:13.54	\N	f
1175	197	2	2025-11-29 11:55:13.54	\N	f
1176	197	1	2025-11-29 11:55:13.54	\N	f
1177	198	0	2025-11-29 11:55:20.482	\N	f
1178	198	1	2025-11-29 11:55:20.779	\N	f
1179	198	2	2025-11-29 11:55:20.779	\N	f
1180	198	3	2025-11-29 11:55:20.779	\N	f
1181	198	4	2025-11-29 11:55:20.779	\N	f
1182	198	5	2025-11-29 11:55:20.779	\N	f
1252	210	3	2025-11-29 12:13:56.101	2025-11-29 13:30:15.976	t
1253	210	4	2025-11-29 13:30:20.249	2025-11-29 13:32:55.405	t
1213	204	0	2025-11-29 11:55:38.77	\N	f
1214	204	5	2025-11-29 11:55:38.902	\N	f
1215	204	4	2025-11-29 11:55:38.902	\N	f
1216	204	3	2025-11-29 11:55:38.902	\N	f
1217	204	2	2025-11-29 11:55:38.902	\N	f
1218	204	1	2025-11-29 11:55:38.902	\N	f
1219	205	0	2025-11-29 11:55:40.128	\N	f
1220	205	1	2025-11-29 11:55:41.29	\N	f
1221	205	2	2025-11-29 11:55:41.29	\N	f
1222	205	3	2025-11-29 11:55:41.29	\N	f
1223	205	4	2025-11-29 11:55:41.29	\N	f
1224	205	5	2025-11-29 11:55:41.29	\N	f
1231	207	0	2025-11-29 11:55:42.43	\N	f
1232	207	1	2025-11-29 11:55:42.786	\N	f
1233	207	2	2025-11-29 11:55:42.786	\N	f
1234	207	3	2025-11-29 11:55:42.786	\N	f
1235	207	4	2025-11-29 11:55:42.786	\N	f
1236	207	5	2025-11-29 11:55:42.786	\N	f
1237	208	0	2025-11-29 11:55:54.728	\N	f
1238	208	1	2025-11-29 11:55:55.043	\N	f
1239	208	2	2025-11-29 11:55:55.043	\N	f
1240	208	3	2025-11-29 11:55:55.043	\N	f
1241	208	4	2025-11-29 11:55:55.043	\N	f
1242	208	5	2025-11-29 11:55:55.043	\N	f
1244	209	5	2025-11-29 11:55:57.427	\N	f
1245	209	4	2025-11-29 11:55:57.427	\N	f
1246	209	3	2025-11-29 11:55:57.427	\N	f
1247	209	2	2025-11-29 11:55:57.427	\N	f
1248	209	1	2025-11-29 11:55:57.427	\N	f
1243	209	0	2025-11-29 11:54:52.67	2025-11-29 12:00:46.868	t
1261	212	0	2025-11-29 11:56:09.314	\N	f
1262	212	5	2025-11-29 11:56:09.788	\N	f
1263	212	4	2025-11-29 11:56:09.788	\N	f
1264	212	3	2025-11-29 11:56:09.788	\N	f
1265	212	2	2025-11-29 11:56:09.788	\N	f
1266	212	1	2025-11-29 11:56:09.788	\N	f
1267	213	0	2025-11-29 11:56:16.04	\N	f
1268	213	5	2025-11-29 11:56:16.242	\N	f
1269	213	4	2025-11-29 11:56:16.242	\N	f
1270	213	3	2025-11-29 11:56:16.242	\N	f
1271	213	2	2025-11-29 11:56:16.242	\N	f
1272	213	1	2025-11-29 11:56:16.242	\N	f
1273	214	0	2025-11-29 11:56:17.205	\N	f
1274	214	5	2025-11-29 11:56:17.51	\N	f
1275	214	4	2025-11-29 11:56:17.51	\N	f
1276	214	3	2025-11-29 11:56:17.51	\N	f
1277	214	2	2025-11-29 11:56:17.51	\N	f
1129	190	0	2025-11-29 11:54:57.67	2025-11-29 12:03:02.568	t
1255	211	0	2025-11-29 11:56:08.762	2025-11-29 11:59:07.874	t
1141	192	0	2025-11-29 11:55:01.631	2025-11-29 12:03:27.999	t
1254	210	5	2025-11-29 13:33:17.63	2025-11-29 13:47:38.22	t
1250	210	1	2025-11-29 11:58:51.569	2025-11-29 12:12:29.65	t
1123	189	0	2025-11-29 11:54:51.951	2025-11-29 12:12:58.258	t
1251	210	2	2025-11-29 12:12:32.979	2025-11-29 12:13:53.391	t
1256	211	5	2025-11-29 11:59:24.323	2025-11-29 12:15:41.469	t
1130	190	5	2025-11-29 12:03:12.647	2025-11-29 12:24:23.575	t
1186	199	3	2025-11-29 12:26:48.049	2025-11-29 12:32:08.075	t
1131	190	4	2025-11-29 12:24:26.053	2025-11-29 12:39:19.688	t
1132	190	3	2025-11-29 12:39:21.488	2025-11-29 12:42:37.18	t
1133	190	2	2025-11-29 12:42:40.831	2025-11-29 12:42:48.737	t
1187	199	4	2025-11-29 12:32:11.328	2025-11-29 12:42:54.258	t
1188	199	5	2025-11-29 12:43:08.858	2025-11-29 12:54:04.997	t
1258	211	3	2025-11-29 13:20:30.481	2025-11-29 13:58:26.38	t
1260	211	1	2025-11-29 14:14:06.87	2025-11-29 14:17:03.959	t
1124	189	1	2025-11-29 12:13:08.799	2025-11-29 15:18:38.578	t
1278	214	1	2025-11-29 11:56:17.51	\N	f
3240	543	5	2025-11-29 13:19:53.557	\N	f
1390	233	3	2025-11-29 13:35:12.368	2025-11-29 13:38:29.547	t
1281	215	2	2025-11-29 11:56:20.197	\N	f
1282	215	3	2025-11-29 11:56:20.197	\N	f
1283	215	4	2025-11-29 11:56:20.197	\N	f
1284	215	5	2025-11-29 11:56:20.197	\N	f
1291	217	0	2025-11-29 11:56:34.545	\N	f
1292	217	1	2025-11-29 11:56:44.222	\N	f
1293	217	2	2025-11-29 11:56:44.222	\N	f
1294	217	3	2025-11-29 11:56:44.222	\N	f
1295	217	4	2025-11-29 11:56:44.222	\N	f
1296	217	5	2025-11-29 11:56:44.222	\N	f
1297	218	0	2025-11-29 11:56:30.539	\N	f
1298	218	1	2025-11-29 11:56:46.566	\N	f
1299	218	2	2025-11-29 11:56:46.566	\N	f
1300	218	3	2025-11-29 11:56:46.566	\N	f
1301	218	4	2025-11-29 11:56:46.566	\N	f
1302	218	5	2025-11-29 11:56:46.566	\N	f
1315	221	0	2025-11-29 11:56:59.337	\N	f
1316	221	1	2025-11-29 11:56:59.495	\N	f
1317	221	2	2025-11-29 11:56:59.495	\N	f
1318	221	3	2025-11-29 11:56:59.495	\N	f
1319	221	4	2025-11-29 11:56:59.495	\N	f
1320	221	5	2025-11-29 11:56:59.495	\N	f
1321	222	0	2025-11-29 11:57:02.884	\N	f
1322	222	5	2025-11-29 11:57:03.645	\N	f
1323	222	4	2025-11-29 11:57:03.645	\N	f
1324	222	3	2025-11-29 11:57:03.645	\N	f
1325	222	2	2025-11-29 11:57:03.645	\N	f
1326	222	1	2025-11-29 11:57:03.645	\N	f
1328	223	1	2025-11-29 11:57:04.402	\N	f
1329	223	2	2025-11-29 11:57:04.402	\N	f
1330	223	3	2025-11-29 11:57:04.402	\N	f
1331	223	4	2025-11-29 11:57:04.402	\N	f
1332	223	5	2025-11-29 11:57:04.402	\N	f
1376	231	1	2025-11-29 11:57:39.072	\N	f
1377	231	2	2025-11-29 11:57:39.072	\N	f
1378	231	3	2025-11-29 11:57:39.072	\N	f
1379	231	4	2025-11-29 11:57:39.072	\N	f
1380	231	5	2025-11-29 11:57:39.072	\N	f
1381	232	0	2025-11-29 11:57:41.815	\N	f
1382	232	5	2025-11-29 11:57:42.063	\N	f
1383	232	4	2025-11-29 11:57:42.063	\N	f
1384	232	3	2025-11-29 11:57:42.063	\N	f
1385	232	2	2025-11-29 11:57:42.063	\N	f
1386	232	1	2025-11-29 11:57:42.063	\N	f
1391	233	2	2025-11-29 13:38:34.855	2025-11-29 13:50:43.911	t
1393	234	0	2025-11-29 11:57:43.861	\N	f
1394	234	1	2025-11-29 11:57:45.523	\N	f
1395	234	2	2025-11-29 11:57:45.523	\N	f
1396	234	3	2025-11-29 11:57:45.523	\N	f
1397	234	4	2025-11-29 11:57:45.523	\N	f
1398	234	5	2025-11-29 11:57:45.523	\N	f
1399	236	0	2025-11-29 11:58:00.376	\N	f
1400	236	1	2025-11-29 11:58:00.569	\N	f
1401	236	2	2025-11-29 11:58:00.569	\N	f
1402	236	3	2025-11-29 11:58:00.569	\N	f
1403	236	4	2025-11-29 11:58:00.569	\N	f
1404	236	5	2025-11-29 11:58:00.569	\N	f
1392	233	1	2025-11-29 13:50:47.816	2025-11-29 13:52:26.965	t
1411	238	0	2025-11-29 11:58:02.357	\N	f
1412	238	5	2025-11-29 11:58:03.271	\N	f
1413	238	4	2025-11-29 11:58:03.271	\N	f
1414	238	3	2025-11-29 11:58:03.271	\N	f
1415	238	2	2025-11-29 11:58:03.271	\N	f
1416	238	1	2025-11-29 11:58:03.271	\N	f
1807	304	0	2025-11-29 12:04:24.942	\N	f
1808	304	5	2025-11-29 12:04:26.335	\N	f
1809	304	4	2025-11-29 12:04:26.335	\N	f
1810	304	3	2025-11-29 12:04:26.335	\N	f
1811	304	2	2025-11-29 12:04:26.335	\N	f
1812	304	1	2025-11-29 12:04:26.335	\N	f
1814	305	5	2025-11-29 12:04:29.609	\N	f
1815	305	4	2025-11-29 12:04:29.609	\N	f
1816	305	3	2025-11-29 12:04:29.609	\N	f
1817	305	2	2025-11-29 12:04:29.609	\N	f
1818	305	1	2025-11-29 12:04:29.609	\N	f
1819	306	0	2025-11-29 12:04:35.013	\N	f
1820	306	5	2025-11-29 12:04:34.907	\N	f
1821	306	4	2025-11-29 12:04:34.907	\N	f
1822	306	3	2025-11-29 12:04:34.907	\N	f
1823	306	2	2025-11-29 12:04:34.907	\N	f
1824	306	1	2025-11-29 12:04:34.907	\N	f
1825	307	0	2025-11-29 12:04:39.008	\N	f
1826	307	5	2025-11-29 12:04:39.646	\N	f
1827	307	4	2025-11-29 12:04:39.646	\N	f
1828	307	3	2025-11-29 12:04:39.646	\N	f
1829	307	2	2025-11-29 12:04:39.646	\N	f
1830	307	1	2025-11-29 12:04:39.646	\N	f
1831	308	0	2025-11-29 12:04:44.811	\N	f
1832	308	1	2025-11-29 12:04:45.288	\N	f
1833	308	2	2025-11-29 12:04:45.288	\N	f
1834	308	3	2025-11-29 12:04:45.288	\N	f
1835	308	4	2025-11-29 12:04:45.288	\N	f
1836	308	5	2025-11-29 12:04:45.288	\N	f
1375	231	0	2025-11-29 11:57:39.527	2025-11-29 12:04:44.962	t
710	119	5	2025-11-29 11:55:32.634	2025-11-29 12:04:58.155	t
1855	312	0	2025-11-29 12:04:59.873	\N	f
1856	312	1	2025-11-29 12:05:00.041	\N	f
1857	312	2	2025-11-29 12:05:00.041	\N	f
1858	312	3	2025-11-29 12:05:00.041	\N	f
1859	312	4	2025-11-29 12:05:00.041	\N	f
1860	312	5	2025-11-29 12:05:00.041	\N	f
1873	315	0	2025-11-29 12:05:23.469	\N	f
1874	315	1	2025-11-29 12:05:23.651	\N	f
1875	315	2	2025-11-29 12:05:23.651	\N	f
1876	315	3	2025-11-29 12:05:23.651	\N	f
1877	315	4	2025-11-29 12:05:23.651	\N	f
1878	315	5	2025-11-29 12:05:23.651	\N	f
1405	237	0	2025-11-29 11:58:02.652	2025-11-29 12:06:07.118	t
1837	309	0	2025-11-29 12:04:45.099	2025-11-29 12:06:33.644	t
1327	223	0	2025-11-29 11:57:00.581	2025-11-29 12:08:17.764	t
1993	335	0	2025-11-29 12:08:40.859	\N	f
1994	335	1	2025-11-29 12:08:39.88	\N	f
1813	305	0	2025-11-29 12:04:28.387	2025-11-29 12:08:54.33	t
1838	309	1	2025-11-29 12:06:40.187	2025-11-29 12:13:02.056	t
1839	309	2	2025-11-29 12:13:04.971	2025-11-29 12:15:16.116	t
1407	237	2	2025-11-29 12:10:12.986	2025-11-29 12:16:29.522	t
1802	303	1	2025-11-29 12:09:06.424	2025-11-29 12:16:29.777	t
1387	233	0	2025-11-29 11:57:43.318	2025-11-29 12:20:02.407	t
1803	303	2	2025-11-29 12:16:42.826	2025-11-29 12:20:18.118	t
1408	237	3	2025-11-29 12:16:36.451	2025-11-29 12:21:41.758	t
1409	237	4	2025-11-29 12:21:48.344	2025-11-29 12:23:21.391	t
1840	309	3	2025-11-29 12:15:18.908	2025-11-29 12:25:25.314	t
1841	309	4	2025-11-29 12:25:29.278	2025-11-29 12:28:10.979	t
1805	303	4	2025-11-29 12:25:48.154	2025-11-29 12:28:21.818	t
1410	237	5	2025-11-29 12:23:30.08	2025-11-29 12:28:59.354	t
1842	309	5	2025-11-29 12:28:13.805	2025-11-29 12:33:45.12	t
1806	303	5	2025-11-29 12:28:23.744	2025-11-29 12:35:28.325	t
1153	194	0	2025-11-29 11:55:08.015	2025-11-29 11:56:25.474	t
1285	216	0	2025-11-29 11:56:27.257	\N	f
1286	216	5	2025-11-29 11:56:27.793	\N	f
1287	216	4	2025-11-29 11:56:27.793	\N	f
1288	216	3	2025-11-29 11:56:27.793	\N	f
1289	216	2	2025-11-29 11:56:27.793	\N	f
1290	216	1	2025-11-29 11:56:27.793	\N	f
1303	219	0	2025-11-29 11:56:53.854	\N	f
1304	219	1	2025-11-29 11:56:54.174	\N	f
1305	219	2	2025-11-29 11:56:54.174	\N	f
1306	219	3	2025-11-29 11:56:54.174	\N	f
1307	219	4	2025-11-29 11:56:54.174	\N	f
1308	219	5	2025-11-29 11:56:54.174	\N	f
1309	220	0	2025-11-29 11:56:57.531	\N	f
1310	220	5	2025-11-29 11:56:58.062	\N	f
1311	220	4	2025-11-29 11:56:58.062	\N	f
1312	220	3	2025-11-29 11:56:58.062	\N	f
1313	220	2	2025-11-29 11:56:58.062	\N	f
1314	220	1	2025-11-29 11:56:58.062	\N	f
1333	224	0	2025-11-29 11:57:06.704	\N	f
1334	224	1	2025-11-29 11:57:06.949	\N	f
1335	224	2	2025-11-29 11:57:06.949	\N	f
1336	224	3	2025-11-29 11:57:06.949	\N	f
1337	224	4	2025-11-29 11:57:06.949	\N	f
1338	224	5	2025-11-29 11:57:06.949	\N	f
1339	225	0	2025-11-29 11:57:09.031	\N	f
1340	225	1	2025-11-29 11:57:09.853	\N	f
1341	225	2	2025-11-29 11:57:09.853	\N	f
1342	225	3	2025-11-29 11:57:09.853	\N	f
1343	225	4	2025-11-29 11:57:09.853	\N	f
1344	225	5	2025-11-29 11:57:09.853	\N	f
1345	226	0	2025-11-29 11:57:10.757	\N	f
1346	226	5	2025-11-29 11:57:10.928	\N	f
1347	226	4	2025-11-29 11:57:10.928	\N	f
1348	226	3	2025-11-29 11:57:10.928	\N	f
1349	226	2	2025-11-29 11:57:10.928	\N	f
1350	226	1	2025-11-29 11:57:10.928	\N	f
1353	227	4	2025-11-29 11:57:16.443	\N	f
1354	227	3	2025-11-29 11:57:16.443	\N	f
1355	227	2	2025-11-29 11:57:16.443	\N	f
1356	227	1	2025-11-29 11:57:16.443	\N	f
1357	228	0	2025-11-29 11:57:30.667	\N	f
1358	228	5	2025-11-29 11:57:30.63	\N	f
1359	228	4	2025-11-29 11:57:30.63	\N	f
1360	228	3	2025-11-29 11:57:30.63	\N	f
1361	228	2	2025-11-29 11:57:30.63	\N	f
1362	228	1	2025-11-29 11:57:30.63	\N	f
1369	230	0	2025-11-29 11:57:35.938	\N	f
1370	230	5	2025-11-29 11:57:36.428	\N	f
1371	230	4	2025-11-29 11:57:36.428	\N	f
1372	230	3	2025-11-29 11:57:36.428	\N	f
1373	230	2	2025-11-29 11:57:36.428	\N	f
1374	230	1	2025-11-29 11:57:36.428	\N	f
1429	241	0	2025-11-29 11:58:18.319	\N	f
1430	241	1	2025-11-29 11:58:18.49	\N	f
1431	241	2	2025-11-29 11:58:18.49	\N	f
1432	241	3	2025-11-29 11:58:18.49	\N	f
1433	241	4	2025-11-29 11:58:18.49	\N	f
1434	241	5	2025-11-29 11:58:18.49	\N	f
1435	242	0	2025-11-29 11:58:22.302	\N	f
1436	242	5	2025-11-29 11:58:21.753	\N	f
1437	242	4	2025-11-29 11:58:21.753	\N	f
1438	242	3	2025-11-29 11:58:21.753	\N	f
1439	242	2	2025-11-29 11:58:21.753	\N	f
1440	242	1	2025-11-29 11:58:21.753	\N	f
1441	243	0	2025-11-29 11:58:23.364	\N	f
1442	243	1	2025-11-29 11:58:24.031	\N	f
1443	243	2	2025-11-29 11:58:24.031	\N	f
1444	243	3	2025-11-29 11:58:24.031	\N	f
1445	243	4	2025-11-29 11:58:24.031	\N	f
1446	243	5	2025-11-29 11:58:24.031	\N	f
1447	244	0	2025-11-29 11:58:26.066	\N	f
1448	244	5	2025-11-29 11:58:27.627	\N	f
1449	244	4	2025-11-29 11:58:27.627	\N	f
1450	244	3	2025-11-29 11:58:27.627	\N	f
1451	244	2	2025-11-29 11:58:27.627	\N	f
1452	244	1	2025-11-29 11:58:27.627	\N	f
1453	245	0	2025-11-29 11:58:29.083	\N	f
1454	245	1	2025-11-29 11:58:29.401	\N	f
1455	245	2	2025-11-29 11:58:29.401	\N	f
1456	245	3	2025-11-29 11:58:29.401	\N	f
1457	245	4	2025-11-29 11:58:29.401	\N	f
1458	245	5	2025-11-29 11:58:29.401	\N	f
1459	246	0	2025-11-29 11:58:32.978	\N	f
1460	246	5	2025-11-29 11:58:32.421	\N	f
1461	246	4	2025-11-29 11:58:32.421	\N	f
1462	246	3	2025-11-29 11:58:32.421	\N	f
1463	246	2	2025-11-29 11:58:32.421	\N	f
1464	246	1	2025-11-29 11:58:32.421	\N	f
1465	247	0	2025-11-29 11:58:31.739	\N	f
1466	247	1	2025-11-29 11:58:32.675	\N	f
1467	247	2	2025-11-29 11:58:32.675	\N	f
1468	247	3	2025-11-29 11:58:32.675	\N	f
1469	247	4	2025-11-29 11:58:32.675	\N	f
1470	247	5	2025-11-29 11:58:32.675	\N	f
1471	248	0	2025-11-29 12:04:45.686	\N	f
1472	248	5	2025-11-29 11:58:33.82	\N	f
1473	248	4	2025-11-29 11:58:33.82	\N	f
1474	248	3	2025-11-29 11:58:33.82	\N	f
1475	248	2	2025-11-29 11:58:33.82	\N	f
1476	248	1	2025-11-29 11:58:33.82	\N	f
1477	249	0	2025-11-29 11:58:41.784	\N	f
1478	249	5	2025-11-29 11:58:42.321	\N	f
1479	249	4	2025-11-29 11:58:42.321	\N	f
1480	249	3	2025-11-29 11:58:42.321	\N	f
1481	249	2	2025-11-29 11:58:42.321	\N	f
1482	249	1	2025-11-29 11:58:42.321	\N	f
1483	250	0	2025-11-29 11:58:46.395	\N	f
1484	250	1	2025-11-29 11:58:46.499	\N	f
1485	250	2	2025-11-29 11:58:46.499	\N	f
1486	250	3	2025-11-29 11:58:46.499	\N	f
1487	250	4	2025-11-29 11:58:46.499	\N	f
1488	250	5	2025-11-29 11:58:46.499	\N	f
1249	210	0	2025-11-29 11:56:00.077	2025-11-29 11:58:46.534	t
973	164	0	2025-11-29 11:53:29.974	2025-11-29 11:58:46.946	t
1417	239	0	2025-11-29 11:58:12.013	2025-11-29 12:06:01.448	t
1363	229	0	2025-11-29 11:57:32.194	2025-11-29 12:06:41.45	t
1423	240	0	2025-11-29 11:58:13.472	2025-11-29 12:07:18.335	t
1352	227	5	2025-11-29 12:03:28.953	2025-11-29 12:14:05.691	t
1419	239	2	2025-11-29 12:10:03.319	2025-11-29 12:14:44.433	t
1364	229	5	2025-11-29 12:06:47.64	2025-11-29 12:15:36.194	t
1365	229	4	2025-11-29 12:15:44.559	2025-11-29 12:20:36.35	t
1420	239	3	2025-11-29 12:15:07.268	2025-11-29 12:21:51.16	t
1422	239	5	2025-11-29 12:23:24.856	2025-11-29 12:29:51.572	t
1366	229	3	2025-11-29 12:20:40.601	2025-11-29 12:41:39.031	t
1367	229	2	2025-11-29 12:41:44.747	2025-11-29 12:47:40.676	t
1424	240	5	2025-11-29 12:07:38.957	2025-11-29 12:48:25.965	t
1425	240	4	2025-11-29 12:48:29.553	2025-11-29 12:48:49.279	t
1427	240	2	2025-11-29 12:49:02.686	2025-11-29 12:49:09.326	t
1428	240	1	2025-11-29 12:49:11.758	2025-11-29 12:49:18.887	t
1368	229	1	2025-11-29 12:47:43.041	2025-11-29 13:00:13.131	t
1495	252	0	2025-11-29 11:59:01.487	\N	f
1496	252	5	2025-11-29 11:59:02.678	\N	f
1497	252	4	2025-11-29 11:59:02.678	\N	f
1498	252	3	2025-11-29 11:59:02.678	\N	f
1499	252	2	2025-11-29 11:59:02.678	\N	f
1500	252	1	2025-11-29 11:59:02.678	\N	f
866	145	1	2025-11-29 11:54:37.648	2025-11-29 11:59:14.743	t
542	91	1	2025-11-29 11:54:58.595	2025-11-29 11:59:25.829	t
1519	256	0	2025-11-29 11:59:29.167	\N	f
1520	256	1	2025-11-29 11:59:29.126	\N	f
1521	256	2	2025-11-29 11:59:29.126	\N	f
1522	256	3	2025-11-29 11:59:29.126	\N	f
1523	256	4	2025-11-29 11:59:29.126	\N	f
1524	256	5	2025-11-29 11:59:29.126	\N	f
793	133	0	2025-11-29 11:52:01.033	2025-11-29 11:59:30.522	t
1525	257	0	2025-11-29 11:59:31.366	\N	f
1526	257	1	2025-11-29 11:59:31.869	\N	f
1527	257	2	2025-11-29 11:59:31.869	\N	f
1528	257	3	2025-11-29 11:59:31.869	\N	f
1529	257	4	2025-11-29 11:59:31.869	\N	f
1530	257	5	2025-11-29 11:59:31.869	\N	f
1531	258	0	2025-11-29 11:59:32.155	\N	f
1532	258	5	2025-11-29 11:59:32.385	\N	f
1533	258	4	2025-11-29 11:59:32.385	\N	f
1534	258	3	2025-11-29 11:59:32.385	\N	f
1535	258	2	2025-11-29 11:59:32.385	\N	f
1536	258	1	2025-11-29 11:59:32.385	\N	f
1543	260	0	2025-11-29 11:59:51.55	\N	f
1544	260	1	2025-11-29 11:59:52.017	\N	f
1545	260	2	2025-11-29 11:59:52.017	\N	f
1546	260	3	2025-11-29 11:59:52.017	\N	f
1547	260	4	2025-11-29 11:59:52.017	\N	f
1548	260	5	2025-11-29 11:59:52.017	\N	f
1555	262	0	2025-11-29 11:59:58.434	\N	f
1556	262	1	2025-11-29 11:59:59.265	\N	f
1557	262	2	2025-11-29 11:59:59.265	\N	f
1558	262	3	2025-11-29 11:59:59.265	\N	f
1559	262	4	2025-11-29 11:59:59.265	\N	f
1560	262	5	2025-11-29 11:59:59.265	\N	f
1940	326	5	2025-11-29 12:14:39.523	2025-11-29 14:06:24.463	t
1563	263	4	2025-11-29 13:07:01.118	2025-11-29 14:08:59.434	t
1565	263	2	2025-11-29 14:12:26.279	2025-11-29 15:21:55.228	t
1591	268	0	2025-11-29 12:00:10.875	\N	f
1592	268	5	2025-11-29 12:00:10.421	\N	f
1593	268	4	2025-11-29 12:00:10.421	\N	f
1594	268	3	2025-11-29 12:00:10.421	\N	f
1595	268	2	2025-11-29 12:00:10.421	\N	f
1596	268	1	2025-11-29 12:00:10.421	\N	f
1597	269	0	2025-11-29 12:00:09.759	\N	f
1598	269	5	2025-11-29 12:00:10.568	\N	f
1599	269	4	2025-11-29 12:00:10.568	\N	f
1600	269	3	2025-11-29 12:00:10.568	\N	f
1601	269	2	2025-11-29 12:00:10.568	\N	f
1602	269	1	2025-11-29 12:00:10.568	\N	f
1567	264	0	2025-11-29 12:00:04.218	2025-11-29 12:02:21.018	t
1537	259	0	2025-11-29 11:59:44.877	2025-11-29 12:03:08.55	t
1549	261	0	2025-11-29 11:59:54.828	2025-11-29 12:03:54.163	t
1843	310	0	2025-11-29 12:04:48.138	\N	f
1844	310	1	2025-11-29 12:04:48.928	\N	f
1845	310	2	2025-11-29 12:04:48.928	\N	f
1846	310	3	2025-11-29 12:04:48.928	\N	f
1847	310	4	2025-11-29 12:04:48.928	\N	f
1848	310	5	2025-11-29 12:04:48.928	\N	f
1566	263	1	2025-11-29 15:21:58.8	2025-11-29 15:23:12.706	t
902	151	5	2025-11-29 11:55:17.558	2025-11-29 12:04:56.278	t
1861	313	0	2025-11-29 12:05:08.769	\N	f
1862	313	5	2025-11-29 12:05:09.742	\N	f
1863	313	4	2025-11-29 12:05:09.742	\N	f
1864	313	3	2025-11-29 12:05:09.742	\N	f
1865	313	2	2025-11-29 12:05:09.742	\N	f
1866	313	1	2025-11-29 12:05:09.742	\N	f
1868	314	5	2025-11-29 12:05:12.797	\N	f
1869	314	4	2025-11-29 12:05:12.797	\N	f
1870	314	3	2025-11-29 12:05:12.797	\N	f
1871	314	2	2025-11-29 12:05:12.797	\N	f
1872	314	1	2025-11-29 12:05:12.797	\N	f
544	91	3	2025-11-29 12:00:52.246	2025-11-29 12:05:16.503	t
1879	316	0	2025-11-29 12:05:31.397	\N	f
1880	316	5	2025-11-29 12:05:31.556	\N	f
1881	316	4	2025-11-29 12:05:31.556	\N	f
1882	316	3	2025-11-29 12:05:31.556	\N	f
1883	316	2	2025-11-29 12:05:31.556	\N	f
1884	316	1	2025-11-29 12:05:31.556	\N	f
467	78	4	2025-11-29 12:03:54.086	2025-11-29 12:05:37.269	t
1885	317	0	2025-11-29 12:05:49.922	\N	f
1886	317	1	2025-11-29 12:05:51.181	\N	f
1887	317	2	2025-11-29 12:05:51.181	\N	f
1888	317	3	2025-11-29 12:05:51.181	\N	f
1889	317	4	2025-11-29 12:05:51.181	\N	f
1890	317	5	2025-11-29 12:05:51.181	\N	f
1867	314	0	2025-11-29 12:05:12.634	2025-11-29 12:06:14.705	t
1849	311	0	2025-11-29 12:04:52.932	2025-11-29 12:06:21.487	t
1921	323	0	2025-11-29 12:06:42.807	\N	f
1922	323	5	2025-11-29 12:06:43.05	\N	f
1923	323	4	2025-11-29 12:06:43.05	\N	f
1924	323	3	2025-11-29 12:06:43.05	\N	f
1925	323	2	2025-11-29 12:06:43.05	\N	f
1926	323	1	2025-11-29 12:06:43.05	\N	f
1550	261	5	2025-11-29 12:03:57.701	2025-11-29 12:10:08.283	t
1570	264	3	2025-11-29 12:11:38.267	2025-11-29 12:13:40.34	t
1927	324	0	2025-11-29 12:06:46.397	2025-11-29 12:13:43.432	t
1850	311	1	2025-11-29 12:06:24.039	2025-11-29 12:13:58.895	t
1939	326	0	2025-11-29 12:07:04.926	2025-11-29 12:14:37.653	t
1851	311	2	2025-11-29 12:14:03.532	2025-11-29 12:16:30.72	t
1572	264	1	2025-11-29 12:16:32.2	2025-11-29 12:17:34.308	t
1538	259	5	2025-11-29 12:04:00.413	2025-11-29 12:18:52.251	t
1852	311	3	2025-11-29 12:16:33.11	2025-11-29 12:20:19.682	t
1928	324	1	2025-11-29 12:13:49.047	2025-11-29 12:21:36.912	t
1539	259	4	2025-11-29 12:19:01.407	2025-11-29 12:22:59.157	t
1929	324	2	2025-11-29 12:21:42.793	2025-11-29 12:23:51.405	t
1540	259	3	2025-11-29 12:23:05.387	2025-11-29 12:25:20.002	t
1551	261	4	2025-11-29 12:10:10.641	2025-11-29 12:25:54.202	t
1854	311	5	2025-11-29 12:23:13.772	2025-11-29 12:30:42.838	t
1552	261	3	2025-11-29 12:26:12.317	2025-11-29 12:32:34.872	t
1542	259	1	2025-11-29 12:31:52.164	2025-11-29 12:34:01.955	t
1489	251	0	2025-11-29 11:58:54.179	2025-11-29 12:36:27.308	t
1553	261	2	2025-11-29 12:33:12.132	2025-11-29 12:37:04.382	t
1554	261	1	2025-11-29 12:37:16.443	2025-11-29 12:38:44.171	t
1490	251	1	2025-11-29 12:36:45.131	2025-11-29 12:44:20.164	t
1931	324	4	2025-11-29 12:42:18.047	2025-11-29 12:46:45.329	t
1491	251	2	2025-11-29 12:44:28.87	2025-11-29 12:47:54.989	t
1561	263	0	2025-11-29 12:00:04.377	2025-11-29 12:48:55.299	t
1492	251	3	2025-11-29 12:48:00.414	2025-11-29 12:55:59.725	t
1493	251	4	2025-11-29 12:56:03.89	2025-11-29 13:01:54.446	t
1562	263	5	2025-11-29 12:49:04.349	2025-11-29 13:06:56.533	t
1494	251	5	2025-11-29 13:01:59.24	2025-11-29 13:11:18.588	t
991	167	0	2025-11-29 11:53:35.515	2025-11-29 11:58:58.474	t
1501	253	0	2025-11-29 11:59:04.688	\N	f
1502	253	5	2025-11-29 11:59:04.815	\N	f
1503	253	4	2025-11-29 11:59:04.815	\N	f
1504	253	3	2025-11-29 11:59:04.815	\N	f
1505	253	2	2025-11-29 11:59:04.815	\N	f
1506	253	1	2025-11-29 11:59:04.815	\N	f
1508	254	5	2025-11-29 11:59:05.547	\N	f
1509	254	4	2025-11-29 11:59:05.547	\N	f
1510	254	3	2025-11-29 11:59:05.547	\N	f
1511	254	2	2025-11-29 11:59:05.547	\N	f
1512	254	1	2025-11-29 11:59:05.547	\N	f
1513	255	0	2025-11-29 11:59:10.584	\N	f
1514	255	1	2025-11-29 11:59:10.735	\N	f
1515	255	2	2025-11-29 11:59:10.735	\N	f
1516	255	3	2025-11-29 11:59:10.735	\N	f
1517	255	4	2025-11-29 11:59:10.735	\N	f
1518	255	5	2025-11-29 11:59:10.735	\N	f
1573	265	0	2025-11-29 12:00:06.438	\N	f
1574	265	5	2025-11-29 12:00:06.709	\N	f
1575	265	4	2025-11-29 12:00:06.709	\N	f
1576	265	3	2025-11-29 12:00:06.709	\N	f
1577	265	2	2025-11-29 12:00:06.709	\N	f
1578	265	1	2025-11-29 12:00:06.709	\N	f
1585	267	0	2025-11-29 12:00:08.651	\N	f
1586	267	1	2025-11-29 12:00:08.909	\N	f
1587	267	2	2025-11-29 12:00:08.909	\N	f
1588	267	3	2025-11-29 12:00:08.909	\N	f
1589	267	4	2025-11-29 12:00:08.909	\N	f
1590	267	5	2025-11-29 12:00:08.909	\N	f
1603	270	0	2025-11-29 12:00:16.915	\N	f
1604	270	1	2025-11-29 12:00:17.244	\N	f
1605	270	2	2025-11-29 12:00:17.244	\N	f
1606	270	3	2025-11-29 12:00:17.244	\N	f
1607	270	4	2025-11-29 12:00:17.244	\N	f
1608	270	5	2025-11-29 12:00:17.244	\N	f
1609	271	0	2025-11-29 12:00:22.778	\N	f
1610	271	5	2025-11-29 12:00:22.393	\N	f
1611	271	4	2025-11-29 12:00:22.393	\N	f
1612	271	3	2025-11-29 12:00:22.393	\N	f
1613	271	2	2025-11-29 12:00:22.393	\N	f
1614	271	1	2025-11-29 12:00:22.393	\N	f
1615	272	0	2025-11-29 12:00:26.342	\N	f
1616	272	1	2025-11-29 12:00:26.904	\N	f
1617	272	2	2025-11-29 12:00:26.904	\N	f
1618	272	3	2025-11-29 12:00:26.904	\N	f
1619	272	4	2025-11-29 12:00:26.904	\N	f
1620	272	5	2025-11-29 12:00:26.904	\N	f
1621	273	0	2025-11-29 12:00:30	\N	f
1622	273	1	2025-11-29 12:00:30.766	\N	f
1623	273	2	2025-11-29 12:00:30.766	\N	f
1624	273	3	2025-11-29 12:00:30.766	\N	f
1625	273	4	2025-11-29 12:00:30.766	\N	f
1626	273	5	2025-11-29 12:00:30.766	\N	f
1627	274	0	2025-11-29 12:00:32.656	\N	f
1628	274	1	2025-11-29 12:00:34.833	\N	f
1629	274	2	2025-11-29 12:00:34.833	\N	f
1630	274	3	2025-11-29 12:00:34.833	\N	f
1631	274	4	2025-11-29 12:00:34.833	\N	f
1632	274	5	2025-11-29 12:00:34.833	\N	f
1633	275	0	2025-11-29 12:00:57.783	\N	f
1634	275	5	2025-11-29 12:00:57.99	\N	f
1635	275	4	2025-11-29 12:00:57.99	\N	f
1636	275	3	2025-11-29 12:00:57.99	\N	f
1637	275	2	2025-11-29 12:00:57.99	\N	f
1638	275	1	2025-11-29 12:00:57.99	\N	f
1639	276	0	2025-11-29 12:01:01.397	\N	f
1640	276	1	2025-11-29 12:01:01.671	\N	f
1641	276	2	2025-11-29 12:01:01.671	\N	f
1642	276	3	2025-11-29 12:01:01.671	\N	f
1643	276	4	2025-11-29 12:01:01.671	\N	f
1644	276	5	2025-11-29 12:01:01.671	\N	f
1651	278	0	2025-11-29 12:01:11.13	\N	f
1652	278	5	2025-11-29 12:01:13.546	\N	f
1653	278	4	2025-11-29 12:01:13.546	\N	f
1654	278	3	2025-11-29 12:01:13.546	\N	f
1655	278	2	2025-11-29 12:01:13.546	\N	f
1656	278	1	2025-11-29 12:01:13.546	\N	f
1507	254	0	2025-11-29 11:59:05.408	2025-11-29 12:01:35.918	t
1645	277	0	2025-11-29 12:01:03.783	2025-11-29 12:03:29.809	t
975	164	2	2025-11-29 12:04:23.168	2025-11-29 12:05:55.259	t
1891	318	0	2025-11-29 12:06:09.145	\N	f
1892	318	5	2025-11-29 12:06:09.914	\N	f
1893	318	4	2025-11-29 12:06:09.914	\N	f
1894	318	3	2025-11-29 12:06:09.914	\N	f
1895	318	2	2025-11-29 12:06:09.914	\N	f
1896	318	1	2025-11-29 12:06:09.914	\N	f
1897	319	0	2025-11-29 12:06:27.378	\N	f
1898	319	5	2025-11-29 12:06:27.528	\N	f
1899	319	4	2025-11-29 12:06:27.528	\N	f
1900	319	3	2025-11-29 12:06:27.528	\N	f
1901	319	2	2025-11-29 12:06:27.528	\N	f
1902	319	1	2025-11-29 12:06:27.528	\N	f
1584	266	5	2025-11-29 13:24:25.415	2025-11-29 13:52:38.182	t
3243	544	2	2025-11-29 13:35:53.312	2025-11-29 14:03:19.352	t
1909	321	0	2025-11-29 12:06:32.904	\N	f
1910	321	1	2025-11-29 12:06:33.179	\N	f
1911	321	2	2025-11-29 12:06:33.179	\N	f
1912	321	3	2025-11-29 12:06:33.179	\N	f
1913	321	4	2025-11-29 12:06:33.179	\N	f
1914	321	5	2025-11-29 12:06:33.179	\N	f
1920	322	5	2025-11-29 12:06:40.776	\N	f
1933	325	0	2025-11-29 12:06:50.097	\N	f
1934	325	1	2025-11-29 12:06:50.676	\N	f
1935	325	2	2025-11-29 12:06:50.676	\N	f
1936	325	3	2025-11-29 12:06:50.676	\N	f
1937	325	4	2025-11-29 12:06:50.676	\N	f
1938	325	5	2025-11-29 12:06:50.676	\N	f
3244	544	3	2025-11-29 14:03:35.841	2025-11-29 14:07:59.782	t
1958	329	1	2025-11-29 12:07:30.128	\N	f
1959	329	2	2025-11-29 12:07:30.128	\N	f
1960	329	3	2025-11-29 12:07:30.128	\N	f
1961	329	4	2025-11-29 12:07:30.128	\N	f
1962	329	5	2025-11-29 12:07:30.128	\N	f
765	128	2	2025-11-29 12:06:49.3	2025-11-29 12:07:37.534	t
1646	277	5	2025-11-29 12:03:35.431	2025-11-29 12:15:20.544	t
1580	266	1	2025-11-29 12:16:52.411	2025-11-29 12:18:04.143	t
1915	322	0	2025-11-29 12:06:34.617	2025-11-29 12:18:10.452	t
1904	320	1	2025-11-29 12:13:27.702	2025-11-29 12:19:09.785	t
1905	320	2	2025-11-29 12:19:13.932	2025-11-29 12:21:00.909	t
1916	322	1	2025-11-29 12:18:20.441	2025-11-29 12:23:18.384	t
1647	277	4	2025-11-29 12:15:23.183	2025-11-29 12:24:30.514	t
1907	320	4	2025-11-29 12:24:25.11	2025-11-29 12:27:03.62	t
1648	277	3	2025-11-29 12:24:32.4	2025-11-29 12:28:11.997	t
1649	277	2	2025-11-29 12:28:16.192	2025-11-29 12:32:45.067	t
1650	277	1	2025-11-29 12:32:46.86	2025-11-29 12:34:55.506	t
1917	322	2	2025-11-29 12:23:22.364	2025-11-29 12:35:05.044	t
1908	320	5	2025-11-29 12:27:22.946	2025-11-29 12:35:17.295	t
1918	322	3	2025-11-29 12:35:15.143	2025-11-29 12:42:12.682	t
1919	322	4	2025-11-29 12:42:24.442	2025-11-29 12:44:11.271	t
1724	290	5	2025-11-29 12:02:57.435	2025-11-29 12:09:00.831	t
2017	339	0	2025-11-29 12:09:01.53	\N	f
2018	339	5	2025-11-29 12:09:02.121	\N	f
2019	339	4	2025-11-29 12:09:02.121	\N	f
2020	339	3	2025-11-29 12:09:02.121	\N	f
2021	339	2	2025-11-29 12:09:02.121	\N	f
2022	339	1	2025-11-29 12:09:02.121	\N	f
1568	264	5	2025-11-29 12:02:23.933	2025-11-29 12:09:12.813	t
2024	340	5	2025-11-29 12:09:18.232	\N	f
2025	340	4	2025-11-29 12:09:18.232	\N	f
2026	340	3	2025-11-29 12:09:18.232	\N	f
2027	340	2	2025-11-29 12:09:18.232	\N	f
2028	340	1	2025-11-29 12:09:18.232	\N	f
2029	341	0	2025-11-29 12:09:20.554	\N	f
2030	341	1	2025-11-29 12:09:20.267	\N	f
2031	341	2	2025-11-29 12:09:20.267	\N	f
2032	341	3	2025-11-29 12:09:20.267	\N	f
2033	341	4	2025-11-29 12:09:20.267	\N	f
2034	341	5	2025-11-29 12:09:20.267	\N	f
2035	342	0	2025-11-29 12:09:22.335	\N	f
2036	342	1	2025-11-29 12:09:24.01	\N	f
2037	342	2	2025-11-29 12:09:24.01	\N	f
2038	342	3	2025-11-29 12:09:24.01	\N	f
2039	342	4	2025-11-29 12:09:24.01	\N	f
2040	342	5	2025-11-29 12:09:24.01	\N	f
2043	343	4	2025-11-29 12:09:26.247	\N	f
2044	343	3	2025-11-29 12:09:26.247	\N	f
2045	343	2	2025-11-29 12:09:26.247	\N	f
2046	343	1	2025-11-29 12:09:26.247	\N	f
1951	328	0	2025-11-29 12:07:23.187	2025-11-29 12:09:27.668	t
2047	344	0	2025-11-29 12:09:47.672	\N	f
2048	344	1	2025-11-29 12:09:47.844	\N	f
2049	344	2	2025-11-29 12:09:47.844	\N	f
2050	344	3	2025-11-29 12:09:47.844	\N	f
2051	344	4	2025-11-29 12:09:47.844	\N	f
2052	344	5	2025-11-29 12:09:47.844	\N	f
1418	239	1	2025-11-29 12:06:04.239	2025-11-29 12:10:00.343	t
3245	544	4	2025-11-29 14:08:02.824	2025-11-29 14:12:15.51	t
2060	346	1	2025-11-29 13:24:37.315	2025-11-29 17:01:14.187	t
2062	346	3	2025-11-29 12:10:00.805	\N	f
2063	346	4	2025-11-29 12:10:00.805	\N	f
2064	346	5	2025-11-29 12:10:00.805	\N	f
1406	237	1	2025-11-29 12:06:11.075	2025-11-29 12:10:02.398	t
2065	347	0	2025-11-29 12:10:12.267	\N	f
2066	347	1	2025-11-29 12:10:12.496	\N	f
2067	347	2	2025-11-29 12:10:12.496	\N	f
2068	347	3	2025-11-29 12:10:12.496	\N	f
2069	347	4	2025-11-29 12:10:12.496	\N	f
2070	347	5	2025-11-29 12:10:12.496	\N	f
2071	348	0	2025-11-29 12:10:18.144	\N	f
2072	348	1	2025-11-29 12:10:18.806	\N	f
2073	348	2	2025-11-29 12:10:18.806	\N	f
2074	348	3	2025-11-29 12:10:18.806	\N	f
2075	348	4	2025-11-29 12:10:18.806	\N	f
2076	348	5	2025-11-29 12:10:18.806	\N	f
2077	349	0	2025-11-29 12:10:44.257	\N	f
2078	349	1	2025-11-29 12:10:45.082	\N	f
2079	349	2	2025-11-29 12:10:45.082	\N	f
2080	349	3	2025-11-29 12:10:45.082	\N	f
2081	349	4	2025-11-29 12:10:45.082	\N	f
2082	349	5	2025-11-29 12:10:45.082	\N	f
2061	346	2	2025-11-29 17:18:05.018	2025-11-29 17:39:02.92	t
1975	332	0	2025-11-29 12:07:53.845	2025-11-29 12:10:51.161	t
2089	351	0	2025-11-29 12:10:57.685	\N	f
2090	351	1	2025-11-29 12:10:57.851	\N	f
2091	351	2	2025-11-29 12:10:57.851	\N	f
2092	351	3	2025-11-29 12:10:57.851	\N	f
2093	351	4	2025-11-29 12:10:57.851	\N	f
2094	351	5	2025-11-29 12:10:57.851	\N	f
2095	352	0	2025-11-29 12:11:02.14	\N	f
2096	352	1	2025-11-29 12:11:03.269	\N	f
2097	352	2	2025-11-29 12:11:03.269	\N	f
2098	352	3	2025-11-29 12:11:03.269	\N	f
2099	352	4	2025-11-29 12:11:03.269	\N	f
2100	352	5	2025-11-29 12:11:03.269	\N	f
2101	353	0	2025-11-29 12:11:29.123	\N	f
2102	353	5	2025-11-29 12:11:29.432	\N	f
2103	353	4	2025-11-29 12:11:29.432	\N	f
2104	353	3	2025-11-29 12:11:29.432	\N	f
2105	353	2	2025-11-29 12:11:29.432	\N	f
2106	353	1	2025-11-29 12:11:29.432	\N	f
2107	354	0	2025-11-29 12:11:28.394	\N	f
2108	354	1	2025-11-29 12:11:29.813	\N	f
2109	354	2	2025-11-29 12:11:29.813	\N	f
2110	354	3	2025-11-29 12:11:29.813	\N	f
2111	354	4	2025-11-29 12:11:29.813	\N	f
2112	354	5	2025-11-29 12:11:29.813	\N	f
2113	355	0	2025-11-29 12:11:31.585	\N	f
2114	355	5	2025-11-29 12:11:31.739	\N	f
2115	355	4	2025-11-29 12:11:31.739	\N	f
2116	355	3	2025-11-29 12:11:31.739	\N	f
2117	355	2	2025-11-29 12:11:31.739	\N	f
2118	355	1	2025-11-29 12:11:31.739	\N	f
1569	264	4	2025-11-29 12:09:16.648	2025-11-29 12:11:35.242	t
2125	357	0	2025-11-29 12:11:40.987	\N	f
2126	357	5	2025-11-29 12:11:43.157	\N	f
2127	357	4	2025-11-29 12:11:43.157	\N	f
2128	357	3	2025-11-29 12:11:43.157	\N	f
2129	357	2	2025-11-29 12:11:43.157	\N	f
2130	357	1	2025-11-29 12:11:43.157	\N	f
2132	358	1	2025-11-29 12:11:44.091	\N	f
2133	358	2	2025-11-29 12:11:44.091	\N	f
2134	358	3	2025-11-29 12:11:44.091	\N	f
2135	358	4	2025-11-29 12:11:44.091	\N	f
2136	358	5	2025-11-29 12:11:44.091	\N	f
2143	360	0	2025-11-29 12:11:51.339	\N	f
2144	360	1	2025-11-29 12:11:51.638	\N	f
2137	359	0	2025-11-29 12:11:49.184	2025-11-29 12:12:50.723	t
2041	343	0	2025-11-29 12:09:16.815	2025-11-29 12:14:02.744	t
2083	350	0	2025-11-29 12:10:50.787	2025-11-29 12:16:47.111	t
2120	356	1	2025-11-29 12:12:52.156	2025-11-29 12:17:19.843	t
2131	358	0	2025-11-29 12:11:43.874	2025-11-29 12:19:18.601	t
2042	343	5	2025-11-29 12:14:08.292	2025-11-29 12:23:50.012	t
2138	359	5	2025-11-29 12:12:54.655	2025-11-29 12:24:06.541	t
2084	350	5	2025-11-29 12:16:52.253	2025-11-29 12:26:42.47	t
2121	356	2	2025-11-29 12:17:26.985	2025-11-29 12:30:01.665	t
2054	345	5	2025-11-29 12:20:31.856	2025-11-29 12:31:55.864	t
2086	350	3	2025-11-29 12:33:30.478	2025-11-29 12:34:35.818	t
2122	356	3	2025-11-29 12:30:06.789	2025-11-29 12:34:35.553	t
2139	359	4	2025-11-29 12:24:10.658	2025-11-29 12:37:41.863	t
2055	345	4	2025-11-29 12:32:00.36	2025-11-29 12:39:08.937	t
2140	359	3	2025-11-29 12:37:44.482	2025-11-29 12:41:20.02	t
2123	356	4	2025-11-29 12:34:37.764	2025-11-29 12:43:05.126	t
2087	350	2	2025-11-29 12:34:57.41	2025-11-29 12:45:42.594	t
2124	356	5	2025-11-29 12:43:07.271	2025-11-29 12:46:01.14	t
2088	350	1	2025-11-29 12:45:45.441	2025-11-29 12:46:18.91	t
2142	359	1	2025-11-29 12:47:00.803	2025-11-29 12:48:28.179	t
2057	345	2	2025-11-29 12:42:47.279	2025-11-29 12:55:56.091	t
2058	345	1	2025-11-29 12:55:59.211	2025-11-29 12:58:55.713	t
2145	360	2	2025-11-29 12:11:51.638	\N	f
2146	360	3	2025-11-29 12:11:51.638	\N	f
2147	360	4	2025-11-29 12:11:51.638	\N	f
2148	360	5	2025-11-29 12:11:51.638	\N	f
2157	362	2	2025-11-29 12:11:57.231	\N	f
2158	362	3	2025-11-29 12:11:57.231	\N	f
2159	362	4	2025-11-29 12:11:57.231	\N	f
2160	362	5	2025-11-29 12:11:57.231	\N	f
2163	363	2	2025-11-29 12:12:02.486	\N	f
2164	363	3	2025-11-29 12:12:02.486	\N	f
2165	363	4	2025-11-29 12:12:02.486	\N	f
2166	363	5	2025-11-29 12:12:02.486	\N	f
2180	366	5	2025-11-29 12:12:13.652	\N	f
2181	366	4	2025-11-29 12:12:13.652	\N	f
2182	366	3	2025-11-29 12:12:13.652	\N	f
2183	366	2	2025-11-29 12:12:13.652	\N	f
2184	366	1	2025-11-29 12:12:13.652	\N	f
2185	367	0	2025-11-29 12:12:10.064	\N	f
2186	367	1	2025-11-29 12:12:16.894	\N	f
2187	367	2	2025-11-29 12:12:16.894	\N	f
2188	367	3	2025-11-29 12:12:16.894	\N	f
2189	367	4	2025-11-29 12:12:16.894	\N	f
2190	367	5	2025-11-29 12:12:16.894	\N	f
2155	362	0	2025-11-29 12:11:56.989	2025-11-29 12:14:01.959	t
2179	366	0	2025-11-29 12:12:10.136	2025-11-29 12:18:59.986	t
2156	362	1	2025-11-29 12:14:04.996	2025-11-29 12:21:31.989	t
2149	361	0	2025-11-29 12:11:52.412	2025-11-29 12:21:42.116	t
2150	361	5	2025-11-29 12:21:47.762	2025-11-29 12:31:53.012	t
2151	361	4	2025-11-29 12:31:57.581	2025-11-29 12:39:05.332	t
2152	361	3	2025-11-29 12:39:08.899	2025-11-29 12:42:40.948	t
2153	361	2	2025-11-29 12:42:44.195	2025-11-29 12:55:50.599	t
2154	361	1	2025-11-29 12:55:53.852	2025-11-29 12:58:48.694	t
2161	363	0	2025-11-29 12:12:01.79	2025-11-29 13:17:56.109	t
2910	488	5	2025-11-29 13:23:25.148	2025-11-29 13:30:12.732	t
3391	570	0	2025-11-29 13:32:11.382	\N	f
3392	570	1	2025-11-29 13:32:12.097	\N	f
3393	570	2	2025-11-29 13:32:12.097	\N	f
3394	570	3	2025-11-29 13:32:12.097	\N	f
3395	570	4	2025-11-29 13:32:12.097	\N	f
3396	570	5	2025-11-29 13:32:12.097	\N	f
3397	571	0	2025-11-29 13:32:27.884	\N	f
3398	571	1	2025-11-29 13:32:28.083	\N	f
3399	571	2	2025-11-29 13:32:28.083	\N	f
3400	571	3	2025-11-29 13:32:28.083	\N	f
3401	571	4	2025-11-29 13:32:28.083	\N	f
3402	571	5	2025-11-29 13:32:28.083	\N	f
3403	572	0	2025-11-29 13:33:17.038	\N	f
3404	572	5	2025-11-29 13:33:18.267	\N	f
3405	572	4	2025-11-29 13:33:18.267	\N	f
3406	572	3	2025-11-29 13:33:18.267	\N	f
3407	572	2	2025-11-29 13:33:18.267	\N	f
3408	572	1	2025-11-29 13:33:18.267	\N	f
3385	569	0	2025-11-29 13:31:44.433	2025-11-29 13:34:10.604	t
2162	363	1	2025-11-29 13:18:08.558	2025-11-29 13:38:01.426	t
3376	567	3	2025-11-29 13:38:30.57	2025-11-29 13:40:48.636	t
3463	583	0	2025-11-29 13:41:37.98	\N	f
3464	583	1	2025-11-29 13:41:39.635	\N	f
3465	583	2	2025-11-29 13:41:39.635	\N	f
3466	583	3	2025-11-29 13:41:39.635	\N	f
3467	583	4	2025-11-29 13:41:39.635	\N	f
3468	583	5	2025-11-29 13:41:39.635	\N	f
3236	543	1	2025-11-29 13:30:15.741	2025-11-29 13:41:39.701	t
3386	569	5	2025-11-29 13:34:14.915	2025-11-29 13:47:23.513	t
3523	593	0	2025-11-29 13:55:46.556	\N	f
3524	593	5	2025-11-29 13:55:46.741	\N	f
3525	593	4	2025-11-29 13:55:46.741	\N	f
3526	593	3	2025-11-29 13:55:46.741	\N	f
3527	593	2	2025-11-29 13:55:46.741	\N	f
3528	593	1	2025-11-29 13:55:46.741	\N	f
3602	606	1	2025-11-29 14:08:58.187	\N	f
3603	606	2	2025-11-29 14:08:58.187	\N	f
3604	606	3	2025-11-29 14:08:58.187	\N	f
3605	606	4	2025-11-29 14:08:58.187	\N	f
3606	606	5	2025-11-29 14:08:58.187	\N	f
2002	336	3	2025-11-29 14:05:50.854	2025-11-29 14:09:03.711	t
3024	507	1	2025-11-29 14:09:01.767	2025-11-29 14:09:18.925	t
3607	607	0	2025-11-29 14:10:57.698	\N	f
3608	607	5	2025-11-29 14:10:58.194	\N	f
3609	607	4	2025-11-29 14:10:58.194	\N	f
3610	607	3	2025-11-29 14:10:58.194	\N	f
3611	607	2	2025-11-29 14:10:58.194	\N	f
3612	607	1	2025-11-29 14:10:58.194	\N	f
3601	606	0	2025-11-29 14:08:58.945	2025-11-29 14:15:31.67	t
3595	605	0	2025-11-29 14:08:20.577	2025-11-29 14:18:28.674	t
3246	544	5	2025-11-29 14:12:18.463	2025-11-29 14:19:00.375	t
900	150	1	2025-11-29 14:20:16.502	2025-11-29 14:20:37.129	t
3654	615	5	2025-11-29 14:21:33.823	\N	f
3655	616	0	2025-11-29 14:21:33.909	\N	f
3656	616	1	2025-11-29 14:21:34.069	\N	f
3657	616	2	2025-11-29 14:21:34.069	\N	f
3658	616	3	2025-11-29 14:21:34.069	\N	f
3659	616	4	2025-11-29 14:21:34.069	\N	f
3660	616	5	2025-11-29 14:21:34.069	\N	f
3387	569	4	2025-11-29 13:47:27.194	2025-11-29 14:25:03.374	t
3596	605	5	2025-11-29 14:18:35.584	2025-11-29 14:27:04.99	t
3388	569	3	2025-11-29 14:25:06.784	2025-11-29 14:28:00.105	t
3649	615	0	2025-11-29 14:21:32.449	2025-11-29 14:30:31.288	t
3597	605	4	2025-11-29 14:27:13.358	2025-11-29 14:33:56.123	t
3598	605	3	2025-11-29 14:34:04.536	2025-11-29 14:38:03.883	t
3650	615	1	2025-11-29 14:30:47.178	2025-11-29 14:41:35.917	t
3599	605	2	2025-11-29 14:38:09.12	2025-11-29 14:43:08.398	t
3389	569	2	2025-11-29 14:28:03.176	2025-11-29 14:44:25.484	t
3600	605	1	2025-11-29 14:43:13.69	2025-11-29 14:45:48.372	t
3390	569	1	2025-11-29 14:44:28.971	2025-11-29 14:48:28.111	t
3651	615	2	2025-11-29 14:41:43.364	2025-11-29 14:50:29.818	t
3733	630	0	2025-11-29 14:42:32.615	2025-11-29 14:51:24.461	t
3686	621	5	2025-11-29 14:42:02.161	2025-11-29 14:56:31.013	t
3652	615	3	2025-11-29 14:50:42.263	2025-11-29 14:58:05.288	t
3734	630	1	2025-11-29 14:51:31.651	2025-11-29 14:59:06.135	t
3735	630	2	2025-11-29 14:59:09.286	2025-11-29 15:03:33.07	t
3799	641	0	2025-11-29 15:10:28.564	\N	f
3800	641	1	2025-11-29 15:10:50.694	\N	f
3801	641	2	2025-11-29 15:10:50.694	\N	f
3802	641	3	2025-11-29 15:10:50.694	\N	f
3803	641	4	2025-11-29 15:10:50.694	\N	f
3804	641	5	2025-11-29 15:10:50.694	\N	f
3688	621	3	2025-11-29 15:09:02.791	2025-11-29 15:12:12.706	t
3790	639	3	2025-11-29 15:12:01.534	2025-11-29 15:12:20.033	t
3653	615	4	2025-11-29 14:58:09.728	2025-11-29 15:12:31.579	t
3737	630	4	2025-11-29 15:15:00.794	2025-11-29 15:19:50.617	t
3805	642	0	2025-11-29 15:12:51.501	2025-11-29 15:50:45.704	t
3829	646	0	2025-11-29 15:55:20.014	\N	f
3807	642	4	2025-11-29 15:56:31.412	2025-11-29 16:01:09.237	t
3808	642	3	2025-11-29 16:01:13.321	2025-11-29 16:12:36.795	t
3809	642	2	2025-11-29 16:12:39.406	2025-11-29 16:25:30.546	t
3810	642	1	2025-11-29 16:25:33.536	2025-11-29 16:30:35.299	t
2167	364	0	2025-11-29 12:24:09.609	\N	f
2168	364	5	2025-11-29 12:12:02.701	\N	f
2169	364	4	2025-11-29 12:12:02.701	\N	f
2170	364	3	2025-11-29 12:12:02.701	\N	f
2171	364	2	2025-11-29 12:12:02.701	\N	f
2172	364	1	2025-11-29 12:12:02.701	\N	f
2173	365	0	2025-11-29 12:12:04.242	\N	f
2174	365	1	2025-11-29 12:12:03.921	\N	f
2175	365	2	2025-11-29 12:12:03.921	\N	f
2176	365	3	2025-11-29 12:12:03.921	\N	f
2177	365	4	2025-11-29 12:12:03.921	\N	f
2178	365	5	2025-11-29 12:12:03.921	\N	f
2192	368	1	2025-11-29 12:12:30.477	\N	f
2193	368	2	2025-11-29 12:12:30.477	\N	f
2194	368	3	2025-11-29 12:12:30.477	\N	f
2195	368	4	2025-11-29 12:12:30.477	\N	f
2196	368	5	2025-11-29 12:12:30.477	\N	f
795	133	4	2025-11-29 12:07:54.731	2025-11-29 12:12:40.165	t
2203	370	0	2025-11-29 12:12:47.216	\N	f
2204	370	5	2025-11-29 12:12:48.251	\N	f
2205	370	4	2025-11-29 12:12:48.251	\N	f
2206	370	3	2025-11-29 12:12:48.251	\N	f
2207	370	2	2025-11-29 12:12:48.251	\N	f
2208	370	1	2025-11-29 12:12:48.251	\N	f
2119	356	0	2025-11-29 12:11:35.5	2025-11-29 12:12:48.451	t
2209	371	0	2025-11-29 12:13:00.896	\N	f
2210	371	5	2025-11-29 12:13:01.975	\N	f
2211	371	4	2025-11-29 12:13:01.975	\N	f
2212	371	3	2025-11-29 12:13:01.975	\N	f
2213	371	2	2025-11-29 12:13:01.975	\N	f
2214	371	1	2025-11-29 12:13:01.975	\N	f
3247	546	0	2025-11-29 13:19:57.956	\N	f
2221	373	0	2025-11-29 12:13:13.415	\N	f
2222	373	1	2025-11-29 12:13:17.047	\N	f
2223	373	2	2025-11-29 12:13:17.047	\N	f
2224	373	3	2025-11-29 12:13:17.047	\N	f
2225	373	4	2025-11-29 12:13:17.047	\N	f
2226	373	5	2025-11-29 12:13:17.047	\N	f
2227	374	0	2025-11-29 12:13:17.606	\N	f
2228	374	1	2025-11-29 12:13:17.916	\N	f
2229	374	2	2025-11-29 12:13:17.916	\N	f
2230	374	3	2025-11-29 12:13:17.916	\N	f
2231	374	4	2025-11-29 12:13:17.916	\N	f
2232	374	5	2025-11-29 12:13:17.916	\N	f
2233	375	0	2025-11-29 12:13:19.842	\N	f
2234	375	1	2025-11-29 12:13:20.289	\N	f
2235	375	2	2025-11-29 12:13:20.289	\N	f
2236	375	3	2025-11-29 12:13:20.289	\N	f
2237	375	4	2025-11-29 12:13:20.289	\N	f
2238	375	5	2025-11-29 12:13:20.289	\N	f
2239	376	0	2025-11-29 12:13:18.992	\N	f
2240	376	5	2025-11-29 12:13:20.425	\N	f
2241	376	4	2025-11-29 12:13:20.425	\N	f
2242	376	3	2025-11-29 12:13:20.425	\N	f
2243	376	2	2025-11-29 12:13:20.425	\N	f
2244	376	1	2025-11-29 12:13:20.425	\N	f
1903	320	0	2025-11-29 12:06:31.479	2025-11-29 12:13:20.587	t
2245	377	0	2025-11-29 12:13:20.519	\N	f
2246	377	1	2025-11-29 12:13:21.249	\N	f
2247	377	2	2025-11-29 12:13:21.249	\N	f
2248	377	3	2025-11-29 12:13:21.249	\N	f
2249	377	4	2025-11-29 12:13:21.249	\N	f
2250	377	5	2025-11-29 12:13:21.249	\N	f
2251	378	0	2025-11-29 12:13:41.48	\N	f
2252	378	5	2025-11-29 12:13:41.636	\N	f
2253	378	4	2025-11-29 12:13:41.636	\N	f
2254	378	3	2025-11-29 12:13:41.636	\N	f
2255	378	2	2025-11-29 12:13:41.636	\N	f
2256	378	1	2025-11-29 12:13:41.636	\N	f
2257	379	0	2025-11-29 12:13:43.486	\N	f
2258	379	1	2025-11-29 12:13:43.667	\N	f
2259	379	2	2025-11-29 12:13:43.667	\N	f
2260	379	3	2025-11-29 12:13:43.667	\N	f
2261	379	4	2025-11-29 12:13:43.667	\N	f
2262	379	5	2025-11-29 12:13:43.667	\N	f
2197	369	0	2025-11-29 12:12:33.657	2025-11-29 12:13:48.415	t
2023	340	0	2025-11-29 12:09:18.08	2025-11-29 12:13:55.91	t
2263	380	0	2025-11-29 12:14:09.767	\N	f
2264	380	1	2025-11-29 12:14:09.96	\N	f
2265	380	2	2025-11-29 12:14:09.96	\N	f
2266	380	3	2025-11-29 12:14:09.96	\N	f
2267	380	4	2025-11-29 12:14:09.96	\N	f
2268	380	5	2025-11-29 12:14:09.96	\N	f
2269	381	0	2025-11-29 12:14:17.31	\N	f
2270	381	1	2025-11-29 12:14:17.508	\N	f
2271	381	2	2025-11-29 12:14:17.508	\N	f
2272	381	3	2025-11-29 12:14:17.508	\N	f
2273	381	4	2025-11-29 12:14:17.508	\N	f
2274	381	5	2025-11-29 12:14:17.508	\N	f
2275	382	0	2025-11-29 12:14:26.938	\N	f
2276	382	1	2025-11-29 12:14:28.746	\N	f
2277	382	2	2025-11-29 12:14:28.746	\N	f
2278	382	3	2025-11-29 12:14:28.746	\N	f
2279	382	4	2025-11-29 12:14:28.746	\N	f
2280	382	5	2025-11-29 12:14:28.746	\N	f
2281	383	0	2025-11-29 12:14:39.606	\N	f
2282	383	5	2025-11-29 12:14:40.247	\N	f
2283	383	4	2025-11-29 12:14:40.247	\N	f
2284	383	3	2025-11-29 12:14:40.247	\N	f
2285	383	2	2025-11-29 12:14:40.247	\N	f
2286	383	1	2025-11-29 12:14:40.247	\N	f
2293	385	0	2025-11-29 12:14:57.065	\N	f
2294	385	5	2025-11-29 12:14:57.213	\N	f
2295	385	4	2025-11-29 12:14:57.213	\N	f
2296	385	3	2025-11-29 12:14:57.213	\N	f
2297	385	2	2025-11-29 12:14:57.213	\N	f
2298	385	1	2025-11-29 12:14:57.213	\N	f
2305	387	0	2025-11-29 12:15:20.541	\N	f
2306	387	5	2025-11-29 12:15:19.921	\N	f
2307	387	4	2025-11-29 12:15:19.921	\N	f
2308	387	3	2025-11-29 12:15:19.921	\N	f
2309	387	2	2025-11-29 12:15:19.921	\N	f
2191	368	0	2025-11-29 12:12:29.801	2025-11-29 12:17:35.52	t
2287	384	0	2025-11-29 12:14:51.705	2025-11-29 12:17:40.085	t
2198	369	5	2025-11-29 12:14:22.481	2025-11-29 12:22:33.092	t
2215	372	0	2025-11-29 12:13:08.382	2025-11-29 12:23:12.909	t
2288	384	1	2025-11-29 12:17:44.156	2025-11-29 12:24:45.38	t
2301	386	2	2025-11-29 12:22:26.262	2025-11-29 12:25:12.296	t
2216	372	1	2025-11-29 12:23:18.831	2025-11-29 12:27:45.002	t
2199	369	4	2025-11-29 12:22:37.526	2025-11-29 12:28:27.317	t
2290	384	3	2025-11-29 12:27:10.01	2025-11-29 12:30:54.285	t
2200	369	3	2025-11-29 12:28:30.111	2025-11-29 12:31:31.144	t
2291	384	4	2025-11-29 12:30:58.246	2025-11-29 12:33:14.753	t
2201	369	2	2025-11-29 12:31:35.018	2025-11-29 12:38:15.711	t
2218	372	3	2025-11-29 12:34:26.949	2025-11-29 12:38:17.803	t
2202	369	1	2025-11-29 12:38:18.781	2025-11-29 12:40:19.319	t
2219	372	4	2025-11-29 12:38:19.851	2025-11-29 12:40:46.832	t
2302	386	3	2025-11-29 12:28:32.609	2025-11-29 12:42:02.566	t
2220	372	5	2025-11-29 12:40:50.796	2025-11-29 12:51:19.849	t
2303	386	4	2025-11-29 12:42:07.718	2025-11-29 12:54:11.203	t
2304	386	5	2025-11-29 12:54:15.557	2025-11-29 13:11:57.241	t
2310	387	1	2025-11-29 12:15:19.921	\N	f
3248	546	1	2025-11-29 13:20:09.849	\N	f
3249	546	2	2025-11-29 13:20:09.849	\N	f
3250	546	3	2025-11-29 13:20:09.849	\N	f
3251	546	4	2025-11-29 13:20:09.849	\N	f
3252	546	5	2025-11-29 13:20:09.849	\N	f
2508	420	5	2025-11-29 13:08:27.488	2025-11-29 13:20:11.508	t
3253	547	0	2025-11-29 13:20:15.011	\N	f
3254	547	1	2025-11-29 13:20:15.982	\N	f
3255	547	2	2025-11-29 13:20:15.982	\N	f
3256	547	3	2025-11-29 13:20:15.982	\N	f
3257	547	4	2025-11-29 13:20:15.982	\N	f
3258	547	5	2025-11-29 13:20:15.982	\N	f
3007	505	0	2025-11-29 13:11:15.683	2025-11-29 13:30:45.919	t
3045	511	4	2025-11-29 13:25:39.74	2025-11-29 13:30:53.415	t
3469	584	0	2025-11-29 13:42:35.845	\N	f
3470	584	5	2025-11-29 13:42:36.027	\N	f
3471	584	4	2025-11-29 13:42:36.027	\N	f
3472	584	3	2025-11-29 13:42:36.027	\N	f
3473	584	2	2025-11-29 13:42:36.027	\N	f
3474	584	1	2025-11-29 13:42:36.027	\N	f
1749	294	2	2025-11-29 12:44:46.844	2025-11-29 13:42:59.126	t
3529	594	0	2025-11-29 13:56:01.441	\N	f
3530	594	1	2025-11-29 13:56:01.627	\N	f
3531	594	2	2025-11-29 13:56:01.627	\N	f
3532	594	3	2025-11-29 13:56:01.627	\N	f
3533	594	4	2025-11-29 13:56:01.627	\N	f
3534	594	5	2025-11-29 13:56:01.627	\N	f
3541	596	0	2025-11-29 13:58:39.841	\N	f
3542	596	5	2025-11-29 13:58:40.559	\N	f
3543	596	4	2025-11-29 13:58:40.559	\N	f
3544	596	3	2025-11-29 13:58:40.559	\N	f
3545	596	2	2025-11-29 13:58:40.559	\N	f
3546	596	1	2025-11-29 13:58:40.559	\N	f
3547	597	0	2025-11-29 13:58:47.292	\N	f
3548	597	5	2025-11-29 13:58:47.464	\N	f
3549	597	4	2025-11-29 13:58:47.464	\N	f
3550	597	3	2025-11-29 13:58:47.464	\N	f
3551	597	2	2025-11-29 13:58:47.464	\N	f
3552	597	1	2025-11-29 13:58:47.464	\N	f
1564	263	3	2025-11-29 14:09:02.809	2025-11-29 14:12:23.425	t
3614	608	1	2025-11-29 14:14:59.175	\N	f
3615	608	2	2025-11-29 14:14:59.175	\N	f
3616	608	3	2025-11-29 14:14:59.175	\N	f
3617	608	4	2025-11-29 14:14:59.175	\N	f
3618	608	5	2025-11-29 14:14:59.175	\N	f
3620	609	5	2025-11-29 14:14:59.293	\N	f
3621	609	4	2025-11-29 14:14:59.293	\N	f
3622	609	3	2025-11-29 14:14:59.293	\N	f
3623	609	2	2025-11-29 14:14:59.293	\N	f
3624	609	1	2025-11-29 14:14:59.293	\N	f
3613	608	0	2025-11-29 14:14:58.938	2025-11-29 14:19:24.774	t
3619	609	0	2025-11-29 14:14:59.099	2025-11-29 14:19:25.331	t
3661	617	0	2025-11-29 14:22:15.637	\N	f
3662	617	5	2025-11-29 14:22:16.508	\N	f
3663	617	4	2025-11-29 14:22:16.508	\N	f
3664	617	3	2025-11-29 14:22:16.508	\N	f
3665	617	2	2025-11-29 14:22:16.508	\N	f
3666	617	1	2025-11-29 14:22:16.508	\N	f
3673	619	0	2025-11-29 14:23:15.824	\N	f
3674	619	1	2025-11-29 14:23:18.107	\N	f
3675	619	2	2025-11-29 14:23:18.107	\N	f
3676	619	3	2025-11-29 14:23:18.107	\N	f
3677	619	4	2025-11-29 14:23:18.107	\N	f
3678	619	5	2025-11-29 14:23:18.107	\N	f
3739	631	0	2025-11-29 14:44:17.78	\N	f
3740	631	5	2025-11-29 14:44:18.343	\N	f
3741	631	4	2025-11-29 14:44:18.343	\N	f
3742	631	3	2025-11-29 14:44:18.343	\N	f
3743	631	2	2025-11-29 14:44:18.343	\N	f
3744	631	1	2025-11-29 14:44:18.343	\N	f
3745	632	0	2025-11-29 14:44:33.434	2025-11-29 14:55:21.921	t
3763	635	0	2025-11-29 14:58:34.051	\N	f
3766	635	3	2025-11-29 14:58:34.375	\N	f
3767	635	2	2025-11-29 14:58:34.375	\N	f
3768	635	1	2025-11-29 14:58:34.375	\N	f
3769	636	0	2025-11-29 14:58:34.117	\N	f
3770	636	5	2025-11-29 14:58:34.843	\N	f
3771	636	4	2025-11-29 14:58:34.843	\N	f
3772	636	3	2025-11-29 14:58:34.843	\N	f
3773	636	2	2025-11-29 14:58:34.843	\N	f
3774	636	1	2025-11-29 14:58:34.843	\N	f
3746	632	1	2025-11-29 14:55:30.468	2025-11-29 15:02:35.183	t
3747	632	2	2025-11-29 15:02:39.56	2025-11-29 15:02:59.709	t
3736	630	3	2025-11-29 15:03:36.445	2025-11-29 15:14:58.208	t
3823	645	0	2025-11-29 15:16:19.642	\N	f
3824	645	1	2025-11-29 15:16:19.801	\N	f
3825	645	2	2025-11-29 15:16:19.801	\N	f
3826	645	3	2025-11-29 15:16:19.801	\N	f
3827	645	4	2025-11-29 15:16:19.801	\N	f
3828	645	5	2025-11-29 15:16:19.801	\N	f
3811	643	0	2025-11-29 15:14:32.712	2025-11-29 15:18:36.758	t
3764	635	5	2025-11-29 15:05:02.812	2025-11-29 15:19:18.731	t
3765	635	4	2025-11-29 15:19:29.129	2025-11-29 15:25:24.798	t
3812	643	5	2025-11-29 15:18:42.692	2025-11-29 15:26:18.161	t
3748	632	3	2025-11-29 15:03:05.828	2025-11-29 15:29:05.099	t
3813	643	4	2025-11-29 15:26:23.85	2025-11-29 15:32:07.824	t
3749	632	4	2025-11-29 15:29:10.019	2025-11-29 15:32:25.992	t
3814	643	3	2025-11-29 15:32:11.582	2025-11-29 15:34:58.805	t
3750	632	5	2025-11-29 15:32:28.786	2025-11-29 15:44:59.048	t
3830	646	5	2025-11-29 15:55:20.773	\N	f
3831	646	4	2025-11-29 15:55:20.773	\N	f
3832	646	3	2025-11-29 15:55:20.773	\N	f
3833	646	2	2025-11-29 15:55:20.773	\N	f
3834	646	1	2025-11-29 15:55:20.773	\N	f
3806	642	5	2025-11-29 15:50:49.215	2025-11-29 15:56:28.811	t
3815	643	2	2025-11-29 15:35:01.989	2025-11-29 15:58:00.514	t
3816	643	1	2025-11-29 15:58:05.469	2025-11-29 16:00:26.03	t
3847	649	0	2025-11-29 16:42:08.109	\N	f
3848	649	5	2025-11-29 16:42:08.848	\N	f
3849	649	4	2025-11-29 16:42:08.848	\N	f
3850	649	3	2025-11-29 16:42:08.848	\N	f
3851	649	2	2025-11-29 16:42:08.848	\N	f
3852	649	1	2025-11-29 16:42:08.848	\N	f
3840	647	1	2025-11-29 16:51:21.322	2025-11-29 16:51:44.247	t
3855	650	2	2025-11-29 16:50:16.581	2025-11-29 16:52:11.781	t
3871	653	0	2025-11-29 16:51:50.704	2025-11-29 16:52:12.61	t
3883	655	0	2025-11-29 16:56:58.166	\N	f
3884	655	1	2025-11-29 16:56:58.414	\N	f
3877	654	0	2025-11-29 16:56:56.391	2025-11-29 17:00:43.941	t
3873	653	4	2025-11-29 17:00:40.237	2025-11-29 17:03:58.449	t
3875	653	2	2025-11-29 17:05:47.014	2025-11-29 17:10:02.677	t
3876	653	1	2025-11-29 17:10:04.855	2025-11-29 17:11:04.694	t
3878	654	1	2025-11-29 17:00:52.13	2025-11-29 17:11:03.637	t
3879	654	2	2025-11-29 17:11:16.688	2025-11-29 17:17:15.507	t
3880	654	3	2025-11-29 17:17:22.086	2025-11-29 17:50:29.796	t
3882	654	5	2025-11-29 17:54:24.633	2025-11-29 18:17:22.456	t
3870	652	1	2025-11-29 17:59:40.812	2025-11-29 18:18:02.88	t
2311	388	0	2025-11-29 12:15:20.835	\N	f
2312	388	5	2025-11-29 12:15:21.327	\N	f
2313	388	4	2025-11-29 12:15:21.327	\N	f
2314	388	3	2025-11-29 12:15:21.327	\N	f
2315	388	2	2025-11-29 12:15:21.327	\N	f
2316	388	1	2025-11-29 12:15:21.327	\N	f
2345	393	4	2025-11-29 12:16:14.256	\N	f
2346	393	5	2025-11-29 12:16:14.256	\N	f
1767	297	2	2025-11-29 12:14:27.626	2025-11-29 12:16:18.776	t
2371	398	0	2025-11-29 12:17:13.711	\N	f
2372	398	5	2025-11-29 12:17:14.632	\N	f
2373	398	4	2025-11-29 12:17:14.632	\N	f
2374	398	3	2025-11-29 12:17:14.632	\N	f
2375	398	2	2025-11-29 12:17:14.632	\N	f
2376	398	1	2025-11-29 12:17:14.632	\N	f
2341	393	0	2025-11-29 12:16:15.221	2025-11-29 12:19:19.807	t
2335	392	0	2025-11-29 12:16:13.588	2025-11-29 12:21:51.665	t
2336	392	5	2025-11-29 12:21:55.818	2025-11-29 12:27:43.751	t
2342	393	1	2025-11-29 12:19:40.846	2025-11-29 12:31:14.8	t
2337	392	4	2025-11-29 12:27:47.509	2025-11-29 12:37:37.107	t
2338	392	3	2025-11-29 12:37:42.044	2025-11-29 12:42:08.849	t
2339	392	2	2025-11-29 12:42:53.948	2025-11-29 12:50:22.912	t
2340	392	1	2025-11-29 12:50:27.056	2025-11-29 12:53:31.068	t
1257	211	4	2025-11-29 12:15:45.838	2025-11-29 13:20:26.819	t
3289	553	0	2025-11-29 13:22:04.5	\N	f
3290	553	5	2025-11-29 13:22:04.675	\N	f
3291	553	4	2025-11-29 13:22:04.675	\N	f
3292	553	3	2025-11-29 13:22:04.675	\N	f
3293	553	2	2025-11-29 13:22:04.675	\N	f
3294	553	1	2025-11-29 13:22:04.675	\N	f
3295	554	0	2025-11-29 13:22:12.399	\N	f
3296	554	5	2025-11-29 13:22:13.834	\N	f
3297	554	4	2025-11-29 13:22:13.834	\N	f
3298	554	3	2025-11-29 13:22:13.834	\N	f
3299	554	2	2025-11-29 13:22:13.834	\N	f
3300	554	1	2025-11-29 13:22:13.834	\N	f
3307	556	0	2025-11-29 13:22:18.483	\N	f
3308	556	5	2025-11-29 13:22:19.072	\N	f
3309	556	4	2025-11-29 13:22:19.072	\N	f
3310	556	3	2025-11-29 13:22:19.072	\N	f
3311	556	2	2025-11-29 13:22:19.072	\N	f
3312	556	1	2025-11-29 13:22:19.072	\N	f
3259	548	0	2025-11-29 13:20:48.602	2025-11-29 13:28:04.83	t
3409	573	0	2025-11-29 13:34:09.437	\N	f
3410	573	5	2025-11-29 13:34:10.994	\N	f
3411	573	4	2025-11-29 13:34:10.994	\N	f
3412	573	3	2025-11-29 13:34:10.994	\N	f
3413	573	2	2025-11-29 13:34:10.994	\N	f
3414	573	1	2025-11-29 13:34:10.994	\N	f
3260	548	5	2025-11-29 13:28:09.541	2025-11-29 13:34:52.164	t
3261	548	4	2025-11-29 13:34:57.945	2025-11-29 13:39:47.078	t
3262	548	3	2025-11-29 13:39:49.836	2025-11-29 13:42:32.099	t
3237	543	2	2025-11-29 13:41:53.29	2025-11-29 13:45:05.636	t
3140	527	1	2025-11-29 13:35:01.267	2025-11-29 13:46:17.904	t
3475	585	0	2025-11-29 13:45:45.032	2025-11-29 13:46:33.78	t
3487	587	0	2025-11-29 13:46:52.721	\N	f
3488	587	5	2025-11-29 13:46:53.868	\N	f
3489	587	4	2025-11-29 13:46:53.868	\N	f
3490	587	3	2025-11-29 13:46:53.868	\N	f
3491	587	2	2025-11-29 13:46:53.868	\N	f
3492	587	1	2025-11-29 13:46:53.868	\N	f
3499	589	0	2025-11-29 13:48:12.289	2025-11-29 13:49:08.298	t
3493	588	0	2025-11-29 13:47:19.353	2025-11-29 13:49:24.22	t
3476	585	1	2025-11-29 13:46:38.582	2025-11-29 13:55:31.915	t
3536	595	1	2025-11-29 13:57:09.239	\N	f
3537	595	2	2025-11-29 13:57:09.239	\N	f
3538	595	3	2025-11-29 13:57:09.239	\N	f
3539	595	4	2025-11-29 13:57:09.239	\N	f
3540	595	5	2025-11-29 13:57:09.239	\N	f
3452	581	5	2025-11-29 13:47:50.564	2025-11-29 13:59:13.684	t
3500	589	5	2025-11-29 13:50:10.859	2025-11-29 13:59:57.874	t
3494	588	5	2025-11-29 13:50:07.302	2025-11-29 14:00:20.244	t
3477	585	2	2025-11-29 13:55:38.391	2025-11-29 14:00:50.595	t
3535	595	0	2025-11-29 13:57:09.05	2025-11-29 14:01:37.169	t
3478	585	3	2025-11-29 14:00:54.252	2025-11-29 14:06:03.383	t
3479	585	4	2025-11-29 14:06:06.737	2025-11-29 14:08:52.283	t
3501	589	4	2025-11-29 14:00:12.078	2025-11-29 14:12:43.929	t
3495	588	4	2025-11-29 14:12:41.429	2025-11-29 14:12:52.708	t
1259	211	2	2025-11-29 13:58:29.872	2025-11-29 14:14:03.297	t
3496	588	3	2025-11-29 14:12:58.938	2025-11-29 14:16:20.4	t
3480	585	5	2025-11-29 14:08:55.436	2025-11-29 14:16:26.332	t
3502	589	3	2025-11-29 14:13:01.044	2025-11-29 14:16:43	t
3497	588	2	2025-11-29 14:16:30.595	2025-11-29 14:17:00.438	t
3503	589	2	2025-11-29 14:16:49.378	2025-11-29 14:17:12.487	t
3498	588	1	2025-11-29 14:17:19.285	2025-11-29 14:17:31.54	t
3504	589	1	2025-11-29 14:17:16.014	2025-11-29 14:17:42.863	t
2343	393	2	2025-11-29 12:32:19.916	2025-11-29 14:22:07.06	t
3263	548	2	2025-11-29 13:42:36.402	2025-11-29 14:34:38.242	t
3679	620	0	2025-11-29 14:26:28.079	2025-11-29 14:36:06.32	t
3264	548	1	2025-11-29 14:34:43.295	2025-11-29 14:36:43.648	t
2004	336	1	2025-11-29 14:40:52.949	2025-11-29 14:45:40.491	t
2874	482	1	2025-11-29 14:43:12.075	2025-11-29 14:45:42.597	t
3680	620	1	2025-11-29 14:36:26.997	2025-11-29 14:48:41.277	t
3681	620	2	2025-11-29 14:48:48.373	2025-11-29 14:53:13.757	t
2344	393	3	2025-11-29 14:22:13.1	2025-11-29 14:59:01.371	t
3781	638	0	2025-11-29 15:02:27.452	\N	f
3782	638	5	2025-11-29 15:02:34.547	\N	f
3783	638	4	2025-11-29 15:02:34.547	\N	f
3784	638	3	2025-11-29 15:02:34.547	\N	f
3785	638	2	2025-11-29 15:02:34.547	\N	f
3786	638	1	2025-11-29 15:02:34.547	\N	f
3775	637	0	2025-11-29 15:01:41.504	2025-11-29 15:03:16.372	t
3776	637	5	2025-11-29 15:03:20.186	2025-11-29 15:06:43.275	t
3777	637	4	2025-11-29 15:07:03.634	2025-11-29 15:09:14.653	t
3778	637	3	2025-11-29 15:09:16.914	2025-11-29 15:11:52.103	t
3779	637	2	2025-11-29 15:11:54.304	2025-11-29 15:12:02.141	t
3780	637	1	2025-11-29 15:12:03.879	2025-11-29 15:12:38.028	t
3817	644	0	2025-11-29 15:15:46.979	\N	f
3818	644	1	2025-11-29 15:15:47.237	\N	f
3819	644	2	2025-11-29 15:15:47.237	\N	f
3820	644	3	2025-11-29 15:15:47.237	\N	f
3821	644	4	2025-11-29 15:15:47.237	\N	f
3822	644	5	2025-11-29 15:15:47.237	\N	f
3682	620	3	2025-11-29 14:53:16.949	2025-11-29 15:19:58.861	t
3835	647	0	2025-11-29 16:03:43.648	2025-11-29 16:06:23.98	t
3859	651	0	2025-11-29 16:46:34.113	\N	f
3860	651	1	2025-11-29 16:46:37.108	\N	f
3861	651	2	2025-11-29 16:46:37.108	\N	f
3683	620	4	2025-11-29 15:20:02.292	2025-11-29 16:50:05.544	t
3837	647	4	2025-11-29 16:49:03.176	2025-11-29 16:50:36.008	t
3838	647	3	2025-11-29 16:50:45.425	2025-11-29 16:50:58.549	t
3839	647	2	2025-11-29 16:51:03.533	2025-11-29 16:51:16.338	t
3684	620	5	2025-11-29 16:50:08.406	2025-11-29 17:03:03.394	t
2299	386	0	2025-11-29 12:14:56.78	2025-11-29 12:15:34.238	t
2317	389	0	2025-11-29 12:15:37.269	\N	f
2318	389	5	2025-11-29 12:15:37.432	\N	f
2319	389	4	2025-11-29 12:15:37.432	\N	f
2320	389	3	2025-11-29 12:15:37.432	\N	f
2321	389	2	2025-11-29 12:15:37.432	\N	f
2322	389	1	2025-11-29 12:15:37.432	\N	f
2323	390	0	2025-11-29 12:15:52.63	\N	f
2324	390	1	2025-11-29 12:15:53.22	\N	f
2325	390	2	2025-11-29 12:15:53.22	\N	f
2326	390	3	2025-11-29 12:15:53.22	\N	f
2327	390	4	2025-11-29 12:15:53.22	\N	f
2328	390	5	2025-11-29 12:15:53.22	\N	f
1571	264	2	2025-11-29 12:13:43.896	2025-11-29 12:16:30.061	t
1742	293	1	2025-11-29 12:06:42.702	2025-11-29 12:16:35.457	t
2347	394	0	2025-11-29 12:16:40.243	\N	f
2348	394	5	2025-11-29 12:16:40.394	\N	f
2349	394	4	2025-11-29 12:16:40.394	\N	f
2350	394	3	2025-11-29 12:16:40.394	\N	f
2351	394	2	2025-11-29 12:16:40.394	\N	f
2352	394	1	2025-11-29 12:16:40.394	\N	f
2353	395	0	2025-11-29 12:16:43.328	\N	f
2354	395	1	2025-11-29 12:16:43.451	\N	f
2355	395	2	2025-11-29 12:16:43.451	\N	f
2356	395	3	2025-11-29 12:16:43.451	\N	f
2357	395	4	2025-11-29 12:16:43.451	\N	f
2358	395	5	2025-11-29 12:16:43.451	\N	f
1579	266	0	2025-11-29 12:00:07.081	2025-11-29 12:16:48.912	t
2359	396	0	2025-11-29 12:16:51.974	\N	f
2360	396	1	2025-11-29 12:16:52.266	\N	f
2361	396	2	2025-11-29 12:16:52.266	\N	f
2362	396	3	2025-11-29 12:16:52.266	\N	f
2363	396	4	2025-11-29 12:16:52.266	\N	f
2364	396	5	2025-11-29 12:16:52.266	\N	f
774	129	5	2025-11-29 12:13:50.513	2025-11-29 12:16:59.069	t
2329	391	0	2025-11-29 12:15:59.525	2025-11-29 12:17:08.241	t
2367	397	2	2025-11-29 12:17:10.625	\N	f
2368	397	3	2025-11-29 12:17:10.625	\N	f
2369	397	4	2025-11-29 12:17:10.625	\N	f
2370	397	5	2025-11-29 12:17:10.625	\N	f
2377	399	0	2025-11-29 12:17:20.557	\N	f
2378	399	5	2025-11-29 12:17:20.722	\N	f
2379	399	4	2025-11-29 12:17:20.722	\N	f
2380	399	3	2025-11-29 12:17:20.722	\N	f
2381	399	2	2025-11-29 12:17:20.722	\N	f
2382	399	1	2025-11-29 12:17:20.722	\N	f
2383	400	0	2025-11-29 12:17:38.94	\N	f
2384	400	1	2025-11-29 12:17:39.128	\N	f
2385	400	2	2025-11-29 12:17:39.128	\N	f
2386	400	3	2025-11-29 12:17:39.128	\N	f
2387	400	4	2025-11-29 12:17:39.128	\N	f
2388	400	5	2025-11-29 12:17:39.128	\N	f
2389	401	0	2025-11-29 12:17:39.436	\N	f
2390	401	1	2025-11-29 12:17:39.766	\N	f
2391	401	2	2025-11-29 12:17:39.766	\N	f
2392	401	3	2025-11-29 12:17:39.766	\N	f
2393	401	4	2025-11-29 12:17:39.766	\N	f
2394	401	5	2025-11-29 12:17:39.766	\N	f
2330	391	1	2025-11-29 12:17:14.188	2025-11-29 12:17:42.801	t
2395	402	0	2025-11-29 12:17:39.699	\N	f
2396	402	5	2025-11-29 12:17:47.766	\N	f
2397	402	4	2025-11-29 12:17:47.766	\N	f
2398	402	3	2025-11-29 12:17:47.766	\N	f
2399	402	2	2025-11-29 12:17:47.766	\N	f
2400	402	1	2025-11-29 12:17:47.766	\N	f
2401	403	0	2025-11-29 12:17:54.135	\N	f
2402	403	1	2025-11-29 12:17:55.258	\N	f
2403	403	2	2025-11-29 12:17:55.258	\N	f
2404	403	3	2025-11-29 12:17:55.258	\N	f
2405	403	4	2025-11-29 12:17:55.258	\N	f
2406	403	5	2025-11-29 12:17:55.258	\N	f
2407	404	0	2025-11-29 12:17:56.704	\N	f
2408	404	1	2025-11-29 12:17:56.808	\N	f
2409	404	2	2025-11-29 12:17:56.808	\N	f
2410	404	3	2025-11-29 12:17:56.808	\N	f
2411	404	4	2025-11-29 12:17:56.808	\N	f
2412	404	5	2025-11-29 12:17:56.808	\N	f
2413	405	0	2025-11-29 12:18:02.067	\N	f
2414	405	1	2025-11-29 12:18:02.258	\N	f
2415	405	2	2025-11-29 12:18:02.258	\N	f
2416	405	3	2025-11-29 12:18:02.258	\N	f
2417	405	4	2025-11-29 12:18:02.258	\N	f
2418	405	5	2025-11-29 12:18:02.258	\N	f
2420	406	5	2025-11-29 12:18:02.859	\N	f
2421	406	4	2025-11-29 12:18:02.859	\N	f
2422	406	3	2025-11-29 12:18:02.859	\N	f
2423	406	2	2025-11-29 12:18:02.859	\N	f
2424	406	1	2025-11-29 12:18:02.859	\N	f
627	105	4	2025-11-29 12:08:53.022	2025-11-29 12:18:07.205	t
1280	215	1	2025-11-29 12:09:00.799	2025-11-29 12:18:08.003	t
3265	549	0	2025-11-29 13:20:52.23	2025-11-29 13:30:34.207	t
2431	408	0	2025-11-29 12:18:37.05	\N	f
2432	408	1	2025-11-29 12:18:37.19	\N	f
2433	408	2	2025-11-29 12:18:37.19	\N	f
2434	408	3	2025-11-29 12:18:37.19	\N	f
2435	408	4	2025-11-29 12:18:37.19	\N	f
2436	408	5	2025-11-29 12:18:37.19	\N	f
2437	409	0	2025-11-29 12:18:45.649	\N	f
2438	409	1	2025-11-29 12:18:45.771	\N	f
2439	409	2	2025-11-29 12:18:45.771	\N	f
2440	409	3	2025-11-29 12:18:45.771	\N	f
2441	409	4	2025-11-29 12:18:45.771	\N	f
2442	409	5	2025-11-29 12:18:45.771	\N	f
2443	410	0	2025-11-29 12:18:53.47	\N	f
2444	410	1	2025-11-29 12:18:54.605	\N	f
2445	410	2	2025-11-29 12:18:54.605	\N	f
2446	410	3	2025-11-29 12:18:54.605	\N	f
2447	410	4	2025-11-29 12:18:54.605	\N	f
2448	410	5	2025-11-29 12:18:54.605	\N	f
2365	397	0	2025-11-29 12:17:10.467	2025-11-29 12:18:57.979	t
2455	412	0	2025-11-29 12:19:20.025	\N	f
2456	412	5	2025-11-29 12:19:20.232	\N	f
2457	412	4	2025-11-29 12:19:20.232	\N	f
2458	412	3	2025-11-29 12:19:20.232	\N	f
2459	412	2	2025-11-29 12:19:20.232	\N	f
2460	412	1	2025-11-29 12:19:20.232	\N	f
1022	172	5	2025-11-29 12:07:29.756	2025-11-29 12:19:20.424	t
2425	407	0	2025-11-29 12:18:33.193	2025-11-29 12:23:06.392	t
2366	397	1	2025-11-29 12:19:03.712	2025-11-29 12:27:35.743	t
2426	407	1	2025-11-29 12:23:09.339	2025-11-29 12:32:07.453	t
2427	407	2	2025-11-29 12:32:11.311	2025-11-29 12:32:19.064	t
2450	411	1	2025-11-29 12:29:38.936	2025-11-29 12:34:19.366	t
2451	411	2	2025-11-29 12:34:23.013	2025-11-29 12:36:45.925	t
2428	407	3	2025-11-29 12:32:21.34	2025-11-29 12:39:54.176	t
2430	407	5	2025-11-29 12:44:04.106	2025-11-29 12:51:23.99	t
2332	391	3	2025-11-29 12:22:05.765	2025-11-29 12:56:43.51	t
2333	391	4	2025-11-29 12:56:56.842	2025-11-29 12:57:04.433	t
2334	391	5	2025-11-29 12:57:09.539	2025-11-29 12:58:18.077	t
2453	411	4	2025-11-29 12:59:30.183	2025-11-29 13:03:12.997	t
2419	406	0	2025-11-29 12:18:02.606	2025-11-29 13:04:37.483	t
496	83	3	2025-11-29 12:09:24.252	2025-11-29 12:19:23.77	t
2053	345	0	2025-11-29 12:10:00.467	2025-11-29 12:20:24.879	t
2485	417	0	2025-11-29 12:20:37.261	\N	f
2486	417	1	2025-11-29 12:20:37.44	\N	f
2487	417	2	2025-11-29 12:20:37.44	\N	f
2488	417	3	2025-11-29 12:20:37.44	\N	f
2489	417	4	2025-11-29 12:20:37.44	\N	f
2490	417	5	2025-11-29 12:20:37.44	\N	f
2461	413	0	2025-11-29 12:19:22.562	2025-11-29 12:22:49.056	t
2462	413	5	2025-11-29 12:22:55.068	2025-11-29 12:39:38.432	t
2463	413	4	2025-11-29 12:39:45.754	2025-11-29 12:42:32.695	t
2464	413	3	2025-11-29 12:42:40.906	2025-11-29 12:44:04.049	t
2465	413	2	2025-11-29 12:44:12.04	2025-11-29 12:54:24.752	t
2466	413	1	2025-11-29 12:54:31.486	2025-11-29 12:56:22.027	t
3266	549	1	2025-11-29 13:20:52.582	\N	f
3267	549	2	2025-11-29 13:20:52.582	\N	f
3268	549	3	2025-11-29 13:20:52.582	\N	f
3269	549	4	2025-11-29 13:20:52.582	\N	f
3270	549	5	2025-11-29 13:20:52.582	\N	f
3271	550	0	2025-11-29 13:21:17.189	\N	f
3272	550	5	2025-11-29 13:21:17.016	\N	f
3273	550	4	2025-11-29 13:21:17.016	\N	f
3274	550	3	2025-11-29 13:21:17.016	\N	f
3275	550	2	2025-11-29 13:21:17.016	\N	f
3276	550	1	2025-11-29 13:21:17.016	\N	f
3277	551	0	2025-11-29 13:21:24.824	\N	f
3278	551	1	2025-11-29 13:21:25.412	\N	f
3279	551	2	2025-11-29 13:21:25.412	\N	f
3280	551	3	2025-11-29 13:21:25.412	\N	f
3281	551	4	2025-11-29 13:21:25.412	\N	f
3282	551	5	2025-11-29 13:21:25.412	\N	f
3283	552	0	2025-11-29 13:21:33.717	\N	f
3284	552	5	2025-11-29 13:21:33.853	\N	f
3285	552	4	2025-11-29 13:21:33.853	\N	f
3286	552	3	2025-11-29 13:21:33.853	\N	f
3287	552	2	2025-11-29 13:21:33.853	\N	f
3288	552	1	2025-11-29 13:21:33.853	\N	f
1582	266	3	2025-11-29 13:17:35.373	2025-11-29 13:21:42.371	t
2802	470	5	2025-11-29 13:11:35.407	2025-11-29 13:21:59.437	t
3301	555	0	2025-11-29 13:22:17.092	\N	f
3302	555	5	2025-11-29 13:22:17.926	\N	f
3303	555	4	2025-11-29 13:22:17.926	\N	f
3304	555	3	2025-11-29 13:22:17.926	\N	f
3305	555	2	2025-11-29 13:22:17.926	\N	f
3306	555	1	2025-11-29 13:22:17.926	\N	f
896	150	5	2025-11-29 11:55:13.427	2025-11-29 13:22:30.9	t
2989	502	0	2025-11-29 13:10:57.14	2025-11-29 13:22:53.579	t
3319	558	0	2025-11-29 13:23:01.048	\N	f
3320	558	1	2025-11-29 13:23:01.862	\N	f
3321	558	2	2025-11-29 13:23:01.862	\N	f
3322	558	3	2025-11-29 13:23:01.862	\N	f
3323	558	4	2025-11-29 13:23:01.862	\N	f
3324	558	5	2025-11-29 13:23:01.862	\N	f
2059	346	0	2025-11-29 12:10:00.637	2025-11-29 13:23:44.626	t
3331	560	0	2025-11-29 13:23:45.823	\N	f
3332	560	1	2025-11-29 13:23:45.593	\N	f
3333	560	2	2025-11-29 13:23:45.593	\N	f
3334	560	3	2025-11-29 13:23:45.593	\N	f
3335	560	4	2025-11-29 13:23:45.593	\N	f
3336	560	5	2025-11-29 13:23:45.593	\N	f
3337	561	0	2025-11-29 13:24:02.183	\N	f
3338	561	5	2025-11-29 13:24:02.299	\N	f
3339	561	4	2025-11-29 13:24:02.299	\N	f
3340	561	3	2025-11-29 13:24:02.299	\N	f
3341	561	2	2025-11-29 13:24:02.299	\N	f
3342	561	1	2025-11-29 13:24:02.299	\N	f
1583	266	4	2025-11-29 13:21:46.93	2025-11-29 13:24:16.464	t
3241	544	0	2025-11-29 13:19:38.53	2025-11-29 13:24:31.054	t
3313	557	0	2025-11-29 13:22:55.575	2025-11-29 13:33:18.996	t
3314	557	5	2025-11-29 13:33:24.616	2025-11-29 13:40:44.843	t
3415	574	0	2025-11-29 13:34:27.441	2025-11-29 13:43:23.787	t
2836	476	3	2025-11-29 13:30:43.907	2025-11-29 13:43:34.857	t
3481	586	0	2025-11-29 13:46:05.78	\N	f
3482	586	5	2025-11-29 13:46:05.94	\N	f
3483	586	4	2025-11-29 13:46:05.94	\N	f
3484	586	3	2025-11-29 13:46:05.94	\N	f
3485	586	2	2025-11-29 13:46:05.94	\N	f
3486	586	1	2025-11-29 13:46:05.94	\N	f
3315	557	4	2025-11-29 13:40:47.505	2025-11-29 13:49:14.304	t
3316	557	3	2025-11-29 13:49:22.137	2025-11-29 13:52:52.362	t
3559	599	0	2025-11-29 14:00:33.358	\N	f
3560	599	5	2025-11-29 14:00:33.658	\N	f
3561	599	4	2025-11-29 14:00:33.658	\N	f
3562	599	3	2025-11-29 14:00:33.658	\N	f
3563	599	2	2025-11-29 14:00:33.658	\N	f
3564	599	1	2025-11-29 14:00:33.658	\N	f
3416	574	5	2025-11-29 13:43:27.323	2025-11-29 14:01:15.739	t
2820	473	5	2025-11-29 13:53:35.773	2025-11-29 14:01:24.455	t
3553	598	0	2025-11-29 14:00:27.382	2025-11-29 14:04:15.216	t
3583	603	0	2025-11-29 14:04:26.754	\N	f
3584	603	1	2025-11-29 14:04:26.893	\N	f
3585	603	2	2025-11-29 14:04:26.893	\N	f
3586	603	3	2025-11-29 14:04:26.893	\N	f
3587	603	4	2025-11-29 14:04:26.893	\N	f
3588	603	5	2025-11-29 14:04:26.893	\N	f
3317	557	2	2025-11-29 13:52:57.213	2025-11-29 14:12:14.356	t
3554	598	5	2025-11-29 14:04:18.441	2025-11-29 14:14:21.667	t
3318	557	1	2025-11-29 14:12:18.325	2025-11-29 14:16:18.835	t
3455	581	2	2025-11-29 14:12:11.767	2025-11-29 14:17:02.392	t
3417	574	4	2025-11-29 14:01:18.607	2025-11-29 14:21:09.421	t
3555	598	4	2025-11-29 14:14:24.557	2025-11-29 14:24:41.869	t
3418	574	3	2025-11-29 14:21:12.738	2025-11-29 14:26:41.366	t
3556	598	3	2025-11-29 14:24:44.124	2025-11-29 14:27:17.47	t
3691	622	0	2025-11-29 14:29:54.699	\N	f
3692	622	5	2025-11-29 14:29:54.602	\N	f
3693	622	4	2025-11-29 14:29:54.602	\N	f
3694	622	3	2025-11-29 14:29:54.602	\N	f
3695	622	2	2025-11-29 14:29:54.602	\N	f
3696	622	1	2025-11-29 14:29:54.602	\N	f
3697	623	0	2025-11-29 14:29:56.607	2025-11-29 14:31:01.899	t
3419	574	2	2025-11-29 14:26:45.052	2025-11-29 14:33:04.576	t
3557	598	2	2025-11-29 14:27:19.93	2025-11-29 14:33:09.644	t
3420	574	1	2025-11-29 14:33:06.639	2025-11-29 14:33:22.509	t
3558	598	1	2025-11-29 14:33:13.45	2025-11-29 14:33:30.901	t
3698	623	1	2025-11-29 14:31:04.441	2025-11-29 14:35:59.835	t
3699	623	2	2025-11-29 14:36:01.735	2025-11-29 14:41:07.244	t
3685	621	0	2025-11-29 14:28:21.545	2025-11-29 14:41:59.077	t
3700	623	3	2025-11-29 14:41:09.11	2025-11-29 14:42:18.447	t
3701	623	4	2025-11-29 14:42:20.176	2025-11-29 14:42:39.477	t
3702	623	5	2025-11-29 14:42:41.556	2025-11-29 14:43:00.381	t
3751	633	0	2025-11-29 14:51:14.8	\N	f
3752	633	5	2025-11-29 14:51:14.959	\N	f
3753	633	4	2025-11-29 14:51:14.959	\N	f
3687	621	4	2025-11-29 14:56:44.29	2025-11-29 15:09:00.185	t
3689	621	2	2025-11-29 15:12:15.074	2025-11-29 15:16:22.883	t
3690	621	1	2025-11-29 15:16:25.338	2025-11-29 15:17:55.357	t
2467	414	0	2025-11-29 12:19:27.289	\N	f
2468	414	1	2025-11-29 12:19:27.679	\N	f
2469	414	2	2025-11-29 12:19:27.679	\N	f
2470	414	3	2025-11-29 12:19:27.679	\N	f
2471	414	4	2025-11-29 12:19:27.679	\N	f
2472	414	5	2025-11-29 12:19:27.679	\N	f
2473	415	0	2025-11-29 12:19:37.915	\N	f
2474	415	5	2025-11-29 12:19:38.033	\N	f
2475	415	4	2025-11-29 12:19:38.033	\N	f
2476	415	3	2025-11-29 12:19:38.033	\N	f
2477	415	2	2025-11-29 12:19:38.033	\N	f
2478	415	1	2025-11-29 12:19:38.033	\N	f
2479	416	0	2025-11-29 12:20:01.196	\N	f
2480	416	1	2025-11-29 12:20:02.953	\N	f
2481	416	2	2025-11-29 12:20:02.953	\N	f
2482	416	3	2025-11-29 12:20:02.953	\N	f
2483	416	4	2025-11-29 12:20:02.953	\N	f
2484	416	5	2025-11-29 12:20:02.953	\N	f
2491	418	0	2025-11-29 12:20:54.877	\N	f
2492	418	1	2025-11-29 12:20:55.31	\N	f
2493	418	2	2025-11-29 12:20:55.31	\N	f
2494	418	3	2025-11-29 12:20:55.31	\N	f
2495	418	4	2025-11-29 12:20:55.31	\N	f
2496	418	5	2025-11-29 12:20:55.31	\N	f
2500	419	3	2025-11-29 13:17:16.699	2025-11-29 13:20:32.343	t
2501	419	2	2025-11-29 12:21:11.646	\N	f
2502	419	1	2025-11-29 12:21:11.646	\N	f
2509	421	0	2025-11-29 12:21:21.106	\N	f
2510	421	5	2025-11-29 12:21:21.26	\N	f
2511	421	4	2025-11-29 12:21:21.26	\N	f
2512	421	3	2025-11-29 12:21:21.26	\N	f
2513	421	2	2025-11-29 12:21:21.26	\N	f
2514	421	1	2025-11-29 12:21:21.26	\N	f
2515	422	0	2025-11-29 12:21:31.497	\N	f
2516	422	1	2025-11-29 12:21:32.524	\N	f
2517	422	2	2025-11-29 12:21:32.524	\N	f
2518	422	3	2025-11-29 12:21:32.524	\N	f
2519	422	4	2025-11-29 12:21:32.524	\N	f
2520	422	5	2025-11-29 12:21:32.524	\N	f
2521	423	0	2025-11-29 12:21:35.112	\N	f
2522	423	1	2025-11-29 12:21:35.247	\N	f
2523	423	2	2025-11-29 12:21:35.247	\N	f
2524	423	3	2025-11-29 12:21:35.247	\N	f
2525	423	4	2025-11-29 12:21:35.247	\N	f
2526	423	5	2025-11-29 12:21:35.247	\N	f
915	153	4	2025-11-29 12:13:32.634	2025-11-29 12:21:49.883	t
2331	391	2	2025-11-29 12:18:21.739	2025-11-29 12:22:00.678	t
2527	424	0	2025-11-29 12:22:06.409	\N	f
2528	424	5	2025-11-29 12:22:06.592	\N	f
2529	424	4	2025-11-29 12:22:06.592	\N	f
2530	424	3	2025-11-29 12:22:06.592	\N	f
2531	424	2	2025-11-29 12:22:06.592	\N	f
2532	424	1	2025-11-29 12:22:06.592	\N	f
2533	425	0	2025-11-29 12:22:11.318	\N	f
2534	425	1	2025-11-29 12:22:10.619	\N	f
2535	425	2	2025-11-29 12:22:10.619	\N	f
2536	425	3	2025-11-29 12:22:10.619	\N	f
2537	425	4	2025-11-29 12:22:10.619	\N	f
2538	425	5	2025-11-29 12:22:10.619	\N	f
2300	386	1	2025-11-29 12:15:41.587	2025-11-29 12:22:21.369	t
2539	426	0	2025-11-29 12:22:43.4	\N	f
2540	426	1	2025-11-29 12:22:41.852	\N	f
2541	426	2	2025-11-29 12:22:41.852	\N	f
2542	426	3	2025-11-29 12:22:41.852	\N	f
2543	426	4	2025-11-29 12:22:41.852	\N	f
2544	426	5	2025-11-29 12:22:41.852	\N	f
2545	427	0	2025-11-29 12:22:51.984	\N	f
2546	427	1	2025-11-29 12:22:52.163	\N	f
2547	427	2	2025-11-29 12:22:52.163	\N	f
2548	427	3	2025-11-29 12:22:52.163	\N	f
2549	427	4	2025-11-29 12:22:52.163	\N	f
2550	427	5	2025-11-29 12:22:52.163	\N	f
2551	428	0	2025-11-29 12:23:01.192	\N	f
2552	428	5	2025-11-29 12:23:01.397	\N	f
2553	428	4	2025-11-29 12:23:01.397	\N	f
2554	428	3	2025-11-29 12:23:01.397	\N	f
2555	428	2	2025-11-29 12:23:01.397	\N	f
2556	428	1	2025-11-29 12:23:01.397	\N	f
1853	311	4	2025-11-29 12:20:22.88	2025-11-29 12:23:03.096	t
1202	202	1	2025-11-29 12:07:23.316	2025-11-29 12:23:20.243	t
1421	239	4	2025-11-29 12:21:53.517	2025-11-29 12:23:23.012	t
2565	430	4	2025-11-29 12:53:06.885	2025-11-29 13:38:33.849	t
2566	430	3	2025-11-29 13:38:37.269	2025-11-29 15:52:46.172	t
2570	431	5	2025-11-29 12:23:58.918	\N	f
2571	431	4	2025-11-29 12:23:58.918	\N	f
2572	431	3	2025-11-29 12:23:58.918	\N	f
2573	431	2	2025-11-29 12:23:58.918	\N	f
2574	431	1	2025-11-29 12:23:58.918	\N	f
2575	432	0	2025-11-29 12:24:13.213	\N	f
2576	432	5	2025-11-29 12:24:13.378	\N	f
2577	432	4	2025-11-29 12:24:13.378	\N	f
2578	432	3	2025-11-29 12:24:13.378	\N	f
2579	432	2	2025-11-29 12:24:13.378	\N	f
2580	432	1	2025-11-29 12:24:13.378	\N	f
1906	320	3	2025-11-29 12:21:04.864	2025-11-29 12:24:22.204	t
2581	433	0	2025-11-29 12:24:27.769	\N	f
2582	433	1	2025-11-29 12:24:27.935	\N	f
2583	433	2	2025-11-29 12:24:27.935	\N	f
2584	433	3	2025-11-29 12:24:27.935	\N	f
2585	433	4	2025-11-29 12:24:27.935	\N	f
2586	433	5	2025-11-29 12:24:27.935	\N	f
2587	434	0	2025-11-29 12:24:29.181	\N	f
2588	434	1	2025-11-29 12:24:31.322	\N	f
2589	434	2	2025-11-29 12:24:31.322	\N	f
2590	434	3	2025-11-29 12:24:31.322	\N	f
2591	434	4	2025-11-29 12:24:31.322	\N	f
2592	434	5	2025-11-29 12:24:31.322	\N	f
729	122	4	2025-11-29 12:17:16.225	2025-11-29 12:24:31.124	t
2503	420	0	2025-11-29 12:21:19.858	2025-11-29 12:24:41.473	t
534	89	1	2025-11-29 12:24:13.501	2025-11-29 12:24:41.36	t
2593	435	0	2025-11-29 12:24:46.678	\N	f
2594	435	5	2025-11-29 12:24:46.763	\N	f
2595	435	4	2025-11-29 12:24:46.763	\N	f
2596	435	3	2025-11-29 12:24:46.763	\N	f
2597	435	2	2025-11-29 12:24:46.763	\N	f
2563	430	0	2025-11-29 12:23:37.61	2025-11-29 12:27:59.237	t
2569	431	0	2025-11-29 12:23:58.728	2025-11-29 12:30:14.083	t
2497	419	0	2025-11-29 12:21:10.488	2025-11-29 12:37:52.915	t
2504	420	1	2025-11-29 12:24:54.93	2025-11-29 12:44:51.995	t
2559	429	2	2025-11-29 12:40:02.492	2025-11-29 12:48:30.62	t
2505	420	2	2025-11-29 12:44:55.439	2025-11-29 12:51:47.679	t
2564	430	5	2025-11-29 12:28:03.764	2025-11-29 12:53:03.714	t
2560	429	3	2025-11-29 12:48:32.934	2025-11-29 12:56:05.881	t
2506	420	3	2025-11-29 12:51:50.459	2025-11-29 13:04:18.914	t
2561	429	4	2025-11-29 12:56:08.448	2025-11-29 13:07:23.937	t
2507	420	4	2025-11-29 13:04:21.717	2025-11-29 13:08:23.916	t
2562	429	5	2025-11-29 13:07:43.558	2025-11-29 13:13:08.575	t
2499	419	4	2025-11-29 13:01:47.427	2025-11-29 13:17:02.52	t
2567	430	2	2025-11-29 15:52:48.422	2025-11-29 15:57:24.999	t
2568	430	1	2025-11-29 15:57:27.328	2025-11-29 15:59:41.724	t
2598	435	1	2025-11-29 12:24:46.763	\N	f
2599	436	0	2025-11-29 12:25:25.083	\N	f
2600	436	1	2025-11-29 12:25:25.25	\N	f
2601	436	2	2025-11-29 12:25:25.25	\N	f
2602	436	3	2025-11-29 12:25:25.25	\N	f
2603	436	4	2025-11-29 12:25:25.25	\N	f
2604	436	5	2025-11-29 12:25:25.25	\N	f
630	105	1	2025-11-29 12:23:56.914	2025-11-29 12:25:25.541	t
2557	429	0	2025-11-29 12:23:24.778	2025-11-29 12:25:36.524	t
2605	437	0	2025-11-29 12:25:55.052	\N	f
2606	437	1	2025-11-29 12:25:55.783	\N	f
2607	437	2	2025-11-29 12:25:55.783	\N	f
2608	437	3	2025-11-29 12:25:55.783	\N	f
2609	437	4	2025-11-29 12:25:55.783	\N	f
2610	437	5	2025-11-29 12:25:55.783	\N	f
2611	438	0	2025-11-29 12:26:27.702	\N	f
2612	438	1	2025-11-29 12:26:28.837	\N	f
2613	438	2	2025-11-29 12:26:28.837	\N	f
2614	438	3	2025-11-29 12:26:28.837	\N	f
2615	438	4	2025-11-29 12:26:28.837	\N	f
2616	438	5	2025-11-29 12:26:28.837	\N	f
977	164	4	2025-11-29 12:24:56.36	2025-11-29 12:28:19.881	t
3325	559	0	2025-11-29 13:23:21.637	\N	f
3326	559	5	2025-11-29 13:23:21.747	\N	f
3327	559	4	2025-11-29 13:23:21.747	\N	f
3328	559	3	2025-11-29 13:23:21.747	\N	f
3329	559	2	2025-11-29 13:23:21.747	\N	f
3330	559	1	2025-11-29 13:23:21.747	\N	f
2909	488	4	2025-11-29 13:20:30.143	2025-11-29 13:23:21.427	t
3344	562	5	2025-11-29 13:25:00.161	\N	f
3345	562	4	2025-11-29 13:25:00.161	\N	f
3346	562	3	2025-11-29 13:25:00.161	\N	f
3347	562	2	2025-11-29 13:25:00.161	\N	f
3348	562	1	2025-11-29 13:25:00.161	\N	f
3343	562	0	2025-11-29 13:25:00.125	2025-11-29 13:32:47.894	t
3421	575	0	2025-11-29 13:34:53.808	\N	f
3422	575	1	2025-11-29 13:34:53.986	\N	f
3423	575	2	2025-11-29 13:34:53.986	\N	f
3424	575	3	2025-11-29 13:34:53.986	\N	f
3425	575	4	2025-11-29 13:34:53.986	\N	f
3426	575	5	2025-11-29 13:34:53.986	\N	f
1389	233	4	2025-11-29 13:07:08.512	2025-11-29 13:35:07.674	t
3427	577	0	2025-11-29 13:36:28.987	\N	f
3428	577	1	2025-11-29 13:36:29.316	\N	f
3429	577	2	2025-11-29 13:36:29.316	\N	f
3430	577	3	2025-11-29 13:36:29.316	\N	f
3431	577	4	2025-11-29 13:36:29.316	\N	f
3432	577	5	2025-11-29 13:36:29.316	\N	f
3433	578	0	2025-11-29 13:37:45.425	\N	f
3434	578	5	2025-11-29 13:37:45.116	\N	f
3435	578	4	2025-11-29 13:37:45.116	\N	f
3436	578	3	2025-11-29 13:37:45.116	\N	f
3437	578	2	2025-11-29 13:37:45.116	\N	f
3438	578	1	2025-11-29 13:37:45.116	\N	f
3439	579	0	2025-11-29 13:37:53.904	\N	f
3440	579	5	2025-11-29 13:37:55.173	\N	f
3441	579	4	2025-11-29 13:37:55.173	\N	f
3442	579	3	2025-11-29 13:37:55.173	\N	f
3443	579	2	2025-11-29 13:37:55.173	\N	f
3444	579	1	2025-11-29 13:37:55.173	\N	f
3447	580	2	2025-11-29 13:38:22.229	\N	f
3448	580	3	2025-11-29 13:38:22.229	\N	f
3449	580	4	2025-11-29 13:38:22.229	\N	f
3450	580	5	2025-11-29 13:38:22.229	\N	f
3106	521	3	2025-11-29 13:28:04.279	2025-11-29 13:38:48.694	t
3505	590	0	2025-11-29 13:50:17.565	\N	f
3506	590	5	2025-11-29 13:50:17.728	\N	f
3507	590	4	2025-11-29 13:50:17.728	\N	f
3508	590	3	2025-11-29 13:50:17.728	\N	f
3509	590	2	2025-11-29 13:50:17.728	\N	f
3510	590	1	2025-11-29 13:50:17.728	\N	f
3517	592	0	2025-11-29 13:52:01.052	\N	f
3518	592	1	2025-11-29 13:52:01.71	\N	f
3519	592	2	2025-11-29 13:52:01.71	\N	f
3520	592	3	2025-11-29 13:52:01.71	\N	f
3521	592	4	2025-11-29 13:52:01.71	\N	f
3522	592	5	2025-11-29 13:52:01.71	\N	f
2991	502	2	2025-11-29 13:51:57.406	2025-11-29 13:52:12.154	t
3445	580	0	2025-11-29 13:38:21.454	2025-11-29 14:02:03.71	t
3565	600	0	2025-11-29 14:02:50.651	\N	f
3566	600	5	2025-11-29 14:02:50.473	\N	f
3567	600	4	2025-11-29 14:02:50.473	\N	f
3568	600	3	2025-11-29 14:02:50.473	\N	f
3569	600	2	2025-11-29 14:02:50.473	\N	f
3570	600	1	2025-11-29 14:02:50.473	\N	f
3571	601	0	2025-11-29 14:02:54.368	\N	f
3572	601	1	2025-11-29 14:02:54.948	\N	f
3573	601	2	2025-11-29 14:02:54.948	\N	f
3574	601	3	2025-11-29 14:02:54.948	\N	f
3575	601	4	2025-11-29 14:02:54.948	\N	f
3576	601	5	2025-11-29 14:02:54.948	\N	f
3577	602	0	2025-11-29 14:03:17.533	\N	f
3578	602	5	2025-11-29 14:03:18.089	\N	f
3579	602	4	2025-11-29 14:03:18.089	\N	f
3580	602	3	2025-11-29 14:03:18.089	\N	f
3581	602	2	2025-11-29 14:03:18.089	\N	f
3582	602	1	2025-11-29 14:03:18.089	\N	f
3625	611	0	2025-11-29 14:17:58.334	2025-11-29 14:19:00.851	t
3626	611	5	2025-11-29 14:19:10.349	2025-11-29 14:22:54.027	t
3627	611	4	2025-11-29 14:23:01.032	2025-11-29 14:26:10.616	t
3628	611	3	2025-11-29 14:26:15.483	2025-11-29 14:28:12.889	t
3703	625	0	2025-11-29 14:31:17.372	\N	f
3704	625	5	2025-11-29 14:31:18.314	\N	f
3705	625	4	2025-11-29 14:31:18.314	\N	f
3706	625	3	2025-11-29 14:31:18.314	\N	f
3707	625	2	2025-11-29 14:31:18.314	\N	f
3708	625	1	2025-11-29 14:31:18.314	\N	f
3709	626	0	2025-11-29 14:31:28.987	\N	f
3710	626	1	2025-11-29 14:31:29.105	\N	f
3711	626	2	2025-11-29 14:31:29.105	\N	f
3712	626	3	2025-11-29 14:31:29.105	\N	f
3713	626	4	2025-11-29 14:31:29.105	\N	f
3714	626	5	2025-11-29 14:31:29.105	\N	f
3629	611	2	2025-11-29 14:28:19.715	2025-11-29 14:32:07.574	t
3630	611	1	2025-11-29 14:32:11.423	2025-11-29 14:33:42.506	t
3732	629	5	2025-11-29 14:34:36.563	\N	f
3727	629	0	2025-11-29 14:34:36.303	2025-11-29 14:35:13.16	t
3728	629	1	2025-11-29 14:35:15.378	2025-11-29 14:35:35.623	t
3729	629	2	2025-11-29 14:35:38.037	2025-11-29 14:36:00.71	t
3730	629	3	2025-11-29 14:36:03.655	2025-11-29 14:36:13.129	t
3731	629	4	2025-11-29 14:36:16.007	2025-11-29 14:36:27.647	t
3446	580	1	2025-11-29 14:02:12.088	2025-11-29 14:45:18.973	t
3754	633	3	2025-11-29 14:51:14.959	\N	f
3755	633	2	2025-11-29 14:51:14.959	\N	f
3756	633	1	2025-11-29 14:51:14.959	\N	f
3793	640	0	2025-11-29 15:05:06.591	\N	f
3788	639	5	2025-11-29 15:10:27.843	2025-11-29 15:10:55.187	t
3789	639	4	2025-11-29 15:11:08.961	2025-11-29 15:11:50.071	t
3791	639	2	2025-11-29 15:12:27.421	2025-11-29 15:12:50.104	t
3792	639	1	2025-11-29 15:13:12.859	2025-11-29 15:13:39.675	t
1804	303	3	2025-11-29 12:20:25.832	2025-11-29 12:25:45.926	t
1185	199	2	2025-11-29 12:08:04.889	2025-11-29 12:26:42.325	t
1747	294	0	2025-11-29 12:03:25.075	2025-11-29 12:26:58.228	t
2289	384	2	2025-11-29 12:24:48.047	2025-11-29 12:27:05.042	t
1745	293	4	2025-11-29 12:25:36.317	2025-11-29 12:28:12.778	t
2617	439	0	2025-11-29 12:28:35.113	\N	f
2618	439	5	2025-11-29 12:28:35.187	\N	f
2619	439	4	2025-11-29 12:28:35.187	\N	f
2620	439	3	2025-11-29 12:28:35.187	\N	f
2621	439	2	2025-11-29 12:28:35.187	\N	f
2622	439	1	2025-11-29 12:28:35.187	\N	f
2623	440	0	2025-11-29 12:28:43.849	\N	f
2624	440	1	2025-11-29 12:28:44.023	\N	f
2625	440	2	2025-11-29 12:28:44.023	\N	f
2626	440	3	2025-11-29 12:28:44.023	\N	f
2627	440	4	2025-11-29 12:28:44.023	\N	f
2628	440	5	2025-11-29 12:28:44.023	\N	f
2629	441	0	2025-11-29 12:28:52.296	\N	f
2630	441	1	2025-11-29 12:28:52.468	\N	f
2631	441	2	2025-11-29 12:28:52.468	\N	f
2632	441	3	2025-11-29 12:28:52.468	\N	f
2633	441	4	2025-11-29 12:28:52.468	\N	f
2634	441	5	2025-11-29 12:28:52.468	\N	f
2636	442	1	2025-11-29 12:29:00.168	\N	f
2637	442	2	2025-11-29 12:29:00.168	\N	f
2638	442	3	2025-11-29 12:29:00.168	\N	f
2639	442	4	2025-11-29 12:29:00.168	\N	f
2640	442	5	2025-11-29 12:29:00.168	\N	f
705	118	4	2025-11-29 12:23:42.311	2025-11-29 12:27:52.198	t
1710	287	1	2025-11-29 12:29:23.071	2025-11-29 12:29:33.936	t
2449	411	0	2025-11-29 12:19:04.773	2025-11-29 12:29:33.88	t
2641	444	0	2025-11-29 12:30:16.941	\N	f
2642	444	5	2025-11-29 12:30:17.316	\N	f
2643	444	4	2025-11-29 12:30:17.316	\N	f
2644	444	3	2025-11-29 12:30:17.316	\N	f
2645	444	2	2025-11-29 12:30:17.316	\N	f
2646	444	1	2025-11-29 12:30:17.316	\N	f
1203	202	2	2025-11-29 12:23:25.349	2025-11-29 12:30:22.685	t
2728	458	3	2025-11-29 13:17:14.887	2025-11-29 13:20:32.394	t
3349	563	0	2025-11-29 13:27:20.331	\N	f
528	88	5	2025-11-29 12:27:09.445	2025-11-29 12:30:38.875	t
868	145	3	2025-11-29 12:21:58.717	2025-11-29 12:31:13.742	t
1541	259	2	2025-11-29 12:25:24.048	2025-11-29 12:31:48.812	t
2665	448	0	2025-11-29 12:31:55.314	\N	f
2666	448	5	2025-11-29 12:31:55.535	\N	f
2667	448	4	2025-11-29 12:31:55.535	\N	f
2668	448	3	2025-11-29 12:31:55.535	\N	f
2669	448	2	2025-11-29 12:31:55.535	\N	f
2670	448	1	2025-11-29 12:31:55.535	\N	f
2653	446	0	2025-11-29 12:30:41.498	2025-11-29 12:32:05.29	t
2647	445	0	2025-11-29 12:30:36.741	2025-11-29 12:32:24.882	t
2671	449	0	2025-11-29 12:32:32.827	\N	f
2672	449	1	2025-11-29 12:32:33.046	\N	f
2673	449	2	2025-11-29 12:32:33.046	\N	f
2674	449	3	2025-11-29 12:32:33.046	\N	f
2675	449	4	2025-11-29 12:32:33.046	\N	f
2676	449	5	2025-11-29 12:32:33.046	\N	f
2677	450	0	2025-11-29 12:32:50.305	\N	f
2678	450	1	2025-11-29 12:32:50.425	\N	f
2679	450	2	2025-11-29 12:32:50.425	\N	f
2680	450	3	2025-11-29 12:32:50.425	\N	f
2681	450	4	2025-11-29 12:32:50.425	\N	f
2682	450	5	2025-11-29 12:32:50.425	\N	f
2085	350	4	2025-11-29 12:26:48.191	2025-11-29 12:33:08.147	t
2683	451	0	2025-11-29 12:33:18.443	\N	f
2684	451	1	2025-11-29 12:33:18.576	\N	f
2685	451	2	2025-11-29 12:33:18.576	\N	f
2686	451	3	2025-11-29 12:33:18.576	\N	f
2687	451	4	2025-11-29 12:33:18.576	\N	f
2688	451	5	2025-11-29 12:33:18.576	\N	f
2689	452	0	2025-11-29 12:33:23.92	\N	f
2690	452	5	2025-11-29 12:33:24.659	\N	f
2691	452	4	2025-11-29 12:33:24.659	\N	f
2692	452	3	2025-11-29 12:33:24.659	\N	f
2693	452	2	2025-11-29 12:33:24.659	\N	f
2694	452	1	2025-11-29 12:33:24.659	\N	f
2659	447	0	2025-11-29 12:31:04.413	2025-11-29 12:33:53.321	t
1205	202	4	2025-11-29 12:32:58.244	2025-11-29 12:34:09.296	t
2698	453	3	2025-11-29 12:34:18.566	\N	f
2699	453	2	2025-11-29 12:34:18.566	\N	f
2700	453	1	2025-11-29 12:34:18.566	\N	f
2217	372	2	2025-11-29 12:27:48.742	2025-11-29 12:34:22.537	t
2701	454	0	2025-11-29 12:34:26.445	\N	f
2702	454	5	2025-11-29 12:34:26.898	\N	f
2703	454	4	2025-11-29 12:34:26.898	\N	f
2704	454	3	2025-11-29 12:34:26.898	\N	f
2705	454	2	2025-11-29 12:34:26.898	\N	f
2706	454	1	2025-11-29 12:34:26.898	\N	f
1763	296	4	2025-11-29 12:31:54.78	2025-11-29 12:34:58.746	t
1957	329	0	2025-11-29 12:07:29.613	2025-11-29 12:34:58.076	t
2707	455	0	2025-11-29 12:35:05.278	\N	f
2708	455	5	2025-11-29 12:35:05.214	\N	f
2709	455	4	2025-11-29 12:35:05.214	\N	f
2710	455	3	2025-11-29 12:35:05.214	\N	f
2711	455	2	2025-11-29 12:35:05.214	\N	f
2712	455	1	2025-11-29 12:35:05.214	\N	f
2715	456	4	2025-11-29 12:35:30.927	\N	f
2716	456	3	2025-11-29 12:35:30.927	\N	f
2717	456	2	2025-11-29 12:35:30.927	\N	f
2718	456	1	2025-11-29 12:35:30.927	\N	f
2719	457	0	2025-11-29 12:35:36.066	\N	f
2720	457	1	2025-11-29 12:35:36.254	\N	f
2721	457	2	2025-11-29 12:35:36.254	\N	f
2722	457	3	2025-11-29 12:35:36.254	\N	f
2723	457	4	2025-11-29 12:35:36.254	\N	f
2724	457	5	2025-11-29 12:35:36.254	\N	f
2654	446	1	2025-11-29 12:32:09.312	2025-11-29 12:36:01.571	t
2729	458	2	2025-11-29 12:36:29.007	\N	f
2730	458	1	2025-11-29 12:36:29.007	\N	f
2731	459	0	2025-11-29 12:36:43.262	\N	f
2732	459	5	2025-11-29 12:36:43.436	\N	f
2725	458	0	2025-11-29 12:36:28.829	2025-11-29 12:37:50.825	t
2656	446	3	2025-11-29 12:37:21.552	2025-11-29 12:40:01.606	t
2657	446	4	2025-11-29 12:40:06.041	2025-11-29 12:41:21.274	t
2660	447	1	2025-11-29 12:34:14.673	2025-11-29 12:42:49.539	t
2635	442	0	2025-11-29 12:28:59.457	2025-11-29 12:42:49.873	t
2658	446	5	2025-11-29 12:41:23.59	2025-11-29 12:44:27.973	t
2661	447	2	2025-11-29 12:42:53.14	2025-11-29 12:45:57.862	t
2714	456	5	2025-11-29 12:36:52.956	2025-11-29 12:50:49.043	t
2649	445	4	2025-11-29 12:43:18.215	2025-11-29 12:51:08.27	t
2662	447	3	2025-11-29 12:46:02.32	2025-11-29 12:52:58.126	t
2651	445	2	2025-11-29 12:52:53.94	2025-11-29 12:56:08.972	t
2663	447	4	2025-11-29 12:53:06.448	2025-11-29 12:56:13.26	t
2695	453	0	2025-11-29 12:34:18.449	2025-11-29 12:56:46.579	t
2652	445	1	2025-11-29 12:56:11.463	2025-11-29 12:57:39.37	t
2696	453	5	2025-11-29 12:56:52.112	2025-11-29 13:01:13.379	t
2664	447	5	2025-11-29 12:56:15.726	2025-11-29 13:07:05.775	t
2697	453	4	2025-11-29 13:01:29.961	2025-11-29 13:12:02.633	t
2727	458	4	2025-11-29 12:59:28.607	2025-11-29 13:17:11.493	t
2733	459	4	2025-11-29 12:36:43.436	\N	f
2734	459	3	2025-11-29 12:36:43.436	\N	f
2735	459	2	2025-11-29 12:36:43.436	\N	f
2736	459	1	2025-11-29 12:36:43.436	\N	f
2713	456	0	2025-11-29 12:35:30.539	2025-11-29 12:36:46.501	t
2655	446	2	2025-11-29 12:36:04.331	2025-11-29 12:37:17.953	t
2739	460	4	2025-11-29 12:37:24.594	\N	f
2740	460	3	2025-11-29 12:37:24.594	\N	f
2741	460	2	2025-11-29 12:37:24.594	\N	f
2742	460	1	2025-11-29 12:37:24.594	\N	f
1023	172	4	2025-11-29 12:19:23.114	2025-11-29 12:38:04.819	t
732	122	1	2025-11-29 12:34:37.523	2025-11-29 12:38:05.361	t
2743	461	0	2025-11-29 12:39:09.367	\N	f
2744	461	1	2025-11-29 12:39:09.555	\N	f
2745	461	2	2025-11-29 12:39:09.555	\N	f
2746	461	3	2025-11-29 12:39:09.555	\N	f
2747	461	4	2025-11-29 12:39:09.555	\N	f
2748	461	5	2025-11-29 12:39:09.555	\N	f
2558	429	1	2025-11-29 12:25:41.539	2025-11-29 12:39:32.716	t
2738	460	5	2025-11-29 12:50:28.656	2025-11-29 13:21:16.677	t
2750	462	5	2025-11-29 12:41:09.933	\N	f
2751	462	4	2025-11-29 12:41:09.933	\N	f
2752	462	3	2025-11-29 12:41:09.933	\N	f
2753	462	2	2025-11-29 12:41:09.933	\N	f
2754	462	1	2025-11-29 12:41:09.933	\N	f
2758	463	3	2025-11-29 12:41:31.32	\N	f
2759	463	2	2025-11-29 12:41:31.32	\N	f
2760	463	1	2025-11-29 12:41:31.32	\N	f
2761	464	0	2025-11-29 12:41:32.702	\N	f
2762	464	1	2025-11-29 12:41:32.864	\N	f
2763	464	2	2025-11-29 12:41:32.864	\N	f
2764	464	3	2025-11-29 12:41:32.864	\N	f
2765	464	4	2025-11-29 12:41:32.864	\N	f
2766	464	5	2025-11-29 12:41:32.864	\N	f
2767	465	0	2025-11-29 12:41:44.099	\N	f
2768	465	1	2025-11-29 12:41:44.27	\N	f
2769	465	2	2025-11-29 12:41:44.27	\N	f
2770	465	3	2025-11-29 12:41:44.27	\N	f
2771	465	4	2025-11-29 12:41:44.27	\N	f
2772	465	5	2025-11-29 12:41:44.27	\N	f
582	97	5	2025-11-29 12:33:09.741	2025-11-29 12:41:49.218	t
1930	324	3	2025-11-29 12:24:05.194	2025-11-29 12:42:14.304	t
2773	466	0	2025-11-29 12:42:16.931	2025-11-29 12:42:41.749	t
2056	345	3	2025-11-29 12:39:11.797	2025-11-29 12:42:43.842	t
886	148	3	2025-11-29 12:40:53.016	2025-11-29 12:42:50.336	t
1134	190	1	2025-11-29 12:43:02.815	2025-11-29 12:43:07.685	t
2779	467	0	2025-11-29 12:43:12.497	\N	f
2780	467	1	2025-11-29 12:43:12.655	\N	f
2781	467	2	2025-11-29 12:43:12.655	\N	f
2782	467	3	2025-11-29 12:43:12.655	\N	f
2783	467	4	2025-11-29 12:43:12.655	\N	f
2784	467	5	2025-11-29 12:43:12.655	\N	f
2648	445	5	2025-11-29 12:32:30.613	2025-11-29 12:43:14.699	t
2790	468	5	2025-11-29 13:11:24.278	2025-11-29 13:22:03.18	t
2777	466	2	2025-11-29 13:05:21.855	2025-11-29 13:26:15.028	t
2755	463	0	2025-11-29 12:41:31.167	2025-11-29 12:43:53.675	t
2429	407	4	2025-11-29 12:39:56.819	2025-11-29 12:44:01.906	t
2804	471	5	2025-11-29 12:44:26.293	\N	f
2805	471	4	2025-11-29 12:44:26.293	\N	f
2806	471	3	2025-11-29 12:44:26.293	\N	f
2807	471	2	2025-11-29 12:44:26.293	\N	f
2808	471	1	2025-11-29 12:44:26.293	\N	f
2810	472	5	2025-11-29 12:44:36.615	\N	f
2811	472	4	2025-11-29 12:44:36.615	\N	f
2812	472	3	2025-11-29 12:44:36.615	\N	f
2813	472	2	2025-11-29 12:44:36.615	\N	f
2814	472	1	2025-11-29 12:44:36.615	\N	f
1980	332	5	2025-11-29 12:40:11.934	2025-11-29 12:45:28.058	t
1727	290	2	2025-11-29 12:13:31.913	2025-11-29 12:46:00.431	t
3350	563	5	2025-11-29 13:27:21.001	\N	f
2141	359	2	2025-11-29 12:41:22.621	2025-11-29 12:46:59.199	t
2822	474	5	2025-11-29 12:47:03.377	\N	f
2823	474	4	2025-11-29 12:47:03.377	\N	f
2824	474	3	2025-11-29 12:47:03.377	\N	f
2825	474	2	2025-11-29 12:47:03.377	\N	f
2826	474	1	2025-11-29 12:47:03.377	\N	f
2797	470	0	2025-11-29 12:43:45.377	2025-11-29 12:47:46.188	t
2803	471	0	2025-11-29 12:44:25.791	2025-11-29 12:47:51.216	t
2791	469	0	2025-11-29 12:43:32.106	2025-11-29 12:47:56.908	t
2785	468	0	2025-11-29 12:43:25.397	2025-11-29 12:47:57.683	t
2809	472	0	2025-11-29 12:44:36.425	2025-11-29 12:47:59.384	t
2835	476	2	2025-11-29 13:11:35.803	2025-11-29 13:27:45.286	t
1426	240	3	2025-11-29 12:48:51.666	2025-11-29 12:49:00.133	t
2774	466	5	2025-11-29 12:42:54.815	2025-11-29 12:49:58.885	t
2737	460	0	2025-11-29 12:37:24.297	2025-11-29 12:50:22.169	t
2839	477	0	2025-11-29 12:50:32.646	\N	f
2840	477	5	2025-11-29 12:50:32.758	\N	f
2841	477	4	2025-11-29 12:50:32.758	\N	f
2842	477	3	2025-11-29 12:50:32.758	\N	f
2843	477	2	2025-11-29 12:50:32.758	\N	f
2844	477	1	2025-11-29 12:50:32.758	\N	f
2292	384	5	2025-11-29 12:33:17.496	2025-11-29 12:38:32.001	t
2845	478	0	2025-11-29 12:50:48.19	\N	f
2846	478	5	2025-11-29 12:50:50.41	\N	f
2847	478	4	2025-11-29 12:50:50.41	\N	f
2821	474	0	2025-11-29 12:49:00.772	2025-11-29 12:57:08.028	t
2815	473	0	2025-11-29 12:46:19.253	2025-11-29 12:55:18.53	t
2786	468	1	2025-11-29 12:48:01.182	2025-11-29 12:55:58.162	t
2798	470	1	2025-11-29 12:47:56.968	2025-11-29 12:56:13.218	t
2775	466	4	2025-11-29 12:50:03.596	2025-11-29 12:58:12.024	t
2828	475	5	2025-11-29 12:51:44.165	2025-11-29 12:59:01.928	t
2787	468	2	2025-11-29 12:56:03.492	2025-11-29 12:59:05.436	t
2833	476	0	2025-11-29 12:50:32.132	2025-11-29 13:00:05.534	t
2792	469	5	2025-11-29 12:47:59.835	2025-11-29 13:00:52.459	t
2776	466	3	2025-11-29 12:58:16.132	2025-11-29 13:05:09.368	t
2829	475	4	2025-11-29 12:59:04.404	2025-11-29 13:06:20.167	t
2830	475	3	2025-11-29 13:06:25.91	2025-11-29 13:07:29.25	t
2800	470	3	2025-11-29 12:59:04.54	2025-11-29 13:08:07.753	t
2788	468	3	2025-11-29 12:59:10.492	2025-11-29 13:08:16.182	t
2789	468	4	2025-11-29 13:08:18.922	2025-11-29 13:11:22.233	t
2834	476	1	2025-11-29 13:01:47.677	2025-11-29 13:05:35.932	t
2801	470	4	2025-11-29 13:08:12.278	2025-11-29 13:11:33.082	t
2794	469	3	2025-11-29 13:10:14.931	2025-11-29 13:14:32.922	t
2831	475	2	2025-11-29 13:07:31.204	2025-11-29 13:31:21.583	t
2832	475	1	2025-11-29 13:31:24.474	2025-11-29 13:32:44.618	t
2817	473	2	2025-11-29 13:01:58.461	2025-11-29 13:41:42.894	t
2837	476	4	2025-11-29 13:45:31.204	2025-11-29 13:46:56.611	t
2818	473	3	2025-11-29 13:41:53.261	2025-11-29 13:50:34.803	t
2819	473	4	2025-11-29 13:50:37.989	2025-11-29 13:53:32.74	t
2838	476	5	2025-11-29 13:47:02.31	2025-11-29 13:55:48.068	t
2756	463	5	2025-11-29 12:43:57.681	2025-11-29 14:05:06.272	t
2795	469	2	2025-11-29 13:14:39.397	2025-11-29 14:07:59.552	t
2796	469	1	2025-11-29 14:08:04.18	2025-11-29 14:13:08.042	t
2757	463	4	2025-11-29 14:05:10.443	2025-11-29 14:18:54.602	t
2848	478	3	2025-11-29 12:50:50.41	\N	f
2849	478	2	2025-11-29 12:50:50.41	\N	f
2850	478	1	2025-11-29 12:50:50.41	\N	f
2856	479	5	2025-11-29 12:51:05.006	\N	f
2827	475	0	2025-11-29 12:48:56.933	2025-11-29 12:51:40.101	t
2857	480	0	2025-11-29 12:52:16.14	\N	f
2858	480	1	2025-11-29 12:52:16.377	\N	f
2859	480	2	2025-11-29 12:52:16.377	\N	f
2860	480	3	2025-11-29 12:52:16.377	\N	f
2861	480	4	2025-11-29 12:52:16.377	\N	f
2862	480	5	2025-11-29 12:52:16.377	\N	f
2864	481	1	2025-11-29 12:52:43.107	\N	f
2865	481	2	2025-11-29 12:52:43.107	\N	f
2866	481	3	2025-11-29 12:52:43.107	\N	f
2867	481	4	2025-11-29 12:52:43.107	\N	f
2868	481	5	2025-11-29 12:52:43.107	\N	f
2650	445	3	2025-11-29 12:51:11.274	2025-11-29 12:52:49.681	t
2749	462	0	2025-11-29 12:41:09.488	2025-11-29 12:53:18.555	t
2875	483	0	2025-11-29 12:55:23.428	\N	f
2876	483	5	2025-11-29 12:55:24.46	\N	f
2877	483	4	2025-11-29 12:55:24.46	\N	f
2878	483	3	2025-11-29 12:55:24.46	\N	f
2879	483	2	2025-11-29 12:55:24.46	\N	f
2880	483	1	2025-11-29 12:55:24.46	\N	f
2882	484	1	2025-11-29 12:55:44.841	\N	f
2883	484	2	2025-11-29 12:55:44.841	\N	f
2884	484	3	2025-11-29 12:55:44.841	\N	f
2885	484	4	2025-11-29 12:55:44.841	\N	f
2886	484	5	2025-11-29 12:55:44.841	\N	f
2863	481	0	2025-11-29 12:52:42.908	2025-11-29 12:56:01.622	t
1932	324	5	2025-11-29 12:46:47.936	2025-11-29 12:55:55.369	t
2851	479	0	2025-11-29 12:51:04.295	2025-11-29 12:56:07.681	t
2869	482	0	2025-11-29 12:54:16.891	2025-11-29 12:56:36.892	t
2887	485	0	2025-11-29 12:56:40.285	\N	f
2888	485	5	2025-11-29 12:56:52.566	\N	f
2889	485	4	2025-11-29 12:56:52.566	\N	f
2890	485	3	2025-11-29 12:56:52.566	\N	f
2891	485	2	2025-11-29 12:56:52.566	\N	f
2892	485	1	2025-11-29 12:56:52.566	\N	f
2799	470	2	2025-11-29 12:56:15.919	2025-11-29 12:59:01.425	t
2893	486	0	2025-11-29 12:59:02.734	\N	f
2894	486	1	2025-11-29 12:59:02.697	\N	f
2895	486	2	2025-11-29 12:59:02.697	\N	f
2896	486	3	2025-11-29 12:59:02.697	\N	f
2897	486	4	2025-11-29 12:59:02.697	\N	f
2898	486	5	2025-11-29 12:59:02.697	\N	f
2726	458	5	2025-11-29 12:37:54.046	2025-11-29 12:59:25.138	t
2452	411	3	2025-11-29 12:36:48.927	2025-11-29 12:59:25.668	t
2899	487	0	2025-11-29 12:59:34.694	\N	f
2900	487	1	2025-11-29 12:59:34.965	\N	f
2901	487	2	2025-11-29 12:59:34.965	\N	f
2902	487	3	2025-11-29 12:59:34.965	\N	f
2903	487	4	2025-11-29 12:59:34.965	\N	f
2904	487	5	2025-11-29 12:59:34.965	\N	f
2908	488	3	2025-11-29 13:15:44.272	2025-11-29 13:20:26.939	t
2920	490	3	2025-11-29 13:15:46.73	2025-11-29 13:20:21.705	t
2911	489	0	2025-11-29 12:59:56.052	\N	f
2912	489	1	2025-11-29 12:59:56.211	\N	f
2913	489	2	2025-11-29 12:59:56.211	\N	f
2914	489	3	2025-11-29 12:59:56.211	\N	f
2915	489	4	2025-11-29 12:59:56.211	\N	f
2916	489	5	2025-11-29 12:59:56.211	\N	f
2923	491	0	2025-11-29 13:00:31.542	\N	f
2924	491	1	2025-11-29 13:00:32.851	\N	f
2925	491	2	2025-11-29 13:00:32.851	\N	f
2926	491	3	2025-11-29 13:00:32.851	\N	f
2927	491	4	2025-11-29 13:00:32.851	\N	f
2928	491	5	2025-11-29 13:00:32.851	\N	f
2498	419	5	2025-11-29 12:37:57.064	2025-11-29 13:01:38.416	t
2816	473	1	2025-11-29 12:55:26.917	2025-11-29 13:01:54.09	t
768	128	5	2025-11-29 12:41:59.14	2025-11-29 13:02:26.149	t
2935	493	0	2025-11-29 13:02:54.864	\N	f
2936	493	5	2025-11-29 13:02:55.193	\N	f
2937	493	4	2025-11-29 13:02:55.193	\N	f
2938	493	3	2025-11-29 13:02:55.193	\N	f
2939	493	2	2025-11-29 13:02:55.193	\N	f
2940	493	1	2025-11-29 13:02:55.193	\N	f
2947	495	0	2025-11-29 13:03:49.5	\N	f
2948	495	5	2025-11-29 13:03:50.551	\N	f
2949	495	4	2025-11-29 13:03:50.551	\N	f
2950	495	3	2025-11-29 13:03:50.551	\N	f
2951	495	2	2025-11-29 13:03:50.551	\N	f
2952	495	1	2025-11-29 13:03:50.551	\N	f
2852	479	1	2025-11-29 12:56:20.212	2025-11-29 13:03:55.677	t
1026	172	1	2025-11-29 13:03:13.865	2025-11-29 13:05:21.995	t
2955	496	4	2025-11-29 13:15:42.611	2025-11-29 13:20:33.85	t
2959	497	0	2025-11-29 13:06:33.851	\N	f
2960	497	5	2025-11-29 13:06:34.778	\N	f
2961	497	4	2025-11-29 13:06:34.778	\N	f
2962	497	3	2025-11-29 13:06:34.778	\N	f
2963	497	2	2025-11-29 13:06:34.778	\N	f
2964	497	1	2025-11-29 13:06:34.778	\N	f
2917	490	0	2025-11-29 13:00:29.791	2025-11-29 13:07:03.153	t
2905	488	0	2025-11-29 12:59:39.952	2025-11-29 13:07:02.323	t
1388	233	5	2025-11-29 12:20:14.425	2025-11-29 13:07:04.147	t
2941	494	0	2025-11-29 13:03:04.477	2025-11-29 13:07:23.028	t
2929	492	0	2025-11-29 13:00:42.861	2025-11-29 13:07:43.616	t
2965	498	0	2025-11-29 13:07:53.504	\N	f
2966	498	1	2025-11-29 13:07:52.377	\N	f
2967	498	2	2025-11-29 13:07:52.377	\N	f
2977	500	0	2025-11-29 13:09:30.706	\N	f
2918	490	1	2025-11-29 13:07:10.624	2025-11-29 13:13:20.046	t
2881	484	0	2025-11-29 12:55:44.677	2025-11-29 13:14:03.909	t
2930	492	5	2025-11-29 13:07:49.622	2025-11-29 13:15:24.569	t
2954	496	5	2025-11-29 13:08:04.246	2025-11-29 13:15:38.832	t
2919	490	2	2025-11-29 13:13:33.011	2025-11-29 13:15:44.329	t
2870	482	5	2025-11-29 12:56:43.235	2025-11-29 13:16:51.454	t
2956	496	3	2025-11-29 13:20:41.127	2025-11-29 13:22:55.739	t
2921	490	4	2025-11-29 13:20:34.543	2025-11-29 13:23:36.894	t
2931	492	4	2025-11-29 13:15:29.984	2025-11-29 13:24:52.495	t
3351	563	4	2025-11-29 13:27:21.001	\N	f
2957	496	2	2025-11-29 13:23:04.054	2025-11-29 13:28:06.084	t
2922	490	5	2025-11-29 13:23:39.228	2025-11-29 13:29:36.606	t
2958	496	1	2025-11-29 13:28:11.102	2025-11-29 13:31:18.984	t
2933	492	2	2025-11-29 13:28:15.831	2025-11-29 13:43:20.952	t
2934	492	1	2025-11-29 13:43:25.508	2025-11-29 13:46:01.188	t
2942	494	1	2025-11-29 13:07:29.492	2025-11-29 14:04:44.876	t
2943	494	2	2025-11-29 14:04:49.046	2025-11-29 14:12:36.096	t
2945	494	4	2025-11-29 14:24:25.083	2025-11-29 14:28:05.038	t
2871	482	4	2025-11-29 13:17:01.759	2025-11-29 14:34:14.307	t
2872	482	3	2025-11-29 14:34:20.809	2025-11-29 14:37:54.645	t
2873	482	2	2025-11-29 14:37:58.751	2025-11-29 14:43:08.224	t
2853	479	2	2025-11-29 13:04:09.828	2025-11-29 16:52:35.362	t
2854	479	3	2025-11-29 16:52:46.637	2025-11-29 16:53:27.785	t
2855	479	4	2025-11-29 16:53:37.143	2025-11-29 16:54:04.651	t
2946	494	5	2025-11-29 14:28:08.446	2025-11-29 17:29:40.781	t
2968	498	3	2025-11-29 13:07:52.377	\N	f
2969	498	4	2025-11-29 13:07:52.377	\N	f
2970	498	5	2025-11-29 13:07:52.377	\N	f
2953	496	0	2025-11-29 13:06:23.088	2025-11-29 13:08:00.435	t
2971	499	0	2025-11-29 13:08:37.411	\N	f
2972	499	1	2025-11-29 13:08:30.774	\N	f
2973	499	2	2025-11-29 13:08:30.774	\N	f
2974	499	3	2025-11-29 13:08:30.774	\N	f
2975	499	4	2025-11-29 13:08:30.774	\N	f
2976	499	5	2025-11-29 13:08:30.774	\N	f
2793	469	4	2025-11-29 13:00:55.806	2025-11-29 13:10:11.084	t
2983	501	0	2025-11-29 13:10:04.89	2025-11-29 13:22:21.937	t
2984	501	5	2025-11-29 13:22:55.825	2025-11-29 13:24:56.143	t
3352	563	3	2025-11-29 13:27:21.001	\N	f
3353	563	2	2025-11-29 13:27:21.001	\N	f
3354	563	1	2025-11-29 13:27:21.001	\N	f
3355	564	0	2025-11-29 13:27:43.055	\N	f
3356	564	1	2025-11-29 13:27:43.261	\N	f
3357	564	2	2025-11-29 13:27:43.261	\N	f
3358	564	3	2025-11-29 13:27:43.261	\N	f
3359	564	4	2025-11-29 13:27:43.261	\N	f
3360	564	5	2025-11-29 13:27:43.261	\N	f
3363	565	2	2025-11-29 13:27:59.39	\N	f
3364	565	3	2025-11-29 13:27:59.39	\N	f
3365	565	4	2025-11-29 13:27:59.39	\N	f
3366	565	5	2025-11-29 13:27:59.39	\N	f
2932	492	3	2025-11-29 13:25:01.576	2025-11-29 13:28:01.766	t
2454	411	5	2025-11-29 13:03:17.459	2025-11-29 13:28:40.962	t
3367	566	0	2025-11-29 13:28:44.065	\N	f
3368	566	1	2025-11-29 13:28:44.195	\N	f
3369	566	2	2025-11-29 13:28:44.195	\N	f
3370	566	3	2025-11-29 13:28:44.195	\N	f
3371	566	4	2025-11-29 13:28:44.195	\N	f
3372	566	5	2025-11-29 13:28:44.195	\N	f
3380	568	5	2025-11-29 13:29:14.217	\N	f
3381	568	4	2025-11-29 13:29:14.217	\N	f
3382	568	3	2025-11-29 13:29:14.217	\N	f
3383	568	2	2025-11-29 13:29:14.217	\N	f
3384	568	1	2025-11-29 13:29:14.217	\N	f
3379	568	0	2025-11-29 13:29:14.101	2025-11-29 13:29:37.444	t
3361	565	0	2025-11-29 13:27:59.197	2025-11-29 13:29:54.119	t
3362	565	1	2025-11-29 13:29:57.701	2025-11-29 13:35:12.468	t
3242	544	1	2025-11-29 13:24:38.522	2025-11-29 13:35:49.108	t
2985	501	4	2025-11-29 13:25:00.373	2025-11-29 13:37:30.855	t
2986	501	3	2025-11-29 13:37:33.745	2025-11-29 13:40:31.941	t
3511	591	0	2025-11-29 13:50:21.466	\N	f
3512	591	5	2025-11-29 13:50:21.735	\N	f
3513	591	4	2025-11-29 13:50:21.735	\N	f
3514	591	3	2025-11-29 13:50:21.735	\N	f
3515	591	2	2025-11-29 13:50:21.735	\N	f
3516	591	1	2025-11-29 13:50:21.735	\N	f
2987	501	2	2025-11-29 13:40:35.373	2025-11-29 13:50:25.658	t
2988	501	1	2025-11-29 13:50:28.17	2025-11-29 13:51:43.363	t
3022	507	3	2025-11-29 13:31:43.317	2025-11-29 13:53:18.599	t
3589	604	0	2025-11-29 14:07:31.516	\N	f
3590	604	5	2025-11-29 14:07:32.008	\N	f
3591	604	4	2025-11-29 14:07:32.008	\N	f
3592	604	3	2025-11-29 14:07:32.008	\N	f
3593	604	2	2025-11-29 14:07:32.008	\N	f
3594	604	1	2025-11-29 14:07:32.008	\N	f
3631	612	0	2025-11-29 14:20:02.495	\N	f
3632	612	1	2025-11-29 14:20:02.623	\N	f
3633	612	2	2025-11-29 14:20:02.623	\N	f
3634	612	3	2025-11-29 14:20:02.623	\N	f
3635	612	4	2025-11-29 14:20:02.623	\N	f
3636	612	5	2025-11-29 14:20:02.623	\N	f
3637	613	0	2025-11-29 14:20:03.861	\N	f
3638	613	5	2025-11-29 14:20:04.209	\N	f
3639	613	4	2025-11-29 14:20:04.209	\N	f
3640	613	3	2025-11-29 14:20:04.209	\N	f
3641	613	2	2025-11-29 14:20:04.209	\N	f
3642	613	1	2025-11-29 14:20:04.209	\N	f
3643	614	0	2025-11-29 14:20:16.149	\N	f
3644	614	1	2025-11-29 14:20:17.179	\N	f
3645	614	2	2025-11-29 14:20:17.179	\N	f
3646	614	3	2025-11-29 14:20:17.179	\N	f
3647	614	4	2025-11-29 14:20:17.179	\N	f
3648	614	5	2025-11-29 14:20:17.179	\N	f
3667	618	0	2025-11-29 14:22:40.391	\N	f
3668	618	5	2025-11-29 14:22:40.751	\N	f
3669	618	4	2025-11-29 14:22:40.751	\N	f
3670	618	3	2025-11-29 14:22:40.751	\N	f
3671	618	2	2025-11-29 14:22:40.751	\N	f
3672	618	1	2025-11-29 14:22:40.751	\N	f
2944	494	3	2025-11-29 14:12:41.208	2025-11-29 14:24:20.473	t
3715	627	0	2025-11-29 14:32:29.726	\N	f
3716	627	1	2025-11-29 14:32:29.832	\N	f
3717	627	2	2025-11-29 14:32:29.832	\N	f
3718	627	3	2025-11-29 14:32:29.832	\N	f
3719	627	4	2025-11-29 14:32:29.832	\N	f
3720	627	5	2025-11-29 14:32:29.832	\N	f
3721	628	0	2025-11-29 14:32:47.767	2025-11-29 14:33:01.515	t
3722	628	5	2025-11-29 14:33:06.826	2025-11-29 14:36:46.176	t
3723	628	4	2025-11-29 14:36:49.355	2025-11-29 14:45:57.96	t
3724	628	3	2025-11-29 14:46:06.069	2025-11-29 14:48:00.799	t
3757	634	0	2025-11-29 14:55:04.031	\N	f
3758	634	1	2025-11-29 14:55:04.324	\N	f
3759	634	2	2025-11-29 14:55:04.324	\N	f
3760	634	3	2025-11-29 14:55:04.324	\N	f
3761	634	4	2025-11-29 14:55:04.324	\N	f
3762	634	5	2025-11-29 14:55:04.324	\N	f
3725	628	2	2025-11-29 14:48:05.968	2025-11-29 14:58:01.866	t
3726	628	1	2025-11-29 14:58:05.902	2025-11-29 15:00:20.481	t
3794	640	1	2025-11-29 15:05:07.299	\N	f
3795	640	2	2025-11-29 15:05:07.299	\N	f
3796	640	3	2025-11-29 15:05:07.299	\N	f
3797	640	4	2025-11-29 15:05:07.299	\N	f
3798	640	5	2025-11-29 15:05:07.299	\N	f
3787	639	0	2025-11-29 15:05:04.391	2025-11-29 15:06:29.855	t
3738	630	5	2025-11-29 15:19:52.158	2025-11-29 15:30:16.367	t
3841	648	0	2025-11-29 16:41:26.241	\N	f
3842	648	1	2025-11-29 16:41:26.843	\N	f
3843	648	2	2025-11-29 16:41:26.843	\N	f
3844	648	3	2025-11-29 16:41:26.843	\N	f
3845	648	4	2025-11-29 16:41:26.843	\N	f
3846	648	5	2025-11-29 16:41:26.843	\N	f
3853	650	0	2025-11-29 16:42:50.707	2025-11-29 16:44:36.896	t
3862	651	3	2025-11-29 16:46:37.108	\N	f
3863	651	4	2025-11-29 16:46:37.108	\N	f
3864	651	5	2025-11-29 16:46:37.108	\N	f
3836	647	5	2025-11-29 16:06:44.094	2025-11-29 16:48:51.447	t
3854	650	1	2025-11-29 16:44:40.201	2025-11-29 16:50:13.032	t
3865	652	0	2025-11-29 16:50:52.409	2025-11-29 16:53:31.748	t
3856	650	3	2025-11-29 16:52:13.919	2025-11-29 16:56:18.345	t
3858	650	5	2025-11-29 16:59:40.517	2025-11-29 17:04:33.744	t
3866	652	5	2025-11-29 16:53:35.73	2025-11-29 17:04:51.3	t
3867	652	4	2025-11-29 17:04:53.694	2025-11-29 17:18:50.149	t
3868	652	3	2025-11-29 17:18:53.105	2025-11-29 17:21:45.472	t
2978	500	1	2025-11-29 13:09:31.374	\N	f
2979	500	2	2025-11-29 13:09:31.374	\N	f
2980	500	3	2025-11-29 13:09:31.374	\N	f
2981	500	4	2025-11-29 13:09:31.374	\N	f
2982	500	5	2025-11-29 13:09:31.374	\N	f
2994	502	5	2025-11-29 13:10:57.441	\N	f
2995	503	0	2025-11-29 13:11:01.778	\N	f
2996	503	1	2025-11-29 13:11:01.863	\N	f
2997	503	2	2025-11-29 13:11:01.863	\N	f
2998	503	3	2025-11-29 13:11:01.863	\N	f
2999	503	4	2025-11-29 13:11:01.863	\N	f
3000	503	5	2025-11-29 13:11:01.863	\N	f
3003	504	2	2025-11-29 13:11:04.876	\N	f
3004	504	3	2025-11-29 13:11:04.876	\N	f
3005	504	4	2025-11-29 13:11:04.876	\N	f
3006	504	5	2025-11-29 13:11:04.876	\N	f
3013	506	0	2025-11-29 13:11:15.633	\N	f
3014	506	5	2025-11-29 13:11:16.159	\N	f
3015	506	4	2025-11-29 13:11:16.159	\N	f
3016	506	3	2025-11-29 13:11:16.159	\N	f
3017	506	2	2025-11-29 13:11:16.159	\N	f
3018	506	1	2025-11-29 13:11:16.159	\N	f
3025	508	0	2025-11-29 13:11:56.443	\N	f
3026	508	5	2025-11-29 13:12:00.839	\N	f
3027	508	4	2025-11-29 13:12:00.839	\N	f
3028	508	3	2025-11-29 13:12:00.839	\N	f
3029	508	2	2025-11-29 13:12:00.839	\N	f
3030	508	1	2025-11-29 13:12:00.839	\N	f
3103	521	0	2025-11-29 13:15:30.685	2025-11-29 13:22:17.863	t
3049	512	0	2025-11-29 13:12:30.348	\N	f
3050	512	5	2025-11-29 13:12:30.536	\N	f
3051	512	4	2025-11-29 13:12:30.536	\N	f
3052	512	3	2025-11-29 13:12:30.536	\N	f
3053	512	2	2025-11-29 13:12:30.536	\N	f
3054	512	1	2025-11-29 13:12:30.536	\N	f
3056	513	5	2025-11-29 13:12:45.559	\N	f
3057	513	4	2025-11-29 13:12:45.559	\N	f
3058	513	3	2025-11-29 13:12:45.559	\N	f
3059	513	2	2025-11-29 13:12:45.559	\N	f
3060	513	1	2025-11-29 13:12:45.559	\N	f
3061	514	0	2025-11-29 13:13:04.135	\N	f
3062	514	1	2025-11-29 13:13:04.284	\N	f
3063	514	2	2025-11-29 13:13:04.284	\N	f
3064	514	3	2025-11-29 13:13:04.284	\N	f
3065	514	4	2025-11-29 13:13:04.284	\N	f
3066	514	5	2025-11-29 13:13:04.284	\N	f
2906	488	1	2025-11-29 13:07:27.417	2025-11-29 13:13:27.677	t
3067	515	0	2025-11-29 13:13:42.303	\N	f
3068	515	1	2025-11-29 13:13:42.503	\N	f
3069	515	2	2025-11-29 13:13:42.503	\N	f
3070	515	3	2025-11-29 13:13:42.503	\N	f
3071	515	4	2025-11-29 13:13:42.503	\N	f
3072	515	5	2025-11-29 13:13:42.503	\N	f
3073	516	0	2025-11-29 13:13:43.692	\N	f
3074	516	1	2025-11-29 13:13:43.62	\N	f
3075	516	2	2025-11-29 13:13:43.62	\N	f
3076	516	3	2025-11-29 13:13:43.62	\N	f
3077	516	4	2025-11-29 13:13:43.62	\N	f
3078	516	5	2025-11-29 13:13:43.62	\N	f
3019	507	0	2025-11-29 13:11:52.95	2025-11-29 13:13:49.305	t
3037	510	0	2025-11-29 13:12:12.538	2025-11-29 13:13:50.118	t
3079	517	0	2025-11-29 13:14:02.856	\N	f
3080	517	5	2025-11-29 13:14:02.493	\N	f
3081	517	4	2025-11-29 13:14:02.493	\N	f
3082	517	3	2025-11-29 13:14:02.493	\N	f
3083	517	2	2025-11-29 13:14:02.493	\N	f
3084	517	1	2025-11-29 13:14:02.493	\N	f
3031	509	0	2025-11-29 13:12:06.342	2025-11-29 13:13:55.094	t
3085	518	0	2025-11-29 13:14:07.45	\N	f
3086	518	1	2025-11-29 13:14:07.601	\N	f
3087	518	2	2025-11-29 13:14:07.601	\N	f
3088	518	3	2025-11-29 13:14:07.601	\N	f
3089	518	4	2025-11-29 13:14:07.601	\N	f
3090	518	5	2025-11-29 13:14:07.601	\N	f
3091	519	0	2025-11-29 13:14:11.921	\N	f
3092	519	1	2025-11-29 13:14:12.77	\N	f
3093	519	2	2025-11-29 13:14:12.77	\N	f
3094	519	3	2025-11-29 13:14:12.77	\N	f
3095	519	4	2025-11-29 13:14:12.77	\N	f
3096	519	5	2025-11-29 13:14:12.77	\N	f
3020	507	5	2025-11-29 13:13:51.569	2025-11-29 13:14:18.335	t
3097	520	0	2025-11-29 13:14:23.578	\N	f
3098	520	1	2025-11-29 13:14:28.303	\N	f
3099	520	2	2025-11-29 13:14:28.303	\N	f
3100	520	3	2025-11-29 13:14:28.303	\N	f
3101	520	4	2025-11-29 13:14:28.303	\N	f
3102	520	5	2025-11-29 13:14:28.303	\N	f
3038	510	5	2025-11-29 13:13:55.293	2025-11-29 13:14:31.292	t
3032	509	5	2025-11-29 13:14:10.272	2025-11-29 13:15:20.271	t
3109	522	0	2025-11-29 13:15:29.242	\N	f
3110	522	5	2025-11-29 13:15:33.522	\N	f
3111	522	4	2025-11-29 13:15:33.522	\N	f
3112	522	3	2025-11-29 13:15:33.522	\N	f
3113	522	2	2025-11-29 13:15:33.522	\N	f
3114	522	1	2025-11-29 13:15:33.522	\N	f
2907	488	2	2025-11-29 13:13:33.889	2025-11-29 13:15:40.667	t
3115	523	0	2025-11-29 13:15:57.084	\N	f
3055	513	0	2025-11-29 13:12:45.242	2025-11-29 13:17:09.835	t
3001	504	0	2025-11-29 13:11:04.935	2025-11-29 13:18:29.672	t
3044	511	5	2025-11-29 13:17:12.787	2025-11-29 13:25:36.019	t
3002	504	1	2025-11-29 13:18:33.346	2025-11-29 13:26:38.638	t
3104	521	1	2025-11-29 13:22:55.728	2025-11-29 13:26:47.941	t
3105	521	2	2025-11-29 13:27:03.74	2025-11-29 13:27:36.752	t
2778	466	1	2025-11-29 13:26:18.872	2025-11-29 13:28:17.158	t
3021	507	4	2025-11-29 13:14:21.09	2025-11-29 13:31:39.192	t
3039	510	4	2025-11-29 13:31:40.877	2025-11-29 13:31:47.116	t
3033	509	4	2025-11-29 13:15:23.033	2025-11-29 13:31:49.193	t
3046	511	3	2025-11-29 13:30:55.598	2025-11-29 13:34:13.584	t
3008	505	1	2025-11-29 13:31:04.105	2025-11-29 13:37:43.366	t
3047	511	2	2025-11-29 13:34:16.09	2025-11-29 13:39:02.485	t
3048	511	1	2025-11-29 13:39:04.59	2025-11-29 13:40:45.543	t
3107	521	4	2025-11-29 13:39:05.598	2025-11-29 13:41:59.294	t
2990	502	1	2025-11-29 13:22:59.466	2025-11-29 13:51:52.253	t
2992	502	3	2025-11-29 13:52:14.706	2025-11-29 13:52:25.668	t
3108	521	5	2025-11-29 13:42:03.823	2025-11-29 13:52:32.273	t
2993	502	4	2025-11-29 13:52:28.422	2025-11-29 13:52:38.265	t
3009	505	2	2025-11-29 13:37:47.837	2025-11-29 13:52:57.159	t
3040	510	3	2025-11-29 13:31:54.355	2025-11-29 13:53:02.696	t
3034	509	3	2025-11-29 13:32:46.202	2025-11-29 13:53:27.274	t
3010	505	3	2025-11-29 13:53:08.516	2025-11-29 13:55:53.125	t
3023	507	2	2025-11-29 13:53:21.28	2025-11-29 14:08:59.468	t
3041	510	2	2025-11-29 13:53:10.754	2025-11-29 14:09:05.947	t
3035	509	2	2025-11-29 13:53:30.975	2025-11-29 14:09:10.228	t
3042	510	1	2025-11-29 14:09:11.029	2025-11-29 14:09:23.2	t
3036	509	1	2025-11-29 14:09:13.318	2025-11-29 14:09:58.762	t
3011	505	4	2025-11-29 13:55:56.563	2025-11-29 14:10:34.749	t
3012	505	5	2025-11-29 14:10:38.128	2025-11-29 14:11:02.783	t
3116	523	1	2025-11-29 13:15:56.663	\N	f
3117	523	2	2025-11-29 13:15:56.663	\N	f
3118	523	3	2025-11-29 13:15:56.663	\N	f
3119	523	4	2025-11-29 13:15:56.663	\N	f
3120	523	5	2025-11-29 13:15:56.663	\N	f
3121	524	0	2025-11-29 13:15:55.68	\N	f
3122	524	1	2025-11-29 13:15:57.176	\N	f
3123	524	2	2025-11-29 13:15:57.176	\N	f
3124	524	3	2025-11-29 13:15:57.176	\N	f
3125	524	4	2025-11-29 13:15:57.176	\N	f
3126	524	5	2025-11-29 13:15:57.176	\N	f
3127	525	0	2025-11-29 13:16:20.887	\N	f
3128	525	5	2025-11-29 13:16:20.539	\N	f
3129	525	4	2025-11-29 13:16:20.539	\N	f
3130	525	3	2025-11-29 13:16:20.539	\N	f
3131	525	2	2025-11-29 13:16:20.539	\N	f
3132	525	1	2025-11-29 13:16:20.539	\N	f
3043	511	0	2025-11-29 13:12:18.22	2025-11-29 13:16:52.489	t
3133	526	0	2025-11-29 13:16:57.434	\N	f
3134	526	5	2025-11-29 13:16:57.914	\N	f
3135	526	4	2025-11-29 13:16:57.914	\N	f
3136	526	3	2025-11-29 13:16:57.914	\N	f
3137	526	2	2025-11-29 13:16:57.914	\N	f
3138	526	1	2025-11-29 13:16:57.914	\N	f
3145	528	0	2025-11-29 13:17:11.716	\N	f
3146	528	5	2025-11-29 13:17:11.862	\N	f
3147	528	4	2025-11-29 13:17:11.862	\N	f
3148	528	3	2025-11-29 13:17:11.862	\N	f
3149	528	2	2025-11-29 13:17:11.862	\N	f
3150	528	1	2025-11-29 13:17:11.862	\N	f
3153	529	2	2025-11-29 13:17:14.787	\N	f
3154	529	3	2025-11-29 13:17:14.787	\N	f
3155	529	4	2025-11-29 13:17:14.787	\N	f
3156	529	5	2025-11-29 13:17:14.787	\N	f
3158	530	1	2025-11-29 13:17:16.97	\N	f
3159	530	2	2025-11-29 13:17:16.97	\N	f
3160	530	3	2025-11-29 13:17:16.97	\N	f
3161	530	4	2025-11-29 13:17:16.97	\N	f
3162	530	5	2025-11-29 13:17:16.97	\N	f
1581	266	2	2025-11-29 12:18:11.955	2025-11-29 13:17:21.497	t
3151	529	0	2025-11-29 13:17:14.249	2025-11-29 13:17:26.829	t
3169	532	0	2025-11-29 13:17:43.814	\N	f
3170	532	5	2025-11-29 13:17:44.122	\N	f
3171	532	4	2025-11-29 13:17:44.122	\N	f
3172	532	3	2025-11-29 13:17:44.122	\N	f
3173	532	2	2025-11-29 13:17:44.122	\N	f
3174	532	1	2025-11-29 13:17:44.122	\N	f
3175	533	0	2025-11-29 13:17:51.659	\N	f
3176	533	1	2025-11-29 13:17:51.933	\N	f
3177	533	2	2025-11-29 13:17:51.933	\N	f
3178	533	3	2025-11-29 13:17:51.933	\N	f
3179	533	4	2025-11-29 13:17:51.933	\N	f
3180	533	5	2025-11-29 13:17:51.933	\N	f
3181	534	0	2025-11-29 13:18:03.831	\N	f
3182	534	1	2025-11-29 13:18:03.997	\N	f
3183	534	2	2025-11-29 13:18:03.997	\N	f
3184	534	3	2025-11-29 13:18:03.997	\N	f
3185	534	4	2025-11-29 13:18:03.997	\N	f
3186	534	5	2025-11-29 13:18:03.997	\N	f
3187	535	0	2025-11-29 13:18:39.551	\N	f
3188	535	5	2025-11-29 13:18:40.482	\N	f
3189	535	4	2025-11-29 13:18:40.482	\N	f
3190	535	3	2025-11-29 13:18:40.482	\N	f
3191	535	2	2025-11-29 13:18:40.482	\N	f
3192	535	1	2025-11-29 13:18:40.482	\N	f
3193	536	0	2025-11-29 13:18:45.304	\N	f
3194	536	5	2025-11-29 13:18:45.877	\N	f
3195	536	4	2025-11-29 13:18:45.877	\N	f
3196	536	3	2025-11-29 13:18:45.877	\N	f
3197	536	2	2025-11-29 13:18:45.877	\N	f
3198	536	1	2025-11-29 13:18:45.877	\N	f
3199	537	0	2025-11-29 13:18:54.314	\N	f
3200	537	5	2025-11-29 13:18:54.109	\N	f
3201	537	4	2025-11-29 13:18:54.109	\N	f
3202	537	3	2025-11-29 13:18:54.109	\N	f
3203	537	2	2025-11-29 13:18:54.109	\N	f
3204	537	1	2025-11-29 13:18:54.109	\N	f
3205	538	0	2025-11-29 13:19:05.988	\N	f
3206	538	5	2025-11-29 13:19:08.038	\N	f
3207	538	4	2025-11-29 13:19:08.038	\N	f
3208	538	3	2025-11-29 13:19:08.038	\N	f
3209	538	2	2025-11-29 13:19:08.038	\N	f
3210	538	1	2025-11-29 13:19:08.038	\N	f
3211	539	0	2025-11-29 13:19:09.485	\N	f
3212	539	5	2025-11-29 13:19:10.573	\N	f
3213	539	4	2025-11-29 13:19:10.573	\N	f
3214	539	3	2025-11-29 13:19:10.573	\N	f
3215	539	2	2025-11-29 13:19:10.573	\N	f
3216	539	1	2025-11-29 13:19:10.573	\N	f
3217	540	0	2025-11-29 13:19:28.56	\N	f
3218	540	5	2025-11-29 13:19:28.67	\N	f
3219	540	4	2025-11-29 13:19:28.67	\N	f
3220	540	3	2025-11-29 13:19:28.67	\N	f
3221	540	2	2025-11-29 13:19:28.67	\N	f
3222	540	1	2025-11-29 13:19:28.67	\N	f
3223	541	0	2025-11-29 13:19:28.414	\N	f
3224	541	5	2025-11-29 13:19:29.031	\N	f
3225	541	4	2025-11-29 13:19:29.031	\N	f
3226	541	3	2025-11-29 13:19:29.031	\N	f
3227	541	2	2025-11-29 13:19:29.031	\N	f
3228	541	1	2025-11-29 13:19:29.031	\N	f
3157	530	0	2025-11-29 13:17:16.587	2025-11-29 13:21:51.11	t
3152	529	1	2025-11-29 13:17:29.878	2025-11-29 13:25:07.701	t
3229	542	0	2025-11-29 13:19:50.724	2025-11-29 13:29:29.722	t
3373	567	0	2025-11-29 13:29:09.553	2025-11-29 13:31:38.855	t
3374	567	5	2025-11-29 13:31:50.459	2025-11-29 13:32:13.722	t
3163	531	0	2025-11-29 13:17:34.907	2025-11-29 13:32:24.551	t
3139	527	0	2025-11-29 13:17:03.55	2025-11-29 13:34:51.905	t
3375	567	4	2025-11-29 13:32:16.762	2025-11-29 13:38:25.681	t
3458	582	1	2025-11-29 13:40:31.359	\N	f
3459	582	2	2025-11-29 13:40:31.359	\N	f
3460	582	3	2025-11-29 13:40:31.359	\N	f
3461	582	4	2025-11-29 13:40:31.359	\N	f
3462	582	5	2025-11-29 13:40:31.359	\N	f
3451	581	0	2025-11-29 13:40:02.506	2025-11-29 13:47:21.651	t
3377	567	2	2025-11-29 13:40:51.426	2025-11-29 13:48:37.242	t
3457	582	0	2025-11-29 13:40:31.244	2025-11-29 13:48:55.658	t
3141	527	2	2025-11-29 13:46:38.135	2025-11-29 13:50:19.11	t
3378	567	1	2025-11-29 13:48:40.225	2025-11-29 13:51:43.535	t
3142	527	3	2025-11-29 13:50:29.578	2025-11-29 14:02:14.68	t
3164	531	1	2025-11-29 13:48:55.827	2025-11-29 14:04:54.574	t
3143	527	4	2025-11-29 14:02:18.559	2025-11-29 14:06:28.188	t
3453	581	4	2025-11-29 13:59:24.623	2025-11-29 14:08:51.526	t
3454	581	3	2025-11-29 14:08:57.768	2025-11-29 14:12:01.555	t
3456	581	1	2025-11-29 14:17:19.532	2025-11-29 14:20:08.687	t
3144	527	5	2025-11-29 14:06:34.93	2025-11-29 14:32:24.189	t
3165	531	2	2025-11-29 14:45:38.221	2025-11-29 14:45:44.645	t
3166	531	3	2025-11-29 17:43:20.276	2025-11-29 18:52:09.758	t
3168	531	5	2025-11-29 18:56:26.42	2025-11-29 19:11:17.848	t
3885	655	2	2025-11-29 16:56:58.414	\N	f
3886	655	3	2025-11-29 16:56:58.414	\N	f
3887	655	4	2025-11-29 16:56:58.414	\N	f
3888	655	5	2025-11-29 16:56:58.414	\N	f
3889	656	0	2025-11-29 16:57:38.598	2025-11-29 16:57:50.919	t
3890	656	1	2025-11-29 16:57:52.914	2025-11-29 16:58:00.775	t
3891	656	2	2025-11-29 16:58:02.441	2025-11-29 16:58:11.383	t
3892	656	3	2025-11-29 16:58:13.138	2025-11-29 16:58:19.955	t
3893	656	4	2025-11-29 16:58:22.264	2025-11-29 16:58:28.38	t
3894	656	5	2025-11-29 16:58:30.138	2025-11-29 16:58:36.343	t
3857	650	4	2025-11-29 16:56:42.115	2025-11-29 16:59:37.48	t
3872	653	5	2025-11-29 16:52:57.298	2025-11-29 17:00:35.072	t
3896	657	1	2025-11-29 17:00:56.973	\N	f
3897	657	2	2025-11-29 17:00:56.973	\N	f
3898	657	3	2025-11-29 17:00:56.973	\N	f
3899	657	4	2025-11-29 17:00:56.973	\N	f
3900	657	5	2025-11-29 17:00:56.973	\N	f
3895	657	0	2025-11-29 17:00:56.331	2025-11-29 17:02:40.701	t
3874	653	3	2025-11-29 17:04:00.461	2025-11-29 17:05:44.567	t
3901	658	0	2025-11-29 17:12:00.474	\N	f
3902	658	1	2025-11-29 17:11:59.542	\N	f
3903	658	2	2025-11-29 17:11:59.542	\N	f
3904	658	3	2025-11-29 17:11:59.542	\N	f
3905	658	4	2025-11-29 17:11:59.542	\N	f
3906	658	5	2025-11-29 17:11:59.542	\N	f
3907	659	0	2025-11-29 17:43:47.603	\N	f
3908	659	5	2025-11-29 17:43:47.779	\N	f
3909	659	4	2025-11-29 17:43:47.779	\N	f
3910	659	3	2025-11-29 17:43:47.779	\N	f
3911	659	2	2025-11-29 17:43:47.779	\N	f
3912	659	1	2025-11-29 17:43:47.779	\N	f
3913	660	0	2025-11-29 17:44:07.629	\N	f
3914	660	1	2025-11-29 17:44:08.079	\N	f
3915	660	2	2025-11-29 17:44:08.079	\N	f
3916	660	3	2025-11-29 17:44:08.079	\N	f
3917	660	4	2025-11-29 17:44:08.079	\N	f
3918	660	5	2025-11-29 17:44:08.079	\N	f
3919	661	0	2025-11-29 17:48:23.961	\N	f
3920	661	1	2025-11-29 17:48:28.061	\N	f
3921	661	2	2025-11-29 17:48:28.061	\N	f
3922	661	3	2025-11-29 17:48:28.061	\N	f
3923	661	4	2025-11-29 17:48:28.061	\N	f
3924	661	5	2025-11-29 17:48:28.061	\N	f
3881	654	4	2025-11-29 17:50:35.605	2025-11-29 17:54:21.212	t
3931	664	0	2025-11-29 17:54:42.867	\N	f
3932	664	1	2025-11-29 17:54:43.25	\N	f
3933	664	2	2025-11-29 17:54:43.25	\N	f
3934	664	3	2025-11-29 17:54:43.25	\N	f
3935	664	4	2025-11-29 17:54:43.25	\N	f
3936	664	5	2025-11-29 17:54:43.25	\N	f
3925	663	0	2025-11-29 17:50:43.932	2025-11-29 17:54:51.999	t
3869	652	2	2025-11-29 17:21:48.111	2025-11-29 17:59:38.652	t
3937	665	0	2025-11-29 17:57:26.086	2025-11-29 18:00:00.689	t
3938	665	1	2025-11-29 18:00:05.362	2025-11-29 18:05:30.109	t
3943	666	0	2025-11-29 18:09:18.948	2025-11-29 18:11:49.809	t
3926	663	1	2025-11-29 17:55:00.328	2025-11-29 18:18:35.298	t
3944	666	1	2025-11-29 18:11:52.92	2025-11-29 18:19:53.451	t
3945	666	2	2025-11-29 18:20:03.592	2025-11-29 18:21:52.646	t
3927	663	2	2025-11-29 18:18:44.729	2025-11-29 18:22:54.817	t
3939	665	2	2025-11-29 18:05:39.763	2025-11-29 18:24:40.398	t
3940	665	3	2025-11-29 18:27:08.552	2025-11-29 18:28:12.878	t
3941	665	4	2025-11-29 18:28:17.114	2025-11-29 18:29:52.179	t
3942	665	5	2025-11-29 18:30:09.714	2025-11-29 18:37:23.295	t
3928	663	3	2025-11-29 18:23:03.093	2025-11-29 18:45:03.079	t
3946	666	3	2025-11-29 18:21:54.589	2025-11-29 18:48:52.597	t
3947	666	4	2025-11-29 18:48:55.37	2025-11-29 18:50:16.136	t
3929	663	4	2025-11-29 18:45:10.738	2025-11-29 18:51:47.047	t
3167	531	4	2025-11-29 18:52:17.801	2025-11-29 18:56:05.206	t
3948	666	5	2025-11-29 18:50:18.049	2025-11-29 18:57:15.08	t
3930	663	5	2025-11-29 18:51:53.005	2025-11-29 19:04:24.85	t
3949	667	0	2025-11-29 18:59:58.872	2025-11-29 19:12:00.6	t
3955	668	0	2025-11-29 19:21:47.783	\N	f
3956	668	1	2025-11-29 19:21:59.024	\N	f
3957	668	2	2025-11-29 19:21:59.024	\N	f
3958	668	3	2025-11-29 19:21:59.024	\N	f
3959	668	4	2025-11-29 19:21:59.024	\N	f
3960	668	5	2025-11-29 19:21:59.024	\N	f
3950	667	1	2025-11-29 19:12:06.157	2025-11-29 19:24:56.201	t
3951	667	2	2025-11-29 19:25:03.929	2025-11-29 19:29:21.18	t
3961	669	0	2025-11-29 19:26:17.253	2025-11-29 19:29:26.956	t
3962	669	5	2025-11-29 19:29:32.479	2025-11-29 19:38:34.826	t
3973	671	0	2025-11-29 19:40:54.715	\N	f
3974	671	5	2025-11-29 19:40:53.977	\N	f
3975	671	4	2025-11-29 19:40:53.977	\N	f
3976	671	3	2025-11-29 19:40:53.977	\N	f
3977	671	2	2025-11-29 19:40:53.977	\N	f
3978	671	1	2025-11-29 19:40:53.977	\N	f
3963	669	4	2025-11-29 19:38:42.138	2025-11-29 19:45:20.99	t
3964	669	3	2025-11-29 19:45:32.976	2025-11-29 19:48:57.417	t
3952	667	3	2025-11-29 19:29:24.794	2025-11-29 19:50:38.525	t
3967	670	0	2025-11-29 19:38:11.545	2025-11-29 19:51:31.854	t
3965	669	2	2025-11-29 19:49:01.223	2025-11-29 19:54:33.621	t
3953	667	4	2025-11-29 19:50:42.928	2025-11-29 19:54:47.403	t
3979	672	0	2025-11-29 19:54:02.156	2025-11-29 19:55:50.807	t
3966	669	1	2025-11-29 19:54:37.721	2025-11-29 19:57:13.467	t
3968	670	5	2025-11-29 19:51:35.618	2025-11-29 20:01:17.536	t
3980	672	5	2025-11-29 19:55:56.17	2025-11-29 20:01:25.48	t
3954	667	5	2025-11-29 19:54:54.336	2025-11-29 20:03:14.057	t
1746	293	5	2025-11-29 12:28:16.089	2025-11-29 12:36:05.172	t
3981	672	4	2025-11-29 20:01:29.488	2025-11-29 20:05:40.663	t
3982	672	3	2025-11-29 20:05:48.554	2025-11-29 20:08:03.698	t
3992	674	5	2025-11-29 20:16:42.522	\N	f
3993	674	4	2025-11-29 20:16:42.522	\N	f
3994	674	3	2025-11-29 20:16:42.522	\N	f
3995	674	2	2025-11-29 20:16:42.522	\N	f
3996	674	1	2025-11-29 20:16:42.522	\N	f
3969	670	4	2025-11-29 20:01:20.211	2025-11-29 20:22:12.497	t
3985	673	0	2025-11-29 20:16:42.093	2025-11-29 20:24:10.006	t
3991	674	0	2025-11-29 20:16:42.39	2025-11-29 20:25:11.858	t
3970	670	3	2025-11-29 20:22:16.037	2025-11-29 20:28:46.206	t
3986	673	1	2025-11-29 20:24:20.435	2025-11-29 20:30:29.139	t
3983	672	2	2025-11-29 20:08:07.135	2025-11-29 20:36:01.71	t
3997	675	0	2025-11-29 20:37:06.474	2025-11-29 20:37:40.162	t
3984	672	1	2025-11-29 20:36:06.249	2025-11-29 20:38:43.978	t
3999	675	4	2025-11-29 20:42:46.823	2025-11-29 20:46:21.715	t
4000	675	3	2025-11-29 20:46:26.839	2025-11-29 20:48:03.812	t
4001	675	2	2025-11-29 20:48:06.155	2025-11-29 20:50:18.124	t
3971	670	2	2025-11-29 20:28:49.32	2025-11-29 20:53:46.048	t
3972	670	1	2025-11-29 20:53:51.467	2025-11-29 20:56:44.71	t
3988	673	3	2025-11-29 20:58:51.708	2025-11-29 21:17:35.905	t
3989	673	4	2025-11-29 21:17:40.724	2025-11-29 21:19:17.599	t
3990	673	5	2025-11-29 21:19:55.615	2025-11-29 21:20:15.516	t
4003	676	0	2025-11-29 20:38:03.628	\N	f
4004	676	1	2025-11-29 20:38:04.253	\N	f
4005	676	2	2025-11-29 20:38:04.253	\N	f
4006	676	3	2025-11-29 20:38:04.253	\N	f
4007	676	4	2025-11-29 20:38:04.253	\N	f
4008	676	5	2025-11-29 20:38:04.253	\N	f
3998	675	5	2025-11-29 20:37:42.765	2025-11-29 20:42:18.167	t
4002	675	1	2025-11-29 20:50:22.049	2025-11-29 20:51:19.733	t
3987	673	2	2025-11-29 20:30:32.826	2025-11-29 20:58:48.766	t
4009	677	0	2025-11-29 21:07:38.866	\N	f
4010	677	1	2025-11-29 21:07:39.094	\N	f
4011	677	2	2025-11-29 21:07:39.094	\N	f
4012	677	3	2025-11-29 21:07:39.094	\N	f
4013	677	4	2025-11-29 21:07:39.094	\N	f
4014	677	5	2025-11-29 21:07:39.094	\N	f
4015	678	0	2025-11-29 21:10:14.42	\N	f
4016	678	5	2025-11-29 21:10:14.906	\N	f
4017	678	4	2025-11-29 21:10:14.906	\N	f
4018	678	3	2025-11-29 21:10:14.906	\N	f
4019	678	2	2025-11-29 21:10:14.906	\N	f
4020	678	1	2025-11-29 21:10:14.906	\N	f
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
59544d92-7410-4804-b9a6-20017b6c8eb0	f028e7c5a5eece6ebb040c98205cf130212bba9736b2ffcedf815011880b24d6	2025-11-14 12:48:50.221278+00	20251114124759_init	\N	\N	2025-11-14 12:48:49.287282+00	1
c2f7feb6-d953-4e3d-b9f8-ad3b234cdef4	1b83305195f36924b209af7d5af2bad53a7416b756590357be7c6c360562cb04	2025-11-14 13:04:24.185446+00	20251114125656_added_hasfinished	\N	\N	2025-11-14 13:04:24.051303+00	1
23ca8023-8e5a-4fda-8f04-0db079f47961	7fec82dd642c892666a7034d61f814bdaac8b9fb88ebecefd98fae74c729fe51	2025-11-14 16:15:14.408861+00	20251114144841_add_duration	\N	\N	2025-11-14 16:15:14.106594+00	1
6722b2b9-30c0-41f0-9155-9c19eb9ced20	f0a73e8ee272cb4cb974f51833a0d9d9e53bf0f480e18dc0c1059fcdf9a15e0d	2025-11-20 21:13:39.511773+00	20251120200351_no_current_treasure	\N	\N	2025-11-20 21:13:39.423249+00	1
0240305c-83cc-4a82-b460-27f2caeb316f	0b9536778ce7c02d7710411e88fa612effdf9ac41a178df135f8aa7b77dac08c	2025-11-27 18:33:04.608393+00	20251127160531_add_game_config	\N	\N	2025-11-27 18:33:04.523408+00	1
4f28e5e5-20a8-42a9-9060-b0ae608a5a09	45892c4cb6c0f7d5fba74deb935a5f90daca70d3543c420baa77dead72d683d0	2025-11-27 20:16:17.179827+00	20251127183735_add_name_override	\N	\N	2025-11-27 20:16:17.097584+00	1
\.


--
-- Name: GameSession_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."GameSession_id_seq"', 678, true);


--
-- Name: Treasure_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."Treasure_id_seq"', 4020, true);


--
-- Name: GameConfig GameConfig_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."GameConfig"
    ADD CONSTRAINT "GameConfig_pkey" PRIMARY KEY (id);


--
-- Name: GameSession GameSession_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."GameSession"
    ADD CONSTRAINT "GameSession_pkey" PRIMARY KEY (id);


--
-- Name: Treasure Treasure_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Treasure"
    ADD CONSTRAINT "Treasure_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: GameSession_playerName_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "GameSession_playerName_key" ON public."GameSession" USING btree ("playerName");


--
-- Name: Treasure Treasure_gameSessionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Treasure"
    ADD CONSTRAINT "Treasure_gameSessionId_fkey" FOREIGN KEY ("gameSessionId") REFERENCES public."GameSession"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict Z2WvOWtjfudcZbcY0bob8Ltkvrkoz3CJs0gEsQNLkxOicgTMprMVdL78kCCYWvI

