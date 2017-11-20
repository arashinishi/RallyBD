--
-- PostgreSQL database dump
--

-- Dumped from database version 10.0
-- Dumped by pg_dump version 10.0

-- Started on 2017-11-06 11:47:20

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 7 (class 2615 OID 32964)
-- Name: rally; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA rally;


ALTER SCHEMA rally OWNER TO postgres;

--
-- TOC entry 1 (class 3079 OID 12924)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2991 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = rally, pg_catalog;


--
-- TOC entry 613 (class 1247 OID 32984)
-- Name: positivo; Type: DOMAIN; Schema: rally; Owner: postgres
--

CREATE DOMAIN positivo AS integer
	CONSTRAINT checkpositivo CHECK ((VALUE >= 0));


ALTER DOMAIN positivo OWNER TO postgres;

--
-- TOC entry 524 (class 1247 OID 32965)
-- Name: rut; Type: DOMAIN; Schema: rally; Owner: postgres
--

CREATE DOMAIN rut AS text
	CONSTRAINT checkrut CHECK ((VALUE ~ '^[0-9]{1,3}[.][0-9]{3}[.][0-9]{3}[-][0-9]$'::text));


ALTER DOMAIN rut OWNER TO postgres;

--
-- TOC entry 605 (class 1247 OID 32972)
-- Name: terreno; Type: DOMAIN; Schema: rally; Owner: postgres
--

CREATE DOMAIN terreno AS text
	CONSTRAINT "checkTerreno" CHECK ((VALUE = ANY (ARRAY['nieve'::text, 'hielo'::text, 'tierra'::text, 'gravilla'::text, 'barro'::text, 'asfalto'::text])));


ALTER DOMAIN terreno OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 206 (class 1259 OID 33171)
-- Name: auspicia_equipo; Type: TABLE; Schema: rally; Owner: postgres
--

CREATE TABLE auspicia_equipo (
    "nombreEquipo" text NOT NULL,
    "nombrePatrocinador" text NOT NULL,
    monto positivo DEFAULT 0 NOT NULL
);


ALTER TABLE auspicia_equipo OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 33242)
-- Name: auspicia_i_torneo; Type: TABLE; Schema: rally; Owner: postgres
--

CREATE TABLE auspicia_i_torneo (
    "nombrePatrocinador" text NOT NULL,
    id_i_torneo positivo NOT NULL,
    monto positivo DEFAULT 0 NOT NULL
);


ALTER TABLE auspicia_i_torneo OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 33082)
-- Name: automovil; Type: TABLE; Schema: rally; Owner: postgres
--

CREATE TABLE automovil (
    matricula text NOT NULL,
    modelo text NOT NULL
);


ALTER TABLE automovil OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 33199)
-- Name: carrera; Type: TABLE; Schema: rally; Owner: postgres
--

CREATE TABLE carrera (
    ubicacion text NOT NULL,
    terreno terreno NOT NULL
);


ALTER TABLE carrera OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 32976)
-- Name: competidor; Type: TABLE; Schema: rally; Owner: postgres
--

CREATE TABLE competidor (
    rut rut NOT NULL,
    nacionalidad text NOT NULL,
    nombres text NOT NULL,
    "apPaterno" text NOT NULL,
    "apMaterno" text NOT NULL,
    "nombreEquipo" text NOT NULL
);


ALTER TABLE competidor OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 33056)
-- Name: copiloto; Type: TABLE; Schema: rally; Owner: postgres
--

CREATE TABLE copiloto (
    "rutCompetidor" rut NOT NULL
);


ALTER TABLE copiloto OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 33298)
-- Name: corre_i_automovil; Type: TABLE; Schema: rally; Owner: postgres
--

CREATE TABLE corre_i_automovil (
    id_i_automovil positivo NOT NULL,
    id_i_carrera positivo NOT NULL,
    "tiempoResultado" time without time zone
);


ALTER TABLE corre_i_automovil OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 32986)
-- Name: equipo; Type: TABLE; Schema: rally; Owner: postgres
--

CREATE TABLE equipo (
    nombre text NOT NULL,
    "numPilotos" positivo DEFAULT 0 NOT NULL,
    "numCopilotos" positivo DEFAULT 0 NOT NULL
);


ALTER TABLE equipo OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 33095)
-- Name: equipo_automovil; Type: TABLE; Schema: rally; Owner: postgres
--

