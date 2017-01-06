<?php
/**
 * Recipe class file
 *
 * PHP Version 5.2
 *
 * @category Admin
 * @package LaLigation
 * @author    Webapp Studio <contact@webapp.studio>
 * @copyright 2007-2015 PrestaShop SA
 * @license   http://opensource.org/licenses/gpl-license.php GNU Public License
 * @link     http://www.webapp.studio/
 */

/**
 * Recipe class
 *
 * The class holding the root Recipe class definition
 *
 * @author    Webapp Studio <contact@webapp.studio>
 * @copyright 2007-2015 PrestaShop SA
 * @license   http://opensource.org/licenses/gpl-license.php GNU Public License
 * @link     http://www.webapp.studio/
 */

class LigationAdmin extends Module
{
    public function __construct()
    {
        $this->name = 'ligationadmin';
        $this->tab = 'administration';
        $this->version = '1.0.0';
        $this->author = 'Webapp Studio';
        $this->need_instance = 1;

        $this->bootstrap = true;

        parent::__construct();

        $this->displayName = $this->l('Supplier disputes');
        $this->description = $this->l('Supplier disputes');
    }

    public function install()
    {
        return parent::install() && $this->installDb() && $this->installTab() && $this->_installConfig() &&
        $this->registerHook('backOfficeHeader');
    }

    public function hookDisplayBackOfficeHeader()
    {
        $this->context->controller->addCss(_MODULE_DIR_ . Tools::strtolower(get_class($this)) . "/views/css/admin.css");
    }

    public function uninstall()
    {
        $this->uninstallDb();
        $this->uninstallTab();
        return parent::uninstall();
    }

    public function uninstallDB()
    {
        $listTable = array(
            'la_ligation_lang',
            'la_history',
            'la_history_product',
            'la_ligation',
            'la_ligation_lang',
            'la_products',
            'la_products',
            'la_revive',
            'la_status',
            'la_status_lang',
            'la_subtype',
            'la_subtype_lang',
            'la_type',
            'la_type_lang',
            'la_subtype_template',
            'la_template'
        );
        foreach ($listTable as $table) {
            Db::getInstance()->query('DROP TABLE IF EXISTS ' . _DB_PREFIX_ . $table);
        }
        return true;
    }

    public function uninstallTab()
    {
        $listTab = array(
            'AdminLaLigation','AdminLaLigationMain','AdminLaType','AdminLaSubtype','AdminLaStatus','AdminLaLigationConfig'
        );
        foreach ($listTab as $tabName) {
            $tabId = (int)Tab::getIdFromClassName($tabName);
            if ($tabId) {
                $tab = new Tab($tabId);
                $tab->delete();
            }
        }
        return true;
    }

    /**
     * Install config
     ***/
    public function _installConfig()
    {
        return true;
    }

    /**
     * Install DB
     **/
    public function installDb()
    {
        $sql = Tools::file_get_contents(_PS_MODULE_DIR_ . Tools::strtolower(get_class($this)) . '/sql/install-1.0.2.sql');
        $sql = str_replace('`ps_', '`' . _DB_PREFIX_, $sql);
        return Db::getInstance()->execute($sql);
    }

