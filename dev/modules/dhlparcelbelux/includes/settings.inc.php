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

// Define global variables for the Parcelshop part

define(
    'DHLPARCELBELUX_SETTINGS_API_PARCELSHOP_ENDPOINT',
    'https://dhlforyounl-dhlforyou-parcelshop-locator-v1.p.mashape.com/datamoduleAPI.jsp',
    true
);
define('DHLPARCELBELUX_SETTINGS_API_PARCELSHOP_VERSION', 2, true);
define('DHLPARCELBELUX_SETTINGS_API_PARCELSHOP_KEY', 'OYujHJLrnimshMPaFg3AtsXCYX0Ip1RNKaljsnzHlfWnj2slxs', true);

// Define global variables for the labels part

define('DHLPARCELBELUX_SETTINGS_API_LABEL_ENDPOINT', 'http://www.dhllabel.nl/labels', true);
define('DHLPARCELBELUX_SETTINGS_API_COUNTRIES_ENDPOINT', 'http://www.dhllabel.nl/countries', true);
define('DHLPARCELBELUX_SETTINGS_API_LABEL_VERSION', 2, true);

// In case the server does not allow base64

define('DHLPARCELBELUX_SETTINGS_API_LABEL_BASE64_AUTH', '', true);

// Global plugin variables

define('DHLPARCELBELUX_SETTINGS_FORCE_EMAIL_NOTIFICATIONS', true, true);
define('DHLPARCELBELUX_SETTINGS_FORCE_EXTRA_INSURANCE', false, true);
define('DHLPARCELBELUX_GOOGLE_MAPS_API_KEY', 'AIzaSyA8vuRQd76n-2pXJsk2cMB-byUxAGpKS_0', true);
define('DHLPARCELBELUX_TRACK_TRACE_ROOT', 'http://www.dhlparcel.be/en/track-and-trace/', true);

// Version constants (shorter for line length validation througout the plugin)

if (!defined('DPB_IS_PS_6')) {
    define('DPB_IS_PS_6', version_compare(_PS_VERSION_, '1.6', '>='), true);
}
if (!defined('DPB_IS_PS_5')) {
    define('DPB_IS_PS_5', version_compare(_PS_VERSION_, '1.5', '>='), true);
}
if (!defined('DPB_IS_PS_4')) {
    define('DPB_IS_PS_4', version_compare(_PS_VERSION_, '1.4', '>='), true);
}
