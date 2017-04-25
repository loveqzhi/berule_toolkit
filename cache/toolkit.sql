-- MySQL dump 10.13  Distrib 5.5.38, for Linux (x86_64)
--
-- Host: localhost    Database: toolkit
-- ------------------------------------------------------
-- Server version	5.5.38-log

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
-- Table structure for table `application`
--

DROP TABLE IF EXISTS `application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'uid',
  `type` int(4) NOT NULL DEFAULT '1' COMMENT '类型:1普通开发者,2测试者',
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT '应用名称',
  `appid` varchar(32) DEFAULT '' COMMENT 'appid',
  `secret` varchar(128) DEFAULT '' COMMENT 'secret',
  `phone` varchar(20) NOT NULL DEFAULT '' COMMENT '电话',
  `email` varchar(100) NOT NULL DEFAULT '' COMMENT '邮箱',
  `image` varchar(255) DEFAULT '' COMMENT 'logo',
  `organization` varchar(255) DEFAULT '' COMMENT '机构',
  `status` int(4) NOT NULL DEFAULT '0' COMMENT '0申请中,1通过,4未通过',
  `message` varchar(255) DEFAULT NULL COMMENT '消息',
  `created` int(10) NOT NULL DEFAULT '0' COMMENT '申请时间',
  `updated` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `appid` (`appid`),
  KEY `uid` (`uid`,`status`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户APP认证申请表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application`
--