CREATE TABLE equipo_automovil (
    "matriculaAutomovil" text NOT NULL,
    "nombreEquipo" text NOT NULL
);


ALTER TABLE equipo_automovil OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 33113)
-- Name: i_automovil; Type: TABLE; Schema: rally; Owner: postgres
--

CREATE TABLE i_automovil (
    id positivo NOT NULL,
    "matriculaAutomovil" text NOT NULL,
    cilindrada positivo NOT NULL,
    "rutPiloto" rut NOT NULL,
    "rutCopiloto" rut NOT NULL
);


ALTER TABLE i_automovil OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 33223)
-- Name: i_carrera; Type: TABLE; Schema: rally; Owner: postgres
--

CREATE TABLE i_carrera (
    id positivo NOT NULL,
    "ubicacionCarrera" text NOT NULL,
    "fecComp" date NOT NULL,
    "cilindradaMin" positivo DEFAULT 0 NOT NULL,
    "cilindradaMax" positivo NOT NULL,
    "id_i_Torneo" positivo NOT NULL,
    CONSTRAINT i_carrera_check CHECK ((("cilindradaMin")::integer <= ("cilindradaMax")::integer))
);


ALTER TABLE i_carrera OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 33211)
-- Name: i_torneo; Type: TABLE; Schema: rally; Owner: postgres
--

CREATE TABLE i_torneo (
    id positivo NOT NULL,
    "idTorneo" positivo NOT NULL,
    "fecInicio" date NOT NULL,
    "fecTermino" date NOT NULL,
    "costoIngreso" positivo DEFAULT 0 NOT NULL,
    "cantCarreras" positivo DEFAULT 0 NOT NULL
);


ALTER TABLE i_torneo OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 33042)
-- Name: modelo_marca; Type: TABLE; Schema: rally; Owner: postgres
--

CREATE TABLE modelo_marca (
    modelo text NOT NULL,
    marca text NOT NULL
);


ALTER TABLE modelo_marca OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 33261)
-- Name: participa_equipo; Type: TABLE; Schema: rally; Owner: postgres
--

CREATE TABLE participa_equipo (
    "nombreEquipo" text NOT NULL,
    id_i_torneo positivo NOT NULL
);


ALTER TABLE participa_equipo OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 33136)
-- Name: patrocinador; Type: TABLE; Schema: rally; Owner: postgres
--

CREATE TABLE patrocinador (
    nombre text NOT NULL,
    nacionalidad text
);


ALTER TABLE patrocinador OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 33158)
-- Name: patrocinador_direccion; Type: TABLE; Schema: rally; Owner: postgres
--

CREATE TABLE patrocinador_direccion (
    "nombrePatrocinador" text NOT NULL,
    direccion text NOT NULL
);


ALTER TABLE patrocinador_direccion OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 33021)
-- Name: piloto; Type: TABLE; Schema: rally; Owner: postgres
--

CREATE TABLE piloto (
    "rutCompetidor" rut NOT NULL
);


ALTER TABLE piloto OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 33313)
-- Name: resultado; Type: TABLE; Schema: rally; Owner: postgres
--

CREATE TABLE resultado (
    tiempo time without time zone NOT NULL,
    puntaje integer NOT NULL
);


ALTER TABLE resultado OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 33190)
-- Name: torneo; Type: TABLE; Schema: rally; Owner: postgres
--

CREATE TABLE torneo (
    id positivo NOT NULL,
    nombre text NOT NULL,
    "cilindradaMin" positivo DEFAULT 0 NOT NULL,
    "cilindradaMax" positivo NOT NULL,
    CONSTRAINT torneo_check CHECK ((("cilindradaMin")::integer <= ("cilindradaMax")::integer))
);


ALTER TABLE torneo OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 33279)
-- Name: torneo_carrera; Type: TABLE; Schema: rally; Owner: postgres
--

CREATE TABLE torneo_carrera (
    "idTorneo" positivo NOT NULL,
    "ubicacionCarrera" text NOT NULL
);


ALTER TABLE torneo_carrera OWNER TO postgres;




--
-- TOC entry 2801 (class 2606 OID 33179)
-- Name: auspicia_equipo auspicia_equipo_pkey; Type: CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY auspicia_equipo
    ADD CONSTRAINT auspicia_equipo_pkey PRIMARY KEY ("nombreEquipo", "nombrePatrocinador");


