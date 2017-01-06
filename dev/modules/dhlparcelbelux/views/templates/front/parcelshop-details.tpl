{*
* 2015 Stigmi.eu
*
* @author Stigmi.eu <www.stigmi.eu>
* @copyright 2015 Stigmi.eu
* @license http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
*}
{if $type == 'parcelshop'}
<div class="row">
	<div class="col-xs-12 col-sm-6">
		<div class="box">
			<h3 class="page-subheading">{l s='Parcelshop for delivery' mod='dhlparcelbelux'}</h3>
			<p>
				{if $shop->name}<strong>{$shop->name|escape:'html':'UTF-8'}</strong><br>{/if}
				{if $shop->address}{$shop->address|escape:'html':'UTF-8'}<br>{/if}
				{if $shop->zip}{$shop->zip|escape:'html':'UTF-8'}{/if} {if $shop->city}{$shop->city|escape:'html':'UTF-8'}{/if}
			</p>
			<p>
				<a href="{$track_trace_root|escape:'htmlall':'UTF-8'}{$tracking_code|escape:'htmlall':'UTF-8'}" alt="{l s='Follow your order with the tracking code' mod='dhlparcelbelux'} {$tracking_code|escape:'htmlall':'UTF-8'}">
					{l s='Follow your order with the tracking code' mod='dhlparcelbelux'} {$tracking_code|escape:'htmlall':'UTF-8'}
				</a>
			</p>
		</div>
	</div>
</div>
{elseif $type == 'home'}
<div class="row">
	<div class="col-xs-12 col-sm-6">
		<div class="box">
			<h3 class="page-subheading">{l s='DHL Delivery Options' mod='dhlparcelbelux'}</h3>
			<ul>
				{if $dhl_order->neighbour && $dhl_order->neighbour == 1}<li>{l s='No neighbour delivery' mod='dhlparcelbelux'}</li>{/if}
				{if $dhl_order->evening && $dhl_order->evening == 1}<li>{l s='Evening delivery' mod='dhlparcelbelux'}</li>{/if}
				{if $dhl_order->saturdays && $dhl_order->saturdays == 1}<li>{l s='Saturday delivery' mod='dhlparcelbelux'}</li>{/if}
			</ul>
			{if $dhl_order->neighbour != 1 && $dhl_order->evening != 1}
			<p class="warning">{l s='No option have been selected for this delivery' mod='dhlparcelbelux'}</p>
			{/if}
		</div>
	</div>
</div>
{/if}