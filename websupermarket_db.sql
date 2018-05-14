/*
Navicat MySQL Data Transfer

Source Server         : 40 Mysql
Source Server Version : 50528
Source Host           : 192.168.20.40:3306
Source Database       : websupermarket_db

Target Server Type    : MYSQL
Target Server Version : 50528
File Encoding         : 65001

Date: 2018-05-14 20:34:22
*/
drop database if exists websupermarket_db;
CREATE DATABASE websupermarket_db DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE websupermarket_db;

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `c_id` int(10) NOT NULL AUTO_INCREMENT,
  `c_userid` int(10) DEFAULT NULL,
  `c_gid` int(10) DEFAULT NULL,
  `c_gamount` int(10) DEFAULT NULL,
  `c_date` datetime DEFAULT NULL,
  `c_isdel` int(1) DEFAULT '0',
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES ('1', '8', '1', '3', '2018-05-13 16:52:03', '1');
INSERT INTO `cart` VALUES ('19', '8', '2', '1', '2018-05-13 17:47:59', '1');
INSERT INTO `cart` VALUES ('21', '8', '2', '2', '2018-05-13 18:46:37', '1');
INSERT INTO `cart` VALUES ('22', '8', '2', '1', '2018-05-13 22:01:34', '1');
INSERT INTO `cart` VALUES ('23', '8', '1', '1', '2018-05-14 09:53:30', '1');
INSERT INTO `cart` VALUES ('24', '8', '1', '48', '2018-05-14 09:56:34', '1');
INSERT INTO `cart` VALUES ('25', '8', '1', '1', '2018-05-14 11:20:20', '1');
INSERT INTO `cart` VALUES ('26', '8', '1', '1', '2018-05-14 13:10:32', '1');
INSERT INTO `cart` VALUES ('27', '8', '1', '1', '2018-05-14 15:56:07', '0');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `c_id` int(10) NOT NULL AUTO_INCREMENT,
  `c_type` varchar(255) DEFAULT NULL,
  `c_name` varchar(255) DEFAULT NULL,
  `c_summary` varchar(255) DEFAULT NULL,
  `c_hour` float(53,0) DEFAULT NULL,
  `c_teacher_id` int(10) DEFAULT NULL,
  `isdel` int(1) DEFAULT NULL,
  `isrec` int(1) DEFAULT '0',
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('1', '课程1方向', '课程1', '课程1简介', '100', '1', '0', '0');