--
-- TOC entry 2811 (class 2606 OID 33250)
-- Name: auspicia_i_torneo auspicia_i_torneo_pkey; Type: CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY auspicia_i_torneo
    ADD CONSTRAINT auspicia_i_torneo_pkey PRIMARY KEY (id_i_torneo, "nombrePatrocinador");


--
-- TOC entry 2791 (class 2606 OID 33089)
-- Name: automovil automovil_pkey; Type: CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY automovil
    ADD CONSTRAINT automovil_pkey PRIMARY KEY (matricula);


--
-- TOC entry 2805 (class 2606 OID 33206)
-- Name: carrera carrera_pkey; Type: CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY carrera
    ADD CONSTRAINT carrera_pkey PRIMARY KEY (ubicacion);


--
-- TOC entry 2780 (class 2606 OID 32983)
-- Name: competidor competidor_pkey; Type: CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY competidor
    ADD CONSTRAINT competidor_pkey PRIMARY KEY (rut);


--
-- TOC entry 2789 (class 2606 OID 33063)
-- Name: copiloto copiloto_pkey; Type: CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY copiloto
    ADD CONSTRAINT copiloto_pkey PRIMARY KEY ("rutCompetidor");


--
-- TOC entry 2817 (class 2606 OID 33302)
-- Name: corre_i_automovil corre_i_automovil_pkey; Type: CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY corre_i_automovil
    ADD CONSTRAINT corre_i_automovil_pkey PRIMARY KEY (id_i_automovil, id_i_carrera);


--
-- TOC entry 2793 (class 2606 OID 33102)
-- Name: equipo_automovil equipo_automovil_pkey; Type: CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY equipo_automovil
    ADD CONSTRAINT equipo_automovil_pkey PRIMARY KEY ("matriculaAutomovil");


--
-- TOC entry 2783 (class 2606 OID 32995)
-- Name: equipo equipo_pkey; Type: CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY equipo
    ADD CONSTRAINT equipo_pkey PRIMARY KEY (nombre);


--
-- TOC entry 2795 (class 2606 OID 33120)
-- Name: i_automovil i_automovil_pkey; Type: CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY i_automovil
    ADD CONSTRAINT i_automovil_pkey PRIMARY KEY (id);


--
-- TOC entry 2809 (class 2606 OID 33231)
-- Name: i_carrera i_carrera_pkey; Type: CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY i_carrera
    ADD CONSTRAINT i_carrera_pkey PRIMARY KEY (id);


--
-- TOC entry 2807 (class 2606 OID 33217)
-- Name: i_torneo i_torneo_pkey; Type: CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY i_torneo
    ADD CONSTRAINT i_torneo_pkey PRIMARY KEY (id);


--
-- TOC entry 2787 (class 2606 OID 33049)
-- Name: modelo_marca modelo_marca_pkey; Type: CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY modelo_marca
    ADD CONSTRAINT modelo_marca_pkey PRIMARY KEY (modelo);


--
-- TOC entry 2813 (class 2606 OID 33268)
-- Name: participa_equipo participa_equipo_pkey; Type: CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY participa_equipo
    ADD CONSTRAINT participa_equipo_pkey PRIMARY KEY ("nombreEquipo", id_i_torneo);


--
-- TOC entry 2799 (class 2606 OID 33165)
-- Name: patrocinador_direccion patrocinador_direccion_pkey; Type: CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY patrocinador_direccion
    ADD CONSTRAINT patrocinador_direccion_pkey PRIMARY KEY ("nombrePatrocinador", direccion);


--
-- TOC entry 2797 (class 2606 OID 33143)
-- Name: patrocinador patrocinador_pkey; Type: CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY patrocinador
    ADD CONSTRAINT patrocinador_pkey PRIMARY KEY (nombre);


--
-- TOC entry 2785 (class 2606 OID 33028)
-- Name: piloto piloto_pkey; Type: CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY piloto
    ADD CONSTRAINT piloto_pkey PRIMARY KEY ("rutCompetidor");


--
-- TOC entry 2820 (class 2606 OID 33317)
-- Name: resultado resultado_pkey; Type: CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY resultado
    ADD CONSTRAINT resultado_pkey PRIMARY KEY (tiempo);