LOCK TABLES `application` WRITE;
/*!40000 ALTER TABLE `application` DISABLE KEYS */;
INSERT INTO `application` VALUES (1,1,1,'我的应用','blC420141220154047563087','$S$a4bdc7628a2451de9334f69380b6fffda499322d62df9dbfd3cbf5d83514c','15221816172','loveqzhi@hotmail.com','/cache/upload/images/20141220/20141220_512175.jpg','上海贝螺公司',1,'',1419051775,1419051775);
/*!40000 ALTER TABLE `application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_field_mail_data`
--

DROP TABLE IF EXISTS `data_field_mail_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_field_mail_data` (
  `entity_type` varchar(32) NOT NULL DEFAULT '' COMMENT 'Entity Type',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `delta` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '复数排序',
  `field_mail_data_address` varchar(255) NOT NULL DEFAULT '' COMMENT '发送目标',
  `field_mail_data_replyto` varchar(255) DEFAULT '1' COMMENT '回复',
  `field_mail_data_cc` varchar(255) DEFAULT '' COMMENT '抄送',
  `field_mail_data_bcc` varchar(255) DEFAULT NULL COMMENT '秘送',
  `field_mail_data_is_html` int(1) DEFAULT '0' COMMENT '是否html',
  `field_mail_data_subject` varchar(255) NOT NULL COMMENT '标题',
  `field_mail_data_body` longblob NOT NULL COMMENT '正文',
  `field_mail_data_altbody` longblob COMMENT 'altbody',
  PRIMARY KEY (`entity_type`,`entity_id`,`delta`),
  KEY `entity_type_id` (`entity_type`,`entity_id`),
  KEY `entity_id` (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='邮件内容';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_field_mail_data`
--

LOCK TABLES `data_field_mail_data` WRITE;
/*!40000 ALTER TABLE `data_field_mail_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_field_mail_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_field_node_body`
--

DROP TABLE IF EXISTS `data_field_node_body`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_field_node_body` (
  `entity_type` varchar(32) NOT NULL,
  `entity_id` int(10) NOT NULL,
  `delta` int(10) NOT NULL,
  `field_node_body_value` mediumtext COMMENT '正文',
  `field_node_body_summary` longtext COMMENT '摘要',
  PRIMARY KEY (`entity_type`,`entity_id`,`delta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='节点正文';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_field_node_body`
--

LOCK TABLES `data_field_node_body` WRITE;
/*!40000 ALTER TABLE `data_field_node_body` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_field_node_body` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_field_role_permission`
--

DROP TABLE IF EXISTS `data_field_role_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_field_role_permission` (
  `entity_type` varchar(32) NOT NULL DEFAULT '' COMMENT 'Entity Type',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `delta` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '复数排序',
  `field_role_permission_permission` varchar(128) NOT NULL DEFAULT '' COMMENT '权限名称',
  `field_role_permission_data` longblob COMMENT '权限序列化数据',
  PRIMARY KEY (`entity_type`,`entity_id`,`delta`),
  KEY `entity_type_id` (`entity_type`,`entity_id`),
  KEY `entity_id` (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_field_role_permission`
--

LOCK TABLES `data_field_role_permission` WRITE;
/*!40000 ALTER TABLE `data_field_role_permission` DISABLE KEYS */;
INSERT INTO `data_field_role_permission` VALUES ('role',1,0,'/mail/search','a:6:{s:5:\"title\";s:12:\"发送历史\";s:11:\"description\";s:6:\"列表\";s:6:\"module\";s:4:\"mail\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,1,'/mail/send','a:6:{s:5:\"title\";s:9:\"写邮件\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:4:\"mail\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,2,'/mail/waitting','a:6:{s:5:\"title\";s:12:\"待发列表\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:4:\"mail\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,3,'/mail/setting','a:6:{s:5:\"title\";s:12:\"邮箱配置\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:4:\"mail\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,4,'/sms/search','a:6:{s:5:\"title\";s:12:\"已发短信\";s:11:\"description\";s:6:\"列表\";s:6:\"module\";s:3:\"sms\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,5,'/sms/send','a:6:{s:5:\"title\";s:9:\"发短信\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:3:\"sms\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,6,'/sms/waitting','a:6:{s:5:\"title\";s:12:\"待发列表\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:3:\"sms\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,7,'/sms/setting','a:6:{s:5:\"title\";s:12:\"短信接口\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:3:\"sms\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,8,'/application/search','a:6:{s:5:\"title\";s:12:\"应用列表\";s:11:\"description\";s:6:\"列表\";s:6:\"module\";s:11:\"application\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,9,'/application/verify','a:6:{s:5:\"title\";s:12:\"审核应用\";s:11:\"description\";s:12:\"审核应用\";s:6:\"module\";s:11:\"application\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,10,'/application/add','a:6:{s:5:\"title\";s:12:\"申请应用\";s:11:\"description\";s:12:\"申请应用\";s:6:\"module\";s:11:\"application\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,11,'/application/interface','a:6:{s:5:\"title\";s:9:\"开发者\";s:11:\"description\";s:9:\"开发者\";s:6:\"module\";s:11:\"application\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,12,'/cron/task','a:6:{s:5:\"title\";s:12:\"定时脚本\";s:11:\"description\";s:12:\"定时脚本\";s:6:\"module\";s:4:\"cron\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,13,'/cron/task/runing','a:6:{s:5:\"title\";s:12:\"脚本启动\";s:11:\"description\";s:12:\"脚本启动\";s:6:\"module\";s:4:\"cron\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,14,'/cron/work','a:6:{s:5:\"title\";s:12:\"工作Worker\";s:11:\"description\";s:12:\"工作Worker\";s:6:\"module\";s:4:\"cron\";s:8:\"quantity\";s:1:\"2\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,15,'/user/search','a:6:{s:5:\"title\";s:12:\"用户列表\";s:11:\"description\";s:12:\"更新地区\";s:6:\"module\";s:4:\"user\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,16,'/user/add','a:6:{s:5:\"title\";s:12:\"添加用户\";s:11:\"description\";s:12:\"添加用户\";s:6:\"module\";s:4:\"user\";s:8:\"quantity\";s:1:\"2\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,17,'/user/edit','a:6:{s:5:\"title\";s:12:\"编辑用户\";s:11:\"description\";s:12:\"编辑用户\";s:6:\"module\";s:4:\"user\";s:8:\"quantity\";s:1:\"3\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,18,'/admin/role/search','a:6:{s:5:\"title\";s:12:\"角色列表\";s:11:\"description\";s:12:\"更新角色\";s:6:\"module\";s:4:\"role\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,19,'/admin/role/add','a:6:{s:5:\"title\";s:12:\"添加角色\";s:11:\"description\";s:12:\"更新角色\";s:6:\"module\";s:4:\"role\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,20,'/admin/role/edit','a:6:{s:5:\"title\";s:12:\"编辑角色\";s:11:\"description\";s:12:\"更新角色\";s:6:\"module\";s:4:\"role\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,0,'/mail/search','a:6:{s:5:\"title\";s:12:\"发送历史\";s:11:\"description\";s:6:\"列表\";s:6:\"module\";s:4:\"mail\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,1,'/mail/send','a:6:{s:5:\"title\";s:9:\"写邮件\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:4:\"mail\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,2,'/mail/waitting','a:6:{s:5:\"title\";s:12:\"待发列表\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:4:\"mail\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,3,'/mail/setting','a:6:{s:5:\"title\";s:12:\"邮箱配置\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:4:\"mail\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}');
/*!40000 ALTER TABLE `data_field_role_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_field_user_mail`
--

DROP TABLE IF EXISTS `data_field_user_mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_field_user_mail` (
  `entity_type` varchar(32) NOT NULL DEFAULT '' COMMENT 'Entity Type',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `delta` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '复数排序',
  `field_user_mail_name` varchar(10) NOT NULL DEFAULT '' COMMENT '接口mail名称',
  `field_user_mail_status` int(11) NOT NULL DEFAULT '1' COMMENT '1正常,2无法连接',
  `field_user_mail_host` varchar(50) NOT NULL DEFAULT '' COMMENT 'host',
  `field_user_mail_username` varchar(128) NOT NULL COMMENT '用户名',
  `field_user_mail_password` varchar(128) NOT NULL COMMENT '密码',
  `field_user_mail_from` varchar(128) DEFAULT NULL COMMENT '发送来自',
  `field_user_mail_fromname` varchar(255) DEFAULT NULL COMMENT '发送机构',
  `field_user_mail_options` longblob COMMENT '其它选项',
  PRIMARY KEY (`entity_type`,`entity_id`,`delta`),
  KEY `entity_type_id` (`entity_type`,`entity_id`),
  KEY `entity_id` (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户邮箱';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_field_user_mail`
--

LOCK TABLES `data_field_user_mail` WRITE;
/*!40000 ALTER TABLE `data_field_user_mail` DISABLE KEYS */;
INSERT INTO `data_field_user_mail` VALUES ('user',1,0,'mail6',1,'smtp.exmail.qq.com','zhi.chen@berule.com','chinazhi2014','zhi.chen@berule.com','陈志','a:2:{s:10:\"smtpsecure\";s:3:\"ssl\";s:4:\"port\";s:3:\"465\";}');
/*!40000 ALTER TABLE `data_field_user_mail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_field_user_sms`
--

DROP TABLE IF EXISTS `data_field_user_sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_field_user_sms` (
  `entity_type` varchar(32) NOT NULL DEFAULT '' COMMENT 'Entity Type',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `delta` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '复数排序',
  `field_user_sms_name` varchar(10) NOT NULL DEFAULT '' COMMENT '接口mail名称',
  `field_user_sms_status` int(11) NOT NULL DEFAULT '1' COMMENT '1正常,2无效',
  `field_user_sms_userid` varchar(50) NOT NULL DEFAULT '' COMMENT '企业ID',
  `field_user_sms_account` varchar(128) NOT NULL COMMENT '用户名',
  `field_user_sms_password` varchar(128) NOT NULL COMMENT '密码',
  `field_user_sms_sign` varchar(20) NOT NULL COMMENT '签名',
  `field_user_sms_options` longblob COMMENT '其它选项',
  PRIMARY KEY (`entity_type`,`entity_id`,`delta`),
  KEY `entity_type_id` (`entity_type`,`entity_id`),
  KEY `entity_id` (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户短信接口';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_field_user_sms`
--

LOCK TABLES `data_field_user_sms` WRITE;
/*!40000 ALTER TABLE `data_field_user_sms` DISABLE KEYS */;
INSERT INTO `data_field_user_sms` VALUES ('user',1,0,'sms1',1,'184','bl1087','123456','贝螺网络科技','a:1:{s:7:\"overage\";s:2:\"12\";}'),('user',1,1,'sms2',1,'192','bl1090','123456','驰耐得轮胎','a:1:{s:7:\"overage\";s:5:\"16397\";}');
/*!40000 ALTER TABLE `data_field_user_sms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `field_config`
--

DROP TABLE IF EXISTS `field_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_config` (
  `id` int(10) unsigned NOT NULL COMMENT '自增主键',
  `entity_type` varchar(64) NOT NULL DEFAULT '' COMMENT 'Entity Type',
  `field_name` varchar(128) NOT NULL DEFAULT '' COMMENT '字段名称',
  `data` longblob NOT NULL COMMENT '字段信息',
  `active` tinyint(1) NOT NULL COMMENT '是否启用',
  `locked` tinyint(1) NOT NULL COMMENT '是否锁定',
  PRIMARY KEY (`id`),
  KEY `entity_type` (`entity_type`,`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='字段配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_config`
--

LOCK TABLES `field_config` WRITE;
/*!40000 ALTER TABLE `field_config` DISABLE KEYS */;
INSERT INTO `field_config` VALUES (1,'user','field_user_mail','a:1:{s:7:\"columns\";a:8:{s:4:\"name\";a:7:{s:11:\"description\";s:16:\"接口mail名称\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";s:0:\"\";s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:6:\"status\";a:7:{s:11:\"description\";s:21:\"1正常,2无法连接\";s:4:\"type\";s:3:\"int\";s:7:\"default\";s:1:\"1\";s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:4:\"host\";a:7:{s:11:\"description\";s:4:\"host\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";s:0:\"\";s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:8:\"username\";a:7:{s:11:\"description\";s:9:\"用户名\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";N;s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:8:\"password\";a:7:{s:11:\"description\";s:6:\"密码\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";N;s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:4:\"from\";a:7:{s:11:\"description\";s:12:\"发送来自\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";N;s:8:\"not null\";b:0;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:8:\"fromname\";a:7:{s:11:\"description\";s:12:\"发送机构\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";N;s:8:\"not null\";b:0;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:7:\"options\";a:7:{s:11:\"description\";s:12:\"其它选项\";s:4:\"type\";s:8:\"longblob\";s:7:\"default\";N;s:8:\"not null\";b:0;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}}}',1,0),(2,'role','field_role_permission','a:1:{s:7:\"columns\";a:2:{s:10:\"permission\";a:7:{s:11:\"description\";s:12:\"权限名称\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";s:0:\"\";s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:4:\"data\";a:7:{s:11:\"description\";s:21:\"权限序列化数据\";s:4:\"type\";s:8:\"longblob\";s:7:\"default\";N;s:8:\"not null\";b:0;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}}}',1,0),(3,'mail','field_mail_data','a:1:{s:7:\"columns\";a:8:{s:7:\"address\";a:7:{s:11:\"description\";s:12:\"发送目标\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";s:0:\"\";s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:7:\"replyto\";a:7:{s:11:\"description\";s:6:\"回复\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";s:1:\"1\";s:8:\"not null\";b:0;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:2:\"cc\";a:7:{s:11:\"description\";s:6:\"抄送\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";s:0:\"\";s:8:\"not null\";b:0;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:3:\"bcc\";a:7:{s:11:\"description\";s:6:\"秘送\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";N;s:8:\"not null\";b:0;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:7:\"is_html\";a:7:{s:11:\"description\";s:10:\"是否html\";s:4:\"type\";s:3:\"int\";s:7:\"default\";s:1:\"0\";s:8:\"not null\";b:0;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:7:\"subject\";a:7:{s:11:\"description\";s:6:\"标题\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";N;s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:4:\"body\";a:7:{s:11:\"description\";s:6:\"正文\";s:4:\"type\";s:8:\"longblob\";s:7:\"default\";N;s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:7:\"altbody\";a:7:{s:11:\"description\";s:7:\"altbody\";s:4:\"type\";s:8:\"longblob\";s:7:\"default\";N;s:8:\"not null\";b:0;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}}}',1,0),(4,'user','field_user_sms','a:1:{s:7:\"columns\";a:7:{s:4:\"name\";a:7:{s:11:\"description\";s:16:\"接口mail名称\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";s:0:\"\";s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:6:\"status\";a:7:{s:11:\"description\";s:15:\"1正常,2无效\";s:4:\"type\";s:3:\"int\";s:7:\"default\";s:1:\"1\";s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:6:\"userid\";a:7:{s:11:\"description\";s:8:\"企业ID\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";s:0:\"\";s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:7:\"account\";a:7:{s:11:\"description\";s:9:\"用户名\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";N;s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:8:\"password\";a:7:{s:11:\"description\";s:6:\"密码\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";N;s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:4:\"sign\";a:7:{s:11:\"description\";s:6:\"签名\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";N;s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:7:\"options\";a:7:{s:11:\"description\";s:12:\"其它选项\";s:4:\"type\";s:8:\"longblob\";s:7:\"default\";N;s:8:\"not null\";b:0;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}}}',1,0);
/*!40000 ALTER TABLE `field_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mail`
--

DROP TABLE IF EXISTS `mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'uid',
  `msgid` varchar(32) NOT NULL DEFAULT '' COMMENT 'msgid',
  `channel` varchar(32) NOT NULL DEFAULT '' COMMENT '发送接口',
  `address` varchar(150) NOT NULL DEFAULT '' COMMENT '发送地址',
  `subject` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `status` int(4) NOT NULL DEFAULT '1' COMMENT '状态 1成功,4失败',
  `created` int(10) NOT NULL DEFAULT '0' COMMENT '生成时间',
  `updated` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `msgid` (`msgid`),
  KEY `uid` (`uid`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8 COMMENT='邮件发送记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mail`
--

LOCK TABLES `mail` WRITE;
/*!40000 ALTER TABLE `mail` DISABLE KEYS */;
INSERT INTO `mail` VALUES (1,1,'C420141224130706356515','mail6','836456126@qq.com','开发中请确定时间',1,1419415188,1419415188),(2,1,'C420141217150118515553','mail7','836456126@qq.com','我们在发是一条试试',1,1418799678,1419415955),(3,1,'C420141224181417519402','mail6','156894161@qq.com','你说什么',1,1419416057,1419416061),(4,1,'C420141224195317828128','mail6','hanson.huang@qq.com','this is a test email',1,1419421997,1419422002),(5,1,'C420141224195327381091','mail6','836456126@qq.com','测试一下就知道了啊',1,1419422007,1419422014),(6,1,'C420141225181025254637','mail6','836456126@qq.com','我在测试邮件发送看看',1,1419502225,1419502231),(7,1,'C42014122518115480063','mail6','836456126@qq.com','我在测试邮件发送看看',1,1419502314,1419502317),(8,1,'C420141229192536451513','mail6','836456126@qq.com','测试主题发送是否成功',1,1419852336,1419852343),(9,1,'C420141229194024436796','mail6','2207860301@qq.com','2014-12-29 19:30 我在测试中...',1,1419853224,1419853229),(10,1,'C420150102183407803314','mail6','836456126@qq.com','测试主题发送',1,1420194847,1420194855),(11,1,'C420150105124030978294','mail6','836456126@qq.com',' 测试发送附件',1,1420432830,1420433298),(12,1,'C420150105155719689174','mail6','836456126@qq.com','测试发送',1,1420444639,1420444905),(13,1,'C420150109140446955514','mail6','836456126@qq.com','测试邮件主题',1,1420783486,1421228833),(14,1,'C420150109140529695997','mail6','156894161@qq.com;836456126@qq.com','测试发送两人以上',1,1420783529,1421228834),(15,1,'C420150114174658663219','mail6','loveqzhi@163.com','测试乱码问题',1,1421228818,1421228835),(16,1,'C420150114174838116164','mail6','loveqzhi@163.com','A-semi 重置密码',1,1421228918,1421228921),(17,1,'C420150120131605269734','mail6','2207860301@qq.com','测试发送一封邮件试试',1,1421730965,1421731239),(18,1,'C420150120132222520001','mail6','2207860301@qq.com','测试发送大附件',1,1421731342,1421731349),(19,1,'C420150120132532370135','mail6','2207860301@qq.com','发送测试邮件',1,1421731532,1421731538),(20,1,'C4201501201325428672','mail6','2207860301@qq.com','11111111111',1,1421731542,1421731548),(21,1,'C420150120132852242113','mail6','2207860301@qq.com','发送记录邮件',1,1421731732,1421731822),(22,1,'C420150120133137398018','mail6','2207860301@qq.com','把这样的信息发出去',1,1421731897,1421731902),(23,1,'C420150120133215769087','mail6','2207860301@qq.com','继续发送这样的邮件',1,1421731935,1421731938),(24,1,'C420150120133438512012','mail6','2207860301@qq.com','发到不能发位',1,1421732078,1421732084),(25,1,'C420150120134135723708','mail6','2207860301@qq.com','东窗事发',1,1421732495,1421732498),(26,1,'C420150120134243871006','mail6','2207860301@qq.com','这个可以有',1,1421732563,1421732572),(27,1,'C420150120134325921693','mail6','2207860301@qq.com','可预不可求的啊',1,1421732605,1421732611),(28,1,'C42015012013442259670','mail6','2207860301@qq.com','脚离地一寸便是天',1,1421732662,1421732671),(29,1,'C420150120134836119795','mail6','2207860301@qq.com','邮件可以接着发',1,1421732916,1421732921),(30,1,'C420150120135154372754','mail6','2207860301@qq.com','写信的原油',1,1421733114,1421733117),(31,1,'C420150126151953565295','mail6','2207860301@qq.com','给你发一封邮件',1,1422256793,1422256800),(32,1,'C420150126152146781625','mail6','2207860301@qq.com','发送测试的而已',1,1422256906,1422256916),(33,1,'C420150213143744617095','mail6','836456126@qq.com','测试数据',1,1423809464,1423809471),(34,1,'C420150213144154654629','mail6','836456126@qq.com','测试数据',1,1423809714,1423809724),(35,1,'C420150213144821472796','mail6','836456126@qq.com','1111111',1,1423810101,1423810108),(36,1,'C420150213145026946494','mail6','836456126@qq.com','2222222',1,1423810226,1423810265),(37,1,'C420150213152220729549','mail6','836456126@qq.com','123',1,1423812344,1423812349),(38,1,'C420150213152816104014','mail6','836456126@qq.com','123',1,1423812496,1423812500),(39,1,'C420150213152918181226','mail6','836456126@qq.com','222222',1,1423812558,1423812566),(40,1,'C420150213152841941069','mail6','888@qq.com','111',4,1423812983,1423812992),(41,1,'C420150213154817640456','mail6','836456126@qq.com','123',1,1423814134,1423814144),(42,1,'C420150213160804825433','mail6','836456126@qq.com','2222',1,1423814884,1423814894),(43,1,'C420150213161038725175','mail6','836456126@qq.com','123123',1,1423815038,1423815068),(44,1,'C420150213161233887232','mail6','836456126@qq.com','111111111111',1,1423815153,1423815163),(45,1,'C420150213161445560816','mail6','836456126@qq.com','123123',1,1423815285,1423815290),(46,1,'C420150213161707793364','mail6','836456126@qq.com','123123',1,1423815427,1423815429),(47,1,'C420150213162013807356','mail6','836456126@qq.com','123',1,1423815613,1423815622),(48,1,'C420150213162215215829','mail6','836456126@qq.com','11111111111',1,1423815735,1423815745),(49,1,'C420150213155832360544','mail6','836456126@qq.com','1111',1,1423815834,1423815843),(50,1,'C420150213162457299527','mail6','836456126@qq.com','22222222222222',1,1423815897,1423815908),(51,1,'C420150213162648302056','mail6','836456126@qq.com','2222222222',1,1423816008,1423816023),(52,1,'C42015021316283418073','mail6','836456126@qq.com','123345',1,1423816114,1423816116),(53,1,'C420150213162855766961','mail6','836456126@qq.com','ffffffff ',1,1423816135,1423816150),(54,1,'C420150213163241237955','mail6','836456126@qq.com','111111111111',1,1423816361,1423816371),(55,1,'C420150213163308190796','mail6','836456126@qq.com','aaaaaa',1,1423816388,1423816393),(56,1,'C420150213163344302996','mail6','836456126@qq.com','fffffffff',1,1423816424,1423816430),(57,1,'C420150213164332488984','mail6','836456126@qq.com','1111111111',1,1423817012,1423817067);
/*!40000 ALTER TABLE `mail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relation_user_roles`
--

DROP TABLE IF EXISTS `relation_user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relation_user_roles` (
  `uid` int(10) unsigned NOT NULL,
  `rid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`uid`,`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relation_user_roles`
--

LOCK TABLES `relation_user_roles` WRITE;
/*!40000 ALTER TABLE `relation_user_roles` DISABLE KEYS */;
INSERT INTO `relation_user_roles` VALUES (1,1),(2,2),(3,2);
/*!40000 ALTER TABLE `relation_user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `rid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色rid',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '角色名称',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT '权重',
  PRIMARY KEY (`rid`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'超级管理员',1),(2,'客户',2);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms`
--

DROP TABLE IF EXISTS `sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'uid',
  `msgid` varchar(32) NOT NULL DEFAULT '' COMMENT 'msgid',
  `taskid` varchar(64) NOT NULL DEFAULT '' COMMENT '任务ID(短信接口返回)',
  `channel` varchar(32) NOT NULL DEFAULT '' COMMENT '发送接口',
  `phone` varchar(150) NOT NULL DEFAULT '' COMMENT '手机号码',
  `content` varchar(255) NOT NULL DEFAULT '' COMMENT '短信内容',
  `status` int(4) NOT NULL DEFAULT '1' COMMENT '状态 1提交成功2提交失败3发送成功4发送失败',
  `created` int(10) NOT NULL DEFAULT '0' COMMENT '生成时间',
  `updated` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `msgid` (`msgid`),
  KEY `uid` (`uid`,`status`),
  KEY `taskid` (`taskid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='短信发送记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms`
--

LOCK TABLES `sms` WRITE;
/*!40000 ALTER TABLE `sms` DISABLE KEYS */;
INSERT INTO `sms` VALUES (1,1,'C420150107163609782314','0','sms2','18616934147','【驰耐得轮胎】感谢你登录我们系统，你的密码是x73kg2',2,1420619769,1420619772),(2,1,'C420150107164522923817','432244','sms2','18616934147','【驰耐得轮胎】感谢你登录我们系统，你的密码是x73kg2',1,1420620322,1420620329),(3,1,'C420150120134645156767','489062','sms1','18616934147','【贝螺网络科技】您的验证码是: xyxybs',1,1421732805,1421732810),(4,1,'C420150120134753540503','489073','sms1','18616934147','【贝螺网络科技】您的验证码是:1200xx',1,1421732873,1421732880),(5,1,'C42015012615295576686','513719','sms1','18616934147','【贝螺网络科技】您的验证码是xxx445',1,1422257395,1422257401),(6,1,'C420150213164059523','608447','sms1','18616934147','【贝螺网络科技】你的验证码是xxyydd',1,1423816859,1423816861),(7,1,'C420150213164154335656','608459','sms1','18616934147','【贝螺网络科技】你的验证码是gsyyds',1,1423816914,1423816918);
/*!40000 ALTER TABLE `sms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `task` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1:mail,2sms',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'uid',
  `msgid` varchar(32) NOT NULL DEFAULT '' COMMENT '任务ID',
  `channel` varchar(32) NOT NULL DEFAULT '' COMMENT '使用接口名',
  `data` longblob NOT NULL COMMENT '内容',
  `status` int(4) NOT NULL DEFAULT '0' COMMENT '0等待发送,1已入队',
  `created` int(10) NOT NULL DEFAULT '0' COMMENT '生成时间',
  PRIMARY KEY (`id`),
  KEY `type_uid` (`type`,`uid`),
  KEY `type_status` (`type`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='发送任务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `date` char(8) NOT NULL COMMENT '日期',
  `uid` int(10) NOT NULL DEFAULT '0' COMMENT 'uid',
  `token` varchar(32) NOT NULL COMMENT 'token',
  `expired` int(10) NOT NULL DEFAULT '0' COMMENT '过期时间',
  `total` int(10) NOT NULL DEFAULT '1' COMMENT '计数',
  `updated` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`date`,`uid`),
  KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='令牌表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES ('20141225',1,'blA920141225181153827652',1419509513,3,1419502313),('20141229',1,'blA920141229194024175190',1419860424,1,1419853224),('20150107',1,'blA920150107164522799989',1420627522,2,1420620322),('20150114',1,'blA920150114174837920292',1421236117,1,1421228917),('20150205',1,'blA920150205184622559011',1423140382,6,1423133182);
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'UID',
  `username` varchar(50) NOT NULL DEFAULT '' COMMENT 'username',
  `password` varchar(128) NOT NULL DEFAULT '' COMMENT 'password',
  `uuid` varchar(64) NOT NULL DEFAULT '' COMMENT '唯一uuid',
  `phone` varchar(20) NOT NULL DEFAULT '' COMMENT '手机',
  `nickname` varchar(50) NOT NULL DEFAULT '' COMMENT '显示昵称',
  `avatar` varchar(255) NOT NULL DEFAULT '' COMMENT '头像',
  `sex` enum('M','F','U') NOT NULL DEFAULT 'U' COMMENT '性别',
  `status` int(4) NOT NULL DEFAULT '1' COMMENT '状态 1正常,2锁定',
  `created` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `accessed` int(10) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'root','$S$G65d74a5442cea7530176350c85ef8423ffab9c5f73a6be036ef1c838bf8a','root','18616934147','Administrator','','M',1,1415939223,1415939223,1423798363),(2,'test','$S$hbea059bf89aa995981dc08f347bb20f7f5095c0fa62e88c5af4c33039377','c5b7845f-83c7-45b8-a894-09da41dc6581','15221816172','西门吹雪','','F',1,1418657237,1418657237,1418704202),(3,'lch','$S$319c711c42c9d97aa6526f306185487273c8a9c2ab0ce2af58fe18b7abcad','3429fc97-0378-4b83-8156-86b1176abcdd','','lch','','M',1,1420437415,1420437415,0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variables`
--

DROP TABLE IF EXISTS `variables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variables` (
  `name` varchar(128) NOT NULL,
  `value` longtext,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='variables';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variables`
--

LOCK TABLES `variables` WRITE;
/*!40000 ALTER TABLE `variables` DISABLE KEYS */;
INSERT INTO `variables` VALUES ('WorkMail','a:2:{s:10:\"master_pid\";i:5405;s:11:\"manager_pid\";i:5406;}'),('WorkSms','a:2:{s:10:\"master_pid\";i:5141;s:11:\"manager_pid\";i:5142;}');
/*!40000 ALTER TABLE `variables` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-03-06 18:12:46