    public function installTab()
    {
        if (!(int)Tab::getIdFromClassName('AdminLaLigationMain')) {
            $tabParent = new Tab();
            // Need a foreach for the language
            $tabParent->name[$this->context->language->id] = $this->l('Supplier Helpdesk');
            $tabParent->class_name = 'AdminLaLigationMain';
            //$tabParent->id_parent = (int)Tab::getIdFromClassName('AdminCatalog'); // Home tab
            $tabParent->id_parent = 0;
            $tabParent->module = $this->name;
            $tabParent->add();
        }

        if (!(int)Tab::getIdFromClassName('AdminLaLigation')) {
            $tabParent = new Tab();
            // Need a foreach for the language
            $tabParent->name[$this->context->language->id] = $this->l('Supplier disputes');
            $tabParent->class_name = 'AdminLaLigation';
            $tabParent->id_parent = (int)Tab::getIdFromClassName('AdminLaLigationMain'); // Home tab
            $tabParent->module = $this->name;
            $tabParent->add();
        }

        if (!(int)Tab::getIdFromClassName('AdminLaLigationConfig')) {
            $tabParent = new Tab();
            // Need a foreach for the language
            $tabParent->name[$this->context->language->id] = $this->l('Configuration');
            $tabParent->class_name = 'AdminLaLigationConfig';
            $tabParent->id_parent = (int)Tab::getIdFromClassName('AdminLaLigationMain'); // Home tab
            $tabParent->module = $this->name;
            $tabParent->add();
        }

        if (!(int)Tab::getIdFromClassName('AdminLaType')) {
            $tabParent = new Tab();
            // Need a foreach for the language
            $tabParent->name[$this->context->language->id] = $this->l('Type');
            $tabParent->class_name = 'AdminLaType';
            $tabParent->id_parent = (int)Tab::getIdFromClassName('AdminLaLigationConfig'); // Home tab
            $tabParent->module = $this->name;
            $tabParent->add();
        }

        if (!(int)Tab::getIdFromClassName('AdminLaSubtype')) {
            $tabParent = new Tab();
            // Need a foreach for the language
            $tabParent->name[$this->context->language->id] = $this->l('Subtype');
            $tabParent->class_name = 'AdminLaSubtype';
            $tabParent->id_parent = (int)Tab::getIdFromClassName('AdminLaLigationConfig'); // Home tab
            $tabParent->module = $this->name;
            $tabParent->add();
        }

        if (!(int)Tab::getIdFromClassName('AdminLaStatus')) {
            $tabParent = new Tab();
            // Need a foreach for the language
            $tabParent->name[$this->context->language->id] = $this->l('Status');
            $tabParent->class_name = 'AdminLaStatus';
            $tabParent->id_parent = (int)Tab::getIdFromClassName('AdminLaLigationConfig'); // Home tab
            $tabParent->module = $this->name;
            $tabParent->add();
        }

        if (!(int)Tab::getIdFromClassName('AdminLaLang')) {
            $tabParent = new Tab();
            // Need a foreach for the language
            $tabParent->name[$this->context->language->id] = $this->l('Lang');
            $tabParent->class_name = 'AdminLaLang';
            $tabParent->id_parent = (int)Tab::getIdFromClassName('AdminLaLigationConfig'); // Home tab
            $tabParent->module = $this->name;
            $tabParent->add();
        }

        if (!(int)Tab::getIdFromClassName('AdminLaTemplate')) {
            $tabParent = new Tab();
            // Need a foreach for the language
            $tabParent->name[$this->context->language->id] = $this->l('Template');
            $tabParent->class_name = 'AdminLaTemplate';
            $tabParent->id_parent = (int)Tab::getIdFromClassName('AdminLaLigationConfig'); // Home tab
            $tabParent->module = $this->name;
            $tabParent->add();
        }

        return true;
    }

    /*
    public function getContent(){
        return $this->renderFormType();
    }*/

    public function renderFormType()
    {
        $fields_form = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->l('Ligation type'),
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
                        'type' => 'text',
                        'label' => $this->l('Name'),
                        'name' => 'name',
                        'lang' => true,
                        'required' => true,
                        'hint' => array(
                            $this->l('Order status (e.g. \'Pending\').'),
                            $this->l('Invalid characters: numbers and') . ' !<>,;?=+()@#"{}_$%:'
                        )
                    ),

                ),
                'submit' => array(
                    'title' => $this->l('Save'),
                )
            )
        );

        $id_lang = $this->context->language->id;

        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $helper->identifier = $this->identifier;
        $helper->submit_action = 'submitSaveType';
        $helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false) . '&configure=' . $this->name . '&tab_module=' . $this->tab . '&module_name=' . $this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');

        $dataValues = array();
        $helper->tpl_vars = array(
            'fields_value' => $dataValues,
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $id_lang
        );

        return $helper->generateForm(array($fields_form));
    }

    public function renderFormSubType()
    {
        $fields_form = array(
            'form' => array(
                'legend' => array(
                    'title' => $this->l('Ligation type'),
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
                        )
                    ),
                    array(
                        'type' => 'text',
                        'label' => $this->l('Name'),
                        'name' => 'name',
                        'lang' => true,
                        'required' => true,
                        'hint' => array(
                            $this->l('Order status (e.g. \'Pending\').'),
                            $this->l('Invalid characters: numbers and') . ' !<>,;?=+()@#"{}_$%:'
                        )
                    ),
                ),
                'submit' => array(
                    'title' => $this->l('Save'),
                )
            )
        );

        $id_lang = $this->context->language->id;

        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->table = $this->table;
        $helper->identifier = $this->identifier;
        $helper->submit_action = 'submitSaveSubtype';
        $helper->currentIndex = $this->context->link->getAdminLink('AdminModules', false) . '&configure=' . $this->name . '&tab_module=' . $this->tab . '&module_name=' . $this->name;
        $helper->token = Tools::getAdminTokenLite('AdminModules');

        $dataValues = array();
        $helper->tpl_vars = array(
            'fields_value' => $dataValues,
            'languages' => $this->context->controller->getLanguages(),
            'id_language' => $id_lang
        );

        return $helper->generateForm(array($fields_form));
    }
}
