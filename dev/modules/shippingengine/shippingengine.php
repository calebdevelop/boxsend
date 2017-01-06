<?php
/**
 * Created by PhpStorm.
 * User: IDBOOSTER
 * <contact@iebooster.com>
 * Date: 24/10/2016
 * Time: 15:17
 */

//namespace IDB;
if (!defined('_PS_VERSION_')) {
	exit;
}

require(dirname(__FILE__) . './autoload.php');
class shippingengine extends Module{
	protected $carriersName = array(
		'DHL','TNT','UPS','GLS'
	);
	public function __construct(){
		$this->name = 'shippingengine';
		$this->tab = 'administration';
		$this->version = '1.0.0';
		$this->author = 'JK Creation';
		$this->need_instance = 1;
		/**
		 * Set $this->bootstrap to true if your module is compliant with bootstrap (PrestaShop 1.6)
		 */
		$this->bootstrap = true;

		parent::__construct();

		$this->displayName = $this->l('Shipping Engine');
		$this->description = $this->l('Shipping Engine');


		//$this->unistallTab();
		//$this->installTab();
		//$this->registerHook('shippingEngineSearch');
		//exit();
	}

	public function hookModuleRoutes(){
		return self::$ModuleRoutes;
	}

	public function install(){
		return parent::install() && $this->installDb() && $this->installTab() && $this->_installConfig() &&
			$this->registerHook('header') &&
			$this->registerHook('shippingEngineSearch') &&
			$this->registerHook('displayHome') &&
			$this->registerHook('backOfficeHeader');
	}
	public function installDb(){
		/**
		 * @todo : require sql
		**/
		return true;
	}

	public function _installConfig(){
		/**
		 * @todo : isntall config
		 **/
		return true ;
	}

	public function unistallTab(){
		$tabParent = new Tab((int)Tab::getIdFromClassName('AdminShippingEngine'));
		$tabParent->delete();

		$tab = new Tab((int)Tab::getIdFromClassName('AdminZoneDeparture'));
		$tab->delete();

		$tab = new Tab((int)Tab::getIdFromClassName('AdminZoneArrival'));
		$tab->delete();

		$tab = new Tab((int)Tab::getIdFromClassName('AdminCountry'));
		$tab->delete();

		return true ;
	}

	public function installTab(){
		if(!(int)Tab::getIdFromClassName('AdminShippingEngine')) {
			$tabParent = new Tab();
			// Need a foreach for the language
			$tabParent->name[$this->context->language->id] = $this->l('Shipping Engine');
			$tabParent->class_name = 'AdminShippingEngine';
			$tabParent->id_parent = 0; // Home tab
			$tabParent->module = $this->name;
			$tabParent->add();
		}
		//------------------------------------------------
		// Tab Zone
		//------------------------------------------------

		if(!(int)Tab::getIdFromClassName('AdminZoneDeparture')) {
			$tab = new Tab();
			foreach (Language::getLanguages() as $language)
				$tab->name[$language['id_lang']] = $this->l('Departure');

			$tab->class_name = 'AdminZoneDeparture';
			$tab->id_parent = (int)Tab::getIdFromClassName('AdminShippingEngine');
			$tab->module = $this->name;

			$tab->add();
		}

		if(!(int)Tab::getIdFromClassName('AdminZoneArrival')) {
			$tab = new Tab();
			foreach (Language::getLanguages() as $language)
				$tab->name[$language['id_lang']] = $this->l('Arrival');

			$tab->class_name = 'AdminZoneArrival';
			$tab->id_parent = (int)Tab::getIdFromClassName('AdminShippingEngine');
			$tab->module = $this->name;

			$tab->add();
		}

		//------------------------------------------------
		// Tab Country
		//------------------------------------------------
		if(!(int)Tab::getIdFromClassName('AdminCountry')) {
			$tab = new Tab();
			foreach (Language::getLanguages() as $language)
				$tab->name[$language['id_lang']] = $this->l('Country');

			$tab->class_name = 'AdminCountry';
			$tab->id_parent = (int)Tab::getIdFromClassName('AdminShippingEngine');
			$tab->module = $this->name;
			$tab->add();
		}

		return true ;
	}

