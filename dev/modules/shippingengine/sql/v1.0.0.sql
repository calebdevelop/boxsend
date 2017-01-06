CREATE TABLE `ps_se_zone` (
  `id_se_zone` INT NOT NULL AUTO_INCREMENT,
  `id_zone` INT NOT NULL,
  `active` TINYINT NOT NULL,
  `comment` TEXT,
  `date_add` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_se_zone`)
) ;

CREATE TABLE `ps_se_country` (
  `id_se_country` INT NOT NULL AUTO_INCREMENT,
  `id_country` INT NOT NULL,
  `active` TINYINT NOT NULL,
  `comment` TEXT,
  `date_add` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_se_country`)
) ;

ALTER TABLE `ps_cart_product` ADD COLUMN `rate_id` VARCHAR(255) NULL AFTER `date_add`;

CREATE TABLE `ps_cart_destination` (
  `id_cart_address` INT NOT NULL AUTO_INCREMENT,
  `id_cart` INT NOT NULL,
  `country_iso_code` CHAR(3) NOT NULL,
  `type` ENUM('departure','arrival') NOT NULL,
  `postcode` VARCHAR (10) NOT NULL,
  `city` VARCHAR (255) NOT NULL,
  `date_departure` DATETIME NOT NULL,
  PRIMARY KEY (`id_cart_address`)
) ;

ALTER TABLE `ps_cart` ADD COLUMN `is_single_cart` INT DEFAULT 0 NULL AFTER `date_upd`;

CREATE TABLE `ps_se_address` (
  `id_se_address` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_country` int(10) unsigned NOT NULL,
  `id_cart` int(10) unsigned NOT NULL,
  `id_state` int(10) unsigned DEFAULT NULL,
  `id_customer` int(10) unsigned NOT NULL DEFAULT '0',
  `alias` varchar(32) NOT NULL,
  `company` varchar(64) DEFAULT NULL,
  `lastname` varchar(32) NOT NULL,
  `firstname` varchar(32) NOT NULL,
  `address1` varchar(128) NOT NULL,
  `address2` varchar(128) DEFAULT NULL,
  `postcode` varchar(12) DEFAULT NULL,
  `city` varchar(64) NOT NULL,
  `other` text,
  `gender` CHAR(3),
  `email` VARCHAR(256) NOT NULL,
  `phone` varchar(32) DEFAULT NULL,
  `phone_mobile` varchar(32) DEFAULT NULL,
  `dni` varchar(16) DEFAULT NULL,
  `date_add` datetime NOT NULL,
  `date_upd` datetime NOT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `deleted` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_se_address`),
  KEY `address_customer` (`id_customer`),
  KEY `id_country` (`id_country`),
  KEY `id_cart` (`id_cart`),
  KEY `id_state` (`id_state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `ps_orders` ADD COLUMN `easypost_tracking_id` VARCHAR(255) NULL AFTER `date_upd`, ADD COLUMN `easypost_shipment_id` VARCHAR(255) NULL AFTER `easypost_tracking_id`;

ALTER TABLE `ps_order_detail` ADD COLUMN `id_cart` INT DEFAULT 0 NULL AFTER `original_wholesale_price`, ADD COLUMN `rate_id` VARCHAR(255) DEFAULT '0' NULL AFTER `id_cart`;