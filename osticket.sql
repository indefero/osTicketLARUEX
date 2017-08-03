-- MySQL dump 10.13  Distrib 5.7.19, for Linux (x86_64)
--
-- Host: localhost    Database: osticket
-- ------------------------------------------------------
-- Server version	5.7.19-0ubuntu0.16.04.1

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
-- Table structure for table `ost__search`
--

DROP TABLE IF EXISTS `ost__search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost__search` (
  `object_type` varchar(8) NOT NULL,
  `object_id` int(11) unsigned NOT NULL,
  `title` text,
  `content` text,
  PRIMARY KEY (`object_type`,`object_id`),
  FULLTEXT KEY `search` (`title`,`content`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost__search`
--

LOCK TABLES `ost__search` WRITE;
/*!40000 ALTER TABLE `ost__search` DISABLE KEYS */;
INSERT INTO `ost__search` VALUES ('U',2,'Antonio Baeza',' tritium@juntaex.es\ntritium@juntaex.es'),('U',3,'David Valencia',' david@laruex.es\ndavid@laruex.es'),('U',4,'Jos√© √Ångel Corbacho',' rat_va_pc@juntaex.es\nrat_va_pc@juntaex.es'),('U',5,'Juan Baeza',' ratvapc@gmail.com\nratvapc@gmail.com'),('U',6,'Jos√© Manuel Caballero',' josemanuel@laruex.es\njosemanuel@laruex.es'),('U',7,'M¬™ √Ångeles Ontalba',' eco2cir@gmail.com\neco2cir@gmail.com'),('U',8,'Jos√© Vasco',' eco2cir@juntaex.es\neco2cir@juntaex.es');
/*!40000 ALTER TABLE `ost__search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_api_key`
--

DROP TABLE IF EXISTS `ost_api_key`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_api_key` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `isactive` tinyint(1) NOT NULL DEFAULT '1',
  `ipaddr` varchar(64) NOT NULL,
  `apikey` varchar(255) NOT NULL,
  `can_create_tickets` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `can_exec_cron` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `notes` text,
  `updated` datetime NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `apikey` (`apikey`),
  KEY `ipaddr` (`ipaddr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_api_key`
--

LOCK TABLES `ost_api_key` WRITE;
/*!40000 ALTER TABLE `ost_api_key` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_api_key` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_attachment`
--

DROP TABLE IF EXISTS `ost_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int(11) unsigned NOT NULL,
  `type` char(1) NOT NULL,
  `file_id` int(11) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `inline` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `lang` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `file-type` (`object_id`,`file_id`,`type`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_attachment`
--

LOCK TABLES `ost_attachment` WRITE;
/*!40000 ALTER TABLE `ost_attachment` DISABLE KEYS */;
INSERT INTO `ost_attachment` VALUES (1,1,'C',2,NULL,0,NULL),(2,8,'T',1,NULL,1,NULL),(3,9,'T',1,NULL,1,NULL),(4,10,'T',1,NULL,1,NULL),(5,11,'T',1,NULL,1,NULL),(6,12,'T',1,NULL,1,NULL),(7,13,'T',1,NULL,1,NULL),(8,14,'T',1,NULL,1,NULL),(9,16,'T',1,NULL,1,NULL),(10,17,'T',1,NULL,1,NULL),(11,18,'T',1,NULL,1,NULL),(12,19,'T',1,NULL,1,NULL),(13,1918176781,'E',3,NULL,0,NULL);
/*!40000 ALTER TABLE `ost_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_canned_response`
--

DROP TABLE IF EXISTS `ost_canned_response`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_canned_response` (
  `canned_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dept_id` int(10) unsigned NOT NULL DEFAULT '0',
  `isenabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `title` varchar(255) NOT NULL DEFAULT '',
  `response` text NOT NULL,
  `lang` varchar(16) NOT NULL DEFAULT 'en_US',
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`canned_id`),
  UNIQUE KEY `title` (`title`),
  KEY `dept_id` (`dept_id`),
  KEY `active` (`isenabled`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_canned_response`
--

LOCK TABLES `ost_canned_response` WRITE;
/*!40000 ALTER TABLE `ost_canned_response` DISABLE KEYS */;
INSERT INTO `ost_canned_response` VALUES (1,0,1,'What is osTicket (sample)?','osTicket is a widely-used open source support ticket system, an\nattractive alternative to higher-cost and complex customer support\nsystems - simple, lightweight, reliable, open source, web-based and easy\nto setup and use.','en_US',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(2,0,1,'Sample (with variables)','Hi %{ticket.name.first},\n<br>\n<br>\nYour ticket #%{ticket.number} created on %{ticket.create_date} is in\n%{ticket.dept.name} department.','en_US',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25');
/*!40000 ALTER TABLE `ost_canned_response` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_config`
--

DROP TABLE IF EXISTS `ost_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `namespace` varchar(64) NOT NULL,
  `key` varchar(64) NOT NULL,
  `value` text NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `namespace` (`namespace`,`key`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_config`
--

LOCK TABLES `ost_config` WRITE;
/*!40000 ALTER TABLE `ost_config` DISABLE KEYS */;
INSERT INTO `ost_config` VALUES (1,'core','admin_email','carlos.nunez@juntaex.es','2017-08-01 10:23:25'),(2,'core','helpdesk_url','http://172.22.13.78/','2017-08-01 10:23:25'),(3,'core','helpdesk_title','Soporte LARUEX','2017-08-01 10:23:25'),(4,'core','schema_signature','98ad7d550c26ac44340350912296e673','2017-08-01 10:23:25'),(5,'core','time_format','hh:mm a','2017-08-01 10:23:25'),(6,'core','date_format','MM/dd/y','2017-08-01 10:23:25'),(7,'core','datetime_format','MM/dd/y h:mm a','2017-08-01 10:23:25'),(8,'core','daydatetime_format','EEE, MMM d y h:mm a','2017-08-01 10:23:25'),(9,'core','default_priority_id','2','2017-08-01 10:23:25'),(10,'core','enable_daylight_saving','','2017-08-01 10:23:25'),(11,'core','reply_separator','-- reply above this line --','2017-08-01 10:23:25'),(12,'core','isonline','1','2017-08-01 10:23:25'),(13,'core','staff_ip_binding','','2017-08-01 10:23:25'),(14,'core','staff_max_logins','4','2017-08-01 10:23:25'),(15,'core','staff_login_timeout','2','2017-08-01 10:23:25'),(16,'core','staff_session_timeout','30','2017-08-01 10:23:25'),(17,'core','passwd_reset_period','0','2017-08-02 09:17:55'),(18,'core','client_max_logins','4','2017-08-01 10:23:25'),(19,'core','client_login_timeout','2','2017-08-01 10:23:25'),(20,'core','client_session_timeout','30','2017-08-01 10:23:25'),(21,'core','max_page_size','25','2017-08-01 10:23:25'),(22,'core','max_open_tickets','0','2017-08-02 09:31:37'),(23,'core','autolock_minutes','3','2017-08-01 10:23:25'),(24,'core','default_smtp_id','0','2017-08-01 12:53:06'),(25,'core','use_email_priority','','2017-08-01 10:23:25'),(26,'core','enable_kb','','2017-08-01 10:23:25'),(27,'core','enable_premade','1','2017-08-01 10:23:25'),(28,'core','enable_captcha','','2017-08-01 10:23:25'),(29,'core','enable_auto_cron','','2017-08-01 10:23:25'),(30,'core','enable_mail_polling','','2017-08-01 10:23:25'),(31,'core','send_sys_errors','0','2017-08-02 05:57:54'),(32,'core','send_sql_errors','1','2017-08-01 10:23:25'),(33,'core','send_login_errors','1','2017-08-01 10:23:25'),(34,'core','save_email_headers','1','2017-08-01 10:23:25'),(35,'core','strip_quoted_reply','1','2017-08-01 10:23:25'),(36,'core','ticket_autoresponder','','2017-08-01 10:23:25'),(37,'core','message_autoresponder','','2017-08-01 10:23:25'),(38,'core','ticket_notice_active','1','2017-08-01 10:23:25'),(39,'core','ticket_alert_active','1','2017-08-01 10:23:25'),(40,'core','ticket_alert_admin','0','2017-08-02 09:48:06'),(41,'core','ticket_alert_dept_manager','1','2017-08-01 10:23:25'),(42,'core','ticket_alert_dept_members','','2017-08-01 10:23:25'),(43,'core','message_alert_active','1','2017-08-01 10:23:25'),(44,'core','message_alert_laststaff','1','2017-08-01 10:23:25'),(45,'core','message_alert_assigned','1','2017-08-01 10:23:25'),(46,'core','message_alert_dept_manager','','2017-08-01 10:23:25'),(47,'core','note_alert_active','0','2017-08-02 05:57:54'),(48,'core','note_alert_laststaff','1','2017-08-01 10:23:25'),(49,'core','note_alert_assigned','1','2017-08-01 10:23:25'),(50,'core','note_alert_dept_manager','','2017-08-01 10:23:25'),(51,'core','transfer_alert_active','0','2017-08-02 05:57:54'),(52,'core','transfer_alert_assigned','','2017-08-01 10:23:25'),(53,'core','transfer_alert_dept_manager','1','2017-08-01 10:23:25'),(54,'core','transfer_alert_dept_members','','2017-08-01 10:23:25'),(55,'core','overdue_alert_active','1','2017-08-01 10:23:25'),(56,'core','overdue_alert_assigned','1','2017-08-01 10:23:25'),(57,'core','overdue_alert_dept_manager','1','2017-08-01 10:23:25'),(58,'core','overdue_alert_dept_members','','2017-08-01 10:23:25'),(59,'core','assigned_alert_active','1','2017-08-01 10:23:25'),(60,'core','assigned_alert_staff','1','2017-08-01 10:23:25'),(61,'core','assigned_alert_team_lead','','2017-08-01 10:23:25'),(62,'core','assigned_alert_team_members','','2017-08-01 10:23:25'),(63,'core','auto_claim_tickets','1','2017-08-01 10:23:25'),(64,'core','show_related_tickets','0','2017-08-02 09:31:37'),(65,'core','show_assigned_tickets','1','2017-08-02 10:02:02'),(66,'core','show_answered_tickets','1','2017-08-02 09:31:37'),(67,'core','hide_staff_name','','2017-08-01 10:23:25'),(68,'core','overlimit_notice_active','','2017-08-01 10:23:25'),(69,'core','email_attachments','1','2017-08-01 10:23:25'),(70,'core','ticket_number_format','######','2017-08-01 10:23:25'),(71,'core','ticket_sequence_id','1','2017-08-02 11:01:04'),(72,'core','task_number_format','######','2017-08-02 05:58:18'),(73,'core','task_sequence_id','2','2017-08-01 10:23:25'),(74,'core','log_level','2','2017-08-01 10:23:25'),(75,'core','log_graceperiod','12','2017-08-01 10:23:25'),(76,'core','client_registration','closed','2017-08-02 05:52:47'),(77,'core','max_file_size','2097152','2017-08-02 05:52:01'),(78,'core','landing_page_id','1','2017-08-01 10:23:25'),(79,'core','thank-you_page_id','2','2017-08-01 10:23:25'),(80,'core','offline_page_id','3','2017-08-01 10:23:25'),(81,'core','system_language','es_ES','2017-08-01 10:59:14'),(82,'mysqlsearch','reindex','0','2017-08-01 10:59:06'),(83,'core','default_email_id','4','2017-08-01 12:53:06'),(84,'core','alert_email_id','0','2017-08-01 12:53:06'),(85,'core','default_dept_id','4','2017-08-01 12:34:50'),(86,'core','default_sla_id','2','2017-08-02 09:31:37'),(87,'core','default_template_id','1','2017-08-01 10:23:25'),(88,'core','default_timezone','Europe/Madrid','2017-08-02 06:21:56'),(89,'core','default_storage_bk','D','2017-08-01 10:59:14'),(90,'core','date_formats','','2017-08-01 10:59:14'),(91,'core','default_locale','','2017-08-01 10:59:14'),(92,'core','secondary_langs','','2017-08-01 10:59:14'),(93,'core','enable_avatars','1','2017-08-01 10:59:14'),(94,'core','enable_richtext','1','2017-08-01 10:59:14'),(95,'core','files_req_auth','1','2017-08-01 10:59:14'),(96,'core','client_logo_id','','2017-08-01 11:22:18'),(97,'core','staff_logo_id','','2017-08-01 11:22:18'),(98,'core','staff_backdrop_id','','2017-08-01 11:22:18'),(99,'core','verify_email_addrs','1','2017-08-01 12:53:06'),(100,'core','accept_unregistered_email','1','2017-08-01 12:53:06'),(101,'core','add_email_collabs','1','2017-08-01 12:53:06'),(102,'core','clients_only','1','2017-08-02 05:52:57'),(103,'core','client_verify_email','1','2017-08-02 05:52:37'),(104,'core','allow_auth_tokens','1','2017-08-02 05:52:37'),(105,'core','client_name_format','original','2017-08-02 05:52:37'),(106,'core','client_avatar','gravatar.mm','2017-08-02 05:52:37'),(107,'core','message_autoresponder_collabs','1','2017-08-02 05:57:54'),(108,'core','ticket_alert_acct_manager','','2017-08-02 05:57:54'),(109,'core','message_alert_acct_manager','','2017-08-02 05:57:54'),(110,'core','default_task_priority_id','1','2017-08-02 05:58:18'),(111,'core','default_task_sla_id','','2017-08-02 05:58:18'),(112,'core','task_alert_active','0','2017-08-02 05:58:18'),(113,'core','task_alert_admin','','2017-08-02 05:58:18'),(114,'core','task_alert_dept_manager','','2017-08-02 05:58:18'),(115,'core','task_alert_dept_members','','2017-08-02 05:58:18'),(116,'core','task_activity_alert_active','0','2017-08-02 05:58:18'),(117,'core','task_activity_alert_laststaff','','2017-08-02 05:58:18'),(118,'core','task_activity_alert_assigned','','2017-08-02 05:58:18'),(119,'core','task_activity_alert_dept_manager','','2017-08-02 05:58:18'),(120,'core','task_assignment_alert_active','0','2017-08-02 05:58:18'),(121,'core','task_assignment_alert_staff','','2017-08-02 05:58:18'),(122,'core','task_assignment_alert_team_lead','','2017-08-02 05:58:18'),(123,'core','task_assignment_alert_team_members','','2017-08-02 05:58:18'),(124,'core','task_transfer_alert_active','0','2017-08-02 05:58:18'),(125,'core','task_transfer_alert_assigned','','2017-08-02 05:58:18'),(126,'core','task_transfer_alert_dept_manager','','2017-08-02 05:58:18'),(127,'core','task_transfer_alert_dept_members','','2017-08-02 05:58:18'),(128,'core','task_overdue_alert_active','0','2017-08-02 05:58:18'),(129,'core','task_overdue_alert_assigned','','2017-08-02 05:58:18'),(130,'core','task_overdue_alert_dept_manager','','2017-08-02 05:58:18'),(131,'core','task_overdue_alert_dept_members','','2017-08-02 05:58:18'),(132,'core','restrict_kb','','2017-08-02 05:59:04'),(133,'core','allow_pw_reset','1','2017-08-02 09:17:55'),(134,'core','pw_reset_window','30','2017-08-02 09:17:55'),(135,'core','agent_name_format','full','2017-08-02 09:17:55'),(136,'core','agent_avatar','gravatar.mm','2017-08-02 09:27:05'),(137,'core','default_help_topic','0','2017-08-02 09:31:37'),(138,'core','default_ticket_status_id','1','2017-08-02 09:31:37'),(139,'core','allow_client_updates','','2017-08-02 09:31:37'),(140,'core','ticket_lock','2','2017-08-02 09:31:37');
/*!40000 ALTER TABLE `ost_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_content`
--

DROP TABLE IF EXISTS `ost_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_content` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `isactive` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `type` varchar(32) NOT NULL DEFAULT 'other',
  `name` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_content`
--

LOCK TABLES `ost_content` WRITE;
/*!40000 ALTER TABLE `ost_content` DISABLE KEYS */;
INSERT INTO `ost_content` VALUES (1,1,'landing','Landing','<h1>Welcome to the Support Center</h1> <p> In order to streamline support requests and better serve you, we utilize a support ticket system. Every support request is assigned a unique ticket number which you can use to track the progress and responses online. For your reference we provide complete archives and history of all your support requests. A valid email address is required to submit a ticket. </p>','The Landing Page refers to the content of the Customer Portal\'s initial view. The template modifies the content seen above the two links <strong>Open a New Ticket</strong> and <strong>Check Ticket Status</strong>.','2017-08-01 12:23:25','2017-08-01 12:23:25'),(2,1,'thank-you','Thank You','<div>%{ticket.name},\n<br>\n<br>\nThank you for contacting us.\n<br>\n<br>\nA support ticket request has been created and a representative will be\ngetting back to you shortly if necessary.</p>\n<br>\n<br>\nSupport Team\n</div>','This template defines the content displayed on the Thank-You page after a\nClient submits a new ticket in the Client Portal.','2017-08-01 12:23:25','2017-08-01 12:23:25'),(3,1,'offline','Offline','<div><h1>\n<span style=\"font-size: medium\">Support Ticket System Offline</span>\n</h1>\n<p>Thank you for your interest in contacting us.</p>\n<p>Our helpdesk is offline at the moment, please check back at a later\ntime.</p>\n</div>','The Offline Page appears in the Customer Portal when the Help Desk is offline.','2017-08-01 12:23:25','2017-08-01 12:23:25'),(4,1,'registration-staff','Welcome to osTicket','<h3><strong>Hi %{recipient.name.first},</strong></h3> <div> We\'ve created an account for you at our help desk at %{url}.<br /> <br /> Please follow the link below to confirm your account and gain access to your tickets.<br /> <br /> <a href=\"%{link}\">%{link}</a><br /> <br /> <em style=\"font-size: small\">Your friendly Customer Support System<br /> %{company.name}</em> </div>','This template defines the initial email (optional) sent to Agents when an account is created on their behalf.','2017-08-01 12:23:25','2017-08-01 12:23:25'),(5,1,'pwreset-staff','osTicket Staff Password Reset','<h3><strong>Hi %{staff.name.first},</strong></h3> <div> A password reset request has been submitted on your behalf for the helpdesk at %{url}.<br /> <br /> If you feel that this has been done in error, delete and disregard this email. Your account is still secure and no one has been given access to it. It is not locked and your password has not been reset. Someone could have mistakenly entered your email address.<br /> <br /> Follow the link below to login to the help desk and change your password.<br /> <br /> <a href=\"%{link}\">%{link}</a><br /> <br /> <em style=\"font-size: small\">Your friendly Customer Support System</em> <br /> <img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width: 126px\" /> </div>','This template defines the email sent to Staff who select the <strong>Forgot My Password</strong> link on the Staff Control Panel Log In page.','2017-08-01 12:23:25','2017-08-01 12:23:25'),(6,1,'banner-staff','Authentication Required','','This is the initial message and banner shown on the Staff Log In page. The first input field refers to the red-formatted text that appears at the top. The latter textarea is for the banner content which should serve as a disclaimer.','2017-08-01 12:23:25','2017-08-01 12:23:25'),(7,1,'registration-client','Welcome to %{company.name}','<h3><strong>Hi %{recipient.name.first},</strong></h3> <div> We\'ve created an account for you at our help desk at %{url}.<br /> <br /> Please follow the link below to confirm your account and gain access to your tickets.<br /> <br /> <a href=\"%{link}\">%{link}</a><br /> <br /> <em style=\"font-size: small\">Your friendly Customer Support System <br /> %{company.name}</em> </div>','This template defines the email sent to Clients when their account has been created in the Client Portal or by an Agent on their behalf. This email serves as an email address verification. Please use %{link} somewhere in the body.','2017-08-01 12:23:25','2017-08-01 12:23:25'),(8,1,'pwreset-client','%{company.name} Help Desk Access','<h3><strong>Hi %{user.name.first},</strong></h3> <div> A password reset request has been submitted on your behalf for the helpdesk at %{url}.<br /> <br /> If you feel that this has been done in error, delete and disregard this email. Your account is still secure and no one has been given access to it. It is not locked and your password has not been reset. Someone could have mistakenly entered your email address.<br /> <br /> Follow the link below to login to the help desk and change your password.<br /> <br /> <a href=\"%{link}\">%{link}</a><br /> <br /> <em style=\"font-size: small\">Your friendly Customer Support System <br /> %{company.name}</em> </div>','This template defines the email sent to Clients who select the <strong>Forgot My Password</strong> link on the Client Log In page.','2017-08-01 12:23:25','2017-08-01 12:23:25'),(9,1,'banner-client','Sign in to %{company.name}','To better serve you, we encourage our Clients to register for an account.','This composes the header on the Client Log In page. It can be useful to inform your Clients about your log in and registration policies.','2017-08-01 12:23:25','2017-08-01 12:23:25'),(10,1,'registration-confirm','Account registration','<div><strong>Thanks for registering for an account.</strong><br/> <br /> We\'ve just sent you an email to the address you entered. Please follow the link in the email to confirm your account and gain access to your tickets. </div>','This templates defines the page shown to Clients after completing the registration form. The template should mention that the system is sending them an email confirmation link and what is the next step in the registration process.','2017-08-01 12:23:25','2017-08-01 12:23:25'),(11,1,'registration-thanks','Account Confirmed!','<div> <strong>Thanks for registering for an account.</strong><br /> <br /> You\'ve confirmed your email address and successfully activated your account. You may proceed to open a new ticket or manage existing tickets.<br /> <br /> <em>Your friendly support center</em><br /> %{company.name} </div>','This template defines the content displayed after Clients successfully register by confirming their account. This page should inform the user that registration is complete and that the Client can now submit a ticket or access existing tickets.','2017-08-01 12:23:25','2017-08-01 12:23:25'),(12,1,'access-link','Ticket [#%{ticket.number}] Access Link','<h3><strong>Hi %{recipient.name.first},</strong></h3> <div> An access link request for ticket #%{ticket.number} has been submitted on your behalf for the helpdesk at %{url}.<br /> <br /> Follow the link below to check the status of the ticket #%{ticket.number}.<br /> <br /> <a href=\"%{recipient.ticket_link}\">%{recipient.ticket_link}</a><br /> <br /> If you <strong>did not</strong> make the request, please delete and disregard this email. Your account is still secure and no one has been given access to the ticket. Someone could have mistakenly entered your email address.<br /> <br /> --<br /> %{company.name} </div>','This template defines the notification for Clients that an access link was sent to their email. The ticket number and email address trigger the access link.','2017-08-01 12:23:25','2017-08-01 12:23:25');
/*!40000 ALTER TABLE `ost_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_department`
--

DROP TABLE IF EXISTS `ost_department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_department` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned DEFAULT NULL,
  `tpl_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sla_id` int(10) unsigned NOT NULL DEFAULT '0',
  `email_id` int(10) unsigned NOT NULL DEFAULT '0',
  `autoresp_email_id` int(10) unsigned NOT NULL DEFAULT '0',
  `manager_id` int(10) unsigned NOT NULL DEFAULT '0',
  `flags` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL DEFAULT '',
  `signature` text NOT NULL,
  `ispublic` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `group_membership` tinyint(1) NOT NULL DEFAULT '0',
  `ticket_auto_response` tinyint(1) NOT NULL DEFAULT '1',
  `message_auto_response` tinyint(1) NOT NULL DEFAULT '0',
  `path` varchar(128) NOT NULL DEFAULT '/',
  `updated` datetime NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`pid`),
  KEY `manager_id` (`manager_id`),
  KEY `autoresp_email_id` (`autoresp_email_id`),
  KEY `tpl_id` (`tpl_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_department`
--

LOCK TABLES `ost_department` WRITE;
/*!40000 ALTER TABLE `ost_department` DISABLE KEYS */;
INSERT INTO `ost_department` VALUES (4,NULL,0,0,0,0,0,1,'Red Alerta Radiol√≥gica','Red de Alerta Radiol√≥gica',1,1,1,1,'/4/','2017-08-01 14:34:35','2017-08-01 14:34:35'),(5,4,0,0,0,0,0,1,'Direcci√≥n','Dpto. Direcci√≥n<br />Red de Alerta Radiol√≥gica',1,1,1,1,'/4/5/','2017-08-01 14:37:14','2017-08-01 14:37:14'),(6,4,0,0,0,0,0,1,'Calidad','Dpto. Calidad <br />Red de Alerta Radiol√≥gica',1,1,1,1,'/4/6/','2017-08-01 14:37:56','2017-08-01 14:37:56'),(7,4,0,0,0,0,0,1,'Inform√°tica','Dpto. Inform√°tica<br />Red de Alerta Radiol√≥gica',1,1,1,1,'/4/7/','2017-08-01 14:38:35','2017-08-01 14:38:35'),(8,4,0,0,0,0,0,1,'An√°lisis','Dpto. de An√°lisis<br />Red de Alerta Radiol√≥gica',1,1,1,1,'/4/8/','2017-08-01 14:39:08','2017-08-01 14:39:08');
/*!40000 ALTER TABLE `ost_department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_draft`
--

DROP TABLE IF EXISTS `ost_draft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_draft` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) unsigned NOT NULL,
  `namespace` varchar(32) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `extra` text,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_draft`
--

LOCK TABLES `ost_draft` WRITE;
/*!40000 ALTER TABLE `ost_draft` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_draft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_email`
--

DROP TABLE IF EXISTS `ost_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_email` (
  `email_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `noautoresp` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `priority_id` tinyint(3) unsigned NOT NULL DEFAULT '2',
  `dept_id` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `topic_id` int(11) unsigned NOT NULL DEFAULT '0',
  `email` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `userid` varchar(255) NOT NULL,
  `userpass` varchar(255) CHARACTER SET ascii NOT NULL,
  `mail_active` tinyint(1) NOT NULL DEFAULT '0',
  `mail_host` varchar(255) NOT NULL,
  `mail_protocol` enum('POP','IMAP') NOT NULL DEFAULT 'POP',
  `mail_encryption` enum('NONE','SSL') NOT NULL,
  `mail_port` int(6) DEFAULT NULL,
  `mail_fetchfreq` tinyint(3) NOT NULL DEFAULT '5',
  `mail_fetchmax` tinyint(4) NOT NULL DEFAULT '30',
  `mail_archivefolder` varchar(255) DEFAULT NULL,
  `mail_delete` tinyint(1) NOT NULL DEFAULT '0',
  `mail_errors` tinyint(3) NOT NULL DEFAULT '0',
  `mail_lasterror` datetime DEFAULT NULL,
  `mail_lastfetch` datetime DEFAULT NULL,
  `smtp_active` tinyint(1) DEFAULT '0',
  `smtp_host` varchar(255) NOT NULL,
  `smtp_port` int(6) DEFAULT NULL,
  `smtp_secure` tinyint(1) NOT NULL DEFAULT '1',
  `smtp_auth` tinyint(1) NOT NULL DEFAULT '1',
  `smtp_spoofing` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`email_id`),
  UNIQUE KEY `email` (`email`),
  KEY `priority_id` (`priority_id`),
  KEY `dept_id` (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_email`
--

LOCK TABLES `ost_email` WRITE;
/*!40000 ALTER TABLE `ost_email` DISABLE KEYS */;
INSERT INTO `ost_email` VALUES (4,0,0,0,0,'laruextickets@gmail.com','LARUEX Gmail','laruextickets@gmail.com','$2$JDEktkgsgZt4xs/boNqXrULW0he2Lp/5IpcbaNePRD9iP/A=',1,'pop.gmail.com','POP','SSL',995,5,10,NULL,1,0,NULL,NULL,1,'smtp.gmail.com',587,1,1,0,NULL,'2017-08-01 14:51:08','2017-08-01 14:51:08');
/*!40000 ALTER TABLE `ost_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_email_account`
--

DROP TABLE IF EXISTS `ost_email_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_email_account` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `protocol` varchar(64) NOT NULL DEFAULT '',
  `host` varchar(128) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL,
  `username` varchar(128) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `options` varchar(512) DEFAULT NULL,
  `errors` int(11) unsigned DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `lastconnect` timestamp NULL DEFAULT NULL,
  `lasterror` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_email_account`
--

LOCK TABLES `ost_email_account` WRITE;
/*!40000 ALTER TABLE `ost_email_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_email_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_email_template`
--

DROP TABLE IF EXISTS `ost_email_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_email_template` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tpl_id` int(11) unsigned NOT NULL,
  `code_name` varchar(32) NOT NULL,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `template_lookup` (`tpl_id`,`code_name`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_email_template`
--

LOCK TABLES `ost_email_template` WRITE;
/*!40000 ALTER TABLE `ost_email_template` DISABLE KEYS */;
INSERT INTO `ost_email_template` VALUES (1,1,'ticket.autoresp','Support Ticket Opened [#%{ticket.number}]',' <h3><strong>Dear %{recipient.name.first},</strong></h3> <p> A request for support has been created and assigned #%{ticket.number}. A representative will follow-up with you as soon as possible. You can <a href=\"%%7Brecipient.ticket_link%7D\">view this ticket\'s progress online</a>. </p> <br /><div style=\"color:rgb(127, 127, 127)\"> Your %{company.name} Team, <br /> %{signature} </div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small\"><em>If you wish to provide additional comments or information regarding the issue, please reply to this email or <a href=\"%%7Brecipient.ticket_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login to your account</span></a> for a complete archive of your support requests.</em></div> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(2,1,'ticket.autoreply','Re: %{ticket.subject} [#%{ticket.number}]',' <h3><strong>Dear %{recipient.name.first},</strong></h3> A request for support has been created and assigned ticket <a href=\"%%7Brecipient.ticket_link%7D\">#%{ticket.number}</a> with the following automatic reply <br /><br /> Topic: <strong>%{ticket.topic.name}</strong> <br /> Subject: <strong>%{ticket.subject}</strong> <br /><br /> %{response} <br /><br /><div style=\"color:rgb(127, 127, 127)\">Your %{company.name} Team,<br /> %{signature}</div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small\"><em>We hope this response has sufficiently answered your questions. If you wish to provide additional comments or informatione, please reply to this email or <a href=\"%%7Brecipient.ticket_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login to your account</span></a> for a complete archive of your support requests.</em></div> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(3,1,'message.autoresp','Message Confirmation',' <h3><strong>Dear %{recipient.name.first},</strong></h3> Your reply to support request <a href=\"%%7Brecipient.ticket_link%7D\">#%{ticket.number}</a> has been noted <br /><br /><div style=\"color:rgb(127, 127, 127)\"> Your %{company.name} Team,<br /> %{signature} </div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small;text-align:center\"> <em>You can view the support request progress <a href=\"%%7Brecipient.ticket_link%7D\">online here</a></em> </div> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(4,1,'ticket.notice','%{ticket.subject} [#%{ticket.number}]',' <h3><strong>Dear %{recipient.name.first},</strong></h3> Our customer care team has created a ticket, <a href=\"%%7Brecipient.ticket_link%7D\">#%{ticket.number}</a> on your behalf, with the following details and summary: <br /><br /> Topic: <strong>%{ticket.topic.name}</strong> <br /> Subject: <strong>%{ticket.subject}</strong> <br /><br /> %{message} <br /><br /> If need be, a representative will follow-up with you as soon as possible. You can also <a href=\"%%7Brecipient.ticket_link%7D\">view this ticket\'s progress online</a>. <br /><br /><div style=\"color:rgb(127, 127, 127)\"> Your %{company.name} Team,<br /> %{signature}</div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small\"><em>If you wish to provide additional comments or information regarding the issue, please reply to this email or <a href=\"%%7Brecipient.ticket_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login to your account</span></a> for a complete archive of your support requests.</em></div> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(5,1,'ticket.overlimit','Open Tickets Limit Reached',' <h3><strong>Dear %{ticket.name.first},</strong></h3> You have reached the maximum number of open tickets allowed. To be able to open another ticket, one of your pending tickets must be closed. To update or add comments to an open ticket simply <a href=\"%%7Burl%7D/tickets.php?e=%%7Bticket.email%7D\">login to our helpdesk</a>. <br /><br /> Thank you,<br /> Support Ticket System',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(6,1,'ticket.reply','Re: %{ticket.subject} [#%{ticket.number}]',' <h3><strong>Dear %{recipient.name},</strong></h3> %{response} <br /><br /><div style=\"color:rgb(127, 127, 127)\"> Your %{company.name} Team,<br /> %{signature} </div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small;text-align:center\"><em>We hope this response has sufficiently answered your questions. If not, please do not send another email. Instead, reply to this email or <a href=\"%%7Brecipient.ticket_link%7D\" style=\"color:rgb(84, 141, 212)\">login to your account</a> for a complete archive of all your support requests and responses.</em></div> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(7,1,'ticket.activity.notice','Re: %{ticket.subject} [#%{ticket.number}]',' <h3><strong>Dear %{recipient.name.first},</strong></h3> <div> <em>%{poster.name}</em> just logged a message to a ticket in which you participate. </div> <br /> %{message} <br /><br /><hr /> <div style=\"color:rgb(127, 127, 127);font-size:small;text-align:center\"> <em>You\'re getting this email because you are a collaborator on ticket <a href=\"%%7Brecipient.ticket_link%7D\" style=\"color:rgb(84, 141, 212)\">#%{ticket.number}</a>. To participate, simply reply to this email or <a href=\"%%7Brecipient.ticket_link%7D\" style=\"color:rgb(84, 141, 212)\">click here</a> for a complete archive of the ticket thread.</em> </div> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(8,1,'ticket.alert','New Ticket Alert',' <h2>Hi %{recipient.name},</h2> New ticket #%{ticket.number} created <br /><br /><table><tbody> <tr> <td> <strong>From</strong>: </td> <td> %{ticket.name} </td> </tr> <tr> <td> <strong>Department</strong>: </td> <td> %{ticket.dept.name} </td> </tr> </tbody></table> <br /> %{message} <br /><br /><hr /> <div>To view or respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\">login</a> to the support ticket system</div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /><a href=\"http://osticket.com/\"><img width=\"126\" height=\"19\" style=\"width:126px\" alt=\"Powered By osTicket\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(9,1,'message.alert','New Message Alert',' <h3><strong>Hi %{recipient.name},</strong></h3> New message appended to ticket <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> <br /><br /><table><tbody> <tr> <td> <strong>From</strong>: </td> <td> %{ticket.name} </td> </tr> <tr> <td> <strong>Department</strong>: </td> <td> %{ticket.dept.name} </td> </tr> </tbody></table> <br /> %{message} <br /><br /><hr /> <div>To view or respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support ticket system</div> <em style=\"color:rgb(127,127,127);font-size:small\">Your friendly Customer Support System</em><br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" /> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(10,1,'note.alert','New Internal Activity Alert',' <h3><strong>Hi %{recipient.name},</strong></h3> An agent has logged activity on ticket <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> <br /><br /><table><tbody> <tr> <td> <strong>From</strong>: </td> <td> %{note.poster} </td> </tr> <tr> <td> <strong>Title</strong>: </td> <td> %{note.title} </td> </tr> </tbody></table> <br /> %{note.message} <br /><br /><hr /> To view/respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\">login</a> to the support ticket system <br /><br /><em style=\"font-size:small\">Your friendly Customer Support System</em> <br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" /> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(11,1,'assigned.alert','Ticket Assigned to you',' <h3><strong>Hi %{assignee.name.first},</strong></h3> Ticket <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> has been assigned to you by %{assigner.name.short} <br /><br /><table><tbody> <tr> <td> <strong>From</strong>: </td> <td> %{ticket.name} </td> </tr> <tr> <td> <strong>Subject</strong>: </td> <td> %{ticket.subject} </td> </tr> </tbody></table> <br /> %{comments} <br /><br /><hr /> <div>To view/respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support ticket system</div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" /> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(12,1,'transfer.alert','Ticket #%{ticket.number} transfer - %{ticket.dept.name}',' <h3>Hi %{recipient.name},</h3> Ticket <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> has been transferred to the %{ticket.dept.name} department by <strong>%{staff.name.short}</strong> <br /><br /><blockquote> %{comments} </blockquote> <hr /> <div>To view or respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\">login</a> to the support ticket system. </div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /><a href=\"http://osticket.com/\"><img width=\"126\" height=\"19\" alt=\"Powered By osTicket\" style=\"width:126px\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(13,1,'ticket.overdue','Stale Ticket Alert',' <h3> <strong>Hi %{recipient.name}</strong>,</h3> A ticket, <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> is seriously overdue. <br /><br /> We should all work hard to guarantee that all tickets are being addressed in a timely manner. <br /><br /> Signed,<br /> %{ticket.dept.manager.name} <hr /> <div>To view or respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support ticket system. You\'re receiving this notice because the ticket is assigned directly to you or to a team or department of which you\'re a member.</div> <em style=\"font-size:small\">Your friendly <span style=\"font-size:smaller\">(although with limited patience)</span> Customer Support System</em><br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" height=\"19\" alt=\"Powered by osTicket\" width=\"126\" style=\"width:126px\" /> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(14,1,'task.alert','New Task Alert',' <h2>Hi %{recipient.name},</h2> New task <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> created <br /><br /><table><tbody><tr> <td> <strong>Department</strong>: </td> <td> %{task.dept.name} </td> </tr></tbody></table> <br /> %{task.description} <br /><br /><hr /> <div>To view or respond to the ticket, please <a href=\"%%7Btask.staff_link%7D\">login</a> to the support system</div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /><a href=\"http://osticket.com/\"><img width=\"126\" height=\"19\" style=\"width:126px\" alt=\"Powered By osTicket\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(15,1,'task.activity.notice','Re: %{task.title} [#%{task.number}]',' <h3><strong>Dear %{recipient.name.first},</strong></h3> <div> <em>%{poster.name}</em> just logged a message to a task in which you participate. </div> <br /> %{message} <br /><br /><hr /> <div style=\"color:rgb(127, 127, 127);font-size:small;text-align:center\"> <em>You\'re getting this email because you are a collaborator on task #%{task.number}. To participate, simply reply to this email.</em> </div> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(16,1,'task.activity.alert','Task Activity [#%{task.number}] - %{activity.title}',' <h3><strong>Hi %{recipient.name},</strong></h3> Task <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> updated: %{activity.description} <br /><br /> %{message} <br /><br /><hr /> <div>To view or respond to the task, please <a href=\"%%7Btask.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support system</div> <em style=\"color:rgb(127,127,127);font-size:small\">Your friendly Customer Support System</em><br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" /> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(17,1,'task.assignment.alert','Task Assigned to you',' <h3><strong>Hi %{assignee.name.first},</strong></h3> Task <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> has been assigned to you by %{assigner.name.short} <br /><br /> %{comments} <br /><br /><hr /> <div>To view/respond to the task, please <a href=\"%%7Btask.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support system</div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" /> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(18,1,'task.transfer.alert','Task #%{task.number} transfer - %{task.dept.name}',' <h3>Hi %{recipient.name},</h3> Task <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> has been transferred to the %{task.dept.name} department by <strong>%{staff.name.short}</strong> <br /><br /><blockquote> %{comments} </blockquote> <hr /> <div>To view or respond to the task, please <a href=\"%%7Btask.staff_link%7D\">login</a> to the support system. </div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /><a href=\"http://osticket.com/\"><img width=\"126\" height=\"19\" alt=\"Powered By osTicket\" style=\"width:126px\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(19,1,'task.overdue.alert','Stale Task Alert',' <h3> <strong>Hi %{recipient.name}</strong>,</h3> A task, <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> is seriously overdue. <br /><br /> We should all work hard to guarantee that all tasks are being addressed in a timely manner. <br /><br /> Signed,<br /> %{task.dept.manager.name} <hr /> <div>To view or respond to the task, please <a href=\"%%7Btask.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support system. You\'re receiving this notice because the task is assigned directly to you or to a team or department of which you\'re a member.</div> <em style=\"font-size:small\">Your friendly <span style=\"font-size:smaller\">(although with limited patience)</span> Customer Support System</em><br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" height=\"19\" alt=\"Powered by osTicket\" width=\"126\" style=\"width:126px\" /> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(20,1,'ticket.closed','Closed Ticket Alert',' <h3> <strong>Hi %{recipient.name}</strong>,</h3> A ticket, <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> has been closed. <br /><br /> Signed,<br /> %{ticket.dept.manager.name} <hr /> <div>To view or respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support ticket system. You\'re receiving this notice because the ticket is assigned directly to you or to a team or department of which you\'re a member.</div> <em style=\"font-size:small\">Your friendly <span style=\"font-size:smaller\">(although with limited patience)</span> Customer Support System</em><br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" height=\"19\" alt=\"Powered by osTicket\" width=\"126\" style=\"width:126px\" />                                                                                                     ',NULL,'2017-08-03 10:40:50','2017-08-03 10:40:50');
/*!40000 ALTER TABLE `ost_email_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_email_template_group`
--

DROP TABLE IF EXISTS `ost_email_template_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_email_template_group` (
  `tpl_id` int(11) NOT NULL AUTO_INCREMENT,
  `isactive` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `name` varchar(32) NOT NULL DEFAULT '',
  `lang` varchar(16) NOT NULL DEFAULT 'en_US',
  `notes` text,
  `created` datetime NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`tpl_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_email_template_group`
--

LOCK TABLES `ost_email_template_group` WRITE;
/*!40000 ALTER TABLE `ost_email_template_group` DISABLE KEYS */;
INSERT INTO `ost_email_template_group` VALUES (1,1,'osTicket Default Template (HTML)','en_US','Default osTicket templates','2017-08-01 12:23:25','2017-08-01 10:23:25');
/*!40000 ALTER TABLE `ost_email_template_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_faq`
--

DROP TABLE IF EXISTS `ost_faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_faq` (
  `faq_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned NOT NULL DEFAULT '0',
  `ispublished` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `question` varchar(255) NOT NULL,
  `answer` text NOT NULL,
  `keywords` tinytext,
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`faq_id`),
  UNIQUE KEY `question` (`question`),
  KEY `category_id` (`category_id`),
  KEY `ispublished` (`ispublished`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_faq`
--

LOCK TABLES `ost_faq` WRITE;
/*!40000 ALTER TABLE `ost_faq` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_faq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_faq_category`
--

DROP TABLE IF EXISTS `ost_faq_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_faq_category` (
  `category_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ispublic` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `name` varchar(125) DEFAULT NULL,
  `description` text NOT NULL,
  `notes` tinytext NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`category_id`),
  KEY `ispublic` (`ispublic`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_faq_category`
--

LOCK TABLES `ost_faq_category` WRITE;
/*!40000 ALTER TABLE `ost_faq_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_faq_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_faq_topic`
--

DROP TABLE IF EXISTS `ost_faq_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_faq_topic` (
  `faq_id` int(10) unsigned NOT NULL,
  `topic_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`faq_id`,`topic_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_faq_topic`
--

LOCK TABLES `ost_faq_topic` WRITE;
/*!40000 ALTER TABLE `ost_faq_topic` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_faq_topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_file`
--

DROP TABLE IF EXISTS `ost_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ft` char(1) NOT NULL DEFAULT 'T',
  `bk` char(1) NOT NULL DEFAULT 'D',
  `type` varchar(255) CHARACTER SET ascii NOT NULL DEFAULT '',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0',
  `key` varchar(86) CHARACTER SET ascii NOT NULL,
  `signature` varchar(86) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `attrs` varchar(255) DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ft` (`ft`),
  KEY `key` (`key`),
  KEY `signature` (`signature`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_file`
--

LOCK TABLES `ost_file` WRITE;
/*!40000 ALTER TABLE `ost_file` DISABLE KEYS */;
INSERT INTO `ost_file` VALUES (1,'T','D','image/png',9452,'b56944cb4722cc5cda9d1e23a3ea7fbc','gjMyblHhAxCQvzLfPBW3EjMUY1AmQQmz','powered-by-osticket.png',NULL,'2017-08-01 12:23:25'),(2,'T','D','text/plain',24,'dWp_rMWtx86n3ccfeGGNagoRoTDtol7o','MWtx86n3ccfeGGNafaacpitTxmJ4h3Ls','osTicket.txt',NULL,'2017-08-01 12:23:25'),(3,'T','D','text/plain',3372,'5yPviU-pwIPGL_bskRm1ZkeZaTOJoTqI','U-pwIPGL_bskRm1Zw7xrOShcxnT7KL6A','Notas osTicket.txt',NULL,'2017-08-02 11:01:02');
/*!40000 ALTER TABLE `ost_file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_file_chunk`
--

DROP TABLE IF EXISTS `ost_file_chunk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_file_chunk` (
  `file_id` int(11) NOT NULL,
  `chunk_id` int(11) NOT NULL,
  `filedata` longblob NOT NULL,
  PRIMARY KEY (`file_id`,`chunk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_file_chunk`
--

LOCK TABLES `ost_file_chunk` WRITE;
/*!40000 ALTER TABLE `ost_file_chunk` DISABLE KEYS */;
INSERT INTO `ost_file_chunk` VALUES (1,0,'âPNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\⁄\0\0\0(\0\0\0òG\‰\…\0\0\nCiCCPICC profile\0\0x⁄ùSwXì˜>\ﬂ˜eVB\ÿ±ólÅ\0\"#¨\»Y¢í\0aÑ@≈Öà\nVúHUƒÇ\’\nHùà\‚†(∏gAäàZãU\\8\Ó‹ßµ}z\Ô\Ì\Ì˚\◊˚º\Áú\Á¸\Œy\œÄ&ë\Ê¢j\09RÖ<:\ÿèOH\ƒ…ΩÄH\‡ \Ê\À\¬g\≈\0\0yx~t∞?¸Øo\0\0p\’.$\«\·ˇÉ∫P&W\0 ë\0\‡\"\ÁêR\0\».T\»\0\»\0∞S≥d\n\0î\0\0ly|B\"\0™\r\0\ÏÙI>\0ÿ©ì\‹\0ÿ¢©\0ç\0ô(G$@ª\0`UÅR,¿\¬\0†¨@\".¿ÆÄY∂2GÄΩ\0véXê@`\0ÄôB,\Ã\0 8\0C\Õ L†0“ø\‡©_pÖ∏H\0¿ÀïÕóK\“3∏ï\–\ZwÚ\‡\‚!\‚\¬l±Ba)f	\‰\"úóõ#H\ÁL\Œ\0\0\Z˘\—¡˛8?ê\Á\Ê\‰\·\Êf\Ál\ÔÙ≈¢˛ko\">!Ò\ﬂ˛ºå\0N\œ\Ô\⁄_\Â\Â\÷p\«∞uøk©[\0\⁄V\0h\ﬂ˘]3\€	†Z\n\–z˘ãy8¸@û°P\»<\n\Ì%b°Ω0\„ã>ˇ3\·o\‡ã~ˆ¸@˛\€z\0qö@ô≠¿£É˝qanvÆRé\Á\ÀB1n˜\Á#˛«Ö˝é)\—\‚4±\\,äÒXâ∏P\"M\«yπRëD!…ï\‚\È2Òñ˝	ìw\r\0¨ÜO¿N∂µ\Àl¿~\ÓãX\“v\0@~Û-å\Zë\0g42y˜\0\0ìø˘è@+\0Õó§\„\0\0º\Ë\\®îL\∆\0\0D†Å*∞A¡¨¿ú¡º¿aD@$¿<B\‰Ä\n°ñAT¿:\ÿµ∞\Z†ö\·¥¡18\r\Á\‡\\Å\Îp`û\¬ºÜ	A\»a!:àbé\ÿ\"\Œôé\"aH4íÄ§ \ÈàQ\"\≈\»r§©Bjë]H#Ú-r9ç\\@˙ê\€\» 2ä¸äºG1îÅ≤Q\‘u@π®\Zä∆†s\—t4]Äñ¢k\—\Z¥=Ä∂¢ß\—K\Ëut\0}äécÄ\—1få\Ÿa\\åáE`âX\Z&\«c\ÂX5Vè5cX7v¿ûa\Ô$ãÄ\Ï^Ñ\¬lÇêêGXLXC®%\Ï#¥∫W	ÉÑ1\¬\'\"ì®O¥%z˘\ƒxb:±êXF¨&\Ó!!û%^\'_ìH$…í\‰N\n!%ê2IIkH\€H-§S§>\“iúL&\Îêm\…\ﬁ\‰≤Ä¨ óë∑êêOí˚\…\√\‰∑:≈à\‚L	¢$R§îJ5e?\Â•ü2Bô†™QÕ©û\‘™à:üZIm†vP/Sá©4uö%ÕõCÀ§-£\’–öigi˜h/\Èt∫	›ÉEó–ó\“k\Ë\È\Á\ÈÉÙw\rÜ\rÉ\«Hb(k{ß∑/ôL¶”óô\»T0\◊2ôgòòoUX*ˆ*|ë\ ï:ïVï~ï\Á™TUsU?\’y™T´U´^V}¶FU≥P\„©	\‘´’©Uª©6Æ\ŒRwRèP\œQ_£æ_˝Ç˙c\r≤ÜÖF†ÜH£Tc∑\∆ç!\∆2eÒXB\÷rV\Î,kòMb[≤˘\ÏLv˚v/{LSCs™f¨fëfù\Êq\Õ∆±\‡9ŸúJ\Œ!\Œ\r\Œ{--?-±\÷j≠f≠~≠7\⁄z⁄æ\⁄b\Ìr\Ì\Ì\Î\⁄\Ôupù@ù,ùı:m:˜u	∫6∫Q∫Ö∫\€u\œ\Í>\”c\Îy\È	ı\ ı\È\›\—GımÙ£ı\Í\Ô\÷\Ô\—7046êl18cÃêc\Ëkòi∏\—Ñ\·®\Àh∫ë\ƒh£\—I£\'∏&\Óág\„5x>f¨ob¨4\ﬁe\‹k<abi2€§ƒ§\≈\‰æ)Õîköf∫—¥\”t\Ã\Ã\»,‹¨ÿ¨\…\Ïé9’úkûaæŸº\€¸çÖ•Eú\≈Jã6ã«ñ⁄ñ|\ÀñMñ˜¨òV>VyVıV◊¨I\÷\\\Î,\Îm\÷WlPWõõ:õÀ∂®≠õ≠\ƒvõm\ﬂ\‚è)\“)ıSn\⁄1\Ï¸\Ï\n\Ïö\Ï\Ì9ˆaˆ%ˆmˆ\œ\Ã\÷;t;|rtu\Ãvlpº\Î§\·4√©ƒ©\√\ÈWgg°sùÛ5¶Kê\ÀóvóSmßäßnüzÀï\Â\Z\Ó∫“µ\”ı£õªõ‹≠\Ÿm\‘\›\Ã=\≈}´˚M.õ\…]\√=\ÔAÙ˜X\‚q\Ã„ùßõß\¬Ûê\Á/^v^Y^˚ΩO≥ú&û\÷0m\»\€\ƒ[\‡Ω\À{`:>=e˙\Œ\È>\∆>üzüáæ¶æ\"\ﬂ=æ#~\÷~ô~¸û˚;˙\À˝è¯ø\·yÚÒN`¡\ÂΩÅ\ZÅ≥kô•5çª/>B	\rYrìo¿Ú˘c3\‹g,ö\—\ ùZ˙0\Ã&L\÷éÜ\œ\ﬂ~o¶˘L\ÈÃ∂à\‡Glà∏iô˘})*2™.\ÍQ¥Stqt˜,÷¨\‰Y˚gΩéÒè©åπ;\€j∂rvg¨jlRlcÏõ∏Ä∏™∏Åxá¯EÒót$	\Ìâ\‰\ƒ\ÿ\ƒ=â\„s\Álö3ú\‰öTñtcÆ\Â‹¢π\Ê\È\ŒÀûw<Y5Yê|8Öòó≤?\ÂÉ BP/O\ÂßnMÚÑõÖOEæ¢ç¢Q±∑∏J<í\ÊùVïˆ8\›;}C˙hÜOFu\∆3	OR+yëíπ#ÛMVD\÷ﬁ¨\œ\Ÿq\Ÿ-9îúîú£R\riñ¥+\◊0∑(∑Of++ì\r\‰y\Êm\ ìá\ ˜\‰#˘sÛ\€lÖL—£¥RÆPL/®+x[[x∏HΩHZ\‘3\ﬂf˛\Í˘#Ç|Ωê∞P∏∞≥ÿ∏xYÒ\‡\"øEª#ãSw.1]R∫dxi\“}\ÀhÀ≤ñ˝P\‚XRUÚjy\‹ÚéRÉ“••C+ÇW4ï©î\…\ÀnÆÙZπcaïdU\Ôjó\’[V*ï_¨p¨®Æ¯∞F∏\Ê\‚WN_\’|ıym\⁄\⁄\ﬁJ∑\ \Ì\ÎH\Î§\În¨˜YøØJΩjA\’–Ü\r≠Òç\Â_mJ\ﬁt°zjıéÕ¥\Õ\ \Õ5a5\Ì[Ã∂¨\€Ú°6£ˆzù]\ÀV˝≠´∑æ\Ÿ&\⁄÷ø\›w{ÛÉ;\ﬁ\ÔîÏºµ+xWkΩE}ın\“\ÓÇ›è\Zb∫ø\Ê~›∏GwO≈ûè{•{ˆE\Ô\Îjtol‹Øøø≤	mR6çH:pÂõÄo⁄õ\ÌöwµpZ*\¬A\Â¡\'ﬂ¶|{\„P\Ë°\Œ\√\‹\√\Õﬂô∑ı\ÎHy+\“:øu¨-£m†=°Ω\ÔËå£ù^Gæ∑ˇ~\Ô1\„cu\«5èWû†ù(=Ò˘‰Çì\„ßdßûùN?=‘ô\‹y˜L¸ôk]Q]ΩgCœû?t\ÓL∑_˜\…Û\ﬁ\Áè]ºpÙ\"˜b\€%∑K≠=Æ=G~p˝\·HØ[o\Îe˜\À\ÌW<ÆtÙM\Î;\—\Ô\”˙j¿\’s\◊¯\◊.]üyΩ\Ô\∆\Ï∑n&\›∏%∫ı¯vˆ\Ìw\n\ÓL\‹]zèxØ¸æ\⁄˝\Í˙\Í¥˛±e¿m\‡¯`¿`\œ\√Y\Ô	áû˛îˇ”á\·\“G\ÃG\’#F#çèù\r\ZΩÚdŒì·ß≤ß\œ\ ~Vˇy\Îs´\Á\ﬂ˝\‚˚K\œX¸\ÿ˘ãœøÆy©ÛrÔ´©Ø:\«#\«º\Œy=Ò¶¸≠\Œ\€}\Ô∏\Ô∫\ﬂ«Ωô(¸@˛PÛ\—˙c«ß\–O˜>\Á|˛¸/˜ÑÛ˚Ä9%\0\0\0tEXtSoftware\0Adobe ImageReadyq\…e<\0\0(iTXtXML:com.adobe.xmp\0\0\0\0\0<?xpacket begin=\"Ôªø\" id=\"W5M0MpCehiHzreSzNTczkc9d\"?> <x:xmpmeta xmlns:x=\"adobe:ns:meta/\" x:xmptk=\"Adobe XMP Core 5.6-c014 79.156797, 2014/08/20-09:53:02        \"> <rdf:RDF xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\"> <rdf:Description rdf:about=\"\" xmlns:xmp=\"http://ns.adobe.com/xap/1.0/\" xmlns:xmpMM=\"http://ns.adobe.com/xap/1.0/mm/\" xmlns:stRef=\"http://ns.adobe.com/xap/1.0/sType/ResourceRef#\" xmp:CreatorTool=\"Adobe Photoshop CC 2014 (Macintosh)\" xmpMM:InstanceID=\"xmp.iid:6E2C95DEA67311E4BDCDDF91FAF94DA5\" xmpMM:DocumentID=\"xmp.did:6E2C95DFA67311E4BDCDDF91FAF94DA5\"> <xmpMM:DerivedFrom stRef:instanceID=\"xmp.iid:CFA74E4FA67111E4BDCDDF91FAF94DA5\" stRef:documentID=\"xmp.did:CFA74E50A67111E4BDCDDF91FAF94DA5\"/> </rdf:Description> </rdf:RDF> </x:xmpmeta> <?xpacket end=\"r\"?>ã˛ˆ\ \0\0IDATx\⁄\Ï]	úS\’\’?/{2\…dfÄaqê]67\–œ≠(*®-\nˆÛ≥∂.ı+\÷÷Ö∫ nµJ¡≠ˆSãR¥\’:VDT§,e\—2®lÇ†¨Ç\Ïã3\Ã\¬Líó˜›õ¸os\ÊNí\…Pq\Ã˘˝$ìó˜\Óª˜¸\œ˘üs\Ôª1ÜNY96§\⁄t\“\ÿ\Ó\ÔS±/Q\ƒ˝]k~K°ìÖ\Ózõ\–\Ìç>É%4ﬂ§\“5∫˙≠<≤\Ÿ,≤\ÕclmYÛ\Œ\ íÑû\'Ù\«BØhÙ∑£BÛLZ∏\ﬁM?õ§∞\0]sôG\÷>æ\◊\‚Z(4W®]h\r\"“æ&F4ô]ç˛∂?JKD$˙F>Yd-}QäZY†e\Âª)≠Ñû*tÄ\–”Ñ∂\Í\‡$ªâ\r	=(tï\–\ÈBg	=ê¡π\Ì¯_Ç¥¢—îQ\0m\∆V\Ì+≥SèvaäDõW\«gÅˆ˝êéBØ˙øBªe¯ù\ﬁBØ∫L\ËH°\“õ#tÛªB\«	˝mFWí\0;t\» _é\Ÿ\Ï@ñ\Õ—öøxÑ\ﬁ.t!ø[\Œ!#\‡\\°˜\„|\…\‰Wàí:˜\ÿ\rG≥†I≥∑9\Èâ\“* ç6ÀÅ\»≠˘Jk°SÖ˛A\ËqG¿Nçº\09ù§õEB\ÔMπ~-4?Ìôù\’~\„†Iã}\‘&∑y\ÂeY\Í\ÿ¸\Â°o\n\ÌuÑ\œ{.rªΩBk∏\÷iv?äó˙LG∑¥—îµj\»-+\ﬂëQÊï£\02%>\‰|ô\ \Ô(^\Õõí\ﬂ\n\ÍX\Ëè\∆r≥\ÊT\“\œR\«\Ê-í*ˆˇñÆ-\„\—R°ÀÖV±ø\ÀBI\À:G\ T\Ã#˛\…5i˛\ZE\"FÛîlD;\Ê\\_\‰pæ˝sj\ dÒëìıB\"tá\–B)Ù2\‰w\ﬂ\ƒ\Ôœäª˜`î\Ê≠Ù–§ï^ö∂\—MnA!ç\Ê<¨Y\À>Üºû•íÌßêˆ\n´ktıM\ÊJw%˘ªú<.ˇ\›\¬\√BøU\\GÒBI?Á¶ì]\0\Ão\∆\–Ù\Â^˝Ù•∫eFê&.˜ë\◊aë\«a5\Ô±Õö˜±#“£o>§ê=L^´\—˛]Féû\⁄\ﬂJÖN\0ÉGπ˘„ÖæVá\Z˙¢!q#!\≈ñ\€\È¿6=X\Íß9õ\\T2\»Ô≤®{´ôc\—Êç≥,–é)zak≥l¥˙@1ı\œ\ﬂ{ù°Ñ^£˝MFî°_b\’\Ê(7˝9°£≠ë+\'J´\÷{hÒón\Íê°[\\ÙhiµÛGc41\'\'±M\Î˚1∂é≥\œ>;k\·«êLõøå\ﬁ\‹›ã˙∑\ÿ$\‹|\∆~,äó›ïîx\ﬂ ∂l\⁄\‚(4W.\”\ZAj’à\¬rù\‚\„sr\…Wùµ\…M\–Wîr\›\"zµhû´>≤\Ì;ôßYîÁ™äE,è0ﬁå\\æ\\1\Ôb\Ô∫Ø\Â\"\·\'Ñæë¡x\À¸\Íu\–LY\Ã»£x9\ﬂ)¥˘^[\0õPÙXV\ÁÇNX\·•ÕªùT(\"Yè∂âuã\ﬂWêeÅvä›àRU\ÿC55AÚ\ÿCô\–GY6?ëΩˇ@\Ë´\⁄1kÑVS|Ç9ù\»I\ÓX\ \Ë£\ƒ*êrD\ \"ÄˆL°ÉÑŒé=*@4\È´=N\ wZjâ9æ%p\…ˆ\ %a\ÌÒ~è\–yBeÅñïò¯Ìµ¥¢¢\rï\Ï\ÏK\√;HT\Îo\Ë+É)æQ\…_≈∏t°\‘\ÎâcI\ÏUû»±B\"îV⁄™\»Vg>L\ vW¶S\‚1õ|ÚXª∂\Óp—∞\…y¥Ì†ùZx£rR≠\≈\'∑#†∞)˝\≈WöH™[ ‘çˆ\ ∫±	\›(#Ú=B2ä˚C°€≤@\ÀJL,H$\À›µ(ÒüN)2ö©∞\'øõ‰òÆ\Zµ\‘/*\œ\'rZüKD\‹˚Vù((\ﬂ\’g	å≤≈õ{Ä\∆Pì]aY\« πjﬂä=B≥ù\n\"4~nÄVnwR˜∂ëXéFÒUˇrQsŒêJd\‰\‹\ZzæÙ7\"\‡y°7e©cVéä∏™\È˝Ω\›\Ë\‰\‡\Í%îB˛T`\ÀÖSÚO\–;]NNy±X\ﬁz7\‚∂s¥\—}ÛÙ\‰á~j/®ﬂ¨\rn™¥∑\“F\√z\◊\–\»*à\ƒfñ€âÊ¥å5)\◊\‹Eû\Ë°EK|Ù\÷j∑4\»˘4\rI.Ú¬ñîx∂\Õ\€\ƒ.åj¿6à®GJéG_˜Ü”òëZz1`Nx\„Pä\„<8¶^˛\»$6ìv\‘hUYı\n\ÏçG∂\‰Ûjrﬁ¨/^\ÔDé•ã§a\›Sö£€öIm¬∑Lúï\Z˚^ fùùZ\ÀÜA36∫ck†\Â{,\Z9†R‹±@WµQ%†∞Z\‰dÛ∑\◊\„WmˆÜoûñ\'rKä\«JˆäˆU0\√7YﬁßD~&*Ø\ÿÚ\—ˇïá1~ˇ\ÈÖ&=PH:	\Ô\«eÅ÷∞»Å~πè|\‘d4≈ü:\Ê“á\‚\Î\n\€\„ò{é\‘≈£T«π+h≤,Ûãà\÷9ww™\Õz\‰¸X\0Øø˝\“\Â-áKÄ\ÃN/R\€\Õ\œ\Ã\Ã\r\›3-HÖÅh+üapymv+\“\ g…ß•7∑ÚE#Û∂:\È\Íí*πÚÄ\€\ÍZ;x˘\◊ŒÅw\…*âØKq®8W\‡QÄ\ÃÄ»∂<{Xû&ù“£îxPTR\œ;Pƒë ¸#úóõö≤%¬∑\'\Ì\»H/ºdÅñ¢&AÒy©¯?ôï†≤\ÂLj»á6\·ê=\"≤9°t9\Z_®ª2I$\€ı\0\ÈK\Ì,\⁄-\"\Ÿh≤û˘g.\›˛v∞∞8ﬂº\…aã=®Ÿû]MV*D-z≤c0:Úz7y\ﬂ…£GœØ(/y=ø|“ß^[π”∫∂ca\‰qÅ>—∫Qjã\–\«)æbDóØ\ŸkyÉüJ@\„˝\÷cò\Â§Kñ∑°†£leh\rKÑ\—\≈)®\„Axn˝vçF8\rìJ∂ùBww*%Gl^ÕñÃã*˘D˚LV\‹˛Ü™ ó)Q\”x¿\Ê1\◊NTÒ7o\Êù\—.\ﬂ|\ŒeßS¢V\Ï>^Ñ\—\»¸\ËB/ë\Zé“Ω\«\ÕqSE\ﬁˆ\≈>;-\ﬁ\Ó41˙tØˆ°¶iD\≈Áìç8Uî}\'\—\"ÙOB\œzùñ#Òú\Õ\≈\ﬁw¢¯ñv8;πÑ\ÏI∫F>\»:‘π≥„∞Ä\‚O4D\Â\Â≥róÇ\÷\·å\∆S\›mÚ.¶¯F!%¶8‰äõI¨Çy\"˙∫ìÜßã\·Ñe\€*H\‡NE\√f£t5\≈\ÁK#¡ÆLíõB\‚\Á\≈E¡3\„\Ÿ6Pï†\À˝$äV72ˆ\„;\‹\ËP\"1˙√ì»π†˘\‡Ú\ƒ°⁄πÉ\‘\\y®\’ \‰(™rˇ\"™W≤>ùïÉ™\›z˙SÒ}ã\Í|?Aü\»6N£¯äyŒãp9H´í\0¢≠ä\ƒ6\¬1ã6 ßP\‘Z}i\Õ\"ßç≤R7\≈%í\ﬁO\ﬁ\Ëƒç˚\Ì—ãkCU!j/@61\‡≤z	\ \'Ûâ[Ñ~•\Âw◊£˙7V\0q_Æ+ˆ}\Íòo^e4\"6∂âéΩ¬®ÙsÑ˛∂Ù!\≈\◊\\r\‚\ kûJN≠TÚó$@ìQ˜N™øÆS\…˘†•\È\Ê\Ã$yZ(_ı:\Î{\È¿\‰W,î§\r∑/Éπuπ\Zs\÷xÜ\Á—∞qh\Ë\ÿ\ÊÇ\Á´\–.ü\ﬁ}	ûäã\Ïg(æb[\Z\÷sL7\„¸RF°\‰+Ø%°(¡\ﬂG\√8\"4§rÅ\Í)\⁄5V\¬Ç6Iè\ŸFı\r:\Ô XR>9±\⁄Q;G)⁄¥\Ô\Ô¶¯¿^ñ\”L»∞R\∆#ã\Ã\”.c\‡/¬†ı¿5/d\‘Izf9π,\Áõ\Ê}Og+>{8æ≤æxq\Ô*\Í\Ó¿kπÇ^\ﬂZ`5¢\ rπu¿\‹u˙∫ †æ\Ë\"íIê\ÕE[uTã\\µ\n\—qå\»\ﬂf\Â∫-\Èœµ\‚Õ∫/I4%8¥{0\∆7\"W+k†´ºTÖåGa_\ÈdC:∂ˆ®2\Ÿ\∆\·∏\ﬂv\0\›Y\ÏÛµ\»-ª£\ﬂ{¿∂˙0«üN\Ï6V˝Ò\¬\‡˚!1˝öyàö\0@ÅLFôy\Ë@:ˆ:x\Ê:¨/+Eü√Æu.^f=0	≤W\»V\"bÖ¶K\–5¨3G†\ÌÑht∏#¿+¡ı>?˜\‡«Ω=Çˆò0é}0û\Œt†…º\◊¥u\r˛Và∂\ 9¨)åft—º~;ºûWü9Xt\»t∆ä#)\n6Ex˝9r¢Û\·8∏º\Î_KÄ\Ã•g\Ëëó\ÊD˚äú\Ï¨öø+	»∏º\nê\Ï\·Z≠Ù˛uö\Ô-@\ﬂG\›L\ Ú©¢\›M\Z\»\¬`\“Ò^NÒ\rÇ^F•»´	\«\›\»\ﬁ\œ` #∏\ŒbL\ÂFD\⁄~îx÷é@7üÑ\”:\…\€˛!lÚ1¿l\Zóï\'˛9@p)ãb\·PbN\ÊUPÆÛq¨\‚¨˜Ò˛tÄ\Ë8ùí\"ñ\'™\r\\&!¬™≤∑\„&OGG◊Çb\ﬁnf`]\ 0\Á\ËN=m?ë\œkı\¬\Î\€X\ÔF$?µ±2¸bP\n±¡ÿïp∂0ò\Î{ıEAohøå|Æ\Íd˘Y\Î∑E,\«qjQeò0\◊\ÌT`\“\ÀK|4bf.\‰D\…fãıáå\⁄o≥\ËûN\‘D¯√Å™\“˝=l,uŸÅ1π\\£§çïv\ﬂUããº\ÓP∞öw¿BÆG_˚)1ß\0ªNüo©∞Å°ñ•C\ÿ\Á\ƒ\∆\Á&“Å˚\ÿÁóÅ\Õ<Pq~ˇ6™Æ≤ùcmZòû¿\Êb>\∆	î\\£UÜÒ£ˇÇ\' ¯y¯>!‹∂Fæ\‰G¥,\ÕG\‰≤\ MO\…f \ uQ\Á\Ï¿\’\‡˝nx™©àä™HrL<\‹4ä?f/\Â†qR¶É\ÍJ øç…§%e\"£â\»2és!÷ßå!®Ø\'Û~\À\Îp\r#Je\Âπ+R=uù\À˙m£^JæÇUí|®≤\ F\ÔopìCºˆ˙(h_oI3ô\Ã]puB4˚+Æq.¢\÷Cóç∂I[\ŸIMõgTm(ã¸FÚáFúg/\"\ÍXñ∑ÆAˇ]ôØ\03#∞®)I\Œ5\„≠r\ÿ¨¿c”®} ™\„G\⁄˚Ö@©@Qæ|\0∫\¬E(àNëû\Âwî\ÿÃ•˛uD\ŒK\0ñ˛h\‘*\‰Y™C•.É1\€\‡UrX4<ûy¢\≈Ãê;≤\»˘_Bø@áD1p~mx\ﬁV\ÀﬁØ\Ëªg¥5ZeÚ+x\–\„\‡H∂\Ã\'\√P\rDÈæ¨ü\ÎÄlw≠ü˙ˆP\Õ\Ãd˘x\Ï>]h˜¸≠Bã∞õ\’Gºæ\‘GØ≠R∑¬à|\»\“`˝ú\ÈèQ\ÏÅ\Ív¢\€”†¿BøÜC,EÓ∂àRO¯g*µ˜/6Ú˚9†p™8!ƒ≠å\ÊÏîØ†q\"BZ45xH2≈¢-G:†ôI83%©æ\’$ÒÇ|ôãaY\€\0<‹¥§ZΩ\»W≥õ\ÿ0\Ï&™\—\Ê\œaTn\Õ\‡Uπ\ÿ√¢\”Ztöù¶ep™\Z\ÿ\‘i#EøôåF®6\Œ˝\È*\€\Ì\\\ÁÛoæ≠&H\'	ê=\–c6πm\"ƒ∂6®W\È\∆\‹JVQSq*Í≤®bßì¶,ÛQõ†©ûd∂±{\Œ4\“{r≤±\ u!∆≤\Ë\◊F°n£¶-Ëµí\Ãñ7aÆ\ÌL≠∏ëÉ\Í7i@\„{PûLÈñÆ%$ê\¬(\–Ù\'q˚∞c∂Ä\√w`ûî`@˘à5	¥eˆ¿∞\‘\„\Zó≤\»Ú9¿f’£°öóV%ıÆØ¢ìùM(ñ√´˙q\Œa˙\Ísæ\ﬂ˜QÄ\Ë®w^\Àìw\“\nRZ0«≤ãE\ÕO\‡tn`≈á\≈Ëó∏eY=\ﬁm.˘˜í\'2_™˝CN`∆Æä(!ñk\«˚M\–ƒç˚4uùõ∫%º4)±èH¶[¯\–/™;ı˝}\\å˛8õ*\‰X¸å\‘=Mwh\r\Zt\n\—\\\'\"\‹\n∆Ñ\ÏZ~M3µÅ-9\Ÿ8\⁄R8â§gÜ_@uWN¿\Ê4∫≤Íìöœπõ5b5\ÀÛT^RcSVhßb\‡>b\0#\‰è\ÿ5:°,˚w\ÃcTß®Pmaù\◊˘¢˙º\'¶ ˛E	e0\√X‘éBIãFx\\yæï¿U\Ïı\"≠8°ré\„ı[¸ÑE\ﬁr:!5àdIAñ\«h\Ì\'Z4Wt∞∂Å∂Øg\Œ4ÈÜ≤ˆv\‰<\«Q˝]à-Ùˇ\\\‚\ÿA(5`m,Ø	Áöå¬âíV®\Z˙XdØ\—*¶\ÁPbéı<¶B%+˚#c.V*†\È\ÌPéîò,V’ôy(:å\0∞F#\"|Fu7Üô¡™l+\0(øñ¥\Ô≈ÄÙbÛü≤Ç\Ã`x⁄óPR˝7’ù*)˘.^U(\Ë\\éŒúä˜;Ü∂ËÑ´P–ô\0Éyó\Z¿ô\Í\«Ò\Ë¸\0àj\À\Ï8ôß˝\Z\«\–Ûì\ﬁ\›y\ŸdÖQ\Êe©üÆZÛ	\∆EO¿∑˝\€h\¬u)à\–\–Óµ¥hª3∂!õ[SU\ƒ\'®\·_åàq¸¢ı\«(.˝îROØB\—bÚ∫Wõ—∂h\ÔØ‘ãG\r\»N´\÷¿)û\Œ\Ó\È|V¶F¸hˇ¡&D]\ÓÙ\ÍE4 kèy6hw\‚ı†=\ﬂ\‡\ƒ?D©Ω\'õ≥πïu¸b-\·Ts˚òGï≤îy≠yà¨`8ó¢\ﬂ\«<Ö\na+V\¬\rh˜2	Ûxö´1\◊—ñMAºÅyó)l\ﬁk$∏¸≥¨Hë\√yô7¸˝t\r¢ïj\ÀHÙ/6-\”J¿u&<}\"¢Qƒïn@{≥jK\Zµ.`-N±B⁄Ü\Èö”´hµM/^ïÇù\\ﬂÄ1vS\√/GJPî!Ω6#¢Ω£9∂:Cb˝±ˆÄ\ÊDƒçR\›_\Ã9ç¯ÜC\rã˛SU]SE4;ºÚ\–B™oØ\"¢(˘¯˜Px)\'å\ÂÃµp ≤\‘	ﬁù”ú{àP\Ô4	˛\Â0,@:\—LïçÅ\\j\’_˘g˘08Ç0\Ócã\"!\‹\Î,x77ÆÒ\Z\nùùd˚\"~Åh\‡É\Áì\Á∫˘\ﬁ~Pï9I∏˝,FS\Á\‘;km@F2?\n%˚5z|:˙∏5h\–D\Ì\€C\ÿtG\¬TETì\Â}-˛\Àqz\Á{\n•˚iI\Ó≥Qø3˛#\Ê\Ãdt˛-\∆!\ŸDWD\“#w#e&∞ö\ZÒ¿QND˚wÅïÄ›îj\Ìq≤¢\‘{p§£kõß£+‹è{gZ«´r–•l´¡\"¸lém$l\€p$I?Ä1ª`<\…¯\À:$ì\Í\ÏBi\ÊbñBìùc]ö\Œ›Äk8qç∞vçCîdíWì\ËxU\ﬁ\'πyûø¿°¨†Qí\È.à=oÖÅ3µÅVÖò %ñ˛|Fı\◊=äV\ +≠û$ãE\'^9Oı7K\Ì\œLıÉËΩ≤ZÖ\‰»´≥I\Œ4x¯áa∞\œ\¬Aï\·>\Œ\ƒgù–è∑≥≥æ\0`_c:\Z¡ò\rF¥(D\‰ù~@3—∑3)±æS:∏\ﬂ _?µÄì\\®M)\Ë¥\Ó8\÷~x/\∆\Ô¡\∆F!\’Pn\Èp/ÿΩ\Â\ÿ%h[p›ãXes,⁄æƒë¢\nieêL\”ò\…D˜ÅJKKrè\÷uîAò)J¿w\"ˆd¥±˛Ú•x^∂\Ã\‚W\»˚\np\”\…\Ê$π\∆\0D˜(¢-ã]ù]¢\”:Ühkπù\ÁiÑ¸d3˛ø™èÒ+\Ó;\ÿ\ﬂUn˛4\nK…∂P(P\«h˝\Î\◊\n;^ª∆≤î,]|ûÑXæÀ´±Tw	Vû\∆\ﬁv\0ºu™øè‡æûbS(¡\’ŸñZ?=g`xí\⁄—°5¿MY9\ZíÉ\\SÅl3®e:Y	j\ÊBn©v°J5ós˚z\“ùS\–\∆.\'\‘\“%õjhÃúÄ\0Z=_\Z¢Û•òˆh`oe[ö\‚∫\À)Ò#Ò2ßi∞\ÏùüM\…7◊ôébV˜ı´ÑN@tÚS˝_]ä\Î˝ˇwfHuÕôHe¶\„m\–\Èˇ\€Hk ZµD€Ω¯\Ó\'(òùÉäπNTª\Á|_;\Á\"¥\ÎVJLç…îiæÒÚ\À/˜Bhå†ë≥∏8\‚\"©\∆/\·!w\¬˚ö\Ï¿\Î\ F5\Â¸vT!+Q¡≠/AìFO“ò\“\Í4õCü\Zp0jCï\nJ\Ã\'6∏£Qö~\‘7vD3/\ÿB5®™\’@\€Z p\…\„\À˛_Ä\0≥‡Øòs]J˝\0\0\0\0IENDÆB`Ç'),(2,0,'Canned Attachments Rock!'),(3,0,'	NOTAS osTicket\r\n	\r\n- S√≥lo se pueden asignar tickets a AGENTES o EQUIPOS del DEPARTAMENTO al que pertenecen.\r\n- Los DEPARTAMENTOS se pueden anidar y ser asignados a tickets en funci√≥n del tipo de √©ste.\r\n- Un AGENTE s√≥lo ve los tickets del DEPARTAMENTO al que pertenece (y los subdepartamentos) y de los que tiene acceso ampliado.\r\n- Los USUARIOS abren tickets y los AGENTES los gestionan.\r\n- Un AGENTE puede abrir un ticket por un USUARIO.\r\n- Un USUARIO s√≥lo puede establecer el tipo de ticket y rellenar el formulario asociado.\r\n- Un AGENTE, al abrir un ticket, DEBE especificar un USUARIO (puede no estar registrado y se registrar√° como invitado) puede cambiar el DEPARTAMENTO preasignado, especificar el AGENTE, la v√≠a de apertura (correo, tel√©fono, etc.), especificar el plan SLA y la fecha de vencimiento. Al comenzar la apertura se muestra una ventana de selecci√≥n de USUARIO.\r\n- Un ADMINISTRADOR es AGENTE tambi√©n.\r\n- El CORREO saliente para notificaciones se configura en el apartado \"MTA por defecto\", escogido entre la lista de los dados de alta.\r\n- Cuando un ticket CADUCA simplemente es marcado como tal, pero esto ocurre si hay actividad en la web.\r\n- Desde la interfaz de USUARIO no se aprecia apenas ninguna diferencia entre un ticket RESUELTO o CERRADO. En ambos estados aparecen en la secci√≥n CERRADO, tanto para AGENTES como para USUARIOS, y estos √∫ltimos pueden reabrirlos publicando una respuesta.\r\n- Se pueden configurar los estados de los tickets y determinar en qu√© estados se pueden reabrir.\r\n- Cuando un agente cierra un ticket, √©ste le queda asignado. Sin embargo esto no sucede al reabrirlo.\r\n\r\n\r\n	PROPUESTAS\r\n\r\n- ¬øPrioridad por tipos de tickets? ¬øM√°s prioritario Incidencia que No Conformidad?\r\n- ¬øDejamos un campo \"Asunto\" en el formulario a modo de t√≠tulo? Facilita la presentaci√≥n de la informaci√≥n.\r\n- Los mantenimientos se pueden programar con TAREAS asociadas a TICKETS.\r\n- Para caducidad de tickets:\r\n	¬∑ Establecemos una jerarqu√≠a de departamentos y aprovechamos el soporte que ya da la aplicaci√≥n para establecer un gerente en cada uno de ellos, de manera que 	ante la caducidad de un ticket podamos asignar el ticket al gerente del departamento superior y al departamento en s√≠, si lo hay. \r\n	¬∑ Ante la caducidad de un ticket se notifica a la persona deseada en funci√≥n del n√∫mero de veces que ha caducado. Requiere apuntar contador de caducidades en cada ticket y orden de aviso en cada AGENTE.\r\n	NOTA: el perfil de gerente s√≥lo existe para recibir notificaciones, no tiene funciones especiales.\r\n\r\n	\r\n	\r\n	PENDIENTE\r\n	\r\n- Identificadores de tickets con el a√±o\r\n- Jerarqu√≠a de localizaciones (√°reas y localizaciones)\r\n- Asignar como USUARIO un ticket directamente a un DEPARTAMENTO y a uno de sus AGENTES\r\n- Reasignar tickets atrasados\r\n\r\n\r\n\r\n	NOTIFICACIONES\r\n	\r\n- Asignaci√≥n\r\n\r\n\r\n\r\n	IMPLEMENTADO\r\n	\r\n- Asignaci√≥n de agente directamente por el usuario desde la apertura de ticket, con la notificaci√≥n personalizada por correo al agente.\r\n- Caducidad de tickets con notificaciones consecutivas (varios SLAs por ticket).\r\n- Notificaci√≥n por cierre de tickets al agente escogido.\r\n\r\n\r\n\r\n	BUGS\r\n	\r\n- En la b√∫squeda avanzada de tickets no siempre se llega a los resultados tras realizarla. En ocasiones se queda abierta la pesta√±a Abrir en lugar de la de Buscar, pese a que la b√∫squeda est√° correcta.');
/*!40000 ALTER TABLE `ost_file_chunk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_filter`
--

DROP TABLE IF EXISTS `ost_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_filter` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `execorder` int(10) unsigned NOT NULL DEFAULT '99',
  `isactive` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `status` int(11) unsigned NOT NULL DEFAULT '0',
  `match_all_rules` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `stop_onmatch` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `target` enum('Any','Web','Email','API') NOT NULL DEFAULT 'Any',
  `email_id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(32) NOT NULL DEFAULT '',
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `target` (`target`),
  KEY `email_id` (`email_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_filter`
--

LOCK TABLES `ost_filter` WRITE;
/*!40000 ALTER TABLE `ost_filter` DISABLE KEYS */;
INSERT INTO `ost_filter` VALUES (1,99,1,0,0,0,'Email',0,'SYSTEM BAN LIST','Internal list for email banning. Do not remove','2017-08-01 12:23:25','2017-08-01 12:23:25');
/*!40000 ALTER TABLE `ost_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_filter_action`
--

DROP TABLE IF EXISTS `ost_filter_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_filter_action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `filter_id` int(10) unsigned NOT NULL,
  `sort` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(24) NOT NULL,
  `configuration` text,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `filter_id` (`filter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_filter_action`
--

LOCK TABLES `ost_filter_action` WRITE;
/*!40000 ALTER TABLE `ost_filter_action` DISABLE KEYS */;
INSERT INTO `ost_filter_action` VALUES (1,1,1,'reject','[]','2017-08-01 12:23:25');
/*!40000 ALTER TABLE `ost_filter_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_filter_rule`
--

DROP TABLE IF EXISTS `ost_filter_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_filter_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `filter_id` int(10) unsigned NOT NULL DEFAULT '0',
  `what` varchar(32) NOT NULL,
  `how` enum('equal','not_equal','contains','dn_contain','starts','ends','match','not_match') NOT NULL,
  `val` varchar(255) NOT NULL,
  `isactive` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `notes` tinytext NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `filter` (`filter_id`,`what`,`how`,`val`),
  KEY `filter_id` (`filter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_filter_rule`
--

LOCK TABLES `ost_filter_rule` WRITE;
/*!40000 ALTER TABLE `ost_filter_rule` DISABLE KEYS */;
INSERT INTO `ost_filter_rule` VALUES (1,1,'email','equal','test@example.com',1,'','2017-08-01 12:23:25','2017-08-01 12:23:25');
/*!40000 ALTER TABLE `ost_filter_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_form`
--

DROP TABLE IF EXISTS `ost_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_form` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) unsigned DEFAULT NULL,
  `type` varchar(8) NOT NULL DEFAULT 'G',
  `flags` int(10) unsigned NOT NULL DEFAULT '1',
  `title` varchar(255) NOT NULL,
  `instructions` varchar(512) DEFAULT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_form`
--

LOCK TABLES `ost_form` WRITE;
/*!40000 ALTER TABLE `ost_form` DISABLE KEYS */;
INSERT INTO `ost_form` VALUES (1,NULL,'U',1,'Contact Information',NULL,'',NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(2,NULL,'T',1,'Ticket Details','Please Describe Your Issue','','This form will be attached to every ticket, regardless of its source.\nYou can add any fields to this form and they will be available to all\ntickets, and will be searchable with advanced search and filterable.','2017-08-01 12:23:24','2017-08-01 12:23:24'),(3,NULL,'C',1,'Company Information','Details available in email templates','',NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(4,NULL,'O',1,'Organization Information','Details on user organization','',NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(5,NULL,'A',1,'Task Details','Please Describe The Issue','','This form is used to create a task.','2017-08-01 12:23:24','2017-08-01 12:23:24'),(6,NULL,'L1',1,'Ticket Status Properties','Properties that can be set on a ticket status.','',NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(7,NULL,'L2',1,'√Årea Properties',NULL,'',NULL,'2017-08-01 14:59:58','2017-08-01 14:59:58'),(8,NULL,'L3',1,'Categor√≠a Properties',NULL,'',NULL,'2017-08-01 15:01:25','2017-08-01 15:01:25'),(9,NULL,'L4',1,'Tipo de localizaci√≥n Properties',NULL,'',NULL,'2017-08-01 15:02:32','2017-08-01 15:02:32'),(10,NULL,'L5',1,'Localizaci√≥n Properties',NULL,'',NULL,'2017-08-01 15:04:03','2017-08-01 15:04:03'),(11,NULL,'G',1,'Notificaci√≥n y cierre de desviaciones',NULL,'',NULL,'2017-08-02 08:03:27','2017-08-02 08:03:27');
/*!40000 ALTER TABLE `ost_form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_form_entry`
--

DROP TABLE IF EXISTS `ost_form_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_form_entry` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `form_id` int(11) unsigned NOT NULL,
  `object_id` int(11) unsigned DEFAULT NULL,
  `object_type` char(1) NOT NULL DEFAULT 'T',
  `sort` int(11) unsigned NOT NULL DEFAULT '1',
  `extra` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `entry_lookup` (`object_type`,`object_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_form_entry`
--

LOCK TABLES `ost_form_entry` WRITE;
/*!40000 ALTER TABLE `ost_form_entry` DISABLE KEYS */;
INSERT INTO `ost_form_entry` VALUES (2,3,NULL,'C',1,NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(5,1,2,'U',1,NULL,'2017-08-02 08:29:32','2017-08-02 08:29:32'),(6,1,3,'U',1,NULL,'2017-08-02 08:31:41','2017-08-02 08:31:41'),(7,1,4,'U',1,NULL,'2017-08-02 08:32:46','2017-08-02 08:32:46'),(8,1,5,'U',1,NULL,'2017-08-02 08:33:23','2017-08-02 08:33:23'),(9,1,6,'U',1,NULL,'2017-08-02 08:34:31','2017-08-02 08:34:31'),(10,1,7,'U',1,NULL,'2017-08-02 08:36:14','2017-08-02 08:36:14'),(11,1,8,'U',1,NULL,'2017-08-02 08:37:09','2017-08-02 08:37:09');
/*!40000 ALTER TABLE `ost_form_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_form_entry_values`
--

DROP TABLE IF EXISTS `ost_form_entry_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_form_entry_values` (
  `entry_id` int(11) unsigned NOT NULL,
  `field_id` int(11) unsigned NOT NULL,
  `value` text,
  `value_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`entry_id`,`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_form_entry_values`
--

LOCK TABLES `ost_form_entry_values` WRITE;
/*!40000 ALTER TABLE `ost_form_entry_values` DISABLE KEYS */;
INSERT INTO `ost_form_entry_values` VALUES (2,23,'LARUEX',NULL),(2,24,NULL,NULL),(2,25,NULL,NULL),(2,26,NULL,NULL),(5,3,NULL,NULL),(5,4,NULL,NULL),(6,3,NULL,NULL),(6,4,NULL,NULL),(7,3,NULL,NULL),(7,4,NULL,NULL),(8,3,NULL,NULL),(8,4,NULL,NULL),(9,3,NULL,NULL),(9,4,NULL,NULL),(10,3,NULL,NULL),(10,4,NULL,NULL),(11,3,NULL,NULL),(11,4,NULL,NULL);
/*!40000 ALTER TABLE `ost_form_entry_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_form_field`
--

DROP TABLE IF EXISTS `ost_form_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_form_field` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `form_id` int(11) unsigned NOT NULL,
  `flags` int(10) unsigned DEFAULT '1',
  `type` varchar(255) NOT NULL DEFAULT 'text',
  `label` varchar(255) NOT NULL,
  `name` varchar(64) NOT NULL,
  `configuration` text,
  `sort` int(11) unsigned NOT NULL,
  `hint` varchar(512) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_form_field`
--

LOCK TABLES `ost_form_field` WRITE;
/*!40000 ALTER TABLE `ost_form_field` DISABLE KEYS */;
INSERT INTO `ost_form_field` VALUES (1,1,489379,'text','Email Address','email','{\"size\":40,\"length\":64,\"validator\":\"email\"}',1,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(2,1,489379,'text','Full Name','name','{\"size\":40,\"length\":64}',2,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(3,1,13057,'phone','Phone Number','phone',NULL,3,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(4,1,12289,'memo','Internal Notes','notes','{\"rows\":4,\"cols\":40}',4,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(20,2,489249,'text','Issue Summary','subject','{\"size\":40,\"length\":50}',1,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(21,2,480547,'thread','Issue Details','message',NULL,2,'Details on the reason(s) for opening the ticket.','2017-08-01 12:23:24','2017-08-01 12:23:24'),(22,2,274609,'priority','Priority Level','priority',NULL,3,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(23,3,291233,'text','Company Name','name','{\"size\":40,\"length\":64}',1,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(24,3,12545,'text','Website','website','{\"size\":40,\"length\":64}',2,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(25,3,12545,'phone','Phone Number','phone','{\"ext\":false}',3,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(26,3,12545,'memo','Address','address','{\"rows\":2,\"cols\":40,\"html\":false,\"length\":100}',4,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(27,4,489379,'text','Name','name','{\"size\":40,\"length\":64}',1,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(28,4,13057,'memo','Address','address','{\"rows\":2,\"cols\":40,\"length\":100,\"html\":false}',2,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(29,4,13057,'phone','Phone','phone',NULL,3,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(30,4,13057,'text','Website','website','{\"size\":40,\"length\":0}',4,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(31,4,12289,'memo','Internal Notes','notes','{\"rows\":4,\"cols\":40}',5,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(32,5,290977,'text','Title','title','{\"size\":40,\"length\":50}',1,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(33,5,282867,'thread','Description','description',NULL,2,'Details on the reason(s) for creating the task.','2017-08-01 12:23:24','2017-08-01 12:23:24'),(34,6,487665,'state','State','state','{\"prompt\":\"State of a ticket\"}',1,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(35,6,471073,'memo','Description','description','{\"rows\":2,\"cols\":40,\"html\":false,\"length\":100}',3,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(36,10,29697,'list-4','Tipo','tipo','{\"multiselect\":false,\"widget\":\"dropdown\",\"validator-error\":\"\",\"prompt\":\"\",\"default\":null}',1,NULL,'2017-08-01 15:04:03','2017-08-01 15:04:30'),(37,10,29697,'list-2','√Årea','variable','{\"multiselect\":false,\"widget\":\"dropdown\",\"validator-error\":\"\",\"prompt\":\"\",\"default\":null}',2,NULL,'2017-08-01 15:04:03','2017-08-01 15:04:42'),(38,11,30465,'list-3','Categor√≠a','categoria',NULL,1,NULL,'2017-08-02 08:03:27','2017-08-02 08:03:27'),(39,11,30465,'list-5','Localizaci√≥n','localizacion',NULL,2,NULL,'2017-08-02 08:03:27','2017-08-02 08:03:27'),(40,11,30465,'text','Asunto','subject',NULL,3,NULL,'2017-08-02 08:03:27','2017-08-02 08:03:27'),(41,11,769,'assignee','Agente preasignado','agente','{\"prompt\":\"\"}',4,NULL,'2017-08-02 08:03:27','2017-08-02 08:03:58'),(42,11,30465,'memo','Descripci√≥n','message',NULL,5,NULL,'2017-08-02 08:04:40','2017-08-02 08:04:40'),(43,11,13057,'memo','An√°lisis de causas','causas',NULL,6,NULL,'2017-08-02 08:05:15','2017-08-02 08:05:15'),(44,11,13057,'memo','An√°lisis de consecuencias','consecuencias',NULL,7,NULL,'2017-08-02 08:05:15','2017-08-02 08:05:15'),(45,11,13057,'files','Ficheros adjuntos','adjuntos',NULL,8,NULL,'2017-08-02 08:06:09','2017-08-02 08:06:09');
/*!40000 ALTER TABLE `ost_form_field` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_group`
--

DROP TABLE IF EXISTS `ost_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_group` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` int(11) unsigned NOT NULL,
  `flags` int(11) unsigned NOT NULL DEFAULT '1',
  `name` varchar(120) NOT NULL DEFAULT '',
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_group`
--

LOCK TABLES `ost_group` WRITE;
/*!40000 ALTER TABLE `ost_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_help_topic`
--

DROP TABLE IF EXISTS `ost_help_topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_help_topic` (
  `topic_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `topic_pid` int(10) unsigned NOT NULL DEFAULT '0',
  `isactive` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `ispublic` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `noautoresp` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `flags` int(10) unsigned DEFAULT '0',
  `status_id` int(10) unsigned NOT NULL DEFAULT '0',
  `priority_id` int(10) unsigned NOT NULL DEFAULT '0',
  `dept_id` int(10) unsigned NOT NULL DEFAULT '0',
  `staff_id` int(10) unsigned NOT NULL DEFAULT '0',
  `team_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sla_id` int(10) unsigned NOT NULL DEFAULT '0',
  `page_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sequence_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sort` int(10) unsigned NOT NULL DEFAULT '0',
  `topic` varchar(32) NOT NULL DEFAULT '',
  `number_format` varchar(32) DEFAULT NULL,
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `close_alert` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`topic_id`),
  UNIQUE KEY `topic` (`topic`,`topic_pid`),
  KEY `topic_pid` (`topic_pid`),
  KEY `priority_id` (`priority_id`),
  KEY `dept_id` (`dept_id`),
  KEY `staff_id` (`staff_id`,`team_id`),
  KEY `sla_id` (`sla_id`),
  KEY `page_id` (`page_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_help_topic`
--

LOCK TABLES `ost_help_topic` WRITE;
/*!40000 ALTER TABLE `ost_help_topic` DISABLE KEYS */;
INSERT INTO `ost_help_topic` VALUES (12,0,1,0,0,0,0,0,4,0,0,0,0,0,1,'Red de Alerta Radiol√≥gica',NULL,'Soporte de la Red de Alerta Radiol√≥gica','2017-08-01 14:57:53','2017-08-02 08:11:22',7),(13,12,1,0,0,1,0,0,6,7,0,0,0,3,2,'Incidencia','INC######',NULL,'2017-08-02 08:10:34','2017-08-02 08:11:34',NULL),(14,12,1,0,0,1,0,0,6,7,0,0,0,4,5,'No conformidad','NC######',NULL,'2017-08-02 08:12:52','2017-08-02 08:13:22',NULL),(15,13,1,1,0,1,0,0,6,7,0,0,0,3,3,'Hardware','INC######',NULL,'2017-08-02 08:14:12','2017-08-02 08:14:12',NULL),(16,13,1,1,0,1,0,0,6,7,0,0,0,3,4,'Software','INC######',NULL,'2017-08-02 08:14:59','2017-08-02 08:14:59',NULL),(17,14,1,1,0,1,0,0,6,7,0,0,0,4,6,'Hardware','NC######',NULL,'2017-08-02 08:15:45','2017-08-02 08:15:45',NULL),(18,14,1,1,0,1,0,0,6,7,0,0,0,4,7,'Software','NC######',NULL,'2017-08-02 08:16:20','2017-08-02 08:16:20',NULL);
/*!40000 ALTER TABLE `ost_help_topic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_help_topic_form`
--

DROP TABLE IF EXISTS `ost_help_topic_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_help_topic_form` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `topic_id` int(11) unsigned NOT NULL DEFAULT '0',
  `form_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sort` int(10) unsigned NOT NULL DEFAULT '1',
  `extra` text,
  PRIMARY KEY (`id`),
  KEY `topic-form` (`topic_id`,`form_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_help_topic_form`
--

LOCK TABLES `ost_help_topic_form` WRITE;
/*!40000 ALTER TABLE `ost_help_topic_form` DISABLE KEYS */;
INSERT INTO `ost_help_topic_form` VALUES (1,1,2,1,'{\"disable\":[]}'),(2,2,2,1,'{\"disable\":[]}'),(3,10,2,1,'{\"disable\":[]}'),(4,11,2,1,'{\"disable\":[]}'),(5,12,2,1,'{\"disable\":[20,21,22]}'),(6,13,2,1,'{\"disable\":[20,21,22]}'),(7,12,11,2,'{\"disable\":[38,40]}'),(8,14,2,1,'{\"disable\":[20,21,22]}'),(9,14,11,2,'{\"disable\":[38,40]}'),(10,15,2,1,'{\"disable\":[20,21,22]}'),(11,15,11,2,'{\"disable\":[38,40]}'),(12,16,2,1,'{\"disable\":[20,21,22]}'),(13,16,11,2,'{\"disable\":[38,40]}'),(14,17,2,1,'{\"disable\":[20,21,22]}'),(15,17,11,2,'{\"disable\":[38,40]}'),(16,18,2,1,'{\"disable\":[20,21,22]}'),(17,18,11,2,'{\"disable\":[38,40]}'),(18,13,11,2,'{\"disable\":[38,40]}');
/*!40000 ALTER TABLE `ost_help_topic_form` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_list`
--

DROP TABLE IF EXISTS `ost_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_list` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `name_plural` varchar(255) DEFAULT NULL,
  `sort_mode` enum('Alpha','-Alpha','SortCol') NOT NULL DEFAULT 'Alpha',
  `masks` int(11) unsigned NOT NULL DEFAULT '0',
  `type` varchar(16) DEFAULT NULL,
  `configuration` text NOT NULL,
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_list`
--

LOCK TABLES `ost_list` WRITE;
/*!40000 ALTER TABLE `ost_list` DISABLE KEYS */;
INSERT INTO `ost_list` VALUES (1,'Ticket Status','Ticket Statuses','SortCol',13,'ticket-status','{\"handler\":\"TicketStatusList\"}','Ticket statuses','2017-08-01 12:23:24','2017-08-01 12:23:24'),(2,'√Årea','√Åreas','SortCol',0,NULL,'',NULL,'2017-08-01 14:59:58','2017-08-01 14:59:58'),(3,'Categor√≠a','Categor√≠as','SortCol',0,NULL,'',NULL,'2017-08-01 15:01:25','2017-08-01 15:01:25'),(4,'Tipo de localizaci√≥n','Tipos de localizaci√≥n','SortCol',0,NULL,'',NULL,'2017-08-01 15:02:32','2017-08-01 15:02:32'),(5,'Localizaci√≥n','Localizaciones','SortCol',0,NULL,'',NULL,'2017-08-01 15:04:03','2017-08-01 15:04:03');
/*!40000 ALTER TABLE `ost_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_list_items`
--

DROP TABLE IF EXISTS `ost_list_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_list_items` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `list_id` int(11) DEFAULT NULL,
  `status` int(11) unsigned NOT NULL DEFAULT '1',
  `value` varchar(255) NOT NULL,
  `extra` varchar(255) DEFAULT NULL,
  `sort` int(11) NOT NULL DEFAULT '1',
  `properties` text,
  PRIMARY KEY (`id`),
  KEY `list_item_lookup` (`list_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_list_items`
--

LOCK TABLES `ost_list_items` WRITE;
/*!40000 ALTER TABLE `ost_list_items` DISABLE KEYS */;
INSERT INTO `ost_list_items` VALUES (1,2,1,'Almaraz',NULL,1,'[]'),(2,2,1,'C√°ceres',NULL,1,'[]'),(3,2,1,'Portugal',NULL,1,'[]'),(4,2,1,'Otra',NULL,1,'[]'),(5,3,1,'Hardware','HW',0,'[]'),(6,3,1,'Software','SW',0,'[]'),(7,4,1,'Estaci√≥n',NULL,0,'[]'),(8,4,1,'Unidad m√≥vil',NULL,0,'[]'),(9,4,1,'Otro',NULL,0,'[]'),(10,5,1,'Alerta2',NULL,0,'{\"36\":{\"7\":\"Estaci\\u00f3n\"},\"37\":{\"2\":\"C\\u00e1ceres\"}}'),(11,5,1,'Almaraz',NULL,0,'{\"36\":{\"7\":\"Estaci\\u00f3n\"},\"37\":{\"1\":\"Almaraz\"}}'),(12,5,1,'√âvora',NULL,0,'{\"36\":{\"7\":\"Estaci\\u00f3n\"},\"37\":{\"3\":\"Portugal\"}}'),(13,5,1,'Portalegre',NULL,0,'{\"36\":{\"7\":\"Estaci\\u00f3n\"},\"37\":{\"3\":\"Portugal\"}}'),(14,5,1,'Saucedilla',NULL,0,'{\"36\":{\"7\":\"Estaci\\u00f3n\"},\"37\":{\"1\":\"Almaraz\"}}'),(15,5,1,'Unidad m√≥vil',NULL,0,'{\"36\":{\"8\":\"Unidad m\\u00f3vil\"},\"37\":{\"4\":\"Otra\"}}'),(16,5,1,'Otros',NULL,0,'{\"36\":{\"9\":\"Otro\"},\"37\":{\"4\":\"Otra\"}}');
/*!40000 ALTER TABLE `ost_list_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_lock`
--

DROP TABLE IF EXISTS `ost_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_lock` (
  `lock_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(10) unsigned NOT NULL DEFAULT '0',
  `expire` datetime DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`lock_id`),
  KEY `staff_id` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_lock`
--

LOCK TABLES `ost_lock` WRITE;
/*!40000 ALTER TABLE `ost_lock` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_note`
--

DROP TABLE IF EXISTS `ost_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_note` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned DEFAULT NULL,
  `staff_id` int(11) unsigned NOT NULL DEFAULT '0',
  `ext_id` varchar(10) DEFAULT NULL,
  `body` text,
  `status` int(11) unsigned NOT NULL DEFAULT '0',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ext_id` (`ext_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_note`
--

LOCK TABLES `ost_note` WRITE;
/*!40000 ALTER TABLE `ost_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_organization`
--

DROP TABLE IF EXISTS `ost_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_organization` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  `manager` varchar(16) NOT NULL DEFAULT '',
  `status` int(11) unsigned NOT NULL DEFAULT '0',
  `domain` varchar(256) NOT NULL DEFAULT '',
  `extra` text,
  `created` timestamp NULL DEFAULT NULL,
  `updated` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_organization`
--

LOCK TABLES `ost_organization` WRITE;
/*!40000 ALTER TABLE `ost_organization` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_organization__cdata`
--

DROP TABLE IF EXISTS `ost_organization__cdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_organization__cdata` (
  `org_id` int(11) unsigned NOT NULL,
  `name` mediumtext,
  `address` mediumtext,
  `phone` mediumtext,
  `website` mediumtext,
  `notes` mediumtext,
  PRIMARY KEY (`org_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_organization__cdata`
--

LOCK TABLES `ost_organization__cdata` WRITE;
/*!40000 ALTER TABLE `ost_organization__cdata` DISABLE KEYS */;
INSERT INTO `ost_organization__cdata` VALUES (1,NULL,'420 Desoto Street\nAlexandria, LA 71301','3182903674','http://osticket.com','Not only do we develop the software, we also use it to manage support for osTicket. Let us help you quickly implement and leverage the full potential of osTicket\'s features and functionality. Contact us for professional support or visit our website for documentation and community support.');
/*!40000 ALTER TABLE `ost_organization__cdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_plugin`
--

DROP TABLE IF EXISTS `ost_plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_plugin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `install_path` varchar(60) NOT NULL,
  `isphar` tinyint(1) NOT NULL DEFAULT '0',
  `isactive` tinyint(1) NOT NULL DEFAULT '0',
  `version` varchar(64) DEFAULT NULL,
  `installed` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_plugin`
--

LOCK TABLES `ost_plugin` WRITE;
/*!40000 ALTER TABLE `ost_plugin` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_plugin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_queue`
--

DROP TABLE IF EXISTS `ost_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_queue` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0',
  `flags` int(11) unsigned NOT NULL DEFAULT '0',
  `staff_id` int(11) unsigned NOT NULL DEFAULT '0',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `title` varchar(60) DEFAULT NULL,
  `config` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_queue`
--

LOCK TABLES `ost_queue` WRITE;
/*!40000 ALTER TABLE `ost_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_role`
--

DROP TABLE IF EXISTS `ost_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `flags` int(10) unsigned NOT NULL DEFAULT '1',
  `name` varchar(64) DEFAULT NULL,
  `permissions` text,
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_role`
--

LOCK TABLES `ost_role` WRITE;
/*!40000 ALTER TABLE `ost_role` DISABLE KEYS */;
INSERT INTO `ost_role` VALUES (1,1,'All Access','{\"ticket.create\":1,\"ticket.edit\":1,\"ticket.assign\":1,\"ticket.transfer\":1,\"ticket.reply\":1,\"ticket.close\":1,\"ticket.delete\":1,\"thread.edit\":1,\"task.create\":1,\"task.edit\":1,\"task.assign\":1,\"task.transfer\":1,\"task.reply\":1,\"task.close\":1,\"task.delete\":1,\"canned.manage\":1}','Role with unlimited access','2017-08-01 12:23:25','2017-08-01 12:23:25'),(2,1,'Expanded Access','{\"ticket.create\":1,\"ticket.edit\":1,\"ticket.assign\":1,\"ticket.transfer\":1,\"ticket.reply\":1,\"ticket.close\":1,\"task.create\":1,\"task.edit\":1,\"task.assign\":1,\"task.transfer\":1,\"task.reply\":1,\"task.close\":1,\"canned.manage\":1}','Role with expanded access','2017-08-01 12:23:25','2017-08-01 12:23:25'),(3,1,'Limited Access','{\"ticket.create\":1,\"ticket.assign\":1,\"ticket.transfer\":1,\"task.assign\":1,\"task.transfer\":1,\"task.reply\":1}','Role with limited access','2017-08-01 12:23:25','2017-08-01 12:23:25'),(4,1,'View only',NULL,'Simple role with no permissions','2017-08-01 12:23:25','2017-08-01 12:23:25');
/*!40000 ALTER TABLE `ost_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_sequence`
--

DROP TABLE IF EXISTS `ost_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_sequence` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `flags` int(10) unsigned DEFAULT NULL,
  `next` bigint(20) unsigned NOT NULL DEFAULT '1',
  `increment` int(11) DEFAULT '1',
  `padding` char(1) DEFAULT '0',
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_sequence`
--

LOCK TABLES `ost_sequence` WRITE;
/*!40000 ALTER TABLE `ost_sequence` DISABLE KEYS */;
INSERT INTO `ost_sequence` VALUES (1,'General Tickets',1,1,1,'0','0000-00-00 00:00:00'),(2,'Tasks Sequence',1,1,1,'0','0000-00-00 00:00:00'),(3,'Secuencia incidencias',NULL,1,1,'0','2017-08-03 09:09:43'),(4,'Secuencia no conformidades',NULL,1,1,'0','2017-08-02 14:26:56');
/*!40000 ALTER TABLE `ost_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_session`
--

DROP TABLE IF EXISTS `ost_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_session` (
  `session_id` varchar(255) CHARACTER SET ascii NOT NULL DEFAULT '',
  `session_data` blob,
  `session_expire` datetime DEFAULT NULL,
  `session_updated` datetime DEFAULT NULL,
  `user_id` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT 'osTicket staff/client ID',
  `user_ip` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_agent` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `updated` (`session_updated`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_session`
--

LOCK TABLES `ost_session` WRITE;
/*!40000 ALTER TABLE `ost_session` DISABLE KEYS */;
INSERT INTO `ost_session` VALUES ('1ahpjage5ot7tr4c5tsrcs4lk2','csrf|a:2:{s:5:\"token\";s:40:\"0e05213b20c02122c5a0533e769a272a9940b304\";s:4:\"time\";i:1501678868;}_auth|a:1:{s:5:\"staff\";a:2:{s:2:\"id\";i:1;s:3:\"key\";s:12:\"local:carlos\";}}:token|a:1:{s:5:\"staff\";s:76:\"1e8fdc5fddb76bb1d04a65aeb109b62c:1501678847:efb4e12265ca7e4fc8fc726a9feb90bc\";}::Q:T|s:7:\"overdue\";:QT:open:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}:Q:tickets|C:8:\"QuerySet\":5125:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":1215:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"ticket_id__in\";C:8:\"QuerySet\":1140:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:3:{i:0;C:1:\"Q\":52:{a:3:{i:0;i:1;i:1;i:0;i:2;a:1:{s:9:\"isoverdue\";i:0;}}}i:1;C:1:\"Q\":64:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"status__state\";s:4:\"open\";}}}i:2;C:1:\"Q\":317:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":267:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{i:0;C:1:\"Q\":132:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:13:\"status__state\";s:4:\"open\";i:0;C:1:\"Q\":51:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{s:8:\"staff_id\";i:1;}}}}}}s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;O:11:\"SqlFunction\":3:{s:5:\"alias\";N;s:4:\"func\";s:8:\"COALESCE\";s:4:\"args\";a:2:{i:0;O:8:\"SqlField\":3:{s:5:\"level\";i:0;s:5:\"alias\";N;s:5:\"field\";s:11:\"est_duedate\";}i:1;s:3:\"zzz\";}}i:1;s:3:\"ASC\";}}s:7:\"related\";b:0;s:6:\"values\";a:1:{i:0;s:9:\"ticket_id\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:3;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}}}}s:16:\"path_constraints\";a:1:{s:4:\"lock\";a:1:{i:0;C:1:\"Q\":131:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:16:\"lock__expire__gt\";O:11:\"SqlFunction\":3:{s:5:\"alias\";N;s:4:\"func\";s:3:\"NOW\";s:4:\"args\";a:0:{}}}}}}}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;r:73;i:1;s:3:\"ASC\";}}s:7:\"related\";b:0;s:6:\"values\";a:23:{s:11:\"est_duedate\";s:11:\"est_duedate\";s:14:\"lock__staff_id\";s:14:\"lock__staff_id\";s:8:\"staff_id\";s:8:\"staff_id\";s:9:\"isoverdue\";s:9:\"isoverdue\";s:7:\"team_id\";s:7:\"team_id\";s:9:\"ticket_id\";s:9:\"ticket_id\";s:6:\"number\";s:6:\"number\";s:14:\"cdata__subject\";s:14:\"cdata__subject\";s:28:\"user__default_email__address\";s:28:\"user__default_email__address\";s:6:\"source\";s:6:\"source\";s:32:\"cdata__:priority__priority_color\";s:32:\"cdata__:priority__priority_color\";s:31:\"cdata__:priority__priority_desc\";s:31:\"cdata__:priority__priority_desc\";s:9:\"status_id\";s:9:\"status_id\";s:12:\"status__name\";s:12:\"status__name\";s:13:\"status__state\";s:13:\"status__state\";s:7:\"dept_id\";s:7:\"dept_id\";s:10:\"dept__name\";s:10:\"dept__name\";s:10:\"user__name\";s:10:\"user__name\";s:10:\"lastupdate\";s:10:\"lastupdate\";s:10:\"isanswered\";s:10:\"isanswered\";s:16:\"staff__firstname\";s:16:\"staff__firstname\";s:15:\"staff__lastname\";s:15:\"staff__lastname\";s:10:\"team__name\";s:10:\"team__name\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:3:{s:12:\"collab_count\";C:8:\"QuerySet\":672:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:17:\"collaborators__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:16:\"attachment_count\";C:8:\"QuerySet\":768:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":72:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:28:\"entries__attachments__inline\";i:0;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:24:\"entries__attachments__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:12:\"thread_count\";C:8:\"QuerySet\":749:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":66:{a:3:{i:0;i:1;i:1;i:0;i:2;a:1:{s:22:\"entries__flags__hasbit\";i:4;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:11:\"entries__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}lastcroncall|i:1501678848;cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}:QT:overdue:sort|a:2:{i:0;s:12:\"priority,due\";i:1;i:0;}','2017-08-03 15:01:08',NULL,'1','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:54.0) Gecko/20100101 Firefox/54.0'),('31kl0fsukdnme7460bp48uegu6','csrf|a:2:{s:5:\"token\";s:40:\"0423a007a3de45e6aa33922ecc138fb8539028d8\";s:4:\"time\";i:1501752835;}_auth|a:1:{s:5:\"staff\";a:2:{s:2:\"id\";i:1;s:3:\"key\";s:12:\"local:carlos\";}}:token|a:1:{s:5:\"staff\";s:76:\"53e51ea72d6eaf6333460bad99f818b4:1501752822:efb4e12265ca7e4fc8fc726a9feb90bc\";}::Q:T|s:4:\"open\";:QT:open:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}:Q:tickets|C:8:\"QuerySet\":4911:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":986:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"ticket_id__in\";C:8:\"QuerySet\":912:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":64:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"status__state\";s:4:\"open\";}}}i:1;C:1:\"Q\":317:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":267:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{i:0;C:1:\"Q\":132:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:13:\"status__state\";s:4:\"open\";i:0;C:1:\"Q\":51:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{s:8:\"staff_id\";i:1;}}}}}}s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:1:{i:0;s:9:\"ticket_id\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:3;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}}}}s:16:\"path_constraints\";a:1:{s:4:\"lock\";a:1:{i:0;C:1:\"Q\":131:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:16:\"lock__expire__gt\";O:11:\"SqlFunction\":3:{s:5:\"alias\";N;s:4:\"func\";s:3:\"NOW\";s:4:\"args\";a:0:{}}}}}}}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:23:{s:14:\"lock__staff_id\";s:14:\"lock__staff_id\";s:8:\"staff_id\";s:8:\"staff_id\";s:9:\"isoverdue\";s:9:\"isoverdue\";s:7:\"team_id\";s:7:\"team_id\";s:12:\"last_duedate\";s:12:\"last_duedate\";s:9:\"ticket_id\";s:9:\"ticket_id\";s:6:\"number\";s:6:\"number\";s:14:\"cdata__subject\";s:14:\"cdata__subject\";s:28:\"user__default_email__address\";s:28:\"user__default_email__address\";s:6:\"source\";s:6:\"source\";s:32:\"cdata__:priority__priority_color\";s:32:\"cdata__:priority__priority_color\";s:31:\"cdata__:priority__priority_desc\";s:31:\"cdata__:priority__priority_desc\";s:9:\"status_id\";s:9:\"status_id\";s:12:\"status__name\";s:12:\"status__name\";s:13:\"status__state\";s:13:\"status__state\";s:7:\"dept_id\";s:7:\"dept_id\";s:10:\"dept__name\";s:10:\"dept__name\";s:10:\"user__name\";s:10:\"user__name\";s:10:\"lastupdate\";s:10:\"lastupdate\";s:10:\"isanswered\";s:10:\"isanswered\";s:16:\"staff__firstname\";s:16:\"staff__firstname\";s:15:\"staff__lastname\";s:15:\"staff__lastname\";s:10:\"team__name\";s:10:\"team__name\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:3:{s:12:\"collab_count\";C:8:\"QuerySet\":672:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:17:\"collaborators__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:16:\"attachment_count\";C:8:\"QuerySet\":768:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":72:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:28:\"entries__attachments__inline\";i:0;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:24:\"entries__attachments__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:12:\"thread_count\";C:8:\"QuerySet\":749:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":66:{a:3:{i:0;i:1;i:1;i:0;i:2;a:1:{s:22:\"entries__flags__hasbit\";i:4;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:11:\"entries__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}lastcroncall|i:1501752790;:QT:closed:sort|a:2:{i:0;s:6:\"closed\";i:1;i:0;}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}','2017-08-04 11:33:55',NULL,'1','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:54.0) Gecko/20100101 Firefox/54.0'),('3hog54beb6ncrssvqnfd9kavt5','csrf|a:2:{s:5:\"token\";s:40:\"de454baebdb0d828d2bd9d7d681d0e75d21dea40\";s:4:\"time\";i:1501657304;}','2017-08-03 09:01:44',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:54.0) Gecko/20100101 Firefox/54.0'),('3jm509ogbr8d4c7jh8ir051m27','csrf|a:2:{s:5:\"token\";s:40:\"9efadbe81664f17844c82aaa62d392a731256692\";s:4:\"time\";i:1501667946;}_auth|a:2:{s:5:\"staff\";N;s:4:\"user\";a:0:{}}_client|a:1:{s:4:\"auth\";a:1:{s:4:\"dest\";s:9:\"/open.php\";}}:token|a:0:{}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}client:Q|N;','2017-08-03 11:59:06',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:54.0) Gecko/20100101 Firefox/54.0'),('490csfj3bajqfbma9hn9eo07a7','csrf|a:2:{s:5:\"token\";s:40:\"d21ffd54061b629b11fdf96cd69dba7a55f1f6bd\";s:4:\"time\";i:1501666576;}_auth|a:2:{s:5:\"staff\";N;s:4:\"user\";a:0:{}}_client|a:1:{s:4:\"auth\";a:1:{s:4:\"dest\";s:9:\"/open.php\";}}:token|a:0:{}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}','2017-08-03 11:36:16',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:54.0) Gecko/20100101 Firefox/54.0'),('67vbpoj00m3717s2nurov60ar6','csrf|a:2:{s:5:\"token\";s:40:\"dc438ac72b03921982b7fe1d3a2848324f56f2df\";s:4:\"time\";i:1501668533;}_auth|a:1:{s:5:\"staff\";a:2:{s:2:\"id\";i:7;s:3:\"key\";s:13:\"local:angeles\";}}:token|a:1:{s:5:\"staff\";s:76:\"107813db0c3e6daf8fb6242f528a0767:1501668504:efb4e12265ca7e4fc8fc726a9feb90bc\";}::Q:T|s:8:\"assigned\";:QT:open:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}:Q:tickets|C:8:\"QuerySet\":4893:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":1077:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"ticket_id__in\";C:8:\"QuerySet\":1002:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:3:{i:0;C:1:\"Q\":142:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{s:8:\"staff_id\";i:7;i:0;C:1:\"Q\":74:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:8:\"staff_id\";i:0;s:11:\"team_id__gt\";i:0;}}}}}}i:1;C:1:\"Q\":64:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"status__state\";s:4:\"open\";}}}i:2;C:1:\"Q\":317:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":267:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{i:0;C:1:\"Q\":132:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:13:\"status__state\";s:4:\"open\";i:0;C:1:\"Q\":51:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{s:8:\"staff_id\";i:7;}}}}}}s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:1:{i:0;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:1:{i:0;s:9:\"ticket_id\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:3;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}}}}s:16:\"path_constraints\";a:1:{s:4:\"lock\";a:1:{i:0;C:1:\"Q\":131:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:16:\"lock__expire__gt\";O:11:\"SqlFunction\":3:{s:5:\"alias\";N;s:4:\"func\";s:3:\"NOW\";s:4:\"args\";a:0:{}}}}}}}s:8:\"ordering\";a:1:{i:0;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:22:{s:14:\"lock__staff_id\";s:14:\"lock__staff_id\";s:8:\"staff_id\";s:8:\"staff_id\";s:9:\"isoverdue\";s:9:\"isoverdue\";s:7:\"team_id\";s:7:\"team_id\";s:9:\"ticket_id\";s:9:\"ticket_id\";s:6:\"number\";s:6:\"number\";s:14:\"cdata__subject\";s:14:\"cdata__subject\";s:28:\"user__default_email__address\";s:28:\"user__default_email__address\";s:6:\"source\";s:6:\"source\";s:32:\"cdata__:priority__priority_color\";s:32:\"cdata__:priority__priority_color\";s:31:\"cdata__:priority__priority_desc\";s:31:\"cdata__:priority__priority_desc\";s:9:\"status_id\";s:9:\"status_id\";s:12:\"status__name\";s:12:\"status__name\";s:13:\"status__state\";s:13:\"status__state\";s:7:\"dept_id\";s:7:\"dept_id\";s:10:\"dept__name\";s:10:\"dept__name\";s:10:\"user__name\";s:10:\"user__name\";s:10:\"lastupdate\";s:10:\"lastupdate\";s:10:\"isanswered\";s:10:\"isanswered\";s:16:\"staff__firstname\";s:16:\"staff__firstname\";s:15:\"staff__lastname\";s:15:\"staff__lastname\";s:10:\"team__name\";s:10:\"team__name\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:3:{s:12:\"collab_count\";C:8:\"QuerySet\":672:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:17:\"collaborators__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:16:\"attachment_count\";C:8:\"QuerySet\":768:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":72:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:28:\"entries__attachments__inline\";i:0;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:24:\"entries__attachments__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:12:\"thread_count\";C:8:\"QuerySet\":749:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":66:{a:3:{i:0;i:1;i:1;i:0;i:2;a:1:{s:22:\"entries__flags__hasbit\";i:4;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:11:\"entries__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}lastcroncall|i:1501668504;:QT:assigned:sort|a:2:{i:0;s:7:\"updated\";i:1;i:0;}','2017-08-03 12:08:53',NULL,'7','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:54.0) Gecko/20100101 Firefox/54.0'),('8fh47147c42nd8cfrnjh7h1354','csrf|a:2:{s:5:\"token\";s:40:\"153d8c5c6cada69ab7afdea7782286e776b82dec\";s:4:\"time\";i:1501745853;}_auth|a:2:{s:4:\"user\";N;s:5:\"staff\";a:2:{s:2:\"id\";i:1;s:3:\"key\";s:12:\"local:carlos\";}}_staff|a:1:{s:4:\"auth\";a:2:{s:4:\"dest\";s:5:\"/scp/\";s:3:\"msg\";s:24:\"Autenticaci√≥n Requerida\";}}:token|a:1:{s:5:\"staff\";s:76:\"804c28b9983726fa287537f6dc5e969c:1501745840:efb4e12265ca7e4fc8fc726a9feb90bc\";}::Q:T|s:7:\"overdue\";:QT:open:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}:Q:tickets|C:8:\"QuerySet\":5165:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":1215:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"ticket_id__in\";C:8:\"QuerySet\":1140:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:3:{i:0;C:1:\"Q\":52:{a:3:{i:0;i:1;i:1;i:0;i:2;a:1:{s:9:\"isoverdue\";i:0;}}}i:1;C:1:\"Q\":64:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"status__state\";s:4:\"open\";}}}i:2;C:1:\"Q\":317:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":267:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{i:0;C:1:\"Q\":132:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:13:\"status__state\";s:4:\"open\";i:0;C:1:\"Q\":51:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{s:8:\"staff_id\";i:1;}}}}}}s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;O:11:\"SqlFunction\":3:{s:5:\"alias\";N;s:4:\"func\";s:8:\"COALESCE\";s:4:\"args\";a:2:{i:0;O:8:\"SqlField\":3:{s:5:\"level\";i:0;s:5:\"alias\";N;s:5:\"field\";s:11:\"est_duedate\";}i:1;s:3:\"zzz\";}}i:1;s:3:\"ASC\";}}s:7:\"related\";b:0;s:6:\"values\";a:1:{i:0;s:9:\"ticket_id\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:3;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}}}}s:16:\"path_constraints\";a:1:{s:4:\"lock\";a:1:{i:0;C:1:\"Q\":131:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:16:\"lock__expire__gt\";O:11:\"SqlFunction\":3:{s:5:\"alias\";N;s:4:\"func\";s:3:\"NOW\";s:4:\"args\";a:0:{}}}}}}}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;r:78;i:1;s:3:\"ASC\";}}s:7:\"related\";b:0;s:6:\"values\";a:24:{s:11:\"est_duedate\";s:11:\"est_duedate\";s:14:\"lock__staff_id\";s:14:\"lock__staff_id\";s:8:\"staff_id\";s:8:\"staff_id\";s:9:\"isoverdue\";s:9:\"isoverdue\";s:7:\"team_id\";s:7:\"team_id\";s:12:\"last_duedate\";s:12:\"last_duedate\";s:9:\"ticket_id\";s:9:\"ticket_id\";s:6:\"number\";s:6:\"number\";s:14:\"cdata__subject\";s:14:\"cdata__subject\";s:28:\"user__default_email__address\";s:28:\"user__default_email__address\";s:6:\"source\";s:6:\"source\";s:32:\"cdata__:priority__priority_color\";s:32:\"cdata__:priority__priority_color\";s:31:\"cdata__:priority__priority_desc\";s:31:\"cdata__:priority__priority_desc\";s:9:\"status_id\";s:9:\"status_id\";s:12:\"status__name\";s:12:\"status__name\";s:13:\"status__state\";s:13:\"status__state\";s:7:\"dept_id\";s:7:\"dept_id\";s:10:\"dept__name\";s:10:\"dept__name\";s:10:\"user__name\";s:10:\"user__name\";s:10:\"lastupdate\";s:10:\"lastupdate\";s:10:\"isanswered\";s:10:\"isanswered\";s:16:\"staff__firstname\";s:16:\"staff__firstname\";s:15:\"staff__lastname\";s:15:\"staff__lastname\";s:10:\"team__name\";s:10:\"team__name\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:3:{s:12:\"collab_count\";C:8:\"QuerySet\":672:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:17:\"collaborators__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:16:\"attachment_count\";C:8:\"QuerySet\":768:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":72:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:28:\"entries__attachments__inline\";i:0;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:24:\"entries__attachments__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:12:\"thread_count\";C:8:\"QuerySet\":749:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":66:{a:3:{i:0;i:1;i:1;i:0;i:2;a:1:{s:22:\"entries__flags__hasbit\";i:4;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:11:\"entries__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}lastcroncall|i:1501745851;:QT:closed:sort|a:2:{i:0;s:6:\"closed\";i:1;i:0;}:QT:overdue:sort|a:2:{i:0;s:12:\"priority,due\";i:1;i:0;}:Q:users|C:8:\"QuerySet\":771:{a:16:{s:5:\"model\";s:4:\"User\";s:11:\"constraints\";a:0:{}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:1:{i:0;s:4:\"name\";}s:7:\"related\";b:0;s:6:\"values\";a:7:{s:2:\"id\";s:2:\"id\";s:4:\"name\";s:4:\"name\";s:22:\"default_email__address\";s:22:\"default_email__address\";s:11:\"account__id\";s:11:\"account__id\";s:15:\"account__status\";s:15:\"account__status\";s:7:\"created\";s:7:\"created\";s:7:\"updated\";s:7:\"updated\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:1:{s:12:\"ticket_count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:7:\"tickets\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:12:\"ticket_count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}','2017-08-04 09:37:33',NULL,'1','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:54.0) Gecko/20100101 Firefox/54.0'),('drcnl70fcmfsadpe8bfrse0bb1','csrf|a:2:{s:5:\"token\";s:40:\"4e17e33acb53c2780863ec653444c2efd90732e3\";s:4:\"time\";i:1501668041;}_auth|a:2:{s:5:\"staff\";N;s:4:\"user\";a:0:{}}_client|a:1:{s:4:\"auth\";a:1:{s:4:\"dest\";s:9:\"/open.php\";}}:token|a:0:{}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}','2017-08-03 12:00:41',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:54.0) Gecko/20100101 Firefox/54.0'),('ebjlf8fsopkq2nsaanqur43de5','csrf|a:2:{s:5:\"token\";s:40:\"cfae50656e827587e2ec7d644dad0aee8963027e\";s:4:\"time\";i:1501657304;}','2017-08-03 09:01:44',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:54.0) Gecko/20100101 Firefox/54.0'),('eh41u30de0ec7uf2vtusct4i51','csrf|a:2:{s:5:\"token\";s:40:\"c81eb5d117fa54d9d869219031768b9fbd7333c5\";s:4:\"time\";i:1501665068;}_staff|a:1:{s:4:\"auth\";a:2:{s:4:\"dest\";s:23:\"/scp/tickets.php?a=open\";s:3:\"msg\";s:24:\"Autenticaci√≥n Requerida\";}}_auth|a:2:{s:5:\"staff\";N;s:4:\"user\";a:0:{}}:token|a:0:{}:uploadedFiles|a:1:{i:3;i:1;}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}client:Q|N;','2017-08-03 11:11:08',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:54.0) Gecko/20100101 Firefox/54.0'),('g10u7ekl5sof3e7f41rrp0kqv2','csrf|a:2:{s:5:\"token\";s:40:\"970569fa53bb51a064c7ed21f012bddde4811ad5\";s:4:\"time\";i:1501656173;}_auth|a:2:{s:5:\"staff\";N;s:4:\"user\";a:2:{s:2:\"id\";i:5;s:3:\"key\";s:8:\"client:5\";}}_client|a:1:{s:4:\"auth\";a:1:{s:4:\"dest\";s:9:\"/open.php\";}}_staff|a:1:{s:4:\"auth\";a:2:{s:4:\"dest\";s:5:\"/scp/\";s:3:\"msg\";s:24:\"Autenticaci√≥n Requerida\";}}:token|a:1:{s:6:\"client\";s:76:\"2b5cb54e4ffd520ce89ff74ae3e3f75b:1501656173:efb4e12265ca7e4fc8fc726a9feb90bc\";}:form-data|a:5:{s:16:\"adfc21a0a2912237\";a:1:{i:0;s:0:\"\";}s:16:\"9f98f8f71dcc9376\";a:1:{i:0;s:0:\"\";}s:16:\"c5c7135ddcd126f6\";s:0:\"\";s:16:\"a2bab8a55aeabb31\";s:0:\"\";s:16:\"f88766c8d76dac45\";s:0:\"\";}','2017-08-03 08:42:53',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:54.0) Gecko/20100101 Firefox/54.0'),('hafss2alaok1r4fu4kraq70r52','csrf|a:2:{s:5:\"token\";s:40:\"b5fe3aaff22921417a47939ebb2aaefea9ac3a6a\";s:4:\"time\";i:1501672102;}_auth|a:2:{s:5:\"staff\";N;s:4:\"user\";a:2:{s:2:\"id\";i:8;s:3:\"key\";s:8:\"client:8\";}}_staff|a:1:{s:4:\"auth\";a:2:{s:4:\"dest\";s:5:\"/scp/\";s:3:\"msg\";s:24:\"Autenticaci√≥n Requerida\";}}:token|a:1:{s:6:\"client\";s:76:\"ca437f8a1faf0b67b763cae45f19b351:1501672090:efb4e12265ca7e4fc8fc726a9feb90bc\";}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}','2017-08-03 13:08:22',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:54.0) Gecko/20100101 Firefox/54.0'),('ogjl3hl6g4927gk4qfmlhms954','csrf|a:2:{s:5:\"token\";s:40:\"189c1330d6d1ad939cbed888cd2fcba4d8a01da4\";s:4:\"time\";i:1501586546;}_auth|a:2:{s:4:\"user\";a:1:{s:7:\"strikes\";i:1;}s:5:\"staff\";a:2:{s:2:\"id\";i:1;s:3:\"key\";s:12:\"local:carlos\";}}_staff|a:1:{s:4:\"auth\";a:2:{s:4:\"dest\";s:5:\"/scp/\";s:3:\"msg\";s:23:\"Authentication Required\";}}:token|a:1:{s:5:\"staff\";s:76:\"faa3eeea2d0151782ba95e2696c0060f:1501586538:efb4e12265ca7e4fc8fc726a9feb90bc\";}::Q:T|s:0:\"\";:QT:open:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}:Q:tickets|C:8:\"QuerySet\":4895:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":1009:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"ticket_id__in\";C:8:\"QuerySet\":935:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:3:{i:0;C:1:\"Q\":54:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:10:\"isanswered\";i:0;}}}i:1;C:1:\"Q\":64:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"status__state\";s:4:\"open\";}}}i:2;C:1:\"Q\":269:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":219:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{i:0;C:1:\"Q\":132:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:13:\"status__state\";s:4:\"open\";i:0;C:1:\"Q\":51:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{s:8:\"staff_id\";i:1;}}}}}}s:11:\"dept_id__in\";a:1:{i:0;s:1:\"1\";}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:1:{i:0;s:9:\"ticket_id\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:3;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}}}}s:16:\"path_constraints\";a:1:{s:4:\"lock\";a:1:{i:0;C:1:\"Q\":131:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:16:\"lock__expire__gt\";O:11:\"SqlFunction\":3:{s:5:\"alias\";N;s:4:\"func\";s:3:\"NOW\";s:4:\"args\";a:0:{}}}}}}}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:22:{s:14:\"lock__staff_id\";s:14:\"lock__staff_id\";s:8:\"staff_id\";s:8:\"staff_id\";s:9:\"isoverdue\";s:9:\"isoverdue\";s:7:\"team_id\";s:7:\"team_id\";s:9:\"ticket_id\";s:9:\"ticket_id\";s:6:\"number\";s:6:\"number\";s:14:\"cdata__subject\";s:14:\"cdata__subject\";s:28:\"user__default_email__address\";s:28:\"user__default_email__address\";s:6:\"source\";s:6:\"source\";s:32:\"cdata__:priority__priority_color\";s:32:\"cdata__:priority__priority_color\";s:31:\"cdata__:priority__priority_desc\";s:31:\"cdata__:priority__priority_desc\";s:9:\"status_id\";s:9:\"status_id\";s:12:\"status__name\";s:12:\"status__name\";s:13:\"status__state\";s:13:\"status__state\";s:7:\"dept_id\";s:7:\"dept_id\";s:10:\"dept__name\";s:10:\"dept__name\";s:10:\"user__name\";s:10:\"user__name\";s:10:\"lastupdate\";s:10:\"lastupdate\";s:10:\"isanswered\";s:10:\"isanswered\";s:16:\"staff__firstname\";s:16:\"staff__firstname\";s:15:\"staff__lastname\";s:15:\"staff__lastname\";s:10:\"team__name\";s:10:\"team__name\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:3:{s:12:\"collab_count\";C:8:\"QuerySet\":672:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:17:\"collaborators__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:16:\"attachment_count\";C:8:\"QuerySet\":768:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":72:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:28:\"entries__attachments__inline\";i:0;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:24:\"entries__attachments__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:12:\"thread_count\";C:8:\"QuerySet\":749:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":66:{a:3:{i:0;i:1;i:1;i:0;i:2;a:1:{s:22:\"entries__flags__hasbit\";i:4;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:11:\"entries__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}lastcroncall|i:1501586538;:Q:users|C:8:\"QuerySet\":771:{a:16:{s:5:\"model\";s:4:\"User\";s:11:\"constraints\";a:0:{}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:1:{i:0;s:4:\"name\";}s:7:\"related\";b:0;s:6:\"values\";a:7:{s:2:\"id\";s:2:\"id\";s:4:\"name\";s:4:\"name\";s:22:\"default_email__address\";s:22:\"default_email__address\";s:11:\"account__id\";s:11:\"account__id\";s:15:\"account__status\";s:15:\"account__status\";s:7:\"created\";s:7:\"created\";s:7:\"updated\";s:7:\"updated\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:1:{s:12:\"ticket_count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:7:\"tickets\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:12:\"ticket_count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}','2017-08-02 13:22:26',NULL,'1','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:54.0) Gecko/20100101 Firefox/54.0'),('te1mdinv687lnel24u1adec421','csrf|a:2:{s:5:\"token\";s:40:\"c859dea457b315977beca449e1545057b804917d\";s:4:\"time\";i:1501744207;}_auth|a:2:{s:5:\"staff\";N;s:4:\"user\";a:0:{}}:token|a:0:{}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}','2017-08-04 09:10:07',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:54.0) Gecko/20100101 Firefox/54.0'),('vfk6p5136ftj7bmf32793lll34','csrf|a:2:{s:5:\"token\";s:40:\"ee570e5adf91630f5dfb8cf7402d0e4fd7b2ee83\";s:4:\"time\";i:1501659404;}_auth|a:2:{s:4:\"user\";a:1:{s:7:\"strikes\";i:2;}s:5:\"staff\";a:2:{s:2:\"id\";i:1;s:3:\"key\";s:12:\"local:carlos\";}}_staff|a:1:{s:4:\"auth\";a:2:{s:4:\"dest\";s:5:\"/scp/\";s:3:\"msg\";s:24:\"Autenticaci√≥n Requerida\";}}:token|a:1:{s:5:\"staff\";s:76:\"1bea252f657170151e50b5e99299e9d7:1501659379:efb4e12265ca7e4fc8fc726a9feb90bc\";}::Q:T|s:4:\"open\";:QT:open:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}:Q:tickets|C:8:\"QuerySet\":4943:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":1057:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"ticket_id__in\";C:8:\"QuerySet\":983:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:3:{i:0;C:1:\"Q\":54:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:10:\"isanswered\";i:0;}}}i:1;C:1:\"Q\":64:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"status__state\";s:4:\"open\";}}}i:2;C:1:\"Q\":317:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":267:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{i:0;C:1:\"Q\":132:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:13:\"status__state\";s:4:\"open\";i:0;C:1:\"Q\":51:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{s:8:\"staff_id\";i:1;}}}}}}s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:1:{i:0;s:9:\"ticket_id\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:3;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}}}}s:16:\"path_constraints\";a:1:{s:4:\"lock\";a:1:{i:0;C:1:\"Q\":131:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:16:\"lock__expire__gt\";O:11:\"SqlFunction\":3:{s:5:\"alias\";N;s:4:\"func\";s:3:\"NOW\";s:4:\"args\";a:0:{}}}}}}}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:22:{s:14:\"lock__staff_id\";s:14:\"lock__staff_id\";s:8:\"staff_id\";s:8:\"staff_id\";s:9:\"isoverdue\";s:9:\"isoverdue\";s:7:\"team_id\";s:7:\"team_id\";s:9:\"ticket_id\";s:9:\"ticket_id\";s:6:\"number\";s:6:\"number\";s:14:\"cdata__subject\";s:14:\"cdata__subject\";s:28:\"user__default_email__address\";s:28:\"user__default_email__address\";s:6:\"source\";s:6:\"source\";s:32:\"cdata__:priority__priority_color\";s:32:\"cdata__:priority__priority_color\";s:31:\"cdata__:priority__priority_desc\";s:31:\"cdata__:priority__priority_desc\";s:9:\"status_id\";s:9:\"status_id\";s:12:\"status__name\";s:12:\"status__name\";s:13:\"status__state\";s:13:\"status__state\";s:7:\"dept_id\";s:7:\"dept_id\";s:10:\"dept__name\";s:10:\"dept__name\";s:10:\"user__name\";s:10:\"user__name\";s:10:\"lastupdate\";s:10:\"lastupdate\";s:10:\"isanswered\";s:10:\"isanswered\";s:16:\"staff__firstname\";s:16:\"staff__firstname\";s:15:\"staff__lastname\";s:15:\"staff__lastname\";s:10:\"team__name\";s:10:\"team__name\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:3:{s:12:\"collab_count\";C:8:\"QuerySet\":672:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:17:\"collaborators__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:16:\"attachment_count\";C:8:\"QuerySet\":768:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":72:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:28:\"entries__attachments__inline\";i:0;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:24:\"entries__attachments__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:12:\"thread_count\";C:8:\"QuerySet\":749:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":66:{a:3:{i:0;i:1;i:1;i:0;i:2;a:1:{s:22:\"entries__flags__hasbit\";i:4;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:11:\"entries__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}lastcroncall|i:1501659282;cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}','2017-08-03 09:36:44',NULL,'1','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:54.0) Gecko/20100101 Firefox/54.0');
/*!40000 ALTER TABLE `ost_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_sla`
--

DROP TABLE IF EXISTS `ost_sla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_sla` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `flags` int(10) unsigned NOT NULL DEFAULT '3',
  `grace_period` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(64) NOT NULL DEFAULT '',
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `alert_staff` int(11) unsigned DEFAULT NULL,
  `next_sla` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_sla`
--

LOCK TABLES `ost_sla` WRITE;
/*!40000 ALTER TABLE `ost_sla` DISABLE KEYS */;
INSERT INTO `ost_sla` VALUES (2,1,72,'Primera fase','Tiempo de respuesta est√°ndar','2017-08-02 11:29:01','2017-08-02 11:30:32',7,3),(3,1,48,'Segunda fase','Tiempo de respuesta adicional','2017-08-02 11:29:19','2017-08-02 11:30:18',2,NULL);
/*!40000 ALTER TABLE `ost_sla` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_staff`
--

DROP TABLE IF EXISTS `ost_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_staff` (
  `staff_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dept_id` int(10) unsigned NOT NULL DEFAULT '0',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0',
  `username` varchar(32) NOT NULL DEFAULT '',
  `firstname` varchar(32) DEFAULT NULL,
  `lastname` varchar(32) DEFAULT NULL,
  `passwd` varchar(128) DEFAULT NULL,
  `backend` varchar(32) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `phone` varchar(24) NOT NULL DEFAULT '',
  `phone_ext` varchar(6) DEFAULT NULL,
  `mobile` varchar(24) NOT NULL DEFAULT '',
  `signature` text NOT NULL,
  `lang` varchar(16) DEFAULT NULL,
  `timezone` varchar(64) DEFAULT NULL,
  `locale` varchar(16) DEFAULT NULL,
  `notes` text,
  `isactive` tinyint(1) NOT NULL DEFAULT '1',
  `isadmin` tinyint(1) NOT NULL DEFAULT '0',
  `isvisible` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `onvacation` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `assigned_only` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `show_assigned_tickets` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `change_passwd` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `max_page_size` int(11) unsigned NOT NULL DEFAULT '0',
  `auto_refresh_rate` int(10) unsigned NOT NULL DEFAULT '0',
  `default_signature_type` enum('none','mine','dept') NOT NULL DEFAULT 'none',
  `default_paper_size` enum('Letter','Legal','Ledger','A4','A3') NOT NULL DEFAULT 'Letter',
  `extra` text,
  `permissions` text,
  `created` datetime NOT NULL,
  `lastlogin` datetime DEFAULT NULL,
  `passwdreset` datetime DEFAULT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `username` (`username`),
  KEY `dept_id` (`dept_id`),
  KEY `issuperuser` (`isadmin`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_staff`
--

LOCK TABLES `ost_staff` WRITE;
/*!40000 ALTER TABLE `ost_staff` DISABLE KEYS */;
INSERT INTO `ost_staff` VALUES (1,4,1,'carlos','Carlos','N√∫√±ez','$2a$08$Yz1e7fueJl/g51dIcB/d0e3y12fZbp98v4VRcfEFjReMdAFtWlbDe',NULL,'carlos.nunez@juntaex.es','',NULL,'','',NULL,NULL,NULL,NULL,1,1,0,0,0,0,0,25,0,'none','Letter','{\"browser_lang\":\"es_ES\",\"def_assn_role\":true}','{\"user.create\":1,\"user.edit\":1,\"user.delete\":1,\"user.manage\":1,\"user.dir\":1,\"org.create\":1,\"org.edit\":1,\"org.delete\":1,\"faq.manage\":1,\"emails.banlist\":1}','2017-08-01 12:23:25','2017-08-03 11:33:10','2017-08-01 14:31:46','2017-08-03 11:33:10'),(2,5,2,'antonio','Antonio','Baeza','$2a$08$1RVtwsax8Yr2KcRyne4KH.0yHQz1hCgNUImjBSSQS4uc8RU/bnaSq',NULL,'tritium@juntaex.es','',NULL,'','',NULL,NULL,NULL,NULL,1,0,1,0,0,0,0,0,0,'none','Letter','{\"def_assn_role\":true}','{\"user.create\":1,\"user.edit\":1,\"user.delete\":1,\"user.manage\":1,\"user.dir\":1,\"org.create\":1,\"org.edit\":1,\"org.delete\":1,\"faq.manage\":1}','2017-08-01 14:41:42',NULL,'2017-08-02 11:13:33','2017-08-02 11:13:33'),(3,7,2,'david','David','Valencia','$2a$08$A65NrS.FK1SDU147/Tj55.infi5REYgzEkXwNLLvrgKbVDq4ZKKQ2',NULL,'david@laruex.es','',NULL,'','',NULL,NULL,NULL,NULL,1,0,0,0,0,0,0,0,0,'none','Letter','{\"def_assn_role\":true}','{\"user.create\":1,\"user.edit\":1,\"user.delete\":1,\"user.manage\":1,\"user.dir\":1,\"org.create\":1,\"org.edit\":1,\"org.delete\":1,\"faq.manage\":1}','2017-08-01 14:42:50',NULL,'2017-08-02 11:14:22','2017-08-02 11:14:27'),(4,8,2,'jose','Jos√© √Ångel','Corbacho','$2a$08$QnZ7rGCByMbKMBQiXVaukegi8KLAvXo8wG3P.gY8gPOfZpUfFJwkG',NULL,'rat_va_pc@juntaex.es','',NULL,'','',NULL,NULL,NULL,NULL,1,0,1,0,0,0,0,0,0,'none','Letter','{\"def_assn_role\":true,\"browser_lang\":\"es_ES\"}','{\"user.create\":1,\"user.edit\":1,\"user.delete\":1,\"user.manage\":1,\"user.dir\":1,\"org.create\":1,\"org.edit\":1,\"org.delete\":1,\"faq.manage\":1}','2017-08-01 14:43:38','2017-08-02 11:18:30','2017-08-02 11:13:11','2017-08-02 11:18:30'),(5,7,2,'juan','Juan','Baeza',NULL,NULL,'ratvapc@gmail.com','',NULL,'','',NULL,NULL,NULL,NULL,1,0,1,0,0,0,0,0,0,'none','Letter','{\"def_assn_role\":true}','{\"user.create\":1,\"user.edit\":1,\"user.delete\":1,\"user.manage\":1,\"user.dir\":1,\"org.create\":1,\"org.edit\":1,\"org.delete\":1,\"faq.manage\":1}','2017-08-01 14:44:53',NULL,NULL,'2017-08-01 14:44:53'),(6,8,2,'manolo','Jos√© Manuel','Caballero',NULL,NULL,'manolo@laruex.es','',NULL,'','',NULL,NULL,NULL,NULL,1,0,0,0,0,0,0,0,0,'none','Letter','{\"def_assn_role\":true}','{\"user.create\":1,\"user.edit\":1,\"user.delete\":1,\"user.manage\":1,\"user.dir\":1,\"org.create\":1,\"org.edit\":1,\"org.delete\":1,\"faq.manage\":1}','2017-08-01 14:45:48',NULL,NULL,'2017-08-02 08:27:55'),(7,6,2,'angeles','M¬™ √Ångeles','Ontalba','$2a$08$BtnMw1AfZQCN5fhal95lbu1uQ6qURWBDRP8kAmCfhJleTXaMITSGm',NULL,'eco2cir@gmail.com','',NULL,'','',NULL,NULL,NULL,NULL,1,0,0,0,0,0,0,0,0,'none','Letter','{\"def_assn_role\":true,\"browser_lang\":\"es_ES\"}','{\"user.create\":1,\"user.edit\":1,\"user.delete\":1,\"user.manage\":1,\"user.dir\":1,\"org.create\":1,\"org.edit\":1,\"org.delete\":1,\"faq.manage\":1}','2017-08-01 14:46:53','2017-08-02 14:03:48','2017-08-02 11:12:19','2017-08-02 14:03:48'),(8,7,2,'pepe','Jos√©','Vasco','$2a$08$kc8tsvzqiKnIIB12mnFzi.EbMYsvq24P8GRtJPDV7mzlxfczV07IW',NULL,'eco2cir@juntaex.es','',NULL,'','',NULL,NULL,NULL,NULL,1,0,0,0,0,0,0,0,0,'none','Letter','{\"def_assn_role\":true,\"browser_lang\":\"es_ES\"}','{\"user.create\":1,\"user.edit\":1,\"user.delete\":1,\"user.manage\":1,\"user.dir\":1,\"org.create\":1,\"org.edit\":1,\"org.delete\":1,\"faq.manage\":1}','2017-08-01 14:47:40','2017-08-03 11:31:52','2017-08-02 11:38:55','2017-08-03 11:31:52');
/*!40000 ALTER TABLE `ost_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_staff_dept_access`
--

DROP TABLE IF EXISTS `ost_staff_dept_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_staff_dept_access` (
  `staff_id` int(10) unsigned NOT NULL DEFAULT '0',
  `dept_id` int(10) unsigned NOT NULL DEFAULT '0',
  `role_id` int(10) unsigned NOT NULL DEFAULT '0',
  `flags` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`staff_id`,`dept_id`),
  KEY `dept_id` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_staff_dept_access`
--

LOCK TABLES `ost_staff_dept_access` WRITE;
/*!40000 ALTER TABLE `ost_staff_dept_access` DISABLE KEYS */;
INSERT INTO `ost_staff_dept_access` VALUES (0,4,4,1),(7,4,2,1);
/*!40000 ALTER TABLE `ost_staff_dept_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_syslog`
--

DROP TABLE IF EXISTS `ost_syslog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_syslog` (
  `log_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `log_type` enum('Debug','Warning','Error') NOT NULL,
  `title` varchar(255) NOT NULL,
  `log` text NOT NULL,
  `logger` varchar(64) NOT NULL,
  `ip_address` varchar(64) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`log_id`),
  KEY `log_type` (`log_type`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_syslog`
--

LOCK TABLES `ost_syslog` WRITE;
/*!40000 ALTER TABLE `ost_syslog` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_syslog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_task`
--

DROP TABLE IF EXISTS `ost_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_task` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int(11) NOT NULL DEFAULT '0',
  `object_type` char(1) NOT NULL,
  `number` varchar(20) DEFAULT NULL,
  `dept_id` int(10) unsigned NOT NULL DEFAULT '0',
  `staff_id` int(10) unsigned NOT NULL DEFAULT '0',
  `team_id` int(10) unsigned NOT NULL DEFAULT '0',
  `lock_id` int(11) unsigned NOT NULL DEFAULT '0',
  `flags` int(10) unsigned NOT NULL DEFAULT '0',
  `duedate` datetime DEFAULT NULL,
  `closed` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dept_id` (`dept_id`),
  KEY `staff_id` (`staff_id`),
  KEY `team_id` (`team_id`),
  KEY `created` (`created`),
  KEY `object` (`object_id`,`object_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_task`
--

LOCK TABLES `ost_task` WRITE;
/*!40000 ALTER TABLE `ost_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_team`
--

DROP TABLE IF EXISTS `ost_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_team` (
  `team_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` int(10) unsigned NOT NULL DEFAULT '0',
  `flags` int(10) unsigned NOT NULL DEFAULT '1',
  `name` varchar(125) NOT NULL DEFAULT '',
  `notes` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`team_id`),
  UNIQUE KEY `name` (`name`),
  KEY `lead_id` (`lead_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_team`
--

LOCK TABLES `ost_team` WRITE;
/*!40000 ALTER TABLE `ost_team` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_team_member`
--

DROP TABLE IF EXISTS `ost_team_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_team_member` (
  `team_id` int(10) unsigned NOT NULL DEFAULT '0',
  `staff_id` int(10) unsigned NOT NULL,
  `flags` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`team_id`,`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_team_member`
--

LOCK TABLES `ost_team_member` WRITE;
/*!40000 ALTER TABLE `ost_team_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_team_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread`
--

DROP TABLE IF EXISTS `ost_thread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_thread` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `object_id` int(11) unsigned NOT NULL,
  `object_type` char(1) NOT NULL,
  `extra` text,
  `lastresponse` datetime DEFAULT NULL,
  `lastmessage` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `object_id` (`object_id`),
  KEY `object_type` (`object_type`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread`
--

LOCK TABLES `ost_thread` WRITE;
/*!40000 ALTER TABLE `ost_thread` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_thread` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread_collaborator`
--

DROP TABLE IF EXISTS `ost_thread_collaborator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_thread_collaborator` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `isactive` tinyint(1) NOT NULL DEFAULT '1',
  `thread_id` int(11) unsigned NOT NULL DEFAULT '0',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0',
  `role` char(1) NOT NULL DEFAULT 'M',
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collab` (`thread_id`,`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread_collaborator`
--

LOCK TABLES `ost_thread_collaborator` WRITE;
/*!40000 ALTER TABLE `ost_thread_collaborator` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_thread_collaborator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread_entry`
--

DROP TABLE IF EXISTS `ost_thread_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_thread_entry` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned NOT NULL DEFAULT '0',
  `thread_id` int(11) unsigned NOT NULL DEFAULT '0',
  `staff_id` int(11) unsigned NOT NULL DEFAULT '0',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0',
  `type` char(1) NOT NULL DEFAULT '',
  `flags` int(11) unsigned NOT NULL DEFAULT '0',
  `poster` varchar(128) NOT NULL DEFAULT '',
  `editor` int(10) unsigned DEFAULT NULL,
  `editor_type` char(1) DEFAULT NULL,
  `source` varchar(32) NOT NULL DEFAULT '',
  `title` varchar(255) DEFAULT NULL,
  `body` text NOT NULL,
  `format` varchar(16) NOT NULL DEFAULT 'html',
  `ip_address` varchar(64) NOT NULL DEFAULT '',
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `thread_id` (`thread_id`),
  KEY `staff_id` (`staff_id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread_entry`
--

LOCK TABLES `ost_thread_entry` WRITE;
/*!40000 ALTER TABLE `ost_thread_entry` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_thread_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread_entry_email`
--

DROP TABLE IF EXISTS `ost_thread_entry_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_thread_entry_email` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `thread_entry_id` int(11) unsigned NOT NULL,
  `mid` varchar(255) NOT NULL,
  `headers` text,
  PRIMARY KEY (`id`),
  KEY `thread_entry_id` (`thread_entry_id`),
  KEY `mid` (`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread_entry_email`
--

LOCK TABLES `ost_thread_entry_email` WRITE;
/*!40000 ALTER TABLE `ost_thread_entry_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_thread_entry_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_thread_event`
--

DROP TABLE IF EXISTS `ost_thread_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_thread_event` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `thread_id` int(11) unsigned NOT NULL DEFAULT '0',
  `staff_id` int(11) unsigned NOT NULL,
  `team_id` int(11) unsigned NOT NULL,
  `dept_id` int(11) unsigned NOT NULL,
  `topic_id` int(11) unsigned NOT NULL,
  `state` enum('created','closed','reopened','assigned','transferred','overdue','edited','viewed','error','collab','resent') NOT NULL,
  `data` varchar(1024) DEFAULT NULL COMMENT 'Encoded differences',
  `username` varchar(128) NOT NULL DEFAULT 'SYSTEM',
  `uid` int(11) unsigned DEFAULT NULL,
  `uid_type` char(1) NOT NULL DEFAULT 'S',
  `annulled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_state` (`thread_id`,`state`,`timestamp`),
  KEY `ticket_stats` (`timestamp`,`state`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread_event`
--

LOCK TABLES `ost_thread_event` WRITE;
/*!40000 ALTER TABLE `ost_thread_event` DISABLE KEYS */;
INSERT INTO `ost_thread_event` VALUES (1,0,0,0,1,1,'created',NULL,'SYSTEM',1,'U',0,'2017-08-01 12:23:25'),(2,0,0,0,6,15,'created',NULL,'Juan Baeza',5,'U',0,'2017-08-02 11:01:33'),(3,0,4,0,6,15,'assigned','{\"staff\":4}','ratvapc@gmail.com',NULL,'S',0,'2017-08-02 11:01:36'),(4,0,4,0,8,15,'closed','{\"status\":[3,\"Cerrado\"]}','jose',4,'S',0,'2017-08-02 11:22:06'),(5,0,0,0,6,16,'created',NULL,'Juan Baeza',5,'U',0,'2017-08-02 11:35:42'),(6,0,7,0,6,16,'assigned','{\"staff\":7}','ratvapc@gmail.com',NULL,'S',0,'2017-08-02 11:35:43'),(7,0,0,0,6,16,'created',NULL,'Juan Baeza',5,'U',0,'2017-08-02 11:58:33'),(8,0,7,0,6,16,'assigned','{\"staff\":7}','ratvapc@gmail.com',NULL,'S',0,'2017-08-02 11:58:35'),(9,0,0,0,6,16,'created',NULL,'Juan Baeza',5,'U',0,'2017-08-02 12:00:11'),(10,0,8,0,6,16,'assigned','{\"staff\":8}','ratvapc@gmail.com',NULL,'S',0,'2017-08-02 12:00:13'),(11,0,0,0,7,16,'transferred',NULL,'angeles',7,'S',0,'2017-08-02 12:06:43'),(12,0,0,0,6,18,'created',NULL,'Jos√© Vasco',8,'U',0,'2017-08-02 13:08:20'),(13,0,4,0,6,18,'assigned','{\"staff\":4}','eco2cir@juntaex.es',NULL,'S',0,'2017-08-02 13:08:22'),(14,0,4,0,8,18,'overdue',NULL,'SYSTEM',NULL,'S',0,'2017-08-02 14:03:48'),(15,0,4,0,8,18,'overdue',NULL,'SYSTEM',NULL,'S',0,'2017-08-02 14:14:07'),(16,0,0,0,7,18,'created',NULL,'carlos',1,'S',0,'2017-08-02 14:26:56'),(17,0,8,0,7,18,'assigned','{\"staff\":[8,\"Jos\\u00e9 Vasco\"]}','carlos',1,'S',0,'2017-08-02 14:26:56'),(18,0,8,0,7,18,'overdue',NULL,'SYSTEM',NULL,'S',0,'2017-08-02 14:36:39'),(19,0,8,0,7,18,'overdue',NULL,'SYSTEM',NULL,'S',0,'2017-08-02 14:51:35'),(20,0,0,0,6,15,'created',NULL,'Juan Baeza',5,'U',0,'2017-08-03 09:09:43'),(21,0,8,0,6,15,'assigned','{\"staff\":8}','ratvapc@gmail.com',NULL,'S',0,'2017-08-03 09:09:46'),(22,0,8,0,7,15,'overdue',NULL,'SYSTEM',NULL,'S',0,'2017-08-03 09:13:40'),(23,0,8,0,7,15,'overdue',NULL,'SYSTEM',NULL,'S',0,'2017-08-03 09:16:57'),(24,0,1,0,7,15,'closed','{\"status\":[3,\"Cerrado\"]}','carlos',1,'S',1,'2017-08-03 11:28:22'),(25,0,1,0,7,15,'reopened',NULL,'pepe',8,'S',0,'2017-08-03 11:32:08'),(26,0,8,0,7,15,'closed','{\"status\":[3,\"Cerrado\"]}','pepe',8,'S',0,'2017-08-03 11:32:34');
/*!40000 ALTER TABLE `ost_thread_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_ticket`
--

DROP TABLE IF EXISTS `ost_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_ticket` (
  `ticket_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `number` varchar(20) DEFAULT NULL,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0',
  `user_email_id` int(11) unsigned NOT NULL DEFAULT '0',
  `status_id` int(10) unsigned NOT NULL DEFAULT '0',
  `dept_id` int(10) unsigned NOT NULL DEFAULT '0',
  `sla_id` int(10) unsigned NOT NULL DEFAULT '0',
  `topic_id` int(10) unsigned NOT NULL DEFAULT '0',
  `staff_id` int(10) unsigned NOT NULL DEFAULT '0',
  `team_id` int(10) unsigned NOT NULL DEFAULT '0',
  `email_id` int(11) unsigned NOT NULL DEFAULT '0',
  `lock_id` int(11) unsigned NOT NULL DEFAULT '0',
  `flags` int(10) unsigned NOT NULL DEFAULT '0',
  `ip_address` varchar(64) NOT NULL DEFAULT '',
  `source` enum('Web','Email','Phone','API','Other') NOT NULL DEFAULT 'Other',
  `source_extra` varchar(40) DEFAULT NULL,
  `isoverdue` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isanswered` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `duedate` datetime DEFAULT NULL,
  `est_duedate` datetime DEFAULT NULL,
  `reopened` datetime DEFAULT NULL,
  `closed` datetime DEFAULT NULL,
  `lastupdate` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `last_duedate` datetime DEFAULT NULL,
  PRIMARY KEY (`ticket_id`),
  KEY `user_id` (`user_id`),
  KEY `dept_id` (`dept_id`),
  KEY `staff_id` (`staff_id`),
  KEY `team_id` (`team_id`),
  KEY `status_id` (`status_id`),
  KEY `created` (`created`),
  KEY `closed` (`closed`),
  KEY `duedate` (`duedate`),
  KEY `topic_id` (`topic_id`),
  KEY `sla_id` (`sla_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_ticket`
--

LOCK TABLES `ost_ticket` WRITE;
/*!40000 ALTER TABLE `ost_ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_ticket__cdata`
--

DROP TABLE IF EXISTS `ost_ticket__cdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_ticket__cdata` (
  `ticket_id` int(11) unsigned NOT NULL,
  `subject` mediumtext,
  `priority` mediumtext,
  PRIMARY KEY (`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_ticket__cdata`
--

LOCK TABLES `ost_ticket__cdata` WRITE;
/*!40000 ALTER TABLE `ost_ticket__cdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_ticket__cdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_ticket_priority`
--

DROP TABLE IF EXISTS `ost_ticket_priority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_ticket_priority` (
  `priority_id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `priority` varchar(60) NOT NULL DEFAULT '',
  `priority_desc` varchar(30) NOT NULL DEFAULT '',
  `priority_color` varchar(7) NOT NULL DEFAULT '',
  `priority_urgency` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ispublic` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`priority_id`),
  UNIQUE KEY `priority` (`priority`),
  KEY `priority_urgency` (`priority_urgency`),
  KEY `ispublic` (`ispublic`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_ticket_priority`
--

LOCK TABLES `ost_ticket_priority` WRITE;
/*!40000 ALTER TABLE `ost_ticket_priority` DISABLE KEYS */;
INSERT INTO `ost_ticket_priority` VALUES (1,'low','Low','#DDFFDD',4,1),(2,'normal','Normal','#FFFFF0',3,1),(3,'high','High','#FEE7E7',2,1),(4,'emergency','Emergency','#FEE7E7',1,1);
/*!40000 ALTER TABLE `ost_ticket_priority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_ticket_status`
--

DROP TABLE IF EXISTS `ost_ticket_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_ticket_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL DEFAULT '',
  `state` varchar(16) DEFAULT NULL,
  `mode` int(11) unsigned NOT NULL DEFAULT '0',
  `flags` int(11) unsigned NOT NULL DEFAULT '0',
  `sort` int(11) unsigned NOT NULL DEFAULT '0',
  `properties` text NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `state` (`state`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_ticket_status`
--

LOCK TABLES `ost_ticket_status` WRITE;
/*!40000 ALTER TABLE `ost_ticket_status` DISABLE KEYS */;
INSERT INTO `ost_ticket_status` VALUES (1,'Abierto','open',3,0,2,'{\"allowreopen\":true,\"reopenstatus\":0,\"35\":\"Open tickets.\"}','2017-08-01 12:23:25','0000-00-00 00:00:00'),(3,'Cerrado','closed',3,0,3,'{\"allowreopen\":false,\"reopenstatus\":0,\"35\":\"Closed tickets. Tickets will still be accessible on client and staff panels.\"}','2017-08-01 12:23:25','0000-00-00 00:00:00'),(4,'Archivado','archived',3,0,4,'{\"allowreopen\":true,\"reopenstatus\":0,\"35\":\"Tickets only adminstratively available but no longer accessible on ticket queues and client panel.\"}','2017-08-01 12:23:25','0000-00-00 00:00:00'),(5,'Borrado','deleted',3,0,5,'{\"allowreopen\":true,\"reopenstatus\":0,\"35\":\"Tickets queued for deletion. Not accessible on ticket queues.\"}','2017-08-01 12:23:25','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `ost_ticket_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_translation`
--

DROP TABLE IF EXISTS `ost_translation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_translation` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `object_hash` char(16) CHARACTER SET ascii DEFAULT NULL,
  `type` enum('phrase','article','override') DEFAULT NULL,
  `flags` int(10) unsigned NOT NULL DEFAULT '0',
  `revision` int(11) unsigned DEFAULT NULL,
  `agent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `lang` varchar(16) NOT NULL DEFAULT '',
  `text` mediumtext NOT NULL,
  `source_text` text,
  `updated` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `type` (`type`,`lang`),
  KEY `object_hash` (`object_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_translation`
--

LOCK TABLES `ost_translation` WRITE;
/*!40000 ALTER TABLE `ost_translation` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_translation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_user`
--

DROP TABLE IF EXISTS `ost_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` int(10) unsigned NOT NULL,
  `default_email_id` int(10) NOT NULL,
  `status` int(11) unsigned NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `org_id` (`org_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_user`
--

LOCK TABLES `ost_user` WRITE;
/*!40000 ALTER TABLE `ost_user` DISABLE KEYS */;
INSERT INTO `ost_user` VALUES (2,0,2,0,'Antonio Baeza','2017-08-02 08:29:32','2017-08-02 08:29:32'),(3,0,3,0,'David Valencia','2017-08-02 08:31:41','2017-08-02 08:31:41'),(4,0,4,0,'Jos√© √Ångel Corbacho','2017-08-02 08:32:46','2017-08-02 08:32:46'),(5,0,5,0,'Juan Baeza','2017-08-02 08:33:23','2017-08-02 08:33:23'),(6,0,6,0,'Jos√© Manuel Caballero','2017-08-02 08:34:31','2017-08-02 08:34:31'),(7,0,7,0,'M¬™ √Ångeles Ontalba','2017-08-02 08:36:14','2017-08-02 08:36:14'),(8,0,8,0,'Jos√© Vasco','2017-08-02 08:37:09','2017-08-02 08:37:09');
/*!40000 ALTER TABLE `ost_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_user__cdata`
--

DROP TABLE IF EXISTS `ost_user__cdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_user__cdata` (
  `user_id` int(11) unsigned NOT NULL,
  `email` mediumtext,
  `name` mediumtext,
  `phone` mediumtext,
  `notes` mediumtext,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_user__cdata`
--

LOCK TABLES `ost_user__cdata` WRITE;
/*!40000 ALTER TABLE `ost_user__cdata` DISABLE KEYS */;
INSERT INTO `ost_user__cdata` VALUES (1,NULL,NULL,NULL,NULL),(2,NULL,NULL,'',''),(3,NULL,NULL,'',''),(4,NULL,NULL,'',''),(5,NULL,NULL,'',''),(6,NULL,NULL,'',''),(7,NULL,NULL,'',''),(8,NULL,NULL,'','');
/*!40000 ALTER TABLE `ost_user__cdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_user_account`
--

DROP TABLE IF EXISTS `ost_user_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_user_account` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `status` int(11) unsigned NOT NULL DEFAULT '0',
  `timezone` varchar(64) DEFAULT NULL,
  `lang` varchar(16) DEFAULT NULL,
  `username` varchar(64) DEFAULT NULL,
  `passwd` varchar(128) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `backend` varchar(32) DEFAULT NULL,
  `extra` text,
  `registered` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_user_account`
--

LOCK TABLES `ost_user_account` WRITE;
/*!40000 ALTER TABLE `ost_user_account` DISABLE KEYS */;
INSERT INTO `ost_user_account` VALUES (1,2,1,'Europe/Berlin',NULL,NULL,'$2a$08$OMpeDl1igHTExQGJP7b8xOlJMWgl1UQRTjyOttKJnJiZVv3GKE6KO',NULL,NULL,'2017-08-02 06:30:20'),(2,3,1,'Europe/Berlin',NULL,NULL,'$2a$08$mt7oKRQXg4iEHXgzEw6sDO/ysORaQrMPYg3DAJT8dhCQom1qkGaGS',NULL,NULL,'2017-08-02 06:32:04'),(3,4,1,'Europe/Berlin',NULL,NULL,'$2a$08$LW41fRzA69EvbHzudvUWzO9v2foCW8OVjVyU3BIggItWBhxvlowEG',NULL,NULL,'2017-08-02 06:32:58'),(4,5,1,'Europe/Berlin',NULL,NULL,'$2a$08$w7njTtgxLMCmT1mEJ1AN.OujL3h8iTQ09jyyAW8igopCY.Be72nqS',NULL,'{\"browser_lang\":\"es_ES\"}','2017-08-02 06:33:42'),(5,6,1,'Europe/Berlin',NULL,NULL,'$2a$08$SPv7EnsNz1qa8EdOW17nTePqvulaaPlHBKYZYR0OQ2lHzziHocnT.',NULL,NULL,'2017-08-02 06:34:49'),(6,7,1,'Europe/Berlin',NULL,NULL,'$2a$08$aoxkX1qHDCKDh8RsoLICXODT.L9cWk7svw/kKiIinNnGkPXmU9OcK',NULL,NULL,'2017-08-02 06:36:30'),(7,8,1,'Europe/Berlin',NULL,NULL,'$2a$08$63lBB11Z3Lz.h9yEL.zUNeeSIYgT7OEnvM97xne8C.pWILPN0FsvS',NULL,'{\"browser_lang\":\"es_ES\"}','2017-08-02 06:37:25');
/*!40000 ALTER TABLE `ost_user_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_user_email`
--

DROP TABLE IF EXISTS `ost_user_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_user_email` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `flags` int(10) unsigned NOT NULL DEFAULT '0',
  `address` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `address` (`address`),
  KEY `user_email_lookup` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_user_email`
--

LOCK TABLES `ost_user_email` WRITE;
/*!40000 ALTER TABLE `ost_user_email` DISABLE KEYS */;
INSERT INTO `ost_user_email` VALUES (2,2,0,'tritium@juntaex.es'),(3,3,0,'david@laruex.es'),(4,4,0,'rat_va_pc@juntaex.es'),(5,5,0,'ratvapc@gmail.com'),(6,6,0,'manolo@laruex.es'),(7,7,0,'eco2cir@gmail.com'),(8,8,0,'eco2cir@juntaex.es');
/*!40000 ALTER TABLE `ost_user_email` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-08-03 11:34:15
