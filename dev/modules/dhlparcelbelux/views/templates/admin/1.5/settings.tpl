{*
* 2015 Stigmi.eu
*
* @author Stigmi.eu <www.stigmi.eu>
* @copyright 2015 Stigmi.eu
* @license http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
*}
<form method="post" action="" class="defaultForm form-horizontal dhl-form">
    <div class="toolbar-placeholder">
        <div class="toolbarBox toolbarHead">
            <div class="pageTitle">
                <h3><span id="current_obj" style="font-weight: normal;">
                    <span class="breadcrumb item--1">{l s='DHL PARCEL BELUX configuration' mod='dhlparcelbelux'}</span>
                </span></h3>
            </div>
        </div>
    </div>

    {if isset($is_multishop) && $is_multishop}
        <div class="warn">
            {l s='You are currently in "group" or "all shops" context. Please select a shop to continue.' mod='dhlparcelbelux'}
        </div>
    {else}
        {if isset($req_messages) && $req_messages|@count > 0}
            <div class="warn">
                {l s='Please check that all points below are correctly set :' mod='dhlparcelbelux'}
                <ul>
                    {foreach from=$req_messages item=message}
                        <li>{$message|escape:'htmlall':'UTF-8'}</li>
                    {/foreach}
                </ul>
            </div>
        {/if}
        
        {include file='./tabs/account-information.tpl'}
        {include file='./tabs/product-options.tpl'}
        {include file='./tabs/sender-details.tpl'}
        {include file='./tabs/carrier-selection.tpl' carriers=$carriers}
        {include file='./tabs/manager-configuration.tpl' statuses=$statuses}
        
        <input type="submit" value="{l s='Save settings' mod='dhlparcelbelux'}" id="module_form_submit_btn" name="submitModuleDHLParcelBelux" class="button">
    {/if}
</form>
