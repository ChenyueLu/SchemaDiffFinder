-- MySQL dump 10.13  Distrib 5.6.27, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: TrendDB
-- ------------------------------------------------------
-- Server version	5.6.27-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `analyzers`
--

DROP TABLE IF EXISTS `analyzers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `analyzers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(254) NOT NULL,
  `category` varchar(16) DEFAULT NULL,
  `description` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `analyzer_name_idx1` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auth_token_info`
--

DROP TABLE IF EXISTS `auth_token_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_token_info` (
  `user_session_key` varchar(254) NOT NULL,
  `last_used_at` bigint(20) NOT NULL,
  `user_data` varchar(254) NOT NULL,
  PRIMARY KEY (`user_session_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `aws_credentials`
--

DROP TABLE IF EXISTS `aws_credentials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aws_credentials` (
  `user` varchar(254) NOT NULL,
  `access_key` varchar(254) NOT NULL,
  `secret_key` varchar(254) NOT NULL,
  PRIMARY KEY (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `aws_file_schemas`
--

DROP TABLE IF EXISTS `aws_file_schemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aws_file_schemas` (
  `file_location` varchar(512) NOT NULL DEFAULT '',
  `schema` mediumtext,
  `summary` mediumtext,
  `meta_file_location` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`file_location`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `behaviours`
--

DROP TABLE IF EXISTS `behaviours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `behaviours` (
  `behaviour_id` int(11) NOT NULL AUTO_INCREMENT,
  `behaviour_name` varchar(254) NOT NULL,
  `parent_behaviour_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`behaviour_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1094 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cohorts`
--

DROP TABLE IF EXISTS `cohorts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cohorts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `demographic_id` int(11) NOT NULL,
  `location_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `demographic_fk` (`demographic_id`),
  KEY `location_fk` (`location_id`),
  CONSTRAINT `demographic_fk` FOREIGN KEY (`demographic_id`) REFERENCES `demographics` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `location_fk` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4841 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_extraction_jobs`
--

DROP TABLE IF EXISTS `data_extraction_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_extraction_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `ext_src_id` int(11) NOT NULL,
  `job_status` varchar(254) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `job_start_time` timestamp NULL DEFAULT NULL,
  `job_end_time` timestamp NULL DEFAULT NULL,
  `error_message` text,
  `spark_app_id` varchar(254) DEFAULT NULL,
  `output_location` varchar(512) DEFAULT NULL,
  `input_location` varchar(512) NOT NULL,
  `spark_submission_id` varchar(254) DEFAULT NULL,
  `pipeline_id` int(11) DEFAULT NULL,
  `metadata` text,
  PRIMARY KEY (`id`),
  KEY `product_data_ext_job_fk` (`product_id`),
  CONSTRAINT `product_data_ext_job_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1848 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_marts`
--

DROP TABLE IF EXISTS `data_marts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_marts` (
  `data_mart_id` int(11) NOT NULL AUTO_INCREMENT,
  `data_mart_name` varchar(254) NOT NULL,
  `product_id` int(11) NOT NULL,
  `description` varchar(254) DEFAULT NULL,
  `grouping_key` varchar(254) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`data_mart_id`),
  UNIQUE KEY `data_mart_name_idx1` (`data_mart_name`,`product_id`),
  KEY `product_data_mart_fk` (`product_id`),
  CONSTRAINT `product_data_mart_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataset_jobs`
--

DROP TABLE IF EXISTS `dataset_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataset_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(254) NOT NULL,
  `location` varchar(512) NOT NULL,
  `product_id` int(11) NOT NULL,
  `folder_data` mediumtext NOT NULL,
  `schema_status` varchar(254) NOT NULL,
  `summary_status` varchar(254) NOT NULL,
  `schema` longtext,
  `meta_location` varchar(512) DEFAULT NULL,
  `header` mediumtext,
  `delimiter` varchar(254) DEFAULT NULL,
  `transformation_job_id` int(11) DEFAULT NULL,
  `prediction_job_id` int(11) DEFAULT NULL,
  `model_job_id` int(11) DEFAULT NULL,
  `job_start_time` timestamp NULL DEFAULT NULL,
  `job_end_time` timestamp NULL DEFAULT NULL,
  `schema_error_message` text,
  `summary_error_message` text,
  `spark_submission_id` varchar(254) DEFAULT NULL,
  `spark_app_id` varchar(254) DEFAULT NULL,
  `feed_id` int(11) DEFAULT NULL,
  `feed_time` mediumtext,
  PRIMARY KEY (`id`),
  KEY `product_dataset_fk` (`product_id`),
  KEY `feed_dataset_fk` (`feed_id`),
  CONSTRAINT `feed_dataset_fk` FOREIGN KEY (`feed_id`) REFERENCES `datasets` (`id`),
  CONSTRAINT `product_dataset_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=51436 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataset_types`
--

DROP TABLE IF EXISTS `dataset_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataset_types` (
  `dataset_id` int(11) NOT NULL,
  `dataset_type` varchar(254) NOT NULL,
  PRIMARY KEY (`dataset_id`,`dataset_type`),
  KEY `type_id` (`dataset_type`,`dataset_id`),
  CONSTRAINT `dt_dataset_fk` FOREIGN KEY (`dataset_id`) REFERENCES `dataset_jobs` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `datasets`
--

DROP TABLE IF EXISTS `datasets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `datasets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(254) NOT NULL,
  `is_db` int(11) DEFAULT NULL,
  `db_credentials` text,
  `last_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `decision_tree_rules`
--

DROP TABLE IF EXISTS `decision_tree_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `decision_tree_rules` (
  `rule_id` bigint(20) NOT NULL,
  `sch_ana_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `raw_rules` text,
  `pruned_rules` text,
  `split_information` text,
  `probability` double DEFAULT NULL,
  `prediction` varchar(512) DEFAULT NULL,
  `impurity` double DEFAULT NULL,
  `samples` bigint(20) DEFAULT NULL,
  `samplesDistribution` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`sch_ana_id`,`rule_id`),
  CONSTRAINT `decision_tree_sch_analyzer_fk` FOREIGN KEY (`sch_ana_id`) REFERENCES `scheduled_analyzer_jobs` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `demographics`
--

DROP TABLE IF EXISTS `demographics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `demographics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `min_age` int(11) NOT NULL,
  `max_age` int(11) NOT NULL,
  `genders` varchar(254) NOT NULL,
  `name` varchar(254) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ext_data_srcs`
--

DROP TABLE IF EXISTS `ext_data_srcs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ext_data_srcs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(254) NOT NULL,
  `product_id` int(11) NOT NULL,
  `src_uri` varchar(254) NOT NULL,
  `src_type` varchar(254) NOT NULL,
  `delimiter` varchar(254) NOT NULL,
  `access_key` varchar(254) DEFAULT NULL,
  `secret_key` varchar(254) DEFAULT NULL,
  `target_uri` varchar(254) DEFAULT NULL,
  `last_read` timestamp NULL DEFAULT NULL,
  `feed_name` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_src_uri_idx1` (`product_id`,`src_uri`),
  CONSTRAINT `extds_prod_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fb_page_datamart`
--

DROP TABLE IF EXISTS `fb_page_datamart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fb_page_datamart` (
  `page_id` int(11) NOT NULL,
  `data_mart_id` int(11) NOT NULL,
  `from_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`page_id`,`data_mart_id`),
  KEY `pd_datamart_fk` (`data_mart_id`),
  CONSTRAINT `pd_datamart_fk` FOREIGN KEY (`data_mart_id`) REFERENCES `data_marts` (`data_mart_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `pd_page_fk` FOREIGN KEY (`page_id`) REFERENCES `fb_pages` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fb_page_verticals`
--

DROP TABLE IF EXISTS `fb_page_verticals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fb_page_verticals` (
  `page_id` int(11) NOT NULL,
  `vertical_id` int(11) NOT NULL,
  PRIMARY KEY (`page_id`,`vertical_id`),
  KEY `page_vertical_vertical_fk` (`vertical_id`),
  CONSTRAINT `page_vertical_page_fk` FOREIGN KEY (`page_id`) REFERENCES `fb_pages` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `page_vertical_vertical_fk` FOREIGN KEY (`vertical_id`) REFERENCES `verticals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fb_pages`
--

DROP TABLE IF EXISTS `fb_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fb_pages` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(254) NOT NULL,
  `PAGE_ID` varchar(254) NOT NULL,
  `country` varchar(254) NOT NULL,
  `last_fetched_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `page_idx1` (`PAGE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2380 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jobserver_product`
--

DROP TABLE IF EXISTS `jobserver_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobserver_product` (
  `job_id` varchar(254) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`job_id`),
  KEY `job_product_fk` (`product_id`),
  CONSTRAINT `job_product_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cities` varchar(254) NOT NULL,
  `regions` varchar(254) NOT NULL,
  `countries` varchar(254) NOT NULL,
  `name` varchar(254) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `models_meta_data`
--

DROP TABLE IF EXISTS `models_meta_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `models_meta_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `data` text,
  PRIMARY KEY (`id`),
  KEY `model_metadata_scheduled_analyzer_job_fk` (`job_id`),
  CONSTRAINT `model_metadata_scheduled_analyzer_job_fk` FOREIGN KEY (`job_id`) REFERENCES `scheduled_analyzer_jobs` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3574 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `news_rss`
--

DROP TABLE IF EXISTS `news_rss`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news_rss` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(254) NOT NULL,
  `RSS` varchar(254) NOT NULL,
  `DATE_FORMAT` varchar(254) NOT NULL,
  `country` varchar(254) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `rss_idx1` (`RSS`)
) ENGINE=InnoDB AUTO_INCREMENT=6066 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `news_rss_datamart`
--

DROP TABLE IF EXISTS `news_rss_datamart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news_rss_datamart` (
  `news_rss_id` int(11) NOT NULL,
  `data_mart_id` int(11) NOT NULL,
  PRIMARY KEY (`news_rss_id`,`data_mart_id`),
  KEY `nd_datamart_fk` (`data_mart_id`),
  CONSTRAINT `nd_datamart_fk` FOREIGN KEY (`data_mart_id`) REFERENCES `data_marts` (`data_mart_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `nd_newsRSS_fk` FOREIGN KEY (`news_rss_id`) REFERENCES `news_rss` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `news_rss_verticals`
--

DROP TABLE IF EXISTS `news_rss_verticals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news_rss_verticals` (
  `news_rss_id` int(11) NOT NULL,
  `vertical_id` int(11) NOT NULL,
  PRIMARY KEY (`news_rss_id`,`vertical_id`),
  KEY `news_vertical_vertical_fk` (`vertical_id`),
  CONSTRAINT `news_vertical_news_fk` FOREIGN KEY (`news_rss_id`) REFERENCES `news_rss` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `news_vertical_vertical_fk` FOREIGN KEY (`vertical_id`) REFERENCES `verticals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_resources`
--

DROP TABLE IF EXISTS `org_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `org_id` int(11) NOT NULL,
  `subsc_type` varchar(254) NOT NULL,
  `master_private_ip` varchar(254) DEFAULT NULL,
  `master_public_ip` varchar(254) DEFAULT NULL,
  `aws_cf_stack_id` varchar(254) DEFAULT NULL,
  `is_analyzer_active` int(11) NOT NULL DEFAULT '0',
  `last_submission_id` varchar(254) DEFAULT NULL,
  `last_status_message` varchar(254) DEFAULT NULL,
  `is_manual_controlled` int(11) DEFAULT NULL,
  `partitions` varchar(254) DEFAULT NULL,
  `spark_server_ips` varchar(254) DEFAULT NULL,
  `driver_jvm` varchar(254) DEFAULT NULL,
  `worker_count` int(11) DEFAULT NULL,
  `spark_start_time` timestamp NULL DEFAULT NULL,
  `spark_up_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ores_org_fk` (`org_id`),
  CONSTRAINT `ores_org_fk` FOREIGN KEY (`org_id`) REFERENCES `orgs` (`org_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `org_users`
--

DROP TABLE IF EXISTS `org_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org_users` (
  `org_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`org_id`,`user_id`),
  KEY `ou_user_fk` (`user_id`),
  CONSTRAINT `ou_org_fk` FOREIGN KEY (`org_id`) REFERENCES `orgs` (`org_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ou_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orgs`
--

DROP TABLE IF EXISTS `orgs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orgs` (
  `org_id` int(11) NOT NULL AUTO_INCREMENT,
  `org_name` varchar(254) NOT NULL,
  `url` varchar(254) NOT NULL,
  `desc` varchar(254) NOT NULL,
  `address` varchar(254) NOT NULL,
  `logo` varchar(254) DEFAULT NULL,
  `phone` varchar(254) DEFAULT NULL,
  `contact` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`org_id`),
  UNIQUE KEY `org_name_unique` (`org_name`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pipeline_instances`
--

DROP TABLE IF EXISTS `pipeline_instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pipeline_instances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pipeline_id` int(11) NOT NULL,
  `status` varchar(254) NOT NULL,
  `executed_jobs` varchar(254) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `external_inputs` mediumtext,
  `self_learning_du` int(11) DEFAULT NULL,
  `retry_count` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `pipeline_job_pipeline_instance_fk` (`pipeline_id`),
  CONSTRAINT `pipeline_job_pipeline_instance_fk` FOREIGN KEY (`pipeline_id`) REFERENCES `pipeline_jobs` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5813 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pipeline_jobs`
--

DROP TABLE IF EXISTS `pipeline_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pipeline_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `name` varchar(254) NOT NULL,
  `jobs` mediumtext NOT NULL,
  `inputs` mediumtext NOT NULL,
  `status` varchar(254) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `days_to_persist` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_pipeline_job_fk` (`product_id`),
  CONSTRAINT `product_pipeline_job_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=442 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pqrAlerts`
--

DROP TABLE IF EXISTS `pqrAlerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pqrAlerts` (
  `rowId` int(11) NOT NULL AUTO_INCREMENT,
  `row_number` int(11) DEFAULT NULL,
  `country` varchar(254) DEFAULT NULL,
  `report_date` bigint(20) DEFAULT NULL,
  `reportType` varchar(254) DEFAULT NULL,
  `reportSubType` varchar(254) DEFAULT NULL,
  `reportScope` varchar(254) DEFAULT NULL,
  `variable_column_name` varchar(254) DEFAULT NULL,
  `variable_row_name` varchar(254) DEFAULT NULL,
  `variable_tag` varchar(254) DEFAULT NULL,
  `value` varchar(254) DEFAULT NULL,
  `ltb` varchar(254) DEFAULT NULL,
  `sourcePipeline` int(11) DEFAULT NULL,
  PRIMARY KEY (`rowId`)
) ENGINE=InnoDB AUTO_INCREMENT=162553 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pqr_alerts`
--

DROP TABLE IF EXISTS `pqr_alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pqr_alerts` (
  `row_id` int(11) NOT NULL AUTO_INCREMENT,
  `row_number` int(11) NOT NULL,
  `country` varchar(254) NOT NULL,
  `report_date` bigint(20) NOT NULL,
  `report_type` varchar(254) NOT NULL,
  `report_subtype` varchar(254) NOT NULL,
  `report_scope` varchar(254) DEFAULT NULL,
  `variable_column_name` varchar(254) NOT NULL,
  `variable_row_name` varchar(254) NOT NULL,
  `variable_tag` varchar(254) NOT NULL,
  `value` varchar(254) DEFAULT NULL,
  `ltb` varchar(254) NOT NULL,
  `source_pipeline` int(11) DEFAULT NULL,
  PRIMARY KEY (`row_id`),
  KEY `countryReportTypeId` (`country`,`report_type`,`report_subtype`,`report_scope`)
) ENGINE=InnoDB AUTO_INCREMENT=412852 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pqr_alerts_column_infos`
--

DROP TABLE IF EXISTS `pqr_alerts_column_infos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pqr_alerts_column_infos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_type` varchar(1024) DEFAULT NULL,
  `report_subtype` varchar(1024) DEFAULT NULL,
  `report_scope` varchar(1024) DEFAULT NULL,
  `variable_column_original_name` varchar(1024) DEFAULT NULL,
  `variable_column_current_name` varchar(1024) DEFAULT NULL,
  `column_description` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=189 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `preferences`
--

DROP TABLE IF EXISTS `preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preferences` (
  `id` int(11) NOT NULL,
  `pref` mediumtext NOT NULL,
  `pref_type` varchar(254) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_buckets`
--

DROP TABLE IF EXISTS `product_buckets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_buckets` (
  `product_id` int(11) NOT NULL,
  `bucket` varchar(254) NOT NULL,
  `path` varchar(254) DEFAULT NULL,
  `user` varchar(254) NOT NULL,
  PRIMARY KEY (`product_id`),
  CONSTRAINT `pd_bucket_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_prefs`
--

DROP TABLE IF EXISTS `product_prefs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_prefs` (
  `product_id` int(11) NOT NULL,
  `pref` mediumtext NOT NULL,
  PRIMARY KEY (`product_id`),
  CONSTRAINT `ppref_product_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_reports`
--

DROP TABLE IF EXISTS `product_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_reports` (
  `product_id` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `execution_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(254) DEFAULT NULL,
  `file_location` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_repos`
--

DROP TABLE IF EXISTS `product_repos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_repos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `repo_type` varchar(254) NOT NULL,
  `root_context` varchar(254) NOT NULL,
  `access_key` varchar(254) DEFAULT NULL,
  `secret_key` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prepo_prod_fk` (`product_id`),
  CONSTRAINT `prepo_prod_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_target_audience_behaviours`
--

DROP TABLE IF EXISTS `product_target_audience_behaviours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_target_audience_behaviours` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `target_audience_id` int(11) NOT NULL,
  `behaviour_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ptab_idx1` (`product_id`,`target_audience_id`,`behaviour_id`),
  KEY `ptab_behaviour_fk` (`behaviour_id`),
  KEY `ptab_target_audience_fk` (`target_audience_id`),
  CONSTRAINT `ptab_behaviour_fk` FOREIGN KEY (`behaviour_id`) REFERENCES `behaviours` (`behaviour_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ptab_product_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ptab_target_audience_fk` FOREIGN KEY (`target_audience_id`) REFERENCES `target_audiences` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(254) NOT NULL,
  `org_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`),
  KEY `org_product_fk` (`org_id`),
  CONSTRAINT `org_product_fk` FOREIGN KEY (`org_id`) REFERENCES `orgs` (`org_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_stats`
--

DROP TABLE IF EXISTS `report_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `report_id` int(11) NOT NULL,
  `name` varchar(254) DEFAULT NULL,
  `stat_value` varchar(254) DEFAULT NULL,
  `value_represented_in` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `report_stats_product_reports_id_fk` (`report_id`),
  CONSTRAINT `report_stats_product_reports_id_fk` FOREIGN KEY (`report_id`) REFERENCES `product_reports` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=577 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(254) NOT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scheduled_analyzer_jobs`
--

DROP TABLE IF EXISTS `scheduled_analyzer_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduled_analyzer_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `analyzer_id` int(11) NOT NULL,
  `name` varchar(254) NOT NULL,
  `description` varchar(254) DEFAULT NULL,
  `sdm_id` int(11) NOT NULL,
  `job_status` varchar(254) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `job_start_time` timestamp NULL DEFAULT NULL,
  `job_end_time` timestamp NULL DEFAULT NULL,
  `error_message` text,
  `important_features` text,
  `decision_rules` longtext,
  `saved_model_location` varchar(512) DEFAULT NULL,
  `spark_app_id` varchar(254) DEFAULT NULL,
  `error_metrics` text,
  `model_params` text,
  `spark_submission_id` varchar(254) DEFAULT NULL,
  `cluster_centers` text,
  `model_output` text,
  `training_data_location` varchar(1024) NOT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT '1',
  `self_learning_du` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `analyzer_scheduled_analyzer_job_fk` (`analyzer_id`),
  KEY `structured_datamart_scheduled_analyzer_job_fk` (`sdm_id`),
  CONSTRAINT `analyzer_scheduled_analyzer_job_fk` FOREIGN KEY (`analyzer_id`) REFERENCES `analyzers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `structured_datamart_scheduled_analyzer_job_fk` FOREIGN KEY (`sdm_id`) REFERENCES `structured_datamarts` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5044 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scheduled_pipelines`
--

DROP TABLE IF EXISTS `scheduled_pipelines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduled_pipelines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pipeline_id` int(11) NOT NULL,
  `datasets` mediumtext NOT NULL,
  `frequency_seconds` int(11) NOT NULL,
  `self_learning_model_id` int(11) DEFAULT NULL,
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_run_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pipeline_fk` (`pipeline_id`),
  CONSTRAINT `pipeline_fk` FOREIGN KEY (`pipeline_id`) REFERENCES `pipeline_jobs` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scheduled_scenario_jobs`
--

DROP TABLE IF EXISTS `scheduled_scenario_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduled_scenario_jobs` (
  `job_id` int(11) NOT NULL,
  `scenario_id` int(11) NOT NULL,
  `job_status` varchar(254) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `job_start_time` timestamp NULL DEFAULT NULL,
  `job_end_time` timestamp NULL DEFAULT NULL,
  `error_message` text,
  `output_location` varchar(512) DEFAULT NULL,
  `fdm_data_location` varchar(512) DEFAULT NULL,
  `spark_app_id` varchar(254) DEFAULT NULL,
  `model_params` text,
  `error_metrics` text,
  `spark_submission_id` varchar(254) DEFAULT NULL,
  `is_champion_model_scenario` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`job_id`,`scenario_id`),
  KEY `sdm_scenario_so_fk` (`scenario_id`),
  CONSTRAINT `sch_analyzer_job_so_fk` FOREIGN KEY (`job_id`) REFERENCES `scheduled_analyzer_jobs` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `sdm_scenario_so_fk` FOREIGN KEY (`scenario_id`) REFERENCES `structured_datamart_scenarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `self_learning_model_instances`
--

DROP TABLE IF EXISTS `self_learning_model_instances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `self_learning_model_instances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `selflearning_model_id` int(11) NOT NULL,
  `status` varchar(254) NOT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `pipeline_instance` int(11) DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `swap_history` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pipeline_instance_fk` (`pipeline_instance`),
  KEY `scheduled_pipeline_fk` (`selflearning_model_id`),
  CONSTRAINT `pipeline_instance_fk` FOREIGN KEY (`pipeline_instance`) REFERENCES `pipeline_instances` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `scheduled_pipeline_fk` FOREIGN KEY (`selflearning_model_id`) REFERENCES `structured_datamarts` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1740 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structured_datamart_scenarios`
--

DROP TABLE IF EXISTS `structured_datamart_scenarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structured_datamart_scenarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(254) DEFAULT NULL,
  `sdm_id` int(11) NOT NULL,
  `data_location` varchar(512) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `struct_dm_scenario_fk` (`sdm_id`),
  CONSTRAINT `struct_dm_scenario_fk` FOREIGN KEY (`sdm_id`) REFERENCES `structured_datamarts` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4368 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `structured_datamarts`
--

DROP TABLE IF EXISTS `structured_datamarts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structured_datamarts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(254) NOT NULL,
  `product_id` int(11) NOT NULL,
  `description` varchar(254) DEFAULT NULL,
  `training_data_location` varchar(1000) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) DEFAULT '1',
  `decision_unit_type` int(11) NOT NULL,
  `pipeline_id` int(11) DEFAULT NULL,
  `last_runtime` timestamp NULL DEFAULT NULL,
  `self_learning_params` text,
  `champion_model` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `struct_dm_name_idx1` (`name`,`product_id`),
  KEY `product_struct_dm_fk` (`product_id`),
  CONSTRAINT `product_struct_dm_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1953 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `target_audience_cohorts`
--

DROP TABLE IF EXISTS `target_audience_cohorts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `target_audience_cohorts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `target_audience_id` int(11) NOT NULL,
  `cohort_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cohort_fk` (`cohort_id`),
  KEY `cohort_ta_fk` (`target_audience_id`),
  CONSTRAINT `cohort_fk` FOREIGN KEY (`cohort_id`) REFERENCES `cohorts` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `cohort_ta_fk` FOREIGN KEY (`target_audience_id`) REFERENCES `target_audiences` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `target_audiences`
--

DROP TABLE IF EXISTS `target_audiences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `target_audiences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(254) NOT NULL,
  `ta_type` varchar(254) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `test_jobs`
--

DROP TABLE IF EXISTS `test_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `job_status` varchar(254) NOT NULL,
  `spark_submission_id` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_test_job_fk` (`product_id`),
  CONSTRAINT `product_test_job_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=228477 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transformation_jobs`
--

DROP TABLE IF EXISTS `transformation_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transformation_jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `operation` varchar(254) NOT NULL,
  `params` mediumtext,
  `job_status` varchar(254) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `job_start_time` timestamp NULL DEFAULT NULL,
  `job_end_time` timestamp NULL DEFAULT NULL,
  `error_message` text,
  `spark_app_id` varchar(254) DEFAULT NULL,
  `output_location` varchar(512) DEFAULT NULL,
  `input_location` varchar(512) DEFAULT NULL,
  `spark_submission_id` varchar(254) DEFAULT NULL,
  `pipeline_id` int(11) DEFAULT NULL,
  `actual_param` mediumtext NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_transformation_job_fk` (`product_id`),
  CONSTRAINT `product_transformation_job_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=22307 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `udfs`
--

DROP TABLE IF EXISTS `udfs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `udfs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(254) NOT NULL,
  `description` varchar(254) DEFAULT NULL,
  `location` varchar(254) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `creator_id` int(11) NOT NULL,
  `edited_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `editor_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `ran_at` timestamp NOT NULL DEFAULT '2000-02-01 01:01:01',
  PRIMARY KEY (`id`),
  UNIQUE KEY `udf_product_name_idx1` (`product_id`,`name`),
  KEY `user_udf_fk1` (`creator_id`),
  KEY `user_udf_fk2` (`editor_id`),
  CONSTRAINT `product_udf_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_udf_fk1` FOREIGN KEY (`creator_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_udf_fk2` FOREIGN KEY (`editor_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_preferences`
--

DROP TABLE IF EXISTS `user_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_preferences` (
  `user_id` int(11) NOT NULL,
  `pref` text NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `upref_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_product_prefs`
--

DROP TABLE IF EXISTS `user_product_prefs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_product_prefs` (
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `pref` mediumtext NOT NULL,
  PRIMARY KEY (`user_id`,`product_id`),
  KEY `uppref_product_fk` (`product_id`),
  CONSTRAINT `uppref_product_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `uppref_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_product_roles`
--

DROP TABLE IF EXISTS `user_product_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_product_roles` (
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`product_id`,`role_id`),
  KEY `upr_product_fk` (`product_id`),
  KEY `upr_role_fk` (`role_id`),
  CONSTRAINT `upr_product_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `upr_role_fk` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `upr_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(254) NOT NULL,
  `last_name` varchar(254) NOT NULL,
  `user_name` varchar(254) NOT NULL,
  `gender` varchar(254) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `password` varchar(254) NOT NULL,
  `is_admin` int(11) NOT NULL DEFAULT '0',
  `mobile` varchar(254) DEFAULT NULL,
  `title` varchar(254) DEFAULT NULL,
  `dob` varchar(254) DEFAULT NULL,
  `country_code` varchar(254) DEFAULT NULL,
  `is_active` int(11) NOT NULL DEFAULT '1',
  `email_validation_code` varchar(254) DEFAULT NULL,
  `is_email_verified` int(11) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_email_idx1` (`email`),
  UNIQUE KEY `user_name_idx1` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `version_information`
--

DROP TABLE IF EXISTS `version_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version_information` (
  `version` varchar(254) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `notes` text,
  `isActive` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `verticals`
--

DROP TABLE IF EXISTS `verticals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `verticals` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(254) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-07 10:29:26
