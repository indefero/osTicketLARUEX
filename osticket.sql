-- MySQL dump 10.13  Distrib 5.7.20, for Linux (x86_64)
--
-- Host: localhost    Database: osticket
-- ------------------------------------------------------
-- Server version	5.7.20-0ubuntu0.16.04.1

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
INSERT INTO `ost__search` VALUES ('U',2,'Antonio Baeza',' tritium@juntaex.es\ntritium@juntaex.es'),('U',3,'David Valencia',' david@laruex.es\ndavid@laruex.es'),('U',4,'José Ángel Corbacho',' rat_va_pc@juntaex.es\nrat_va_pc@juntaex.es'),('U',5,'Juan Baeza',' ratvapc@gmail.com\nratvapc@gmail.com'),('U',6,'José Manuel Caballero',' josemanuel@laruex.es\njosemanuel@laruex.es'),('U',7,'Mª Ángeles Ontalba',' eco2cir@gmail.com\neco2cir@gmail.com'),('U',8,'José Vasco',' eco2cir@juntaex.es\neco2cir@juntaex.es');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_attachment`
--

LOCK TABLES `ost_attachment` WRITE;
/*!40000 ALTER TABLE `ost_attachment` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_config`
--

LOCK TABLES `ost_config` WRITE;
/*!40000 ALTER TABLE `ost_config` DISABLE KEYS */;
INSERT INTO `ost_config` VALUES (1,'core','admin_email','carlos.nunez@juntaex.es','2017-08-01 10:23:25'),(2,'core','helpdesk_url','http://172.22.13.78/','2017-08-01 10:23:25'),(3,'core','helpdesk_title','Soporte LARUEX','2017-08-01 10:23:25'),(4,'core','schema_signature','98ad7d550c26ac44340350912296e673','2017-08-01 10:23:25'),(5,'core','time_format','hh:mm a','2017-08-01 10:23:25'),(6,'core','date_format','MM/dd/y','2017-08-01 10:23:25'),(7,'core','datetime_format','MM/dd/y h:mm a','2017-08-01 10:23:25'),(8,'core','daydatetime_format','EEE, MMM d y h:mm a','2017-08-01 10:23:25'),(9,'core','default_priority_id','2','2017-08-01 10:23:25'),(10,'core','enable_daylight_saving','','2017-08-01 10:23:25'),(11,'core','reply_separator','-- reply above this line --','2017-08-01 10:23:25'),(12,'core','isonline','1','2017-08-01 10:23:25'),(13,'core','staff_ip_binding','','2017-08-01 10:23:25'),(14,'core','staff_max_logins','4','2017-08-01 10:23:25'),(15,'core','staff_login_timeout','2','2017-08-01 10:23:25'),(16,'core','staff_session_timeout','30','2017-08-01 10:23:25'),(17,'core','passwd_reset_period','0','2017-08-02 09:17:55'),(18,'core','client_max_logins','4','2017-08-01 10:23:25'),(19,'core','client_login_timeout','2','2017-08-01 10:23:25'),(20,'core','client_session_timeout','30','2017-08-01 10:23:25'),(21,'core','max_page_size','25','2017-08-01 10:23:25'),(22,'core','max_open_tickets','0','2017-08-02 09:31:37'),(23,'core','autolock_minutes','3','2017-08-01 10:23:25'),(24,'core','default_smtp_id','0','2017-08-01 12:53:06'),(25,'core','use_email_priority','','2017-08-01 10:23:25'),(26,'core','enable_kb','','2017-08-01 10:23:25'),(27,'core','enable_premade','1','2017-08-01 10:23:25'),(28,'core','enable_captcha','','2017-08-01 10:23:25'),(29,'core','enable_auto_cron','','2017-08-01 10:23:25'),(30,'core','enable_mail_polling','','2017-08-01 10:23:25'),(31,'core','send_sys_errors','0','2017-08-02 05:57:54'),(32,'core','send_sql_errors','1','2017-08-01 10:23:25'),(33,'core','send_login_errors','1','2017-08-01 10:23:25'),(34,'core','save_email_headers','1','2017-08-01 10:23:25'),(35,'core','strip_quoted_reply','1','2017-08-01 10:23:25'),(36,'core','ticket_autoresponder','','2017-08-01 10:23:25'),(37,'core','message_autoresponder','','2017-08-01 10:23:25'),(38,'core','ticket_notice_active','1','2017-08-01 10:23:25'),(39,'core','ticket_alert_active','1','2017-08-01 10:23:25'),(40,'core','ticket_alert_admin','0','2017-08-02 09:48:06'),(41,'core','ticket_alert_dept_manager','1','2017-08-01 10:23:25'),(42,'core','ticket_alert_dept_members','','2017-08-01 10:23:25'),(43,'core','message_alert_active','1','2017-08-01 10:23:25'),(44,'core','message_alert_laststaff','1','2017-08-01 10:23:25'),(45,'core','message_alert_assigned','1','2017-08-01 10:23:25'),(46,'core','message_alert_dept_manager','','2017-08-01 10:23:25'),(47,'core','note_alert_active','0','2017-08-02 05:57:54'),(48,'core','note_alert_laststaff','1','2017-08-01 10:23:25'),(49,'core','note_alert_assigned','1','2017-08-01 10:23:25'),(50,'core','note_alert_dept_manager','','2017-08-01 10:23:25'),(51,'core','transfer_alert_active','0','2017-08-02 05:57:54'),(52,'core','transfer_alert_assigned','','2017-08-01 10:23:25'),(53,'core','transfer_alert_dept_manager','1','2017-08-01 10:23:25'),(54,'core','transfer_alert_dept_members','','2017-08-01 10:23:25'),(55,'core','overdue_alert_active','1','2017-08-01 10:23:25'),(56,'core','overdue_alert_assigned','1','2017-08-01 10:23:25'),(57,'core','overdue_alert_dept_manager','1','2017-08-01 10:23:25'),(58,'core','overdue_alert_dept_members','','2017-08-01 10:23:25'),(59,'core','assigned_alert_active','1','2017-08-01 10:23:25'),(60,'core','assigned_alert_staff','1','2017-08-01 10:23:25'),(61,'core','assigned_alert_team_lead','1','2017-11-02 11:21:53'),(62,'core','assigned_alert_team_members','','2017-08-01 10:23:25'),(63,'core','auto_claim_tickets','1','2017-08-01 10:23:25'),(64,'core','show_related_tickets','0','2017-08-02 09:31:37'),(65,'core','show_assigned_tickets','1','2017-08-02 10:02:02'),(66,'core','show_answered_tickets','1','2017-08-02 09:31:37'),(67,'core','hide_staff_name','','2017-08-01 10:23:25'),(68,'core','overlimit_notice_active','','2017-08-01 10:23:25'),(69,'core','email_attachments','1','2017-08-01 10:23:25'),(70,'core','ticket_number_format','######','2017-08-01 10:23:25'),(71,'core','ticket_sequence_id','1','2017-08-02 11:01:04'),(72,'core','task_number_format','######','2017-08-02 05:58:18'),(73,'core','task_sequence_id','2','2017-08-01 10:23:25'),(74,'core','log_level','2','2017-08-01 10:23:25'),(75,'core','log_graceperiod','12','2017-08-01 10:23:25'),(76,'core','client_registration','closed','2017-08-02 05:52:47'),(77,'core','max_file_size','2097152','2017-08-02 05:52:01'),(78,'core','landing_page_id','1','2017-08-01 10:23:25'),(79,'core','thank-you_page_id','2','2017-08-01 10:23:25'),(80,'core','offline_page_id','3','2017-08-01 10:23:25'),(81,'core','system_language','es_ES','2017-09-25 10:46:18'),(82,'mysqlsearch','reindex','0','2017-08-01 10:59:06'),(83,'core','default_email_id','4','2017-08-01 12:53:06'),(84,'core','alert_email_id','0','2017-08-01 12:53:06'),(85,'core','default_dept_id','4','2017-08-01 12:34:50'),(86,'core','default_sla_id','0','2017-11-06 13:37:30'),(87,'core','default_template_id','2','2017-10-31 10:22:37'),(88,'core','default_timezone','Europe/Madrid','2017-08-02 06:21:56'),(89,'core','default_storage_bk','D','2017-08-01 10:59:14'),(90,'core','date_formats','','2017-08-01 10:59:14'),(91,'core','default_locale','','2017-08-01 10:59:14'),(92,'core','secondary_langs','','2017-09-25 10:18:45'),(93,'core','enable_avatars','1','2017-08-01 10:59:14'),(94,'core','enable_richtext','1','2017-08-01 10:59:14'),(95,'core','files_req_auth','1','2017-08-01 10:59:14'),(96,'core','client_logo_id','','2017-08-01 11:22:18'),(97,'core','staff_logo_id','','2017-08-01 11:22:18'),(98,'core','staff_backdrop_id','','2017-08-01 11:22:18'),(99,'core','verify_email_addrs','1','2017-08-01 12:53:06'),(100,'core','accept_unregistered_email','1','2017-08-01 12:53:06'),(101,'core','add_email_collabs','1','2017-08-01 12:53:06'),(102,'core','clients_only','1','2017-08-02 05:52:57'),(103,'core','client_verify_email','1','2017-08-02 05:52:37'),(104,'core','allow_auth_tokens','1','2017-08-02 05:52:37'),(105,'core','client_name_format','original','2017-08-02 05:52:37'),(106,'core','client_avatar','gravatar.mm','2017-08-02 05:52:37'),(107,'core','message_autoresponder_collabs','1','2017-08-02 05:57:54'),(108,'core','ticket_alert_acct_manager','','2017-08-02 05:57:54'),(109,'core','message_alert_acct_manager','','2017-08-02 05:57:54'),(110,'core','default_task_priority_id','1','2017-08-02 05:58:18'),(111,'core','default_task_sla_id','','2017-08-02 05:58:18'),(112,'core','task_alert_active','0','2017-08-02 05:58:18'),(113,'core','task_alert_admin','','2017-08-02 05:58:18'),(114,'core','task_alert_dept_manager','','2017-08-02 05:58:18'),(115,'core','task_alert_dept_members','','2017-08-02 05:58:18'),(116,'core','task_activity_alert_active','0','2017-08-02 05:58:18'),(117,'core','task_activity_alert_laststaff','','2017-08-02 05:58:18'),(118,'core','task_activity_alert_assigned','','2017-08-02 05:58:18'),(119,'core','task_activity_alert_dept_manager','','2017-08-02 05:58:18'),(120,'core','task_assignment_alert_active','0','2017-08-02 05:58:18'),(121,'core','task_assignment_alert_staff','','2017-08-02 05:58:18'),(122,'core','task_assignment_alert_team_lead','','2017-08-02 05:58:18'),(123,'core','task_assignment_alert_team_members','','2017-08-02 05:58:18'),(124,'core','task_transfer_alert_active','0','2017-08-02 05:58:18'),(125,'core','task_transfer_alert_assigned','','2017-08-02 05:58:18'),(126,'core','task_transfer_alert_dept_manager','','2017-08-02 05:58:18'),(127,'core','task_transfer_alert_dept_members','','2017-08-02 05:58:18'),(128,'core','task_overdue_alert_active','1','2017-09-27 07:16:10'),(129,'core','task_overdue_alert_assigned','1','2017-09-27 07:16:10'),(130,'core','task_overdue_alert_dept_manager','','2017-08-02 05:58:18'),(131,'core','task_overdue_alert_dept_members','','2017-08-02 05:58:18'),(132,'core','restrict_kb','','2017-08-02 05:59:04'),(133,'core','allow_pw_reset','1','2017-08-02 09:17:55'),(134,'core','pw_reset_window','30','2017-08-02 09:17:55'),(135,'core','agent_name_format','full','2017-08-02 09:17:55'),(136,'core','agent_avatar','gravatar.mm','2017-08-02 09:27:05'),(137,'core','default_help_topic','0','2017-08-02 09:31:37'),(138,'core','default_ticket_status_id','1','2017-08-02 09:31:37'),(139,'core','allow_client_updates','','2017-08-02 09:31:37'),(140,'core','ticket_lock','2','2017-08-02 09:31:37'),(141,'staff.1','datetime_format','','2017-09-25 10:26:29'),(142,'staff.1','default_from_name','','2017-09-25 10:26:29'),(143,'staff.1','thread_view_order','','2017-09-25 10:26:29');
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
INSERT INTO `ost_department` VALUES (4,NULL,0,0,0,0,0,1,'Red Alerta Radiológica','Red de Alerta Radiológica',1,1,1,1,'/4/','2017-08-01 14:34:35','2017-08-01 14:34:35'),(5,4,0,0,0,0,0,1,'Dirección','Dpto. Dirección<br />Red de Alerta Radiológica',1,1,1,1,'/4/5/','2017-08-01 14:37:14','2017-08-01 14:37:14'),(6,4,0,0,0,0,0,1,'Calidad','Dpto. Calidad <br />Red de Alerta Radiológica',1,1,1,1,'/4/6/','2017-08-01 14:37:56','2017-08-01 14:37:56'),(7,4,0,0,0,0,0,1,'Informática','Dpto. Informática<br />Red de Alerta Radiológica',1,1,1,1,'/4/7/','2017-08-01 14:38:35','2017-08-01 14:38:35'),(8,4,0,0,0,0,0,1,'Análisis','Dpto. de Análisis<br />Red de Alerta Radiológica',1,1,1,1,'/4/8/','2017-08-01 14:39:08','2017-08-01 14:39:08');
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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_email_template`
--

LOCK TABLES `ost_email_template` WRITE;
/*!40000 ALTER TABLE `ost_email_template` DISABLE KEYS */;
INSERT INTO `ost_email_template` VALUES (1,1,'ticket.autoresp','Support Ticket Opened [#%{ticket.number}]',' <h3><strong>Dear %{recipient.name.first},</strong></h3> <p> A request for support has been created and assigned #%{ticket.number}. A representative will follow-up with you as soon as possible. You can <a href=\"%%7Brecipient.ticket_link%7D\">view this ticket\'s progress online</a>. </p> <br /><div style=\"color:rgb(127, 127, 127)\"> Your %{company.name} Team, <br /> %{signature} </div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small\"><em>If you wish to provide additional comments or information regarding the issue, please reply to this email or <a href=\"%%7Brecipient.ticket_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login to your account</span></a> for a complete archive of your support requests.</em></div> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(2,1,'ticket.autoreply','Re: %{ticket.subject} [#%{ticket.number}]',' <h3><strong>Dear %{recipient.name.first},</strong></h3> A request for support has been created and assigned ticket <a href=\"%%7Brecipient.ticket_link%7D\">#%{ticket.number}</a> with the following automatic reply <br /><br /> Topic: <strong>%{ticket.topic.name}</strong> <br /> Subject: <strong>%{ticket.subject}</strong> <br /><br /> %{response} <br /><br /><div style=\"color:rgb(127, 127, 127)\">Your %{company.name} Team,<br /> %{signature}</div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small\"><em>We hope this response has sufficiently answered your questions. If you wish to provide additional comments or informatione, please reply to this email or <a href=\"%%7Brecipient.ticket_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login to your account</span></a> for a complete archive of your support requests.</em></div> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(3,1,'message.autoresp','Message Confirmation',' <h3><strong>Dear %{recipient.name.first},</strong></h3> Your reply to support request <a href=\"%%7Brecipient.ticket_link%7D\">#%{ticket.number}</a> has been noted <br /><br /><div style=\"color:rgb(127, 127, 127)\"> Your %{company.name} Team,<br /> %{signature} </div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small;text-align:center\"> <em>You can view the support request progress <a href=\"%%7Brecipient.ticket_link%7D\">online here</a></em> </div> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(4,1,'ticket.notice','%{ticket.subject} [#%{ticket.number}]',' <h3><strong>Dear %{recipient.name.first},</strong></h3> Our customer care team has created a ticket, <a href=\"%%7Brecipient.ticket_link%7D\">#%{ticket.number}</a> on your behalf, with the following details and summary: <br /><br /> Topic: <strong>%{ticket.topic.name}</strong> <br /> Subject: <strong>%{ticket.subject}</strong> <br /><br /> %{message} <br /><br /> If need be, a representative will follow-up with you as soon as possible. You can also <a href=\"%%7Brecipient.ticket_link%7D\">view this ticket\'s progress online</a>. <br /><br /><div style=\"color:rgb(127, 127, 127)\"> Your %{company.name} Team,<br /> %{signature}</div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small\"><em>If you wish to provide additional comments or information regarding the issue, please reply to this email or <a href=\"%%7Brecipient.ticket_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login to your account</span></a> for a complete archive of your support requests.</em></div> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(5,1,'ticket.overlimit','Open Tickets Limit Reached',' <h3><strong>Dear %{ticket.name.first},</strong></h3> You have reached the maximum number of open tickets allowed. To be able to open another ticket, one of your pending tickets must be closed. To update or add comments to an open ticket simply <a href=\"%%7Burl%7D/tickets.php?e=%%7Bticket.email%7D\">login to our helpdesk</a>. <br /><br /> Thank you,<br /> Support Ticket System',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(6,1,'ticket.reply','Re: %{ticket.subject} [#%{ticket.number}]',' <h3><strong>Dear %{recipient.name},</strong></h3> %{response} <br /><br /><div style=\"color:rgb(127, 127, 127)\"> Your %{company.name} Team,<br /> %{signature} </div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small;text-align:center\"><em>We hope this response has sufficiently answered your questions. If not, please do not send another email. Instead, reply to this email or <a href=\"%%7Brecipient.ticket_link%7D\" style=\"color:rgb(84, 141, 212)\">login to your account</a> for a complete archive of all your support requests and responses.</em></div> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(7,1,'ticket.activity.notice','Re: %{ticket.subject} [#%{ticket.number}]',' <h3><strong>Dear %{recipient.name.first},</strong></h3> <div> <em>%{poster.name}</em> just logged a message to a ticket in which you participate. </div> <br /> %{message} <br /><br /><hr /> <div style=\"color:rgb(127, 127, 127);font-size:small;text-align:center\"> <em>You\'re getting this email because you are a collaborator on ticket <a href=\"%%7Brecipient.ticket_link%7D\" style=\"color:rgb(84, 141, 212)\">#%{ticket.number}</a>. To participate, simply reply to this email or <a href=\"%%7Brecipient.ticket_link%7D\" style=\"color:rgb(84, 141, 212)\">click here</a> for a complete archive of the ticket thread.</em> </div> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(8,1,'ticket.alert','New Ticket Alert',' <h2>Hi %{recipient.name},</h2> New ticket #%{ticket.number} created <br /><br /><table><tbody> <tr> <td> <strong>From</strong>: </td> <td> %{ticket.name} </td> </tr> <tr> <td> <strong>Department</strong>: </td> <td> %{ticket.dept.name} </td> </tr> </tbody></table> <br /> %{message} <br /><br /><hr /> <div>To view or respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\">login</a> to the support ticket system</div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /><a href=\"http://osticket.com/\"><img width=\"126\" height=\"19\" style=\"width:126px\" alt=\"Powered By osTicket\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(9,1,'message.alert','New Message Alert',' <h3><strong>Hi %{recipient.name},</strong></h3> New message appended to ticket <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> <br /><br /><table><tbody> <tr> <td> <strong>From</strong>: </td> <td> %{ticket.name} </td> </tr> <tr> <td> <strong>Department</strong>: </td> <td> %{ticket.dept.name} </td> </tr> </tbody></table> <br /> %{message} <br /><br /><hr /> <div>To view or respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support ticket system</div> <em style=\"color:rgb(127,127,127);font-size:small\">Your friendly Customer Support System</em><br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" /> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(10,1,'note.alert','New Internal Activity Alert',' <h3><strong>Hi %{recipient.name},</strong></h3> An agent has logged activity on ticket <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> <br /><br /><table><tbody> <tr> <td> <strong>From</strong>: </td> <td> %{note.poster} </td> </tr> <tr> <td> <strong>Title</strong>: </td> <td> %{note.title} </td> </tr> </tbody></table> <br /> %{note.message} <br /><br /><hr /> To view/respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\">login</a> to the support ticket system <br /><br /><em style=\"font-size:small\">Your friendly Customer Support System</em> <br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" /> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(11,1,'assigned.alert','Ticket Assigned to you',' <h3><strong>Hi %{assignee.name.first},</strong></h3> Ticket <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> has been assigned to you by %{assigner.name.short} <br /><br /><table><tbody> <tr> <td> <strong>From</strong>: </td> <td> %{ticket.name} </td> </tr> <tr> <td> <strong>Subject</strong>: </td> <td> %{ticket.subject} </td> </tr> </tbody></table> <br /> %{comments} <br /><br /><hr /> <div>To view/respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support ticket system</div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" /> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(12,1,'transfer.alert','Ticket #%{ticket.number} transfer - %{ticket.dept.name}',' <h3>Hi %{recipient.name},</h3> Ticket <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> has been transferred to the %{ticket.dept.name} department by <strong>%{staff.name.short}</strong> <br /><br /><blockquote> %{comments} </blockquote> <hr /> <div>To view or respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\">login</a> to the support ticket system. </div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /><a href=\"http://osticket.com/\"><img width=\"126\" height=\"19\" alt=\"Powered By osTicket\" style=\"width:126px\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(13,1,'ticket.overdue','Stale Ticket Alert',' <h3> <strong>Hi %{recipient.name}</strong>,</h3> A ticket, <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> is seriously overdue. <br /><br /> We should all work hard to guarantee that all tickets are being addressed in a timely manner. <br /><br /> Signed,<br /> %{ticket.dept.manager.name} <hr /> <div>To view or respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support ticket system. You\'re receiving this notice because the ticket is assigned directly to you or to a team or department of which you\'re a member.</div> <em style=\"font-size:small\">Your friendly <span style=\"font-size:smaller\">(although with limited patience)</span> Customer Support System</em><br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" height=\"19\" alt=\"Powered by osTicket\" width=\"126\" style=\"width:126px\" /> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(14,1,'task.alert','New Task Alert',' <h2>Hi %{recipient.name},</h2> New task <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> created <br /><br /><table><tbody><tr> <td> <strong>Department</strong>: </td> <td> %{task.dept.name} </td> </tr></tbody></table> <br /> %{task.description} <br /><br /><hr /> <div>To view or respond to the ticket, please <a href=\"%%7Btask.staff_link%7D\">login</a> to the support system</div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /><a href=\"http://osticket.com/\"><img width=\"126\" height=\"19\" style=\"width:126px\" alt=\"Powered By osTicket\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(15,1,'task.activity.notice','Re: %{task.title} [#%{task.number}]',' <h3><strong>Dear %{recipient.name.first},</strong></h3> <div> <em>%{poster.name}</em> just logged a message to a task in which you participate. </div> <br /> %{message} <br /><br /><hr /> <div style=\"color:rgb(127, 127, 127);font-size:small;text-align:center\"> <em>You\'re getting this email because you are a collaborator on task #%{task.number}. To participate, simply reply to this email.</em> </div> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(16,1,'task.activity.alert','Task Activity [#%{task.number}] - %{activity.title}',' <h3><strong>Hi %{recipient.name},</strong></h3> Task <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> updated: %{activity.description} <br /><br /> %{message} <br /><br /><hr /> <div>To view or respond to the task, please <a href=\"%%7Btask.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support system</div> <em style=\"color:rgb(127,127,127);font-size:small\">Your friendly Customer Support System</em><br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" /> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(17,1,'task.assignment.alert','Task Assigned to you',' <h3><strong>Hi %{assignee.name.first},</strong></h3> Task <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> has been assigned to you by %{assigner.name.short} <br /><br /> %{comments} <br /><br /><hr /> <div>To view/respond to the task, please <a href=\"%%7Btask.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support system</div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" /> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(18,1,'task.transfer.alert','Task #%{task.number} transfer - %{task.dept.name}',' <h3>Hi %{recipient.name},</h3> Task <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> has been transferred to the %{task.dept.name} department by <strong>%{staff.name.short}</strong> <br /><br /><blockquote> %{comments} </blockquote> <hr /> <div>To view or respond to the task, please <a href=\"%%7Btask.staff_link%7D\">login</a> to the support system. </div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /><a href=\"http://osticket.com/\"><img width=\"126\" height=\"19\" alt=\"Powered By osTicket\" style=\"width:126px\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(19,1,'task.overdue.alert','Stale Task Alert',' <h3> <strong>Hi %{recipient.name}</strong>,</h3> A task, <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> is seriously overdue. <br /><br /> We should all work hard to guarantee that all tasks are being addressed in a timely manner. <br /><br /> Signed,<br /> %{task.dept.manager.name} <hr /> <div>To view or respond to the task, please <a href=\"%%7Btask.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support system. You\'re receiving this notice because the task is assigned directly to you or to a team or department of which you\'re a member.</div> <em style=\"font-size:small\">Your friendly <span style=\"font-size:smaller\">(although with limited patience)</span> Customer Support System</em><br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" height=\"19\" alt=\"Powered by osTicket\" width=\"126\" style=\"width:126px\" /> ',NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(20,1,'ticket.closed','Closed Ticket Alert',' <h3> <strong>Hi %{recipient.name}</strong>,</h3> A ticket, <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> has been closed. <br /><br /> Signed,<br /> %{ticket.dept.manager.name} <hr /> <div>To view or respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support ticket system. You\'re receiving this notice because the ticket is assigned directly to you or to a team or department of which you\'re a member.</div> <em style=\"font-size:small\">Your friendly <span style=\"font-size:smaller\">(although with limited patience)</span> Customer Support System</em><br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" height=\"19\" alt=\"Powered by osTicket\" width=\"126\" style=\"width:126px\" />                                                                                                     ',NULL,'2017-08-03 10:40:50','2017-08-03 10:40:50'),(21,2,'ticket.autoresp','Support Ticket Opened [#%{ticket.number}]',' <h3><strong>Dear %{recipient.name.first},</strong></h3> <p> A request for support has been created and assigned #%{ticket.number}. A representative will follow-up with you as soon as possible. You can <a href=\"%%7Brecipient.ticket_link%7D\">view this ticket\'s progress online</a>. </p> <br /><div style=\"color:rgb(127, 127, 127)\"> Your %{company.name} Team, <br /> %{signature} </div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small\"><em>If you wish to provide additional comments or information regarding the issue, please reply to this email or <a href=\"%%7Brecipient.ticket_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login to your account</span></a> for a complete archive of your support requests.</em></div> ',NULL,'2017-09-27 09:11:24','2017-09-27 09:11:24'),(22,2,'ticket.autoreply','Re: %{ticket.subject} [#%{ticket.number}]',' <h3><strong>Dear %{recipient.name.first},</strong></h3> A request for support has been created and assigned ticket <a href=\"%%7Brecipient.ticket_link%7D\">#%{ticket.number}</a> with the following automatic reply <br /><br /> Topic: <strong>%{ticket.topic.name}</strong> <br /> Subject: <strong>%{ticket.subject}</strong> <br /><br /> %{response} <br /><br /><div style=\"color:rgb(127, 127, 127)\">Your %{company.name} Team,<br /> %{signature}</div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small\"><em>We hope this response has sufficiently answered your questions. If you wish to provide additional comments or informatione, please reply to this email or <a href=\"%%7Brecipient.ticket_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login to your account</span></a> for a complete archive of your support requests.</em></div> ',NULL,'2017-09-27 09:11:24','2017-09-27 09:11:24'),(23,2,'message.autoresp','Message Confirmation',' <h3><strong>Dear %{recipient.name.first},</strong></h3> Your reply to support request <a href=\"%%7Brecipient.ticket_link%7D\">#%{ticket.number}</a> has been noted <br /><br /><div style=\"color:rgb(127, 127, 127)\"> Your %{company.name} Team,<br /> %{signature} </div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small;text-align:center\"> <em>You can view the support request progress <a href=\"%%7Brecipient.ticket_link%7D\">online here</a></em> </div> ',NULL,'2017-09-27 09:11:24','2017-09-27 09:11:24'),(24,2,'ticket.notice','%{ticket.subject} [#%{ticket.number}]',' <h3><strong>Dear %{recipient.name.first},</strong></h3> Our customer care team has created a ticket, <a href=\"%%7Brecipient.ticket_link%7D\">#%{ticket.number}</a> on your behalf, with the following details and summary: <br /><br /> Topic: <strong>%{ticket.topic.name}</strong> <br /> Subject: <strong>%{ticket.subject}</strong> <br /><br /> %{message} <br /><br /> If need be, a representative will follow-up with you as soon as possible. You can also <a href=\"%%7Brecipient.ticket_link%7D\">view this ticket\'s progress online</a>. <br /><br /><div style=\"color:rgb(127, 127, 127)\"> Your %{company.name} Team,<br /> %{signature}</div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small\"><em>If you wish to provide additional comments or information regarding the issue, please reply to this email or <a href=\"%%7Brecipient.ticket_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login to your account</span></a> for a complete archive of your support requests.</em></div> ',NULL,'2017-09-27 09:11:24','2017-09-27 09:11:24'),(25,2,'ticket.overlimit','Open Tickets Limit Reached',' <h3><strong>Dear %{ticket.name.first},</strong></h3> You have reached the maximum number of open tickets allowed. To be able to open another ticket, one of your pending tickets must be closed. To update or add comments to an open ticket simply <a href=\"%%7Burl%7D/tickets.php?e=%%7Bticket.email%7D\">login to our helpdesk</a>. <br /><br /> Thank you,<br /> Support Ticket System',NULL,'2017-09-27 09:11:24','2017-09-27 09:11:24'),(26,2,'ticket.reply','Re: %{ticket.subject} [#%{ticket.number}]',' <h3><strong>Dear %{recipient.name},</strong></h3> %{response} <br /><br /><div style=\"color:rgb(127, 127, 127)\"> Your %{company.name} Team,<br /> %{signature} </div> <hr /> <div style=\"color:rgb(127, 127, 127);font-size:small;text-align:center\"><em>We hope this response has sufficiently answered your questions. If not, please do not send another email. Instead, reply to this email or <a href=\"%%7Brecipient.ticket_link%7D\" style=\"color:rgb(84, 141, 212)\">login to your account</a> for a complete archive of all your support requests and responses.</em></div> ',NULL,'2017-09-27 09:11:24','2017-09-27 09:11:24'),(27,2,'ticket.activity.notice','Re: %{ticket.subject} [#%{ticket.number}]',' <h3><strong>Dear %{recipient.name.first},</strong></h3> <div> <em>%{poster.name}</em> just logged a message to a ticket in which you participate. </div> <br /> %{message} <br /><br /><hr /> <div style=\"color:rgb(127, 127, 127);font-size:small;text-align:center\"> <em>You\'re getting this email because you are a collaborator on ticket <a href=\"%%7Brecipient.ticket_link%7D\" style=\"color:rgb(84, 141, 212)\">#%{ticket.number}</a>. To participate, simply reply to this email or <a href=\"%%7Brecipient.ticket_link%7D\" style=\"color:rgb(84, 141, 212)\">click here</a> for a complete archive of the ticket thread.</em> </div> ',NULL,'2017-09-27 09:11:24','2017-09-27 09:11:24'),(28,2,'ticket.alert','New Ticket Alert',' <h2>Hi %{recipient.name},</h2> New ticket #%{ticket.number} created <br /><br /><table><tbody> <tr> <td> <strong>From</strong>: </td> <td> %{ticket.name} </td> </tr> <tr> <td> <strong>Department</strong>: </td> <td> %{ticket.dept.name} </td> </tr> </tbody></table> <br /> %{message} <br /><br /><hr /> <div>To view or respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\">login</a> to the support ticket system</div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /><a href=\"http://osticket.com/\"><img width=\"126\" height=\"19\" style=\"width:126px\" alt=\"Powered By osTicket\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a> ',NULL,'2017-09-27 09:11:24','2017-09-27 09:11:24'),(29,2,'message.alert','New Message Alert',' <h3><strong>Hi %{recipient.name},</strong></h3> New message appended to ticket <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> <br /><br /><table><tbody> <tr> <td> <strong>From</strong>: </td> <td> %{ticket.name} </td> </tr> <tr> <td> <strong>Department</strong>: </td> <td> %{ticket.dept.name} </td> </tr> </tbody></table> <br /> %{message} <br /><br /><hr /> <div>To view or respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support ticket system</div> <em style=\"color:rgb(127,127,127);font-size:small\">Your friendly Customer Support System</em><br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" /> ',NULL,'2017-09-27 09:11:24','2017-09-27 09:11:24'),(30,2,'note.alert','New Internal Activity Alert',' <h3><strong>Hi %{recipient.name},</strong></h3> An agent has logged activity on ticket <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> <br /><br /><table><tbody> <tr> <td> <strong>From</strong>: </td> <td> %{note.poster} </td> </tr> <tr> <td> <strong>Title</strong>: </td> <td> %{note.title} </td> </tr> </tbody></table> <br /> %{note.message} <br /><br /><hr /> To view/respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\">login</a> to the support ticket system <br /><br /><em style=\"font-size:small\">Your friendly Customer Support System</em> <br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" /> ',NULL,'2017-09-27 09:11:24','2017-09-27 09:11:24'),(31,2,'assigned.alert','Ticket Assigned to you',' <h3><strong>Hi %{assignee.name.first},</strong></h3> Ticket <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> has been assigned to you by %{assigner.name.short} <br /><br /><table><tbody> <tr> <td> <strong>From</strong>: </td> <td> %{ticket.name} </td> </tr> <tr> <td> <strong>Subject</strong>: </td> <td> %{ticket.subject} </td> </tr> </tbody></table> <br /> %{comments} <br /><br /><hr /> <div>To view/respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support ticket system</div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" /> ',NULL,'2017-09-27 09:11:24','2017-09-27 09:11:24'),(32,2,'transfer.alert','Ticket #%{ticket.number} transfer - %{ticket.dept.name}',' <h3>Hi %{recipient.name},</h3> Ticket <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> has been transferred to the %{ticket.dept.name} department by <strong>%{staff.name.short}</strong> <br /><br /><blockquote> %{comments} </blockquote> <hr /> <div>To view or respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\">login</a> to the support ticket system. </div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /><a href=\"http://osticket.com/\"><img width=\"126\" height=\"19\" alt=\"Powered By osTicket\" style=\"width:126px\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a> ',NULL,'2017-09-27 09:11:24','2017-09-27 09:11:24'),(33,2,'ticket.overdue','Stale Ticket Alert',' <h3> <strong>Hi %{recipient.name}</strong>,</h3> A ticket, <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> is seriously overdue. <br /><br /> We should all work hard to guarantee that all tickets are being addressed in a timely manner. <br /><br /> Signed,<br /> %{ticket.dept.manager.name} <hr /> <div>To view or respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support ticket system. You\'re receiving this notice because the ticket is assigned directly to you or to a team or department of which you\'re a member.</div> <em style=\"font-size:small\">Your friendly <span style=\"font-size:smaller\">(although with limited patience)</span> Customer Support System</em><br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" height=\"19\" alt=\"Powered by osTicket\" width=\"126\" style=\"width:126px\" /> ',NULL,'2017-09-27 09:11:24','2017-09-27 09:11:24'),(34,2,'task.alert','New Task Alert',' <h2>Hi %{recipient.name},</h2> New task <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> created <br /><br /><table><tbody><tr> <td> <strong>Department</strong>: </td> <td> %{task.dept.name} </td> </tr></tbody></table> <br /> %{task.description} <br /><br /><hr /> <div>To view or respond to the ticket, please <a href=\"%%7Btask.staff_link%7D\">login</a> to the support system</div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /><a href=\"http://osticket.com/\"><img width=\"126\" height=\"19\" style=\"width:126px\" alt=\"Powered By osTicket\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a> ',NULL,'2017-09-27 09:11:24','2017-09-27 09:11:24'),(35,2,'task.activity.notice','Re: %{task.title} [#%{task.number}]',' <h3><strong>Dear %{recipient.name.first},</strong></h3> <div> <em>%{poster.name}</em> just logged a message to a task in which you participate. </div> <br /> %{message} <br /><br /><hr /> <div style=\"color:rgb(127, 127, 127);font-size:small;text-align:center\"> <em>You\'re getting this email because you are a collaborator on task #%{task.number}. To participate, simply reply to this email.</em> </div> ',NULL,'2017-09-27 09:11:24','2017-09-27 09:11:24'),(36,2,'task.activity.alert','Task Activity [#%{task.number}] - %{activity.title}',' <h3><strong>Hi %{recipient.name},</strong></h3> Task <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> updated: %{activity.description} <br /><br /> %{message} <br /><br /><hr /> <div>To view or respond to the task, please <a href=\"%%7Btask.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support system</div> <em style=\"color:rgb(127,127,127);font-size:small\">Your friendly Customer Support System</em><br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" /> ',NULL,'2017-09-27 09:11:24','2017-09-27 09:11:24'),(37,2,'task.assignment.alert','Task Assigned to you',' <h3><strong>Hi %{assignee.name.first},</strong></h3> Task <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> has been assigned to you by %{assigner.name.short} <br /><br /> %{comments} <br /><br /><hr /> <div>To view/respond to the task, please <a href=\"%%7Btask.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support system</div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" width=\"126\" height=\"19\" style=\"width:126px\" /> ',NULL,'2017-09-27 09:11:24','2017-09-27 09:11:24'),(38,2,'task.transfer.alert','Task #%{task.number} transfer - %{task.dept.name}',' <h3>Hi %{recipient.name},</h3> Task <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> has been transferred to the %{task.dept.name} department by <strong>%{staff.name.short}</strong> <br /><br /><blockquote> %{comments} </blockquote> <hr /> <div>To view or respond to the task, please <a href=\"%%7Btask.staff_link%7D\">login</a> to the support system. </div> <em style=\"font-size:small\">Your friendly Customer Support System</em> <br /><a href=\"http://osticket.com/\"><img width=\"126\" height=\"19\" alt=\"Powered By osTicket\" style=\"width:126px\" src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" /></a> ',NULL,'2017-09-27 09:11:24','2017-09-27 09:11:24'),(39,2,'task.overdue.alert','Stale Task Alert',' <h3> <strong>Hi %{recipient.name}</strong>,</h3> A task, <a href=\"%%7Btask.staff_link%7D\">#%{task.number}</a> is seriously overdue. <br /><br /> We should all work hard to guarantee that all tasks are being addressed in a timely manner. <br /><br /> Signed,<br /> %{task.dept.manager.name} <hr /> <div>To view or respond to the task, please <a href=\"%%7Btask.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support system. You\'re receiving this notice because the task is assigned directly to you or to a team or department of which you\'re a member.</div> <em style=\"font-size:small\">Your friendly <span style=\"font-size:smaller\">(although with limited patience)</span> Customer Support System</em><br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" height=\"19\" alt=\"Powered by osTicket\" width=\"126\" style=\"width:126px\" /> ',NULL,'2017-09-27 09:11:24','2017-09-27 09:11:24'),(40,2,'ticket.closed','Closed Ticket Alert',' <h3> <strong>Hi %{recipient.name}</strong>,</h3> A ticket, <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> has been closed. <br /><br /> Signed,<br /> %{ticket.dept.manager.name} <hr /> <div>To view or respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support ticket system. You\'re receiving this notice because the ticket is assigned directly to you or to a team or department of which you\'re a member.</div> <em style=\"font-size:small\">Your friendly <span style=\"font-size:smaller\">(although with limited patience)</span> Customer Support System</em><br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" height=\"19\" alt=\"Powered by osTicket\" width=\"126\" style=\"width:126px\" />                                                                                                     ',NULL,'2017-09-27 09:11:24','2017-09-27 09:11:24'),(41,2,'ticket.solved','Solved Ticket Alert',' <h3> <strong>Hi %{recipient.name}</strong>,</h3> A ticket, <a href=\"%%7Bticket.staff_link%7D\">#%{ticket.number}</a> has been solved. <br /><br /> Signed,<br /> %{ticket.dept.manager.name} <hr /> To view or respond to the ticket, please <a href=\"%%7Bticket.staff_link%7D\"><span style=\"color:rgb(84, 141, 212)\">login</span></a> to the support ticket system. You\'re receiving this notice because the ticket is assigned directly to you or to a team or department of which you\'re a member.<br /><em style=\"font-size:small\">Your friendly <span style=\"font-size:smaller\">(although with limited patience)</span> Customer Support System</em><br /><img src=\"cid:b56944cb4722cc5cda9d1e23a3ea7fbc\" alt=\"Powered by osTicket\" style=\"width:126px\" height=\"19\" width=\"126\" /> ',NULL,'2017-10-31 09:48:58','2017-10-31 11:09:04');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_email_template_group`
--

