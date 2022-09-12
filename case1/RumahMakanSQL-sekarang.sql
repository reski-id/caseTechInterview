/*
SQLyog Ultimate
MySQL - 5.7.24 : Database - rumah_makan_dbapp
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`rumah_makan_dbapp` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `rumah_makan_dbapp`;

/*Table structure for table `table_costumer` */

DROP TABLE IF EXISTS `table_costumer`;

CREATE TABLE `table_costumer` (
  `Costumer_ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `phone` char(13) DEFAULT NULL,
  `seated_table` int(3) DEFAULT NULL,
  `time_in` datetime DEFAULT NULL,
  `time_out` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`Costumer_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `table_costumer` */

insert  into `table_costumer`(`Costumer_ID`,`name`,`address`,`phone`,`seated_table`,`time_in`,`time_out`,`created_at`,`updated_at`,`deleted_at`) values 
(1,'Ahmed','Jakarta','081234561234',1,'2022-09-12 22:42:54',NULL,'2022-09-12 22:43:51',NULL,NULL),
(2,'Lia','Jakarta','081243561234',2,'2022-09-12 22:43:45',NULL,'2022-09-12 22:43:54',NULL,NULL),
(3,'Ronal','Jakarta','081343561567',2,'2022-09-12 22:44:44',NULL,'2022-09-12 22:44:49',NULL,NULL),
(4,'Leo','Jakarta','081234564321',1,'2022-09-12 22:45:54',NULL,'2022-09-12 22:45:58',NULL,NULL);

/*Table structure for table `table_food` */

DROP TABLE IF EXISTS `table_food`;

CREATE TABLE `table_food` (
  `Food_ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `type` varchar(25) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `food_info` varchar(250) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`Food_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `table_food` */

insert  into `table_food`(`Food_ID`,`name`,`price`,`type`,`stock`,`food_info`,`created_at`,`updated_at`,`deleted_at`) values 
(1,'Applebee\'s',50000,'Bakeries ',100,'Among the options are Cedar-Grilled Lemon Chicken and Thai Shrimp Salad. Your best bet is probably the Pepper-Crusted Sirloin & Whole Grains — served with spinach, mushrooms and tomatoes','2022-09-12 22:54:03',NULL,NULL),
(2,'Fay Da',10000,'Bakeries ',100,'Choose from large- or mini-sized collections of golden Cantonese-style mooncakes with traditional fillings like white lotus egg yolk, red bean and jujube-walnut','2022-09-12 22:59:36',NULL,NULL);

/*Table structure for table `table_order` */

DROP TABLE IF EXISTS `table_order`;

CREATE TABLE `table_order` (
  `Order_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Costumer_ID` int(11) DEFAULT NULL,
  `Food_ID` int(11) DEFAULT NULL,
  `Quantity` int(5) DEFAULT NULL,
  `cooking_time_minutes` int(5) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`Order_ID`),
  KEY `Costumer_ID` (`Costumer_ID`),
  KEY `Food_ID` (`Food_ID`),
  CONSTRAINT `table_order_ibfk_1` FOREIGN KEY (`Costumer_ID`) REFERENCES `table_costumer` (`Costumer_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `table_order_ibfk_2` FOREIGN KEY (`Food_ID`) REFERENCES `table_food` (`Food_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `table_order` */

insert  into `table_order`(`Order_ID`,`Costumer_ID`,`Food_ID`,`Quantity`,`cooking_time_minutes`,`price`,`created_at`,`updated_at`,`deleted_at`) values 
(1,1,2,2,5,20000,'2022-09-12 23:08:39',NULL,NULL),
(2,2,1,3,10,150000,'2022-09-12 23:09:08',NULL,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
