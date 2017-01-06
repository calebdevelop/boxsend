{*
* 2015 Stigmi.eu
*
* @author Stigmi.eu <www.stigmi.eu>
* @copyright 2015 Stigmi.eu
* @license http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
*}

{if isset($success_message)}
{$success_message}
{/if}

{if isset($bulk_print_ids)}
<script type="text/javascript">var bulk_print_ids = {$bulk_print_ids|escape:'htmlall':'UTF-8'};</script>
{/if}

{$list_html}