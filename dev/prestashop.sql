/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.6.16 : Database - easyshopinternationnal
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `ps_la_file` */

DROP TABLE IF EXISTS `ps_la_file`;

CREATE TABLE `ps_la_file` (
  `id_la_file` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_la_ligation` int(10) unsigned DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `mime` varchar(20) DEFAULT NULL,
  `original_name` varchar(255) NOT NULL,
  `date_add` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_la_file`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ps_la_file` */

/*Table structure for table `ps_la_history` */

DROP TABLE IF EXISTS `ps_la_history`;

CREATE TABLE `ps_la_history` (
  `id_la_history` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_la_ligation` int(10) unsigned NOT NULL,
  `id_employee` int(10) unsigned NOT NULL,
  `id_la_status` int(10) unsigned DEFAULT NULL,
  `id_la_type` int(11) DEFAULT NULL,
  `id_la_subtype` int(11) DEFAULT NULL,
  `mode` enum('add','edit') DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `comment` text,
  `mail_content` text,
  `send_mail` tinyint(4) DEFAULT '0',
  `date_add` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `comment_status` text,
  `mail_addresses` text,
  PRIMARY KEY (`id_la_history`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ps_la_history` */

/*Table structure for table `ps_la_history_file` */

DROP TABLE IF EXISTS `ps_la_history_file`;

CREATE TABLE `ps_la_history_file` (
  `id_la_history_file` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_la_file` int(11) unsigned NOT NULL,
  `id_la_ligation` int(10) unsigned NOT NULL,
  `id_employee` int(10) unsigned NOT NULL,
  `size` int(10) unsigned NOT NULL,
  `mime` varchar(255) NOT NULL,
  `original_name` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `date_add` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_la_history_file`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ps_la_history_file` */

/*Table structure for table `ps_la_history_product` */

DROP TABLE IF EXISTS `ps_la_history_product`;

CREATE TABLE `ps_la_history_product` (
  `id_la_history_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_la_history` int(10) unsigned NOT NULL,
  `id_la_ligation` int(10) unsigned NOT NULL,
  `id_product` int(10) unsigned NOT NULL,
  `comment` text,
  `quantity_concerned` int(10) unsigned NOT NULL DEFAULT '0',
  `quantity_validated` int(10) unsigned NOT NULL DEFAULT '0',
  `quantity_resolved` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_la_history_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ps_la_history_product` */

/*Table structure for table `ps_la_ligation` */

DROP TABLE IF EXISTS `ps_la_ligation`;

CREATE TABLE `ps_la_ligation` (
  `id_la_ligation` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_supplier` int(11) unsigned NOT NULL,
  `id_employee` int(11) unsigned NOT NULL,
  `id_la_type` int(11) unsigned NOT NULL,
  `id_la_status` int(11) unsigned NOT NULL,
  `id_la_subtype` int(11) unsigned NOT NULL,
  `reference` varchar(20) NOT NULL,
  `order_reference_supplier` varchar(20) DEFAULT NULL,
  `order_reference_customer` varchar(20) DEFAULT NULL,
  `mail_addresses` text NOT NULL,
  `send_mail` tinyint(4) DEFAULT '1',
  `comment` text,
  `date_add` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_update` timestamp NULL DEFAULT NULL,
  `date_resolution` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_la_ligation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ps_la_ligation` */

/*Table structure for table `ps_la_ligation_lang` */

DROP TABLE IF EXISTS `ps_la_ligation_lang`;

CREATE TABLE `ps_la_ligation_lang` (
  `id_la_ligation_lang` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_la_ligation` int(11) unsigned NOT NULL,
  `id_lang` int(10) unsigned NOT NULL,
  `mail_content` text,
  PRIMARY KEY (`id_la_ligation_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ps_la_ligation_lang` */

/*Table structure for table `ps_la_products` */

DROP TABLE IF EXISTS `ps_la_products`;

CREATE TABLE `ps_la_products` (
  `id_la_product` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_la_ligation` int(10) unsigned NOT NULL,
  `id_product` int(10) unsigned NOT NULL,
  `comment` text,
  `quantity_concerned` int(10) unsigned NOT NULL DEFAULT '1',
  `quantity_validated` int(11) NOT NULL DEFAULT '0',
  `quantity_resolved` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_la_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ps_la_products` */

/*Table structure for table `ps_la_revive` */

DROP TABLE IF EXISTS `ps_la_revive`;

CREATE TABLE `ps_la_revive` (
  `id_la_revive` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_la_ligation` int(10) unsigned NOT NULL,
  `id_employee` int(11) unsigned NOT NULL,
  `mail_addresses` text NOT NULL,
  `mail_content` text,
  `date_add` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_la_revive`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `ps_la_revive` */

/*Table structure for table `ps_la_status` */

DROP TABLE IF EXISTS `ps_la_status`;

CREATE TABLE `ps_la_status` (
  `id_la_status` int(11) NOT NULL AUTO_INCREMENT,
  `active` tinyint(3) unsigned DEFAULT '0',
  `position` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `color` varchar(32) DEFAULT NULL,
  `code` varchar(26) DEFAULT NULL,
  `icon_class` varchar(50) DEFAULT NULL,
  `stat` tinyint(4) DEFAULT '0',
  `kpi_color` varchar(10) DEFAULT NULL,
  `kpi_position` tinyint(4) DEFAULT '0',
  `selectable` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id_la_status`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `ps_la_status` */

insert  into `ps_la_status`(`id_la_status`,`active`,`position`,`color`,`code`,`icon_class`,`stat`,`kpi_color`,`kpi_position`,`selectable`) values (1,1,0,'#FF9900','opened','icon-archive',1,'color1',1,1),(2,1,1,'#4A86E8','accepted','',0,'',0,1),(3,1,2,'#38761D','resolved','icon-off',1,'color4',5,1),(4,1,3,'#674EA7','special','icon-flask',1,'color3',3,1),(5,1,4,'#990000','denied','icon-tags',1,'color2',2,1),(6,1,5,'#434343','closed','',0,'',0,1),(7,1,1,'#00b49f','partialy_resolved','',0,'',0,0);

/*Table structure for table `ps_la_status_lang` */

DROP TABLE IF EXISTS `ps_la_status_lang`;

CREATE TABLE `ps_la_status_lang` (
  `id_la_status_lang` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_la_status` int(11) NOT NULL,
  `id_lang` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id_la_status_lang`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

/*Data for the table `ps_la_status_lang` */

insert  into `ps_la_status_lang`(`id_la_status_lang`,`id_la_status`,`id_lang`,`name`) values (1,1,1,'Ouvert'),(2,2,1,'Accepté'),(3,3,1,'Résolu'),(4,4,1,'Spécial'),(5,5,1,'Refusé'),(6,6,1,'Fermé '),(7,6,2,'Fermé '),(8,6,3,'Fermé '),(9,1,2,'Ouvert'),(10,1,3,'Ouvert'),(11,2,2,'Accepté'),(12,2,3,'Accepté'),(13,3,2,'Résolu'),(14,3,3,'Résolu'),(15,7,1,'Partiellement résolue'),(16,7,2,'Partiellement résolue'),(17,7,3,'Partiellement résolue');

/*Table structure for table `ps_la_subtype` */

DROP TABLE IF EXISTS `ps_la_subtype`;

CREATE TABLE `ps_la_subtype` (
  `id_la_subtype` int(11) NOT NULL AUTO_INCREMENT,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_la_subtype`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `ps_la_subtype` */

insert  into `ps_la_subtype`(`id_la_subtype`,`active`) values (1,1),(2,1),(3,1),(4,1);

/*Table structure for table `ps_la_subtype_lang` */

DROP TABLE IF EXISTS `ps_la_subtype_lang`;

CREATE TABLE `ps_la_subtype_lang` (
  `id_la_subtype_lang` int(11) NOT NULL AUTO_INCREMENT,
  `id_la_subtype` int(11) NOT NULL,
  `id_lang` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id_la_subtype_lang`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `ps_la_subtype_lang` */

insert  into `ps_la_subtype_lang`(`id_la_subtype_lang`,`id_la_subtype`,`id_lang`,`name`) values (1,1,1,'Produit(s) manquant'),(2,2,1,'Produit(s) défectueux'),(3,3,1,'Produit(s) endommagé(s)'),(4,4,1,'Produit(s) incomplet(s)');

/*Table structure for table `ps_la_type` */

DROP TABLE IF EXISTS `ps_la_type`;

CREATE TABLE `ps_la_type` (
  `id_la_type` int(11) NOT NULL AUTO_INCREMENT,
  `active` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id_la_type`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `ps_la_type` */

insert  into `ps_la_type`(`id_la_type`,`active`) values (1,1),(2,1),(3,1);

/*Table structure for table `ps_la_type_lang` */

DROP TABLE IF EXISTS `ps_la_type_lang`;

CREATE TABLE `ps_la_type_lang` (
  `id_la_type_lang` int(11) NOT NULL AUTO_INCREMENT,
  `id_lang` int(11) NOT NULL,
  `id_la_type` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id_la_type_lang`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `ps_la_type_lang` */

insert  into `ps_la_type_lang`(`id_la_type_lang`,`id_lang`,`id_la_type`,`name`) values (1,1,1,'Logistique'),(2,1,2,'Presse'),(3,1,3,'SAV');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