	public function getContent(){
		$controller = $this->context->controller;
		$controller->addJS($this->_path.'/views/js/back/product.js');
		$controller->addJs($this->_path . "/views/js/jquery/plugins/select2/select2.min.js");
		$controller->addJs($this->_path . "/views/js/jquery/plugins/select2/select2_locale_" . $this->context->language->iso_code . ".js");
		$controller->addCss($this->_path . "/views/js/jquery/plugins/select2/select2.css");
		$controller->addCss($this->_path . "/views/js/jquery/plugins/select2/select2-bootstrap.css");

		$output = '';
		$errors = array();

		if( Tools::isSubmit('submitSaveCarrierConfig') ){
			$output .= $this->saveCarrier();
		}

		if( Tools::isSubmit('submitSaveProduct') ){
			$output .= $this->saveProduct();
		}

		$id_product_shipping = Configuration::get('SE_PRODUCT_ID');
		$product = new ProductCore((int)$id_product_shipping,false,$this->context->language->id);

		$this->context->smarty->assign([
			'imageCover' => $product->id ? $product->getCoverWs() : "",
			'link' => $this->context->link ,
			'ajax_product_list_url' => _PS_BASE_URL_ . _MODULE_DIR_ . get_class($this) . "/ajax_products_list.php" ,
			'zTokenAjax' => Tools::getAdminTokenLite('AdminModules'),
			'actionUrl' => $this->context->link->getAdminLink('AdminModules', false).'&configure='.$this->name.'&tab_module='.$this->tab.'&module_name='.$this->name . '&token=' . Tools::getAdminTokenLite('AdminModules'),
			'product' => $product,
			'id_lang' => $this->context->language->id,
			//'mainConfiguration' => $output.$this->renderFormMain(),
		]);

		//$output .= $this->context->smarty->fetch(dirname(__FILE__).'/views/templates/module/main.tpl');
		$output .= $this->context->smarty->fetch(dirname(__FILE__).'/views/templates/module/main-new.tpl');
		return $output;
	}

	public function saveCarrier(){
		$output = "";
		if( Tools::getValue('IDB_SHIPPINENGINE') ){
			$tmPostConfigurations = Tools::getValue('IDB_SHIPPINENGINE');
			foreach($this->carriersName as $carrierName){
				if( isset($tmPostConfigurations[$carrierName]) ){
					foreach( $tmPostConfigurations[$carrierName] as $key => $value ){
						$configName = 'IDB_SHIPPINENGINE_' . $carrierName . '_' . $key;
						ConfigurationCore::updateValue($configName , $value);
					}

					$output .= $this->displayConfirmation( $this->l("Paramètres de " . $carrierName . " mis à jour"));
				}
			}
		}
		return $output;
	}

