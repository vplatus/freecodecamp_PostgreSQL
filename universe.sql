--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: constellation; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.constellation (
    constellation_id integer NOT NULL,
    name character varying(50),
    symbolism text,
    area integer NOT NULL,
    stars_with_planets integer NOT NULL
);


ALTER TABLE public.constellation OWNER TO freecodecamp;

--
-- Name: conctellation_constellation_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.conctellation_constellation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conctellation_constellation_id_seq OWNER TO freecodecamp;

--
-- Name: conctellation_constellation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.conctellation_constellation_id_seq OWNED BY public.constellation.constellation_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(50),
    size_kly integer NOT NULL,
    escape_velocity_km integer NOT NULL,
    distance_mly numeric(4,2),
    origin_of_name text,
    is_spiral boolean,
    more_than_100_billion_stars boolean
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(50),
    planet_id integer,
    dist_from_planet integer NOT NULL,
    diameter integer NOT NULL,
    semimajor_axis numeric(4,3),
    notes text,
    is_solar boolean,
    mass_than_earth boolean
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(50),
    star_id integer NOT NULL,
    planet_mass numeric(4,2),
    is_solar boolean
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(50),
    galaxy_id integer NOT NULL,
    star_mass numeric(5,2),
    is_milkyway boolean
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: constellation constellation_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.constellation ALTER COLUMN constellation_id SET DEFAULT nextval('public.conctellation_constellation_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: constellation; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.constellation VALUES (1, 'Leo', 'the Lion', 947, 13);
INSERT INTO public.constellation VALUES (2, 'Cancer', 'the Crab', 506, 10);
INSERT INTO public.constellation VALUES (3, 'Antlia', 'the Air Pump', 239, 2);
INSERT INTO public.constellation VALUES (4, 'Eridanus', 'the riveer Eridanus', 1138, 32);
INSERT INTO public.constellation VALUES (5, 'Hydra', 'the sea serpent', 1303, 18);
INSERT INTO public.constellation VALUES (6, 'Gemini', 'the Twins', 2514, 8);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Andromeda Galaxy', 220, 470, 2.45, 'Gets its name from the area of the sky in which it appears, the constellation of Andromeda', true, true);
INSERT INTO public.galaxy VALUES (2, 'Milky Way', 185, 550, 0.03, 'The appearance from Earth of the galaxy - a band of light', true, true);
INSERT INTO public.galaxy VALUES (3, 'Sculptor Galaxy', 90, 243, 11.40, 'NAmed after its location in the Sculptor Constellation. Also called the Silver Dollar or Silver Coin Galaxy because of its light and circular appearance', true, true);
INSERT INTO public.galaxy VALUES (4, 'Centaurus A', 60, 243, 13.70, 'Centaurus A has been spotted with the naked eye by Stephen James O''Meara.', false, true);
INSERT INTO public.galaxy VALUES (5, 'Bode''s Galaxy', 45, 73, 11.75, 'Named for Johann Elert Bode who discovered this galaxy in 1774.', true, true);
INSERT INTO public.galaxy VALUES (7, 'Fireworks Galaxy', 40, 48, 25.20, 'Due to its bright and spotty appearance.', false, false);
INSERT INTO public.galaxy VALUES (6, 'Circinus Galaxy', 2, 80, 12.45, 'Named after the constellation it is located in(Circinus)', false, false);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'J1407b1', 1, 800738000, 3010, 0.400, 'Possible exomoon residing in a large ring gap around J1407b.', false, false);
INSERT INTO public.moon VALUES (2, 'DH Tauri b1', 2, 66423005, 2500, 9.000, 'Candidate Jupiter-mass satellite from direct imaging.', false, true);
INSERT INTO public.moon VALUES (3, 'Kepler-409b1', 3, 78002589, 7, 0.222, 'Possible exomoon from transit timing variations, since deemed unlikely.', false, false);
INSERT INTO public.moon VALUES (4, 'Kepler-809b1', 4, 23649032, 10, 0.289, 'Possible exomoon from transit timing variations, since deemed unlikely.', false, true);
INSERT INTO public.moon VALUES (5, 'WASP-12b1', 5, 324478400, 8, 0.023, 'Found by studing periodic increases and decreases in light given off from WASP-12b.', false, false);
INSERT INTO public.moon VALUES (6, 'KOI-268.011', 6, 703057983, 900, 0.217, 'Possible exomoon.', false, false);
INSERT INTO public.moon VALUES (7, 'WASP-49b1', 7, 908804377, 15, 0.038, 'Exo-lo candidate.', false, false);
INSERT INTO public.moon VALUES (8, 'WASP-121b1', 8, 433802459, 9, 0.027, 'Exo-lo candidate.', false, false);
INSERT INTO public.moon VALUES (9, 'Atlas', 9, 137640, 37, 0.045, 'R.Terrile, 1980.', true, false);
INSERT INTO public.moon VALUES (10, 'Dione', 9, 377400, 1120, 0.500, 'G.Cassini, 1684.', true, false);
INSERT INTO public.moon VALUES (11, 'Eukelade', 10, 24557295, 4, 0.003, 'S.Sheppard et al, 2003.', true, false);
INSERT INTO public.moon VALUES (12, 'Europa', 10, 670900, 3126, 0.400, 'Galileo, 1610.', true, false);
INSERT INTO public.moon VALUES (13, 'Helike', 10, 10972830, 4, 0.223, 'S.Sheppard et al., 2003', true, false);
INSERT INTO public.moon VALUES (14, 'Metis', 10, 127960, 40, 0.250, 'S. Sunnott,, 1979.', true, false);
INSERT INTO public.moon VALUES (15, 'Io', 10, 421600, 3629, 0.550, 'Galileo, 1610', true, false);
INSERT INTO public.moon VALUES (16, 'Cordelia', 11, 49750, 26, 0.040, 'Voyager 2, 1986.', true, false);
INSERT INTO public.moon VALUES (17, 'Perdita', 11, 76420, 20, 0.034, 'E. Karkoschka, Voyager 2, 1986', true, false);
INSERT INTO public.moon VALUES (18, 'Psamathe', 12, 46738000, 38, 0.060, 'D. Jewitt et al.,, 2003.', true, false);
INSERT INTO public.moon VALUES (19, 'Triton', 12, 354800, 2705, 0.430, 'W. Lassel, 1846', true, false);
INSERT INTO public.moon VALUES (20, 'Galatea', 12, 52500, 140, 0.100, 'Voyager 2, 1989.', true, false);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'J1407b', 1, 15.00, false);
INSERT INTO public.planet VALUES (2, 'DH Tauri b', 2, 10.00, false);
INSERT INTO public.planet VALUES (3, 'Kepler-409b', 3, 1.00, false);
INSERT INTO public.planet VALUES (4, 'Kepler-809b', 4, 38.00, false);
INSERT INTO public.planet VALUES (5, 'WASP-12b', 5, 2.00, false);
INSERT INTO public.planet VALUES (6, 'KOI-268.01b', 6, 9.00, false);
INSERT INTO public.planet VALUES (7, 'WASP-49b', 7, 1.00, false);
INSERT INTO public.planet VALUES (8, 'WASP-121b', 8, 1.00, false);
INSERT INTO public.planet VALUES (9, 'Saturn', 9, 39.00, true);
INSERT INTO public.planet VALUES (10, 'Jupiter', 9, 99.00, true);
INSERT INTO public.planet VALUES (11, 'Uranus', 9, 14.54, true);
INSERT INTO public.planet VALUES (12, 'Neptune', 9, 17.15, true);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, '1SWASP J140747.93-394542.6', 7, 0.90, false);
INSERT INTO public.star VALUES (2, 'DH Tauri', 6, 0.41, false);
INSERT INTO public.star VALUES (3, 'Kepler-409', 6, 22.00, false);
INSERT INTO public.star VALUES (4, 'Kepler-809', 5, 9.32, false);
INSERT INTO public.star VALUES (5, 'WASP-12', 4, 1.43, false);
INSERT INTO public.star VALUES (6, 'KOI-268', 3, 1.00, false);
INSERT INTO public.star VALUES (7, 'WASP-49', 1, 0.72, false);
INSERT INTO public.star VALUES (8, 'WASP-121', 1, 1.35, false);
INSERT INTO public.star VALUES (9, 'SUN', 2, 1.98, true);


--
-- Name: conctellation_constellation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.conctellation_constellation_id_seq', 6, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 7, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 20, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 9, true);


--
-- Name: constellation conctellation_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.constellation
    ADD CONSTRAINT conctellation_name_key UNIQUE (name);


--
-- Name: constellation conctellation_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.constellation
    ADD CONSTRAINT conctellation_pkey PRIMARY KEY (constellation_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

