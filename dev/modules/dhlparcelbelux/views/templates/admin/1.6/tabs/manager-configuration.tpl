{*
* 2015 Stigmi.eu
*
* @author Stigmi.eu <www.stigmi.eu>
* @copyright 2015 Stigmi.eu
* @license http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
*}

<div class="tab" id="tab-manager-configuration" style="display: none">
    <div class="panel" id="dhl-settings-introduction">
        <div class="panel-heading">
            <i class="icon-cogs"></i> {l s='Configuration' mod='dhlparcelbelux'}
        </div>
        <div class="form-wrapper">
            <div class="form-group">
                <label class="control-label col-lg-3" for="dpb_statuses">
                    <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="{l s='You can use these settings to filter the orders displayed in the DHL tab. Leave unchecked to display all statuses.' mod='dhlparcelbelux'}">
                        {l s='Display orders with the following statuses:' mod='dhlparcelbelux'}
                    </span>
                </label>
                <div class="col-lg-9">
                    {foreach $statuses as $status}
                    <div class="checkbox">
                        <label for="dpb_statuses" class="col-lg-11">
                            <input type="checkbox" name="dpb_statuses[]" id="dpb_statuses_{$status.id_order_state|escape:'htmlall':'UTF-8'}" value="{$status.id_order_state|escape:'htmlall':'UTF-8'}" {if isset($settings.statuses) && is_array($settings.statuses) && $status.id_order_state|escape:'htmlall':'UTF-8'|in_array:$settings.statuses }checked="checked"{/if}>
                            <span style="width: 5px; height: 5px; display: inline-block; position: relative; top: -2px; margin-right: 4px; background-color:{$status.color|escape:'htmlall':'UTF-8'}; border-radius: 4px;"></span>
                            {$status.name|escape:'htmlall':'UTF-8'}
                        </label>
                    </div>
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
</div>