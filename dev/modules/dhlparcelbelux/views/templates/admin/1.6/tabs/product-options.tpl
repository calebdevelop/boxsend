{*
* 2015 Stigmi.eu
*
* @author Stigmi.eu <www.stigmi.eu>
* @copyright 2015 Stigmi.eu
* @license http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
*}

<div class="tab" id="tab-product-options" style="display: none">
    <div class="panel" id="dhl-settings-product-selection">
        <div class="panel-heading">
            <i class="icon-cogs"></i> {l s='DHL Parcel Services' mod='dhlparcelbelux'}
        </div>
        <div class="panel-body">
            <div class="form-wrapper">
                <div class="form-group">
                    <label class="control-label col-lg-3" for="dpb_delivery_type">
                        <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="{l s='Eg 45123456' mod='dhlparcelbelux'}">
                            {l s='Service:' mod='dhlparcelbelux'}
                        </span>
                    </label>
                    <div class="col-lg-9 ">
                        <div class="radio">
                            <label for="dpb_dhl_for_you">
                                <input type="radio" name="dpb_delivery_type" id="dpb_dhl_for_you" value="0" {if isset($settings.delivery_type) && $settings.delivery_type == 0}checked="checked"{/if}>
                                <span class="label-tooltip" data-placement="right" data-toggle="tooltip" data-html="true" title="{l s='DHL PARCEL BELUX is a B2C product that allows you to ship parcels to private addresses in Belgium, Luxembourg or the Netherlands.' mod='dhlparcelbelux'}">
                                    {l s='Benelux (DHL PARCEL BENELUX)' mod='dhlparcelbelux'}
                                </span>
                            </label>
                        </div>
                        <div class="radio">
                            <label for="dpb_europlus">
                                <input type="radio" name="dpb_delivery_type" id="dpb_europlus" value="1" {if isset($settings.delivery_type) && $settings.delivery_type == 1}checked="checked"{/if}>
                                <span class="label-tooltip" data-placement="right" data-toggle="tooltip" data-html="true" title="{l s='DHL EUROPLUS is a B2B product that allows you to ship parcels to business addresses, both within the Belux and rest of Europe.' mod='dhlparcelbelux'}">
                                    {l s='Rest of Europe (DHL EUROPLUS)' mod='dhlparcelbelux'}
                                </span>
                            </label>
                        </div><br>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-3" for="dpb_parcelshop_delivery">
                        <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="{l s='Eg 45123456' mod='dhlparcelbelux'}">
                            {l s='DHL Parcelshop delivery' mod='dhlparcelbelux'}
                        </span>
                    </label>
                    <div class="col-lg-9 ">
                        <span class="switch prestashop-switch fixed-width-lg">
                            <input type="radio" name="dpb_parcelshop_delivery" id="dpb_parcelshop_delivery_on" value="1" {if isset($settings.parcelshop_delivery) && $settings.parcelshop_delivery == 1}checked="checked"{/if}>
                            <label for="dpb_parcelshop_delivery_on" class="radioCheck">
                                {l s='Yes' mod='dhlparcelbelux'}
                            </label>
                            <input type="radio" name="dpb_parcelshop_delivery" id="dpb_parcelshop_delivery_off" value="0" {if isset($settings.parcelshop_delivery) && $settings.parcelshop_delivery == 0}checked="checked"{/if}>
                            <label for="dpb_parcelshop_delivery_off" class="radioCheck">
                                {l s='No' mod='dhlparcelbelux'}
                            </label>
                            <a class="slide-button btn"></a>
                        </span>
                        <p class="help-block">
                            <span class="label-tooltip" data-placement="right" data-toggle="tooltip" data-html="true" title="{l s='The Parcelshop delivery method allows your client to be delivered in a pick-up point of their choice in Belgium, Luxembourg or the Netherlands.' mod='dhlparcelbelux'}">
                                {l s='DHL Parcelshop delivery is only available within the Belux!' mod='dhlparcelbelux'}&nbsp;<i class="icon-info-circle"></i>
                            </span>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="panel" id="dhl-settings-product-options-benelux">
        <div class="panel-heading">
            <i class="icon-cogs"></i> {l s='Home delivery with DHL PARCEL BENELUX' mod='dhlparcelbelux'}
        </div>
        
        <div class="panel-body">
            <div class="form-wrapper">
                <div class="form-group">
                    <label class="control-label col-lg-3" for="dpb_belux_neighbours">
                        <span class="label-tooltip" data-toggle="tooltip" data-html="true">
                            {l s='Delivery options' mod='dhlparcelbelux'}
                        </span>
                    </label>
                    <div class="col-lg-9">
                        <div class="checkbox">
                            <label for="dpb_belux_neighbours">
                                <input type="checkbox" name="dpb_belux_neighbours" id="dpb_belux_neighbours" value="1" {if (isset($settings.belux_neighbours) && $settings.belux_neighbours == 1)}checked="checked"{/if}>
                                <span class="label-tooltip" data-placement="right" data-toggle="tooltip" data-html="true" title="{l s='Let your customers decide if they want to forbid neighbour delivery when they are not available at the time of delivery.' mod='dhlparcelbelux'}">
                                    {l s='No neighbour delivery' mod='dhlparcelbelux'} <i class="icon-info-circle"></i>
                                </span>
                            </label>
                        </div>
                        {if isset($settings.details_country) && $settings.details_country == 13 }
                        <div class="checkbox">
                            <label for="dpb_belux_signature">
                                <input type="checkbox" name="dpb_belux_signature" id="dpb_belux_signature" value="1" {if isset($settings.belux_signature) && $settings.belux_signature == 1}checked="checked"{/if}>
                                <span class="label-tooltip" data-placement="right" data-toggle="tooltip" data-html="true" title="{l s='Choose if you want to require your clients to sign upon delivery in the Netherlands. Note that a signature is always required when we deliver parcels to Belgium and Luxembourg.' mod='dhlparcelbelux'}">
                                    {l s='Signature' mod='dhlparcelbelux'} <i class="icon-info-circle"></i>
                                </span>
                            </label>
                        </div>
                        {else}
                            <input type="hidden" name="dpb_belux_signature" id="dpb_belux_signature" value="0">
                        {/if}
                        <div class="checkbox">
                            <label for="dpb_belux_evening_delivery">
                                <input type="checkbox" name="dpb_belux_evening_delivery" id="dpb_belux_evening_delivery" value="1" {if isset($settings.belux_evening_delivery) && $settings.belux_evening_delivery == 1}checked="checked"{/if}>
                                <span class="label-tooltip" data-placement="right" data-toggle="tooltip" data-html="true" title="{l s='Let your clients choose if they prefer to be delivered at the end of the day, between 17h and 22h.' mod='dhlparcelbelux'}">
                                    {l s='Evening delivery' mod='dhlparcelbelux'} <i class="icon-info-circle"></i>
                                </span>
                            </label>
                        </div>
                        <div class="checkbox">
                            <label for="dpb_belux_saturdays">
                                <input type="checkbox" name="dpb_belux_saturdays" id="dpb_belux_saturdays" value="1" {if isset($settings.belux_saturdays) && $settings.belux_saturdays == 1}checked="checked"{/if}>
                                <span class="label-tooltip" data-placement="right" data-toggle="tooltip" data-html="true" title="{l s='Deliver on Saturday' mod='dhlparcelbelux'}">
                                    {l s='Saturday delivery' mod='dhlparcelbelux'} <i class="icon-info-circle"></i>
                                </span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>