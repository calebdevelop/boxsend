{*
* 2015 Stigmi.eu
*
* @author Stigmi.eu <www.stigmi.eu>
* @copyright 2015 Stigmi.eu
* @license http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
*}

{if isset($success_save) }
    <div class="conf">
        <img src="../img/admin/ok2.png"> {l s='Settings successfully saved.' mod='dhlparcelbelux'}
        {if isset($updated_tabs) && count($updated_tabs) > 0 }
        <br>
        {l s='The following tabs have been updated:' mod='dhlparcelbelux'}
        <ul>
            {foreach from=$updated_tabs item=tab}
            <li>{$tab|escape:'htmlall':'UTF-8'}</li>
            {/foreach}
        </ul>
        {/if}
    </div>
{/if}

{if isset($req_messages) && $req_messages|@count > 0}
    <div class="warn">
        <img src="../img/admin/warn2.png">{l s='Please check that all points below are correctly set :' mod='dhlparcelbelux'}
        <ul>
            {foreach from=$req_messages item=message}
                <li>{$message|escape:'htmlall':'UTF-8'}</li>
            {/foreach}
        </ul>
    </div>
{/if}
<form method="post" action="" class="defaultForm form-horizontal">

    <h2 class="space">{l s='DHL PARCEL BELUX configuration' mod='dhlparcelbelux'}</h2>

    {include file='./tabs/account-information.tpl'}
    {include file='./tabs/product-options.tpl'}
    {include file='./tabs/sender-details.tpl'}
    {include file='./tabs/carrier-selection.tpl' carriers=$carriers}
    {include file='./tabs/manager-configuration.tpl' statuses=$statuses}
    
    <input type="submit" value="{l s='Save settings' mod='dhlparcelbelux'}" id="module_form_submit_btn" name="submitModuleDHLParcelBelux" class="button">
</form>
