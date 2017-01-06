{*
* 2015 Stigmi.eu
*
* @author Stigmi.eu <www.stigmi.eu>
* @copyright 2015 Stigmi.eu
* @license http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
*}

<div id="tab-carrier-selection">
    <fieldset id="dhl-settings-carriers" style="margin-top: 10px; {if !isset($smarty.get.carriers) || $smarty.get.carriers != 1}display: none{/if}">
        <legend>
            <img src="../img/admin/cog.gif" />
            {l s='Carrier selection' mod='dhlparcelbelux'}
        </legend>
        <p>{l s='Use this pane to associate carriers with DHL Shipping Method.' mod='dhlparcelbelux'}</p>
        <p><strong>{l s='Warning' mod='dhlparcelbelux' }</strong> : {l s='If the "DHL Parcelshop Delivery" option is off, the carrier will be deactivated. If you re-activate the carrier afterwards, the option will be automatically updated.' mod='dhlparcelbelux'}</p>
        <br>
        <div>
            <label for="dpb_carrier_home">
                {l s='At home delivery' mod='dhlparcelbelux'}
            </label>
            <div class="margin-form">
                <select name="dpb_carrier_home" id="dpb_carrier_home">
                {foreach from=$carriers key=carrier_key item=carrier}
                    <option {if isset($settings.carrier_home) && $settings.carrier_home == $carrier.id_carrier }selected="selected"{/if} value="{$carrier.id_carrier|escape:'htmlall':'UTF-8'}">{$carrier.id_carrier|escape:'htmlall':'UTF-8'} - {$carrier.name|escape:'htmlall':'UTF-8'}</option>
                {/foreach}
                </select>
            </div>
        </div>
        <div>
            <label for="dpb_carrier_parcelshop">
                {l s='DHL Parcelshop delivery' mod='dhlparcelbelux'}
            </label>
            <div class="margin-form">
                <select name="dpb_carrier_parcelshop" id="dpb_carrier_parcelshop">
                {foreach from=$carriers key=carrier_key item=carrier}
                    <option {if isset($settings.carrier_parcelshop) && $settings.carrier_parcelshop == $carrier.id_carrier }selected="selected"{/if} value="{$carrier.id_carrier|escape:'htmlall':'UTF-8'}">{$carrier.id_carrier|escape:'htmlall':'UTF-8'} - {$carrier.name|escape:'htmlall':'UTF-8'}</option>
                {/foreach}
                </select>
            </div>
        </div>
        <div class="margin-form">
            <input type="submit" value="{l s='Save settings' mod='dhlparcelbelux'}" id="module_form_submit_btn" name="submitModuleDHLParcelBelux" class="button">
        </div>
    </fieldset>
</div>