LOCK TABLES `ost_email_template_group` WRITE;
/*!40000 ALTER TABLE `ost_email_template_group` DISABLE KEYS */;
INSERT INTO `ost_email_template_group` VALUES (1,1,'osTicket Default Template (HTML)','en_US','Default osTicket templates','2017-08-01 12:23:25','2017-08-01 10:23:25'),(2,1,'Soporte LARUEX','es_ES','Grupo de plantillas clonado desde las que vienen por defecto y personalizadas para el soporte tanto del laboratorio como la red.','2017-09-27 09:11:24','2017-09-27 07:11:24');
/*!40000 ALTER TABLE `ost_email_template_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_equipment`
--

DROP TABLE IF EXISTS `ost_equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_equipment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `description` text,
  `status_id` int(11) unsigned DEFAULT NULL,
  `bookable` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dept_id` int(11) unsigned NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `activation` datetime DEFAULT NULL,
  `deactivation` datetime DEFAULT NULL,
  `retirement` datetime DEFAULT NULL,
  `lock_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status_id` (`status_id`),
  CONSTRAINT `ost_equipment_ibfk_1` FOREIGN KEY (`status_id`) REFERENCES `ost_equipment_status` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_equipment`
--

LOCK TABLES `ost_equipment` WRITE;
/*!40000 ALTER TABLE `ost_equipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_equipment_booking`
--

DROP TABLE IF EXISTS `ost_equipment_booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_equipment_booking` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `equipment_id` int(11) unsigned NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `staff_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `equipment_id` (`equipment_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `ost_equipment_booking_ibfk_1` FOREIGN KEY (`equipment_id`) REFERENCES `ost_equipment` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `ost_equipment_booking_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `ost_staff` (`staff_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_equipment_booking`
--

LOCK TABLES `ost_equipment_booking` WRITE;
/*!40000 ALTER TABLE `ost_equipment_booking` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_equipment_booking` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER ComprobacionSolapamientoReservas1 BEFORE INSERT ON ost_equipment_booking FOR EACH ROW
BEGIN
	SET @num = (SELECT count(id) FROM ost_equipment_booking 
				WHERE equipment_id = new.equipment_id 
                AND ((start <= new.start AND end > new.start) OR (start < new.end AND end >= new.end)
                OR (start > new.start AND end < new.end)));
	IF (@num > 0) THEN
		SIGNAL SQLSTATE '45001' SET message_text = 'Error por solapamiento de reservas';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER ComprobacionInicioFinReservas1 BEFORE INSERT ON ost_equipment_booking FOR EACH ROW
BEGIN
	IF (new.start >= new.end) THEN
		SIGNAL SQLSTATE '45002' SET message_text = 'Error de fechas de reserva';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER ComprobacionInicioFinReservas2 BEFORE UPDATE ON ost_equipment_booking FOR EACH ROW
BEGIN
	IF (new.start >= new.end) THEN
		SIGNAL SQLSTATE '45002' SET message_text = 'Error de fechas de reserva';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER ComprobacionSolapamientoReservas2 BEFORE UPDATE ON ost_equipment_booking FOR EACH ROW
BEGIN
SET @num = (SELECT count(id) FROM ost_equipment_booking 
WHERE equipment_id = new.equipment_id AND id != new.id
AND ((start <= new.start AND end > new.start) OR (start < new.end AND end >= new.end)
OR (start > new.start AND end < new.end)));
IF (@num > 0) THEN
SIGNAL SQLSTATE '45001' SET message_text = 'Error por solapamiento de reservas';
 END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ost_equipment_booking_hist`
--

DROP TABLE IF EXISTS `ost_equipment_booking_hist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_equipment_booking_hist` (
  `equipment_id` int(11) unsigned NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `staff_id` int(11) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_equipment_booking_hist`
--

LOCK TABLES `ost_equipment_booking_hist` WRITE;
/*!40000 ALTER TABLE `ost_equipment_booking_hist` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_equipment_booking_hist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_equipment_status`
--

DROP TABLE IF EXISTS `ost_equipment_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_equipment_status` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `state` varchar(16) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_equipment_status`
--

LOCK TABLES `ost_equipment_status` WRITE;
/*!40000 ALTER TABLE `ost_equipment_status` DISABLE KEYS */;
INSERT INTO `ost_equipment_status` VALUES (1,'Nuevo','new','2017-08-04 11:54:57','2017-08-04 11:54:57'),(2,'Operativo','active','2017-08-04 11:55:33','2017-08-04 11:55:33'),(3,'Inoperativo','inactive','2017-08-04 11:56:05','2017-08-04 11:56:05'),(4,'Retirado','retired','2017-08-04 11:56:59','2017-08-04 11:56:59'),(5,'Eliminado','deleted','2017-10-02 14:47:27','2017-10-02 14:47:27');
/*!40000 ALTER TABLE `ost_equipment_status` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_file`
--

LOCK TABLES `ost_file` WRITE;
/*!40000 ALTER TABLE `ost_file` DISABLE KEYS */;
INSERT INTO `ost_file` VALUES (1,'T','D','text/plain',204,'uFck05BcDW-lG9m1iqTRxqVlFHNZawH4','5BcDW-lG9m1iqTRxa6WtQPQV_rw6ffmn','new 1.txt',NULL,'2017-11-10 09:38:34');
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
INSERT INTO `ost_file_chunk` VALUES (1,0,'Antonio				-> tritium@juntaex.es\r\nMª Ángeles			-> eco2cir@gmail.com\r\nJuan				-> ratvapc@gmail.com\r\nPepe				-> eco2cir@juntaex.es		gravatar\r\nDavid				-> \r\nJose				-> rat_va_pc@juntaex.es\r\nManolo				-> \r\n');
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_form`
--

LOCK TABLES `ost_form` WRITE;
/*!40000 ALTER TABLE `ost_form` DISABLE KEYS */;
INSERT INTO `ost_form` VALUES (1,NULL,'U',1,'Contact Information',NULL,'',NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(2,NULL,'T',1,'Detalles del ticket','','','This form will be attached to every ticket, regardless of its source.\r\nYou can add any fields to this form and they will be available to all\r\ntickets, and will be searchable with advanced search and filterable.','2017-08-01 12:23:24','2017-10-23 14:29:10'),(3,NULL,'C',1,'Company Information','Details available in email templates','',NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(4,NULL,'O',1,'Organization Information','Details on user organization','',NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(5,NULL,'A',1,'Detalles de la tarea','Por favor, describa la tarea.','','This form is used to create a task.','2017-08-01 12:23:24','2017-11-02 11:58:45'),(6,NULL,'L1',1,'Ticket Status Properties','Properties that can be set on a ticket status.','',NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(7,NULL,'L2',1,'Área Properties',NULL,'',NULL,'2017-08-01 14:59:58','2017-08-01 14:59:58'),(8,NULL,'L3',1,'Categoría Properties',NULL,'',NULL,'2017-08-01 15:01:25','2017-08-01 15:01:25'),(9,NULL,'L4',1,'Tipo de localización Properties',NULL,'',NULL,'2017-08-01 15:02:32','2017-08-01 15:02:32'),(10,NULL,'L5',1,'Localización Properties',NULL,'',NULL,'2017-08-01 15:04:03','2017-08-01 15:04:03'),(11,NULL,'G',1,'Notificación y cierre de desviaciones',NULL,'',NULL,'2017-08-02 08:03:27','2017-08-02 08:03:27'),(12,NULL,'E',1,'Detalles de equipamiento','Please Describe The Equipment','','This form is use to add equipment','2017-08-10 11:52:35','2017-09-29 12:35:07'),(13,NULL,'R',1,'Reservation Information',NULL,'',NULL,'2017-08-25 13:53:58','2017-08-25 13:53:58'),(14,NULL,'S',1,'Información de programación de tarea',NULL,'',NULL,'2017-09-19 09:38:01','2017-11-02 12:29:23');
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
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_form_entry`
--

