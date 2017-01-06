{*
* 2015 Stigmi.eu
*
* @author Stigmi.eu <www.stigmi.eu>
* @copyright 2015 Stigmi.eu
* @license http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
*}

<div id="tab-product-options">
    <fieldset id="dhl-settings-product-selection" style="margin-top: 10px">
        <legend>
            <img src="../img/admin/cog.gif" />
            {l s='DHL Parcel Services' mod='dhlparcelbelux'}
        </legend>
        <div>
            <label for="dpb_delivery_type">{l s='Service:' mod='dhlparcelbelux'}</label>
            <div class="margin-form">
                <input style="margin: 5px 5px 5px 0" type="radio" name="dpb_delivery_type" id="dpb_dhl_for_you" value="0" {if isset($settings.delivery_type) && $settings.delivery_type == 0}checked="checked"{/if}>
                {l s='Benelux (DHL PARCEL BENELUX)' mod='dhlparcelbelux'}
                <br style="margin-bottom: 10px">
                <input style="margin: 5px 5px 5px 0" type="radio" name="dpb_delivery_type" id="dpb_europlus" value="1" {if isset($settings.delivery_type) && $settings.delivery_type == 1}checked="checked"{/if}>
                {l s='Rest of Europe (DHL EUROPLUS)' mod='dhlparcelbelux'}
            </div>
        </div>
        <div>
            <label for="dpb_parcelshop_delivery">{l s='DHL Parcelshop delivery' mod='dhlparcelbelux'}</label>
            <div class="margin-form">
                <input type="radio" name="dpb_parcelshop_delivery" id="dpb_parcelshop_delivery_on" value="1" {if isset($settings.parcelshop_delivery) && $settings.parcelshop_delivery == 1}checked="checked"{/if}>
                <label class="t"><img src="../img/admin/enabled.gif" alt="{l s='on' mod='dhlparcelbelux'}" title="{l s='on' mod='dhlparcelbelux'}"></label>
                <input type="radio" name="dpb_parcelshop_delivery" id="dpb_parcelshop_delivery_off" value="0" {if isset($settings.parcelshop_delivery) && $settings.parcelshop_delivery == 0}checked="checked"{/if}>
                <label class="t"><img src="../img/admin/disabled.gif" alt="{l s='off' mod='dhlparcelbelux'}" title="{l s='off' mod='dhlparcelbelux'}"></label>
                <p>{l s='DHL Parcelshop delivery is only available within the Belux!' mod='dhlparcelbelux'}</p>
            </div>
        </div>
        <div class="margin-form">
            <input type="submit" value="{l s='Save settings' mod='dhlparcelbelux'}" id="module_form_submit_btn" name="submitModuleDHLParcelBelux" class="button">
        </div>
    </fieldset>

    <fieldset id="dhl-settings-product-options-benelux" style="margin-top: 10px">
        <legend>
            <img src="../img/admin/cog.gif" />
            {l s='Home delivery with DHL PARCEL BENELUX' mod='dhlparcelbelux'}
        </legend>
        <div>
            <label>{l s='Delivery options' mod='dhlparcelbelux'}</label>
            <div class="margin-form">
                <input style="margin: 5px 5px 5px 0" type="checkbox" name="dpb_belux_neighbours" id="dpb_belux_neighbours" value="1" {if isset($settings.belux_neighbours) && $settings.belux_neighbours == 1}checked="checked"{/if}>
                {l s='No neighbour delivery' mod='dhlparcelbelux'}
                <br>
                {if isset($settings.details_country) && $settings.details_country == 13 }
                <input style="margin: 5px 5px 5px 0" type="checkbox" name="dpb_belux_signature" id="dpb_belux_signature" value="1" {if isset($settings.belux_signature) && $settings.belux_signature == 1}checked="checked"{/if}> {l s='Signature' mod='dhlparcelbelux'}
                <br>
                {else}
                    <input type="hidden" name="dpb_belux_signature" id="dpb_belux_signature" value="0">
                {/if}
                <input style="margin: 5px 5px 5px 0" type="checkbox" name="dpb_belux_saturdays" id="dpb_belux_saturdays" value="1" {if isset($settings.belux_saturdays) && $settings.belux_saturdays == 1}checked="checked"{/if}>
                {l s='Saturday delivery' mod='dhlparcelbelux'}
                <br>
                <input style="margin: 5px 5px 5px 0" type="checkbox" name="dpb_belux_evening_delivery" id="dpb_belux_evening_delivery" value="1" {if isset($settings.belux_evening_delivery) && $settings.belux_evening_delivery == 1}checked="checked"{/if}> {l s='Evening delivery' mod='dhlparcelbelux'}
            </div>
        </div>
        <div class="margin-form">
            <input type="submit" value="{l s='Save settings' mod='dhlparcelbelux'}" id="module_form_submit_btn" name="submitModuleDHLParcelBelux" class="button">
        </div>
    </fieldset>
</div>