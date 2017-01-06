{*
* 2015 Stigmi.eu
*
* @author Stigmi.eu <www.stigmi.eu>
* @copyright 2015 Stigmi.eu
* @license http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
*}

<div class="tab" id="tab-carrier-selection" style="display: none">
    <div class="panel" id="dhl-settings-introduction">
        <div class="panel-heading">
            <i class="icon-cogs"></i> {l s='Carrier selection' mod='dhlparcelbelux'}
        </div>
        <div class="alert alert-info">
            <p>{l s='Use this pane to associate carriers with DHL Shipping Method.' mod='dhlparcelbelux'}</p>
        </div>
        <div class="dhl-disabled-alert dhl-disabled-alert-warning">
            <p><strong>{l s='Warning' mod='dhlparcelbelux' }</strong> : {l s='If the "DHL Parcelshop Delivery" option is off, the carrier will be deactivated. If you re-activate the carrier afterwards, the option will be automatically updated.' mod='dhlparcelbelux'}</p>
        </div>
        <div class="form-wrapper">
            <div class="form-group">
                <label class="control-label col-lg-3" for="dpb_carrier_home">
                    <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="{l s='Eg 45123456' mod='dhlparcelbelux'}">
                        {l s='At home delivery' mod='dhlparcelbelux'}
                    </span>
                </label>
                <div class="col-lg-4">
                    <select name="dpb_carrier_home" id="dpb_carrier_home">
                    {foreach from=$carriers key=carrier_key item=carrier}
                        <option {if isset($settings.carrier_home) && $settings.carrier_home == $carrier.id_carrier }selected="selected"{/if} value="{$carrier.id_carrier|escape:'htmlall':'UTF-8'}">{$carrier.id_carrier|escape:'htmlall':'UTF-8'} - {$carrier.name|escape:'htmlall':'UTF-8'}</option>
                    {/foreach}
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-lg-3" for="dpb_carrier_parcelshop">
                    <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="{l s='Eg 45123456' mod='dhlparcelbelux'}">
                        {l s='DHL Parcelshop delivery' mod='dhlparcelbelux'}
                    </span>
                </label>
                <div class="col-lg-4">
                    <select name="dpb_carrier_parcelshop" id="dpb_carrier_parcelshop">
                    {foreach from=$carriers key=carrier_key item=carrier}
                        <option {if isset($settings.carrier_parcelshop) && $settings.carrier_parcelshop == $carrier.id_carrier }selected="selected"{/if} value="{$carrier.id_carrier|escape:'htmlall':'UTF-8'}">{$carrier.id_carrier|escape:'htmlall':'UTF-8'} - {$carrier.name|escape:'htmlall':'UTF-8'}</option>
                    {/foreach}
                    </select>
                </div>
            </div>
        </div>
    </div>
</div>