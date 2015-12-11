--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: counties; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE counties (
    id integer NOT NULL,
    state_id integer NOT NULL,
    county_name character varying NOT NULL
);


--
-- Name: epa_records; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE epa_records (
    id integer NOT NULL,
    cas_number character varying,
    reporting_year character varying,
    trifid character varying,
    facility_name character varying,
    facility_city character varying,
    facility_county character varying,
    facility_state character varying,
    facility_zip_code character varying,
    primary_naics_code character varying,
    latitude character varying,
    longitude character varying,
    parent_company_name character varying,
    chemical_name character varying,
    classification character varying,
    unit_of_measure character varying,
    produce_the_chemical character varying(3),
    import_the_chemical character varying(3),
    on_site_use character varying(3),
    sale_or_distribution character varying(3),
    as_a_byproduct character varying(3),
    as_a_manufactured_impurity character varying(3),
    as_a_reactant character varying(3),
    as_a_formulation_component character varying(3),
    as_an_article_component character varying(3),
    repackaging character varying(3),
    as_a_process_impurity character varying(3),
    as_a_chemical_processing_aid character varying(3),
    as_a_manufacturing_aid character varying(3),
    ancillary_or_other_use character varying(3),
    total_air_emissions character varying,
    total_underground_injection character varying,
    total_on_site_land_releases character varying,
    total_transferred_off_site_to_disposal character varying,
    document_control_number character varying,
    total_surface_water_discharge character varying,
    transfers_to_potws_metals_and_metal_compounds character varying,
    naics_2 character varying,
    naics_3 character varying,
    chemical character varying,
    cercla_chemicals character varying(3),
    haps character varying(3),
    metals_and_metal_compounds character varying(3),
    pbt_chemicals character varying(3),
    priority_chemicals character varying(3),
    osha_chemicals character varying(3),
    other_health_effects character varying(3),
    body_weight character varying(3),
    cardiovascular character varying(3),
    dermal character varying(3),
    developmental character varying(3),
    endocrine character varying(3),
    gastrointestinal character varying(3),
    hematological character varying(3),
    hepatic character varying(3),
    immunological character varying(3),
    metabolic character varying(3),
    musculoskeletal character varying(3),
    neurological character varying(3),
    ocular character varying(3),
    other_systemic character varying(3),
    renal character varying(3),
    reproductive character varying(3),
    respiratory character varying(3),
    human_health_effects_information_not_identified character varying(3),
    acute character varying(3),
    intermediate character varying(3),
    chronic character varying(3)
);


--
-- Name: epa_records_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE epa_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: epa_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE epa_records_id_seq OWNED BY epa_records.id;


--
-- Name: geo_json; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE geo_json (
    id integer NOT NULL,
    state_id integer NOT NULL,
    county_id integer NOT NULL,
    geo_object jsonb NOT NULL
);


--
-- Name: geo_json_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE geo_json_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_json_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE geo_json_id_seq OWNED BY geo_json.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: states; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE states (
    id integer NOT NULL,
    state_name character varying NOT NULL,
    abbreviation character varying(2) NOT NULL
);


--
-- Name: states_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE states_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE states_id_seq OWNED BY states.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY epa_records ALTER COLUMN id SET DEFAULT nextval('epa_records_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY geo_json ALTER COLUMN id SET DEFAULT nextval('geo_json_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY states ALTER COLUMN id SET DEFAULT nextval('states_id_seq'::regclass);


--
-- Name: counties_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY counties
    ADD CONSTRAINT counties_pkey PRIMARY KEY (id, state_id);


--
-- Name: epa_records_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY epa_records
    ADD CONSTRAINT epa_records_pkey PRIMARY KEY (id);


--
-- Name: geo_json_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY geo_json
    ADD CONSTRAINT geo_json_pkey PRIMARY KEY (id);


--
-- Name: states_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY states
    ADD CONSTRAINT states_pkey PRIMARY KEY (id);


--
-- Name: index_counties_on_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_counties_on_id ON counties USING btree (id);


--
-- Name: index_counties_on_id_and_state_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_counties_on_id_and_state_id ON counties USING btree (id, state_id);


--
-- Name: index_counties_on_state_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_counties_on_state_id ON counties USING btree (state_id);


--
-- Name: index_geo_json_on_county_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_geo_json_on_county_id ON geo_json USING btree (county_id);


--
-- Name: index_geo_json_on_geometry; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_geo_json_on_geometry ON geo_json USING gin (((geo_object -> 'geometry'::text)));


--
-- Name: index_geo_json_on_state_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_geo_json_on_state_id ON geo_json USING btree (state_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: fk_counties_county_state_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY geo_json
    ADD CONSTRAINT fk_counties_county_state_id FOREIGN KEY (county_id, state_id) REFERENCES counties(id, state_id);


--
-- Name: fk_rails_028abb0ec1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY counties
    ADD CONSTRAINT fk_rails_028abb0ec1 FOREIGN KEY (state_id) REFERENCES states(id);


--
-- Name: fk_rails_24e43d5cb4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY geo_json
    ADD CONSTRAINT fk_rails_24e43d5cb4 FOREIGN KEY (state_id) REFERENCES states(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20151209162931');

INSERT INTO schema_migrations (version) VALUES ('20151210204253');

INSERT INTO schema_migrations (version) VALUES ('20151210214409');

INSERT INTO schema_migrations (version) VALUES ('20151210232050');

