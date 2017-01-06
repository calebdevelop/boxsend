{*
* 2015 Stigmi.eu
*
* @author Stigmi.eu <www.stigmi.eu>
* @copyright 2015 Stigmi.eu
* @license http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
*}

<div class="tab" id="tab-account-information" style="display: none">
    <div class="panel" id="dhl-settings-introduction">
        <div class="panel-heading">
            <i class="icon-cogs"></i> {l s='About this module' mod='dhlparcelbelux'}
        </div>
        <div class="dhl-disabled-alert dhl-disabled-alert-success">
            <p>{l s='The DHL PARCEL BELUX module allows your customers to pick a DHL delivery method to receive their order.' mod='dhlparcelbelux'}</p>
        </div>

        <div class="dhl-round-account-call dhl-round-account-call-16">
            <a href="{l s='https://www.dhlparcel.be/en/dhl-prestashop-plugin' mod='dhlparcelbelux'}" target="_blank">{l s='Click here to request a DHL account!' mod='dhlparcelbelux'}</a>
        </div>

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
    </div>

    <div class="panel" id="dhl-settings-introduction">
        <div class="panel-heading">
            <i class="icon-cogs"></i> {l s='Account Settings' mod='dhlparcelbelux'}
        </div>

        <div class="dhl-disabled-alert dhl-disabled-alert-success">
            <p>{l s='Please fill in your credentials to use the module.' mod='dhlparcelbelux'}</p>
        </div>

        <div class="form-wrapper">
            <div class="form-group">
                <label class="control-label col-lg-3" for="dpb_account_id">
                    <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="{l s='Eg 45123456' mod='dhlparcelbelux'}">
                        {l s='Account ID' mod='dhlparcelbelux'}
                    </span>
                </label>
                <div class="col-lg-9 ">
                    <input type="text" name="dpb_account_id" id="dpb_account_id" value="{if isset($settings.account_id)}{$settings.account_id|escape:'htmlall':'UTF-8'}{/if}">
                    <p class="help-block">{l s='Your account ID is created and communicated by DHL once your contract is signed.' mod='dhlparcelbelux'}</p>
                    {if isset($req_messages['dpb_account_id']) }
                        <p class="required-field">{l s='This field is required.' mod='dhlparcelbelux'}</p>
                    {/if}
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-lg-3" for="dpb_api_key">
                    <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="{l s='Eg 1F0YWW2YSzxSTqVYnEir' mod='dhlparcelbelux'}">
                        {l s='API-Key' mod='dhlparcelbelux'}
                    </span>
                </label>
                <div class="col-lg-9 ">
                    <input type="text" name="dpb_api_key" id="dpb_api_key" value="{if isset($settings.api_key)}{$settings.api_key|escape:'htmlall':'UTF-8'}{/if}">
                    <p class="help-block">{l s='Your API-Key is sent by email by DHL.' mod='dhlparcelbelux'}</p>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-lg-3" for="dpb_api_secret">
                    <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="{l s='Eg M5quzzC5rytsduraqt9i' mod='dhlparcelbelux'}">
                        {l s='API-Secret' mod='dhlparcelbelux'}
                    </span>
                </label>
                <div class="col-lg-9 ">
                    <input type="text" name="dpb_api_secret" id="dpb_api_secret" value="{if isset($settings.api_secret)}{$settings.api_secret|escape:'htmlall':'UTF-8'}{/if}">
                    <p class="help-block">{l s='Your API-Secret is sent by email by DHL.' mod='dhlparcelbelux'}</p>
                </div>
            </div>
        </div>
    </div>
</div>