LOCK TABLES `ost_form_entry` WRITE;
/*!40000 ALTER TABLE `ost_form_entry` DISABLE KEYS */;
INSERT INTO `ost_form_entry` VALUES (2,3,NULL,'C',1,NULL,'2017-08-01 12:23:25','2017-08-01 12:23:25'),(5,1,2,'U',1,NULL,'2017-08-02 08:29:32','2017-08-02 08:29:32'),(6,1,3,'U',1,NULL,'2017-08-02 08:31:41','2017-08-02 08:31:41'),(7,1,4,'U',1,NULL,'2017-08-02 08:32:46','2017-08-02 08:32:46'),(8,1,5,'U',1,NULL,'2017-08-02 08:33:23','2017-08-02 08:33:23'),(9,1,6,'U',1,NULL,'2017-08-02 08:34:31','2017-08-02 08:34:31'),(10,1,7,'U',1,NULL,'2017-08-02 08:36:14','2017-08-02 08:36:14'),(11,1,8,'U',1,NULL,'2017-08-02 08:37:09','2017-08-02 08:37:09'),(95,12,1,'E',1,NULL,'2017-11-09 13:18:35','2017-11-09 13:18:35'),(96,12,2,'E',1,NULL,'2017-11-09 13:36:21','2017-11-09 13:36:21');
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
INSERT INTO `ost_form_entry_values` VALUES (2,23,'LARUEX',NULL),(2,24,NULL,NULL),(2,25,NULL,NULL),(2,26,NULL,NULL),(5,3,NULL,NULL),(5,4,NULL,NULL),(6,3,NULL,NULL),(6,4,NULL,NULL),(7,3,NULL,NULL),(7,4,NULL,NULL),(8,3,NULL,NULL),(8,4,NULL,NULL),(9,3,NULL,NULL),(9,4,NULL,NULL),(10,3,NULL,NULL),(10,4,NULL,NULL),(11,3,NULL,NULL),(11,4,NULL,NULL),(95,46,'Ordenador',NULL),(95,48,NULL,NULL),(95,49,'0',NULL),(95,52,'Red Alerta Radiológica',4),(96,46,'Vehículo',NULL),(96,48,NULL,NULL),(96,49,'1',NULL),(96,52,'Red Alerta Radiológica',4);
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
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_form_field`
--

LOCK TABLES `ost_form_field` WRITE;
/*!40000 ALTER TABLE `ost_form_field` DISABLE KEYS */;
INSERT INTO `ost_form_field` VALUES (1,1,489379,'text','Email Address','email','{\"size\":40,\"length\":64,\"validator\":\"email\"}',1,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(2,1,489379,'text','Full Name','name','{\"size\":40,\"length\":64}',2,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(3,1,13057,'phone','Phone Number','phone',NULL,3,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(4,1,12289,'memo','Internal Notes','notes','{\"rows\":4,\"cols\":40}',4,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(20,2,489249,'text','Asunto','subject','{\"size\":\"40\",\"length\":\"50\",\"validator\":\"\",\"regex\":\"\",\"validator-error\":\"\",\"placeholder\":\"\"}',1,NULL,'2017-08-01 12:23:24','2017-10-23 14:32:04'),(21,2,489251,'thread','Descripción','message','{\"attachments\":true,\"size\":2097152,\"mimetypes\":null,\"extensions\":\"\",\"max\":\"\"}',2,'Details on the reason(s) for opening the ticket.','2017-08-01 12:23:24','2017-10-23 14:29:10'),(22,2,275377,'priority','Nivel de prioridad','priority','{\"prompt\":\"\",\"default\":\"\"}',3,NULL,'2017-08-01 12:23:24','2017-10-23 14:31:53'),(23,3,291233,'text','Company Name','name','{\"size\":40,\"length\":64}',1,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(24,3,12545,'text','Website','website','{\"size\":40,\"length\":64}',2,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(25,3,12545,'phone','Phone Number','phone','{\"ext\":false}',3,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(26,3,12545,'memo','Address','address','{\"rows\":2,\"cols\":40,\"html\":false,\"length\":100}',4,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(27,4,489379,'text','Name','name','{\"size\":40,\"length\":64}',1,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(28,4,13057,'memo','Address','address','{\"rows\":2,\"cols\":40,\"length\":100,\"html\":false}',2,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(29,4,13057,'phone','Phone','phone',NULL,3,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(30,4,13057,'text','Website','website','{\"size\":40,\"length\":0}',4,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(31,4,12289,'memo','Internal Notes','notes','{\"rows\":4,\"cols\":40}',5,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(32,5,290977,'text','Título','title','{\"size\":40,\"length\":50}',1,NULL,'2017-08-01 12:23:24','2017-11-02 12:53:05'),(33,5,282867,'thread','Descripción','description','{\"attachments\":true,\"size\":2097152,\"mimetypes\":null,\"extensions\":\"\",\"max\":\"\"}',2,'Details on the reason(s) for creating the task.','2017-08-01 12:23:24','2017-11-02 12:53:05'),(34,6,487665,'state','State','state','{\"prompt\":\"State of a ticket\"}',1,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(35,6,471073,'memo','Description','description','{\"rows\":2,\"cols\":40,\"html\":false,\"length\":100}',3,NULL,'2017-08-01 12:23:24','2017-08-01 12:23:24'),(36,10,29697,'list-4','Tipo','tipo','{\"multiselect\":false,\"widget\":\"dropdown\",\"validator-error\":\"\",\"prompt\":\"\",\"default\":null}',1,NULL,'2017-08-01 15:04:03','2017-08-01 15:04:30'),(37,10,29697,'list-2','Área','variable','{\"multiselect\":false,\"widget\":\"dropdown\",\"validator-error\":\"\",\"prompt\":\"\",\"default\":null}',2,NULL,'2017-08-01 15:04:03','2017-08-01 15:04:42'),(38,11,30465,'list-3','Categoría','categoria',NULL,1,NULL,'2017-08-02 08:03:27','2017-08-02 08:03:27'),(39,11,30465,'list-5','Localización','localizacion',NULL,2,NULL,'2017-08-02 08:03:27','2017-08-02 08:03:27'),(41,11,5377,'assignee','Preasignación','preasignacion','{\"prompt\":\"\"}',3,NULL,'2017-08-02 08:03:27','2017-11-02 12:09:23'),(43,11,13069,'memo','Análisis de causas','causas','{\"cols\":\"40\",\"rows\":\"4\",\"length\":\"\",\"html\":true,\"placeholder\":\"\"}',5,NULL,'2017-08-02 08:05:15','2017-11-06 13:57:03'),(44,11,13069,'memo','Análisis de consecuencias','consecuencias','{\"cols\":\"40\",\"rows\":\"4\",\"length\":\"\",\"html\":true,\"placeholder\":\"\"}',6,NULL,'2017-08-02 08:05:15','2017-11-08 12:08:35'),(45,11,13057,'files','Ficheros adjuntos','adjuntos','{\"size\":2097152,\"mimetypes\":null,\"extensions\":\"\",\"max\":\"\"}',7,NULL,'2017-08-02 08:06:09','2017-10-23 14:36:56'),(46,12,290977,'text','Título','name','{\"size\":40,\"length\":50}',1,NULL,'2017-08-10 11:58:41','2017-09-28 13:53:57'),(48,12,12289,'memo','Descripción','description','{\"size\":\"16\",\"length\":\"30\",\"validator\":\"\",\"regex\":\"\",\"validator-error\":\"\",\"placeholder\":\"\"}',3,NULL,'2017-08-17 09:56:23','2017-09-28 13:53:57'),(49,12,12289,'bool','Permite reservas','bookable',NULL,4,NULL,'2017-08-17 13:41:52','2017-08-17 13:41:52'),(50,14,290977,'text','Título','title','{\"size\":40,\"length\":50}',1,NULL,'2017-09-19 12:48:37','2017-11-02 12:53:19'),(51,14,282867,'thread','Descripción','description',NULL,2,'Details on the reason(s) for creating the task.','2017-09-19 12:48:37','2017-11-02 12:53:19'),(52,12,28673,'department','Departamento preasignado','dept',NULL,5,NULL,'2017-09-28 11:02:11','2017-09-29 08:46:45'),(53,11,30465,'memo','Descripción','descripcion',NULL,4,NULL,'2017-10-23 14:32:51','2017-10-23 14:33:00'),(54,5,28673,'list-5','Localización','localizacion','{\"multiselect\":false,\"widget\":\"dropdown\",\"validator-error\":\"\",\"prompt\":\"\",\"default\":null}',3,NULL,'2017-11-02 11:56:10','2017-11-02 11:56:20'),(55,14,28673,'list-5','Localización','localizacion',NULL,3,NULL,'2017-11-02 12:29:23','2017-11-02 12:29:23'),(56,11,12293,'memo','Acciones realizadas','acciones','{\"cols\":\"40\",\"rows\":\"4\",\"length\":\"\",\"html\":true,\"placeholder\":\"\"}',8,NULL,'2017-11-13 08:06:09','2017-11-13 08:08:13');
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
  `close_alert` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`topic_id`),
  UNIQUE KEY `topic` (`topic`,`topic_pid`),
  KEY `topic_pid` (`topic_pid`),
  KEY `priority_id` (`priority_id`),
  KEY `dept_id` (`dept_id`),
  KEY `staff_id` (`staff_id`,`team_id`),
  KEY `sla_id` (`sla_id`),
  KEY `page_id` (`page_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_help_topic`
--

LOCK TABLES `ost_help_topic` WRITE;
/*!40000 ALTER TABLE `ost_help_topic` DISABLE KEYS */;
INSERT INTO `ost_help_topic` VALUES (12,0,1,0,0,0,0,0,4,0,0,0,0,0,1,'Red de Alerta Radiológica',NULL,'Soporte de la Red de Alerta Radiológica','2017-08-01 14:57:53','2017-10-24 08:30:06','null'),(13,12,1,1,0,1,0,0,6,7,0,0,0,3,2,'Incidencia','INC######',NULL,'2017-08-02 08:10:34','2017-10-24 08:27:07','t1'),(14,12,1,1,0,1,0,0,6,7,0,0,0,4,3,'No conformidad','NC######',NULL,'2017-08-02 08:12:52','2017-10-24 08:27:15','t1');
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
INSERT INTO `ost_help_topic_form` VALUES (1,1,2,1,'{\"disable\":[]}'),(2,2,2,1,'{\"disable\":[]}'),(3,10,2,1,'{\"disable\":[]}'),(4,11,2,1,'{\"disable\":[]}'),(5,12,2,1,'{\"disable\":[21]}'),(6,13,2,1,'{\"disable\":[21]}'),(7,12,11,2,'{\"disable\":[38]}'),(8,14,2,1,'{\"disable\":[21]}'),(9,14,11,2,'{\"disable\":[38]}'),(10,15,2,1,'{\"disable\":[22]}'),(11,15,11,2,'{\"disable\":[38]}'),(12,16,2,1,'{\"disable\":[22]}'),(13,16,11,2,'{\"disable\":[38]}'),(14,17,2,1,'{\"disable\":[22]}'),(15,17,11,2,'{\"disable\":[38]}'),(16,18,2,1,'{\"disable\":[22]}'),(17,18,11,2,'{\"disable\":[38]}'),(18,13,11,2,'{\"disable\":[38]}');
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
INSERT INTO `ost_list` VALUES (1,'Ticket Status','Ticket Statuses','SortCol',13,'ticket-status','{\"handler\":\"TicketStatusList\"}','Ticket statuses','2017-08-01 12:23:24','2017-08-01 12:23:24'),(2,'Área','Áreas','SortCol',0,NULL,'',NULL,'2017-08-01 14:59:58','2017-08-01 14:59:58'),(3,'Categoría','Categorías','SortCol',0,NULL,'',NULL,'2017-08-01 15:01:25','2017-08-01 15:01:25'),(4,'Tipo de localización','Tipos de localización','SortCol',0,NULL,'',NULL,'2017-08-01 15:02:32','2017-08-01 15:02:32'),(5,'Localización','Localizaciones','SortCol',0,NULL,'',NULL,'2017-08-01 15:04:03','2017-08-01 15:04:03');
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
INSERT INTO `ost_list_items` VALUES (1,2,1,'Almaraz',NULL,1,'[]'),(2,2,1,'Cáceres',NULL,1,'[]'),(3,2,1,'Portugal',NULL,1,'[]'),(4,2,1,'Otra',NULL,1,'[]'),(5,3,1,'Hardware','HW',0,'[]'),(6,3,1,'Software','SW',0,'[]'),(7,4,1,'Estación',NULL,0,'[]'),(8,4,1,'Unidad móvil',NULL,0,'[]'),(9,4,1,'Otro',NULL,0,'[]'),(10,5,1,'Alerta2',NULL,0,'{\"36\":{\"7\":\"Estaci\\u00f3n\"},\"37\":{\"2\":\"C\\u00e1ceres\"}}'),(11,5,1,'Almaraz',NULL,0,'{\"36\":{\"7\":\"Estaci\\u00f3n\"},\"37\":{\"1\":\"Almaraz\"}}'),(12,5,1,'Évora',NULL,0,'{\"36\":{\"7\":\"Estaci\\u00f3n\"},\"37\":{\"3\":\"Portugal\"}}'),(13,5,1,'Portalegre',NULL,0,'{\"36\":{\"7\":\"Estaci\\u00f3n\"},\"37\":{\"3\":\"Portugal\"}}'),(14,5,1,'Saucedilla',NULL,0,'{\"36\":{\"7\":\"Estaci\\u00f3n\"},\"37\":{\"1\":\"Almaraz\"}}'),(15,5,1,'Unidad móvil',NULL,0,'{\"36\":{\"8\":\"Unidad m\\u00f3vil\"},\"37\":{\"4\":\"Otra\"}}'),(16,5,1,'Otros',NULL,0,'{\"36\":{\"9\":\"Otro\"},\"37\":{\"4\":\"Otra\"}}');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
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
INSERT INTO `ost_role` VALUES (1,1,'All Access','{\"ticket.create\":1,\"ticket.edit\":1,\"ticket.assign\":1,\"ticket.transfer\":1,\"ticket.delete\":1,\"thread.edit\":1,\"task.create\":1,\"task.edit\":1,\"task.assign\":1,\"task.transfer\":1,\"task.close\":1,\"task.delete\":1,\"canned.manage\":1,\"equipment.create\":1,\"equipment.edit\":1,\"equipment.transfer\":1,\"equipment.delete\":1,\"ticket.close\":1,\"equipment.retire\":1,\"task.reply\":1,\"task-schedule.create\":1,\"task-schedule.delete\":1,\"task-schedule.transfer\":1,\"task-schedule.assign\":1,\"ticket.reply\":1,\"ticket.verify\":1}','Role with unlimited access','2017-08-01 12:23:25','2017-11-08 13:48:56'),(2,1,'Expanded Access','{\"ticket.create\":1,\"ticket.edit\":1,\"ticket.assign\":1,\"ticket.transfer\":1,\"ticket.reply\":1,\"task.create\":1,\"task.edit\":1,\"task.assign\":1,\"task.transfer\":1,\"task.reply\":1,\"task.close\":1,\"canned.manage\":1}','Role with expanded access','2017-08-01 12:23:25','2017-10-25 09:10:50'),(3,1,'Limited Access','{\"ticket.create\":1,\"ticket.assign\":1,\"ticket.transfer\":1,\"task.assign\":1,\"task.transfer\":1,\"task.reply\":1}','Role with limited access','2017-08-01 12:23:25','2017-08-01 12:23:25'),(4,1,'View only',NULL,'Simple role with no permissions','2017-08-01 12:23:25','2017-08-01 12:23:25');
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
INSERT INTO `ost_sequence` VALUES (1,'General Tickets',1,1,1,'0','0000-00-00 00:00:00'),(2,'Tasks Sequence',1,74,1,'0','2017-11-10 09:01:04'),(3,'Secuencia incidencias',NULL,37,1,'0','2017-11-13 08:10:43'),(4,'Secuencia no conformidades',NULL,10,1,'0','2017-11-07 11:38:23');
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
INSERT INTO `ost_session` VALUES ('1cfsprs27uetn59ibkvgpd3cr4','csrf|a:2:{s:5:\"token\";s:40:\"10f70e4fffd3f0242a26bf863656d0b7c2222837\";s:4:\"time\";i:1510559376;}_auth|a:1:{s:5:\"staff\";N;}','2017-11-14 08:49:36',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('2cbts21ge25c297bt69ie43i20','csrf|a:2:{s:5:\"token\";s:40:\"5256504cfc050525b7b4d781e979d64ba0cb89d7\";s:4:\"time\";i:1510038809;}_auth|a:2:{s:5:\"staff\";N;s:4:\"user\";a:2:{s:2:\"id\";i:8;s:3:\"key\";s:8:\"client:8\";}}_client|a:1:{s:4:\"auth\";a:1:{s:4:\"dest\";s:9:\"/open.php\";}}:token|a:1:{s:6:\"client\";s:76:\"8c0d75c2ad0928bb1ea9ca21daf31a32:1510038806:efb4e12265ca7e4fc8fc726a9feb90bc\";}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}','2017-11-08 08:13:29',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('4hk6om88vbkifpfrbsg1ljf2g5','csrf|a:2:{s:5:\"token\";s:40:\"c5e54c40bea80b711456c329078684fa8687b171\";s:4:\"time\";i:1509953707;}_auth|a:1:{s:5:\"staff\";N;}','2017-11-07 08:35:07',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('55j5719lb8dj85ipg7bpkvnc45','csrf|a:2:{s:5:\"token\";s:40:\"78de2df531949c69a004cc7e83c8255864d94e72\";s:4:\"time\";i:1510221445;}_auth|a:1:{s:5:\"staff\";a:2:{s:2:\"id\";i:1;s:3:\"key\";s:12:\"local:carlos\";}}:token|a:1:{s:5:\"staff\";s:76:\"63c45069d04ddc0ca6a5645dfd72cb46:1510221445:efb4e12265ca7e4fc8fc726a9feb90bc\";}::Q:T|s:6:\"closed\";:QT:open:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}:Q:tickets|C:8:\"QuerySet\":4789:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":913:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"ticket_id__in\";C:8:\"QuerySet\":839:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":66:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"status__state\";s:6:\"closed\";}}}i:1;C:1:\"Q\":317:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":267:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{i:0;C:1:\"Q\":132:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:13:\"status__state\";s:4:\"open\";i:0;C:1:\"Q\":51:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{s:8:\"staff_id\";i:1;}}}}}}s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:1:{i:0;a:2:{i:0;s:6:\"closed\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:1:{i:0;s:9:\"ticket_id\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:3;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}}}}s:16:\"path_constraints\";a:1:{s:4:\"lock\";a:1:{i:0;C:1:\"Q\":131:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:16:\"lock__expire__gt\";O:11:\"SqlFunction\":3:{s:5:\"alias\";N;s:4:\"func\";s:3:\"NOW\";s:4:\"args\";a:0:{}}}}}}}s:8:\"ordering\";a:1:{i:0;a:2:{i:0;s:6:\"closed\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:24:{s:6:\"closed\";s:6:\"closed\";s:14:\"lock__staff_id\";s:14:\"lock__staff_id\";s:8:\"staff_id\";s:8:\"staff_id\";s:9:\"isoverdue\";s:9:\"isoverdue\";s:7:\"team_id\";s:7:\"team_id\";s:12:\"last_duedate\";s:12:\"last_duedate\";s:9:\"ticket_id\";s:9:\"ticket_id\";s:6:\"number\";s:6:\"number\";s:14:\"cdata__subject\";s:14:\"cdata__subject\";s:28:\"user__default_email__address\";s:28:\"user__default_email__address\";s:6:\"source\";s:6:\"source\";s:32:\"cdata__:priority__priority_color\";s:32:\"cdata__:priority__priority_color\";s:31:\"cdata__:priority__priority_desc\";s:31:\"cdata__:priority__priority_desc\";s:9:\"status_id\";s:9:\"status_id\";s:12:\"status__name\";s:12:\"status__name\";s:13:\"status__state\";s:13:\"status__state\";s:7:\"dept_id\";s:7:\"dept_id\";s:10:\"dept__name\";s:10:\"dept__name\";s:10:\"user__name\";s:10:\"user__name\";s:10:\"lastupdate\";s:10:\"lastupdate\";s:10:\"isanswered\";s:10:\"isanswered\";s:16:\"staff__firstname\";s:16:\"staff__firstname\";s:15:\"staff__lastname\";s:15:\"staff__lastname\";s:10:\"team__name\";s:10:\"team__name\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:3:{s:12:\"collab_count\";C:8:\"QuerySet\":672:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:17:\"collaborators__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:16:\"attachment_count\";C:8:\"QuerySet\":768:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":72:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:28:\"entries__attachments__inline\";i:0;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:24:\"entries__attachments__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:12:\"thread_count\";C:8:\"QuerySet\":749:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":66:{a:3:{i:0;i:1;i:1;i:0;i:2;a:1:{s:22:\"entries__flags__hasbit\";i:4;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:11:\"entries__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}lastcroncall|i:1510221199;:QT:closed:sort|a:2:{i:0;s:6:\"closed\";i:1;i:0;}','2017-11-10 10:57:25',NULL,'1','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('65mcj68cne03o9jbkpk8nja4t7','csrf|a:2:{s:5:\"token\";s:40:\"fb8b1821cbc72008444ba265fe621724a1515a9c\";s:4:\"time\";i:1510055103;}_auth|a:2:{s:5:\"staff\";N;s:4:\"user\";a:0:{}}:token|a:0:{}client:Q|a:3:{s:6:\"status\";s:4:\"open\";s:8:\"keywords\";s:0:\"\";s:8:\"topic_id\";s:0:\"\";}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}','2017-11-08 12:45:03',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('8cctha9j35vgrns13hv3vccaq1','csrf|a:2:{s:5:\"token\";s:40:\"6c63252479470aeec637dcb3522eb096233b0bbf\";s:4:\"time\";i:1510134837;}_auth|a:2:{s:5:\"staff\";N;s:4:\"user\";a:0:{}}:token|a:0:{}client:Q|N;cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}','2017-11-09 10:53:57',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('93pvp7lpmj6fvqcj3k0ac8kv34','csrf|a:2:{s:5:\"token\";s:40:\"d145ddd1159ea14cd00e972ea5a51249bba57a29\";s:4:\"time\";i:1509975401;}_auth|a:2:{s:5:\"staff\";N;s:4:\"user\";a:0:{}}:token|a:0:{}','2017-11-07 14:36:41',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('9j8en5g44idgjvqlpkrldv30e1','csrf|a:2:{s:5:\"token\";s:40:\"519d3b2f5a3b410bdfde749e1c97de99c03b3329\";s:4:\"time\";i:1510557997;}_auth|a:2:{s:5:\"staff\";N;s:4:\"user\";a:0:{}}_client|a:1:{s:4:\"auth\";a:1:{s:4:\"dest\";s:9:\"/open.php\";}}:token|a:0:{}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}client:Q|a:3:{s:6:\"status\";s:4:\"open\";s:8:\"keywords\";s:0:\"\";s:8:\"topic_id\";s:0:\"\";}:form-data|a:7:{s:16:\"8b255c9a64509776\";s:0:\"\";s:16:\"4b297ab1f5232fac\";a:1:{i:0;s:0:\"\";}s:16:\"e03cc78b512da1b5\";a:1:{i:0;s:0:\"\";}s:16:\"51d4ebaabfef2d13\";a:1:{i:0;s:0:\"\";}s:16:\"cf83959d1176ceca\";s:0:\"\";s:16:\"3a6228573f1b42f3\";s:0:\"\";s:16:\"0933e1794c39e576\";s:0:\"\";}:uploadedFiles|a:1:{i:2;i:1;}','2017-11-14 08:26:37',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('b4u83olbb5r2s0p40os697n617','csrf|a:2:{s:5:\"token\";s:40:\"7c9f389ce93f27c6ee256596173367a80c44482d\";s:4:\"time\";i:1510304317;}_auth|a:1:{s:5:\"staff\";a:2:{s:2:\"id\";i:1;s:3:\"key\";s:12:\"local:carlos\";}}:token|a:1:{s:5:\"staff\";s:76:\"0766a5b1164e27232e548a5e9eacdd5d:1510304312:efb4e12265ca7e4fc8fc726a9feb90bc\";}::Q:T|s:8:\"assigned\";:QT:open:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}:Q:tickets|C:8:\"QuerySet\":4933:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":1077:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"ticket_id__in\";C:8:\"QuerySet\":1002:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:3:{i:0;C:1:\"Q\":142:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{s:8:\"staff_id\";i:1;i:0;C:1:\"Q\":74:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:8:\"staff_id\";i:0;s:11:\"team_id__gt\";i:0;}}}}}}i:1;C:1:\"Q\":64:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"status__state\";s:4:\"open\";}}}i:2;C:1:\"Q\":317:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":267:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{i:0;C:1:\"Q\":132:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:13:\"status__state\";s:4:\"open\";i:0;C:1:\"Q\":51:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{s:8:\"staff_id\";i:1;}}}}}}s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:1:{i:0;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:1:{i:0;s:9:\"ticket_id\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:3;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}}}}s:16:\"path_constraints\";a:1:{s:4:\"lock\";a:1:{i:0;C:1:\"Q\":131:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:16:\"lock__expire__gt\";O:11:\"SqlFunction\":3:{s:5:\"alias\";N;s:4:\"func\";s:3:\"NOW\";s:4:\"args\";a:0:{}}}}}}}s:8:\"ordering\";a:1:{i:0;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:23:{s:14:\"lock__staff_id\";s:14:\"lock__staff_id\";s:8:\"staff_id\";s:8:\"staff_id\";s:9:\"isoverdue\";s:9:\"isoverdue\";s:7:\"team_id\";s:7:\"team_id\";s:12:\"last_duedate\";s:12:\"last_duedate\";s:9:\"ticket_id\";s:9:\"ticket_id\";s:6:\"number\";s:6:\"number\";s:14:\"cdata__subject\";s:14:\"cdata__subject\";s:28:\"user__default_email__address\";s:28:\"user__default_email__address\";s:6:\"source\";s:6:\"source\";s:32:\"cdata__:priority__priority_color\";s:32:\"cdata__:priority__priority_color\";s:31:\"cdata__:priority__priority_desc\";s:31:\"cdata__:priority__priority_desc\";s:9:\"status_id\";s:9:\"status_id\";s:12:\"status__name\";s:12:\"status__name\";s:13:\"status__state\";s:13:\"status__state\";s:7:\"dept_id\";s:7:\"dept_id\";s:10:\"dept__name\";s:10:\"dept__name\";s:10:\"user__name\";s:10:\"user__name\";s:10:\"lastupdate\";s:10:\"lastupdate\";s:10:\"isanswered\";s:10:\"isanswered\";s:16:\"staff__firstname\";s:16:\"staff__firstname\";s:15:\"staff__lastname\";s:15:\"staff__lastname\";s:10:\"team__name\";s:10:\"team__name\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:3:{s:12:\"collab_count\";C:8:\"QuerySet\":672:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:17:\"collaborators__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:16:\"attachment_count\";C:8:\"QuerySet\":768:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":72:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:28:\"entries__attachments__inline\";i:0;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:24:\"entries__attachments__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:12:\"thread_count\";C:8:\"QuerySet\":749:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":66:{a:3:{i:0;i:1;i:1;i:0;i:2;a:1:{s:22:\"entries__flags__hasbit\";i:4;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:11:\"entries__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}lastcroncall|i:1510304317;::Q:A|s:0:\"\";:QA::sort|a:2:{i:0;s:7:\"created\";i:1;i:0;}:Q:tasks|C:8:\"QuerySet\":2240:{a:16:{s:5:\"model\";s:4:\"Task\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":106:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{i:0;C:1:\"Q\":57:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"flags__hasbit\";i:1;}}}}}}i:1;C:1:\"Q\":260:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{i:0;C:1:\"Q\":76:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:13:\"flags__hasbit\";i:1;s:8:\"staff_id\";i:1;}}}i:1;C:1:\"Q\":117:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:1:{i:0;s:8:\"-created\";}s:7:\"related\";b:0;s:6:\"values\";a:11:{s:2:\"id\";s:2:\"id\";s:6:\"number\";s:6:\"number\";s:7:\"created\";s:7:\"created\";s:8:\"staff_id\";s:8:\"staff_id\";s:7:\"team_id\";s:7:\"team_id\";s:16:\"staff__firstname\";s:16:\"staff__firstname\";s:15:\"staff__lastname\";s:15:\"staff__lastname\";s:10:\"team__name\";s:10:\"team__name\";s:10:\"dept__name\";s:10:\"dept__name\";s:12:\"cdata__title\";s:12:\"cdata__title\";s:5:\"flags\";s:5:\"flags\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:3:{s:12:\"collab_count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:21:\"thread__collaborators\";s:8:\"distinct\";b:1;s:10:\"constraint\";b:0;s:5:\"alias\";s:12:\"collab_count\";}s:16:\"attachment_count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";O:7:\"SqlCase\":5:{s:5:\"cases\";a:1:{i:0;a:2:{i:0;O:8:\"SqlField\":3:{s:5:\"level\";i:0;s:5:\"alias\";N;s:5:\"field\";s:36:\"thread__entries__attachments__inline\";}i:1;N;}}s:4:\"else\";O:8:\"SqlField\":3:{s:5:\"level\";i:0;s:5:\"alias\";N;s:5:\"field\";s:28:\"thread__entries__attachments\";}s:5:\"alias\";N;s:4:\"func\";s:4:\"CASE\";s:4:\"args\";a:0:{}}s:8:\"distinct\";b:1;s:10:\"constraint\";b:0;s:5:\"alias\";s:16:\"attachment_count\";}s:12:\"thread_count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";O:7:\"SqlCase\":5:{s:5:\"cases\";a:1:{i:0;a:2:{i:0;C:1:\"Q\":74:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:30:\"thread__entries__flags__hasbit\";i:4;}}}i:1;N;}}s:4:\"else\";O:8:\"SqlField\":3:{s:5:\"level\";i:0;s:5:\"alias\";N;s:5:\"field\";s:19:\"thread__entries__id\";}s:5:\"alias\";N;s:4:\"func\";s:4:\"CASE\";s:4:\"args\";a:0:{}}s:8:\"distinct\";b:1;s:10:\"constraint\";b:0;s:5:\"alias\";s:12:\"thread_count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}:QT:solved:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}:QT:closed:sort|a:2:{i:0;s:6:\"closed\";i:1;i:0;}:uploadedFiles|a:1:{i:1;i:1;}:QT:export:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}:QT:assigned:sort|a:2:{i:0;s:7:\"updated\";i:1;i:0;}','2017-11-11 09:58:37',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('bar9jsa8ttr4gf4gverm2ho4v1','csrf|a:2:{s:5:\"token\";s:40:\"ea0d289b3a0e894d87739f63b7456d98f4abfc49\";s:4:\"time\";i:1510052495;}_auth|a:2:{s:5:\"staff\";N;s:4:\"user\";a:0:{}}_client|a:1:{s:4:\"auth\";a:1:{s:4:\"dest\";s:9:\"/open.php\";}}:token|a:0:{}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}client:Q|a:3:{s:8:\"keywords\";s:0:\"\";s:8:\"topic_id\";s:0:\"\";s:6:\"status\";s:4:\"open\";}','2017-11-08 12:01:35',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('bjimj6et9di4ht6pi4fiaftvh4','csrf|a:2:{s:5:\"token\";s:40:\"b3d2c852f6ef833947adb29b99cb181f32e0e0ca\";s:4:\"time\";i:1509952941;}_staff|a:1:{s:4:\"auth\";a:2:{s:4:\"dest\";s:28:\"/scp/tickets.php?status=open\";s:3:\"msg\";s:24:\"Autenticación Requerida\";}}_auth|a:1:{s:5:\"staff\";a:2:{s:2:\"id\";i:1;s:3:\"key\";s:12:\"local:carlos\";}}:token|a:1:{s:5:\"staff\";s:76:\"a51341378016bdd23c023553793a465b:1509952936:efb4e12265ca7e4fc8fc726a9feb90bc\";}::Q:T|s:4:\"open\";:QT:open:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}:Q:tickets|C:8:\"QuerySet\":4911:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":986:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"ticket_id__in\";C:8:\"QuerySet\":912:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":64:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"status__state\";s:4:\"open\";}}}i:1;C:1:\"Q\":317:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":267:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{i:0;C:1:\"Q\":132:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:13:\"status__state\";s:4:\"open\";i:0;C:1:\"Q\":51:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{s:8:\"staff_id\";i:1;}}}}}}s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:1:{i:0;s:9:\"ticket_id\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:3;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}}}}s:16:\"path_constraints\";a:1:{s:4:\"lock\";a:1:{i:0;C:1:\"Q\":131:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:16:\"lock__expire__gt\";O:11:\"SqlFunction\":3:{s:5:\"alias\";N;s:4:\"func\";s:3:\"NOW\";s:4:\"args\";a:0:{}}}}}}}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:23:{s:14:\"lock__staff_id\";s:14:\"lock__staff_id\";s:8:\"staff_id\";s:8:\"staff_id\";s:9:\"isoverdue\";s:9:\"isoverdue\";s:7:\"team_id\";s:7:\"team_id\";s:12:\"last_duedate\";s:12:\"last_duedate\";s:9:\"ticket_id\";s:9:\"ticket_id\";s:6:\"number\";s:6:\"number\";s:14:\"cdata__subject\";s:14:\"cdata__subject\";s:28:\"user__default_email__address\";s:28:\"user__default_email__address\";s:6:\"source\";s:6:\"source\";s:32:\"cdata__:priority__priority_color\";s:32:\"cdata__:priority__priority_color\";s:31:\"cdata__:priority__priority_desc\";s:31:\"cdata__:priority__priority_desc\";s:9:\"status_id\";s:9:\"status_id\";s:12:\"status__name\";s:12:\"status__name\";s:13:\"status__state\";s:13:\"status__state\";s:7:\"dept_id\";s:7:\"dept_id\";s:10:\"dept__name\";s:10:\"dept__name\";s:10:\"user__name\";s:10:\"user__name\";s:10:\"lastupdate\";s:10:\"lastupdate\";s:10:\"isanswered\";s:10:\"isanswered\";s:16:\"staff__firstname\";s:16:\"staff__firstname\";s:15:\"staff__lastname\";s:15:\"staff__lastname\";s:10:\"team__name\";s:10:\"team__name\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:3:{s:12:\"collab_count\";C:8:\"QuerySet\":672:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:17:\"collaborators__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:16:\"attachment_count\";C:8:\"QuerySet\":768:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":72:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:28:\"entries__attachments__inline\";i:0;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:24:\"entries__attachments__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:12:\"thread_count\";C:8:\"QuerySet\":749:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":66:{a:3:{i:0;i:1;i:1;i:0;i:2;a:1:{s:22:\"entries__flags__hasbit\";i:4;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:11:\"entries__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}lastcroncall|i:1509952895;::Q:A|s:4:\"open\";:QA::sort|a:2:{i:0;s:7:\"created\";i:1;i:0;}:Q:tasks|C:8:\"QuerySet\":2240:{a:16:{s:5:\"model\";s:4:\"Task\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":106:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{i:0;C:1:\"Q\":57:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"flags__hasbit\";i:1;}}}}}}i:1;C:1:\"Q\":260:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{i:0;C:1:\"Q\":76:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:13:\"flags__hasbit\";i:1;s:8:\"staff_id\";i:1;}}}i:1;C:1:\"Q\":117:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:1:{i:0;s:8:\"-created\";}s:7:\"related\";b:0;s:6:\"values\";a:11:{s:2:\"id\";s:2:\"id\";s:6:\"number\";s:6:\"number\";s:7:\"created\";s:7:\"created\";s:8:\"staff_id\";s:8:\"staff_id\";s:7:\"team_id\";s:7:\"team_id\";s:16:\"staff__firstname\";s:16:\"staff__firstname\";s:15:\"staff__lastname\";s:15:\"staff__lastname\";s:10:\"team__name\";s:10:\"team__name\";s:10:\"dept__name\";s:10:\"dept__name\";s:12:\"cdata__title\";s:12:\"cdata__title\";s:5:\"flags\";s:5:\"flags\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:3:{s:12:\"collab_count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:21:\"thread__collaborators\";s:8:\"distinct\";b:1;s:10:\"constraint\";b:0;s:5:\"alias\";s:12:\"collab_count\";}s:16:\"attachment_count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";O:7:\"SqlCase\":5:{s:5:\"cases\";a:1:{i:0;a:2:{i:0;O:8:\"SqlField\":3:{s:5:\"level\";i:0;s:5:\"alias\";N;s:5:\"field\";s:36:\"thread__entries__attachments__inline\";}i:1;N;}}s:4:\"else\";O:8:\"SqlField\":3:{s:5:\"level\";i:0;s:5:\"alias\";N;s:5:\"field\";s:28:\"thread__entries__attachments\";}s:5:\"alias\";N;s:4:\"func\";s:4:\"CASE\";s:4:\"args\";a:0:{}}s:8:\"distinct\";b:1;s:10:\"constraint\";b:0;s:5:\"alias\";s:16:\"attachment_count\";}s:12:\"thread_count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";O:7:\"SqlCase\":5:{s:5:\"cases\";a:1:{i:0;a:2:{i:0;C:1:\"Q\":74:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:30:\"thread__entries__flags__hasbit\";i:4;}}}i:1;N;}}s:4:\"else\";O:8:\"SqlField\":3:{s:5:\"level\";i:0;s:5:\"alias\";N;s:5:\"field\";s:19:\"thread__entries__id\";}s:5:\"alias\";N;s:4:\"func\";s:4:\"CASE\";s:4:\"args\";a:0:{}}s:8:\"distinct\";b:1;s:10:\"constraint\";b:0;s:5:\"alias\";s:12:\"thread_count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}:QA:open:sort|a:2:{i:0;s:7:\"created\";i:1;i:0;}','2017-11-07 08:22:21',NULL,'1','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('c7pbcpn3jm2k2a9lckmuctbnj0','csrf|a:2:{s:5:\"token\";s:40:\"28b0889c0eace2d59ce0457a6b74545e70d077ae\";s:4:\"time\";i:1510127869;}_auth|a:1:{s:5:\"staff\";a:2:{s:2:\"id\";i:1;s:3:\"key\";s:12:\"local:carlos\";}}:token|a:1:{s:5:\"staff\";s:76:\"2503f6154387cbc6e8c0c17e45c25816:1510127849:efb4e12265ca7e4fc8fc726a9feb90bc\";}::Q:T|s:4:\"open\";:QT:open:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}:Q:tickets|C:8:\"QuerySet\":4911:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":986:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"ticket_id__in\";C:8:\"QuerySet\":912:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":64:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"status__state\";s:4:\"open\";}}}i:1;C:1:\"Q\":317:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":267:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{i:0;C:1:\"Q\":132:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:13:\"status__state\";s:4:\"open\";i:0;C:1:\"Q\":51:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{s:8:\"staff_id\";i:1;}}}}}}s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:1:{i:0;s:9:\"ticket_id\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:3;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}}}}s:16:\"path_constraints\";a:1:{s:4:\"lock\";a:1:{i:0;C:1:\"Q\":131:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:16:\"lock__expire__gt\";O:11:\"SqlFunction\":3:{s:5:\"alias\";N;s:4:\"func\";s:3:\"NOW\";s:4:\"args\";a:0:{}}}}}}}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:23:{s:14:\"lock__staff_id\";s:14:\"lock__staff_id\";s:8:\"staff_id\";s:8:\"staff_id\";s:9:\"isoverdue\";s:9:\"isoverdue\";s:7:\"team_id\";s:7:\"team_id\";s:12:\"last_duedate\";s:12:\"last_duedate\";s:9:\"ticket_id\";s:9:\"ticket_id\";s:6:\"number\";s:6:\"number\";s:14:\"cdata__subject\";s:14:\"cdata__subject\";s:28:\"user__default_email__address\";s:28:\"user__default_email__address\";s:6:\"source\";s:6:\"source\";s:32:\"cdata__:priority__priority_color\";s:32:\"cdata__:priority__priority_color\";s:31:\"cdata__:priority__priority_desc\";s:31:\"cdata__:priority__priority_desc\";s:9:\"status_id\";s:9:\"status_id\";s:12:\"status__name\";s:12:\"status__name\";s:13:\"status__state\";s:13:\"status__state\";s:7:\"dept_id\";s:7:\"dept_id\";s:10:\"dept__name\";s:10:\"dept__name\";s:10:\"user__name\";s:10:\"user__name\";s:10:\"lastupdate\";s:10:\"lastupdate\";s:10:\"isanswered\";s:10:\"isanswered\";s:16:\"staff__firstname\";s:16:\"staff__firstname\";s:15:\"staff__lastname\";s:15:\"staff__lastname\";s:10:\"team__name\";s:10:\"team__name\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:3:{s:12:\"collab_count\";C:8:\"QuerySet\":672:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:17:\"collaborators__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:16:\"attachment_count\";C:8:\"QuerySet\":768:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":72:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:28:\"entries__attachments__inline\";i:0;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:24:\"entries__attachments__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:12:\"thread_count\";C:8:\"QuerySet\":749:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":66:{a:3:{i:0;i:1;i:1;i:0;i:2;a:1:{s:22:\"entries__flags__hasbit\";i:4;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:11:\"entries__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}lastcroncall|i:1510126280;:QT:solved:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}:Q:users|C:8:\"QuerySet\":771:{a:16:{s:5:\"model\";s:4:\"User\";s:11:\"constraints\";a:0:{}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:1:{i:0;s:4:\"name\";}s:7:\"related\";b:0;s:6:\"values\";a:7:{s:2:\"id\";s:2:\"id\";s:4:\"name\";s:4:\"name\";s:22:\"default_email__address\";s:22:\"default_email__address\";s:11:\"account__id\";s:11:\"account__id\";s:15:\"account__status\";s:15:\"account__status\";s:7:\"created\";s:7:\"created\";s:7:\"updated\";s:7:\"updated\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:1:{s:12:\"ticket_count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:7:\"tickets\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:12:\"ticket_count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}','2017-11-09 08:57:49',NULL,'1','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('dhu88flishu398g0jhu13vm3e6','csrf|a:2:{s:5:\"token\";s:40:\"c939537e033decdf44c69465996c25334ad89a71\";s:4:\"time\";i:1510044509;}_auth|a:2:{s:5:\"staff\";N;s:4:\"user\";a:0:{}}_client|a:1:{s:4:\"auth\";a:1:{s:4:\"dest\";s:9:\"/open.php\";}}:token|a:0:{}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}','2017-11-08 09:48:29',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('di449pdoul1r4rs2ba6n43dt63','csrf|a:2:{s:5:\"token\";s:40:\"3033083a74996996434ea3970763f1a067f3ced4\";s:4:\"time\";i:1509972967;}_auth|a:2:{s:5:\"staff\";N;s:4:\"user\";a:0:{}}:token|a:0:{}','2017-11-07 13:56:07',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('h7t9ekvkuhiq4p9jou5add1jc2','csrf|N;','2017-11-10 10:46:58',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('iplq27hgkufu3egm7o6cmu35r4','csrf|a:2:{s:5:\"token\";s:40:\"62c832fad643d00c4d0907e09a00c29d25b72229\";s:4:\"time\";i:1510044220;}_auth|a:2:{s:5:\"staff\";N;s:4:\"user\";a:0:{}}:token|a:0:{}client:Q|N;cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}','2017-11-08 09:43:40',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('kfbbk46lrrjgduer5n60fmb1u0','csrf|a:2:{s:5:\"token\";s:40:\"d8b3ee4cee97f103669fd89a7be857fa6cdfdd1f\";s:4:\"time\";i:1510231694;}_staff|a:1:{s:4:\"auth\";a:2:{s:4:\"dest\";s:30:\"/scp/tickets.php?status=closed\";s:3:\"msg\";s:24:\"Autenticación Requerida\";}}_auth|a:1:{s:5:\"staff\";a:2:{s:2:\"id\";i:1;s:3:\"key\";s:12:\"local:carlos\";}}:token|a:1:{s:5:\"staff\";s:76:\"7ea2b721fcb914ad3ecf3f33b827dc03:1510231694:efb4e12265ca7e4fc8fc726a9feb90bc\";}::Q:T|s:6:\"solved\";:QT:closed:sort|a:2:{i:0;s:8:\"priority\";i:1;s:1:\"0\";}:Q:tickets|C:8:\"QuerySet\":4913:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":988:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"ticket_id__in\";C:8:\"QuerySet\":914:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":66:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"status__state\";s:6:\"solved\";}}}i:1;C:1:\"Q\":317:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":267:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{i:0;C:1:\"Q\":132:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:13:\"status__state\";s:4:\"open\";i:0;C:1:\"Q\":51:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{s:8:\"staff_id\";i:1;}}}}}}s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:1:{i:0;s:9:\"ticket_id\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:3;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}}}}s:16:\"path_constraints\";a:1:{s:4:\"lock\";a:1:{i:0;C:1:\"Q\":131:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:16:\"lock__expire__gt\";O:11:\"SqlFunction\":3:{s:5:\"alias\";N;s:4:\"func\";s:3:\"NOW\";s:4:\"args\";a:0:{}}}}}}}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:23:{s:14:\"lock__staff_id\";s:14:\"lock__staff_id\";s:8:\"staff_id\";s:8:\"staff_id\";s:9:\"isoverdue\";s:9:\"isoverdue\";s:7:\"team_id\";s:7:\"team_id\";s:12:\"last_duedate\";s:12:\"last_duedate\";s:9:\"ticket_id\";s:9:\"ticket_id\";s:6:\"number\";s:6:\"number\";s:14:\"cdata__subject\";s:14:\"cdata__subject\";s:28:\"user__default_email__address\";s:28:\"user__default_email__address\";s:6:\"source\";s:6:\"source\";s:32:\"cdata__:priority__priority_color\";s:32:\"cdata__:priority__priority_color\";s:31:\"cdata__:priority__priority_desc\";s:31:\"cdata__:priority__priority_desc\";s:9:\"status_id\";s:9:\"status_id\";s:12:\"status__name\";s:12:\"status__name\";s:13:\"status__state\";s:13:\"status__state\";s:7:\"dept_id\";s:7:\"dept_id\";s:10:\"dept__name\";s:10:\"dept__name\";s:10:\"user__name\";s:10:\"user__name\";s:10:\"lastupdate\";s:10:\"lastupdate\";s:10:\"isanswered\";s:10:\"isanswered\";s:16:\"staff__firstname\";s:16:\"staff__firstname\";s:15:\"staff__lastname\";s:15:\"staff__lastname\";s:10:\"team__name\";s:10:\"team__name\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:3:{s:12:\"collab_count\";C:8:\"QuerySet\":672:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:17:\"collaborators__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:16:\"attachment_count\";C:8:\"QuerySet\":768:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":72:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:28:\"entries__attachments__inline\";i:0;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:24:\"entries__attachments__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:12:\"thread_count\";C:8:\"QuerySet\":749:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":66:{a:3:{i:0;i:1;i:1;i:0;i:2;a:1:{s:22:\"entries__flags__hasbit\";i:4;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:11:\"entries__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}lastcroncall|i:1510231615;:QT:open:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}:QT:solved:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}::Q:E|s:4:\"open\";:QE::sort|a:2:{i:0;s:10:\"activation\";i:1;i:0;}:Q:equipments|C:8:\"QuerySet\":1737:{a:16:{s:5:\"model\";s:14:\"EquipmentModel\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":807:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:6:\"id__in\";C:8:\"QuerySet\":741:{a:16:{s:5:\"model\";s:14:\"EquipmentModel\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":67:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"status__state\";s:7:\"retired\";}}}i:1;C:1:\"Q\":217:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":167:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":117:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:1:{i:0;a:2:{i:0;s:10:\"retirement\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:1:{i:0;s:2:\"id\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:3;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}}}}s:16:\"path_constraints\";a:1:{s:4:\"lock\";a:1:{i:0;C:1:\"Q\":131:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:16:\"lock__expire__gt\";O:11:\"SqlFunction\":3:{s:5:\"alias\";N;s:4:\"func\";s:3:\"NOW\";s:4:\"args\";a:0:{}}}}}}}s:8:\"ordering\";a:1:{i:0;a:2:{i:0;s:10:\"retirement\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:10:{s:10:\"retirement\";s:10:\"retirement\";s:14:\"lock__staff_id\";s:14:\"lock__staff_id\";s:2:\"id\";s:2:\"id\";s:4:\"name\";s:4:\"name\";s:11:\"description\";s:11:\"description\";s:9:\"status_id\";s:9:\"status_id\";s:12:\"status__name\";s:12:\"status__name\";s:13:\"status__state\";s:13:\"status__state\";s:7:\"updated\";s:7:\"updated\";s:10:\"dept__name\";s:10:\"dept__name\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}:QE:available:sort|a:2:{i:0;s:10:\"activation\";i:1;i:0;}:QE:inactive:sort|a:2:{i:0;s:12:\"deactivation\";i:1;i:0;}:QE:retired:sort|a:2:{i:0;s:10:\"retirement\";i:1;i:0;}:Q:users|C:8:\"QuerySet\":771:{a:16:{s:5:\"model\";s:4:\"User\";s:11:\"constraints\";a:0:{}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:1:{i:0;s:4:\"name\";}s:7:\"related\";b:0;s:6:\"values\";a:7:{s:2:\"id\";s:2:\"id\";s:4:\"name\";s:4:\"name\";s:22:\"default_email__address\";s:22:\"default_email__address\";s:11:\"account__id\";s:11:\"account__id\";s:15:\"account__status\";s:15:\"account__status\";s:7:\"created\";s:7:\"created\";s:7:\"updated\";s:7:\"updated\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:1:{s:12:\"ticket_count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:7:\"tickets\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:12:\"ticket_count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}::Q:A|s:0:\"\";:QA::sort|a:2:{i:0;s:7:\"created\";i:1;i:0;}:Q:tasks|C:8:\"QuerySet\":2240:{a:16:{s:5:\"model\";s:4:\"Task\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":106:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{i:0;C:1:\"Q\":57:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"flags__hasbit\";i:1;}}}}}}i:1;C:1:\"Q\":260:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{i:0;C:1:\"Q\":76:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:13:\"flags__hasbit\";i:1;s:8:\"staff_id\";i:1;}}}i:1;C:1:\"Q\":117:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:1:{i:0;s:8:\"-created\";}s:7:\"related\";b:0;s:6:\"values\";a:11:{s:2:\"id\";s:2:\"id\";s:6:\"number\";s:6:\"number\";s:7:\"created\";s:7:\"created\";s:8:\"staff_id\";s:8:\"staff_id\";s:7:\"team_id\";s:7:\"team_id\";s:16:\"staff__firstname\";s:16:\"staff__firstname\";s:15:\"staff__lastname\";s:15:\"staff__lastname\";s:10:\"team__name\";s:10:\"team__name\";s:10:\"dept__name\";s:10:\"dept__name\";s:12:\"cdata__title\";s:12:\"cdata__title\";s:5:\"flags\";s:5:\"flags\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:3:{s:12:\"collab_count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:21:\"thread__collaborators\";s:8:\"distinct\";b:1;s:10:\"constraint\";b:0;s:5:\"alias\";s:12:\"collab_count\";}s:16:\"attachment_count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";O:7:\"SqlCase\":5:{s:5:\"cases\";a:1:{i:0;a:2:{i:0;O:8:\"SqlField\":3:{s:5:\"level\";i:0;s:5:\"alias\";N;s:5:\"field\";s:36:\"thread__entries__attachments__inline\";}i:1;N;}}s:4:\"else\";O:8:\"SqlField\":3:{s:5:\"level\";i:0;s:5:\"alias\";N;s:5:\"field\";s:28:\"thread__entries__attachments\";}s:5:\"alias\";N;s:4:\"func\";s:4:\"CASE\";s:4:\"args\";a:0:{}}s:8:\"distinct\";b:1;s:10:\"constraint\";b:0;s:5:\"alias\";s:16:\"attachment_count\";}s:12:\"thread_count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";O:7:\"SqlCase\":5:{s:5:\"cases\";a:1:{i:0;a:2:{i:0;C:1:\"Q\":74:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:30:\"thread__entries__flags__hasbit\";i:4;}}}i:1;N;}}s:4:\"else\";O:8:\"SqlField\":3:{s:5:\"level\";i:0;s:5:\"alias\";N;s:5:\"field\";s:19:\"thread__entries__id\";}s:5:\"alias\";N;s:4:\"func\";s:4:\"CASE\";s:4:\"args\";a:0:{}}s:8:\"distinct\";b:1;s:10:\"constraint\";b:0;s:5:\"alias\";s:12:\"thread_count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}','2017-11-10 13:48:14',NULL,'1','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('lqmdapjl452vqmo674acs821c6','csrf|a:2:{s:5:\"token\";s:40:\"69850b9bff107ab9889f2e07294aacf0057069d2\";s:4:\"time\";i:1510044085;}_client|a:1:{s:4:\"auth\";a:1:{s:4:\"dest\";s:9:\"/open.php\";}}_auth|a:1:{s:4:\"user\";a:0:{}}:token|a:0:{}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}','2017-11-08 09:41:25',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('n0prm0upqk1hjm9rsv2eqhkiv1','csrf|a:2:{s:5:\"token\";s:40:\"a0a7d44f7ff37cb3b22028b584088869e7f5fc22\";s:4:\"time\";i:1510039919;}_auth|a:1:{s:5:\"staff\";N;}','2017-11-08 08:31:59',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('ncoca94mlgaa6hb8m6je8b7fe2','csrf|a:2:{s:5:\"token\";s:40:\"c8cf4c9d55de4889ffc80a2204451821153e0098\";s:4:\"time\";i:1509713911;}_auth|a:1:{s:5:\"staff\";N;}','2017-11-04 13:58:31',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('ok9ck33kcn7o50ggs833i5v363','csrf|N;_staff|a:1:{s:4:\"auth\";a:2:{s:4:\"dest\";s:16:\"/scp/tickets.php\";s:3:\"msg\";s:24:\"Autenticación Requerida\";}}','2017-11-07 08:35:07',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('rflatdcnnmr3fisttc6obsshj1','csrf|a:2:{s:5:\"token\";s:40:\"4b7a888302753c679f63248613ed32443b5d4b30\";s:4:\"time\";i:1510050838;}_auth|a:2:{s:5:\"staff\";N;s:4:\"user\";a:0:{}}_staff|a:1:{s:4:\"auth\";a:2:{s:4:\"dest\";s:5:\"/scp/\";s:3:\"msg\";s:24:\"Autenticación Requerida\";}}:token|a:0:{}','2017-11-08 11:33:58',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('ri5gcb9obhgbe00ehfvdhk4103','csrf|a:2:{s:5:\"token\";s:40:\"b19c707ab5ec1947a60be0f63f26e3a7e7fbc8b9\";s:4:\"time\";i:1510218067;}_auth|a:1:{s:5:\"staff\";a:2:{s:2:\"id\";i:1;s:3:\"key\";s:12:\"local:carlos\";}}:token|a:1:{s:5:\"staff\";s:76:\"543f841d6046c01043da44b8f08d0096:1510218067:efb4e12265ca7e4fc8fc726a9feb90bc\";}::Q:T|s:6:\"closed\";:QT:open:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}:Q:tickets|C:8:\"QuerySet\":4789:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":913:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"ticket_id__in\";C:8:\"QuerySet\":839:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":66:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"status__state\";s:6:\"closed\";}}}i:1;C:1:\"Q\":317:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":267:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{i:0;C:1:\"Q\":132:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:13:\"status__state\";s:4:\"open\";i:0;C:1:\"Q\":51:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{s:8:\"staff_id\";i:1;}}}}}}s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:1:{i:0;a:2:{i:0;s:6:\"closed\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:1:{i:0;s:9:\"ticket_id\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:3;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}}}}s:16:\"path_constraints\";a:1:{s:4:\"lock\";a:1:{i:0;C:1:\"Q\":131:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:16:\"lock__expire__gt\";O:11:\"SqlFunction\":3:{s:5:\"alias\";N;s:4:\"func\";s:3:\"NOW\";s:4:\"args\";a:0:{}}}}}}}s:8:\"ordering\";a:1:{i:0;a:2:{i:0;s:6:\"closed\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:24:{s:6:\"closed\";s:6:\"closed\";s:14:\"lock__staff_id\";s:14:\"lock__staff_id\";s:8:\"staff_id\";s:8:\"staff_id\";s:9:\"isoverdue\";s:9:\"isoverdue\";s:7:\"team_id\";s:7:\"team_id\";s:12:\"last_duedate\";s:12:\"last_duedate\";s:9:\"ticket_id\";s:9:\"ticket_id\";s:6:\"number\";s:6:\"number\";s:14:\"cdata__subject\";s:14:\"cdata__subject\";s:28:\"user__default_email__address\";s:28:\"user__default_email__address\";s:6:\"source\";s:6:\"source\";s:32:\"cdata__:priority__priority_color\";s:32:\"cdata__:priority__priority_color\";s:31:\"cdata__:priority__priority_desc\";s:31:\"cdata__:priority__priority_desc\";s:9:\"status_id\";s:9:\"status_id\";s:12:\"status__name\";s:12:\"status__name\";s:13:\"status__state\";s:13:\"status__state\";s:7:\"dept_id\";s:7:\"dept_id\";s:10:\"dept__name\";s:10:\"dept__name\";s:10:\"user__name\";s:10:\"user__name\";s:10:\"lastupdate\";s:10:\"lastupdate\";s:10:\"isanswered\";s:10:\"isanswered\";s:16:\"staff__firstname\";s:16:\"staff__firstname\";s:15:\"staff__lastname\";s:15:\"staff__lastname\";s:10:\"team__name\";s:10:\"team__name\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:3:{s:12:\"collab_count\";C:8:\"QuerySet\":672:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:17:\"collaborators__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:16:\"attachment_count\";C:8:\"QuerySet\":768:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":72:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:28:\"entries__attachments__inline\";i:0;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:24:\"entries__attachments__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:12:\"thread_count\";C:8:\"QuerySet\":749:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":66:{a:3:{i:0;i:1;i:1;i:0;i:2;a:1:{s:22:\"entries__flags__hasbit\";i:4;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:11:\"entries__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}lastcroncall|i:1510216618;:QT:closed:sort|a:2:{i:0;s:6:\"closed\";i:1;i:0;}:QT:solved:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}::Q:A|s:0:\"\";:QA::sort|a:2:{i:0;s:7:\"created\";i:1;i:0;}:Q:tasks|C:8:\"QuerySet\":2240:{a:16:{s:5:\"model\";s:4:\"Task\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":106:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{i:0;C:1:\"Q\":57:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"flags__hasbit\";i:1;}}}}}}i:1;C:1:\"Q\":260:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{i:0;C:1:\"Q\":76:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:13:\"flags__hasbit\";i:1;s:8:\"staff_id\";i:1;}}}i:1;C:1:\"Q\":117:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:1:{i:0;s:8:\"-created\";}s:7:\"related\";b:0;s:6:\"values\";a:11:{s:2:\"id\";s:2:\"id\";s:6:\"number\";s:6:\"number\";s:7:\"created\";s:7:\"created\";s:8:\"staff_id\";s:8:\"staff_id\";s:7:\"team_id\";s:7:\"team_id\";s:16:\"staff__firstname\";s:16:\"staff__firstname\";s:15:\"staff__lastname\";s:15:\"staff__lastname\";s:10:\"team__name\";s:10:\"team__name\";s:10:\"dept__name\";s:10:\"dept__name\";s:12:\"cdata__title\";s:12:\"cdata__title\";s:5:\"flags\";s:5:\"flags\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:3:{s:12:\"collab_count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:21:\"thread__collaborators\";s:8:\"distinct\";b:1;s:10:\"constraint\";b:0;s:5:\"alias\";s:12:\"collab_count\";}s:16:\"attachment_count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";O:7:\"SqlCase\":5:{s:5:\"cases\";a:1:{i:0;a:2:{i:0;O:8:\"SqlField\":3:{s:5:\"level\";i:0;s:5:\"alias\";N;s:5:\"field\";s:36:\"thread__entries__attachments__inline\";}i:1;N;}}s:4:\"else\";O:8:\"SqlField\":3:{s:5:\"level\";i:0;s:5:\"alias\";N;s:5:\"field\";s:28:\"thread__entries__attachments\";}s:5:\"alias\";N;s:4:\"func\";s:4:\"CASE\";s:4:\"args\";a:0:{}}s:8:\"distinct\";b:1;s:10:\"constraint\";b:0;s:5:\"alias\";s:16:\"attachment_count\";}s:12:\"thread_count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";O:7:\"SqlCase\":5:{s:5:\"cases\";a:1:{i:0;a:2:{i:0;C:1:\"Q\":74:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:30:\"thread__entries__flags__hasbit\";i:4;}}}i:1;N;}}s:4:\"else\";O:8:\"SqlField\":3:{s:5:\"level\";i:0;s:5:\"alias\";N;s:5:\"field\";s:19:\"thread__entries__id\";}s:5:\"alias\";N;s:4:\"func\";s:4:\"CASE\";s:4:\"args\";a:0:{}}s:8:\"distinct\";b:1;s:10:\"constraint\";b:0;s:5:\"alias\";s:12:\"thread_count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}::Q:E|s:0:\"\";:QE::sort|a:2:{i:0;s:10:\"activation\";i:1;i:0;}:Q:equipments|C:8:\"QuerySet\":1736:{a:16:{s:5:\"model\";s:14:\"EquipmentModel\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":806:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:6:\"id__in\";C:8:\"QuerySet\":740:{a:16:{s:5:\"model\";s:14:\"EquipmentModel\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":66:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"status__state\";s:6:\"active\";}}}i:1;C:1:\"Q\":217:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":167:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":117:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:1:{i:0;a:2:{i:0;s:10:\"activation\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:1:{i:0;s:2:\"id\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:3;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}}}}s:16:\"path_constraints\";a:1:{s:4:\"lock\";a:1:{i:0;C:1:\"Q\":131:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:16:\"lock__expire__gt\";O:11:\"SqlFunction\":3:{s:5:\"alias\";N;s:4:\"func\";s:3:\"NOW\";s:4:\"args\";a:0:{}}}}}}}s:8:\"ordering\";a:1:{i:0;a:2:{i:0;s:10:\"activation\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:10:{s:10:\"activation\";s:10:\"activation\";s:14:\"lock__staff_id\";s:14:\"lock__staff_id\";s:2:\"id\";s:2:\"id\";s:4:\"name\";s:4:\"name\";s:11:\"description\";s:11:\"description\";s:9:\"status_id\";s:9:\"status_id\";s:12:\"status__name\";s:12:\"status__name\";s:13:\"status__state\";s:13:\"status__state\";s:7:\"updated\";s:7:\"updated\";s:10:\"dept__name\";s:10:\"dept__name\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}:Q:users|C:8:\"QuerySet\":771:{a:16:{s:5:\"model\";s:4:\"User\";s:11:\"constraints\";a:0:{}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:1:{i:0;s:4:\"name\";}s:7:\"related\";b:0;s:6:\"values\";a:7:{s:2:\"id\";s:2:\"id\";s:4:\"name\";s:4:\"name\";s:22:\"default_email__address\";s:22:\"default_email__address\";s:11:\"account__id\";s:11:\"account__id\";s:15:\"account__status\";s:15:\"account__status\";s:7:\"created\";s:7:\"created\";s:7:\"updated\";s:7:\"updated\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:1:{s:12:\"ticket_count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:7:\"tickets\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:12:\"ticket_count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}','2017-11-10 10:01:07',NULL,'1','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('rqsmpoejplbhr87lj8m2r03tn0','csrf|a:2:{s:5:\"token\";s:40:\"eaa06d8356c98f18e8ea8f96ffc72865078bbe59\";s:4:\"time\";i:1510316085;}_auth|a:2:{s:5:\"staff\";N;s:4:\"user\";a:0:{}}_client|a:1:{s:4:\"auth\";a:1:{s:4:\"dest\";s:9:\"/open.php\";}}:token|a:0:{}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}','2017-11-11 13:14:45',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('sjt6gipcn0nfa1oi6jilg1e0m6','csrf|a:2:{s:5:\"token\";s:40:\"a3ce06255192ffb167449e951482c388b357fd06\";s:4:\"time\";i:1510318381;}_auth|a:1:{s:5:\"staff\";a:2:{s:2:\"id\";i:1;s:3:\"key\";s:12:\"local:carlos\";}}:token|a:1:{s:5:\"staff\";s:76:\"5f36b218e235bb47a197d84bf710fc53:1510318378:efb4e12265ca7e4fc8fc726a9feb90bc\";}::Q:T|s:6:\"closed\";:QT:open:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}:Q:tickets|C:8:\"QuerySet\":4789:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":913:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"ticket_id__in\";C:8:\"QuerySet\":839:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":66:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"status__state\";s:6:\"closed\";}}}i:1;C:1:\"Q\":317:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":267:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{i:0;C:1:\"Q\":132:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:13:\"status__state\";s:4:\"open\";i:0;C:1:\"Q\":51:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{s:8:\"staff_id\";i:1;}}}}}}s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:1:{i:0;a:2:{i:0;s:6:\"closed\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:1:{i:0;s:9:\"ticket_id\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:3;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}}}}s:16:\"path_constraints\";a:1:{s:4:\"lock\";a:1:{i:0;C:1:\"Q\":131:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:16:\"lock__expire__gt\";O:11:\"SqlFunction\":3:{s:5:\"alias\";N;s:4:\"func\";s:3:\"NOW\";s:4:\"args\";a:0:{}}}}}}}s:8:\"ordering\";a:1:{i:0;a:2:{i:0;s:6:\"closed\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:24:{s:6:\"closed\";s:6:\"closed\";s:14:\"lock__staff_id\";s:14:\"lock__staff_id\";s:8:\"staff_id\";s:8:\"staff_id\";s:9:\"isoverdue\";s:9:\"isoverdue\";s:7:\"team_id\";s:7:\"team_id\";s:12:\"last_duedate\";s:12:\"last_duedate\";s:9:\"ticket_id\";s:9:\"ticket_id\";s:6:\"number\";s:6:\"number\";s:14:\"cdata__subject\";s:14:\"cdata__subject\";s:28:\"user__default_email__address\";s:28:\"user__default_email__address\";s:6:\"source\";s:6:\"source\";s:32:\"cdata__:priority__priority_color\";s:32:\"cdata__:priority__priority_color\";s:31:\"cdata__:priority__priority_desc\";s:31:\"cdata__:priority__priority_desc\";s:9:\"status_id\";s:9:\"status_id\";s:12:\"status__name\";s:12:\"status__name\";s:13:\"status__state\";s:13:\"status__state\";s:7:\"dept_id\";s:7:\"dept_id\";s:10:\"dept__name\";s:10:\"dept__name\";s:10:\"user__name\";s:10:\"user__name\";s:10:\"lastupdate\";s:10:\"lastupdate\";s:10:\"isanswered\";s:10:\"isanswered\";s:16:\"staff__firstname\";s:16:\"staff__firstname\";s:15:\"staff__lastname\";s:15:\"staff__lastname\";s:10:\"team__name\";s:10:\"team__name\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:3:{s:12:\"collab_count\";C:8:\"QuerySet\":672:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:17:\"collaborators__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:16:\"attachment_count\";C:8:\"QuerySet\":768:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":72:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:28:\"entries__attachments__inline\";i:0;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:24:\"entries__attachments__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:12:\"thread_count\";C:8:\"QuerySet\":749:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":66:{a:3:{i:0;i:1;i:1;i:0;i:2;a:1:{s:22:\"entries__flags__hasbit\";i:4;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:11:\"entries__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}lastcroncall|i:1510318379;:QT:overdue:sort|a:2:{i:0;s:12:\"priority,due\";i:1;i:0;}:QT:assigned:sort|a:2:{i:0;s:7:\"updated\";i:1;i:0;}:QT:closed:sort|a:2:{i:0;s:6:\"closed\";i:1;i:0;}','2017-11-11 13:53:01',NULL,'1','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('t17fm1rd3ntttr24ubpsvovvu2','csrf|N;_staff|a:1:{s:4:\"auth\";a:2:{s:4:\"dest\";s:18:\"/scp/equipment.php\";s:3:\"msg\";s:24:\"Autenticación Requerida\";}}','2017-11-08 08:31:59',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('t6m5cvpelt5qd5lkaugajrevk5','csrf|a:2:{s:5:\"token\";s:40:\"2839cc03e05f2a234716a8863b64ce36adbb20e8\";s:4:\"time\";i:1509973099;}_auth|a:2:{s:5:\"staff\";N;s:4:\"user\";a:0:{}}:token|a:0:{}','2017-11-07 13:58:19',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('tbkqmomqg7k81cspreuop130f1','csrf|a:2:{s:5:\"token\";s:40:\"ccc128a9fae677710cf546374453c2af9d282df5\";s:4:\"time\";i:1509958498;}_auth|a:1:{s:5:\"staff\";a:2:{s:2:\"id\";i:1;s:3:\"key\";s:12:\"local:carlos\";}}:token|a:1:{s:5:\"staff\";s:76:\"a1be2a61cfc08d2562ea1a28286505d0:1509958493:efb4e12265ca7e4fc8fc726a9feb90bc\";}::Q:T|s:0:\"\";:QT:open:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}:Q:tickets|C:8:\"QuerySet\":4911:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":986:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"ticket_id__in\";C:8:\"QuerySet\":912:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":64:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"status__state\";s:4:\"open\";}}}i:1;C:1:\"Q\":317:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":267:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{i:0;C:1:\"Q\":132:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:13:\"status__state\";s:4:\"open\";i:0;C:1:\"Q\":51:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{s:8:\"staff_id\";i:1;}}}}}}s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:1:{i:0;s:9:\"ticket_id\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:3;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}}}}s:16:\"path_constraints\";a:1:{s:4:\"lock\";a:1:{i:0;C:1:\"Q\":131:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:16:\"lock__expire__gt\";O:11:\"SqlFunction\":3:{s:5:\"alias\";N;s:4:\"func\";s:3:\"NOW\";s:4:\"args\";a:0:{}}}}}}}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:23:{s:14:\"lock__staff_id\";s:14:\"lock__staff_id\";s:8:\"staff_id\";s:8:\"staff_id\";s:9:\"isoverdue\";s:9:\"isoverdue\";s:7:\"team_id\";s:7:\"team_id\";s:12:\"last_duedate\";s:12:\"last_duedate\";s:9:\"ticket_id\";s:9:\"ticket_id\";s:6:\"number\";s:6:\"number\";s:14:\"cdata__subject\";s:14:\"cdata__subject\";s:28:\"user__default_email__address\";s:28:\"user__default_email__address\";s:6:\"source\";s:6:\"source\";s:32:\"cdata__:priority__priority_color\";s:32:\"cdata__:priority__priority_color\";s:31:\"cdata__:priority__priority_desc\";s:31:\"cdata__:priority__priority_desc\";s:9:\"status_id\";s:9:\"status_id\";s:12:\"status__name\";s:12:\"status__name\";s:13:\"status__state\";s:13:\"status__state\";s:7:\"dept_id\";s:7:\"dept_id\";s:10:\"dept__name\";s:10:\"dept__name\";s:10:\"user__name\";s:10:\"user__name\";s:10:\"lastupdate\";s:10:\"lastupdate\";s:10:\"isanswered\";s:10:\"isanswered\";s:16:\"staff__firstname\";s:16:\"staff__firstname\";s:15:\"staff__lastname\";s:15:\"staff__lastname\";s:10:\"team__name\";s:10:\"team__name\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:3:{s:12:\"collab_count\";C:8:\"QuerySet\":672:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:17:\"collaborators__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:16:\"attachment_count\";C:8:\"QuerySet\":768:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":72:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:28:\"entries__attachments__inline\";i:0;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:24:\"entries__attachments__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:12:\"thread_count\";C:8:\"QuerySet\":749:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":66:{a:3:{i:0;i:1;i:1;i:0;i:2;a:1:{s:22:\"entries__flags__hasbit\";i:4;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:11:\"entries__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}lastcroncall|i:1509958344;::Q:A|s:4:\"open\";:QA::sort|a:2:{i:0;s:7:\"created\";i:1;i:0;}:Q:tasks|C:8:\"QuerySet\":2240:{a:16:{s:5:\"model\";s:4:\"Task\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":106:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{i:0;C:1:\"Q\":57:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"flags__hasbit\";i:1;}}}}}}i:1;C:1:\"Q\":260:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{i:0;C:1:\"Q\":76:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:13:\"flags__hasbit\";i:1;s:8:\"staff_id\";i:1;}}}i:1;C:1:\"Q\":117:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:1:{i:0;s:8:\"-created\";}s:7:\"related\";b:0;s:6:\"values\";a:11:{s:2:\"id\";s:2:\"id\";s:6:\"number\";s:6:\"number\";s:7:\"created\";s:7:\"created\";s:8:\"staff_id\";s:8:\"staff_id\";s:7:\"team_id\";s:7:\"team_id\";s:16:\"staff__firstname\";s:16:\"staff__firstname\";s:15:\"staff__lastname\";s:15:\"staff__lastname\";s:10:\"team__name\";s:10:\"team__name\";s:10:\"dept__name\";s:10:\"dept__name\";s:12:\"cdata__title\";s:12:\"cdata__title\";s:5:\"flags\";s:5:\"flags\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:3:{s:12:\"collab_count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:21:\"thread__collaborators\";s:8:\"distinct\";b:1;s:10:\"constraint\";b:0;s:5:\"alias\";s:12:\"collab_count\";}s:16:\"attachment_count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";O:7:\"SqlCase\":5:{s:5:\"cases\";a:1:{i:0;a:2:{i:0;O:8:\"SqlField\":3:{s:5:\"level\";i:0;s:5:\"alias\";N;s:5:\"field\";s:36:\"thread__entries__attachments__inline\";}i:1;N;}}s:4:\"else\";O:8:\"SqlField\":3:{s:5:\"level\";i:0;s:5:\"alias\";N;s:5:\"field\";s:28:\"thread__entries__attachments\";}s:5:\"alias\";N;s:4:\"func\";s:4:\"CASE\";s:4:\"args\";a:0:{}}s:8:\"distinct\";b:1;s:10:\"constraint\";b:0;s:5:\"alias\";s:16:\"attachment_count\";}s:12:\"thread_count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";O:7:\"SqlCase\":5:{s:5:\"cases\";a:1:{i:0;a:2:{i:0;C:1:\"Q\":74:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:30:\"thread__entries__flags__hasbit\";i:4;}}}i:1;N;}}s:4:\"else\";O:8:\"SqlField\":3:{s:5:\"level\";i:0;s:5:\"alias\";N;s:5:\"field\";s:19:\"thread__entries__id\";}s:5:\"alias\";N;s:4:\"func\";s:4:\"CASE\";s:4:\"args\";a:0:{}}s:8:\"distinct\";b:1;s:10:\"constraint\";b:0;s:5:\"alias\";s:12:\"thread_count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}:QA:open:sort|a:2:{i:0;s:7:\"created\";i:1;i:0;}','2017-11-07 09:54:59',NULL,'1','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('tjnejcu1i4ed7anicactla5gt5','csrf|a:2:{s:5:\"token\";s:40:\"28904bafc0acede2bd653371dcb6d94551c15cd8\";s:4:\"time\";i:1509969505;}_auth|a:1:{s:5:\"staff\";a:2:{s:2:\"id\";i:1;s:3:\"key\";s:12:\"local:carlos\";}}:token|a:1:{s:5:\"staff\";s:76:\"354dcfbc9c9b3afa5b3ac2687705d8dd:1509969498:efb4e12265ca7e4fc8fc726a9feb90bc\";}::Q:T|s:0:\"\";:QT:open:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}:Q:tickets|C:8:\"QuerySet\":4911:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":986:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"ticket_id__in\";C:8:\"QuerySet\":912:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":64:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"status__state\";s:4:\"open\";}}}i:1;C:1:\"Q\":317:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":267:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{i:0;C:1:\"Q\":132:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:13:\"status__state\";s:4:\"open\";i:0;C:1:\"Q\":51:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{s:8:\"staff_id\";i:1;}}}}}}s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:1:{i:0;s:9:\"ticket_id\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:3;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}}}}s:16:\"path_constraints\";a:1:{s:4:\"lock\";a:1:{i:0;C:1:\"Q\":131:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:16:\"lock__expire__gt\";O:11:\"SqlFunction\":3:{s:5:\"alias\";N;s:4:\"func\";s:3:\"NOW\";s:4:\"args\";a:0:{}}}}}}}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:23:{s:14:\"lock__staff_id\";s:14:\"lock__staff_id\";s:8:\"staff_id\";s:8:\"staff_id\";s:9:\"isoverdue\";s:9:\"isoverdue\";s:7:\"team_id\";s:7:\"team_id\";s:12:\"last_duedate\";s:12:\"last_duedate\";s:9:\"ticket_id\";s:9:\"ticket_id\";s:6:\"number\";s:6:\"number\";s:14:\"cdata__subject\";s:14:\"cdata__subject\";s:28:\"user__default_email__address\";s:28:\"user__default_email__address\";s:6:\"source\";s:6:\"source\";s:32:\"cdata__:priority__priority_color\";s:32:\"cdata__:priority__priority_color\";s:31:\"cdata__:priority__priority_desc\";s:31:\"cdata__:priority__priority_desc\";s:9:\"status_id\";s:9:\"status_id\";s:12:\"status__name\";s:12:\"status__name\";s:13:\"status__state\";s:13:\"status__state\";s:7:\"dept_id\";s:7:\"dept_id\";s:10:\"dept__name\";s:10:\"dept__name\";s:10:\"user__name\";s:10:\"user__name\";s:10:\"lastupdate\";s:10:\"lastupdate\";s:10:\"isanswered\";s:10:\"isanswered\";s:16:\"staff__firstname\";s:16:\"staff__firstname\";s:15:\"staff__lastname\";s:15:\"staff__lastname\";s:10:\"team__name\";s:10:\"team__name\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:3:{s:12:\"collab_count\";C:8:\"QuerySet\":672:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:17:\"collaborators__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:16:\"attachment_count\";C:8:\"QuerySet\":768:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":72:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:28:\"entries__attachments__inline\";i:0;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:24:\"entries__attachments__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:12:\"thread_count\";C:8:\"QuerySet\":749:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":66:{a:3:{i:0;i:1;i:1;i:0;i:2;a:1:{s:22:\"entries__flags__hasbit\";i:4;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:11:\"entries__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}lastcroncall|i:1509969383;cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}','2017-11-07 12:58:25',NULL,'1','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('v24fr8ie7pje3s7u82e93epfv5','csrf|a:2:{s:5:\"token\";s:40:\"913f0e627e91961db2f71221aeb359e51e1ecf33\";s:4:\"time\";i:1510043206;}_client|a:1:{s:4:\"auth\";a:1:{s:4:\"dest\";s:17:\"/tickets.php?id=1\";}}_auth|a:1:{s:4:\"user\";a:2:{s:2:\"id\";i:8;s:3:\"key\";s:8:\"client:8\";}}:token|a:1:{s:6:\"client\";s:76:\"932388b4857a8b157ab933b3f21ce5c6:1510043186:efb4e12265ca7e4fc8fc726a9feb90bc\";}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}','2017-11-08 09:26:46',NULL,'0','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('v92vev3gcto86602sv5jpv8d54','csrf|a:2:{s:5:\"token\";s:40:\"594d4507396681dbaec08fd590935503d956af38\";s:4:\"time\";i:1510140920;}_auth|a:1:{s:5:\"staff\";a:2:{s:2:\"id\";i:8;s:3:\"key\";s:10:\"local:pepe\";}}:token|a:1:{s:5:\"staff\";s:76:\"e1233d8ff84b01251a0bb8a12a1ed38b:1510140913:efb4e12265ca7e4fc8fc726a9feb90bc\";}::Q:T|s:6:\"solved\";:QT:open:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}:Q:tickets|C:8:\"QuerySet\":4865:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":940:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"ticket_id__in\";C:8:\"QuerySet\":866:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":66:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"status__state\";s:6:\"solved\";}}}i:1;C:1:\"Q\":269:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":219:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{i:0;C:1:\"Q\":132:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:13:\"status__state\";s:4:\"open\";i:0;C:1:\"Q\":51:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{s:8:\"staff_id\";i:8;}}}}}}s:11:\"dept_id__in\";a:1:{i:0;s:1:\"7\";}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:1:{i:0;s:9:\"ticket_id\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:3;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}}}}s:16:\"path_constraints\";a:1:{s:4:\"lock\";a:1:{i:0;C:1:\"Q\":131:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:16:\"lock__expire__gt\";O:11:\"SqlFunction\":3:{s:5:\"alias\";N;s:4:\"func\";s:3:\"NOW\";s:4:\"args\";a:0:{}}}}}}}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:23:{s:14:\"lock__staff_id\";s:14:\"lock__staff_id\";s:8:\"staff_id\";s:8:\"staff_id\";s:9:\"isoverdue\";s:9:\"isoverdue\";s:7:\"team_id\";s:7:\"team_id\";s:12:\"last_duedate\";s:12:\"last_duedate\";s:9:\"ticket_id\";s:9:\"ticket_id\";s:6:\"number\";s:6:\"number\";s:14:\"cdata__subject\";s:14:\"cdata__subject\";s:28:\"user__default_email__address\";s:28:\"user__default_email__address\";s:6:\"source\";s:6:\"source\";s:32:\"cdata__:priority__priority_color\";s:32:\"cdata__:priority__priority_color\";s:31:\"cdata__:priority__priority_desc\";s:31:\"cdata__:priority__priority_desc\";s:9:\"status_id\";s:9:\"status_id\";s:12:\"status__name\";s:12:\"status__name\";s:13:\"status__state\";s:13:\"status__state\";s:7:\"dept_id\";s:7:\"dept_id\";s:10:\"dept__name\";s:10:\"dept__name\";s:10:\"user__name\";s:10:\"user__name\";s:10:\"lastupdate\";s:10:\"lastupdate\";s:10:\"isanswered\";s:10:\"isanswered\";s:16:\"staff__firstname\";s:16:\"staff__firstname\";s:15:\"staff__lastname\";s:15:\"staff__lastname\";s:10:\"team__name\";s:10:\"team__name\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:3:{s:12:\"collab_count\";C:8:\"QuerySet\":672:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:17:\"collaborators__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:16:\"attachment_count\";C:8:\"QuerySet\":768:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":72:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:28:\"entries__attachments__inline\";i:0;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:24:\"entries__attachments__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:12:\"thread_count\";C:8:\"QuerySet\":749:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":66:{a:3:{i:0;i:1;i:1;i:0;i:2;a:1:{s:22:\"entries__flags__hasbit\";i:4;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:11:\"entries__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}lastcroncall|i:1510140914;:QT:solved:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}','2017-11-09 12:35:20',NULL,'8','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('vnkbnlhecsovsbremrjsikgtg0','csrf|a:2:{s:5:\"token\";s:40:\"3d3fbf5b5fa3bb8fdffd83d62d6ffd5ed5fec92d\";s:4:\"time\";i:1509951091;}_auth|a:1:{s:5:\"staff\";a:2:{s:2:\"id\";i:1;s:3:\"key\";s:12:\"local:carlos\";}}:token|a:1:{s:5:\"staff\";s:76:\"df7cec664c4aed3b63ea7d773e4c1af7:1509951091:efb4e12265ca7e4fc8fc726a9feb90bc\";}::Q:T|s:4:\"open\";:QT:open:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}:Q:tickets|C:8:\"QuerySet\":4911:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":986:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"ticket_id__in\";C:8:\"QuerySet\":912:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":64:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"status__state\";s:4:\"open\";}}}i:1;C:1:\"Q\":317:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":267:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{i:0;C:1:\"Q\":132:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:13:\"status__state\";s:4:\"open\";i:0;C:1:\"Q\":51:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{s:8:\"staff_id\";i:1;}}}}}}s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:1:{i:0;s:9:\"ticket_id\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:3;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}}}}s:16:\"path_constraints\";a:1:{s:4:\"lock\";a:1:{i:0;C:1:\"Q\":131:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:16:\"lock__expire__gt\";O:11:\"SqlFunction\":3:{s:5:\"alias\";N;s:4:\"func\";s:3:\"NOW\";s:4:\"args\";a:0:{}}}}}}}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:23:{s:14:\"lock__staff_id\";s:14:\"lock__staff_id\";s:8:\"staff_id\";s:8:\"staff_id\";s:9:\"isoverdue\";s:9:\"isoverdue\";s:7:\"team_id\";s:7:\"team_id\";s:12:\"last_duedate\";s:12:\"last_duedate\";s:9:\"ticket_id\";s:9:\"ticket_id\";s:6:\"number\";s:6:\"number\";s:14:\"cdata__subject\";s:14:\"cdata__subject\";s:28:\"user__default_email__address\";s:28:\"user__default_email__address\";s:6:\"source\";s:6:\"source\";s:32:\"cdata__:priority__priority_color\";s:32:\"cdata__:priority__priority_color\";s:31:\"cdata__:priority__priority_desc\";s:31:\"cdata__:priority__priority_desc\";s:9:\"status_id\";s:9:\"status_id\";s:12:\"status__name\";s:12:\"status__name\";s:13:\"status__state\";s:13:\"status__state\";s:7:\"dept_id\";s:7:\"dept_id\";s:10:\"dept__name\";s:10:\"dept__name\";s:10:\"user__name\";s:10:\"user__name\";s:10:\"lastupdate\";s:10:\"lastupdate\";s:10:\"isanswered\";s:10:\"isanswered\";s:16:\"staff__firstname\";s:16:\"staff__firstname\";s:15:\"staff__lastname\";s:15:\"staff__lastname\";s:10:\"team__name\";s:10:\"team__name\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:3:{s:12:\"collab_count\";C:8:\"QuerySet\":672:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:17:\"collaborators__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:16:\"attachment_count\";C:8:\"QuerySet\":768:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":72:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:28:\"entries__attachments__inline\";i:0;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:24:\"entries__attachments__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:12:\"thread_count\";C:8:\"QuerySet\":749:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":66:{a:3:{i:0;i:1;i:1;i:0;i:2;a:1:{s:22:\"entries__flags__hasbit\";i:4;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:11:\"entries__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}lastcroncall|i:1509951043;','2017-11-07 07:51:31',NULL,'1','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0'),('vq60k0kijo60inet17jdkp37a1','csrf|a:2:{s:5:\"token\";s:40:\"d183cf7f707678905cea267c8c3d0d55dcfba64a\";s:4:\"time\";i:1510131093;}_auth|a:1:{s:5:\"staff\";a:2:{s:2:\"id\";i:1;s:3:\"key\";s:12:\"local:carlos\";}}:token|a:1:{s:5:\"staff\";s:76:\"a2dbdb3fa6184827e079205222bd4612:1510131092:efb4e12265ca7e4fc8fc726a9feb90bc\";}::Q:T|s:4:\"open\";:QT:open:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}:Q:tickets|C:8:\"QuerySet\":4911:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":986:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"ticket_id__in\";C:8:\"QuerySet\":912:{a:16:{s:5:\"model\";s:11:\"TicketModel\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":64:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"status__state\";s:4:\"open\";}}}i:1;C:1:\"Q\":317:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":267:{a:3:{i:0;i:0;i:1;i:2;i:2;a:2:{i:0;C:1:\"Q\":132:{a:3:{i:0;i:0;i:1;i:0;i:2;a:2:{s:13:\"status__state\";s:4:\"open\";i:0;C:1:\"Q\":51:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{s:8:\"staff_id\";i:1;}}}}}}s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:1:{i:0;s:9:\"ticket_id\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:3;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}}}}s:16:\"path_constraints\";a:1:{s:4:\"lock\";a:1:{i:0;C:1:\"Q\":131:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:16:\"lock__expire__gt\";O:11:\"SqlFunction\":3:{s:5:\"alias\";N;s:4:\"func\";s:3:\"NOW\";s:4:\"args\";a:0:{}}}}}}}s:8:\"ordering\";a:2:{i:0;a:2:{i:0;s:34:\"cdata__:priority__priority_urgency\";i:1;s:3:\"ASC\";}i:1;a:2:{i:0;s:10:\"lastupdate\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:23:{s:14:\"lock__staff_id\";s:14:\"lock__staff_id\";s:8:\"staff_id\";s:8:\"staff_id\";s:9:\"isoverdue\";s:9:\"isoverdue\";s:7:\"team_id\";s:7:\"team_id\";s:12:\"last_duedate\";s:12:\"last_duedate\";s:9:\"ticket_id\";s:9:\"ticket_id\";s:6:\"number\";s:6:\"number\";s:14:\"cdata__subject\";s:14:\"cdata__subject\";s:28:\"user__default_email__address\";s:28:\"user__default_email__address\";s:6:\"source\";s:6:\"source\";s:32:\"cdata__:priority__priority_color\";s:32:\"cdata__:priority__priority_color\";s:31:\"cdata__:priority__priority_desc\";s:31:\"cdata__:priority__priority_desc\";s:9:\"status_id\";s:9:\"status_id\";s:12:\"status__name\";s:12:\"status__name\";s:13:\"status__state\";s:13:\"status__state\";s:7:\"dept_id\";s:7:\"dept_id\";s:10:\"dept__name\";s:10:\"dept__name\";s:10:\"user__name\";s:10:\"user__name\";s:10:\"lastupdate\";s:10:\"lastupdate\";s:10:\"isanswered\";s:10:\"isanswered\";s:16:\"staff__firstname\";s:16:\"staff__firstname\";s:15:\"staff__lastname\";s:15:\"staff__lastname\";s:10:\"team__name\";s:10:\"team__name\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:3:{s:12:\"collab_count\";C:8:\"QuerySet\":672:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:17:\"collaborators__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:16:\"attachment_count\";C:8:\"QuerySet\":768:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":72:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:28:\"entries__attachments__inline\";i:0;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:24:\"entries__attachments__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}s:12:\"thread_count\";C:8:\"QuerySet\":749:{a:16:{s:5:\"model\";s:12:\"TicketThread\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":134:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:17:\"ticket__ticket_id\";O:8:\"SqlField\":3:{s:5:\"level\";i:1;s:5:\"alias\";N;s:5:\"field\";s:9:\"ticket_id\";}}}}i:1;C:1:\"Q\":66:{a:3:{i:0;i:1;i:1;i:0;i:2;a:1:{s:22:\"entries__flags__hasbit\";i:4;}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:0:{}s:7:\"related\";b:0;s:6:\"values\";a:0:{}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:1;s:11:\"annotations\";a:1:{s:5:\"count\";O:12:\"SqlAggregate\":5:{s:4:\"func\";s:5:\"COUNT\";s:4:\"expr\";s:11:\"entries__id\";s:8:\"distinct\";b:0;s:10:\"constraint\";b:0;s:5:\"alias\";s:5:\"count\";}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}cfg:core|a:1:{s:11:\"db_timezone\";s:13:\"Europe/Berlin\";}lastcroncall|i:1510130367;::Q:E|s:0:\"\";:QE::sort|a:2:{i:0;s:10:\"activation\";i:1;i:0;}:Q:equipments|C:8:\"QuerySet\":1736:{a:16:{s:5:\"model\";s:14:\"EquipmentModel\";s:11:\"constraints\";a:1:{i:0;C:1:\"Q\":806:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:6:\"id__in\";C:8:\"QuerySet\":740:{a:16:{s:5:\"model\";s:14:\"EquipmentModel\";s:11:\"constraints\";a:2:{i:0;C:1:\"Q\":66:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:13:\"status__state\";s:6:\"active\";}}}i:1;C:1:\"Q\":217:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":167:{a:3:{i:0;i:0;i:1;i:2;i:2;a:1:{i:0;C:1:\"Q\":117:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:11:\"dept_id__in\";a:5:{i:0;s:1:\"4\";i:1;s:1:\"5\";i:2;s:1:\"6\";i:3;s:1:\"7\";i:4;s:1:\"8\";}}}}}}}}}}}s:16:\"path_constraints\";a:0:{}s:8:\"ordering\";a:1:{i:0;a:2:{i:0;s:10:\"activation\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:1:{i:0;s:2:\"id\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:3;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}}}}}s:16:\"path_constraints\";a:1:{s:4:\"lock\";a:1:{i:0;C:1:\"Q\":131:{a:3:{i:0;i:0;i:1;i:0;i:2;a:1:{s:16:\"lock__expire__gt\";O:11:\"SqlFunction\":3:{s:5:\"alias\";N;s:4:\"func\";s:3:\"NOW\";s:4:\"args\";a:0:{}}}}}}}s:8:\"ordering\";a:1:{i:0;a:2:{i:0;s:10:\"activation\";i:1;s:4:\"DESC\";}}s:7:\"related\";b:0;s:6:\"values\";a:10:{s:10:\"activation\";s:10:\"activation\";s:14:\"lock__staff_id\";s:14:\"lock__staff_id\";s:2:\"id\";s:2:\"id\";s:4:\"name\";s:4:\"name\";s:11:\"description\";s:11:\"description\";s:9:\"status_id\";s:9:\"status_id\";s:12:\"status__name\";s:12:\"status__name\";s:13:\"status__state\";s:13:\"status__state\";s:7:\"updated\";s:7:\"updated\";s:10:\"dept__name\";s:10:\"dept__name\";}s:5:\"defer\";a:0:{}s:10:\"aggregated\";b:0;s:11:\"annotations\";a:0:{}s:5:\"extra\";a:0:{}s:8:\"distinct\";a:0:{}s:4:\"lock\";b:0;s:5:\"chain\";a:0:{}s:7:\"options\";a:0:{}s:4:\"iter\";i:2;s:8:\"compiler\";s:13:\"MySqlCompiler\";}}:QT:solved:sort|a:2:{i:0;s:16:\"priority,updated\";i:1;i:0;}','2017-11-09 09:51:33',NULL,'1','172.22.15.53','Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:56.0) Gecko/20100101 Firefox/56.0');
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
  `alert_staff` varchar(12) DEFAULT NULL,
  `next_sla` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_sla`
