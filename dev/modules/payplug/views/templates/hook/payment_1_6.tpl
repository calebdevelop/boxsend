{*
* 2016 PayPlug
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PayPlug SAS
*  @copyright 2016 PayPlug SAS
*  @license http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PayPlug SAS
*}
{if isset($api_url)}
	<script type="text/javascript" src="{$api_url|escape:'htmlall':'UTF-8'}/js/1.0/form.js"></script>
	<script type="text/javascript">
		var spinner_url = '{$spinner_url|escape:'htmlall':'UTF-8'}';
		var payment_url = '{$payment_url|escape:'htmlall':'UTF-8'}';

		$('input[name=SubmitPayplugOneClick]').unbind('click');
		$('input[name=SubmitPayplugOneClick]').bind('click', function(e){
			e.preventDefault();
			var id_card = $('input[name=payplug_card]:checked').val();
			callPayment(id_card);
			return false;
		});

		$('a.payplug.call').unbind('click');
		$('a.payplug.call').bind('click', function(e) {
			e.preventDefault();
			$('body').append('<div class="overlay"><img class="loader" src="'+spinner_url+'" /></div>');
			callPayment('new_card');
			return false;
		});

	</script>
{/if}
<div class="row">
	<div class="col-xs-12">
		{if isset($payplug_one_click) AND $payplug_one_click == 1}<div class="payplug-wrapper">{/if}
			<p class="payment_module">
				{if isset($front_ajax_url)}
					{if isset($payplug_one_click)}
						<span>
							{l s='Credit card checkout' mod='payplug'}
						</span>
					{/if}
					<a class="payplug call{if isset($payplug_one_click)} pphide{/if}" title="{l s='Credit card payment' mod='payplug'}" href="{$this_path|escape:'htmlall':'UTF-8'}controllers/front/payment.php">
						{l s='Credit card checkout' mod='payplug'}
					</a>

				{else}
					<a class="payplug" title="{l s='Credit card payment' mod='payplug'}" href="{$this_path|escape:'htmlall':'UTF-8'}controllers/front/payment.php">
						{l s='Credit card checkout' mod='payplug'}
					</a>
				{/if}
			</p>
			{if isset($front_ajax_url)}
				<form style="display: none;">
					<input type="hidden" name="front_ajax_url" value="{$front_ajax_url|escape:'htmlall':'UTF-8'}" />
					<input type="hidden" name="id_cart" value="{$cart->id|escape:'htmlall':'UTF-8'}" />
				</form>
			{/if}
			{if isset($payplug_one_click) AND $payplug_one_click == 1}
			<form id="form_payplug_payment" action="">
				<input type="hidden" name="front_ajax_url" value="{$front_ajax_url|escape:'htmlall':'UTF-8'}" />
				<input type="hidden" name="id_cart" value="{$cart->id|escape:'htmlall':'UTF-8'}" />
				{if isset($payplug_cards) AND !empty($payplug_cards) AND sizeof($payplug_cards)}
					{foreach from=$payplug_cards item=card name=ppcards}
						<div class="card-wrapper">
							<input type="radio" name="payplug_card" id="payplug_card_{$card.id_payplug_card|escape:'htmlall':'UTF-8'}" value="{$card.id_payplug_card|escape:'htmlall':'UTF-8'}" {if $smarty.foreach.ppcards.first}checked="checked" {/if}/>
							<label for="payplug_card_{$card.id_payplug_card|escape:'htmlall':'UTF-8'}">
								<img src="{$this_path|escape:'htmlall':'UTF-8'}views/img/{$card.brand|escape:'htmlall':'UTF-8'|lower}.png"/>
								<div class="info-wrapper">
									<div>**** **** **** {$card.last4|escape:'htmlall':'UTF-8'} ({if $card.brand == 'none'}{l s='Card' mod='payplug'}{else}{$card.brand|escape:'htmlall':'UTF-8'}{/if})</div>
									<div class="payplug_expiry_date">{l s='Expiry date' mod='payplug'} {$card.expiry_date|escape:'htmlall':'UTF-8'}</div>
								</div>
							</label>
							<br />
						</div>
					{/foreach}
				{/if}
					<div class="card-wrapper">
						<input type="radio" name="payplug_card" id="payplug_card_new" value="new_card">
						<label for="payplug_card_new">
							<img src="{$this_path|escape:'htmlall':'UTF-8'}views/img/none.png"/>
							{*<span>{l s='Pay with a different card' mod='payplug'}</span><br />*}
							<div class="info-wrapper">
								<div>{l s='Pay with a different card' mod='payplug'}</div>
							</div>
						</label>
					</div>
				<div class="ppOneClickStatus">
					<p class="ppwait">{l s='Please wait...' mod='payplug'}<img class="loader" src="{$module_dir|escape:'htmlall':'UTF-8'}views/img/admin/spinner.gif" /></p>
					<p class="ppsuccess">
						<img src="{$this_path|escape:'htmlall':'UTF-8'}views/img/admin/icon-success.png" />
						<span class="ppbold">{l s='Payment succeeded!' mod='payplug'}</span><br />
						{l s='You will be redirected to the confirmation page' mod='payplug'}
					</p>
					<p class="ppfail">{l s='The transaction was not completed and your card was not charged.' mod='payplug'}</p>
					<input class="ppsubmit" type="submit" name="SubmitPayplugOneClick" value="{l s='Pay' mod='payplug'} {displayPrice price=$price2display}" />
				</div>
			</form>
			{/if}
		{if isset($payplug_one_click) AND $payplug_one_click == 1}</div>{/if}
	</div>
</div>
