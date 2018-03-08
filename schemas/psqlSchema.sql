--
-- PostgreSQL database dump
--

-- Dumped from database version 10.1
-- Dumped by pg_dump version 10.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: analyzers; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE analyzers (
    id integer NOT NULL,
    name character varying(254) NOT NULL,
    description character varying(254)
);


ALTER TABLE analyzers OWNER TO root;

--
-- Name: analyzers_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE analyzers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE analyzers_id_seq OWNER TO root;

--
-- Name: analyzers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE analyzers_id_seq OWNED BY analyzers.id;


--
-- Name: auth_token_info; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE auth_token_info (
    user_session_key character varying(254) NOT NULL,
    last_used_at bigint NOT NULL,
    user_data character varying(254) NOT NULL
);


ALTER TABLE auth_token_info OWNER TO root;

--
-- Name: aws_credentials; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE aws_credentials (
    "user" character varying(254) NOT NULL,
    access_key character varying(254) NOT NULL,
    secret_key character varying(254) NOT NULL
);


ALTER TABLE aws_credentials OWNER TO root;

--
-- Name: behaviours; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE behaviours (
    behaviour_id integer NOT NULL,
    behaviour_name character varying(254) NOT NULL,
    parent_behaviour_id integer
);


ALTER TABLE behaviours OWNER TO root;

--
-- Name: behaviours_behaviour_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE behaviours_behaviour_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE behaviours_behaviour_id_seq OWNER TO root;

--
-- Name: behaviours_behaviour_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE behaviours_behaviour_id_seq OWNED BY behaviours.behaviour_id;


--
-- Name: data_extraction_jobs; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE data_extraction_jobs (
    id integer NOT NULL,
    product_id integer NOT NULL,
    ext_src_id integer NOT NULL,
    job_status character varying(254) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    job_start_time timestamp without time zone,
    job_end_time timestamp without time zone,
    error_message text,
    spark_app_id character varying(254),
    output_location character varying(512),
    input_location character varying(512) NOT NULL,
    spark_submission_id character varying(254),
    pipeline_id integer,
    metadata character varying(254)
);


ALTER TABLE data_extraction_jobs OWNER TO root;

--
-- Name: data_extraction_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE data_extraction_jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE data_extraction_jobs_id_seq OWNER TO root;

--
-- Name: data_extraction_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE data_extraction_jobs_id_seq OWNED BY data_extraction_jobs.id;


--
-- Name: data_marts; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE data_marts (
    data_mart_id integer NOT NULL,
    data_mart_name character varying(254) NOT NULL,
    product_id integer NOT NULL,
    description character varying(254),
    grouping_key character varying(254),
    is_active integer DEFAULT 1 NOT NULL
);


ALTER TABLE data_marts OWNER TO root;

--
-- Name: data_marts_data_mart_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE data_marts_data_mart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE data_marts_data_mart_id_seq OWNER TO root;

--
-- Name: data_marts_data_mart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE data_marts_data_mart_id_seq OWNED BY data_marts.data_mart_id;


--
-- Name: dataset_jobs; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE dataset_jobs (
    id integer NOT NULL,
    name character varying(254) NOT NULL,
    location character varying(254) NOT NULL,
    product_id integer NOT NULL,
    folder_data text NOT NULL,
    schema_status character varying(254) NOT NULL,
    summary_status character varying(254) NOT NULL,
    schema text,
    meta_location character varying(254),
    header character varying(254),
    delimiter character varying(254),
    transformation_job_id integer,
    prediction_job_id integer,
    model_job_id integer,
    job_start_time timestamp without time zone,
    job_end_time timestamp without time zone,
    schema_error_message text,
    summary_error_message text,
    spark_submission_id character varying(254),
    spark_app_id character varying(254),
    feed_id integer,
    feed_time bigint
);


ALTER TABLE dataset_jobs OWNER TO root;

--
-- Name: dataset_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE dataset_jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dataset_jobs_id_seq OWNER TO root;

--
-- Name: dataset_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE dataset_jobs_id_seq OWNED BY dataset_jobs.id;


--
-- Name: dataset_types; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE dataset_types (
    dataset_id integer NOT NULL,
    dataset_type character varying(254) NOT NULL
);


ALTER TABLE dataset_types OWNER TO root;

--
-- Name: datasets; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE datasets (
    id integer NOT NULL,
    name character varying(254) NOT NULL,
    is_db integer NOT NULL,
    db_credentials character varying(254),
    last_time timestamp without time zone
);


ALTER TABLE datasets OWNER TO root;

--
-- Name: datasets_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE datasets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE datasets_id_seq OWNER TO root;

--
-- Name: datasets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE datasets_id_seq OWNED BY datasets.id;


