/*
 Navicat Premium Data Transfer

 Source Server         : localMysql
 Source Server Type    : MySQL
 Source Server Version : 50634
 Source Host           : localhost
 Source Database       : websupermarket_db

 Target Server Type    : MySQL
 Target Server Version : 50634
 File Encoding         : utf-8

 Date: 05/14/2018 22:47:18 PM
*/

drop database if exists websupermarket_db;
CREATE DATABASE websupermarket_db DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE websupermarket_db;

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `cart`
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
--  Records of `cart`
-- ----------------------------
BEGIN;
INSERT INTO `cart` VALUES ('1', '8', '1', '3', '2018-05-13 16:52:03', '1'), ('19', '8', '2', '1', '2018-05-13 17:47:59', '1'), ('21', '8', '2', '2', '2018-05-13 18:46:37', '1'), ('22', '8', '2', '1', '2018-05-13 22:01:34', '1'), ('23', '8', '1', '1', '2018-05-14 09:53:30', '1'), ('24', '8', '1', '48', '2018-05-14 09:56:34', '1'), ('25', '8', '1', '1', '2018-05-14 11:20:20', '1'), ('26', '8', '1', '1', '2018-05-14 13:10:32', '1'), ('27', '8', '1', '1', '2018-05-14 15:56:07', '0');
COMMIT;

-- ----------------------------
--  Table structure for `goods`
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
--  Records of `goods`
-- ----------------------------
BEGIN;
INSERT INTO `goods` VALUES ('1', '服饰', '1001衣服', '1', '件', '很漂亮', '88', '10.00', '1', '8.00', '20180512170228871.jpg', '0'), ('2', '饮料', '2', '2', '2', '111', '2', '10.00', '0', '0.00', '20180514221736949.jpg', '0');
COMMIT;

-- ----------------------------
--  Table structure for `notice`
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `n_id` int(10) NOT NULL AUTO_INCREMENT,
  `n_content` text,
  `n_date` datetime DEFAULT NULL,
  `n_isdel` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`n_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `notice`
-- ----------------------------
BEGIN;
INSERT INTO `notice` VALUES ('1', '欢迎来到网上超市', '2018-05-14 22:24:06', '0');
COMMIT;

-- ----------------------------
--  Table structure for `orders`
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
--  Records of `orders`
-- ----------------------------
BEGIN;
INSERT INTO `orders` VALUES ('3', '8', '0', '5', '44.00', '顾客1的弟弟', '123456', '顾客1的收货地址', '1', '2', '2018-05-13 21:58:21', '0'), ('4', '8', '0', '48', '384.00', '顾客1', '123456', '1', '0', '1', '2018-05-14 11:17:53', '0');
COMMIT;

-- ----------------------------
--  Table structure for `sale`
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
--  Records of `sale`
-- ----------------------------
BEGIN;
INSERT INTO `sale` VALUES ('1', '0', '1', '1', '1', '2', '1', '1', '10.00', '1', '8.00', '8', '8.00', '0', '2018-05-12 23:01:22', '0'), ('14', '3', '0', '1', '1', '1001衣服', '服饰', '件', '10.00', '1', '8.00', '3', '24.00', '2', '2018-05-13 21:58:21', '0'), ('15', '3', '0', '2', '2', '2', '2', '2', '10.00', '0', '0.00', '2', '20.00', '2', '2018-05-13 21:58:21', '0'), ('16', '4', '0', '1', '1', '1001衣服', '服饰', '件', '10.00', '1', '8.00', '48', '384.00', '1', '2018-05-14 11:17:53', '0');
COMMIT;

-- ----------------------------
--  Table structure for `tea_estimate`
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
--  Records of `tea_estimate`
-- ----------------------------
BEGIN;
INSERT INTO `tea_estimate` VALUES ('1', '1', '1', '老师1评价', '2018-04-11 18:15:51', '0'), ('2', '3', '3', '123', '2018-04-16 21:49:56', '0'), ('3', '5', '5', '1', '2018-05-12 13:34:19', '0'), ('4', '3', '3', '不错', '2018-05-12 13:34:37', '0'), ('5', null, null, '哈哈', '2018-05-13 16:37:27', '0'), ('6', null, null, '111', '2018-05-13 16:38:35', '0'), ('7', null, null, '123', '2018-05-13 16:39:32', '0'), ('8', '1', '1', '123', '2018-05-13 16:40:26', '0'), ('9', '1', '1', '哈哈', '2018-05-13 16:40:34', '0'), ('10', '1', '1', '再次评价', '2018-05-13 16:41:02', '0'), ('11', '1', '1', '很不错', '2018-05-13 16:41:57', '0');
COMMIT;

-- ----------------------------
--  Table structure for `users`
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
--  Records of `users`
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES ('3', 'admin', 'admin', '管理员', '计算机学院', '0', '15800000000', null, null, '0'), ('4', 'stu1', '123', 'stu1', '测试学院', '1', '13000000000', null, null, '0'), ('5', 'stu2', 'null', 'stu2', null, '1', '13100000000', null, null, '0'), ('7', 'clienta', '123', '参与用户', 'null', '1', '123', '2', '2', '0'), ('8', 'client', '123456', '顾客1', null, '1', '123456', '1', '2', '0');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
