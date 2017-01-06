<script type="text/javascript">
    var rates = new Array();
</script>
<div class="my-breadcrumb">
    <a href=/#" class="ico-check">{l s='Votre envoi' mod='shippingengine'}</a>
    <a href="#" class="ico-box current">{l s='Les offres' mod='shippingengine'}</a>
    <span>{l s='Commande' mod='shippingengine'}</span>
    <span>{l s='Paiement' mod='shippingengine'}</span>
    <span>{l s='Confirmation' mod='shippingengine'}</span>
</div>
<div class="content">
    <div class="head-page">
        {*
        <p class="pull-right">
            <img src="/modules/shippingengine/views/img/ico-print.png" alt="Imprimer" title="Imprimer" width="19" height="22">
            <!--a class="link" target="_blank" href="#">Imprimer</a-->
            <img src="/modules/shippingengine/views/img/ico-envelope.png" alt="Email" title="Email" width="15" height="11">
            <a class="link" href="#">Envoyer par mail</a><br> </p>
        </p>
        *}
        <h1>{l s='SELECTIONNEZ UNE OFFRE' mod='shippingengine'}</h1>
        <!--button class="button btn btn-default btnbouton pull-right">Modifier les critères de recherche</button-->
        <div class="info-top">
            <p><strong>{l s='De :' mod='shippingengine'} </strong>{$departure.zipcode} {$departure.city}</p>
            <p><strong>{l s='A :' mod='shippingengine'} </strong>{$arrival.zipcode} {$arrival.city}</p>
            <!--p><strong>Contenu : </strong>Chaussures</p-->
            <p><strong>{$parcelCount} colis </strong> - {$parcel.weight} kg - <strong>Dimensions </strong> {$parcel.width} cm x {$parcel.length} cm x {$parcel.height} cm </p>
        </div>
    </div>
    <div class="top-offres">
        <div class="row">
            <div class="col-lg-2 col-md-3 col-xs-3 text-center top-offres-1">
                <span>{count($rates)} {l s='offres' mod='shippingengine'}</span>
                <!--a href="#">Réinitialiser</a-->
            </div>
            <!--div class="col-lg-2 col-md-3 col-xs-3 text-center top-offres-2">
                <span>DÉPART</span>
                <strong>TOUS LIEUX</strong>
                <div class="row- box-check">
                    <label class="col-xs-6 text-right">
                        <input type="checkbox" checked="checked"><img src="/modules/shippingengine/views/img/ico-home.png" alt="Site" title="Site" width="20" height="18">
                    </label>
                    <label class="col-xs-6 text-left">
                        <input type="checkbox" checked="checked"><img src="/modules/shippingengine/views/img/ico-marker.png" alt="Point de proximité" title="Point de proximité" width="12" height="17">
                    </label>
                </div>
            </div>
            <div class="col-lg-2 col-md-3 col-xs-3 text-center top-offres-3">
                <span>ARRIVÉE</span>
                <strong class="text-uppercase">TOUS LIEUX</strong>
                <div class="row- box-check">
                    <label class="col-xs-6 text-right">
                        <input type="checkbox" checked="checked"><img src="/modules/shippingengine/views/img/ico-home.png" alt="Site" title="Site" width="20" height="18">
                    </label>
                    <label class="col-xs-6 text-left">
                        <input type="checkbox" checked="checked"><img src="/modules/shippingengine/views/img/ico-marker.png" alt="Point de proximité" title="Point de proximité" width="12" height="17">
                    </label>
                </div>
            </div>
            <div class="col-lg-2 col-md-3 col-xs-3 text-center pull-right top-offres-4">
                <span></span>
                <strong class="text-uppercase">ENVOI URGENT</strong>
                <div class="row box-check">
                    <label class="col-xs-12">
                        <input type="checkbox" checked="checked"><img src="/modules/shippingengine/views/img/ico-truck5.png" alt="Envoi urgent" title="Envoi urgent" width="25" height="13">
                    </label>
                </div>
            </div-->
        </div>
    </div>
    <div class="row flitre">
        <div class="col-xs-2 text-center">
            {l s='Transporteur' mod='shippingengine'} <a href="javascript:void(0)" class="tri-select" data-asc="0" data-tri="carrier"><span class="tri-icon tri-icon-decendant"></span></a>
        </div>
        <div class="col-xs-2 text-center">
            {l s='Date de départ' mod='shippingengine'} <!--span class="tri-select tri-decendant"></span-->
        </div>
        <div class="col-xs-2 text-center">
            {l s='Délai' mod='shippingengine'} <a href="javascript:void(0)" class="tri-select"  data-asc="0" data-tri="delivery_days"><span class="tri-icon tri-icon-decendant"></span></a>
        </div>
        <div class="col-xs-2 text-center">
            {l s='Date de livraison' mod='shippingengine'} <a href="javascript:void(0)"  data-asc="0"  class="tri-select" data-tri="delivery_date"><span class="tri-icon tri-icon-decendant"></span></a>
        </div>
        <div class="col-xs-2 text-center">
            {l s='Prix' mod='shippingengine'} <a href="javascript:void(0)" class="tri-select"  data-asc="0" data-tri="rate"><span class="tri-icon tri-icon-decendant"></span></a>
        </div>
    </div>

    {literal}
    <script>
        $(document).ready(function(){
            var currentDirection = "0";
            var isFloat = false;
            function compareValue(a,b) {
                if( isFloat ){
                    a.value = parseFloat(a.value);
                    b.value = parseFloat(b.value);
                }
                if( currentDirection == "0" ){
                    if (a.value < b.value)
                        return -1;
                    if (a.value> b.value)
                        return 1;
                }else{
                    if (a.value > b.value)
                        return -1;
                    if (a.value< b.value)
                        return 1;
                }

                return 0;
            }

            $("a.tri-select").on("click",function(e){
                e.preventDefault();
                var $oCurr = $(this);
                var zHtml = "";
                currentDirection = $oCurr.attr('data-asc');

                if( $oCurr.attr('data-asc') == "1" ){
                    $oCurr.attr('data-asc','0');
                    $oCurr.find("span.tri-icon").removeClass("tri-icon-decendant").addClass("tri-icon-ascendant");
                }else{
                    $oCurr.attr('data-asc','1');
                    $oCurr.find("span.tri-icon").addClass("tri-icon-decendant").removeClass("tri-icon-ascendant");
                }

                var filter = $(this).attr("data-tri")
                var listData = new Array();

                if( filter == "rate" ){
                    isFloat = true;
                }else{
                    false;
                }
                $("#listRates .box-item-list").each(function(i,e){
                    listData.push({
                        'id' : $(e).attr('data-rate-id') ,
                        'filter' : $(e).attr('data-rate-'+filter),
                        'value': $(e).attr('data-rate-' + filter),
                    });
                });
                listData.sort(compareValue);
                var $toNewBox = new Array();
                $.each(listData,function(i,e){
                    $toNewBox.push( $("[data-rate-id=" + e.id + "]") );
                });
                $("#listRates").fadeToggle({
                    complete : function(){
                        $("#listRates").html($toNewBox);
                        $("#listRates").fadeToggle();
                    }
                });
            });
        });
    </script>
    {/literal}

    <div class="row" id="listRates">
        {if isset($rates) && !empty($rates)}
            {*
            <pre>
            {$rates|@print_r}
            </pre>
            *}
            {foreach $rates as $rate}
                <script type="text/javascript">
                    rates.push({Tools::jsonEncode($rate)})
                </script>
                {*
                <!--li>
                    Carrier  : <span class="label label-warning">{$rate->carrier}</span><br/>
                    Delivery days  : {$rate->delivery_days}<br/>
                    Delivery date  : {$rate->delivery_date}<br/>
                    delivery_date_guaranteed  : {$rate->delivery_date_guaranteed}<br/>
                    Rate  : {$rate->rate}<br/>
                    Currency  : {$rate->currency}<br/>
                    Converted price  : <span class="label label-danger">{Tools::displayPrice($rate->localPrice)}</span><br/>
                    retail_rate  : {$rate->retail_rate}<br/>
                    retail_currency  : {$rate->retail_currency}<br/>
                    shipment_id  : {$rate->shipment_id}<br/>
                    carrier_account_id  : {$rate->carrier_account_id}<br/>
                    <hr/>
                    </li-->
            *}

                <div class="box-item-list" data-rate-id="{$rate->id}" data-rate-carrier="{$rate->carrier} {$rate->service}" data-rate-rate="{$rate->localPrice}" data-rate-delivery_date="{$rate->delivery_date}" data-rate-delivery_days="{$rate->delivery_days}">
                    <div class="row">
                        <div class="col-xs-2 box-item-list-1">
                            <div class="img-transposteur">
                                <img class="centre" src="{SeTools::getCarrierLogo($rate->carrier_account_id)}" alt="">
                                <!--img class="centre" src="/modules/shippingengine/views/img/operators/MONR.png" alt=""-->
                            </div>
                            <div class="name-transposteur">
                                {$rate->carrier} <br/> {$rate->service}
                            </div>

                        </div>
                        <div class="col-xs-2 box-item-list-2 text-center">
                            <div class="my-panel-body">
                                <div class="title-panel">
                                    Dépôt dès le {$rate->departure_date_week_long}
                                </div>
                                <div class="footer-panel text-center">
                                    <div class="relay">
                                        <!--div class="number">14</--div>
                                        <div-- class="month">novembre</div-->
                                        <div class="number">{$rate->departure_date_day}</div>
                                        <div class="month">{$rate->departure_date_month_long}</div>
                                        <!--div class="number">
                                        {Tools::displayDate($departureDateUnix)}
                                    </div-->
                                    </div>
                                </div>
                            </div>
                            <!--p class="panel-bottom"> Dépôt en<br>Relais Colis<sup>®</sup>XXXXXX </p-->
                            <!--a class="pointer">Liste des relaisXXX</a-->
                        </div>
                        <div class="col-xs-2 box-item-list-3">
                            <div class="period">
                                <strong>{$rate->delivery_days} JOURS</strong>
                            </div>
                        </div>
                        <div class="col-xs-2 box-item-list-4 text-center">
                            <div class="my-panel-body">
                                <div class="title-panel">
                                    Prévue le {$rate->delivery_date_week_long}
                                </div>
                                <div class="footer-panel text-center">
                                    <div class="relay">
                                        <div class="number">{$rate->delivery_date_day}</div>
                                        <div class="month">{$rate->delivery_date_month_long}</div>
                                        <!--div class="number">18</div>
                                        <div class="month">novembre</div-->
                                    </div>
                                </div>
                            </div>
                            <!--p class="panel-bottom"> Livraison en<br>Relais Colis<sup>®</sup> </p-->
                            <!--a class="pointer">Liste des relais</a-->
                        </div>
                        <div class="col-xs-2 text-right box-item-list-5">
                            <div class="price product-price">{Tools::displayPrice($rate->localPrice)} HT</div>
                            <div class="price product-price-ttc">{Tools::displayPrice($rate->localPriceTTC)} TTC</div>
                            <!--div class="old-price product-price">5,81€ TTC</div-->
                        </div>

                        <div class="col-xs-2 box-item-list-6 no-padding">
                            <form id="buy_block"{if $PS_CATALOG_MODE && !isset($groups) && $product->quantity > 0} class="hidden"{/if} action="{$link->getPageLink('cart')|escape:'html':'UTF-8'}" method="post">
                                <!-- hidden datas -->
                                <p class="hidden">
                                    <!-- PS product -->
                                    <input type="hidden" name="token" value="{$static_token}" />
                                    <input type="hidden" name="id_product" value="{$product->id|intval}" id="product_page_product_id" />
                                    <input type="hidden" name="add" value="1" />
                                    <input type="hidden" name="is_single_cart" value="1" />
                                    <input type="hidden" name="id_product_attribute" id="idCombination" value="" />

                                    <!-- Easypost data -->
                                    <input type="hidden" name="rate_id" value="{$rate->id}">
                                </p>
                                <input class="button btn btn-default fistSend text-center" type="submit" value="{l s="Choisir cette offre" mod="shippingengine"}"/>
                            </form>
                            <!--a href="#" class="detail">Plus de détails</a-->
                        </div>
                    </div>
                </div>
            {/foreach}
        {/if}
    </div>

</div>