--
-- Name: ext_data_srcs; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE ext_data_srcs (
    id integer NOT NULL,
    name character varying(254) NOT NULL,
    product_id integer NOT NULL,
    src_uri character varying(254) NOT NULL,
    src_type character varying(254) NOT NULL,
    delimiter character varying(254) NOT NULL,
    access_key character varying(254),
    secret_key character varying(254),
    target_uri character varying(254),
    last_read timestamp without time zone,
    feed_name character varying(254)
);


ALTER TABLE ext_data_srcs OWNER TO root;

--
-- Name: ext_data_srcs_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE ext_data_srcs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE ext_data_srcs_id_seq OWNER TO root;

--
-- Name: ext_data_srcs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE ext_data_srcs_id_seq OWNED BY ext_data_srcs.id;


--
-- Name: jobserver_product; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE jobserver_product (
    job_id character varying(254) NOT NULL,
    product_id integer NOT NULL
);


ALTER TABLE jobserver_product OWNER TO root;

--
-- Name: models_meta_data; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE models_meta_data (
    id integer NOT NULL,
    job_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    data text
);


ALTER TABLE models_meta_data OWNER TO root;

--
-- Name: models_meta_data_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE models_meta_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE models_meta_data_id_seq OWNER TO root;

--
-- Name: models_meta_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE models_meta_data_id_seq OWNED BY models_meta_data.id;


--
-- Name: org_resources; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE org_resources (
    id integer NOT NULL,
    org_id integer NOT NULL,
    subsc_type character varying(254) NOT NULL,
    master_private_ip character varying(254),
    master_public_ip character varying(254),
    aws_cf_stack_id character varying(254),
    is_analyzer_active integer DEFAULT 0 NOT NULL,
    last_submission_id character varying(254),
    last_status_message character varying(254),
    is_manual_controlled integer,
    partitions character varying(254),
    spark_server_ips character varying(254),
    driver_jvm character varying(254),
    worker_count integer,
    spark_start_time timestamp without time zone,
    spark_up_time integer
);


ALTER TABLE org_resources OWNER TO root;

--
-- Name: org_resources_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE org_resources_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE org_resources_id_seq OWNER TO root;

--
-- Name: org_resources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE org_resources_id_seq OWNED BY org_resources.id;


