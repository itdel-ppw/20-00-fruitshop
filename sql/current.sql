/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 10.4.7-MariaDB : Database - fruitshop_db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
USE `fruitshop_db`;

/*Table structure for table `account` */

DROP TABLE IF EXISTS `account`;

CREATE TABLE `account` (
  `email` varchar(64) NOT NULL,
  `password` char(128) NOT NULL,
  `full_name` varchar(64) NOT NULL,
  `address` text DEFAULT NULL,
  `image` varchar(128) NOT NULL,
  `owner` tinyint(1) NOT NULL DEFAULT 0,
  `last_login` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `account` */

/*Table structure for table `cart` */

DROP TABLE IF EXISTS `cart`;

CREATE TABLE `cart` (
  `id` char(64) NOT NULL,
  `payment` varchar(64) NOT NULL,
  `fruit` varchar(64) NOT NULL,
  `amount` int(2) unsigned NOT NULL DEFAULT 0,
  `price` float(6,2) unsigned NOT NULL DEFAULT 0.00,
  `total_price` float(6,2) unsigned NOT NULL DEFAULT 0.00,
  `rating` int(2) unsigned NOT NULL DEFAULT 0,
  `placed_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `fruit` (`fruit`),
  KEY `payment` (`payment`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`payment`) REFERENCES `payment` (`id`),
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`fruit`) REFERENCES `fruit` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cart` */

/*Table structure for table `fruit` */

DROP TABLE IF EXISTS `fruit`;

CREATE TABLE `fruit` (
  `id` char(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `latin` varchar(64) NOT NULL,
  `color` varchar(64) NOT NULL,
  `description` varchar(256) DEFAULT NULL,
  `image` varchar(128) NOT NULL,
  `price` float(6,2) unsigned NOT NULL DEFAULT 0.00,
  `weight` float(6,2) unsigned NOT NULL DEFAULT 0.00,
  `added_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `fruit` */

insert  into `fruit`(`id`,`name`,`latin`,`color`,`description`,`image`,`price`,`weight`,`added_at`) values ('0e21b9e56243d2915bd56d09034cecf5a4e20c86a928cb63623acfb83494217c','Grape','Vitis vinifera','Green, Purple, Red, & White','Very delicious.','images/grape.jpg',3.40,400.00,'2018-09-09 20:24:13');
insert  into `fruit`(`id`,`name`,`latin`,`color`,`description`,`image`,`price`,`weight`,`added_at`) values ('77d04b1ea52cc7145049407abfaf761b76af78f26ef5c5d451a3f2f190c11ce5','Cherry','Prunus avium','Red','On top of the case.','images/cherry.jpg',1.20,200.00,'2018-09-20 20:24:18');
insert  into `fruit`(`id`,`name`,`latin`,`color`,`description`,`image`,`price`,`weight`,`added_at`) values ('ca7baa9f5a65d045756e291728eb0df6a9da8d80bdcf397284d48b8cd8746112','Apple','Malus','Red & Green','Everyone loves it.','images/apple.jpg',1.00,800.00,'2018-09-04 20:24:22');
insert  into `fruit`(`id`,`name`,`latin`,`color`,`description`,`image`,`price`,`weight`,`added_at`) values ('fdc8e69bc9ce41b3bdc72163c88265afefe1931f082221a8982f3cd75de8c1dc','Strawberry','Fragaria','Red & Green','Kids\' favourite.','images/strawberry.jpg',1.75,800.00,'2018-10-03 20:24:28');

/*Table structure for table `fruit_voting` */

DROP TABLE IF EXISTS `fruit_voting`;

CREATE TABLE `fruit_voting` (
  `id` varchar(64) NOT NULL,
  `voted_fruit` varchar(64) NOT NULL,
  `voted_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `voted_fruit` (`voted_fruit`),
  CONSTRAINT `fruit_voting_ibfk_1` FOREIGN KEY (`voted_fruit`) REFERENCES `fruit` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `fruit_voting` */

/*Table structure for table `payment` */

DROP TABLE IF EXISTS `payment`;

CREATE TABLE `payment` (
  `id` char(64) NOT NULL,
  `buyer` varchar(64) NOT NULL,
  `total_price` float(6,2) unsigned NOT NULL DEFAULT 0.00,
  `delivery_address` text DEFAULT NULL,
  `transaction_url` char(64) DEFAULT NULL,
  `payed_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `issued_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `buyer` (`buyer`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`buyer`) REFERENCES `account` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `payment` */

/*Table structure for table `status` */

DROP TABLE IF EXISTS `status`;

CREATE TABLE `status` (
  `id` char(64) NOT NULL,
  `text` varchar(128) NOT NULL,
  `published_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `status` */

/*Table structure for table `stock` */

DROP TABLE IF EXISTS `stock`;

CREATE TABLE `stock` (
  `id` char(64) NOT NULL,
  `payment` char(64) DEFAULT NULL,
  `cart` char(64) DEFAULT NULL,
  `fruit` char(64) NOT NULL,
  `best_before` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fruit` (`fruit`),
  KEY `payment` (`payment`),
  KEY `cart` (`cart`),
  CONSTRAINT `stock_ibfk_1` FOREIGN KEY (`fruit`) REFERENCES `fruit` (`id`),
  CONSTRAINT `stock_ibfk_2` FOREIGN KEY (`payment`) REFERENCES `payment` (`id`),
  CONSTRAINT `stock_ibfk_3` FOREIGN KEY (`cart`) REFERENCES `cart` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `stock` */

/*Table structure for table `testimony` */

DROP TABLE IF EXISTS `testimony`;

CREATE TABLE `testimony` (
  `id` char(64) NOT NULL,
  `text` varchar(128) NOT NULL,
  `email` varchar(64) NOT NULL,
  `full_name` varchar(64) NOT NULL,
  `image` varchar(128) NOT NULL,
  `published_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `testimony` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
