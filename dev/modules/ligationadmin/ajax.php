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

include('./../../config/config.inc.php');

/**
 * Return suppliers
 *
 * @return array Suppliers
 */
class LigationTools
{
    public static function getSuppliers($get_nb_products = false, $id_lang = 0, $aliasWhere = array(), $active = true, $p = false, $n = false, $all_groups = false)
    {
        if (!$id_lang) {
            $id_lang = Configuration::get('PS_LANG_DEFAULT');
        }
        if (!Group::isFeatureActive()) {
            $all_groups = true;
        }

        $query = new DbQuery();
        $query->select('s.id_supplier as id,s.name');
        $query->from('supplier', 's');
        $query->leftJoin('supplier_lang', 'sl', 's.`id_supplier` = sl.`id_supplier` AND sl.`id_lang` = '.(int)$id_lang);
        $query->join(Shop::addSqlAssociation('supplier', 's'));
        if ($active) {
            $query->where('s.`active` = 1');
        }

        if (!empty($aliasWhere)) {
            foreach ($aliasWhere as $where) {
                $query->where($where);
            }
        }
        $query->orderBy(' s.`name` ASC');
        $query->limit($n, ($p - 1) * $n);
        $query->groupBy('s.id_supplier');

        $suppliers = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($query);
        if ($suppliers === false) {
            return false;
        }
        if ($get_nb_products) {
            $sql_groups = '';
            if (!$all_groups) {
                $groups = FrontController::getCurrentCustomerGroups();
                $sql_groups = (count($groups) ? 'IN ('.implode(',', $groups).')' : '= 1');
            }
            $sql = 'SELECT ps.`id_supplier`, COUNT(DISTINCT ps.`id_product`) as nb_products
              FROM `'._DB_PREFIX_.'product_supplier` ps
                JOIN `'._DB_PREFIX_.'product` p ON (ps.`id_product`= p.`id_product`)
                '.Shop::addSqlAssociation('product', 'p').'
					LEFT JOIN `'._DB_PREFIX_.'supplier` as m ON (m.`id_supplier`= p.`id_supplier`)
					WHERE ps.id_product_attribute = 0'.
                    ($active ? ' AND product_shop.`active` = 1' : '').
                    ' AND product_shop.`visibility` NOT IN ("none")'.
                ($all_groups ? '' :'AND ps.`id_product` IN ( SELECT cp.`id_product` FROM `'._DB_PREFIX_.'category_group` cg LEFT JOIN `'._DB_PREFIX_.'category_product` cp ON (cp.`id_category` = cg.`id_category`) WHERE cg.`id_group` '.$sql_groups.')') . 'GROUP BY ps.`id_supplier`';

            $results = Db::getInstance(_PS_USE_SQL_SLAVE_)->executeS($sql);
            $counts = array();
            foreach ($results as $result) {
                $counts[(int)$result['id_supplier']] = (int)$result['nb_products'];
            }

            if (count($counts) && is_array($suppliers)) {
                foreach ($suppliers as $key => $supplier) {
                    if (isset($counts[(int)$supplier['id_supplier']])) {
                        $suppliers[$key]['nb_products'] = $counts[(int)$supplier['id_supplier']];
                    } else {
                        $suppliers[$key]['nb_products'] = 0;
                    }
                }
            }
        }

        $nb_suppliers = count($suppliers);
        $rewrite_settings = (int)Configuration::get('PS_REWRITING_SETTINGS');
        for ($i = 0; $i < $nb_suppliers; $i++) {
            $suppliers[$i]['link_rewrite'] = ($rewrite_settings ? Tools::link_rewrite($suppliers[$i]['name']) : 0);
        }
        return $suppliers;
    }
}
$cookie = new Cookie('psAdmin', '', (int)Configuration::get('PS_COOKIE_LIFETIME_BO'));
$employee = new Employee((int)$cookie->id_employee);
$context = Context::getContext();
$context->employee = $employee;
if (Tools::getValue('action') && $employee->id) {
    switch (Tools::getValue('action')) {
        case "products":
            if (Tools::getValue('id_supplier') && Tools::getValue('id_lang')) {
                $context->controller = new FrontController();
                $items = SupplierCore::getProducts((int)Tools::getValue('id_supplier'), (int)Tools::getValue('id_lang'), 0, 99999999);
                // packs
                $results = array();
                foreach ($items as $item) {
                    // check if product have combination
                    if (Tools::getValue('ids_product')) {
                        if (!in_array($item['id_product'], Tools::getValue('ids_product'))) {
                            $product = array(
                                'id' => (int)($item['id_product']),
                                'name' => $item['name'],
                                'ref' => (!empty($item['reference']) ? $item['reference'] : ''),
                                'image' => $context->link->getImageLink($item['link_rewrite'], $item['id_image'], ImageType::getFormatedName('small')),
                            );
                            array_push($results, $product);
                        }
                    } else {
                        $product = array(
                            'id' => (int)($item['id_product']),
                            'name' => $item['name'],
                            'ref' => (!empty($item['reference']) ? $item['reference'] : ''),
                            'image' => $context->link->getImageLink($item['link_rewrite'], $item['id_image'], ImageType::getFormatedName('small')),
                        );
                        array_push($results, $product);
                    }
                }
                $results = array_values($results);
                echo Tools::jsonEncode($results);
            }
            break;
        case "searchProduct":
            $query = Tools::getValue('q');
            $excludeVirtuals = array();
            $excludeIds = array();
            $exclude_packs = array();
            $sql = 'SELECT p.`id_product` as id, pl.`link_rewrite`, p.`reference`, pl.`name`, image_shop.`id_image` id_image, il.`legend`, p.`cache_default_attribute`
                    FROM `'._DB_PREFIX_.'product` p
                    '.Shop::addSqlAssociation('product', 'p').'
                    LEFT JOIN `'._DB_PREFIX_.'product_lang` pl ON (pl.id_product = p.id_product AND pl.id_lang = '.(int)$context->language->id.Shop::addSqlRestrictionOnLang('pl').')
                    LEFT JOIN `'._DB_PREFIX_.'image_shop` image_shop
                        ON (image_shop.`id_product` = p.`id_product` AND image_shop.cover=1 AND image_shop.id_shop='.(int)$context->shop->id.')
                    LEFT JOIN `'._DB_PREFIX_.'image_lang` il ON (image_shop.`id_image` = il.`id_image` AND il.`id_lang` = '.(int)$context->language->id.')
                    WHERE (pl.name LIKE \'%'.pSQL($query).'%\' OR p.reference LIKE \'%'.pSQL($query).'%\')'.
                            (!empty($excludeIds) ? ' AND p.id_product NOT IN ('.$excludeIds.') ' : ' ').
                            ($excludeVirtuals ? 'AND NOT EXISTS (SELECT 1 FROM `'._DB_PREFIX_.'product_download` pd WHERE (pd.id_product = p.id_product))' : '').
                            ($exclude_packs ? 'AND (p.cache_is_pack IS NULL OR p.cache_is_pack = 0)' : '').
                ' GROUP BY p.id_product';

            $items = Db::getInstance()->executeS($sql);
            echo Tools::jsonEncode($items);
            break;
        case "files":
            $message = "error";
            if (Tools::getValue('file_id') && Tools::getValue('id_la_ligation')) {
                $mLaFile = Db::getInstance()->getRow('SELECT * FROM ' . _DB_PREFIX_ . 'la_file WHERE id_la_file = ' . (int)Tools::getValue('file_id'));
                if (!empty($mLaFile)) {
                    Db::getInstance()->query('DELETE FROM ' . _DB_PREFIX_ . 'la_file WHERE id_la_file = ' . (int)Tools::getValue('file_id'));
                    $message = "success";
                    Db::getInstance()->query("INSERT INTO " . _DB_PREFIX_ . "la_history_file SET
                        `id_la_file` = '" . (int)Tools::getValue('file_id') . "',
                        `id_employee` = '" . $employee->id . "',
                        `id_la_ligation` = '" . $mLaFile['id_la_ligation']  . "',
                        `size` = '" . $mLaFile['size'] . "',
                        `mime` = '" . $mLaFile['id_la_ligation'] . "',
                        `name` = '" . $mLaFile['name'] . "',
                        `original_name` = '" . $mLaFile['original_name'] . "'
                    ");
                }
            }
            echo Tools::jsonEncode(array(
                'message' => $message
            ));
            break;
        case "supplier":
            $suppliers = LigationTools::getSuppliers(false, Tools::getValue('id_lang'), array("s.name LIKE '" . pSQL(Tools::getValue('q')) . "%'"));
            echo Tools::jsonEncode($suppliers);
            break;
    }
}