-- ----------------------------
-- Table structure for forum
-- ----------------------------
DROP TABLE IF EXISTS `forum`;
CREATE TABLE `forum` (
  `f_id` int(10) NOT NULL AUTO_INCREMENT,
  `f_summary` text,
  `f_content` text,
  `f_qtype` int(10) DEFAULT NULL,
  `f_ftype` int(10) DEFAULT NULL,
  `f_root` int(10) DEFAULT NULL,
  `f_user_id` int(10) DEFAULT NULL,
  `f_status` varchar(255) DEFAULT NULL,
  `f_date` datetime DEFAULT NULL,
  `isdel` int(1) DEFAULT NULL,
  `f_reply` text,
  `f_reply_date` datetime DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of forum
-- ----------------------------
INSERT INTO `forum` VALUES ('1', '', '123', '1', '0', '0', '7', '已回复', '2018-04-16 22:05:59', '0', '哈哈', '2018-04-16 22:06:43');
INSERT INTO `forum` VALUES ('2', '新帖子', '新帖子内容', '0', '1', '0', '7', null, '2018-04-17 21:12:21', '0', 'client', '2018-04-17 21:22:32');
INSERT INTO `forum` VALUES ('3', '1', '1', '0', '1', '0', '7', null, '2018-04-17 21:13:43', '0', 'client', '2018-04-17 21:31:49');
INSERT INTO `forum` VALUES ('4', null, '回复', '0', '1', '2', '7', null, '2018-04-17 21:22:32', '0', null, null);
INSERT INTO `forum` VALUES ('5', null, '回复1', '0', '1', '3', '7', null, '2018-04-17 21:31:49', '0', null, null);
INSERT INTO `forum` VALUES ('6', '再次发帖', '再次发帖的内容', '0', '1', '0', '7', null, '2018-04-17 21:32:33', '0', null, null);
INSERT INTO `forum` VALUES ('7', '顶部的帖子', '新帖子哦', '0', '1', '0', '7', null, '2018-04-17 21:35:13', '0', 'stu1', '2018-04-18 10:09:27');
INSERT INTO `forum` VALUES ('8', null, '我要回复', '0', '1', '7', '7', null, '2018-04-17 21:35:22', '0', null, null);
INSERT INTO `forum` VALUES ('9', null, '回复的不好', '0', '1', '7', '7', null, '2018-04-17 21:35:28', '0', null, null);
INSERT INTO `forum` VALUES ('10', null, '1', '0', '1', '7', '4', null, '2018-04-18 10:09:27', '0', null, null);
INSERT INTO `forum` VALUES ('11', '', 'stu1咨询的内容', '1', '0', '0', '4', '未回复', '2018-04-18 10:44:31', '0', null, null);

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `g_id` int(10) NOT NULL AUTO_INCREMENT,
  `g_type` varchar(255) DEFAULT NULL,
  `g_name` varchar(255) DEFAULT NULL,
  `g_code` varchar(255) DEFAULT NULL,
  `g_unit` varchar(255) DEFAULT NULL,
  `g_summary` text,
  `g_amount` int(10) DEFAULT NULL,
  `g_price` decimal(10,2) DEFAULT NULL,
  `g_isonsale` int(1) DEFAULT NULL,
  `g_onsaleprice` decimal(10,2) DEFAULT NULL,
  `g_img` varchar(255) DEFAULT NULL,
  `g_isdel` int(1) DEFAULT '0',
  PRIMARY KEY (`g_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('1', '服饰', '1001衣服', '1', '件', '很漂亮', '88', '10.00', '1', '8.00', '20180512170228871.jpg', '0');
INSERT INTO `goods` VALUES ('2', '2', '2', '2', '2', '111', '2', '10.00', '0', '0.00', '20180512195204432.jpg', '0');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `o_id` int(10) NOT NULL AUTO_INCREMENT,
  `o_userid` int(10) DEFAULT NULL,
  `o_saleid` int(10) DEFAULT NULL,
  `o_amount` int(10) DEFAULT NULL,
  `o_sumprice` decimal(10,2) DEFAULT NULL,
  `o_receiver` varchar(255) DEFAULT NULL,
  `o_phone` varchar(255) DEFAULT NULL,
  `o_address` varchar(255) DEFAULT NULL,
  `o_method` int(1) DEFAULT NULL,
  `o_status` int(1) DEFAULT '0',
  `o_date` datetime DEFAULT NULL,
  `o_isdel` int(1) DEFAULT '0',
  PRIMARY KEY (`o_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('3', '8', '0', '5', '44.00', '顾客1的弟弟', '123456', '顾客1的收货地址', '1', '2', '2018-05-13 21:58:21', '0');
INSERT INTO `orders` VALUES ('4', '8', '0', '48', '384.00', '顾客1', '123456', '1', '0', '1', '2018-05-14 11:17:53', '0');

-- ----------------------------
-- Table structure for sale
-- ----------------------------
DROP TABLE IF EXISTS `sale`;
CREATE TABLE `sale` (
  `s_id` int(10) NOT NULL AUTO_INCREMENT,
  `s_orderid` int(10) DEFAULT '0',
  `s_type` int(1) DEFAULT NULL,
  `s_gid` int(10) DEFAULT NULL,
  `s_gcode` varchar(255) DEFAULT NULL,
  `s_gname` varchar(255) DEFAULT NULL,
  `s_gtype` varchar(255) DEFAULT NULL,
  `s_gunit` varchar(255) DEFAULT NULL,
  `s_gprice` decimal(10,2) DEFAULT NULL,
  `s_gisonsale` int(1) DEFAULT NULL,
  `s_price` decimal(10,2) DEFAULT NULL,
  `s_amount` int(10) DEFAULT NULL,
  `s_sumprice` decimal(10,2) DEFAULT NULL,
  `s_status` int(1) DEFAULT '0',
  `s_date` datetime DEFAULT NULL,
  `s_isdel` int(1) DEFAULT '0',
  PRIMARY KEY (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sale
-- ----------------------------
INSERT INTO `sale` VALUES ('1', '0', '1', '1', '1', '2', '1', '1', '10.00', '1', '8.00', '8', '8.00', '0', '2018-05-12 23:01:22', '0');
INSERT INTO `sale` VALUES ('14', '3', '0', '1', '1', '1001衣服', '服饰', '件', '10.00', '1', '8.00', '3', '24.00', '2', '2018-05-13 21:58:21', '0');
INSERT INTO `sale` VALUES ('15', '3', '0', '2', '2', '2', '2', '2', '10.00', '0', '0.00', '2', '20.00', '2', '2018-05-13 21:58:21', '0');
INSERT INTO `sale` VALUES ('16', '4', '0', '1', '1', '1001衣服', '服饰', '件', '10.00', '1', '8.00', '48', '384.00', '1', '2018-05-14 11:17:53', '0');

-- ----------------------------
-- Table structure for signup
-- ----------------------------
DROP TABLE IF EXISTS `signup`;
CREATE TABLE `signup` (
  `s_id` int(10) NOT NULL AUTO_INCREMENT,
  `s_user_id` int(10) DEFAULT NULL,
  `s_course_id` int(10) DEFAULT NULL,
  `s_score` varchar(100) DEFAULT NULL,
  `s_status` int(1) DEFAULT NULL,
  `s_attenddate` datetime DEFAULT NULL,
  `s_date` datetime DEFAULT NULL,
  `isdel` int(1) DEFAULT NULL,
  PRIMARY KEY (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of signup
-- ----------------------------
INSERT INTO `signup` VALUES ('1', '4', '1', '0.00', '2', null, '2018-04-11 18:17:35', '0');
INSERT INTO `signup` VALUES ('2', '3', '3', 'T1523885753578', '0', null, '2018-04-16 21:35:53', '0');
INSERT INTO `signup` VALUES ('3', '7', '3', 'T1523887200181', '1', '2018-04-17 21:48:35', '2018-04-16 22:00:00', '0');
INSERT INTO `signup` VALUES ('4', '7', '7', 'T1523973125773', '1', '2018-04-17 21:52:32', '2018-04-17 21:52:05', '0');
INSERT INTO `signup` VALUES ('5', '7', '5', 'T1523973256410', '2', null, '2018-04-17 21:54:16', '0');
INSERT INTO `signup` VALUES ('6', '7', '5', 'T1523974703107', '2', null, '2018-04-17 22:18:23', '0');
INSERT INTO `signup` VALUES ('7', '7', '5', 'T1523974739122', '2', null, '2018-04-17 22:18:59', '0');
INSERT INTO `signup` VALUES ('8', '7', '5', 'T1523974779278', '1', '2018-04-17 22:41:29', '2018-04-17 22:19:39', '0');

-- ----------------------------
-- Table structure for specify
-- ----------------------------
DROP TABLE IF EXISTS `specify`;
CREATE TABLE `specify` (
  `s_id` int(10) NOT NULL AUTO_INCREMENT,
  `s_userid` int(10) DEFAULT NULL,
  `s_activityid` int(10) DEFAULT NULL,
  `s_status` int(1) DEFAULT NULL,
  `s_date` datetime DEFAULT NULL,
  `s_isdel` int(1) DEFAULT NULL,
  PRIMARY KEY (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of specify
-- ----------------------------
INSERT INTO `specify` VALUES ('1', '1', '1', '0', '2018-04-13 11:12:35', '0');
INSERT INTO `specify` VALUES ('2', '4', '4', '0', '2018-04-13 11:26:13', '1');
INSERT INTO `specify` VALUES ('3', '5', '4', '0', '2018-04-13 11:26:13', '1');
INSERT INTO `specify` VALUES ('4', '4', '5', '0', '2018-04-13 12:38:04', '1');
INSERT INTO `specify` VALUES ('5', '5', '5', '0', '2018-04-13 12:38:04', '1');
INSERT INTO `specify` VALUES ('6', '4', '5', '0', '2018-04-13 12:51:17', '1');
INSERT INTO `specify` VALUES ('7', '4', null, '0', '2018-04-17 20:48:07', '0');
INSERT INTO `specify` VALUES ('8', '5', null, '0', '2018-04-17 20:48:07', '0');
INSERT INTO `specify` VALUES ('9', '7', null, '0', '2018-04-17 20:48:07', '0');
INSERT INTO `specify` VALUES ('10', '4', null, '0', '2018-04-17 20:49:18', '0');
INSERT INTO `specify` VALUES ('11', '5', null, '0', '2018-04-17 20:49:18', '0');
INSERT INTO `specify` VALUES ('12', '7', null, '0', '2018-04-17 20:49:18', '0');
INSERT INTO `specify` VALUES ('13', '4', null, '0', '2018-04-17 20:50:00', '0');
INSERT INTO `specify` VALUES ('14', '5', null, '0', '2018-04-17 20:50:00', '0');
INSERT INTO `specify` VALUES ('15', '7', null, '0', '2018-04-17 20:50:00', '0');
INSERT INTO `specify` VALUES ('16', '4', null, '0', '2018-04-17 20:51:11', '0');
INSERT INTO `specify` VALUES ('17', '5', null, '0', '2018-04-17 20:51:11', '0');
INSERT INTO `specify` VALUES ('18', '7', null, '0', '2018-04-17 20:51:11', '0');
INSERT INTO `specify` VALUES ('19', '4', null, '0', '2018-04-17 20:53:00', '0');
INSERT INTO `specify` VALUES ('20', '5', null, '0', '2018-04-17 20:53:00', '0');
INSERT INTO `specify` VALUES ('21', '4', '6', '0', '2018-04-17 20:55:50', '1');
INSERT INTO `specify` VALUES ('22', '5', '6', '0', '2018-04-17 20:55:50', '1');
INSERT INTO `specify` VALUES ('23', '7', '5', '1', '2018-04-17 21:54:08', '1');
INSERT INTO `specify` VALUES ('24', '7', '5', '1', '2018-04-17 22:17:33', '1');
INSERT INTO `specify` VALUES ('25', '7', '5', '1', '2018-04-17 22:17:44', '0');
INSERT INTO `specify` VALUES ('26', '4', '4', '0', '2018-04-17 22:17:54', '1');
INSERT INTO `specify` VALUES ('27', '5', '4', '0', '2018-04-17 22:17:54', '1');
INSERT INTO `specify` VALUES ('28', '4', '4', '0', '2018-04-18 09:16:42', '0');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `t_id` int(10) NOT NULL AUTO_INCREMENT,
  `t_name` varchar(255) DEFAULT NULL,
  `t_summary` text,
  `t_date` datetime DEFAULT NULL,
  `t_address` varchar(255) DEFAULT NULL,
  `t_department` varchar(255) DEFAULT NULL,
  `t_specifying` int(1) DEFAULT NULL,
  `t_persons` int(10) DEFAULT NULL,
  `t_course_type` varchar(255) DEFAULT NULL,
  `t_course_id` int(11) DEFAULT NULL,
  `isdel` int(255) DEFAULT NULL,
  `isrec` int(255) DEFAULT '0',
  PRIMARY KEY (`t_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('1', '活动名称', '活动内容', '2018-04-12 00:00:00', '活动地址', '主办机构', '0', '100', '主办机构电话', null, '0', '0');
INSERT INTO `teacher` VALUES ('2', '活动名称', '活动内容', '2018-04-13 00:00:00', '活动地址', '主办机构', '1', '3', '机构电话', '0', '0', '0');
INSERT INTO `teacher` VALUES ('3', '活动3', '活动内容', '2018-05-01 00:00:00', '活动地址', '主办机构', '0', '10', '主办机构电话', '2', '1', '1');
INSERT INTO `teacher` VALUES ('4', '活动3', '活动内容', '2018-05-01 00:00:00', '活动地址', '主办机构', '1', '1', '主办机构电话', '0', '0', '0');
INSERT INTO `teacher` VALUES ('5', '活动5修改', '内容', '2018-05-20 00:00:00', '地址', '机构', '1', '1', '电话', '1', '0', '0');
INSERT INTO `teacher` VALUES ('6', '1', '1', '2018-04-18 00:00:00', '1', '1', '1', '2', '1', '0', '1', '0');
INSERT INTO `teacher` VALUES ('7', '新增活动', '新增活动内容', '2018-04-20 00:00:00', '活动地址', '机构', '0', '10', '电话', '1', '0', '0');

-- ----------------------------
-- Table structure for tea_estimate
-- ----------------------------
DROP TABLE IF EXISTS `tea_estimate`;
CREATE TABLE `tea_estimate` (
  `te_id` int(10) NOT NULL AUTO_INCREMENT,
  `te_teacher_id` int(10) DEFAULT NULL,
  `te_user_id` int(10) DEFAULT NULL,
  `te_estimation` text,
  `te_date` datetime DEFAULT NULL,
  `isdel` int(1) DEFAULT NULL,
  PRIMARY KEY (`te_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tea_estimate
-- ----------------------------
INSERT INTO `tea_estimate` VALUES ('1', '1', '1', '老师1评价', '2018-04-11 18:15:51', '0');
INSERT INTO `tea_estimate` VALUES ('2', '3', '3', '123', '2018-04-16 21:49:56', '0');
INSERT INTO `tea_estimate` VALUES ('3', '5', '5', '1', '2018-05-12 13:34:19', '0');
INSERT INTO `tea_estimate` VALUES ('4', '3', '3', '不错', '2018-05-12 13:34:37', '0');
INSERT INTO `tea_estimate` VALUES ('5', null, null, '哈哈', '2018-05-13 16:37:27', '0');
INSERT INTO `tea_estimate` VALUES ('6', null, null, '111', '2018-05-13 16:38:35', '0');
INSERT INTO `tea_estimate` VALUES ('7', null, null, '123', '2018-05-13 16:39:32', '0');
INSERT INTO `tea_estimate` VALUES ('8', '1', '1', '123', '2018-05-13 16:40:26', '0');
INSERT INTO `tea_estimate` VALUES ('9', '1', '1', '哈哈', '2018-05-13 16:40:34', '0');
INSERT INTO `tea_estimate` VALUES ('10', '1', '1', '再次评价', '2018-05-13 16:41:02', '0');
INSERT INTO `tea_estimate` VALUES ('11', '1', '1', '很不错', '2018-05-13 16:41:57', '0');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` int(10) NOT NULL AUTO_INCREMENT,
  `user_uname` varchar(255) DEFAULT NULL,
  `user_pwd` varchar(255) DEFAULT NULL,
  `user_realname` varchar(255) DEFAULT NULL,
  `user_department` varchar(255) DEFAULT NULL,
  `user_role` int(1) DEFAULT NULL,
  `user_phone` varchar(255) DEFAULT NULL,
  `user_address` varchar(255) DEFAULT NULL,
  `user_card` varchar(255) DEFAULT NULL,
  `isdel` int(1) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('3', 'admin', 'admin', '管理员', '计算机学院', '0', '15800000000', null, null, '0');
INSERT INTO `users` VALUES ('4', 'stu1', '123', 'stu1', '测试学院', '1', '13000000000', null, null, '0');
INSERT INTO `users` VALUES ('5', 'stu2', 'null', 'stu2', null, '1', '13100000000', null, null, '0');
INSERT INTO `users` VALUES ('7', 'clienta', '123', '参与用户', 'null', '1', '123', '2', '2', '0');
INSERT INTO `users` VALUES ('8', 'client', '123456', '顾客1', null, '1', '123456', '1', '2', '0');