--
-- Name: org_users; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE org_users (
    org_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE org_users OWNER TO root;

--
-- Name: orgs; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE orgs (
    org_id integer NOT NULL,
    org_name character varying(254) NOT NULL,
    url character varying(254) NOT NULL,
    "desc" character varying(254) NOT NULL,
    address character varying(254) NOT NULL,
    logo character varying(254),
    phone character varying(254),
    contact character varying(254)
);


ALTER TABLE orgs OWNER TO root;

--
-- Name: orgs_org_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE orgs_org_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE orgs_org_id_seq OWNER TO root;

--
-- Name: orgs_org_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE orgs_org_id_seq OWNED BY orgs.org_id;


--
-- Name: pipeline_instances; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE pipeline_instances (
    id integer NOT NULL,
    pipeline_id integer NOT NULL,
    status character varying(254) NOT NULL,
    executed_jobs character varying(254) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    external_inputs text NOT NULL,
    self_learning_du integer,
    retry_count integer,
    is_active boolean
);


ALTER TABLE pipeline_instances OWNER TO root;

--
-- Name: pipeline_instances_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE pipeline_instances_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pipeline_instances_id_seq OWNER TO root;

--
-- Name: pipeline_instances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE pipeline_instances_id_seq OWNED BY pipeline_instances.id;


--
-- Name: pipeline_jobs; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE pipeline_jobs (
    id integer NOT NULL,
    product_id integer NOT NULL,
    name character varying(254) NOT NULL,
    jobs text NOT NULL,
    inputs text NOT NULL,
    status character varying(254) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    days_to_persist integer
);


ALTER TABLE pipeline_jobs OWNER TO root;

--
-- Name: pipeline_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE pipeline_jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pipeline_jobs_id_seq OWNER TO root;

--
-- Name: pipeline_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE pipeline_jobs_id_seq OWNED BY pipeline_jobs.id;


--
-- Name: pqr_alerts; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE pqr_alerts (
    row_id integer NOT NULL,
    row_number integer NOT NULL,
    country character varying(254) NOT NULL,
    report_date bigint NOT NULL,
    report_type character varying(254) NOT NULL,
    report_subtype character varying(254) NOT NULL,
    report_scope character varying(254),
    variable_column_name character varying(254) NOT NULL,
    variable_row_name character varying(254) NOT NULL,
    variable_tag character varying(254) NOT NULL,
    value character varying(254),
    ltb character varying(254) NOT NULL,
    source_pipeline integer
);


ALTER TABLE pqr_alerts OWNER TO root;

--
-- Name: pqr_alerts_row_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE pqr_alerts_row_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pqr_alerts_row_id_seq OWNER TO root;

--
-- Name: pqr_alerts_row_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE pqr_alerts_row_id_seq OWNED BY pqr_alerts.row_id;


--
-- Name: preferences; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE preferences (
    id integer NOT NULL,
    pref text NOT NULL,
    pref_type character varying(254) NOT NULL
);


ALTER TABLE preferences OWNER TO root;

--
-- Name: product_buckets; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE product_buckets (
    product_id integer NOT NULL,
    bucket character varying(254) NOT NULL,
    path character varying(254),
    "user" character varying(254) NOT NULL
);


ALTER TABLE product_buckets OWNER TO root;

--
-- Name: product_prefs; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE product_prefs (
    product_id integer NOT NULL,
    pref text NOT NULL
);


ALTER TABLE product_prefs OWNER TO root;

--
-- Name: product_reports; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE product_reports (
    id integer NOT NULL,
    product_id integer NOT NULL,
    name character varying(254) NOT NULL,
    file_location character varying(254) NOT NULL,
    execution_date timestamp without time zone NOT NULL
);


ALTER TABLE product_reports OWNER TO root;

--
-- Name: product_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE product_reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_reports_id_seq OWNER TO root;

--
-- Name: product_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE product_reports_id_seq OWNED BY product_reports.id;


--
-- Name: product_repos; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE product_repos (
    id integer NOT NULL,
    product_id integer NOT NULL,
    repo_type character varying(254) NOT NULL,
    root_context character varying(254) NOT NULL,
    access_key character varying(254),
    secret_key character varying(254)
);


ALTER TABLE product_repos OWNER TO root;

--
-- Name: product_repos_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE product_repos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_repos_id_seq OWNER TO root;

--
-- Name: product_repos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE product_repos_id_seq OWNED BY product_repos.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE products (
    product_id integer NOT NULL,
    product_name character varying(254) NOT NULL,
    org_id integer NOT NULL
);


ALTER TABLE products OWNER TO root;

--
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE products_product_id_seq OWNER TO root;

--
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE products_product_id_seq OWNED BY products.product_id;


--
-- Name: report_stats; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE report_stats (
    id integer NOT NULL,
    report_id integer NOT NULL,
    name character varying(254) NOT NULL,
    stat_value character varying(254) NOT NULL,
    value_represented_in character varying(254) NOT NULL
);


ALTER TABLE report_stats OWNER TO root;

--
-- Name: report_stats_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE report_stats_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE report_stats_id_seq OWNER TO root;

--
-- Name: report_stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE report_stats_id_seq OWNED BY report_stats.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE roles (
    role_name character varying(254) NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE roles OWNER TO root;

--
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE roles_role_id_seq OWNER TO root;

--
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE roles_role_id_seq OWNED BY roles.role_id;


--
-- Name: scheduled_analyzer_jobs; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE scheduled_analyzer_jobs (
    id integer NOT NULL,
    analyzer_id integer NOT NULL,
    name character varying(254) NOT NULL,
    description character varying(254),
    sdm_id integer NOT NULL,
    job_status character varying(254) NOT NULL,
    model_params text,
    created_at timestamp without time zone NOT NULL,
    job_start_time timestamp without time zone,
    job_end_time timestamp without time zone,
    error_message character varying(254),
    important_features text,
    decision_rules text,
    saved_model_location character varying(254),
    spark_app_id character varying(254),
    error_metrics text,
    spark_submission_id character varying(254),
    cluster_centers text,
    model_output text,
    training_data_location text NOT NULL,
    is_active integer DEFAULT 1 NOT NULL,
    self_learning_du integer
);


ALTER TABLE scheduled_analyzer_jobs OWNER TO root;

--
-- Name: scheduled_analyzer_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE scheduled_analyzer_jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE scheduled_analyzer_jobs_id_seq OWNER TO root;

--
-- Name: scheduled_analyzer_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE scheduled_analyzer_jobs_id_seq OWNED BY scheduled_analyzer_jobs.id;


--
-- Name: scheduled_pipelines; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE scheduled_pipelines (
    id integer NOT NULL,
    pipeline_id integer NOT NULL,
    datasets text NOT NULL,
    frequency_seconds integer NOT NULL,
    start_time timestamp without time zone NOT NULL,
    last_run_time timestamp without time zone
);


ALTER TABLE scheduled_pipelines OWNER TO root;

--
-- Name: scheduled_pipelines_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE scheduled_pipelines_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE scheduled_pipelines_id_seq OWNER TO root;

--
-- Name: scheduled_pipelines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE scheduled_pipelines_id_seq OWNED BY scheduled_pipelines.id;


--
-- Name: scheduled_scenario_jobs; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE scheduled_scenario_jobs (
    job_id integer NOT NULL,
    scenario_id integer NOT NULL,
    job_status character varying(254) NOT NULL,
    model_params text,
    created_at timestamp without time zone NOT NULL,
    job_start_time timestamp without time zone,
    job_end_time timestamp without time zone,
    error_message character varying(254),
    output_location character varying(254),
    spark_app_id character varying(254),
    error_metrics text,
    spark_submission_id character varying(254),
    is_active integer DEFAULT 1 NOT NULL
);


ALTER TABLE scheduled_scenario_jobs OWNER TO root;

--
-- Name: self_learning_model_instances; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE self_learning_model_instances (
    id integer NOT NULL,
    selflearning_model_id integer NOT NULL,
    status character varying(254) NOT NULL,
    start_time timestamp without time zone NOT NULL,
    pipeline_instance integer,
    end_time timestamp without time zone,
    swap_history character varying(254)
);


ALTER TABLE self_learning_model_instances OWNER TO root;

--
-- Name: self_learning_model_instances_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE self_learning_model_instances_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE self_learning_model_instances_id_seq OWNER TO root;

--
-- Name: self_learning_model_instances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE self_learning_model_instances_id_seq OWNED BY self_learning_model_instances.id;


--
-- Name: structured_datamart_scenarios; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE structured_datamart_scenarios (
    id integer NOT NULL,
    name character varying(254),
    sdm_id integer NOT NULL,
    data_location character varying(254) NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE structured_datamart_scenarios OWNER TO root;

--
-- Name: structured_datamart_scenarios_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE structured_datamart_scenarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE structured_datamart_scenarios_id_seq OWNER TO root;

--
-- Name: structured_datamart_scenarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE structured_datamart_scenarios_id_seq OWNED BY structured_datamart_scenarios.id;


--
-- Name: structured_datamarts; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE structured_datamarts (
    id integer NOT NULL,
    name character varying(254) NOT NULL,
    product_id integer NOT NULL,
    description character varying(254),
    training_data_location character varying(254) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    is_active integer DEFAULT 1 NOT NULL,
    decision_unit_type integer NOT NULL,
    pipeline_id integer,
    last_runtime timestamp without time zone,
    self_learning_params text,
    champion_model character varying(254)
);


ALTER TABLE structured_datamarts OWNER TO root;

--
-- Name: structured_datamarts_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE structured_datamarts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE structured_datamarts_id_seq OWNER TO root;

--
-- Name: structured_datamarts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE structured_datamarts_id_seq OWNED BY structured_datamarts.id;


--
-- Name: test_jobs; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE test_jobs (
    id integer NOT NULL,
    product_id integer NOT NULL,
    job_status character varying(254) NOT NULL,
    spark_submission_id character varying(254)
);


ALTER TABLE test_jobs OWNER TO root;

--
-- Name: test_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE test_jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE test_jobs_id_seq OWNER TO root;

--
-- Name: test_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE test_jobs_id_seq OWNED BY test_jobs.id;


--
-- Name: transformation_jobs; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE transformation_jobs (
    id integer NOT NULL,
    product_id integer NOT NULL,
    operation character varying(254) NOT NULL,
    params text NOT NULL,
    job_status character varying(254) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    job_start_time timestamp without time zone,
    job_end_time timestamp without time zone,
    error_message text,
    spark_app_id character varying(254),
    output_location character varying(254),
    input_location character varying(254) NOT NULL,
    spark_submission_id character varying(254),
    actual_param character varying(254) NOT NULL,
    pipeline_id integer,
    is_active boolean
);


ALTER TABLE transformation_jobs OWNER TO root;

--
-- Name: transformation_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE transformation_jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE transformation_jobs_id_seq OWNER TO root;

--
-- Name: transformation_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE transformation_jobs_id_seq OWNED BY transformation_jobs.id;


--
-- Name: udfs; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE udfs (
    id integer NOT NULL,
    name character varying(254) NOT NULL,
    description character varying(254),
    location character varying(254) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    creator_id integer NOT NULL,
    edited_at timestamp without time zone DEFAULT now() NOT NULL,
    editor_id integer NOT NULL,
    product_id integer NOT NULL,
    ran_at timestamp without time zone DEFAULT '2000-02-01 01:01:01'::timestamp without time zone NOT NULL
);


ALTER TABLE udfs OWNER TO root;

--
-- Name: udfs_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE udfs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE udfs_id_seq OWNER TO root;

--
-- Name: udfs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE udfs_id_seq OWNED BY udfs.id;


--
-- Name: user_preferences; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE user_preferences (
    user_id integer NOT NULL,
    pref text NOT NULL
);


ALTER TABLE user_preferences OWNER TO root;

--
-- Name: user_product_prefs; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE user_product_prefs (
    user_id integer NOT NULL,
    product_id integer NOT NULL,
    pref text NOT NULL
);


ALTER TABLE user_product_prefs OWNER TO root;

--
-- Name: user_product_roles; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE user_product_roles (
    user_id integer NOT NULL,
    product_id integer NOT NULL,
    role_id integer NOT NULL
);


ALTER TABLE user_product_roles OWNER TO root;

--
-- Name: users; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE users (
    user_id integer NOT NULL,
    first_name character varying(254) NOT NULL,
    last_name character varying(254) NOT NULL,
    user_name character varying(254) NOT NULL,
    gender character varying(254),
    email character varying(254) NOT NULL,
    password character varying(254) NOT NULL,
    is_admin integer DEFAULT 0 NOT NULL,
    mobile character varying(254),
    title character varying(254),
    dob character varying(254),
    country_code character varying(254),
    is_active integer DEFAULT 1 NOT NULL,
    email_validation_code character varying(254),
    is_email_verified integer NOT NULL
);


ALTER TABLE users OWNER TO root;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_user_id_seq OWNER TO root;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE users_user_id_seq OWNED BY users.user_id;


--
-- Name: analyzers id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY analyzers ALTER COLUMN id SET DEFAULT nextval('analyzers_id_seq'::regclass);


--
-- Name: behaviours behaviour_id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY behaviours ALTER COLUMN behaviour_id SET DEFAULT nextval('behaviours_behaviour_id_seq'::regclass);


--
-- Name: data_extraction_jobs id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY data_extraction_jobs ALTER COLUMN id SET DEFAULT nextval('data_extraction_jobs_id_seq'::regclass);


--
-- Name: data_marts data_mart_id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY data_marts ALTER COLUMN data_mart_id SET DEFAULT nextval('data_marts_data_mart_id_seq'::regclass);


--
-- Name: dataset_jobs id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY dataset_jobs ALTER COLUMN id SET DEFAULT nextval('dataset_jobs_id_seq'::regclass);


--
-- Name: datasets id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY datasets ALTER COLUMN id SET DEFAULT nextval('datasets_id_seq'::regclass);


--
-- Name: ext_data_srcs id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY ext_data_srcs ALTER COLUMN id SET DEFAULT nextval('ext_data_srcs_id_seq'::regclass);


--
-- Name: models_meta_data id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY models_meta_data ALTER COLUMN id SET DEFAULT nextval('models_meta_data_id_seq'::regclass);


--
-- Name: org_resources id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY org_resources ALTER COLUMN id SET DEFAULT nextval('org_resources_id_seq'::regclass);


--
-- Name: orgs org_id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY orgs ALTER COLUMN org_id SET DEFAULT nextval('orgs_org_id_seq'::regclass);


--
-- Name: pipeline_instances id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY pipeline_instances ALTER COLUMN id SET DEFAULT nextval('pipeline_instances_id_seq'::regclass);


--
-- Name: pipeline_jobs id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY pipeline_jobs ALTER COLUMN id SET DEFAULT nextval('pipeline_jobs_id_seq'::regclass);


--
-- Name: pqr_alerts row_id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY pqr_alerts ALTER COLUMN row_id SET DEFAULT nextval('pqr_alerts_row_id_seq'::regclass);


--
-- Name: product_reports id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY product_reports ALTER COLUMN id SET DEFAULT nextval('product_reports_id_seq'::regclass);


--
-- Name: product_repos id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY product_repos ALTER COLUMN id SET DEFAULT nextval('product_repos_id_seq'::regclass);


--
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY products ALTER COLUMN product_id SET DEFAULT nextval('products_product_id_seq'::regclass);


--
-- Name: report_stats id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY report_stats ALTER COLUMN id SET DEFAULT nextval('report_stats_id_seq'::regclass);


--
-- Name: roles role_id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY roles ALTER COLUMN role_id SET DEFAULT nextval('roles_role_id_seq'::regclass);


--
-- Name: scheduled_analyzer_jobs id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY scheduled_analyzer_jobs ALTER COLUMN id SET DEFAULT nextval('scheduled_analyzer_jobs_id_seq'::regclass);


--
-- Name: scheduled_pipelines id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY scheduled_pipelines ALTER COLUMN id SET DEFAULT nextval('scheduled_pipelines_id_seq'::regclass);


--
-- Name: self_learning_model_instances id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY self_learning_model_instances ALTER COLUMN id SET DEFAULT nextval('self_learning_model_instances_id_seq'::regclass);


--
-- Name: structured_datamart_scenarios id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY structured_datamart_scenarios ALTER COLUMN id SET DEFAULT nextval('structured_datamart_scenarios_id_seq'::regclass);


--
-- Name: structured_datamarts id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY structured_datamarts ALTER COLUMN id SET DEFAULT nextval('structured_datamarts_id_seq'::regclass);


--
-- Name: test_jobs id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY test_jobs ALTER COLUMN id SET DEFAULT nextval('test_jobs_id_seq'::regclass);


--
-- Name: transformation_jobs id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY transformation_jobs ALTER COLUMN id SET DEFAULT nextval('transformation_jobs_id_seq'::regclass);


--
-- Name: udfs id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY udfs ALTER COLUMN id SET DEFAULT nextval('udfs_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Name: analyzers analyzers_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY analyzers
    ADD CONSTRAINT analyzers_pkey PRIMARY KEY (id);


--
-- Name: auth_token_info auth_token_info_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY auth_token_info
    ADD CONSTRAINT auth_token_info_pkey PRIMARY KEY (user_session_key);


--
-- Name: aws_credentials aws_credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY aws_credentials
    ADD CONSTRAINT aws_credentials_pkey PRIMARY KEY ("user");


--
-- Name: behaviours behaviours_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY behaviours
    ADD CONSTRAINT behaviours_pkey PRIMARY KEY (behaviour_id);


--
-- Name: data_extraction_jobs data_extraction_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY data_extraction_jobs
    ADD CONSTRAINT data_extraction_jobs_pkey PRIMARY KEY (id);


--
-- Name: data_marts data_marts_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY data_marts
    ADD CONSTRAINT data_marts_pkey PRIMARY KEY (data_mart_id);


--
-- Name: dataset_types datasetTypePk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY dataset_types
    ADD CONSTRAINT "datasetTypePk" PRIMARY KEY (dataset_id, dataset_type);


--
-- Name: dataset_jobs dataset_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY dataset_jobs
    ADD CONSTRAINT dataset_jobs_pkey PRIMARY KEY (id);


--
-- Name: datasets datasets_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY datasets
    ADD CONSTRAINT datasets_pkey PRIMARY KEY (id);


--
-- Name: ext_data_srcs ext_data_srcs_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY ext_data_srcs
    ADD CONSTRAINT ext_data_srcs_pkey PRIMARY KEY (id);


--
-- Name: jobserver_product jobserver_product_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY jobserver_product
    ADD CONSTRAINT jobserver_product_pkey PRIMARY KEY (job_id);


--
-- Name: models_meta_data models_meta_data_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY models_meta_data
    ADD CONSTRAINT models_meta_data_pkey PRIMARY KEY (id);


--
-- Name: org_resources org_resources_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY org_resources
    ADD CONSTRAINT org_resources_pkey PRIMARY KEY (id);


--
-- Name: orgs orgs_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY orgs
    ADD CONSTRAINT orgs_pkey PRIMARY KEY (org_id);


--
-- Name: pipeline_instances pipeline_instances_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pipeline_instances
    ADD CONSTRAINT pipeline_instances_pkey PRIMARY KEY (id);


--
-- Name: pipeline_jobs pipeline_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pipeline_jobs
    ADD CONSTRAINT pipeline_jobs_pkey PRIMARY KEY (id);


--
-- Name: org_users pk_org_users; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY org_users
    ADD CONSTRAINT pk_org_users PRIMARY KEY (org_id, user_id);


--
-- Name: product_buckets pk_product_buckets; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY product_buckets
    ADD CONSTRAINT pk_product_buckets PRIMARY KEY (product_id);


--
-- Name: product_prefs pk_product_pref; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY product_prefs
    ADD CONSTRAINT pk_product_pref PRIMARY KEY (product_id);


--
-- Name: scheduled_scenario_jobs pk_scenario_outputs; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY scheduled_scenario_jobs
    ADD CONSTRAINT pk_scenario_outputs PRIMARY KEY (job_id, scenario_id);


--
-- Name: user_product_prefs pk_user_product_pref; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY user_product_prefs
    ADD CONSTRAINT pk_user_product_pref PRIMARY KEY (user_id, product_id);


--
-- Name: user_product_roles pk_user_product_role; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY user_product_roles
    ADD CONSTRAINT pk_user_product_role PRIMARY KEY (user_id, product_id, role_id);


--
-- Name: pqr_alerts pqr_alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pqr_alerts
    ADD CONSTRAINT pqr_alerts_pkey PRIMARY KEY (row_id);


--
-- Name: product_reports product_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY product_reports
    ADD CONSTRAINT product_reports_pkey PRIMARY KEY (id);


--
-- Name: product_repos product_repos_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY product_repos
    ADD CONSTRAINT product_repos_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- Name: report_stats report_stats_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY report_stats
    ADD CONSTRAINT report_stats_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- Name: scheduled_analyzer_jobs scheduled_analyzer_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY scheduled_analyzer_jobs
    ADD CONSTRAINT scheduled_analyzer_jobs_pkey PRIMARY KEY (id);


--
-- Name: scheduled_pipelines scheduled_pipelines_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY scheduled_pipelines
    ADD CONSTRAINT scheduled_pipelines_pkey PRIMARY KEY (id);


--
-- Name: self_learning_model_instances self_learning_model_instances_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY self_learning_model_instances
    ADD CONSTRAINT self_learning_model_instances_pkey PRIMARY KEY (id);


--
-- Name: structured_datamart_scenarios structured_datamart_scenarios_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY structured_datamart_scenarios
    ADD CONSTRAINT structured_datamart_scenarios_pkey PRIMARY KEY (id);


--
-- Name: structured_datamarts structured_datamarts_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY structured_datamarts
    ADD CONSTRAINT structured_datamarts_pkey PRIMARY KEY (id);


--
-- Name: test_jobs test_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY test_jobs
    ADD CONSTRAINT test_jobs_pkey PRIMARY KEY (id);


--
-- Name: transformation_jobs transformation_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY transformation_jobs
    ADD CONSTRAINT transformation_jobs_pkey PRIMARY KEY (id);


--
-- Name: udfs udfs_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY udfs
    ADD CONSTRAINT udfs_pkey PRIMARY KEY (id);


--
-- Name: user_preferences user_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY user_preferences
    ADD CONSTRAINT user_preferences_pkey PRIMARY KEY (user_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: analyzer_name_idx1; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX analyzer_name_idx1 ON analyzers USING btree (name);


--
-- Name: countryReportTypeId; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX "countryReportTypeId" ON pqr_alerts USING btree (country, report_type, report_subtype, report_scope);


--
-- Name: data_mart_name_idx1; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX data_mart_name_idx1 ON data_marts USING btree (data_mart_name, product_id);


--
-- Name: org_name_unique; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX org_name_unique ON orgs USING btree (org_name);


--
-- Name: product_src_uri_idx1; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX product_src_uri_idx1 ON ext_data_srcs USING btree (product_id, src_uri);


--
-- Name: struct_dm_name_idx1; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX struct_dm_name_idx1 ON structured_datamarts USING btree (name, product_id);


--
-- Name: udf_product_name_idx1; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX udf_product_name_idx1 ON udfs USING btree (product_id, name);


--
-- Name: user_email_idx1; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX user_email_idx1 ON users USING btree (email);


--
-- Name: user_name_idx1; Type: INDEX; Schema: public; Owner: root
--

CREATE UNIQUE INDEX user_name_idx1 ON users USING btree (user_name);


--
-- Name: dataset_types dt_dataset_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY dataset_types
    ADD CONSTRAINT dt_dataset_fk FOREIGN KEY (dataset_id) REFERENCES dataset_jobs(id);


--
-- Name: ext_data_srcs extds_prod_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY ext_data_srcs
    ADD CONSTRAINT extds_prod_fk FOREIGN KEY (product_id) REFERENCES products(product_id);


--
-- Name: dataset_jobs feed_dataset_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY dataset_jobs
    ADD CONSTRAINT feed_dataset_fk FOREIGN KEY (feed_id) REFERENCES datasets(id);


--
-- Name: jobserver_product job_product_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY jobserver_product
    ADD CONSTRAINT job_product_fk FOREIGN KEY (product_id) REFERENCES products(product_id);


--
-- Name: models_meta_data model_metadata_scheduled_analyzer_job_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY models_meta_data
    ADD CONSTRAINT model_metadata_scheduled_analyzer_job_fk FOREIGN KEY (job_id) REFERENCES scheduled_analyzer_jobs(id);


--
-- Name: org_resources ores_org_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY org_resources
    ADD CONSTRAINT ores_org_fk FOREIGN KEY (org_id) REFERENCES orgs(org_id);


--
-- Name: products org_product_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY products
    ADD CONSTRAINT org_product_fk FOREIGN KEY (org_id) REFERENCES orgs(org_id);


--
-- Name: org_users ou_org_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY org_users
    ADD CONSTRAINT ou_org_fk FOREIGN KEY (org_id) REFERENCES orgs(org_id);


--
-- Name: org_users ou_user_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY org_users
    ADD CONSTRAINT ou_user_fk FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: product_buckets pd_bucket_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY product_buckets
    ADD CONSTRAINT pd_bucket_fk FOREIGN KEY (product_id) REFERENCES products(product_id);


--
-- Name: scheduled_pipelines pipeline_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY scheduled_pipelines
    ADD CONSTRAINT pipeline_fk FOREIGN KEY (pipeline_id) REFERENCES pipeline_jobs(id);


--
-- Name: self_learning_model_instances pipeline_instance_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY self_learning_model_instances
    ADD CONSTRAINT pipeline_instance_fk FOREIGN KEY (pipeline_instance) REFERENCES pipeline_instances(id);


--
-- Name: pipeline_instances pipeline_job_pipeline_instance_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pipeline_instances
    ADD CONSTRAINT pipeline_job_pipeline_instance_fk FOREIGN KEY (pipeline_id) REFERENCES pipeline_jobs(id);


--
-- Name: structured_datamarts pipeline_struct_dm_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY structured_datamarts
    ADD CONSTRAINT pipeline_struct_dm_fk FOREIGN KEY (pipeline_id) REFERENCES pipeline_jobs(id);


--
-- Name: product_prefs ppref_product_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY product_prefs
    ADD CONSTRAINT ppref_product_fk FOREIGN KEY (product_id) REFERENCES products(product_id);


--
-- Name: product_repos prepo_prod_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY product_repos
    ADD CONSTRAINT prepo_prod_fk FOREIGN KEY (product_id) REFERENCES products(product_id);


--
-- Name: data_extraction_jobs product_data_ext_job_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY data_extraction_jobs
    ADD CONSTRAINT product_data_ext_job_fk FOREIGN KEY (product_id) REFERENCES products(product_id);


--
-- Name: data_marts product_data_mart_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY data_marts
    ADD CONSTRAINT product_data_mart_fk FOREIGN KEY (product_id) REFERENCES products(product_id);


--
-- Name: dataset_jobs product_dataset_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY dataset_jobs
    ADD CONSTRAINT product_dataset_fk FOREIGN KEY (product_id) REFERENCES products(product_id);


--
-- Name: pipeline_jobs product_pipeline_job_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pipeline_jobs
    ADD CONSTRAINT product_pipeline_job_fk FOREIGN KEY (product_id) REFERENCES products(product_id);


--
-- Name: structured_datamarts product_struct_dm_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY structured_datamarts
    ADD CONSTRAINT product_struct_dm_fk FOREIGN KEY (product_id) REFERENCES products(product_id);


--
-- Name: test_jobs product_test_job_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY test_jobs
    ADD CONSTRAINT product_test_job_fk FOREIGN KEY (product_id) REFERENCES products(product_id);


--
-- Name: transformation_jobs product_transformation_job_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY transformation_jobs
    ADD CONSTRAINT product_transformation_job_fk FOREIGN KEY (product_id) REFERENCES products(product_id);


--
-- Name: udfs product_udf_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY udfs
    ADD CONSTRAINT product_udf_fk FOREIGN KEY (product_id) REFERENCES products(product_id);


--
-- Name: scheduled_scenario_jobs sch_analyzer_job_so_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY scheduled_scenario_jobs
    ADD CONSTRAINT sch_analyzer_job_so_fk FOREIGN KEY (job_id) REFERENCES scheduled_analyzer_jobs(id);


--
-- Name: self_learning_model_instances scheduled_pipeline_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY self_learning_model_instances
    ADD CONSTRAINT scheduled_pipeline_fk FOREIGN KEY (selflearning_model_id) REFERENCES structured_datamarts(id);


--
-- Name: scheduled_scenario_jobs sdm_scenario_so_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY scheduled_scenario_jobs
    ADD CONSTRAINT sdm_scenario_so_fk FOREIGN KEY (scenario_id) REFERENCES structured_datamart_scenarios(id);


--
-- Name: structured_datamart_scenarios struct_dm_scenario_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY structured_datamart_scenarios
    ADD CONSTRAINT struct_dm_scenario_fk FOREIGN KEY (sdm_id) REFERENCES structured_datamarts(id);


--
-- Name: scheduled_analyzer_jobs structured_datamart_scheduled_analyzer_job_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY scheduled_analyzer_jobs
    ADD CONSTRAINT structured_datamart_scheduled_analyzer_job_fk FOREIGN KEY (sdm_id) REFERENCES structured_datamarts(id);


--
-- Name: pipeline_instances structured_pipeline_job_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY pipeline_instances
    ADD CONSTRAINT structured_pipeline_job_fk FOREIGN KEY (self_learning_du) REFERENCES structured_datamarts(id);


--
-- Name: user_product_prefs uppref_product_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY user_product_prefs
    ADD CONSTRAINT uppref_product_fk FOREIGN KEY (product_id) REFERENCES products(product_id);


--
-- Name: user_product_prefs uppref_user_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY user_product_prefs
    ADD CONSTRAINT uppref_user_fk FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: user_product_roles upr_product_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY user_product_roles
    ADD CONSTRAINT upr_product_fk FOREIGN KEY (product_id) REFERENCES products(product_id);


--
-- Name: user_product_roles upr_role_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY user_product_roles
    ADD CONSTRAINT upr_role_fk FOREIGN KEY (role_id) REFERENCES roles(role_id);


--
-- Name: user_product_roles upr_user_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY user_product_roles
    ADD CONSTRAINT upr_user_fk FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: user_preferences upref_user_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY user_preferences
    ADD CONSTRAINT upref_user_fk FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: udfs user_udf_fk1; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY udfs
    ADD CONSTRAINT user_udf_fk1 FOREIGN KEY (creator_id) REFERENCES users(user_id);


--
-- Name: udfs user_udf_fk2; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY udfs
    ADD CONSTRAINT user_udf_fk2 FOREIGN KEY (editor_id) REFERENCES users(user_id);


--
-- PostgreSQL database dump complete
--

