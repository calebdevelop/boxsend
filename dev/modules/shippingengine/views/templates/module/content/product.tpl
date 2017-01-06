<form method="post" action="{$actionUrl}">
    <fieldset class="scheduler-border">
        <legend class="scheduler-border">{l s=""}</legend>
        <div class="form-wrapper">
            <div class="col-lg-9">
                <div class="form-group">
                    <div class="col-lg-1"><span class="pull-right"></span></div>
                    <label class="control-label col-lg-2">
                    <span title="" data-toggle="tooltip" class="label-tooltip" data-original-title="">
                        {l s="Choisir un produit" mod="shippingengine"}
                    </span>
                    </label>
                    <div class="col-lg-8">

                        <ul class="list-unstyled" id="productSelected">
                            {if $product->id}
                                <li class="product-pack-item media-product-pack" data-product-name="{$product->name}" data-product-qty="0" data-product-id="{$product->id}" data-product-id-attribute="0">
                                    <img class="media-product-pack-img" src="{$link->getImageLink($product->link_rewrite, $imageCover, 'small_default')}"/>
                                    <span class="media-product-pack-title">{$product->name}</span>
                                    <span class="media-product-pack-ref">REF: {$product->reference}</span>
                                    <button type="button" class="btn btn-default delPackItem media-product-pack-action" data-delete="{$product->id}"><i class="icon-trash"></i></button>
                                </li>
                            {/if}
                        </ul>

                        {*<input type="text" name="id_product_attribute" value="{if $product->id_product_attribute}{$product->id_product_attribute}{else}0{/if}" id="id_product_attribute"/>*}
                        <input type="hidden" name="id_product" value="{if $product->id}{$product->id}{/if}" id="id_product"/>
                        <input type="hidden" id="name_product" value="{if $product->id}{$product->name}{/if}"/>

                        <div class="col-lg-6">
                            <input type="text"  class="form-control" size="128" value="{$product->id}" id="inputProductAutocomplete">
                        </div>
                    </div>
                </div>
            </div>
            <button type="submit" class="btn btn-info" name="submitSaveProduct" value="1">
                {l s='Save' mod='shippingengine'}
            </button>
        </div>
    </fieldset>
</form>