	public function saveProduct(){
		if( Tools::getValue('id_product') ){
			$product = new Product((int)Tools::getValue('id_product'));
			if( !ValidateCore::isLoadedObject($product) ){
				return $this->displayError($this->l("Invalid product"));
			}else{
				Configuration::updateValue('SE_PRODUCT_ID',(int)Tools::getValue('id_product'));
				return $this->displayConfirmation( $this->l("Save success"));
			}
		}
	}
	public function renderFormMain(){
		$zones = ZoneCore::getZones(true);
		$zonesArray = array();
		foreach($zones as $zone){
			$zonesArray[] = [
				'id' => $zone['id_zone'],
				'name' => $zone['name'],
				'val' => $zone['id_zone']
			];
		}
		$fields_form = array(
			'form' => array(
				'legend' => array(
					'title' => $this->l('Shipping Engine parameters'),
					'icon' => 'icon-envelope-alt'
				),
				'input' => array(
					array(
						'type' => 'switch',
						'label' => $this->l('Active'),
						'name' => 'active',
						'required' => true,
						'class' => 't',
						'is_bool' => true,
						'hint' => $this->l(''),
						'values' => array(
							array(
								'id' => 'active_on',
								'value' => 1,
								'label' => $this->l('Enabled')
							),
							array(
								'id' => 'active_off',
								'value' => 0,
								'label' => $this->l('Disabled')
							)
						),
					),
					array(
						'type' => 'switch',
						'label' => $this->l('Mode test'),
						'name' => 'IDB_SHIPPINGENGINE_TEST_MODE',
						'required' => true,
						'class' => 't',
						'is_bool' => true,
						'hint' => $this->l(''),
						'values' => array(
							array(
								'id' => 'active_on',
								'value' => 1,
								'label' => $this->l('Enabled')
							),
							array(
								'id' => 'active_off',
								'value' => 0,
								'label' => $this->l('Disabled')
							)
						),
					),
					array(
						'type' => 'checkbox',
						'label' => $this->l('Zone'),
						'name' => 'id_zone[]',
						'required' => true,
						'values' => array(
							'query' => $zonesArray,
							'id' => 'id',
							'name' => 'name',
							'value' => '1'
						),
						'tab' => 'config',
					),
				),
				'submit' => array(
					'title' => $this->l('Save'),
				)
			)
		);

		$helper = new HelperForm();
		$helper->show_toolbar = false;
		$helper->table = $this->table;
		$helper->identifier = $this->identifier;
		$helper->submit_action = 'submitSaveZone';
		$helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false).'&configure='.$this->name.'&tab_module='.$this->tab.'&module_name='.$this->name;
		$helper->token = Tools::getAdminTokenLite('AdminModules');


		$dataValues = array();
		$tmSeZones = SeZone::getList();
		$dataValues['active'] = Configuration::get('IDB_SHIPPIN_ENGINE_ENABLE') ? Configuration::get('IDB_SHIPPIN_ENGINE_ENABLE') : 1;
		$dataValues['IDB_SHIPPINGENGINE_TEST_MODE'] = Configuration::get('IDB_SHIPPINGENGINE_TEST_MODE') ? Configuration::get('IDB_SHIPPINGENGINE_TEST_MODE') : 1;

		foreach($tmSeZones as $zone){
			$dataValues['id_zone[]_' . $zone['id_zone']] = "on";
		}

		$helper->tpl_vars = array(
			'fields_value' => $dataValues,
			'languages' => $this->context->controller->getLanguages(),
			'id_language' => $this->context->language->id
		);

		return $helper->generateForm(array($fields_form));
	}

	public function hookShippingEngineSearch(){
		$id_lang = $this->context->language->id;
		$departuresCountries = SeZone::getAllCountries($id_lang,'departure');
		$arrivalsCountries = SeZone::getAllCountries($id_lang,'arrival');
		$tmColis = SeColis::getList($id_lang);

		$this->smarty->assign([
			'arrivalsCountries' => $arrivalsCountries,
			'departuresCountries' => $departuresCountries,
			'tmColis' => $tmColis
		]);
		return $this->display(__FILE__, 'views/templates/hook/form.tpl');
	}

	public function hookHeader(){
		$this->context->controller->addJs(_MODULE_DIR_ . get_class($this) . "/views/js/jquery/plugins/select2/select2.min.js");
		$this->context->controller->addJs(_MODULE_DIR_ . get_class($this) . "/views/js/search.js");
		$this->context->controller->addJs(_MODULE_DIR_ . get_class($this) . "/views/js/jquery/plugins/select2/select2_locale_" . $this->context->language->iso_code . ".js");

		$this->context->controller->addJqueryUI('ui.datepicker');

		$this->context->controller->addCss(_MODULE_DIR_ . get_class($this) . "/views/js/jquery/plugins/select2/select2.css");
		$this->context->controller->addCss(_MODULE_DIR_ . get_class($this) . "/views/js/jquery/plugins/select2/select2-bootstrap.css");
	}
}