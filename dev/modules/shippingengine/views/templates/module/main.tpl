<!-- Main configuration -->

<div class="panel">
    <div class="panel-heading">
        <i class="icon-user"></i>
        {l s='Configurations' mod='shippingengine'}
    </div>
    <div class="panel-body">
        <ul class="nav nav-tabs" role="tablist">
            <!--li><a href="#tab-main-configuration" data-toggle="tab">{l s='Paramètres généraux' mod='shippingengine'}</a></li-->
            <li><a href="#tab-transport-configuration" data-toggle="tab">{l s='Transporteurs' mod='shippingengine'}</a></li>
            <li><a href="#step3" data-toggle="tab">{l s='Localitées proches' mod='shippingengine'}</a></li>
            <li><a href="#step-final" data-toggle="tab">{l s='Enregister' mod='shippingengine'}</a></li>
        </ul>

        <div class="tab-content">
            <!--
            <div class="tab-pane" id="tab-main-configuration">
                <div class="panel panel-default">
                    {$mainConfiguration}
                </div>
            </div-->

            <div class="tab-pane" id="tab-transport-configuration">
                <!-- DHL parameters -->
                <div class="col-md-4 panel panel-default">
                    <div class="panel-heading">
                        {l s='DHL parameters' mod='shippingengine'}
                    </div>

                    <form action="{$actionUrl}&token={Tools::getAdminTokenLite('AdminModules')}" method="post">
                        <fieldset>
                            <div class="form-group">
                                <label for="IDB_SHIPPINENGINE[DHL][SHOP_ID]">{l s='Shop ID' mod='shippingengine'}</label>
                                <input type="text" class="form-control" id="IDB_SHIPPINENGINE[DHL][SHOP_ID]" name="IDB_SHIPPINENGINE[DHL][SHOP_ID]" value="{Configuration::get('IDB_SHIPPINENGINE_DHL_SHOP_ID')}" placeholder="Shop ID"/>
                            </div>
                            <div class="form-group">
                                <label for="IDB_SHIPPINENGINE[DHL][PASSWORD]">{l s='Password' mod='shippingengine'}</label>
                                <input type="password" class="form-control" id="IDB_SHIPPINENGINE[DHL][PASSWORD]" name="IDB_SHIPPINENGINE[DHL][PASSWORD]" value="{Configuration::get('IDB_SHIPPINENGINE_DHL_PASSWORD')}" placeholder="Password"/>
                            </div>

                            <hr/>
                            <div class="form-group">
                                <label for="IDB_SHIPPINENGINE[DHL][shipperAccountNumber]">{l s='shipperAccountNumber' mod='shippingengine'}</label>
                                <input type="text" class="form-control" id="IDB_SHIPPINENGINE[DHL][shipperAccountNumber]" name="IDB_SHIPPINENGINE[DHL][shipperAccountNumber]" placeholder="shipperAccountNumber" value="{Configuration::get('IDB_SHIPPINENGINE_DHL_shipperAccountNumber')}"/>
                            </div>

                            <div class="form-group">
                                <label for="IDB_SHIPPINENGINE[DHL][shipperAccountNumber]">{l s='shipperAccountNumber' mod='shipperAccountNumber'}</label>
                                <input type="text" class="form-control" id="IDB_SHIPPINENGINE[DHL][billingAccountNumber]" name="IDB_SHIPPINENGINE[DHL][billingAccountNumber]" placeholder="billingAccountNumber" value="{Configuration::get('IDB_SHIPPINENGINE_DHL_billingAccountNumber')}"/>
                            </div>

                            <div class="form-group">
                                <label for="IDB_SHIPPINENGINE[DHL][dutyAccountNumber]">{l s='dutyAccountNumber' mod='shipperAccountNumber'}</label>
                                <input type="text" class="form-control" id="IDB_SHIPPINENGINE[DHL][dutyAccountNumber]" name="IDB_SHIPPINENGINE[DHL][dutyAccountNumber]" placeholder="dutyAccountNumber" value="{Configuration::get('IDB_SHIPPINENGINE_DHL_dutyAccountNumber')}"/>
                            </div>

                            <button type="submit" value="1" id="module_form_submit_btn" name="submitSaveCarrierConfig" class="btn btn-default pull-right">
                                <i class="process-icon-save"></i> {l s='Save' mod='shippingengine'}
                            </button>
                        </fieldset>
                    </form>
                </div>

                <!-- UPS parameters -->
                <div class="col-md-4 panel panel-default">
                    <div class="panel-heading">
                        {l s='UPS parameters' mod='shippingengine'}
                    </div>

                    <form action="{$actionUrl}&token={Tools::getAdminTokenLite('AdminModules')}" method="post">
                        <fieldset>
                            <div class="form-group">
                                <label for="IDB_SHIPPINENGINE[DHL][SHOP_ID]">{l s='Shop ID' mod='shipperAccountNumber'}</label>
                                <input type="text" class="form-control" id="IDB_SHIPPINENGINE[UPS][SHOP_ID]" name="IDB_SHIPPINENGINE[UPS][SHOP_ID]" value="{Configuration::get('IDB_SHIPPINENGINE_UPS_SHOP_ID')}" placeholder="Shop ID"/>
                            </div>
                            <div class="form-group">
                                <label for="IDB_SHIPPINENGINE[DHL][PASSWORD]">{l s='Password' mod='shipperAccountNumber'}</label>
                                <input type="password" class="form-control" id="IDB_SHIPPINENGINE[UPS][PASSWORD]" name="IDB_SHIPPINENGINE[UPS][PASSWORD]" value="{Configuration::get('IDB_SHIPPINENGINE_UPS_PASSWORD')}" placeholder="Password"/>
                            </div>

                            <button type="submit" value="1" id="module_form_submit_btn" name="submitSaveCarrierConfig" class="btn btn-default pull-right">
                                <i class="process-icon-save"></i> {l s='Save' mod='shippingengine'}
                            </button>
                        </fieldset>
                    </form>
                </div>

                <!-- TNT parameters -->
                <div class="col-md-4 panel panel-default">
                    <div class="panel-heading">
                        {l s='TNT parameters' mod='shippingengine'}
                    </div>

                    <form action="{$actionUrl}&token={Tools::getAdminTokenLite('AdminModules')}" method="post">
                        <fieldset>
                            <div class="form-group">
                                <label for="IDB_SHIPPINENGINE[TNT][SHOP_ID]">{l s='Shop ID' mod='shippingengine'}</label>
                                <input type="text" class="form-control" id="IDB_SHIPPINENGINE[TNT][SHOP_ID]" name="IDB_SHIPPINENGINE[TNT][SHOP_ID]" value="{Configuration::get('IDB_SHIPPINENGINE_TNT_SHOP_ID')}" placeholder="Shop ID"/>
                            </div>
                            <div class="form-group">
                                <label for="IDB_SHIPPINENGINE[TNT][PASSWORD]">{l s='Password' mod='shippingengine'}</label>
                                <input type="password" class="form-control" id="IDB_SHIPPINENGINE[TNT][PASSWORD]" name="IDB_SHIPPINENGINE[TNT][PASSWORD]" value="{Configuration::get('IDB_SHIPPINENGINE_TNT_PASSWORD')}" placeholder="Password"/>
                            </div>

                            <div class="form-group">
                                <label for="IDB_SHIPPINENGINE[TNT][ACCOUNT]">{l s='Account' mod='shippingengine'}</label>
                                <input type="text" class="form-control" id="IDB_SHIPPINENGINE[TNT][ACCOUNT]" name="IDB_SHIPPINENGINE[TNT][ACCOUNT]" value="{Configuration::get('IDB_SHIPPINENGINE_TNT_ACCOUNT')}" placeholder="Password"/>
                            </div>

                            <button type="submit" value="1" id="module_form_submit_btn" name="submitSaveCarrierConfig" class="btn btn-default pull-right">
                                <i class="process-icon-save"></i> {l s='Save' mod='shippingengine'}
                            </button>
                        </fieldset>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>
