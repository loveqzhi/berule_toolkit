-- MySQL dump 10.13  Distrib 5.5.36, for Linux (x86_64)
--
-- Host: localhost    Database: toolkit
-- ------------------------------------------------------
-- Server version	5.5.36-cll-lve

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
  `token_max_time` int(10) NOT NULL DEFAULT '100' COMMENT 'token最大请求次数',
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
INSERT INTO `application` VALUES (1,1,1,'管理测试开发','blC420141220154047563087','$S$a4bdc7628a2451de9334f69380b6fffda499322d62df9dbfd3cbf5d83514c',300,'15221816172','loveqzhi@hotmail.com','/cache/upload/images/20141220/20141220_512175.jpg','上海贝螺公司',1,'',1419051775,1419051775);
/*!40000 ALTER TABLE `application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `async`
--

DROP TABLE IF EXISTS `async`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `async` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `type` int(4) unsigned NOT NULL DEFAULT '2' COMMENT '1系统2用户',
  `file_name` varchar(50) NOT NULL COMMENT '脚本名',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '服务名',
  `worker_num` int(4) NOT NULL DEFAULT '1' COMMENT 'worker数量',
  `work_port` int(6) NOT NULL DEFAULT '9500' COMMENT '端口',
  `task_worker_num` int(4) NOT NULL DEFAULT '1' COMMENT 'task worker数量',
  `max_request` int(10) NOT NULL DEFAULT '100' COMMENT '最大请求数',
  `dispatch_mode` int(4) NOT NULL DEFAULT '3' COMMENT '分发模式',
  `debug_mode` int(4) NOT NULL DEFAULT '1' COMMENT '调试模式',
  `log_file` varchar(255) NOT NULL DEFAULT '' COMMENT '日志文件',
  `status` int(4) unsigned NOT NULL DEFAULT '1' COMMENT '1正常2待审核4关闭',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户UID',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='异步注册表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `async`
--

LOCK TABLES `async` WRITE;
/*!40000 ALTER TABLE `async` DISABLE KEYS */;
INSERT INTO `async` VALUES (1,1,'MailSend.php','系统邮件',2,9500,1,100,3,1,'/tmp/toolkit_mail.log',1,1,1419051775,1419051776),(2,1,'SmsSend.php','短信服务',1,9501,1,100,3,1,'/tmp/test_swoole.log',1,1,1432523369,1432523369);
/*!40000 ALTER TABLE `async` ENABLE KEYS */;
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
INSERT INTO `data_field_role_permission` VALUES ('role',1,0,'/wechat/user','a:6:{s:5:\"title\";s:12:\"用户管理\";s:11:\"description\";s:12:\"更新地区\";s:6:\"module\";s:6:\"wechat\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,1,'/wechat/setting','a:6:{s:5:\"title\";s:12:\"账号配置\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:6:\"wechat\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,2,'/mail/search','a:6:{s:5:\"title\";s:12:\"发送历史\";s:11:\"description\";s:6:\"列表\";s:6:\"module\";s:4:\"mail\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,3,'/mail/send','a:6:{s:5:\"title\";s:9:\"写邮件\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:4:\"mail\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,4,'/mail/waitting','a:6:{s:5:\"title\";s:12:\"待发列表\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:4:\"mail\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,5,'/mail/setting','a:6:{s:5:\"title\";s:12:\"邮箱配置\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:4:\"mail\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,6,'/sms/search','a:6:{s:5:\"title\";s:12:\"已发短信\";s:11:\"description\";s:6:\"列表\";s:6:\"module\";s:3:\"sms\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,7,'/sms/send','a:6:{s:5:\"title\";s:9:\"发短信\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:3:\"sms\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,8,'/sms/waitting','a:6:{s:5:\"title\";s:12:\"待发列表\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:3:\"sms\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,9,'/sms/setting','a:6:{s:5:\"title\";s:12:\"短信接口\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:3:\"sms\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,10,'/application/search','a:6:{s:5:\"title\";s:12:\"应用列表\";s:11:\"description\";s:6:\"列表\";s:6:\"module\";s:11:\"application\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,11,'/application/verify','a:6:{s:5:\"title\";s:12:\"审核应用\";s:11:\"description\";s:12:\"审核应用\";s:6:\"module\";s:11:\"application\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,12,'/application/add','a:6:{s:5:\"title\";s:12:\"申请应用\";s:11:\"description\";s:12:\"申请应用\";s:6:\"module\";s:11:\"application\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,13,'/application/interface','a:6:{s:5:\"title\";s:9:\"开发者\";s:11:\"description\";s:9:\"开发者\";s:6:\"module\";s:11:\"application\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,14,'/async/search','a:6:{s:5:\"title\";s:12:\"Worker管理\";s:11:\"description\";s:12:\"Worker管理\";s:6:\"module\";s:5:\"async\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,15,'/user/search','a:6:{s:5:\"title\";s:12:\"用户列表\";s:11:\"description\";s:12:\"更新地区\";s:6:\"module\";s:4:\"user\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,16,'/user/add','a:6:{s:5:\"title\";s:12:\"添加用户\";s:11:\"description\";s:12:\"添加用户\";s:6:\"module\";s:4:\"user\";s:8:\"quantity\";s:1:\"2\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,17,'/user/edit','a:6:{s:5:\"title\";s:12:\"编辑用户\";s:11:\"description\";s:12:\"编辑用户\";s:6:\"module\";s:4:\"user\";s:8:\"quantity\";s:1:\"3\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,18,'/admin/role/search','a:6:{s:5:\"title\";s:12:\"角色列表\";s:11:\"description\";s:12:\"更新角色\";s:6:\"module\";s:4:\"role\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,19,'/admin/role/add','a:6:{s:5:\"title\";s:12:\"添加角色\";s:11:\"description\";s:12:\"更新角色\";s:6:\"module\";s:4:\"role\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',1,20,'/admin/role/edit','a:6:{s:5:\"title\";s:12:\"编辑角色\";s:11:\"description\";s:12:\"更新角色\";s:6:\"module\";s:4:\"role\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,0,'/mail/search','a:6:{s:5:\"title\";s:12:\"发送历史\";s:11:\"description\";s:6:\"列表\";s:6:\"module\";s:4:\"mail\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,1,'/mail/send','a:6:{s:5:\"title\";s:9:\"写邮件\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:4:\"mail\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,2,'/mail/waitting','a:6:{s:5:\"title\";s:12:\"待发列表\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:4:\"mail\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,3,'/mail/setting','a:6:{s:5:\"title\";s:12:\"邮箱配置\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:4:\"mail\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,4,'/sms/search','a:6:{s:5:\"title\";s:12:\"已发短信\";s:11:\"description\";s:6:\"列表\";s:6:\"module\";s:3:\"sms\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,5,'/sms/send','a:6:{s:5:\"title\";s:9:\"发短信\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:3:\"sms\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,6,'/sms/waitting','a:6:{s:5:\"title\";s:12:\"待发列表\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:3:\"sms\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,7,'/sms/setting','a:6:{s:5:\"title\";s:12:\"短信接口\";s:11:\"description\";s:0:\"\";s:6:\"module\";s:3:\"sms\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,8,'/application/search','a:6:{s:5:\"title\";s:12:\"应用列表\";s:11:\"description\";s:6:\"列表\";s:6:\"module\";s:11:\"application\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,9,'/application/add','a:6:{s:5:\"title\";s:12:\"申请应用\";s:11:\"description\";s:12:\"申请应用\";s:6:\"module\";s:11:\"application\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}'),('role',2,10,'/application/interface','a:6:{s:5:\"title\";s:9:\"开发者\";s:11:\"description\";s:9:\"开发者\";s:6:\"module\";s:11:\"application\";s:8:\"quantity\";s:1:\"1\";s:9:\"inherited\";s:0:\"\";s:7:\"warning\";s:0:\"\";}');
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
INSERT INTO `data_field_user_mail` VALUES ('user',1,0,'mail6',1,'smtp.exmail.qq.com','noreply@berule.com','dev123456','noreply@berule.com','noreply','a:2:{s:10:\"smtpsecure\";s:3:\"ssl\";s:4:\"port\";s:3:\"465\";}'),('user',3,0,'mail1',1,'smtp.exmail.qq.com','chunhui.liu@berule.com','spring1993315','chunhui.liu@berule.com','刘春晖','a:2:{s:10:\"smtpsecure\";s:3:\"ssl\";s:4:\"port\";s:3:\"465\";}');
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
INSERT INTO `data_field_user_sms` VALUES ('user',1,0,'sms1',1,'184','bl1087','123456','贝螺网络科技','a:1:{s:7:\"overage\";s:1:\"1\";}'),('user',1,1,'sms2',1,'192','bl1090','123456','驰耐得轮胎','a:1:{s:7:\"overage\";s:5:\"16321\";}');
/*!40000 ALTER TABLE `data_field_user_sms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_field_user_weixin`
--

DROP TABLE IF EXISTS `data_field_user_weixin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_field_user_weixin` (
  `entity_type` varchar(32) NOT NULL DEFAULT '' COMMENT 'Entity Type',
  `entity_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Entity ID',
  `delta` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '复数排序',
  `field_user_weixin_name` varchar(32) NOT NULL DEFAULT '' COMMENT '应用名',
  `field_user_weixin_type` int(4) NOT NULL DEFAULT '1' COMMENT '公众号类型 1订阅号2服务号3企业号',
  `field_user_weixin_corpid` varchar(32) NOT NULL DEFAULT '' COMMENT '公司ID',
  `field_user_weixin_corpsecret` varchar(128) NOT NULL DEFAULT '' COMMENT '接口管理密钥',
  `field_user_weixin_token` varchar(128) NOT NULL DEFAULT '' COMMENT 'Token',
  `field_user_weixin_encodingaeskey` varchar(128) NOT NULL DEFAULT '' COMMENT '加密秘钥',
  `field_user_weixin_url` varchar(32) NOT NULL DEFAULT '' COMMENT '回调url',
  `field_user_weixin_options` longblob COMMENT '其它选项',
  PRIMARY KEY (`entity_type`,`entity_id`,`delta`),
  UNIQUE KEY `field_user_weixin_url` (`field_user_weixin_url`),
  KEY `entity_type_id` (`entity_type`,`entity_id`),
  KEY `entity_id` (`entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='用户微信配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_field_user_weixin`
--

LOCK TABLES `data_field_user_weixin` WRITE;
/*!40000 ALTER TABLE `data_field_user_weixin` DISABLE KEYS */;
INSERT INTO `data_field_user_weixin` VALUES ('user',1,0,'测试企业号',4,'wx6bfd35376cfc3d02','QLMzdryoP3st6gpE_VNWOPr4ti-0o1wg29-41wzf5wscPteL2fNSEmUueSQ-luD_','QBjKTtt3yMXOJ8QBDgsbB225MS','rHvdpPoMQ5ZlKL6DZQBEWNqcCZHC9q8t55EYNCIbndu','loveqzhi','a:0:{}');
/*!40000 ALTER TABLE `data_field_user_weixin` ENABLE KEYS */;
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
INSERT INTO `field_config` VALUES (1,'user','field_user_mail','a:1:{s:7:\"columns\";a:8:{s:4:\"name\";a:7:{s:11:\"description\";s:16:\"接口mail名称\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";s:0:\"\";s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:6:\"status\";a:7:{s:11:\"description\";s:21:\"1正常,2无法连接\";s:4:\"type\";s:3:\"int\";s:7:\"default\";s:1:\"1\";s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:4:\"host\";a:7:{s:11:\"description\";s:4:\"host\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";s:0:\"\";s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:8:\"username\";a:7:{s:11:\"description\";s:9:\"用户名\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";N;s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:8:\"password\";a:7:{s:11:\"description\";s:6:\"密码\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";N;s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:4:\"from\";a:7:{s:11:\"description\";s:12:\"发送来自\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";N;s:8:\"not null\";b:0;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:8:\"fromname\";a:7:{s:11:\"description\";s:12:\"发送机构\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";N;s:8:\"not null\";b:0;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:7:\"options\";a:7:{s:11:\"description\";s:12:\"其它选项\";s:4:\"type\";s:8:\"longblob\";s:7:\"default\";N;s:8:\"not null\";b:0;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}}}',1,0),(2,'role','field_role_permission','a:1:{s:7:\"columns\";a:2:{s:10:\"permission\";a:7:{s:11:\"description\";s:12:\"权限名称\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";s:0:\"\";s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:4:\"data\";a:7:{s:11:\"description\";s:21:\"权限序列化数据\";s:4:\"type\";s:8:\"longblob\";s:7:\"default\";N;s:8:\"not null\";b:0;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}}}',1,0),(3,'mail','field_mail_data','a:1:{s:7:\"columns\";a:8:{s:7:\"address\";a:7:{s:11:\"description\";s:12:\"发送目标\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";s:0:\"\";s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:7:\"replyto\";a:7:{s:11:\"description\";s:6:\"回复\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";s:1:\"1\";s:8:\"not null\";b:0;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:2:\"cc\";a:7:{s:11:\"description\";s:6:\"抄送\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";s:0:\"\";s:8:\"not null\";b:0;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:3:\"bcc\";a:7:{s:11:\"description\";s:6:\"秘送\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";N;s:8:\"not null\";b:0;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:7:\"is_html\";a:7:{s:11:\"description\";s:10:\"是否html\";s:4:\"type\";s:3:\"int\";s:7:\"default\";s:1:\"0\";s:8:\"not null\";b:0;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:7:\"subject\";a:7:{s:11:\"description\";s:6:\"标题\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";N;s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:4:\"body\";a:7:{s:11:\"description\";s:6:\"正文\";s:4:\"type\";s:8:\"longblob\";s:7:\"default\";N;s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:7:\"altbody\";a:7:{s:11:\"description\";s:7:\"altbody\";s:4:\"type\";s:8:\"longblob\";s:7:\"default\";N;s:8:\"not null\";b:0;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}}}',1,0),(4,'user','field_user_sms','a:1:{s:7:\"columns\";a:7:{s:4:\"name\";a:7:{s:11:\"description\";s:16:\"接口mail名称\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";s:0:\"\";s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:6:\"status\";a:7:{s:11:\"description\";s:15:\"1正常,2无效\";s:4:\"type\";s:3:\"int\";s:7:\"default\";s:1:\"1\";s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:6:\"userid\";a:7:{s:11:\"description\";s:8:\"企业ID\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";s:0:\"\";s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:7:\"account\";a:7:{s:11:\"description\";s:9:\"用户名\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";N;s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:8:\"password\";a:7:{s:11:\"description\";s:6:\"密码\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";N;s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:4:\"sign\";a:7:{s:11:\"description\";s:6:\"签名\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";N;s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:7:\"options\";a:7:{s:11:\"description\";s:12:\"其它选项\";s:4:\"type\";s:8:\"longblob\";s:7:\"default\";N;s:8:\"not null\";b:0;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}}}',1,0),(5,'user','field_user_weixin','a:1:{s:7:\"columns\";a:8:{s:4:\"name\";a:7:{s:11:\"description\";s:9:\"应用名\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";s:0:\"\";s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:4:\"type\";a:7:{s:11:\"description\";s:46:\"公众号类型 1订阅号2服务号3企业号\";s:4:\"type\";s:3:\"int\";s:7:\"default\";s:1:\"1\";s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:6:\"corpid\";a:7:{s:11:\"description\";s:8:\"公司ID\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";s:0:\"\";s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:10:\"corpsecret\";a:7:{s:11:\"description\";s:18:\"接口管理密钥\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";s:0:\"\";s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:5:\"token\";a:7:{s:11:\"description\";s:5:\"Token\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";s:0:\"\";s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:14:\"encodingaeskey\";a:7:{s:11:\"description\";s:12:\"加密秘钥\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";s:0:\"\";s:8:\"not null\";b:1;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:3:\"url\";a:7:{s:11:\"description\";s:9:\"回调url\";s:4:\"type\";s:7:\"varchar\";s:7:\"default\";s:0:\"\";s:8:\"not null\";b:1;s:8:\"key type\";s:3:\"UNI\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}s:7:\"options\";a:7:{s:11:\"description\";s:12:\"其它选项\";s:4:\"type\";s:8:\"longblob\";s:7:\"default\";N;s:8:\"not null\";b:0;s:8:\"key type\";s:0:\"\";s:9:\"increment\";b:0;s:7:\"decimal\";i:0;}}}',1,0);
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
  `address` varchar(255) NOT NULL DEFAULT '' COMMENT '发送地址',
  `subject` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `status` int(4) NOT NULL DEFAULT '1' COMMENT '状态 1成功,4失败',
  `created` int(10) NOT NULL DEFAULT '0' COMMENT '生成时间',
  `updated` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `msgid` (`msgid`),
  KEY `uid` (`uid`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8 COMMENT='邮件发送记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mail`
--

LOCK TABLES `mail` WRITE;
/*!40000 ALTER TABLE `mail` DISABLE KEYS */;
INSERT INTO `mail` VALUES (1,1,'C420141224130706356515','mail6','836456126@qq.com','开发中请确定时间',1,1419415188,1419415188),(2,1,'C420141217150118515553','mail7','836456126@qq.com','我们在发是一条试试',1,1418799678,1419415955),(3,1,'C420141224181417519402','mail6','156894161@qq.com','你说什么',1,1419416057,1419416061),(4,1,'C420141224195317828128','mail6','hanson.huang@qq.com','this is a test email',1,1419421997,1419422002),(5,1,'C420141224195327381091','mail6','836456126@qq.com','测试一下就知道了啊',1,1419422007,1419422014),(6,1,'C420141225181025254637','mail6','836456126@qq.com','我在测试邮件发送看看',1,1419502225,1419502231),(7,1,'C42014122518115480063','mail6','836456126@qq.com','我在测试邮件发送看看',1,1419502314,1419502317),(8,1,'C420141229192536451513','mail6','836456126@qq.com','测试主题发送是否成功',1,1419852336,1419852343),(9,1,'C420141229194024436796','mail6','2207860301@qq.com','2014-12-29 19:30 我在测试中...',1,1419853224,1419853229),(10,1,'C420150102183407803314','mail6','836456126@qq.com','测试主题发送',1,1420194847,1420194855),(11,1,'C420150105130824996585','mail6','836456126@qq.com','发送邮件附件来一封',1,1420434504,1420434512),(12,3,'EC20150105151911117575','mail1','836456126@qq.com','12345',1,1420442351,1420445985),(13,3,'EC20150105162149985607','mail1','156894161@qq.ocm','明天要下雪',1,1420446109,1420446116),(14,1,'C420150105164004274052','mail6','156894161@qq.com','发送附件给你',1,1420447204,1420447222),(15,1,'C420150110212245622491','mail6','2207860301@qq.com','测试 主题邮件',1,1420896165,1420896351),(16,1,'C420150111233843149296','mail6','836456126@qq.com','发送主题邮件试试',1,1420990723,1420990728),(17,1,'C420150112084517260263','mail6','836456126@qq.com','早上测试发送',1,1421023517,1421023520),(18,1,'C420150112182206220748','mail6','836456126@qq.com','欢迎注册A-semi',1,1421058126,1421058131),(19,1,'C420150112183114277402','mail6','836456126@qq.com','欢迎注册A-semi',1,1421058674,1421058681),(20,1,'C420150112183508588509','mail6','836456126@qq.com','欢迎注册A-semi',1,1421058908,1421058916),(21,1,'C420150114131019215724','mail6','836456126@qq.com','虚拟主机空间xls',1,1421212219,1421212222),(22,1,'C420150114154301203262','mail6','2207860301@qq.com','2015-01-14 15:32 我在测试中...',1,1421221381,1421221389),(23,1,'C420150114160049475959','mail6','836456126@qq.com','让我们相约黄山看日出，数星星，打雪仗[黄山市] 新的申请【abctest】',1,1421222449,1421222457),(24,1,'C420150114160515905310','mail6','836456126@qq.com','让我们相约黄山看日出，数星星，打雪仗[黄山市] 新的申请【大圣归来】',1,1421222715,1421222722),(25,1,'C420150114160759555011','mail6','loveqzhi@163.com','让我们相约黄山看日出，数星星，打雪仗[黄山市] 新的申请【大圣归来】',1,1421222879,1421222887),(26,1,'C4201501141613297697','mail6','loveqzhi@163.com','让我们相约黄山看日出，数星星，打雪仗[黄山市] 新的申请【大圣归来】',1,1421223209,1421223217),(27,1,'C420150114174010743037','mail6','836456126@qq.com','A-semi 重置密码',1,1421228410,1421228417),(28,1,'C420150114174457828724','mail6','836456126@qq.com','A-semi 重置密码',1,1421228697,1421228708),(29,1,'C420150114175157324426','mail6','836456126@qq.com','A-semi 重置密码',1,1421229117,1421229123),(30,1,'C420150114175436389812','mail6','loveqzhi@163.com','A-semi 重置密码',1,1421229276,1421229286),(31,1,'C42015011418221077511','mail6','loveqzhi@163.com','A-semi 重置密码',1,1421230930,1421230938),(32,1,'C420150114182426763671','mail6','loveqzhi@163.com','A-semi 重置密码',1,1421231066,1421231073),(33,1,'C420150115175249508878','mail6','loveqzhi@163.com','A-semi 重置密码',1,1421315569,1421315577),(34,1,'C420150115184845326036','mail6','836456126@qq.com','A-semi 来访信件【上海贝罗科技 大圣归来】',1,1421318925,1421318932),(35,1,'C420150116110139732359','mail6','156894161@qq.com','欢迎注册A-semi',1,1421377299,1421377306),(36,1,'C420150120161039654516','mail6','836456126@qq.com','2015年F1赛车中国大奖赛上海站 新的申请【テスト】',1,1421741439,1421741444),(37,1,'C42015012016353682472','mail6','yiteng1979@gmail.com','欢迎注册A-semi',1,1421742936,1421742943),(38,1,'C420150121160925331768','mail6','yiteng1979@gmail.com','A-semi 重置密码',1,1421827765,1421827768),(39,1,'C420150121175736629802','mail6','55510696@qq.com','this is a test email',1,1421834256,1421834259),(40,1,'C420150126155823445298','mail6','2207860301@qq.com','测试一封邮件',1,1422259103,1422259118),(41,1,'C420150213170201945707','mail6','836456126@qq.com','发送测试邮件',1,1423818121,1423818126),(42,1,'C420150213170231229242','mail6','836456126@qq.com','附件测试',1,1423818151,1423818158),(43,1,'C420150213171029549500','mail6','836456126@qq.com','11111111',1,1423818629,1423818641),(44,1,'C420150213171140432323','mail6','836456126@qq.com','3333333',1,1423818700,1423818706),(45,1,'C420150213171231626671','mail6','836456126@qq.com','22222222',1,1423818751,1423818756),(46,1,'C420150213171259698964','mail6','836456126@qq.com','444444444',1,1423818779,1423818788),(47,1,'C420150213171435382579','mail6','836456126@qq.com','123',1,1423818875,1423818883),(48,1,'C420150213171548446098','mail6','836456126@qq.com','测试一下',1,1423818948,1423818954),(49,1,'C420150213232721835828','mail6','836456126@qq.com','测试邮件来一份',1,1423841241,1423841247),(50,1,'C420150213232939159835','mail6','836456126@qq.com','主题测试附件测试',1,1423841379,1423841386),(51,1,'C42015021810582638399','mail6','yiteng1979@gmail.com','中国のワーク・ライフ・バランスが生産、物流現場に与える影響 新的申请【dsdsda】',1,1424396638,1424396645),(52,1,'C420150220094516674192','mail6','yiteng1979@gmail.com','中国のワーク・ライフ・バランスが生産、物流現場に与える影響 新的申请【dfsdfaf\'d\'f\'sa\'d\'f\'sa】',1,1424396716,1424396722),(53,1,'C420150226153254778991','mail6','loveqzhi@163.com','2015年上海家电展 新的申请【grehgre】',1,1424935974,1424935980),(54,1,'C420150226153323623048','mail6','loveqzhi@163.com','2015年上海家电展 新的申请【jtyjyte】',1,1424936003,1424936011),(55,1,'C420150226154318322885','mail6','836456126@qq.com','欢迎注册A-semi',1,1424936598,1424936603),(56,1,'C420150226155643482148','mail6','836456126@qq.com','欢迎注册A-semi',1,1424937403,1424937405),(57,1,'C420150226160130310100','mail6','836456126@qq.com','欢迎注册A-semi',1,1424937690,1424937698),(58,1,'C420150226161043318928','mail6','836456126@qq.com','A-semi パスワード再設定',1,1424938243,1424938244),(59,1,'C420150226161946212753','mail6','836456126@qq.com','A-semi パスワード再設定',1,1424938786,1424938791),(60,1,'C420150227142739313336','mail6','836456126@qq.com','活动测试中 イベントへの新規お問い合わせ【小小猎头】',1,1425018459,1425018469),(61,1,'C420150227152120814667','mail6','loveqzhi@163.com','2015年上海家电展 イベントへの新規お問い合わせ【jtyjyte】',1,1425021680,1425021685),(62,1,'C420150227152403187119','mail6','836456126@qq.com','让我们相约黄山看日出，数星星，打雪仗[黄山市] イベントへの新規お問い合わせ【loveqzhi】',1,1425021843,1425021848),(63,1,'C42015030518044928536','mail6','yiteng1979@gmail.com','欢迎注册A-semi',1,1425549889,1425626825),(64,1,'C420150310174131701003','mail6','836456126@qq.com','测试返回',1,1425980491,1425980508),(65,1,'C420150310185331915601','mail6','8364561126@qq.com','你有新的报名录入',4,1425984811,1425984819),(66,1,'C420150310185423488692','mail6','836456126@qq.com','你有新的报名录入',1,1425984863,1425984867),(67,1,'C420150310191202149096','mail6','836456126@qq.com','你有新的报名录入',1,1425985922,1425985929),(68,1,'C420150310191444201003','mail6','836456126@qq.com','你有新的报名录入',1,1425986084,1425986091),(69,1,'C420150310192138330366','mail6','836456126@qq.com','你有新的报名录入',1,1425986498,1425986503),(70,1,'C420150311104018299341','mail6','836456126@qq.com','你有新的报名录入',1,1426041618,1426041627),(71,1,'C420150311162406189980','mail6','836456126@qq.com','你有新的报名录入',1,1426062246,1426062253),(72,1,'C420150313135157887538','mail6','836456126@qq.com','你有新的报名录入',1,1426225917,1426225922),(73,1,'C42015031313530649500','mail6','836456126@qq.com','你有新的报名录入',1,1426225986,1426225994),(74,1,'C420150321092140507248','mail6','loveqzhi@163.com','测试异步异步邮件发送',1,1426900900,1426900904),(75,1,'C420150327104919420936','mail6','836456126@qq.com','你有新的访问者',1,1427424559,1427424565),(76,1,'C420150327105244877842','mail6','china@sonosite.com','你有新的访问者',1,1427424764,1427424772),(77,1,'C420150327105706846547','mail6','china@sonosite.com','你有新的访问者',1,1427425026,1427425035),(78,1,'C420150327114820341852','mail6','836456126@qq.com','测试主题发送',1,1427428100,1427428108),(79,1,'C420150328162153653937','mail6','china@sonosite.com','你有新的访问者',1,1427530913,1427530920),(80,1,'C420150331143553916176','mail6','836456126@qq.com','你有新的访问者',1,1427783753,1427783772),(81,1,'C42015033114382146276','mail6','836456126@qq.com','你有新的访问者',1,1427783901,1427783909),(82,1,'C42015040909465615029','mail6','china@sonosite.com','你有新的访问者',1,1428544016,1428544022),(83,1,'C420150410113944440094','mail6','836456126@qq.com','你有新的报名录入',1,1428637184,1428637197),(84,1,'C420150410152749266213','mail6','china@sonosite.com','你有新的访问者',1,1428650869,1428650875),(85,1,'C420150410152749829141','mail6','china@sonosite.com','你有新的访问者',1,1428650869,1428650876),(86,1,'C420150410155751447742','mail6','836456126@qq.com','测试发送',1,1428652671,1428652680),(87,1,'C420150410163745631313','mail6','china@sonosite.com','你有新的报名录入',1,1428655065,1428655074),(88,1,'C420150421215411480248','mail6','china@sonosite.com','你有新的访问者',1,1429624451,1429624460),(89,1,'C420150423065925350059','mail6','china@sonosite.com','你有新的访问者',1,1429743565,1429743575),(90,1,'C420150428233433281992','mail6','china@sonosite.com','你有新的访问者',1,1430235273,1430235278),(91,1,'C420150428233433496724','mail6','china@sonosite.com','你有新的访问者',1,1430235273,1430235280),(92,1,'C42015050220361827263','mail6','china@sonosite.com','你有新的访问者',1,1430570178,1431931539),(93,1,'C42015052017341779778','mail6','china@sonosite.com','你有新的访问者',1,1432114457,1432114463),(94,1,'C420150430150921280367','mail6','china@sonosite.com','你有新的访问者',1,1432264042,1432264051),(95,1,'C420150525172645965822','mail6','836456126@qq.com','线上测试邮件服务',1,1432546005,1432546016),(96,1,'C420150527163028648485','mail6','836456126@qq.com','继续测试一天后worker是否活着',1,1432715428,1432715436),(97,1,'C420150601115349829872','mail6','2207860301@qq.com','测试worker是否挂了',1,1433130829,1433130834),(98,1,'C420150604121445812247','mail6','china@sonosite.com','你有新的报名录入',1,1433391285,1433391295);
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
) ENGINE=InnoDB AUTO_INCREMENT=390 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='短信发送记录表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms`
--

LOCK TABLES `sms` WRITE;
/*!40000 ALTER TABLE `sms` DISABLE KEYS */;
INSERT INTO `sms` VALUES (1,1,'C420150104180500176281','419934','sms1','18616934147','【贝螺网络科技】你的验证码为：xxxbb333',1,1420365900,1420365905),(2,1,'C420150104180951376903','419941','sms1','18918891440','【贝螺网络科技】你的验证码：132156464646516',1,1420366191,1420366195),(3,1,'C420150104181420963138','419946','sms2','18918891440','【驰耐得轮胎】测试：刚和我UI更换过更好饿哦我关怀刚不过热卡轨让给I个人娃儿UI高',1,1420366460,1420366466),(4,1,'C420150107175126238145','432409','sms2','13661953805','【驰耐得轮胎】感谢你登录我们系统，你的密码是d9yas8',1,1420624286,1420624289),(5,1,'C420150108095700368488','435427','sms2','13382899198','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是myb2ws,请尽快修改密码',1,1420682220,1420683463),(6,1,'C420150108100313448005','435428','sms2','18671166679','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是myb2ws,请尽快修改密码',1,1420682593,1420683463),(7,1,'C420150107163932306391','435483','sms2','18616934147','【驰耐得轮胎】感谢你登录我们系统，你的密码是x73kg2',1,1420619972,1420683622),(8,1,'C420150108092353389403','435485','sms2','13661953805','【驰耐得轮胎】感谢你登录我们系统，你的密码是 d9yas8',1,1420680233,1420683622),(9,1,'C420150108102937551627','435539','sms2','18918891440','【驰耐得轮胎】【驰耐得轮胎】感谢你登录我们系统，你的密码是xxxxx',1,1420684177,1420684183),(10,1,'C420150108103252479528','435573','sms2','13524184107','【驰耐得轮胎】【驰耐得轮胎】测试,感谢你登录我们系统，你的密码是xxxxx',1,1420684372,1420684378),(11,1,'C420150108103257782399','435574','sms2','17092232218','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是myb2ws,请尽快修改密码',1,1420684377,1420684383),(12,1,'C420150108103301387460','435575','sms2','17092232218','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是myb2ws,请尽快修改密码',1,1420684381,1420684383),(13,1,'C42015010810462268550','435680','sms2','17092232218','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是myb2ws,请尽快修改密码',1,1420685182,1420685188),(14,1,'C420150108104922778290','435695','sms2','15161530198','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是myb2ws,请尽快修改密码',1,1420685362,1420685368),(15,1,'C420150108105237545136','435721','sms2','13524184107','【驰耐得轮胎】测试,感谢你登录我们系统，你的密码是xxxxxx',1,1420685557,1420685564),(16,1,'C4201501081057268838','435752','sms2','15901781773','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是1234,请尽快修改密码',1,1420685846,1420685849),(17,1,'C420150108111111135309','435847','sms2','13876899970','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是sb25rs,请尽快修改密码',1,1420686671,1420686674),(18,1,'C420150108111936157060','435897','sms2','13776703872','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是n6fgxq,请尽快修改密码',1,1420687176,1420687179),(19,1,'C420150108113023213966','435953','sms2','13776703872','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是n6fgxq,请尽快修改密码',1,1420687823,1420687829),(20,1,'C420150108124322445536','436221','sms2','13627004886','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是6xaf5x,请尽快修改密码',1,1420692202,1420692205),(21,1,'C420150108125855671523','436282','sms2','13605609385','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是rbuxtr,请尽快修改密码',1,1420693135,1420693140),(22,1,'C420150108125859780885','436283','sms2','13605609385','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是rbuxtr,请尽快修改密码',1,1420693139,1420693145),(23,1,'C420150108131302900422','436347','sms2','13220585758','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是9eavch,请尽快修改密码',1,1420693982,1420693985),(24,1,'C420150108132354132496','436395','sms2','13863890011','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是suaa8x,请尽快修改密码',1,1420694634,1420694641),(25,1,'C420150108151747889551','437098','sms2','13142898513','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是m52mka,请尽快修改密码',1,1420701467,1420701471),(26,1,'C420150108155520678438','437246','sms2','13912074010','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是nh7xyf,请尽快修改密码',1,1420703720,1420703727),(27,1,'C420150108165117556162','437710','sms2','13502066266','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是37ct3x,请尽快修改密码',1,1420707077,1420707082),(28,1,'C42015010816550877024','437744','sms2','13502039231','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是fu8vf7,请尽快修改密码',1,1420707308,1420707312),(29,1,'C420150108170228862777','437803','sms2','13605609385','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是rbuxtr,请尽快修改密码',1,1420707748,1420707753),(30,1,'C420150108170713969121','437840','sms2','18861814646','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是t6s3mx,请尽快修改密码',1,1420708033,1420708038),(31,1,'C420150108172437594197','437968','sms2','18234003937','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是rd3ayk,请尽快修改密码',1,1420709077,1420709083),(32,1,'C420150108180338993257','438183','sms2','13870955372','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是72fhca,请尽快修改密码',1,1420711418,1420711423),(33,1,'C420150108191957452414','438557','sms2','15261791608','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是4a2nue,请尽快修改密码',1,1420715997,1420715999),(34,1,'C420150108192002733630','438560','sms2','13554105027','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是a9wee4,请尽快修改密码',1,1420716002,1420716009),(35,1,'C420150108192355681959','438582','sms2','15261791608','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是4a2nue,请尽快修改密码',1,1420716235,1420716239),(36,1,'C420150108203501779156','438885','sms2','15079186673','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是ec5ben,请尽快修改密码',1,1420720501,1420720504),(37,1,'C420150108205732461671','438981','sms2','15079186673','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是ec5ben,请尽快修改密码',1,1420721852,1420721855),(38,1,'C420150108205927470742','438993','sms2','15079186673','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是ec5ben,请尽快修改密码',1,1420721967,1420721970),(39,1,'C420150108215356727005','439259','sms2','13627004886','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是6xaf5x,请尽快修改密码',1,1420725236,1420725240),(40,1,'C420150108221807757185','439384','sms2','13755697610','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是hl7mhc,请尽快修改密码',1,1420726687,1420726690),(41,1,'C420150109082908153532','439919','sms2','13967484431','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是y59jdb,请尽快修改密码',1,1420763348,1420768676),(42,1,'C420150109083330324882','439920','sms2','13967484431','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是y59jdb,请尽快修改密码',1,1420763610,1420768676),(43,1,'C420150109085005510518','439921','sms2','13967484431','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是y59jdb,请尽快修改密码',1,1420764605,1420768677),(44,1,'C420150109085314721278','439922','sms2','13967484431','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是y59jdb,请尽快修改密码',1,1420764794,1420768677),(45,1,'C420150109085622839303','439923','sms2','18664913917','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是apfgt3,请尽快修改密码',1,1420764982,1420768677),(46,1,'C420150109085725732845','439924','sms2','18664913917','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是apfgt3,请尽快修改密码',1,1420765045,1420768677),(47,1,'C420150109085931972887','439925','sms2','13967484431','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是y59jdb,请尽快修改密码',1,1420765171,1420768677),(48,1,'C420150109090138912988','439926','sms2','13661953805','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是d9yas8,请尽快修改密码',1,1420765298,1420768677),(49,1,'C420150109082745668683','439945','sms2','13967484431','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是y59jdb,请尽快修改密码',1,1420763265,1420768897),(50,1,'C420150109101315215357','440013','sms2','13634293584','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是jeqy59,请尽快修改密码',1,1420769595,1420769598),(51,1,'C420150109104452503715','440362','sms2','15142508658','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是mtux7c,请尽快修改密码',1,1420771492,1420771498),(52,1,'C420150109120637477474','440996','sms2','15852722126','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是kgu2x2,请尽快修改密码',1,1420776397,1420776398),(53,1,'C420150109144444748120','441824','sms2','15866735971','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是7ymnkb,请尽快修改密码',1,1420785884,1420785889),(54,1,'C420150109161709497177','442399','sms2','18653131086','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是fy4gra,请尽快修改密码',1,1420791429,1420791438),(55,1,'C42015010916174845669','442405','sms2','13583115316','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是66ph62,请尽快修改密码',1,1420791468,1420791473),(56,1,'C420150109161840924296','442410','sms2','13969166589','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是ksgzlx,请尽快修改密码',1,1420791520,1420791523),(57,1,'C42015010916194397781','442422','sms2','13583115316','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是66ph62,请尽快修改密码',1,1420791583,1420791588),(58,1,'C420150109162216898347','442452','sms2','13583115316','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是66ph62,请尽快修改密码',1,1420791736,1420791738),(59,1,'C420150109162248418312','442455','sms2','13953144307','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是26e5al,请尽快修改密码',1,1420791768,1420791773),(60,1,'C420150109162551314066','442488','sms2','13583115316','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是66ph62,请尽快修改密码',1,1420791951,1420791959),(61,1,'C420150109170357216782','442845','sms2','13319203942','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是5xvfdm,请尽快修改密码',1,1420794237,1420794240),(62,1,'C420150109172445913756','443038','sms2','13319203942','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是5xvfdm,请尽快修改密码',1,1420795485,1420795490),(63,1,'C420150109172555979112','443047','sms2','15809292621','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是tjlzht,请尽快修改密码',1,1420795555,1420795560),(64,1,'C420150109173105255753','443092','sms2','15979008240','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是8eg3v4,请尽快修改密码',1,1420795865,1420795870),(65,1,'C420150109174510609296','443173','sms2','18792416393','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是kntkdz,请尽快修改密码',1,1420796710,1420796716),(66,1,'C420150109174617846625','443184','sms2','18792416393','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是kntkdz,请尽快修改密码',1,1420796777,1420796781),(67,1,'C420150109174802804764','443198','sms2','18792416393','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是kntkdz,请尽快修改密码',1,1420796882,1420796886),(68,1,'C420150109174804223287','443199','sms2','13319203942','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是5xvfdm,请尽快修改密码',1,1420796884,1420796886),(69,1,'C420150109193155378570','443643','sms2','13812070398','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是wrwnsz,请尽快修改密码',1,1420803115,1420803117),(70,1,'C420150109212720101683','444233','sms2','15057833380','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是8nr5xr,请尽快修改密码',1,1420810040,1420810043),(71,1,'C420150110081917577905','444951','sms2','15901781773','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是1234,请尽快修改密码',1,1420849157,1420849160),(72,1,'C420150110092859232104','445051','sms2','13319203942','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是5xvfdm,请尽快修改密码',1,1420853339,1420853345),(73,1,'C420150110094322474230','445072','sms2','18691336790','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是j5rp6l,请尽快修改密码',1,1420854202,1420854206),(74,1,'C420150110095537144711','445097','sms2','15081144455','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是hf83zb,请尽快修改密码',1,1420854937,1420854941),(75,1,'C420150110112108766349','445257','sms2','13095513393','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是32jnhn,请尽快修改密码',1,1420860068,1420860071),(76,1,'C4201501101202433093','445366','sms2','13575916075','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是fk9kcw,请尽快修改密码',1,1420862563,1420862567),(77,1,'C420150110124130904729','445454','sms2','15860611363','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是aya8gr,请尽快修改密码',1,1420864890,1420864892),(78,1,'C420150110144455162668','446340','sms2','13876899970','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是sb25rs,请尽快修改密码',1,1420872295,1420881963),(79,1,'C420150110150831195038','446341','sms2','15665888799','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是r2e2rw,请尽快修改密码',1,1420873711,1420881964),(80,1,'C420150110151159110664','446342','sms2','15665888799','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是r2e2rw,请尽快修改密码',1,1420873919,1420881964),(81,1,'C420150110152147524446','446343','sms2','15665888799','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是r2e2rw,请尽快修改密码',1,1420874507,1420881964),(82,1,'C420150110081411428136','447149','sms2','15901781773','【驰耐得轮胎】【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是1234,请尽快修改密码',1,1420848851,1420895030),(83,1,'C420150111112042930919','448042','sms2','15901781773','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是d9yas8,请尽快修改密码',1,1420946442,1420946450),(84,1,'C420150111112207236792','448052','sms2','13661953805','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是d9yas8,请尽快修改密码',1,1420946527,1420946535),(85,1,'C420150111113121820273','448085','sms2','18876876825','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是jls2zv,请尽快修改密码',1,1420947081,1420947090),(86,1,'C42015011111341277808','448093','sms2','13812081779','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是u3vpf9,请尽快修改密码',1,1420947252,1420947260),(87,1,'C420150111114325427773','448120','sms2','15035311651','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是cdaqzg,请尽快修改密码',1,1420947805,1420947810),(88,1,'C420150111115014855749','448132','sms2','18652258480','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是eqtcnh,请尽快修改密码',1,1420948214,1420948216),(89,1,'C420150111120611567144','448152','sms2','13661953805','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是d9yas8,请尽快修改密码',1,1420949171,1420949176),(90,1,'C420150111123647274857','448210','sms2','13755697610','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是hl7mhc,请尽快修改密码',1,1420951007,1420951011),(91,1,'C420150111131734294223','448301','sms2','13710686164','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是qavpll,请尽快修改密码',1,1420953454,1420953457),(92,1,'C420150111160818113369','448745','sms2','13178027286','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是vhztsr,请尽快修改密码',1,1420963698,1420963702),(93,1,'C420150111105547411758','449064','sms2','13661953805','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是d9yas8,请尽快修改密码',1,1420944947,1420967828),(94,1,'C420150111173621238772','449137','sms2','13672249879','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是gtefcr,请尽快修改密码',1,1420968981,1420968983),(95,1,'C420150111175811629079','449228','sms2','18842455339','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是stqj3t,请尽快修改密码',1,1420970291,1420970294),(96,1,'C420150111234028606075','450367','sms1','18616934147','【贝螺网络科技】您的验证码是xybf87.',1,1420990828,1420990832),(97,1,'C420150111234112191494','450369','sms1','15221816172','【贝螺网络科技】你的验证码是abc87f',1,1420990872,1420990877),(98,1,'C420150112084424956859','450589','sms2','15179168003','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是z9zlk4,请尽快修改密码',1,1421023464,1421023469),(99,1,'C420150112085116487529','450614','sms2','13816444231','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是39ta22,请尽快修改密码',1,1421023876,1421023879),(100,1,'C420150112085225365344','450623','sms2','13816444231','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是39ta22,请尽快修改密码',1,1421023945,1421023949),(101,1,'C420150112085928837743','450649','sms2','15179168003','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是z9zlk4,请尽快修改密码',1,1421024368,1421024374),(102,1,'C420150112092803198878','450798','sms2','13661953805','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是d9yas8,请尽快修改密码',1,1421026083,1421026084),(103,1,'C420150112095150591107','450961','sms2','13575911810','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是djhab5,请尽快修改密码',1,1421027510,1421027514),(104,1,'C420150112115911701696','453405','sms2','13575911810','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是djhab5,请尽快修改密码',1,1421035151,1421035155),(105,1,'C420150112131742177532','453771','sms2','18507955396','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是vgr2lb,请尽快修改密码',1,1421039862,1421039865),(106,1,'C420150112153708137205','454758','sms1','15901781773','【贝螺网络科技】你的验证码是abc325',1,1421048228,1421048235),(107,1,'C420150113084652370845','457503','sms2','13810648839','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是792d39,请尽快修改密码',1,1421110012,1421110017),(108,1,'C420150113103032303976','457903','sms2','15809292621','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是tjlzht,请尽快修改密码',1,1421116232,1421116237),(109,1,'C420150113123256697748','458474','sms2','13632436980','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是3vd236,请尽快修改密码',1,1421123576,1421123582),(110,1,'C420150113145413703039','459324','sms2','15068859669','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是zd4rdp,请尽快修改密码',1,1421132053,1421132057),(111,1,'C420150113150300383305','459487','sms2','15068859669','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是zd4rdp,请尽快修改密码',1,1421132580,1421132582),(112,1,'C420150113150359322756','459506','sms2','15068859669','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是zd4rdp,请尽快修改密码',1,1421132639,1421132642),(113,1,'C420150113151315125988','459608','sms2','15068859669','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是zd4rdp,请尽快修改密码',1,1421133195,1421133197),(114,1,'C420150115113644217463','469339','sms2','18727479526','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是tw4d76,请尽快修改密码',1,1421293004,1421293004),(115,1,'C420150115150342540135','470189','sms2','13661953805','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是d9yas8,请尽快修改密码',1,1421305422,1421305430),(116,1,'C420150115194307481160','471541','sms2','18507955396','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是vgr2lb,请尽快修改密码',1,1421322187,1421322192),(117,1,'C420150116125325448453','473646','sms2','18842507356','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是bql4yy,请尽快修改密码',1,1421384005,1421384009),(118,1,'C420150116141629391688','474015','sms2','13622240066','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是p3uzv8,请尽快修改密码',1,1421388989,1421388994),(119,1,'C420150116142413102343','474064','sms2','13825041000','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是v7hapq,请尽快修改密码',1,1421389453,1421389459),(120,1,'C420150116144140774345','474156','sms2','13622240066','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是p3uzv8,请尽快修改密码',1,1421390500,1421390504),(121,1,'C420150117100835184173','476899','sms2','18702096218','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是qhdwdu,请尽快修改密码',1,1421460515,1421460522),(122,1,'C420150117110509739820','477098','sms2','18940290380','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是czjtw2,请尽快修改密码',1,1421463909,1421463912),(123,1,'C420150117084757653418','477119','sms2','18931842188','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是xspd2t,请尽快修改密码',1,1421455677,1421464440),(124,1,'C420150117100551679472','477120','sms2','18702096218','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是qhdwdu,请尽快修改密码',1,1421460351,1421464440),(125,1,'C420150117140430333211','477456','sms2','13812521808','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是3x67cs,请尽快修改密码',1,1421474670,1421474675),(126,1,'C420150117144355443898','477555','sms2','13812521808','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是3x67cs,请尽快修改密码',1,1421477035,1421477041),(127,1,'C420150118193755288679','481185','sms2','15081144455','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是hf83zb,请尽快修改密码',1,1421581075,1421581080),(128,1,'C420150118145850503749','482079','sms2','15081144455','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是hf83zb,请尽快修改密码',1,1421564330,1421629703),(129,1,'C420150118083321255298','482080','sms2','13816444231','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是39ta22,请尽快修改密码',1,1421541201,1421629703),(130,1,'C420150119090616873676','482081','sms2','13757960363','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是anxlk2,请尽快修改密码',1,1421629576,1421629703),(131,1,'C420150119091111965006','482087','sms2','13685831585','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是cdkd9b,请尽快修改密码',1,1421629871,1421629878),(132,1,'C420150119102830440308','482592','sms2','18636679826','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是aqcx5b,请尽快修改密码',1,1421634510,1421634513),(133,1,'C420150119115302389369','483282','sms2','13685831585','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是cdkd9b,请尽快修改密码',1,1421639582,1421639583),(134,1,'C420150119115735867321','483303','sms2','13757960363','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是anxlk2,请尽快修改密码',1,1421639855,1421639858),(135,1,'C420150119175541881669','485589','sms2','15179168003','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是z9zlk4,请尽快修改密码',1,1421661341,1421661349),(136,1,'C420150119213553804237','486565','sms2','18605284248','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是5zd6bx,请尽快修改密码',1,1421674553,1421674560),(137,1,'C420150120132444412017','488820','sms2','18507955396','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是vgr2lb,请尽快修改密码',1,1421731484,1421731487),(138,1,'C420150120180104596514','490641','sms2','15879145855','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是k9aajh,请尽快修改密码',1,1421748064,1421748068),(139,1,'C420150121151713574072','494010','sms2','18009151788','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是hhzgn2,请尽快修改密码',1,1421824633,1421824637),(140,1,'C420150121155647161286','494237','sms2','18009151788','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是hhzgn2,请尽快修改密码',1,1421827007,1421827012),(141,1,'C420150122151341278668','498700','sms2','13812521808','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是3x67cs,请尽快修改密码',1,1421910821,1421910824),(142,1,'C420150124134047766753','506427','sms2','13755697610','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是hl7mhc,请尽快修改密码',1,1422078047,1422078051),(143,1,'C420150125130447494931','509070','sms2','13583115316','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是66ph62,请尽快修改密码',1,1422162287,1422162295),(144,1,'C420150125133707360675','509161','sms2','15261791608','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是4a2nue,请尽快修改密码',1,1422164227,1422164238),(145,1,'C42015012513403260027','509172','sms2','13776703872','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是n6fgxq,请尽快修改密码',1,1422164432,1422164440),(146,1,'C420150125151438454743','509436','sms2','13583115316','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是66ph62,请尽快修改密码',1,1422170078,1422170085),(147,1,'C420150125154923251517','509536','sms2','13825041000','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是v7hapq,请尽快修改密码',1,1422172163,1422172170),(148,1,'C420150126094717197479','511448','sms2','13583115316','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是66ph62,请尽快修改密码',1,1422236837,1422236842),(149,1,'C420150126094112635247','511456','sms2','13583115316','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是66ph62,请尽快修改密码',1,1422236472,1422236902),(150,1,'C420150126094039631534','511457','sms2','13661953805','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是d9yas8,请尽快修改密码',1,1422236439,1422236902),(151,1,'C420150126095134582478','511487','sms2','13661953805','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是d9yas8,请尽快修改密码',1,1422237094,1422237102),(152,1,'C420150126100718686891','511619','sms2','15808945370','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是5pc5ln,请尽快修改密码',1,1422238038,1422238042),(153,1,'C420150126101334297367','511661','sms2','18107600139','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是jpp52y,请尽快修改密码',1,1422238414,1422238422),(154,1,'C420150126110943230704','512079','sms2','13861842602','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是5bkt7d,请尽快修改密码',1,1422241783,1422241787),(155,1,'C420150126113646182533','512279','sms2','13588665182','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是h484y5,请尽快修改密码',1,1422243406,1422243412),(156,1,'C420150126122554249408','512547','sms2','15261791608','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是4a2nue,请尽快修改密码',1,1422246354,1422246357),(157,1,'C420150127121443871848','517806','sms2','18727585121','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是gvlmlz,请尽快修改密码',1,1422332083,1422332087),(158,1,'C420150127145310939079','518794','sms2','18727585121','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是gvlmlz,请尽快修改密码',1,1422341590,1422341592),(159,1,'C420150127145659789893','518811','sms2','18035109575','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是cvrash,请尽快修改密码',1,1422341819,1422341822),(160,1,'C420150127150403450386','518854','sms2','18672651984','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是qhrthr,请尽快修改密码',1,1422342243,1422342247),(161,1,'C420150127150548910540','518867','sms2','18672651984','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是qhrthr,请尽快修改密码',1,1422342348,1422342352),(162,1,'C420150127151022485264','518896','sms2','13876369678','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是ncrmu7,请尽快修改密码',1,1422342622,1422342627),(163,1,'C420150127184541168569','520391','sms2','13924172256','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是6sjxw2,请尽快修改密码',1,1422355541,1422355543),(164,1,'C420150128105252883159','522895','sms2','13986005305','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是btx66n,请尽快修改密码',1,1422413572,1422415555),(165,1,'C420150128105546328426','522896','sms2','18672890356','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是hzq5zj,请尽快修改密码',1,1422413746,1422415556),(166,1,'C420150128145756463834','523978','sms2','15829344668','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是ms2ye6,请尽快修改密码',1,1422428276,1422428285),(167,1,'C420150128145834840093','523984','sms2','15829344668','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是ms2ye6,请尽快修改密码',1,1422428314,1422428320),(168,1,'C420150128150014329340','523993','sms2','15829344668','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是ms2ye6,请尽快修改密码',1,1422428414,1422428420),(169,1,'C420150128155029180497','524183','sms2','13825092880','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是v2w6kn,请尽快修改密码',1,1422431429,1422431435),(170,1,'C420150128172659768039','524853','sms2','13886071953','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是t86kkj,请尽快修改密码',1,1422437219,1422437225),(171,1,'C420150129150526162864','528620','sms2','13659821151','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是v6x43k,请尽快修改密码',1,1422515126,1422515129),(172,1,'C420150129154738532161','528794','sms2','13667243286','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是7y6hea,请尽快修改密码',1,1422517658,1422517664),(173,1,'C420150129160055922452','528851','sms2','18972665557','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是u54ctv,请尽快修改密码',1,1422518455,1422518459),(174,1,'C420150129160140364095','528854','sms2','15827396485','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是gady5d,请尽快修改密码',1,1422518500,1422518504),(175,1,'C42015012917453749743','529652','sms2','13886070683','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是4gl3ws,请尽快修改密码',1,1422524737,1422524739),(176,1,'C420150129174609879321','529657','sms2','15172505201','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是femesv,请尽快修改密码',1,1422524769,1422524774),(177,1,'C420150131205319200439','539446','sms2','15035311651','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是cdaqzg,请尽快修改密码',1,1422708799,1422708804),(178,1,'C420150131205646491119','539471','sms2','15035311651','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是cdaqzg,请尽快修改密码',1,1422709006,1422709014),(179,1,'C420150201100641502293','541214','sms2','15035311651','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是cdaqzg,请尽快修改密码',1,1422756401,1422757584),(180,1,'C420150201103130100535','541224','sms2','15035311651','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是cdaqzg,请尽快修改密码',1,1422757890,1422757894),(181,1,'C420150201113612255741','541381','sms2','13695696079','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是zbnmws,请尽快修改密码',1,1422761772,1422761779),(182,1,'C420150201153333958609','541936','sms2','15013123419','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是gq63eq,请尽快修改密码',1,1422776013,1422776019),(183,1,'C420150202132844224663','545470','sms2','13776703872','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是n6fgxq,请尽快修改密码',1,1422854924,1422854928),(184,1,'C420150202143325204796','545972','sms2','18616934147','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是,请尽快修改密码',1,1422858805,1422858808),(185,1,'C420150202143404868360','545977','sms2','18616934147','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是3bkxfg,请尽快修改密码',1,1422858844,1422858848),(186,1,'C420150202144622202385','546055','sms2','18616934147','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是e38jxv,请尽快修改密码',1,1422859582,1422859588),(187,1,'C420150202161950886794','546664','sms2','18616934147','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是tnbkw5,请尽快修改密码',1,1422865190,1422865198),(188,1,'C42015020216255792189','546720','sms2','18616934147','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是s687tf,请尽快修改密码',1,1422865557,1422865563),(189,1,'C420150202171041230115','547148','sms2','18616934147','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是lhh7un,请尽快修改密码',1,1422868241,1422868248),(190,1,'C420150202171344466352','547167','sms1','18616934147','【贝螺网络科技】您的验证码是：xxx352d',1,1422868424,1422868429),(191,1,'C42015020300090755289','548832','sms1','18616934147','【贝螺网络科技】你的验证码是xxyydd',1,1422893347,1422893355),(192,1,'C420150203094851888724','549202','sms2','13661953805','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是d9yas8,请尽快修改密码',1,1422928131,1422928137),(193,1,'C420150203155934945400','551638','sms2','18757805584','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是qbnx2g,请尽快修改密码',1,1422950374,1422950378),(194,1,'C420150204181954624074','557413','sms2','13960168543','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是s9hda8,请尽快修改密码',1,1423045194,1423045199),(195,1,'C420150204215124507816','558234','sms2','13661953805','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是rbvk7r，请尽快修改密码',1,1423057884,1423057890),(196,1,'C420150204222502269258','558351','sms2','13605609385','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是t9hrtd，请尽快修改密码',1,1423059902,1423059907),(197,1,'C420150204235359833843','558596','sms2','15261791608','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是6esthr，请尽快修改密码',1,1423065239,1423065247),(198,1,'C420150204235402959166','558597','sms2','15261791608','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是6esthr，请尽快修改密码',1,1423065242,1423065247),(199,1,'C420150204235405821115','558598','sms2','15261791608','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是6esthr，请尽快修改密码',1,1423065245,1423065252),(200,1,'C420150205082911719192','558780','sms2','18876876825','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是pv4aqt，请尽快修改密码',1,1423096151,1423096154),(201,1,'C420150205084121926904','558807','sms2','13863890011','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是e43gaw，请尽快修改密码',1,1423096881,1423096884),(202,1,'C420150205082821292594','558811','sms2','15081144455','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是c5hkqz，请尽快修改密码',1,1423096101,1423096999),(203,1,'C420150205085010747883','558829','sms2','15142508658','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是n6uuva，请尽快修改密码',1,1423097410,1423097414),(204,1,'C420150205085616639014','558843','sms2','15035311651','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是526dlx，请尽快修改密码',1,1423097776,1423097784),(205,1,'C420150205090203467298','558867','sms2','15035311651','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是526dlx，请尽快修改密码',1,1423098123,1423098129),(206,1,'C420150205090247291223','558875','sms2','18755367895','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是k35kmk，请尽快修改密码',1,1423098167,1423098174),(207,1,'C420150205091109610505','558908','sms2','13803563050','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是ajy7rp，请尽快修改密码',1,1423098669,1423098674),(208,1,'C420150205091202884224','558910','sms2','13583115316','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是nvy3vw，请尽快修改密码',1,1423098722,1423098729),(209,1,'C420150205091613939286','558925','sms2','18507955396','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是2nqshl，请尽快修改密码',1,1423098973,1423098979),(210,1,'C42015020509164635052','558927','sms2','18507955396','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是2nqshl，请尽快修改密码',1,1423099006,1423099009),(211,1,'C420150205092126299993','558947','sms2','13220585758','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是tftanc，请尽快修改密码',1,1423099286,1423099289),(212,1,'C420150205092326130429','558960','sms2','13178027286','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是yqdpzn，请尽快修改密码',1,1423099406,1423099409),(213,1,'C420150205092617481748','558966','sms2','15988553268','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是sycpfv，请尽快修改密码',1,1423099577,1423099584),(214,1,'C420150205093331439561','558995','sms2','13967484431','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是3w3q4w，请尽快修改密码',1,1423100011,1423100014),(215,1,'C420150205093432300721','559002','sms2','13967484431','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是3w3q4w，请尽快修改密码',1,1423100072,1423100079),(216,1,'C420150205093905673361','559024','sms2','13575916075','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是zma7nd，请尽快修改密码',1,1423100345,1423100349),(217,1,'C420150205094811621727','559068','sms2','18664913917','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是9cm5ae，请尽快修改密码',1,1423100891,1423100894),(218,1,'C420150205094822791691','559069','sms2','18664913917','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是9cm5ae，请尽快修改密码',1,1423100902,1423100909),(219,1,'C420150205094917980920','559071','sms2','13637077327','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是6573zs，请尽快修改密码',1,1423100957,1423100964),(220,1,'C420150205095358593696','559100','sms2','18616934147','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是batest12，请尽快修改密码',1,1423101238,1423101244),(221,1,'C420150205095358508889','559101','sms2','18671166679','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是3kyg2s，请尽快修改密码',1,1423101238,1423101244),(222,1,'C420150205100229141690','559147','sms2','13870955372','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是yxb63d，请尽快修改密码',1,1423101749,1423101754),(223,1,'C420150205100637246982','559164','sms2','15860611363','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是j946gm，请尽快修改密码',1,1423101997,1423102004),(224,1,'C420150205102629859522','559266','sms2','13912074010','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是6k9e4r，请尽快修改密码',1,1423103189,1423103194),(225,1,'C420150205104530632302','559380','sms2','13095513393','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是vjqyz4，请尽快修改密码',1,1423104330,1423104335),(226,1,'C420150205105311746134','559420','sms2','18107600139','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是8aqyu2，请尽快修改密码',1,1423104791,1423104795),(227,1,'C420150205105854587430','559450','sms2','13825097595','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是4qbwvc，请尽快修改密码',1,1423105134,1423105140),(228,1,'C420150205105927513132','559455','sms2','13825087595','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是4qbwvc，请尽快修改密码',1,1423105167,1423105175),(229,1,'C420150205111726639799','559537','sms2','18234003937','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是g9p2k2，请尽快修改密码',1,1423106246,1423106250),(230,1,'C420150205111931332467','559556','sms2','15809292621','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是nrct8l，请尽快修改密码',1,1423106371,1423106375),(231,1,'C420150205112509177719','559588','sms2','15852722126','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是uhgg7z，请尽快修改密码',1,1423106709,1423106715),(232,1,'C420150205112536393227','559591','sms2','15852722126','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是uhgg7z，请尽快修改密码',1,1423106736,1423106740),(233,1,'C42015020511362816520','559646','sms2','15979008240','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是f9etk2，请尽快修改密码',1,1423107388,1423107395),(234,1,'C420150205114028110859','559662','sms2','13812081779','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是sgcygu，请尽快修改密码',1,1423107628,1423107635),(235,1,'C420150205114302162725','559681','sms2','13812081779','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是sgcygu，请尽快修改密码',1,1423107782,1423107785),(236,1,'C420150205122140906276','559873','sms2','13672249879','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是dw7f2n，请尽快修改密码',1,1423110100,1423110105),(237,1,'C420150205152603495512','560876','sms2','13588665182','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是qpnwqr，请尽快修改密码',1,1423121163,1423121165),(238,1,'C420150205155100624772','561049','sms2','18940290380','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是s3g9za，请尽快修改密码',1,1423122660,1423122665),(239,1,'C420150205155852520418','561090','sms2','13776703872','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是vemkwb，请尽快修改密码',1,1423123132,1423123135),(240,1,'C420150205160245512461','561110','sms2','18842455339','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是3bkxfg，请尽快修改密码',1,1423123365,1423123370),(241,1,'C420150205163603807960','561322','sms2','18861814646','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是4m9x8n，请尽快修改密码',1,1423125363,1423125365),(242,1,'C420150205163911628599','561351','sms2','18861814646','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是4m9x8n，请尽快修改密码',1,1423125551,1423125556),(243,1,'C420150205165741806815','561487','sms2','15055326328','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是e92nyh，请尽快修改密码',1,1423126661,1423126666),(244,1,'C420150205170117472480','561521','sms2','15055326328','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是e92nyh，请尽快修改密码',1,1423126877,1423126881),(245,1,'C420150205171103870686','561605','sms2','13605609385','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是t9hrtd，请尽快修改密码',1,1423127463,1423127466),(246,1,'C420150205190738280444','562197','sms2','13870955372','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是yxb63d，请尽快修改密码',1,1423134458,1423134461),(247,1,'C420150205205537333874','562585','sms2','15860611363','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是j946gm，请尽快修改密码',1,1423140937,1423140942),(248,1,'C420150206080502584040','563476','sms2','15179168003','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是x7z4sh，请尽快修改密码',1,1423181102,1423181109),(249,1,'C420150206081032254332','563482','sms2','15179168003','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是x7z4sh，请尽快修改密码',1,1423181432,1423181439),(250,1,'C420150206082256538685','563489','sms2','13554105027','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是2xz795，请尽快修改密码',1,1423182176,1423182184),(251,1,'C420150206082300838121','563490','sms2','13575911810','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是vukn8l，请尽快修改密码',1,1423182180,1423182189),(252,1,'C420150206082551874403','563491','sms2','13627004886','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是che6va，请尽快修改密码',1,1423182351,1423182359),(253,1,'C420150206082605516568','563492','sms2','13627004886','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是che6va，请尽快修改密码',1,1423182365,1423182369),(254,1,'C420150206083033262345','563496','sms2','15879145855','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是39jrb2，请尽快修改密码',1,1423182633,1423182639),(255,1,'C420150206083229361251','563497','sms2','15370410370','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是fh8gp5，请尽快修改密码',1,1423182749,1423182754),(256,1,'C420150206080015476960','563502','sms2','15179168003','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是x7z4sh，请尽快修改密码',1,1423180815,1423183099),(257,1,'C420150206084142401764','563506','sms2','18652258480','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是2ywnhb，请尽快修改密码',1,1423183302,1423183306),(258,1,'C420150206084636838817','563512','sms2','13755697610','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是lfrk5x，请尽快修改密码',1,1423183596,1423183601),(259,1,'C420150206084908826964','563519','sms2','18652258480','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是2ywnhb，请尽快修改密码',1,1423183748,1423183751),(260,1,'C420150206091145656413','563568','sms2','13319203942','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是m882xa，请尽快修改密码',1,1423185105,1423185111),(261,1,'C420150206092337750983','563605','sms2','13502039231','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是ucr2mc，请尽快修改密码',1,1423185817,1423185821),(262,1,'C420150206094456103287','563704','sms2','13757960363','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是mld3rs，请尽快修改密码',1,1423187096,1423187101),(263,1,'C42015020609485848004','563718','sms2','15665888799','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是tnbkw5，请尽快修改密码',1,1423187338,1423187341),(264,1,'C420150206095633118032','563762','sms2','13755697610','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是lfrk5x，请尽快修改密码',1,1423187793,1423187796),(265,1,'C420150206100206398148','563794','sms2','13755697610','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是lfrk5x，请尽快修改密码',1,1423188126,1423188131),(266,1,'C420150206101105954407','563833','sms2','13924172256','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是lzu395，请尽快修改密码',1,1423188665,1423188671),(267,1,'C420150206111830804287','564266','sms2','15809292621','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是nrct8l，请尽快修改密码',1,1423192710,1423192711),(268,1,'C420150206120723266514','564566','sms2','13812070398','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是zldxg5，请尽快修改密码',1,1423195643,1423195646),(269,1,'C420150206132859892989','564953','sms2','15356965787','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是ndzacp，请尽快修改密码',1,1423200539,1423200542),(270,1,'C420150206141422293221','565222','sms2','18792416393','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是ymctdx，请尽快修改密码',1,1423203262,1423203272),(271,1,'C420150206142513262576','565275','sms2','13876899970','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是ncs4bw，请尽快修改密码',1,1423203913,1423203922),(272,1,'C420150206143749877566','565348','sms2','13502066266','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是m3qf58，请尽快修改密码',1,1423204669,1423204677),(273,1,'C42015020615461327524','565872','sms2','13876899970','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是ncs4bw，请尽快修改密码',1,1423208773,1423208782),(274,1,'C42015020618035099727','566907','sms2','18727585121','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是skdrvw，请尽快修改密码',1,1423217030,1423217037),(275,1,'C420150207090604853115','568464','sms2','15081144455','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是c5hkqz，请尽快修改密码',1,1423271164,1423271172),(276,1,'C42015020709564738604','568557','sms2','18608963688','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是d48knl，请尽快修改密码',1,1423274207,1423274212),(277,1,'C420150207100638765757','568594','sms2','18608963688','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是g6l2an,请尽快修改密码',1,1423274798,1423274807),(278,1,'C420150207100707173306','568596','sms2','18608963688','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是g6l2an,请尽快修改密码',1,1423274827,1423274832),(279,1,'C420150207121149630130','569117','sms2','15179168003','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是x7z4sh，请尽快修改密码',1,1423282309,1423282317),(280,1,'C420150207145104388986','569594','sms2','15013123419','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是9bz987，请尽快修改密码',1,1423291864,1423291868),(281,1,'C420150207153449900053','569749','sms2','18507955396','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是vgr2lb,请尽快修改密码',1,1423294489,1423294493),(282,1,'C420150207173713191350','570322','sms2','18755367895','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是k35kmk，请尽快修改密码',1,1423301833,1423301838),(283,1,'C420150207180726932094','570454','sms2','18658895990','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是fhysfl，请尽快修改密码',1,1423303646,1423303653),(284,1,'C420150207213431284727','571236','sms2','13480221861','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是lphs25，请尽快修改密码',1,1423316071,1423316074),(285,1,'C420150208085405607317','572235','sms2','18658895990','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是fhysfl，请尽快修改密码',1,1423356845,1423358506),(286,1,'C42015020809540768443','572325','sms2','18035109575','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是2ae2c3，请尽快修改密码',1,1423360447,1423360451),(287,1,'C420150208114817747679','572737','sms2','15866735971','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是s32nf3，请尽快修改密码',1,1423367297,1423367301),(288,1,'C420150209085437437893','575446','sms2','13502039231','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是ucr2mc，请尽快修改密码',1,1423443277,1423443284),(289,1,'C420150209091750174999','575505','sms2','18658895990','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是fhysfl，请尽快修改密码',1,1423444670,1423444674),(290,1,'C420150209092049197783','575516','sms2','18658895990','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是fhysfl，请尽快修改密码',1,1423444849,1423444854),(291,1,'C420150209092112745784','575519','sms2','18976422477','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是bnat4f，请尽快修改密码',1,1423444872,1423444879),(292,1,'C420150209103410644437','577261','sms2','13710686164','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是5wcj83，请尽快修改密码',1,1423449250,1423449254),(293,1,'C420150209132941692540','578701','sms2','13622240066','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是psfvgt，请尽快修改密码',1,1423459781,1423459785),(294,1,'C420150209170224556332','580444','sms2','15808945370','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是f7u3zu，请尽快修改密码',1,1423472544,1423472545),(295,1,'C420150210110425507140','583759','sms2','13825041000','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是tl54k9，请尽快修改密码',1,1423537465,1423537467),(296,1,'C420150210151947913145','585755','sms2','13710643353','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是hmm9u9，请尽快修改密码',1,1423552787,1423552797),(297,1,'C420150210230341925875','589243','sms2','13803563050','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是ajy7rp，请尽快修改密码',1,1423580621,1423587399),(298,1,'C420150211104307204252','590198','sms2','15068859669','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是cd5atd，请尽快修改密码',1,1423622587,1423622595),(299,1,'C420150211111245174391','590427','sms2','18691336790','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是8kphbp，请尽快修改密码',1,1423624365,1423624370),(300,1,'C420150211140347371051','591470','sms2','15829344668','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是2hhr5j，请尽快修改密码',1,1423634627,1423634636),(301,1,'C420150211163607655755','592529','sms2','13695696079','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是cxa7kg，请尽快修改密码',1,1423643767,1423643771),(302,1,'C420150211165732400650','592800','sms2','13810648839','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是qugxbd，请尽快修改密码',1,1423645052,1423645056),(303,1,'C420150211171229505519','593018','sms2','15512138537','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是bcpgf4，请尽快修改密码',1,1423645949,1423645956),(304,1,'C420150213170312427014','608558','sms1','18616934147','【贝螺网络科技】你的验证码是xyxd76',1,1423818192,1423818194),(305,1,'C420150213170359646845','608569','sms1','18616934147','【贝螺网络科技】你的验证码是123ssf',1,1423818239,1423818246),(306,1,'C420150213171330860483','608668','sms1','18616934147','【贝螺网络科技】你的验证码是xxffdd',1,1423818810,1423818814),(307,1,'C420150213232808776235','611406','sms1','15221816172','【贝螺网络科技】你的验证码是xyxydd',1,1423841288,1423841293),(308,1,'C420150216105917529199','622979','sms2','13575916075','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是fk9kcw,请尽快修改密码',1,1424055557,1424055581),(309,1,'C420150225220600375682','647055','sms2','13634293584','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是jeqy59,请尽快修改密码',1,1424873160,1424873165),(310,1,'C420150225223300870091','647171','sms2','13634293584','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是jeqy59,请尽快修改密码',1,1424874780,1424874782),(311,1,'C420150226083906985223','647657','sms2','18931842188','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是xspd2t,请尽快修改密码',1,1424911146,1424911165),(312,1,'C42015022610112414048','648150','sms2','13659821151','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是fbq5de，请尽快修改密码',1,1424916684,1424916688),(313,1,'C420150226101524227656','648187','sms2','13632436980','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是9pz2xx，请尽快修改密码',1,1424916924,1424916930),(314,1,'C420150226102609834774','648277','sms2','13632436980','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是3vd236,请尽快修改密码',1,1424917569,1424917572),(315,1,'C420150226110339902208','648548','sms2','13710686164','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是5wcj83，请尽快修改密码',1,1424919819,1424919824),(316,1,'C420150226122956368081','649243','sms2','13924172256','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是lzu395，请尽快修改密码',1,1424924996,1424925001),(317,1,'C420150227164318625219','658544','sms2','18861814646','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是4m9x8n，请尽快修改密码',1,1425026598,1425026604),(318,1,'C420150228162024483609','663427','sms2','15866735971','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是s32nf3，请尽快修改密码',1,1425111624,1425111629),(319,1,'C420150301105957403975','666765','sms2','18035109575','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是2ae2c3，请尽快修改密码',1,1425178797,1425178804),(320,1,'C4201503011155098436','666965','sms2','18757805584','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是hvge9w，请尽快修改密码',1,1425182109,1425182124),(321,1,'C420150301215111608024','669645','sms2','15079186673','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是cvjug4，请尽快修改密码',1,1425217871,1425217878),(322,1,'C420150302140742582416','676330','sms2','13450384465','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是vpj3h8，请尽快修改密码',1,1425276462,1425276469),(323,1,'C42015030311474981759','682857','sms2','13812521808','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是ycl32f，请尽快修改密码',1,1425354469,1425354482),(324,1,'C420150303115434912894','682927','sms2','13812521808','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是ycl32f，请尽快修改密码',1,1425354874,1425354879),(325,1,'C420150303183347985123','686919','sms2','13969166589','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是z6lpzz，请尽快修改密码',1,1425378827,1425378837),(326,1,'C42015030318413911389','686964','sms2','13969166589','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是z6lpzz，请尽快修改密码',1,1425379299,1425379304),(327,1,'C420150304205640108765','695373','sms2','13554105027','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是2xz795，请尽快修改密码',1,1425473800,1425473802),(328,1,'C420150305162636830697','706584','sms2','18976422477','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是bc5h9y,请尽快修改密码',1,1425626767,1425626825),(329,1,'C420150306152826630654','706601','sms1','18616934147','【贝螺网络科技】你的验证码是xyddss',1,1425626906,1425626912),(330,1,'C42015031108191894957','740691','sms2','18842507356','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是j9e85a，请尽快修改密码',1,1426041403,1426041413),(331,1,'C420150311142339168957','742759','sms2','13695696079','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是cxa7kg，请尽快修改密码',1,1426055019,1426055023),(332,1,'C420150311161753240207','743956','sms2','18931842188','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是xvjs9l，请尽快修改密码',1,1426061873,1426061875),(333,1,'C420150314093018496442','765792','sms2','13710643353','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是qxlasp,请尽快修改密码',1,1426296618,1426296619),(334,1,'C42015031410131195309','766275','sms2','18658895990','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是kezq9u,请尽快修改密码',1,1426299191,1426299196),(335,1,'C420150314101345656790','766278','sms2','18658895990','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是kezq9u,请尽快修改密码',1,1426299225,1426299233),(336,1,'C420150316081207887084','776842','sms2','18931842188','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是xvjs9l，请尽快修改密码',1,1426464727,1426464747),(337,1,'C420150316085743201758','777010','sms2','13816444231','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是kvfhpr，请尽快修改密码',1,1426467463,1426467464),(338,1,'C420150316215445367516','789347','sms2','15079186673','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是cvjug4，请尽快修改密码',1,1426514085,1426514093),(339,1,'C420150324105320508760','858642','sms2','13667243286','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是872ghj，请尽快修改密码',1,1427165600,1427165605),(340,1,'C420150324113530293516','859184','sms2','18976422477','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是bc5h9y,请尽快修改密码',1,1427168130,1427168137),(341,1,'C420150325163344621642','876162','sms2','13969166589','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是z6lpzz，请尽快修改密码',1,1427272424,1427272429),(342,1,'C420150325170150382086','876813','sms2','15808945370','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是5pc5ln,请尽快修改密码',1,1427274110,1427274111),(343,1,'C420150325171204290599','877071','sms2','13969166589','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是ksgzlx,请尽快修改密码',1,1427274724,1427274728),(344,1,'C420150330220421297215','927261','sms2','15079186673','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是cvjug4，请尽快修改密码',1,1427724261,1427724264),(345,1,'C420150330220433563639','927265','sms2','15079186673','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是cvjug4，请尽快修改密码',1,1427724273,1427724281),(346,1,'C420150331151823694444','933745','sms1','15221816172','【贝螺网络科技】你的验证码是usbusb',1,1427786303,1427786307),(347,1,'C420150402200413681023','961494','sms2','18702019250','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是bjyplz，请尽快修改密码',1,1427976253,1427976265),(348,1,'C420150405072538708423','993076','sms2','15057833380','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是tp2lc9，请尽快修改密码',1,1428189938,1428377854),(349,1,'C420150405072608772930','993077','sms2','15057833380','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是tp2lc9，请尽快修改密码',1,1428189968,1428377856),(350,1,'C420150405175102514502','993078','sms2','15057833380','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是tp2lc9，请尽快修改密码',1,1428227462,1428377858),(351,1,'C420150406093613558409','993079','sms2','15057833380','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是tp2lc9，请尽快修改密码',1,1428284173,1428377860),(352,1,'C420150406184620117403','993081','sms2','15057833380','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是tp2lc9，请尽快修改密码',1,1428317180,1428377862),(353,1,'C420150407080529372310','993082','sms2','15866735971','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是7ymnkb,请尽快修改密码',1,1428365129,1428377864),(354,1,'C420150407081030697957','993083','sms2','15866735971','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是7ymnkb,请尽快修改密码',1,1428365430,1428377866),(355,1,'C420150407083154896626','993084','sms2','15866735971','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是7ymnkb,请尽快修改密码',1,1428366714,1428377868),(356,1,'C42015040507241130221','993096','sms2','15057833380','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是tp2lc9，请尽快修改密码',1,1428377917,1428377932),(357,1,'C420150407130925479067','993897','sms2','15064005396','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是ldcxjb，请尽快修改密码',1,1428383365,1428383374),(358,1,'C420150407162157608421','996419','sms2','15057833380','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是tp2lc9，请尽快修改密码',1,1428394917,1428394921),(359,1,'C420150410090318691775','1027527','sms2','13514076199','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是gcz5x7,请尽快修改密码',1,1428627798,1428627817),(360,1,'C420150410101313131995','1028545','sms2','15221816172','【驰耐得轮胎】【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是cztest,请尽快修改密码',1,1428631993,1428631999),(361,1,'C420150410101440677341','1028572','sms2','18918891440','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是lchlch,请尽快修改密码',1,1428632080,1428632086),(362,1,'C420150415195301853907','1094585','sms1','15221816172','【贝螺网络科技】你的验证码是xyxybb',1,1429098781,1429098788),(363,1,'C420150421094900217501','1151270','sms2','13915281240','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是z4fcr2，请尽快修改密码',1,1429580940,1429580944),(364,1,'C420150423162441504777','1186343','sms2','18636887787','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是lq5e6y,请尽快修改密码',1,1429777481,1429777487),(365,1,'C420150424163730774758','1208049','sms2','13514076199','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是gcz5x7,请尽快修改密码',1,1429933669,1429933677),(366,1,'C420150427140808947386','1227407','sms2','13381188072','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是7heppj，请尽快修改密码',1,1430114888,1430114899),(367,1,'C420150503165427627923','1516600','sms2','13816444231','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是kvfhpr，请尽快修改密码',1,1430643267,1431931500),(368,1,'C420150509095302613655','1516601','sms2','18702019250','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是f4jld2,请尽快修改密码',1,1431136382,1431931501),(369,1,'C420150509095616324702','1516603','sms2','18702019250','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是f4jld2,请尽快修改密码',1,1431136576,1431931503),(370,1,'C420150510104357121230','1516604','sms2','15064005396','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是uj8bez,请尽快修改密码',1,1431225837,1431931505),(371,1,'C420150510104536662293','1516605','sms2','15064005396','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是uj8bez,请尽快修改密码',1,1431225936,1431931507),(372,1,'C420150512101225743350','1516607','sms2','18653131086','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是wec42g，请尽快修改密码',1,1431396745,1431931509),(373,1,'C420150512101304169773','1516609','sms2','18653131086','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是wec42g，请尽快修改密码',1,1431396784,1431931511),(374,1,'C420150512102823878027','1516612','sms2','18653131086','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是wec42g，请尽快修改密码',1,1431397703,1431931513),(375,1,'C42015051211002012216','1516613','sms2','18702019250','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是f4jld2,请尽快修改密码',1,1431399620,1431931515),(376,1,'C420150512112428171593','1516615','sms2','18702019250','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是f4jld2,请尽快修改密码',1,1431401068,1431931517),(377,1,'C420150512114506541742','1516616','sms2','18702019250','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是f4jld2,请尽快修改密码',1,1431402306,1431931519),(378,1,'C420150513083147167307','1516618','sms2','18976422477','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是bc5h9y,请尽快修改密码',1,1431477107,1431931521),(379,1,'C420150513115708499432','1516620','sms2','18702019250','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是f4jld2,请尽快修改密码',1,1431489428,1431931523),(380,1,'C420150518132606486000','1516623','sms2','18702019250','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是f4jld2,请尽快修改密码',1,1431926766,1431931525),(381,1,'C420150503081413411945','1516624','sms2','13816444231','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是kvfhpr，请尽快修改密码',1,1430612053,1431931529),(382,1,'C420150519082905910141','1528428','sms2','18702019250','【驰耐得轮胎】感谢使用驰耐得内部交流平台,您的登录密码是f4jld2,请尽快修改密码',1,1431995345,1431995346),(383,1,'C420150525172802144570','1658786','sms1','15221816172','【贝螺网络科技】您的验证码是sfsfdd',1,1432546082,1432546089),(384,1,'C42015052716314561776','1709891','sms1','15221816172','【贝螺网络科技】你的验证码是sbsb11',1,1432715505,1432715509),(385,1,'C420150602085239248682','1824879','sms2','13516968795','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是4u2vbb，请尽快修改密码',1,1433206359,1433206364),(386,1,'C420150602091700231336','1825324','sms2','13695696079','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是cxa7kg，请尽快修改密码',1,1433207820,1433207824),(387,1,'C420150602101016216970','1827976','sms2','13803563500','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是gjdz8p，请尽快修改密码',1,1433211016,1433211019),(388,1,'C420150604191200247641','1893820','sms2','13516968795','【驰耐得轮胎】感谢使用驰耐得邮箱系统，您的登录密码是4u2vbb，请尽快修改密码',1,1433416320,1433416324),(389,1,'C420150605081003688958','1900923','sms1','15221816172','【贝螺网络科技】您的验证码是sbsbyy',1,1433463003,1433463012);
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
) ENGINE=InnoDB AUTO_INCREMENT=481 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='发送任务表';
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
INSERT INTO `tokens` VALUES ('20141225',1,'blA920141225181153827652',1419509513,3,1419502313),('20141229',1,'blA920141229194024175190',1419860424,1,1419853224),('20150107',1,'blA9201501071751267523',1420631486,2,1420624286),('20150108',1,'blA920150108221807558108',1420733887,35,1420726687),('20150109',1,'blA920150109212719893558',1420817239,30,1420810039),('20150110',1,'blA920150110152147434581',1420881707,10,1420874507),('20150111',1,'blA920150111175811520055',1420977491,11,1420970291),('20150112',1,'blA920150112183508432301',1421066108,12,1421058908),('20150113',1,'blA92015011315131535788',1421140395,7,1421133195),('20150114',1,'blA920150114182426606836',1421238266,11,1421231066),('20150115',1,'blA920150115194307385833',1421329387,6,1421322187),('20150116',1,'blA920150116144140681890',1421397700,5,1421390500),('20150117',1,'blA920150117144355346691',1421484235,6,1421477035),('20150118',1,'blA920150118193755192590',1421588275,3,1421581075),('20150119',1,'blA920150119213553708426',1421681753,8,1421674553),('20150120',1,'blA920150120180104496238',1421755264,4,1421748064),('20150121',1,'blA920150121160925282161',1421834965,3,1421827765),('20150122',1,'blA920150122151341183526',1421918021,1,1421910821),('20150124',1,'blA920150124134047676549',1422085247,1,1422078047),('20150125',1,'blA920150125154923125188',1422179363,6,1422172163),('20150126',1,'blA920150126122554159553',1422253554,9,1422246354),('20150127',1,'blA92015012718454171054',1422362741,7,1422355541),('20150128',1,'blA920150128172659640617',1422444419,7,1422437219),('20150129',1,'blA920150129174609786443',1422531969,6,1422524769),('20150131',1,'blA920150131205646397315',1422716206,2,1422709006),('20150201',1,'blA920150201153333868451',1422783213,4,1422776013),('20150202',1,'blA920150202171041143488',1422875441,7,1422868241),('20150203',1,'blA920150203155934845534',1422957574,2,1422950374),('20150204',1,'blA920150204235405740839',1423072445,6,1423065245),('20150205',1,'blA920150205205537240584',1423148137,48,1423140937),('20150206',1,'blA9201502061803509635',1423224230,27,1423217030),('20150207',1,'blA920150207213431191320',1423323271,10,1423316071),('20150208',1,'blA920150208114817639162',1423374497,3,1423367297),('20150209',1,'blA920150209170224469282',1423479744,7,1423472544),('20150210',1,'blA920150210230341830483',1423587821,3,1423580621),('20150211',1,'blA920150211171226432339',1423653146,6,1423645946),('20150216',1,'blA920150216105917435992',1424062757,1,1424055557),('20150218',1,'blA920150218105825988429',1424235505,1,1424228305),('20150220',1,'blA920150220094516624010',1424403916,1,1424396716),('20150225',1,'blA920150225223300764368',1424881980,2,1424874780),('20150226',1,'blA9201502261619462060',1424945986,13,1424938786),('20150227',1,'blA920150227164318534296',1425033798,4,1425026598),('20150228',1,'blA920150228162021502015',1425118821,1,1425111621),('20150301',1,'blA920150301215111518324',1425225071,3,1425217871),('20150302',1,'blA920150302140742498330',1425283662,1,1425276462),('20150303',1,'blA920150303184138915462',1425386498,4,1425379298),('20150304',1,'blA92015030420564020185',1425481000,1,1425473800),('20150305',1,'blA920150305180448963250',1425557088,2,1425549888),('20150310',1,'blA920150310192138157754',1425993698,5,1425986498),('20150311',1,'blA920150311162406139948',1426069446,5,1426062246),('20150313',1,'blA920150313135305876736',1426233185,2,1426225985),('20150314',1,'blA920150314101345569281',1426306425,3,1426299225),('20150316',1,'blA920150316215445278495',1426521285,3,1426514085),('20150324',1,'blA920150324113530200266',1427175330,2,1427168130),('20150325',1,'blA920150325171204197361',1427281924,3,1427274724),('20150327',1,'blA920150327105706791617',1427432226,3,1427425026),('20150328',1,'blA920150328162153599267',1427538113,1,1427530913),('20150330',1,'blA920150330220433473301',1427731473,2,1427724273),('20150331',1,'blA920150331143820991745',1427791100,2,1427783900),('20150402',1,'blA920150402200413599208',1427983453,1,1427976253),('20150405',1,'blA920150405175102425181',1428234662,4,1428227462),('20150406',1,'blA92015040618462022597',1428324380,2,1428317180),('20150407',1,'blA920150407162157501191',1428402117,5,1428394917),('20150409',1,'blA920150409094655942207',1428551215,1,1428544015),('20150410',1,'blA920150410163745575227',1428662265,5,1428655065),('20150421',1,'blA920150421215411415900',1429631651,2,1429624451),('20150423',1,'blA920150423162441408981',1429784681,2,1429777481),('20150424',1,'blA920150424163730683202',1429871850,1,1429864650),('20150427',1,'blA920150427140808851385',1430122088,1,1430114888),('20150428',1,'blA920150428233433441729',1430242473,2,1430235273),('20150430',1,'blA920150430150921225537',1430384961,1,1430377761),('20150502',1,'blA920150502203617972279',1430577377,1,1430570177),('20150503',1,'blA920150503165427532695',1430650467,2,1430643267),('20150509',1,'blA920150509095616216835',1431143776,2,1431136576),('20150510',1,'blA920150510104536565935',1431233136,2,1431225936),('20150512',1,'blA920150512114506447045',1431409506,6,1431402306),('20150513',1,'blA920150513115708412161',1431496628,2,1431489428),('20150518',1,'blA920150518132606371613',1431933966,1,1431926766),('20150519',1,'blA920150519082905781469',1432002545,1,1431995345),('20150520',1,'blA92015052017341716438',1432121657,2,1432114457),('20150602',1,'blA920150602101016121319',1433218216,3,1433211016),('20150604',1,'blA920150604191200156231',1433423520,2,1433416320);
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
INSERT INTO `user` VALUES (1,'root','$S$G65d74a5442cea7530176350c85ef8423ffab9c5f73a6be036ef1c838bf8a','root','18616934147','Administrator','','M',1,1415939223,1415939223,1433483890),(2,'test','$S$A4ebaa16b9d21955b4d8cd0a22613c448728a6167b335fe240197449653c3','c5b7845f-83c7-45b8-a894-09da41dc6581','15221816172','西门吹雪','','F',1,1418657237,1418657237,1426686105),(3,'lch','$S$4cf4e0828e98384ae550e5951781c05b2f39bf7f67b3ea07a67e720b04e34','f3441291-453b-453c-8a63-9921df63d55d','','lch','','M',1,1420442036,1420442036,1420445930);
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
INSERT INTO `variables` VALUES ('swoole_1','a:2:{s:10:\"master_pid\";i:9671;s:11:\"manager_pid\";i:9672;}'),('swoole_2','a:2:{s:10:\"master_pid\";i:9629;s:11:\"manager_pid\";i:9630;}'),('WorkMail','a:2:{s:10:\"master_pid\";i:3764;s:11:\"manager_pid\";i:3765;}'),('WorkSms','a:2:{s:10:\"master_pid\";i:3848;s:11:\"manager_pid\";i:3849;}');
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

-- Dump completed on 2015-06-05 14:02:45
