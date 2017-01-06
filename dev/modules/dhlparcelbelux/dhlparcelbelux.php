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

class DHLParcelBelux extends CarrierModule
{

    public static $instance;

    private $postErrors;
    private $successMessages;

    public $defaultLanguage;
    public $languages;

    public $shipping_methods = array();
    public $carriers = array();
    public $carrier = null;

    protected $config = null;
    protected $orders_page = null;
    protected $settings = null;
    protected $carrier_displayed = 0;

    public function __construct($only_for_translation = false)
    {
        // If we have no PrestaShop version defined, get out

        if (!defined('_PS_VERSION_')) {
            exit;
        }

        if ($only_for_translation === true) {
            return true;
        }

        // General description of the module

        $this->name                   = 'dhlparcelbelux';
        $this->tab                    = 'shipping_logistics';
        $this->version                = '1.0.5';
        $this->author                 = 'Stigmi.eu';
        $this->needinstance           = 0;
        $this->ps_versions_compliancy = array('min' => '1.4', 'max' => '1.6.5');
        $this->module_key             = '6eb3d0ff807e367ae5cf1bf9dab5558f';

        parent::__construct();

        // Module administration tab information

        $this->displayName            = $this->l('DHL PARCEL BELUX');
        $this->description            = $this->l('Send parcels with DHL services');
        $this->confirmUninstall       = $this->l('Are you sure you want to uninstall this module?');

        $this->defaultLanguage       = (int) Configuration::get('PS_LANG_DEFAULT');
        $this->languages             = Language::getLanguages();

        // Backward compatibility

        $this->addBackward();
        
        require_once(_PS_MODULE_DIR_ . 'dhlparcelbelux/includes/settings.inc.php');

        // Require the custom classes

        require_once(_PS_MODULE_DIR_ . 'dhlparcelbelux/classes/Request.php');
        require_once(_PS_MODULE_DIR_ . 'dhlparcelbelux/classes/Carrier.php');
        require_once(_PS_MODULE_DIR_ . 'dhlparcelbelux/classes/Settings.php');

        // Models

        require_once(_PS_MODULE_DIR_ . 'dhlparcelbelux/classes/models/Cart.php');
        require_once(_PS_MODULE_DIR_ . 'dhlparcelbelux/classes/models/Order.php');

        // Services

        require_once(_PS_MODULE_DIR_ . 'dhlparcelbelux/classes/services/ParcelShop.php');

        // Require the admin tab controller

        if (_PS_VERSION_ >= 1.5) {
            require_once(_PS_MODULE_DIR_ . 'dhlparcelbelux/controllers/admin/AdminOrdersDHL.php');
        } else {
            require_once(_PS_MODULE_DIR_ . 'dhlparcelbelux/classes/AdminOrdersDHL.php');
        }

        // Tools

        require_once(_PS_MODULE_DIR_ . 'dhlparcelbelux/classes/Tools.php');
        DHLParcelBeluxTools::getInstance();

        $this->bootstrap = (dpb_is_ps_6);

        $this->carrier = DHLParcelBeluxCarrier::getInstance($this);
        $this->carriers = $this->carrier->carriers_ids;

        DHLParcelBeluxTools::getInstance($this);

        if (empty($this->smarty)) {
            $this->context = Context::getContext();
            $this->smarty = &$this->context->smarty;
        }
    }