--
-- TOC entry 2815 (class 2606 OID 33286)
-- Name: torneo_carrera torneo_carrera_pkey; Type: CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY torneo_carrera
    ADD CONSTRAINT torneo_carrera_pkey PRIMARY KEY ("idTorneo", "ubicacionCarrera");


--
-- TOC entry 2803 (class 2606 OID 33198)
-- Name: torneo torneo_pkey; Type: CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY torneo
    ADD CONSTRAINT torneo_pkey PRIMARY KEY (id);


--
-- TOC entry 2781 (class 1259 OID 33001)
-- Name: fki_refEquipo; Type: INDEX; Schema: rally; Owner: postgres
--

CREATE INDEX "fki_refEquipo" ON competidor USING btree ("nombreEquipo");


--
-- TOC entry 2818 (class 1259 OID 33323)
-- Name: fki_ref_resultado; Type: INDEX; Schema: rally; Owner: postgres
--

CREATE INDEX fki_ref_resultado ON corre_i_automovil USING btree ("tiempoResultado");


--
-- TOC entry 2831 (class 2606 OID 33180)
-- Name: auspicia_equipo auspicia_equipo_nombreEquipo_fkey; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY auspicia_equipo
    ADD CONSTRAINT "auspicia_equipo_nombreEquipo_fkey" FOREIGN KEY ("nombreEquipo") REFERENCES equipo(nombre) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2832 (class 2606 OID 33185)
-- Name: auspicia_equipo auspicia_equipo_nombrePatrocinador_fkey; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY auspicia_equipo
    ADD CONSTRAINT "auspicia_equipo_nombrePatrocinador_fkey" FOREIGN KEY ("nombrePatrocinador") REFERENCES patrocinador(nombre) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2837 (class 2606 OID 33256)
