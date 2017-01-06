<script>
    var zNewToken = '{$zTokenAjax}';
    var zAjaxProductList = "{$ajax_product_list_url}";
    var iLangID = '{$id_lang}';
</script>
<div class="panel form-horizontal">
    <div class="panel-heading">
        <i class="icon-user"></i>
        {l s='Configurations' mod='shippinengine'}
    </div>
    <div id="wizard-prestation" class="tabbable tabs-left">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#product" data-toggle="tab">{l s="Product" mod='shippinengine'}</a></li>
        </ul>

        <div class="tab-content">
            <div class="tab-pane active" id="product">
                {include file="./content/product.tpl"}
            </div>
        </div>
    </div>
</div>