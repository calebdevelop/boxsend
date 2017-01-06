{*
* 2015 Stigmi.eu
*
* @author Stigmi.eu <www.stigmi.eu>
* @copyright 2015 Stigmi.eu
* @license http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
*}

<div id="tab-manager-configuration">
    <fieldset id="dhl-settings-introduction" style="margin-top: 10px">
        <legend>
            <img src="../img/admin/cog.gif" />
            {l s='Configuration' mod='dhlparcelbelux'}
        </legend>
        <div>
            <label for="dpb_statuses">
                {l s='Display orders with the following statuses:' mod='dhlparcelbelux'}
            </label>
            <div class="margin-form">
                {foreach $statuses as $status}
                <div class="checkbox">
                    <input style="margin: 5px 5px 5px 0" type="checkbox" name="dpb_statuses[]" id="dpb_statuses_{$status.id_order_state|escape:'htmlall':'UTF-8'}" value="{$status.id_order_state|escape:'htmlall':'UTF-8'}" {if isset($settings.statuses) && $settings.statuses|is_array && $status.id_order_state|escape:'htmlall':'UTF-8'|in_array:$settings.statuses }checked="checked"{/if}>
                    <span style="margin-left: 5px; border: 1px solid #979797; width: 5px; height: 5px; display: inline-block; position: relative; margin-right: 4px; background-color:{$status.color|escape:'htmlall':'UTF-8'}; border-radius: 4px;"></span>
                    {$status.name|escape:'htmlall':'UTF-8'}
                    <br>
                </div>
                {/foreach}
            </div>
        </div>
        <div class="margin-form">
            <input type="submit" value="{l s='Save settings' mod='dhlparcelbelux'}" id="module_form_submit_btn" name="submitModuleDHLParcelBelux" class="button">
        </div>
    </fieldset>
</div>