--

LOCK TABLES `ost_sla` WRITE;
/*!40000 ALTER TABLE `ost_sla` DISABLE KEYS */;
INSERT INTO `ost_sla` VALUES (4,1,3,'Urgente (72h)',NULL,'2017-11-06 12:00:30','2017-11-06 15:12:13','t1',11),(5,1,2,'Urgente (48h)',NULL,'2017-11-06 12:01:15','2017-11-06 15:12:08','t1',11),(9,1,7,'Semana',NULL,'2017-11-06 14:38:46','2017-11-06 15:11:25','t1',10),(10,1,7,'Semana extra',NULL,'2017-11-06 14:38:59','2017-11-06 15:11:52','s2',0),(11,1,1,'24 horas extra',NULL,'2017-11-06 14:39:17','2017-11-06 15:11:43','s2',0),(12,1,15,'15 días extra',NULL,'2017-11-06 14:39:45','2017-11-06 15:11:38','s2',0),(13,1,30,'Mes',NULL,'2017-11-06 14:40:19','2017-11-06 15:09:56','t1',12),(14,1,90,'Tres meses',NULL,'2017-11-06 14:40:45','2017-11-06 15:12:01','t1',12);
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
INSERT INTO `ost_staff` VALUES (1,4,1,'carlos','Carlos','Núñez','$2a$08$Yz1e7fueJl/g51dIcB/d0e3y12fZbp98v4VRcfEFjReMdAFtWlbDe',NULL,'carlos.nunez@juntaex.es','',NULL,'','',NULL,NULL,'',NULL,1,1,0,0,0,0,0,25,0,'none','Letter','{\"browser_lang\":\"es_ES\",\"def_assn_role\":true}','{\"user.create\":1,\"user.edit\":1,\"user.delete\":1,\"user.manage\":1,\"user.dir\":1,\"org.create\":1,\"org.edit\":1,\"org.delete\":1,\"faq.manage\":1,\"emails.banlist\":1}','2017-08-01 12:23:25','2017-11-13 08:49:16','2017-08-01 14:31:46','2017-11-13 08:49:16'),(2,5,3,'antonio','Antonio','Baeza','$2a$08$1RVtwsax8Yr2KcRyne4KH.0yHQz1hCgNUImjBSSQS4uc8RU/bnaSq',NULL,'tritium@juntaex.es','',NULL,'','',NULL,NULL,NULL,NULL,1,0,0,0,0,0,0,0,0,'none','Letter','{\"def_assn_role\":true,\"browser_lang\":\"es_ES\"}','{\"user.create\":1,\"user.edit\":1,\"user.delete\":1,\"user.manage\":1,\"user.dir\":1,\"org.create\":1,\"org.edit\":1,\"org.delete\":1,\"faq.manage\":1}','2017-08-01 14:41:42','2017-09-07 08:43:58','2017-08-02 11:13:33','2017-10-25 09:11:44'),(3,7,2,'david','David','Valencia','$2a$08$A65NrS.FK1SDU147/Tj55.infi5REYgzEkXwNLLvrgKbVDq4ZKKQ2',NULL,'ratvapc@gmail.com','',NULL,'','',NULL,NULL,NULL,NULL,1,0,0,0,0,0,0,0,0,'none','Letter','{\"def_assn_role\":true,\"browser_lang\":\"es_ES\"}','{\"user.create\":1,\"user.edit\":1,\"user.delete\":1,\"user.manage\":1,\"user.dir\":1,\"org.create\":1,\"org.edit\":1,\"org.delete\":1,\"faq.manage\":1}','2017-08-01 14:42:50','2017-11-13 08:26:46','2017-08-02 11:14:22','2017-11-13 08:26:46'),(4,8,2,'jose','José Ángel','Corbacho','$2a$08$QnZ7rGCByMbKMBQiXVaukegi8KLAvXo8wG3P.gY8gPOfZpUfFJwkG',NULL,'rat_va_pc@juntaex.es','',NULL,'','',NULL,NULL,NULL,NULL,1,0,1,0,0,0,0,0,0,'none','Letter','{\"def_assn_role\":true,\"browser_lang\":\"es_ES\"}','{\"user.create\":1,\"user.edit\":1,\"user.delete\":1,\"user.manage\":1,\"user.dir\":1,\"org.create\":1,\"org.edit\":1,\"org.delete\":1,\"faq.manage\":1}','2017-08-01 14:43:38','2017-10-31 14:03:13','2017-08-02 11:13:11','2017-10-31 14:03:13'),(5,7,2,'juan','Juan','Baeza','$2a$08$0oAuiWbbDSayt7KEORpnYuerUZouOChxNaXCJnzoMq5f8WPksSPB2',NULL,'juanbaeza@laruex.es','',NULL,'','',NULL,NULL,NULL,NULL,1,0,0,0,0,0,0,0,0,'none','Letter','{\"def_assn_role\":true,\"browser_lang\":\"es_ES\"}','{\"user.create\":1,\"user.edit\":1,\"user.delete\":1,\"user.manage\":1,\"user.dir\":1,\"org.create\":1,\"org.edit\":1,\"org.delete\":1,\"faq.manage\":1}','2017-08-01 14:44:53','2017-11-10 13:14:57','2017-08-03 14:00:26','2017-11-10 13:14:57'),(6,8,2,'manolo','José Manuel','Caballero',NULL,NULL,'manolo@laruex.es','',NULL,'','',NULL,NULL,NULL,NULL,1,0,0,0,0,0,0,0,0,'none','Letter','{\"def_assn_role\":true}','{\"user.create\":1,\"user.edit\":1,\"user.delete\":1,\"user.manage\":1,\"user.dir\":1,\"org.create\":1,\"org.edit\":1,\"org.delete\":1,\"faq.manage\":1}','2017-08-01 14:45:48',NULL,NULL,'2017-08-02 08:27:55'),(7,6,1,'angeles','Mª Ángeles','Ontalba','$2a$08$tIh8tt6Ss4k8ZnGrtTPfg.2MFcYHaRinCLLf4w5V8ZQcEyxMeDwSu',NULL,'eco2cir@gmail.com','',NULL,'','',NULL,NULL,NULL,NULL,1,0,0,0,0,0,0,0,0,'none','Letter','{\"def_assn_role\":true,\"browser_lang\":\"es_ES\"}','{\"user.create\":1,\"user.edit\":1,\"user.delete\":1,\"user.manage\":1,\"user.dir\":1,\"org.create\":1,\"org.edit\":1,\"org.delete\":1,\"faq.manage\":1}','2017-08-01 14:46:53','2017-11-13 08:31:00','2017-10-11 13:49:50','2017-11-13 08:31:00'),(8,7,2,'pepe','José','Vasco','$2a$08$kc8tsvzqiKnIIB12mnFzi.EbMYsvq24P8GRtJPDV7mzlxfczV07IW',NULL,'eco2cir@juntaex.es','',NULL,'','',NULL,NULL,NULL,NULL,1,0,0,0,0,0,0,0,0,'none','Letter','{\"def_assn_role\":true,\"browser_lang\":\"es_ES\"}','{\"user.create\":1,\"user.edit\":1,\"user.delete\":1,\"user.manage\":1,\"user.dir\":1,\"org.create\":1,\"org.edit\":1,\"org.delete\":1,\"faq.manage\":1}','2017-08-01 14:47:40','2017-11-13 08:08:40','2017-08-02 11:38:55','2017-11-13 08:08:40');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_task`
--

LOCK TABLES `ost_task` WRITE;
/*!40000 ALTER TABLE `ost_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_task__cdata`
--

DROP TABLE IF EXISTS `ost_task__cdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_task__cdata` (
  `task_id` int(11) unsigned NOT NULL,
  `title` mediumtext,
  `localizacion` mediumtext,
  PRIMARY KEY (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_task__cdata`
