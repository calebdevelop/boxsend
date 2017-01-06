{*
* 2015 Stigmi.eu
*
* @author Stigmi.eu <www.stigmi.eu>
* @copyright 2015 Stigmi.eu
* @license http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
*}

<div id="tab-sender-details">
    <fieldset id="dhl-settings-introduction" style="margin-top: 10px">
        <legend>
            <img src="../img/admin/cog.gif" />
            {l s='Sender details' mod='dhlparcelbelux'}
        </legend>
        <p>{l s='These details will only be used to create labels. Only BELUX addresses are accepted.' mod='dhlparcelbelux'}</p>
        
        <div>
            <label for="dpb_details_company">{l s='Company' mod='dhlparcelbelux'}</label>
            <div class="margin-form">
                <input type="text" name="dpb_details_company" id="dpb_details_company" value="{if isset($settings.details_company)}{$settings.details_company|escape:'htmlall':'UTF-8'}{/if}">
                {if isset($req_messages['dpb_details_company']) }
                    <p class="required-field">{l s='This field is required.' mod='dhlparcelbelux'}</p>
                {/if}
            </div>
        </div>
        <div>
            <label for="dpb_details_firstname">{l s='First name' mod='dhlparcelbelux'}</label>
            <div class="margin-form">
                <input type="text" name="dpb_details_firstname" id="dpb_details_firstname" value="{if isset($settings.details_firstname)}{$settings.details_firstname|escape:'htmlall':'UTF-8'}{/if}">
            </div>
        </div>
        <div>
            <label for="dpb_details_lastname">{l s='Last name' mod='dhlparcelbelux'}</label>
            <div class="margin-form">
                <input type="text" name="dpb_details_lastname" id="dpb_details_lastname" value="{if isset($settings.details_lastname)}{$settings.details_lastname|escape:'htmlall':'UTF-8'}{/if}">
            </div>
        </div>
        <div>
            <label for="dpb_details_street">{l s='Street' mod='dhlparcelbelux'}</label>
            <div class="margin-form">
                <input type="text" name="dpb_details_street" id="dpb_details_street" value="{if isset($settings.details_street)}{$settings.details_street|escape:'htmlall':'UTF-8'}{/if}">
            </div>
        </div>
        <div>
            <label for="dpb_details_house_number">{l s='House number' mod='dhlparcelbelux'}</label>
            <div class="margin-form">
                <input type="text" name="dpb_details_house_number" id="dpb_details_house_number" value="{if isset($settings.details_house_number)}{$settings.details_house_number|escape:'htmlall':'UTF-8'}{/if}">
            </div>
        </div>
        <div>
            <label for="dpb_details_postal_code">{l s='Postal code' mod='dhlparcelbelux'}</label>
            <div class="margin-form">
                <input type="text" name="dpb_details_postal_code" id="dpb_details_postal_code" value="{if isset($settings.details_postal_code)}{$settings.details_postal_code|escape:'htmlall':'UTF-8'}{/if}">
            </div>
        </div>
        <div>
            <label for="dpb_details_city">{l s='City' mod='dhlparcelbelux'}</label>
            <div class="margin-form">
                <input type="text" name="dpb_details_city" id="dpb_details_city" value="{if isset($settings.details_city)}{$settings.details_city|escape:'htmlall':'UTF-8'}{/if}">
            </div>
        </div>
        <div>
            <label for="dpb_details_country">{l s='Country' mod='dhlparcelbelux'}</label>
            <div class="margin-form">
                <select name="dpb_details_country" id="dpb_details_country">
                    <option {if isset($settings.details_country) && $settings.details_country == 3 }selected="selected"{/if} value="3">{l s='Belgium' mod='dhlparcelbelux'}</option>
                    <option {if isset($settings.details_country) && $settings.details_country == 12 }selected="selected"{/if} value="12">{l s='Luxembourg' mod='dhlparcelbelux'}</option>
                </select>
            </div>
        </div>
        <div class="margin-form">
            <input type="submit" value="{l s='Save settings' mod='dhlparcelbelux'}" id="module_form_submit_btn" name="submitModuleDHLParcelBelux" class="button">
        </div>
    </fieldset>
</div>