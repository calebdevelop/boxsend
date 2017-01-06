<?php
/**
 * Created by PhpStorm.
 * User: Anthony
 * Date: 19/12/2016
 * Time: 17:53
 */

if( !class_exists('SeZone') ){
    require(dirname(__FILE__) . './classes/SeZone.php');
}
if( !class_exists('SeColis') ){
    require(dirname(__FILE__) . './classes/SeColis.php');
}
if( !class_exists('SeCountry') ) {
    require(dirname(__FILE__) . './classes/SeCountry.php');
}
if( !class_exists('SeTools') ) {
    require(dirname(__FILE__) . './classes/SeTools.php');
}

if( !class_exists('SeShipment') ) {
    require(dirname(__FILE__) . './classes/SeShipment.php');
}