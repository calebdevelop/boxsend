<?php
/**
 * 2015 Stigmi.eu
 *
 * DHL PARCEL BELUX
 *
 * This certified PrestaShop module is the DHL PARCEL BELUX Module,
 * which enables door-to-door and parcel shops deliveries to BELUX.
 *
 * @author    Stigmi <www.stigmi.eu>
 * @copyright 2015 Stigmi.eu
 * @license   http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
 */

require_once('../../../config/autoload.php');
require_once('../controllers/front/lightbox14.php');

$controller = new DHLParcelBeluxLightboxModuleFrontController();
$controller->displayContent();
