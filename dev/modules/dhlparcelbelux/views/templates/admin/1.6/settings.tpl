{*
* 2015 Stigmi.eu
*
* @author Stigmi.eu <www.stigmi.eu>
* @copyright 2015 Stigmi.eu
* @license http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
*}

{if isset($is_multishop) && $is_multishop}
    <div class="warn">
        {l s='You are currently in "group" or "all shops" context. Please select a shop to continue.' mod='dhlparcelbelux'}
    </div>
{else}
    {if isset($success_save) }
        <div class="bootstrap">
            <div class="alert alert-success" style="display:block;">
                <p>{l s='Settings successfully saved.' mod='dhlparcelbelux'}</p>
                {if isset($updated_tabs) && count($updated_tabs) > 0 }
                <p>{l s='The following tabs have been updated:' mod='dhlparcelbelux'}</p>
                <ul>
                    {foreach from=$updated_tabs item=tab}
                    <li>{$tab|escape:'htmlall':'UTF-8'}</li>
                    {/foreach}
                </ul>
                {/if}
            </div>
        </div>
    {/if}

    {if isset($req_messages) && $req_messages|@count > 0}
        <div class="bootstrap">
            <div class="alert alert-danger" style="display:block;">
                <p>{l s='Please check that all points below are correctly set :' mod='dhlparcelbelux'}</p>
                <ul>
                    {foreach from=$req_messages item=message}
                        <li>{$message|escape:'htmlall':'UTF-8'}</li>
                    {/foreach}
                </ul>
            </div>
        </div>
    {/if}

    <form method="post" action="" class="defaultForm form-horizontal">
        <div class="row">
            <div class="col-lg-3 col-md-4">
                <div class="list-group" id="configuration-tabs">
                    <a class="list-group-item" href="#tab-account-information">
                        {l s='Account settings' mod='dhlparcelbelux'}
                        {if isset($updated_tabs) && isset($updated_tabs.account)}
                        <span class="badge dhl_badge">{l s='UP' mod='dhlparcelbelux'}</span>
                        {/if}
                        {if isset($req_messages_tabs) && isset($req_messages_tabs.account)}
                        <span class="badge dhl_error_badge"><i class="icon icon-warning"></i></span>
                        {/if}
                    </a>
                    <a class="list-group-item" href="#tab-sender-details">
                        {l s='Sender details' mod='dhlparcelbelux'}
                        {if isset($updated_tabs) && isset($updated_tabs.details)}
                        <span class="badge dhl_badge">{l s='UP' mod='dhlparcelbelux'}</span>
                        {/if}
                        {if isset($req_messages_tabs) && isset($req_messages_tabs.details)}
                        <span class="badge dhl_error_badge"><i class="icon icon-warning"></i></span>
                        {/if}
                    </a>
                    <a class="list-group-item" href="#tab-product-options">
                        {l s='Product options' mod='dhlparcelbelux'}
                        {if isset($updated_tabs) && isset($updated_tabs.options)}
                        <span class="badge dhl_badge">{l s='UP' mod='dhlparcelbelux'}</span>
                        {/if}
                        {if isset($req_messages_tabs) && isset($req_messages_tabs.options)}
                        <span class="badge dhl_error_badge"><i class="icon icon-warning"></i></span>
                        {/if}
                    </a>
                    {if isset($smarty.get.carriers) && $smarty.get.carriers == 1}
                    <a class="list-group-item" href="#tab-carrier-selection">
                        {l s='Carrier selection' mod='dhlparcelbelux'}
                        {if isset($updated_tabs) && isset($updated_tabs.carrier)}
                        <span class="badge dhl_badge">{l s='UP' mod='dhlparcelbelux'}</span>
                        {/if}
                        {if isset($req_messages_tabs) && isset($req_messages_tabs.carrier)}
                        <span class="badge dhl_error_badge"><i class="icon icon-warning"></i></span>
                        {/if}
                    </a>
                    {/if}
                    <a class="list-group-item" href="#tab-manager-configuration">
                        {l s='Configuration' mod='dhlparcelbelux'}
                        {if isset($updated_tabs) && isset($updated_tabs.config)}
                        <span class="badge dhl_badge">{l s='UP' mod='dhlparcelbelux'}</span>
                        {/if}
                        {if isset($req_messages_tabs) && isset($req_messages_tabs.config)}
                        <span class="badge dhl_error_badge"><i class="icon icon-warning"></i></span>
                        {/if}
                    </a>
                </div>
            </div>
            <div class="form-horizontal col-lg-9 col-md-8">
                {include file='./tabs/account-information.tpl'}
                {include file='./tabs/product-options.tpl'}
                {include file='./tabs/sender-details.tpl'}
                {include file='./tabs/carrier-selection.tpl' carriers=$carriers}
                {include file='./tabs/manager-configuration.tpl' statuses=$statuses}
            </div>

        </div>
        <div class="row">
            <div class="panel" style="margin: 0 5px;">
                <div class="panel-footer" style="margin-top: -21px">
                    <button type="submit" value="1" id="module_form_submit_btn" name="submitModuleDHLParcelBelux" class="btn btn-default pull-right">
                        <i class="process-icon-save"></i> {l s='Save' mod='dhlparcelbelux'}
                    </button>
                </div>
            </div>
        </div>
    </form>
{/if}