--

LOCK TABLES `ost_task__cdata` WRITE;
/*!40000 ALTER TABLE `ost_task__cdata` DISABLE KEYS */;
INSERT INTO `ost_task__cdata` VALUES (1,'Prueba de tarea normal','12'),(2,'Nueva tarea','11'),(3,'Nueva tarea programada','10'),(11,'Tarea asignada a equipo','10'),(12,'Programación de tareas asignada a calidad','11'),(13,'Programación de tareas asignada a calidad','11'),(14,'Programación de tareas asignada a calidad','11');
/*!40000 ALTER TABLE `ost_task__cdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ost_task_schedule`
--

DROP TABLE IF EXISTS `ost_task_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ost_task_schedule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `regularity` enum('Anual','Semestral','Cuatrimestral','Trimestral','Bimensual','Mensual','Quincenal','Semanal') NOT NULL,
  `period` tinyint(3) unsigned NOT NULL,
  `start` datetime NOT NULL,
  `department_id` int(11) unsigned NOT NULL,
  `staff_id` int(11) unsigned DEFAULT NULL,
  `team_id` int(10) unsigned DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  `last_created_task` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `department_id` (`department_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `ost_task_schedule_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `ost_department` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `ost_task_schedule_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `ost_staff` (`staff_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_task_schedule`
--

LOCK TABLES `ost_task_schedule` WRITE;
/*!40000 ALTER TABLE `ost_task_schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `ost_task_schedule` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_team`
--

LOCK TABLES `ost_team` WRITE;
/*!40000 ALTER TABLE `ost_team` DISABLE KEYS */;
INSERT INTO `ost_team` VALUES (1,7,1,'Calidad',NULL,'2017-10-23 12:35:49','2017-10-23 12:35:57'),(2,0,1,'Laboratorio Móvil',NULL,'2017-11-06 10:58:50','2017-11-06 10:58:50');
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
INSERT INTO `ost_team_member` VALUES (1,3,1),(1,7,1),(2,4,1),(2,5,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8;
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
  `state` enum('created','closed','reopened','assigned','transferred','overdue','edited','viewed','error','collab','resent','equipment_edition','equipment_retirement','retired','reserved','unreserved','verified') NOT NULL,
  `data` varchar(1024) DEFAULT NULL COMMENT 'Encoded differences',
  `username` varchar(128) NOT NULL DEFAULT 'SYSTEM',
  `uid` int(11) unsigned DEFAULT NULL,
  `uid_type` char(1) NOT NULL DEFAULT 'S',
  `annulled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_state` (`thread_id`,`state`,`timestamp`),
  KEY `ticket_stats` (`timestamp`,`state`)
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_thread_event`
--

LOCK TABLES `ost_thread_event` WRITE;
/*!40000 ALTER TABLE `ost_thread_event` DISABLE KEYS */;
INSERT INTO `ost_thread_event` VALUES (102,0,0,0,0,0,'created',NULL,'carlos',1,'S',0,'2017-11-03 13:46:19'),(103,0,0,0,0,0,'assigned','{\"team\":1}','carlos',1,'S',0,'2017-11-03 13:46:19'),(104,0,0,0,0,0,'created',NULL,'carlos',1,'S',0,'2017-11-03 13:47:04'),(105,0,0,0,0,0,'assigned','{\"team\":1}','carlos',1,'S',0,'2017-11-03 13:47:04'),(106,0,0,0,0,0,'created',NULL,'SYSTEM',NULL,'S',0,'2017-11-06 07:50:44'),(107,0,0,0,0,0,'created',NULL,'SYSTEM',NULL,'S',0,'2017-11-06 09:19:01'),(108,0,0,0,0,0,'created',NULL,'SYSTEM',NULL,'S',0,'2017-11-06 09:30:10'),(109,0,0,0,0,0,'assigned','{\"claim\":true}','carlos',1,'S',0,'2017-11-06 10:56:35'),(110,0,0,0,0,0,'assigned','{\"team\":2}','carlos',1,'S',0,'2017-11-06 10:59:28'),(111,0,0,0,0,0,'assigned','{\"team\":1}','carlos',1,'S',0,'2017-11-06 10:59:58'),(112,0,0,0,0,0,'assigned','{\"team\":2}','carlos',1,'S',0,'2017-11-06 11:06:02'),(113,0,0,0,6,13,'created',NULL,'José Vasco',8,'U',0,'2017-11-07 08:13:27'),(114,0,3,0,6,13,'assigned','{\"staff\":3}','eco2cir@juntaex.es',NULL,'S',0,'2017-11-07 08:13:29'),(115,0,0,0,6,13,'created',NULL,'José Vasco',8,'U',0,'2017-11-07 09:26:24'),(116,0,3,0,6,13,'assigned','{\"staff\":3}','eco2cir@juntaex.es',NULL,'S',0,'2017-11-07 09:26:26'),(117,0,0,0,6,13,'created',NULL,'José Vasco',8,'U',0,'2017-11-07 09:41:17'),(118,0,3,0,6,13,'assigned','{\"staff\":3}','eco2cir@juntaex.es',NULL,'S',0,'2017-11-07 09:41:18'),(119,0,0,0,6,13,'created',NULL,'José Vasco',8,'U',0,'2017-11-07 09:43:35'),(120,0,3,0,6,13,'assigned','{\"staff\":3}','eco2cir@juntaex.es',NULL,'S',0,'2017-11-07 09:43:36'),(121,0,0,0,6,13,'created',NULL,'José Vasco',8,'U',0,'2017-11-07 09:48:25'),(122,0,3,0,6,13,'assigned','{\"staff\":3}','eco2cir@juntaex.es',NULL,'S',0,'2017-11-07 09:48:27'),(123,0,0,0,6,13,'created',NULL,'José Vasco',8,'U',0,'2017-11-07 11:36:30'),(124,0,0,1,6,13,'assigned','{\"team\":1}','eco2cir@juntaex.es',NULL,'S',0,'2017-11-07 11:36:31'),(125,0,0,0,6,14,'created',NULL,'José Vasco',8,'U',0,'2017-11-07 11:38:23'),(126,0,3,0,6,14,'assigned','{\"staff\":3}','eco2cir@juntaex.es',NULL,'S',0,'2017-11-07 11:38:24'),(127,0,3,0,7,14,'edited','{\"status\":6}','carlos',1,'S',0,'2017-11-07 12:02:07'),(128,0,0,1,6,13,'edited','{\"fields\":{\"43\":[null,\"wsef\"],\"44\":[null,\"sddf\"]}}','carlos',1,'S',0,'2017-11-08 09:06:53'),(129,0,0,1,6,13,'edited','{\"fields\":{\"43\":[\"wsef\",\"\"],\"44\":[\"sddf\",\"\"]}}','carlos',1,'S',0,'2017-11-08 09:11:46'),(130,0,0,0,6,13,'created',NULL,'José Vasco',8,'U',0,'2017-11-08 10:53:48'),(131,0,3,0,6,13,'assigned','{\"staff\":3}','eco2cir@juntaex.es',NULL,'S',0,'2017-11-08 10:53:50'),(132,0,3,0,7,13,'edited','{\"fields\":{\"43\":[null,\"An\\u00e1lisis de causas\"],\"44\":[null,\"Consecuencias\"]}}','pepe',8,'S',0,'2017-11-08 10:55:28'),(133,0,3,0,7,13,'edited','{\"status\":6}','pepe',8,'S',0,'2017-11-08 10:55:43'),(134,0,1,0,7,13,'closed','{\"status\":[3,\"Cerrado\"]}','carlos',1,'S',0,'2017-11-08 10:56:41'),(135,0,1,0,7,13,'',NULL,'carlos',1,'S',0,'2017-11-09 11:52:34'),(136,0,1,0,7,13,'verified',NULL,'carlos',1,'S',0,'2017-11-09 11:58:34'),(137,0,1,0,7,13,'verified',NULL,'carlos',1,'S',0,'2017-11-09 12:00:33'),(138,0,0,0,4,0,'created',NULL,'carlos',1,'S',0,'2017-11-09 13:18:35'),(139,0,0,0,4,0,'equipment_edition','{\"status\":[2,\"Operativo\"]}','carlos',1,'S',0,'2017-11-09 13:18:53'),(140,0,0,0,4,0,'equipment_edition','{\"status\":[3,\"Inoperativo\"]}','carlos',1,'S',0,'2017-11-09 13:19:15'),(141,0,0,0,4,0,'equipment_retirement',NULL,'carlos',1,'S',0,'2017-11-09 13:29:32'),(142,0,0,0,4,0,'created',NULL,'carlos',1,'S',0,'2017-11-09 13:36:21'),(143,0,0,0,4,0,'equipment_edition','{\"status\":[2,\"Operativo\"]}','carlos',1,'S',0,'2017-11-09 14:30:40'),(144,0,0,0,0,0,'created',NULL,'carlos',1,'S',0,'2017-11-09 14:39:14'),(145,0,0,0,0,0,'closed',NULL,'carlos',1,'S',0,'2017-11-09 14:40:17'),(146,0,0,0,0,0,'created',NULL,'carlos',1,'S',0,'2017-11-09 14:40:56'),(147,0,0,0,0,0,'transferred',NULL,'carlos',1,'S',0,'2017-11-09 14:41:14'),(148,0,0,0,0,0,'assigned','{\"staff\":[3,{\"format\":\"full\",\"parts\":{\"first\":\"David\",\"last\":\"Valencia\"},\"name\":\"David Valencia\"}]}','carlos',1,'S',0,'2017-11-09 14:41:32'),(149,0,0,0,0,0,'created',NULL,'carlos',1,'S',0,'2017-11-09 14:48:53'),(150,0,0,0,0,0,'created',NULL,'SYSTEM',NULL,'S',0,'2017-11-10 09:01:04'),(151,0,1,0,7,13,'verified',NULL,'carlos',1,'S',0,'2017-11-10 09:33:06'),(152,0,1,1,6,13,'overdue',NULL,'SYSTEM',NULL,'S',0,'2017-11-10 12:37:28'),(153,0,0,0,6,13,'created',NULL,'Juan Baeza',5,'U',0,'2017-11-10 13:13:45'),(154,0,7,0,6,13,'assigned','{\"staff\":7}','juanbaeza@laruex.es',NULL,'S',0,'2017-11-10 13:13:47'),(155,0,7,0,6,13,'overdue',NULL,'SYSTEM',NULL,'S',0,'2017-11-10 13:22:28'),(156,0,7,0,6,13,'overdue',NULL,'SYSTEM',NULL,'S',0,'2017-11-13 07:46:44'),(157,0,0,0,6,13,'created',NULL,'José Vasco',8,'U',0,'2017-11-13 08:10:43'),(158,0,3,0,6,13,'assigned','{\"staff\":3}','eco2cir@juntaex.es',NULL,'S',0,'2017-11-13 08:10:45'),(159,0,3,0,7,13,'edited','{\"fields\":{\"41\":[3,[{\"format\":\"full\",\"parts\":{\"first\":\"David\",\"last\":\"Valencia\"},\"name\":\"David Valencia\"},3]],\"45\":[\"[]\",\"[2]\"]}}','eco2cir@juntaex.es',NULL,'S',0,'2017-11-13 08:15:59'),(160,0,3,0,7,13,'edited','{\"fields\":{\"43\":[null,\"Causas\"],\"44\":[null,\"Consecuencias\"],\"45\":[\"[2]\",\"[]\"]}}','david',3,'S',0,'2017-11-13 08:28:59'),(161,0,3,0,7,13,'edited','{\"status\":6}','david',3,'S',0,'2017-11-13 08:29:45'),(162,0,3,0,7,13,'edited','{\"fields\":{\"56\":[null,\"Se ha hecho tal y tal\"]}}','angeles',7,'S',0,'2017-11-13 08:31:58'),(163,0,7,0,7,13,'closed','{\"status\":[3,\"Cerrado\"]}','angeles',7,'S',0,'2017-11-13 08:33:00'),(164,0,7,0,7,13,'verified',NULL,'angeles',7,'S',0,'2017-11-13 08:35:39');
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
  `verified` datetime DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
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
  `sla_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`priority_id`),
  UNIQUE KEY `priority` (`priority`),
  KEY `priority_urgency` (`priority_urgency`),
  KEY `ispublic` (`ispublic`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_ticket_priority`
--

LOCK TABLES `ost_ticket_priority` WRITE;
/*!40000 ALTER TABLE `ost_ticket_priority` DISABLE KEYS */;
INSERT INTO `ost_ticket_priority` VALUES (1,'low','Baja','#DDFFDD',4,1,13),(2,'normal','Normal','#FFFFF0',3,1,9),(3,'high','Alta','#FEE7E7',2,1,4);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ost_ticket_status`
--

LOCK TABLES `ost_ticket_status` WRITE;
/*!40000 ALTER TABLE `ost_ticket_status` DISABLE KEYS */;
INSERT INTO `ost_ticket_status` VALUES (1,'Abierto','open',3,0,2,'{\"allowreopen\":true,\"reopenstatus\":0,\"35\":\"Open tickets.\"}','2017-08-01 12:23:25','0000-00-00 00:00:00'),(3,'Cerrado','closed',3,0,3,'{\"allowreopen\":false,\"reopenstatus\":0,\"35\":\"Closed tickets. Tickets will still be accessible on client and staff panels.\"}','2017-08-01 12:23:25','0000-00-00 00:00:00'),(4,'Archivado','archived',3,0,4,'{\"allowreopen\":true,\"reopenstatus\":0,\"35\":\"Tickets only adminstratively available but no longer accessible on ticket queues and client panel.\"}','2017-08-01 12:23:25','0000-00-00 00:00:00'),(5,'Borrado','deleted',3,0,5,'{\"allowreopen\":true,\"reopenstatus\":0,\"35\":\"Tickets queued for deletion. Not accessible on ticket queues.\"}','2017-08-01 12:23:25','0000-00-00 00:00:00'),(6,'Resuelto','solved',1,0,0,'{\"allowreopen\":true,\"reopenstatus\":0,\"35\":\"Ticket resuelto pero a\\u00fan no cerrado.\"}','2017-10-31 08:01:25','0000-00-00 00:00:00');
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
INSERT INTO `ost_user` VALUES (2,0,2,0,'Antonio Baeza','2017-08-02 08:29:32','2017-08-02 08:29:32'),(3,0,3,0,'David Valencia','2017-08-02 08:31:41','2017-08-02 08:31:41'),(4,0,4,0,'José Ángel Corbacho','2017-08-02 08:32:46','2017-08-02 08:32:46'),(5,0,5,0,'Juan Baeza','2017-08-02 08:33:23','2017-08-02 08:33:23'),(6,0,6,0,'José Manuel Caballero','2017-08-02 08:34:31','2017-08-02 08:34:31'),(7,0,7,0,'Mª Ángeles Ontalba','2017-08-02 08:36:14','2017-08-02 08:36:14'),(8,0,8,0,'José Vasco','2017-08-02 08:37:09','2017-08-02 08:37:09');
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
INSERT INTO `ost_user_account` VALUES (1,2,1,'Europe/Berlin',NULL,'antonio','$2a$08$OMpeDl1igHTExQGJP7b8xOlJMWgl1UQRTjyOttKJnJiZVv3GKE6KO',NULL,NULL,'2017-08-02 06:30:20'),(2,3,1,'Europe/Berlin',NULL,'david','$2a$08$mt7oKRQXg4iEHXgzEw6sDO/ysORaQrMPYg3DAJT8dhCQom1qkGaGS',NULL,'{\"browser_lang\":\"es_ES\"}','2017-08-02 06:32:04'),(3,4,1,'Europe/Berlin',NULL,'jose','$2a$08$LW41fRzA69EvbHzudvUWzO9v2foCW8OVjVyU3BIggItWBhxvlowEG',NULL,NULL,'2017-08-02 06:32:58'),(4,5,1,'Europe/Berlin',NULL,'juan','$2a$08$PfPfN68QEG0ETWk4o5Z5feBKug11.Bv0uLU9kw9N33m0JE7i1iIKW',NULL,'{\"browser_lang\":\"es_ES\"}','2017-08-02 06:33:42'),(5,6,1,'Europe/Berlin',NULL,'manolo','$2a$08$SB.rklDpfSCIGenHNlRXWOpKOcDfIcUIZb/5ywvSvE13tvdcqUpb6',NULL,NULL,'2017-08-02 06:34:49'),(6,7,1,'Europe/Berlin',NULL,'angeles','$2a$08$aoxkX1qHDCKDh8RsoLICXODT.L9cWk7svw/kKiIinNnGkPXmU9OcK',NULL,NULL,'2017-08-02 06:36:30'),(7,8,1,'Europe/Berlin',NULL,'pepe','$2a$08$63lBB11Z3Lz.h9yEL.zUNeeSIYgT7OEnvM97xne8C.pWILPN0FsvS',NULL,'{\"browser_lang\":\"es_ES\"}','2017-08-02 06:37:25');
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
INSERT INTO `ost_user_email` VALUES (2,2,0,'tritium@juntaex.es'),(3,3,0,'ratvapc@gmail.com'),(4,4,0,'rat_va_pc@juntaex.es'),(5,5,0,'juanbaeza@laruex.es'),(6,6,0,'manolo@laruex.es'),(7,7,0,'eco2cir@gmail.com'),(8,8,0,'eco2cir@juntaex.es');
/*!40000 ALTER TABLE `ost_user_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'osticket'
--
/*!50003 DROP FUNCTION IF EXISTS `GetProximaFechaCreacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`localhost` FUNCTION `GetProximaFechaCreacion`(plazo VARCHAR(20), ultima_tarea datetime, inicio datetime) RETURNS datetime
BEGIN
	IF ultima_tarea IS NULL THEN
		RETURN inicio;
	ELSE
		CASE plazo
			WHEN 'Anual' THEN RETURN date_add(ultima_tarea, interval 1 year);
			WHEN 'Semestral' THEN RETURN date_add(ultima_tarea, interval 6 month);
			WHEN 'Cuatrimestral' THEN RETURN date_add(ultima_tarea, interval 4 month);
			WHEN 'Trimestral' THEN RETURN date_add(ultima_tarea, interval 3 month);
			WHEN 'Bimensual' THEN RETURN date_add(ultima_tarea, interval 2 month);
			WHEN 'Mensual' THEN RETURN date_add(ultima_tarea, interval 1 month);
			WHEN 'Quincenal' THEN RETURN date_add(ultima_tarea, interval 15 day);
			WHEN 'Semanal' THEN RETURN date_add(ultima_tarea, interval 7 day);
		END CASE;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `LimpiarInventario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`localhost` PROCEDURE `LimpiarInventario`()
BEGIN
	
    
    
    
    
    
    delete from ost__search where object_type != 'U';
    
    delete from ost_equipment_booking where equipment_id not in (select id from ost_equipment);
    delete from ost_equipment_booking_hist where equipment_id not in (select id from ost_equipment);
    
    delete from ost_ticket__cdata where ticket_id not in (select ticket_id from ost_ticket);
    
    delete from ost_task__cdata where task_id not in (select id from ost_task);
    
	delete from ost_attachment where (type = 'T' and object_id not in (select id from ost_ticket));
    delete from ost_attachment where (type = 'E' and object_id not in (select id from ost_equipment));
    delete from ost_attachment where (type = 'A' and object_id not in (select id from ost_task));
    delete from ost_attachment where (type = 'S' and object_id not in (select id from ost_equipment_booking));
    delete from ost_file where id not in (select file_id from ost_attachment);
    delete from ost_file_chunk where file_id not in (select id from ost_file);
    
	delete from ost_form_entry where object_type = 'T' and object_id not in (select id from ost_ticket);
    delete from ost_form_entry where object_type = 'E' and object_id not in (select id from ost_equipment);
    delete from ost_form_entry where object_type = 'A' and object_id not in (select id from ost_task);
    delete from ost_form_entry where object_type = 'S' and object_id not in (select id from ost_equipment_booking);
    delete from ost_form_entry_values where entry_id not in (select id from ost_form_entry);

	delete from ost_thread where object_type = 'T' and object_id not in (select id from ost_ticket);
    delete from ost_thread where object_type = 'E' and object_id not in (select id from ost_equipment);
    delete from ost_thread where object_type = 'A' and object_id not in (select id from ost_task);
    delete from ost_thread where object_type = 'S' and object_id not in (select id from ost_equipment_booking);
	delete from ost_thread_entry where thread_id not in (select id from ost_thread);
	delete from ost_thread_event where thread_id not in (select id from ost_thread);

    delete from ost_session;
    
    delete from ost_draft;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ost_CreateEquipmentFormFields` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`localhost` PROCEDURE `ost_CreateEquipmentFormFields`()
BEGIN
	SET @form_id = (SELECT id FROM `ost_form` WHERE title='Equipment' LIMIT 1);
	SET @status_list_id = (SELECT id FROM `ost_list` WHERE `name`='equipment_status' LIMIT 1);
	SET @equipment_list_id = (SELECT id FROM `ost_list` WHERE `name`='equipment' LIMIT 1);

	IF (@form_id IS NOT NULL) AND (@status_list_id IS NOT NULL) AND (@equipment_list_id IS NOT NULL) then
		INSERT INTO `ost_form_field`
			(`form_id`,
			`type`,
			`label`,
			`required`,
			`private`,
			`edit_mask`,
			`name`,
			`sort`,
			`created`,
			`updated`)
			VALUES
			(@form_id,
			CONCAT('list-',@equipment_list_id),
			'Equipment',
			0,0,0,
			'equipment',			
			3,			
			NOW(),
			NOW());	

		INSERT INTO `ost_form_field`
			(`form_id`,
			`type`,
			`label`,
			`required`,
			`private`,
			`edit_mask`,
			`name`,
			`sort`,
			`created`,
			`updated`)
			VALUES
			(@form_id,
			CONCAT('list-',@status_list_id),
			'Status',
			0,0,0,
			'status',			
			2,			
			NOW(),
			NOW());	

                INSERT INTO `ost_form_field`
			(`form_id`,
			`type`,
			`label`,
			`required`,
			`private`,
			`edit_mask`,
			`name`,
			`sort`,
			`created`,
			`updated`)
			VALUES
			(@form_id,
			('text'),
			'Asset ID',
			0,0,0,
			'asset_id',			
			1,			
			NOW(),
			NOW());							
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ost_UpgradeEquipmentFormFields` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`localhost` PROCEDURE `ost_UpgradeEquipmentFormFields`()
BEGIN
	SET @form_id = (SELECT id FROM `ost_form` WHERE title='Equipment' LIMIT 1);
	SET @status_list_id = (SELECT id FROM `ost_list` WHERE `name`='equipment_status' LIMIT 1);
	SET @equipment_list_id = (SELECT id FROM `ost_list` WHERE `name`='equipment' LIMIT 1);

	IF (@form_id IS NOT NULL) AND (@status_list_id IS NOT NULL) AND (@equipment_list_id IS NOT NULL) then			

                INSERT INTO `ost_form_field`
			(`form_id`,
			`type`,
			`label`,
			`required`,
			`private`,
			`edit_mask`,
			`name`,
			`sort`,
			`created`,
			`updated`)
			VALUES
			(@form_id,
			('text'),
			'Asset ID',
			0,0,0,
			'asset_id',			
			1,			
			NOW(),
			NOW());							
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `VencerSLA` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`admin`@`localhost` PROCEDURE `VencerSLA`(IN id INT)
BEGIN
update ost_ticket t inner join ost_sla s on t.sla_id = s.id set t.created = subdate(t.created, INTERVAL s.grace_period HOUR), reopened = subdate(reopened, INTERVAL s.grace_period HOUR), duedate = subdate(duedate, INTERVAL s.grace_period HOUR), last_duedate = subdate(last_duedate, INTERVAL s.grace_period HOUR) where ticket_id = id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-13  8:49:44
