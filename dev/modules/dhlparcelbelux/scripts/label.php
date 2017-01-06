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

require_once('../../../config/config.inc.php');
require_once(_PS_MODULE_DIR_ . 'dhlparcelbelux/includes/settings.inc.php');

require_once(_PS_MODULE_DIR_ . 'dhlparcelbelux/classes/models/Order.php');
require_once(_PS_MODULE_DIR_ . 'dhlparcelbelux/classes/models/Label.php');

require_once(_PS_MODULE_DIR_ . 'dhlparcelbelux/classes/services/Label.php');

require_once(_PS_MODULE_DIR_ . 'dhlparcelbelux/classes/Settings.php');
require_once(_PS_MODULE_DIR_ . 'dhlparcelbelux/classes/Request.php');

// Instantiate the DPB order

$action    = Tools::getValue('action');
$order     = Tools::getValue('order');
$label     = Tools::getValue('label');
$labels    = Tools::getValue('labels');

$dpb_order = new DHLParcelBeluxModelOrder($order);
$errors    = DHLParcelBeluxModelOrder::settingsErrors();

if ((empty($label) && empty($labels)) || empty($order)) {
    die(Tools::jsonEncode(array( 'result' => 'error' )));
}

$cookie = new Cookie('psAdmin');
if (empty($cookie->id_employee)) {
    die(Tools::jsonEncode(array( 'result' => 'error' )));
}

if (!empty($labels)) {
    $labels = explode('/', $labels);
    $pdf = $dpb_order->getLabels($labels);
} else {
    $pdf = $dpb_order->getLabel($label);
}

if (is_array($pdf)) {
    echo '<h2>Unable to create label</h2>';
    echo '<ul>';
    
    foreach ($pdf as $error) {
        echo '<li>' . $error . '</li>';
    }

    echo '</ul>';
    return;
}

echo $pdf;
