{*
* 2015 Stigmi.eu
*
* @author Stigmi.eu <www.stigmi.eu>
* @copyright 2015 Stigmi.eu
* @license http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
*}

<div id="tab-account-information">
    <fieldset id="dhl-settings-introduction">
        <legend>
            <img src="../img/admin/cog.gif" />
            {l s='About this module' mod='dhlparcelbelux'}
        </legend>
        
        <div class="dhl-round-account-call">
            <a href="{l s='https://www.dhlparcel.be/en/dhl-prestashop-plugin' mod='dhlparcelbelux'}" target="_blank">{l s='Click here to request a DHL account!' mod='dhlparcelbelux'}</a>
        </div>
        
        <p><strong>{l s='The DHL PARCEL BELUX module allows your customers to pick a DHL delivery method to receive their order.' mod='dhlparcelbelux'}</strong></p>
        
        <p>{l s='The following delivery methods are currently supported:' mod='dhlparcelbelux'}</p>
        <ul>
            <li>{l s='Home delivery (BENELUX and Europe)' mod='dhlparcelbelux'}</li>
            <li>{l s='DHL Parcelshop delivery (BENELUX)' mod='dhlparcelbelux'}</li>
        </ul>
        <p>{l s='The DHL Parcel Belux module is completely integrated with PrestaShop.' mod='dhlparcelbelux'}</p>
        <p>{l s='Your customers can choose their preferred delivery method.' mod='dhlparcelbelux'}</p>
        <p>{l s='You can print your labels and send tracking emails to your customers.' mod='dhlparcelbelux'}</p>
        <p>{l s='You need to have a DHL account in order to use this module. Click' mod='dhlparcelbelux'} <a href="{l s='https://www.dhlparcel.be/en/dhl-prestashop-plugin' mod='dhlparcelbelux'}" target="_blank">{l s='here' mod='dhlparcelbelux'}</a> {l s='to request an account or contact our customer service for more information: +32 2 583 43 80 (BE & LU).' mod='dhlparcelbelux'}</p>
        <p>{l s='The full documentation regarding the module can be found here' mod='dhlparcelbelux'}: <a href="{l s='http://www.stigmi.eu/module-dhl/dhl-configuration-guide/' mod='dhlparcelbelux'}" target="_blank">{l s='http://www.stigmi.eu/module-dhl/dhl-configuration-guide/' mod='dhlparcelbelux'}</a>. {l s='For technical support, please send an e-mail to cimparcel@dhl.com.' mod='dhlparcelbelux'}</p>
    </fieldset>

    <fieldset id="dhl-settings-introduction" style="margin-top: 10px">
        <legend>
            <img src="../img/admin/cog.gif" />
            {l s='Account Settings' mod='dhlparcelbelux'}
        </legend>
        
        <p>{l s='Please fill in your credentials to use the module.' mod='dhlparcelbelux'}</p>
        <br>
        <div>
            <label for="dpb_account_id">
                {l s='Account ID' mod='dhlparcelbelux'}
            </label>
            <div class="margin-form">
                <input type="text" name="dpb_account_id" id="dpb_account_id" value="{if isset($settings.account_id)}{$settings.account_id|escape:'htmlall':'UTF-8'}{/if}">
                <p>{l s='Your account ID is created and communicated by DHL once your contract is signed.' mod='dhlparcelbelux'}</p>
                {if isset($req_messages['dpb_account_id']) }
                    <p class="required-field">{l s='This field is required.' mod='dhlparcelbelux'}</p>
                {/if}
            </div>
        </div>
        <div>
            <label for="dpb_api_key">
                    {l s='API-Key' mod='dhlparcelbelux'}
                </span>
            </label>
            <div class="margin-form">
                <input type="text" name="dpb_api_key" id="dpb_api_key" value="{if isset($settings.api_key)}{$settings.api_key|escape:'htmlall':'UTF-8'}{/if}">
                <p>{l s='Your API-Key is sent by email by DHL.' mod='dhlparcelbelux'}</p>
            </div>
        </div>
        <div>
            <label for="dpb_api_secret">
                    {l s='API-Secret' mod='dhlparcelbelux'}
                </span>
            </label>
            <div class="margin-form">
                <input type="text" name="dpb_api_secret" id="dpb_api_secret" value="{if isset($settings.api_secret)}{$settings.api_secret|escape:'htmlall':'UTF-8'}{/if}">
                <p>{l s='Your API-Secret is sent by email by DHL.' mod='dhlparcelbelux'}</p>
            </div>
        </div>
        <div class="margin-form">
            <input type="submit" value="{l s='Save settings' mod='dhlparcelbelux'}" id="module_form_submit_btn" name="submitModuleDHLParcelBelux" class="button">
        </div>
    </fieldset>
</div>