    /**
     * Method creating the unique class instance if it doesn't exist yet and returns it.
     *
     * @param void
     * @return Core
     */
    public static function getInstance()
    {
        if (empty(self::$instance)) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    /**
     * Load backward compatibility classes
     *
     * @param void
     * @return Core
     */
    public function addBackward()
    {

        $backward_file = _PS_MODULE_DIR_ . $this->name . '/backward_compatibility/backward.php';
           
        if (_PS_VERSION_ < '1.5' && file_exists($backward_file)) {
            require($backward_file);
        }
    }

    public static function lStatic($string)
    {
        $translate = new self(true);
        return $translate->l($string);
    }

    public function install()
    {

        // Populate class members if not already populated

        $this->carrier = DHLParcelBeluxCarrier::getInstance($this);

        // Try executing all the hook connections and various instanciations

        $success = true;
        $success = $success && parent::install();
        $success = $success &&
            // Hooks

            $this->createDatabaseTables()                        &&
            $this->defaultDatabaseValues()                       &&
            $this->registerHook('extraCarrier')                  &&
            $this->registerHook('newOrder')                      &&
            $this->registerHook('backOfficeHeader')              &&
            $this->registerHook('header')                        &&
            $this->registerHook('paymentTop')                    &&
            $this->registerHook('beforeCarrier')                 &&
            true;
            
        if (dpb_is_ps_6 || dpb_is_ps_5) {

            $success = $success &&

            // Hooks

            $this->registerHook('displayOrderDetail')            &&
            $this->registerHook('actionAdminControllerSetMedia') &&
            $this->registerHook('header')                        &&
            $this->registerHook('actionCarrierUpdate')           &&
            $this->registerHook('actionPaymentConfirmation')     &&

            // Embedded classes

            AdminOrdersDHLController::install();
        } else {
            if (!$this->context) {
                $this->context = Context::getContext();
            }

            $success = $success & $this->registerHook('updateCarrier');

            $success = $success && $this->installModuleTab(
                'AdminOrdersDHL',
                $this->l('DHL Orders'),
                Tab::getIdFromClassName('AdminOrders')
            );
        }

        // Embedded classes
        $success = $success && $this->carrier->install();

        return $success;
    }

    public static function getShopID()
    {
        $type = 'all';
        $value = 0;

        $context = Context::getContext();

        if ((dpb_is_ps_6 || dpb_is_ps_5) && $context->cookie->shopContext) {
            $pieces = explode('-', $context->cookie->shopContext);

            if ($pieces[0] == 'g') {
                $type = 'group';
            } elseif ($pieces[0] == 's') {
                $type = 'shop';
            }

            $value = $pieces[1];
        }

        return array(
            'type'  => $type,
            'value' => $value
        );
    }

    public function uninstall()
    {

        // Populate class members if not already populated
        
        $this->carrier = DHLParcelBeluxCarrier::getInstance($this);
        $this->carrier->uninstall();

        // Try executing all the hook connections and various instanciations

        $success = true &&
            // Hooks

            // TODO
            // $this->deleteDatabaseTables()                       &&
            // $this->deleteSettings()                             &&
            $this->unregisterHook('extraCarrier')                  &&
            $this->unregisterHook('newOrder')                      &&
            $this->unregisterHook('backOfficeHeader')              &&
            $this->unregisterHook('header')                        &&
            $this->unregisterHook('processCarrier')                &&
            $this->unregisterHook('beforeCarrier')                 &&
            $this->unregisterHook('displayOrderDetail')            &&
            true;

        if (dpb_is_ps_6 || dpb_is_ps_5) {
            $success = $success &&
                // Parents
                parent::uninstall() &&

                // Hooks

                $this->unregisterHook('actionAdminControllerSetMedia') &&
                $this->unregisterHook('header')                        &&
                $this->unregisterHook('actionCarrierUpdate')           &&
                $this->unregisterHook('paymentTop')                    &&
            

                // Embedded classes

                AdminOrdersDHLController::uninstall();
        } else {
            parent::uninstall();

            $this->unregisterHook('updateCarrier');

            $success = $success && $this->uninstallModuleTab(
                'AdminOrdersDHL'
            );
        }

        return $success;
    }

    /**
     * Delete every settings about DHL module in the ps_configuration table.
     */
    public function deleteSettings()
    {

        $query = 'DELETE FROM ' . _DB_PREFIX_ . 'configuration '
            . 'WHERE `name` like "%' . DHLParcelBeluxSettings::$db_prefix . '%" ';
        return Db::getInstance()->execute($query);
    }

    public function createDatabaseTables()
    {

        $sql_orders = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'dpb_orders` ('
            . '`id_dpb_order` int(10) NOT NULL AUTO_INCREMENT PRIMARY KEY, '
            . '`id_order` int(10), '
            . '`id_shop_group` int(3), '
            . '`id_shop` int(3), '
            . '`id_dpb_cart` int(3), '
            . '`current_state` int(3), '
            . '`printed` int(3) not null default 0, '
            . '`recipient` varchar(64), '
            . '`reference` varchar(64), '
            . '`delivery_type` varchar(32), '
            . '`parcelshop_details` text, '
            . '`features` text, '
            . '`neighbour` tinyint(1), '
            . '`saturdays` tinyint(1), '
            . '`evening` tinyint(1), '
            . '`country_iso` varchar(4), '
            . '`delivery_subtype` varchar(32), '
            . '`date_created` timestamp default "0000-00-00 00:00:00", '
            . '`date_updated` timestamp default now() on update now() '
        . ')';

        $sql_carts = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'dpb_carts` ('
            . '`id_dpb_cart` int(10) NOT NULL AUTO_INCREMENT PRIMARY KEY, '
            . '`id_cart` int(10), '
            . '`shop_id` int(10), '
            . '`dpb_shop_id` int(10), '
            . '`parcelshop_details` text, '
            . '`neighbour` tinyint(1), '
            . '`saturdays` tinyint(1), '
            . '`evening` tinyint(1), '
            . '`country_iso` varchar(4), '
            . '`id_carrier` int(10), '
            . '`date_created` timestamp default "0000-00-00 00:00:00", '
            . '`date_updated` timestamp default now() on update now() '
        . ')';

        $sql_labels = 'CREATE TABLE IF NOT EXISTS `' . _DB_PREFIX_ . 'dpb_labels` ('
            . '`id_dpb_label` int(11) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY, '
            . '`id_dpb_order` int(11) unsigned NOT NULL, '
            . '`tracking_code` varchar(32), '
            . '`date_created` timestamp default "0000-00-00 00:00:00", '
            . '`date_updated` timestamp default now() on update now() '
        . ')';

        $db_instance = DB::getInstance();

        return (
            $db_instance->Execute($sql_orders)
            && $db_instance->Execute($sql_carts)
            && $db_instance->Execute($sql_labels)
        );
    }

    public function deleteDatabaseTables()
    {
        $sql_orders = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'dpb_orders`';
        $sql_carts  = 'DROP TABLE IF EXISTS `' . _DB_PREFIX_ . 'dpb_carts`';
        $db_instance = DB::getInstance();
        
        return $db_instance->Execute($sql_orders) && $db_instance->Execute($sql_carts)    ;
    }

    public function defaultDatabaseValues()
    {
        // Avoid 120 characters for validator

        $settings_prefix = DHLParcelBeluxSettings::$db_prefix;

        // Update configuration settings

        DHLParcelBeluxSettings::saveSingle('delivery_type', 0);
        DHLParcelBeluxSettings::saveSingle('parcelshop_delivery', 1);
        DHLParcelBeluxSettings::saveSingle('international_delivery', 0);

        DHLParcelBeluxTools::updateGlobalValue(Tools::strtoupper($settings_prefix . 'delivery_type'), 0);
        DHLParcelBeluxTools::updateGlobalValue(Tools::strtoupper($settings_prefix . 'parcelshop_delivery'), 1);
        DHLParcelBeluxTools::updateGlobalValue(Tools::strtoupper($settings_prefix . 'international_delivery'), 0);

        return true;
    }

    public function hookHeader($params)
    {

        $module_js_root      = _MODULE_DIR_ . 'dhlparcelbelux/views/js/';
        
        $this->context->controller->addJS($module_js_root . 'front/jquery.front.js');
        $this->context->controller->addJS($module_js_root . 'front/jquery.cookie.js');
    }

    
    public function hookActionAdminControllerSetMedia()
    {
        $controller_class_name = get_class($this->context->controller);
        $configured_module     = !empty($this->context->smarty->tpl_vars['module_name'])
            ? $this->context->smarty->tpl_vars['module_name']->value
            : null;
        
        if ($controller_class_name == 'AdminModulesController' && $configured_module == $this->name) {
            $this->context->controller->addJS($this->_path . 'views/js/admin.js?v=' . time(), false);
            $this->context->controller->addJS($this->_path . 'views/js/maps.js');
        }
    }

    public function hookPaymentTop($params)
    {
        return $this->hookProcessCarrier($params);
    }

    public function hookDisplayOrderDetail($params)
    {
        // Get order_id and carrier_id
        
        $order_id     = $params['order']->id;
        
        // Get dpb_order to get the DHL shop id
        
        $dpb_order = DHLParcelBeluxModelOrder::getByPrestaShopOrderID($order_id);
        $type = DHLParcelBeluxModelOrder::getDeliveryType(0, $params);

        $this->context->smarty->assign(array(
             'type'      => $type,
             'dhl_order' => $dpb_order,
             'features'  => $dpb_order->buildRequestSelectedFeatures(),
             'tracking_code' => DHLParcelBeluxTools::getTrackingCode($dpb_order->id, 1),
             'track_trace_root' => dhlparcelbelux_track_trace_root
        ));

        // If we have a dpb_order, we set the details
        if (!empty($dpb_order)) {

            if (!empty($dpb_order->parcelshop_details)) {
                $parcelshop_details = Tools::jsonDecode(stripslashes($dpb_order->parcelshop_details));
                $type = DHLParcelBeluxModelOrder::getDeliveryType($parcelshop_details->id, $params);

                $this->context->smarty->assign(array(
                     'shop'      => $parcelshop_details,
                ));
            }
        }
        
        return $this->context->smarty->fetch(
            _PS_MODULE_DIR_ . 'dhlparcelbelux/views/templates/front/parcelshop-details.tpl'
        );
    }

    public function getContent()
    {
        
        // Hook onto the "Saved" button
        if (Tools::getIsset('submitModuleDHLParcelBelux')) {

            $send_values = array();

            foreach (DHLParcelBeluxSettings::$fields as $field) {
                $field_prefix = DHLParcelBeluxSettings::$field_prefix . $field;
                $send_values[$field_prefix] = Tools::getValue($field_prefix);
            }

            DHLParcelBeluxSettings::save($send_values);
        }

        // Display the form
        
        return DHLParcelBeluxSettings::display();
    }

    public function hookNewOrder($params)
    {
        DHLParcelBeluxModelCart::hookNewOrder($params);
        DHLParcelBeluxModelOrder::hookNewOrder($params);
    }

    public function hookBackOfficeHeader($params)
    {
        return $this->hookDisplayBackOfficeHeader($params);
    }

    public function hookDisplayBackOfficeHeader($params)
    {
        // Needed for validation (120 chars max)

        $src_opener = '<script type="text/javascript" src="';
        $src_closer = '"></script>';
        
        $return = $src_opener . $this->_path . 'views/js/admin.js?v=' . time() . $src_closer;
        $return .= '<link href="' . $this->_path . 'views/css/dhl-admin.css" type="text/css" rel="stylesheet" />';

        return $return;
    }

    public function hookProcessCarrier($params)
    {
        return $this->carrier->process($params);
    }

    public function hookActionCarrierUpdate($params)
    {
        return $this->carrier->checkEnable($params);
    }

    public function hookUpdateCarrier($params)
    {
        return $this->carrier->checkEnable($params);
    }

    public function hookExtraCarrier($params)
    {
        return $this->carrier->displayExtra($params, $this->smarty);
    }

    public function hookBeforeCarrier($params)
    {
        return '';
    }

    public function getOrderShippingCost($params, $shipping_cost)
    {
        if (empty($params)) {
            $params = array();
        }
        if (empty($shipping_cost)) {
            $shipping_cost = 0;
        }
    }

    public function getOrderShippingCostExternal($params)
    {
        if ($params == null || empty($params)) {
            $params = array();
        }
    }

    public function ajaxGetCleanShopsByLocation()
    {
        @$results_by_location = @DHLParcelBeluxParcelshop::getCleanShops(
            Tools::getValue('zipcode'),
            Tools::getValue('iso_code'),
            Tools::getValue('iso_code'),
            'y'
        );
        
        $google_maps_api_key = dhlparcelbelux_google_maps_api_key;

        if (!empty($results_by_location)) {
            $this->context->smarty->assign(array(
                'shops'                => Tools::jsonEncode($results_by_location),
                'google_maps_api_key'  => $google_maps_api_key
            ));
            
            echo Tools::jsonEncode($results_by_location);
            
            return true;
        } else {
            return false;
        }
        return false;
    }

    /**
     * @param string $tab_class
     * @param string $tab_name
     * @param int $id_tab_parent
     * @return mixed
     */
    private function installModuleTab($tab_class, $tab_name, $id_tab_parent)
    {
        $tab = new Tab();
        $tab->name[$this->context->language->id] = $tab_name;
        $tab->class_name                         = $tab_class;
        $tab->module                             = $this->name;
        $tab->id_parent                          = $id_tab_parent;
        $tab->active                             = 1;
        
        return $tab->save();
    }

    /**
     * @param string $tab_class
     * @return bool
     */
    private function uninstallModuleTab($tab_class)
    {
        $return = true;
        if ($id_tab = Tab::getIdFromClassName($tab_class)) {
            $tab = new Tab($id_tab);
            $return = $return && $tab->delete();
        }
        return $return;
    }

    public static function staticConfirmation($message)
    {
        $return_self = new self();
        return $return_self->displayConfirmation($message);
    }
}