-- Name: auspicia_i_torneo auspicia_i_torneo_id_i_torneo_fkey; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY auspicia_i_torneo
    ADD CONSTRAINT auspicia_i_torneo_id_i_torneo_fkey FOREIGN KEY (id_i_torneo) REFERENCES i_torneo(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2836 (class 2606 OID 33251)
-- Name: auspicia_i_torneo auspicia_i_torneo_nombrePatrocinador_fkey; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY auspicia_i_torneo
    ADD CONSTRAINT "auspicia_i_torneo_nombrePatrocinador_fkey" FOREIGN KEY ("nombrePatrocinador") REFERENCES patrocinador(nombre) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2824 (class 2606 OID 33090)
-- Name: automovil automovil_modelo_fkey; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY automovil
    ADD CONSTRAINT automovil_modelo_fkey FOREIGN KEY (modelo) REFERENCES modelo_marca(modelo) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2842 (class 2606 OID 33303)
-- Name: corre_i_automovil corre_i_automovil_id_i_automovil_fkey; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY corre_i_automovil
    ADD CONSTRAINT corre_i_automovil_id_i_automovil_fkey FOREIGN KEY (id_i_automovil) REFERENCES i_automovil(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2843 (class 2606 OID 33308)
-- Name: corre_i_automovil corre_i_automovil_id_i_carrera_fkey; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY corre_i_automovil
    ADD CONSTRAINT corre_i_automovil_id_i_carrera_fkey FOREIGN KEY (id_i_carrera) REFERENCES i_carrera(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2825 (class 2606 OID 33103)
-- Name: equipo_automovil equipo_automovil_matriculaAutomovil_fkey; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY equipo_automovil
    ADD CONSTRAINT "equipo_automovil_matriculaAutomovil_fkey" FOREIGN KEY ("matriculaAutomovil") REFERENCES automovil(matricula) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2826 (class 2606 OID 33108)
-- Name: equipo_automovil equipo_automovil_nombreEquipo_fkey; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY equipo_automovil
    ADD CONSTRAINT "equipo_automovil_nombreEquipo_fkey" FOREIGN KEY ("nombreEquipo") REFERENCES equipo(nombre) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2827 (class 2606 OID 33121)
-- Name: i_automovil i_automovil_matriculaAutomovil_fkey; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY i_automovil
    ADD CONSTRAINT "i_automovil_matriculaAutomovil_fkey" FOREIGN KEY ("matriculaAutomovil") REFERENCES automovil(matricula) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2829 (class 2606 OID 33131)
-- Name: i_automovil i_automovil_rutCopiloto_fkey; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY i_automovil
    ADD CONSTRAINT "i_automovil_rutCopiloto_fkey" FOREIGN KEY ("rutCopiloto") REFERENCES copiloto("rutCompetidor") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2828 (class 2606 OID 33126)
-- Name: i_automovil i_automovil_rutPiloto_fkey; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY i_automovil
    ADD CONSTRAINT "i_automovil_rutPiloto_fkey" FOREIGN KEY ("rutPiloto") REFERENCES piloto("rutCompetidor") ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2835 (class 2606 OID 33237)
-- Name: i_carrera i_carrera_id_i_Torneo_fkey; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY i_carrera
    ADD CONSTRAINT "i_carrera_id_i_Torneo_fkey" FOREIGN KEY ("id_i_Torneo") REFERENCES i_torneo(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2834 (class 2606 OID 33232)
-- Name: i_carrera i_carrera_ubicacionCarrera_fkey; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY i_carrera
    ADD CONSTRAINT "i_carrera_ubicacionCarrera_fkey" FOREIGN KEY ("ubicacionCarrera") REFERENCES carrera(ubicacion) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2833 (class 2606 OID 33218)
-- Name: i_torneo i_torneo_idTorneo_fkey; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY i_torneo
    ADD CONSTRAINT "i_torneo_idTorneo_fkey" FOREIGN KEY ("idTorneo") REFERENCES torneo(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2839 (class 2606 OID 33274)
-- Name: participa_equipo participa_equipo_id_i_torneo_fkey; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY participa_equipo
    ADD CONSTRAINT participa_equipo_id_i_torneo_fkey FOREIGN KEY (id_i_torneo) REFERENCES i_torneo(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2838 (class 2606 OID 33269)
-- Name: participa_equipo participa_equipo_nombreEquipo_fkey; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY participa_equipo
    ADD CONSTRAINT "participa_equipo_nombreEquipo_fkey" FOREIGN KEY ("nombreEquipo") REFERENCES equipo(nombre) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2830 (class 2606 OID 33166)
-- Name: patrocinador_direccion patrocinador_direccion_nombrePatrocinador_fkey; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY patrocinador_direccion
    ADD CONSTRAINT "patrocinador_direccion_nombrePatrocinador_fkey" FOREIGN KEY ("nombrePatrocinador") REFERENCES patrocinador(nombre) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2822 (class 2606 OID 33029)
-- Name: piloto refCompetidor; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY piloto
    ADD CONSTRAINT "refCompetidor" FOREIGN KEY ("rutCompetidor") REFERENCES competidor(rut) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2823 (class 2606 OID 33064)
-- Name: copiloto refCompetidor; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY copiloto
    ADD CONSTRAINT "refCompetidor" FOREIGN KEY ("rutCompetidor") REFERENCES competidor(rut) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2821 (class 2606 OID 32996)
-- Name: competidor refEquipo; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY competidor
    ADD CONSTRAINT "refEquipo" FOREIGN KEY ("nombreEquipo") REFERENCES equipo(nombre) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2844 (class 2606 OID 33318)
-- Name: corre_i_automovil ref_resultado; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY corre_i_automovil
    ADD CONSTRAINT ref_resultado FOREIGN KEY ("tiempoResultado") REFERENCES resultado(tiempo) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2840 (class 2606 OID 33287)
-- Name: torneo_carrera torneo_carrera_idTorneo_fkey; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY torneo_carrera
    ADD CONSTRAINT "torneo_carrera_idTorneo_fkey" FOREIGN KEY ("idTorneo") REFERENCES torneo(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 2841 (class 2606 OID 33292)
-- Name: torneo_carrera torneo_carrera_ubicacionCarrera_fkey; Type: FK CONSTRAINT; Schema: rally; Owner: postgres
--

ALTER TABLE ONLY torneo_carrera
    ADD CONSTRAINT "torneo_carrera_ubicacionCarrera_fkey" FOREIGN KEY ("ubicacionCarrera") REFERENCES carrera(ubicacion) ON UPDATE RESTRICT ON DELETE RESTRICT;


-- Completed on 2017-11-06 11:47:21

--
-- PostgreSQL database dump complete
--

