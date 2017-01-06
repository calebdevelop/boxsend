{*
* 2015 Stigmi.eu
*
* @author Stigmi.eu <www.stigmi.eu>
* @copyright 2015 Stigmi.eu
* @license http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
*}

<div class="tab" id="tab-sender-details" style="display: none">
    <div class="panel" id="dhl-settings-introduction">
        <div class="panel-heading">
            <i class="icon-cogs"></i> {l s='Sender details' mod='dhlparcelbelux'}
        </div>
        <div class="alert alert-info">
            <p>{l s='These details will only be used to create labels. Only BELUX addresses are accepted.' mod='dhlparcelbelux'}</p>
        </div>
        <div class="form-wrapper">
            <div class="form-group">
                <label class="control-label col-lg-3" for="dpb_details_company">
                    <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="{l s='Eg Contoso Ltd.' mod='dhlparcelbelux'}">
                        {l s='Company' mod='dhlparcelbelux'}
                    </span>
                </label>
                <div class="col-lg-4">
                    <input type="text" name="dpb_details_company" id="dpb_details_company" value="{if isset($settings.details_company)}{$settings.details_company|escape:'htmlall':'UTF-8'}{/if}">
                    {if isset($req_messages.details_company) && isset($req_fields.details_company) }
                        <p class="required-field">{l s='This field is required.' mod='dhlparcelbelux'}</p>
                    {/if}
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-lg-3" for="dpb_details_firstname">
                    <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="{l s='Eg John' mod='dhlparcelbelux'}">
                        {l s='First name' mod='dhlparcelbelux'}
                    </span>
                </label>
                <div class="col-lg-4">
                    <input type="text" name="dpb_details_firstname" id="dpb_details_firstname" value="{if isset($settings.details_firstname)}{$settings.details_firstname|escape:'htmlall':'UTF-8'}{/if}">
                    {if isset($req_messages.details_firstname) && isset($req_fields.details_firstname) }
                        <p class="required-field">{l s='This field is required.' mod='dhlparcelbelux'}</p>
                    {/if}
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-lg-3" for="dpb_details_lastname">
                    <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="{l s='Eg Doe' mod='dhlparcelbelux'}">
                        {l s='Last name' mod='dhlparcelbelux'}
                    </span>
                </label>
                <div class="col-lg-4">
                    <input type="text" name="dpb_details_lastname" id="dpb_details_lastname" value="{if !empty($settings.details_lastname)}{$settings.details_lastname|escape:'htmlall':'UTF-8'}{/if}">
                    {if isset($req_messages.details_lastname) && isset($req_fields.details_lastname) }
                        <p class="required-field">{l s='This field is required.' mod='dhlparcelbelux'}</p>
                    {/if}
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-lg-3" for="dpb_details_street">
                    {l s='Street' mod='dhlparcelbelux'}
                </label>
                <div class="col-lg-4">
                    <input type="text" name="dpb_details_street" id="dpb_details_street" value="{if !empty($settings.details_street)}{$settings.details_street|escape:'htmlall':'UTF-8'}{/if}">
                    {if isset($req_messages.details_street) && isset($req_fields.details_street) }
                        <p class="required-field">{l s='This field is required.' mod='dhlparcelbelux'}</p>
                    {/if}
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-lg-3" for="dpb_details_house_number">
                    {l s='House number' mod='dhlparcelbelux'}
                </label>
                <div class="col-lg-4">
                    <input type="text" name="dpb_details_house_number" id="dpb_details_house_number" value="{if !empty($settings.details_house_number)}{$settings.details_house_number|escape:'htmlall':'UTF-8'}{/if}">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-lg-3" for="dpb_details_postal_code">
                    {l s='Postal code' mod='dhlparcelbelux'}
                </label>
                <div class="col-lg-4">
                    <input type="text" name="dpb_details_postal_code" id="dpb_details_postal_code" value="{if !empty($settings.details_postal_code)}{$settings.details_postal_code|escape:'htmlall':'UTF-8'}{/if}">
                    {if isset($req_messages.details_postal_code) && isset($req_fields.details_postal_code) }
                        <p class="required-field">{l s='This field is required.' mod='dhlparcelbelux'}</p>
                    {/if}
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-lg-3" for="dpb_details_city">
                    {l s='City' mod='dhlparcelbelux'}
                </label>
                <div class="col-lg-4">
                    <input type="text" name="dpb_details_city" id="dpb_details_city" value="{if !empty($settings.details_city)}{$settings.details_city|escape:'htmlall':'UTF-8'}{/if}">
                    {if isset($req_messages.details_city) && isset($req_fields.details_city) }
                        <p class="required-field">{l s='This field is required.' mod='dhlparcelbelux'}</p>
                    {/if}
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-lg-3" for="dpb_details_country">
                    {l s='Country' mod='dhlparcelbelux'}
                </label>
                <div class="col-lg-4">
                    <select name="dpb_details_country" id="dpb_details_country">
                        <option {if isset($settings.details_country) && $settings.details_country == 3 }selected="selected"{/if} value="3">{l s='Belgium' mod='dhlparcelbelux'}</option>
                        <option {if isset($settings.details_country) && $settings.details_country == 12 }selected="selected"{/if} value="12">{l s='Luxembourg' mod='dhlparcelbelux'}</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
</div>