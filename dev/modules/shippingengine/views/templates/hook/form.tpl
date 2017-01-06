<div id="slide">
    <div><img src="{$img_dir}compare.jpg" alt="{l s='Colis'}"/></div>
    <div><img src="{$img_dir}colistransport.jpg" alt="{l s='Colis'}"/></div>
    <div><img src="{$img_dir}pallete-transport.jpg" alt="{l s='Colis'}"/></div>
</div>
<div id="slideForm" class="blockrecherchetop">
    <form method="post" action="{$link->getModuleLink('shippingengine', 'search', [], true)}">
        <div class="container">
            <div class="col-sm-6">
                <div class="blockForm">
                    <h4>{l s='Comparateur d\'envoi de Colis' mod='shippingengine'}</h4>
                    <div class="formblock">
                        <div class="blockf">
                            <div class="labelType">{l s='Type' mod='shippingengine'}</div>
                            <div class="contentCheck">
                                {foreach $tmColis as $mColis}
                                    <label class="formcheck {$mColis.class}">
                                        <input type="radio" required name="parcel[type]" value="{$mColis.code}" class="checkbox_persoh"/> <span class="nameColis">{$mColis.name}</span>
                                    </label>
                                {/foreach}
                            </div>
                        </div>
                        <div class="form-inlineinput clearfix data-parent-location">
                            <div class="labelType">
                                {l s='Départ' mod='shippingengine'}
                            </div>
                            <div class="clearfix"></div>
                            <div class="col-sm-7 inputnoleft">
                                <div class="selectType">
                                    <select name="departure[country]" required class="autocomplete-location-country"  id="departure[country]" data-placeholder="{l s='Sélectionner l\'origine' mod='shippingengine'}">
                                        <option value=""></option>
                                        {foreach $departuresCountries as $country}
                                            <option value="{$country.iso_code}">{$country.name}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="col-sm-5 inputpding">
                                <div class="selectType">
                                    <input type="text" class="autocomplete-location-cp" required id="departure[cp]" name="departure[cp]" placeholder="{l s='Ville ou code postal' mod='shippingengine'}"/>
                                </div>
                            </div>
                        </div>
                        <div class="form-inlineinput clearfix data-parent-location">
                            <div class="labelType">{l s='Arrivé' mod='shippingengine'}</div>
                            <div class="clearfix"></div>
                            <div class="col-sm-7 inputnoleft">
                                <div class="selectType">
                                    <select name="arrival[country]" required class="autocomplete-location-country" data-placeholder="{l s='Sélectionner l\'origine' mod='shippingengine'}">
                                        <option value=""></option>
                                        {foreach $arrivalsCountries as $country}
                                            <option value="{$country.iso_code}">{$country.name}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="col-sm-5 inputpding">
                                <div class="selectType">
                                    <input type="text" required class="autocomplete-location-cp" name="arrival[cp]"  id="arrival[cp]" placeholder="{l s='Ville ou code postal' mod='shippingengine'}"/>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>

                    <div class="formColis">
                        <div class="clearfix"></div>
                        <h4>{l s='Détails de votre colis' mod='shippingengine'}</h4>
                        <div class="contentColis">
                            <div class="inputForm">
                                <div class="labelType">{l s='Colis' mod='shippingengine'}</div>
                                <div class="inputColis"><input type="text" required class="inputText" name="parcel[count]" placeholder="{l s='Nbre colis' mod='shippingengine'}"/></div>
                                <div class="inputColis"><input type="text" required class="inputText" name="parcel[weight]" placeholder="{l s='Kg' mod='shippingengine'}"/><span>{l s='Poids' mod='shippingengine'}</span></div>
                                <div class="inputColis"><input type="text" required class="inputText" name="parcel[length]" placeholder="{l s='Cm' mod='shippingengine'}"/><span>{l s='Longueur' mod='shippingengine'}</span></div>
                                <div class="inputColis"><input type="text" required class="inputText" name="parcel[width]" placeholder="{l s='Cm' mod='shippingengine'}"/><span>{l s='Largeur' mod='shippingengine'}</span></div>
                                <div class="inputColis"><input type="text" required class="inputText" name="parcel[height]" placeholder="{l s='Cm' mod='shippingengine'}"/><span>{l s='Hauteur' mod='shippingengine'}</span></div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="col-sm-12">
                                <div class="selectType">
                                    <div class="labelType">{l s='Date d\'enlèvement' mod='shippingengine'}</div>
                                    <input type="text" name="departuredate" required class="datepicker"/>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="buttonClass">
                                <button class="submitClass" type="submit"><span>{l s='Rechercher la meilleur offre' mod='shippingengine'}</span></button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="blockRightSlide">
                    <h4>{l s='livraison de colis en france'} <br>{l s='et partout dans le monde' mod='shippingengine'}</h4>
                    <div class="remise">
                        <div class="transport">
                            <span>{l s='20%'}</span> {l s='de remise des tarifs' mod='shippingengine'}
                            <div class="imgTransport">
                                <img src="{$img_dir}dhl_logo.png" alt="{l s='dhl'}">
                                <img src="{$img_dir}tnt_logo.png" class="tnt" alt="{l s='tnt'}">
                                <img src="{$img_dir}UPS_logo.png" alt="{l s='ups'}">
                            </div>
                        </div>
                        <div class="stitle">{l s='Sans contrat ni engagement' mod='shippingengine'}</div>
                        <div class="stitle">{l s='Plus de 220 destinations' mod='shippingengine'}</div>
                        <div class="clearfix footerClass">
                            <div class=" col-sm-6 inputnoleft"><a href="#" class="whois" title="{l s='Qui sommes nous ?' mod='shippingengine'}">{l s='Qui sommes nous ?' mod='shippingengine'}</a></div>
                            <div class="col-sm-6 inputpding"><a href="{$link->getPageLink('contact', true)|escape:'html':'UTF-8'}" class="contactClass" title="{l s='Contactez-nous' mod='shippingengine'}">{l s='Contactez-nous' mod='shippingengine'}</a></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<div id="cqmId" class="cqm">
    <div class="container">
        <div class="col-sm-5">
            <img src="{$img_dir}comment-camarche.png" alt="{l s='Comment ça marche ?' mod='shippingengine'}" class="img-responsive"/>
        </div>
        <div class="col-sm-7">
            <div class="blockRight">
                <div class="listTxt">
                    <div class="img"><img src="{$img_dir}picto-screen.png" alt="{l s='screen' mod='shippingengine'}" class="img-responsive"/></div>
                    <div class="text">
                        <h4>{l s='Comparer' mod='shippingengine'}</h4>
                        <p>{l s='Le meilleurs offres de transport professionnels.' mod='shippingengine'}</p>
                    </div>
                </div>
                <div class="listTxt">
                    <div class="img"><img src="{$img_dir}picto-box.png" alt="{l s='screen' mod='shippingengine'}" class="img-responsive"/></div>
                    <div class="text">
                        <h4>{l s='Envoyer' mod='shippingengine'}</h4>
                        <p>{l s='Enlèvement sur site ou dépôt en point de relais.' mod='shippingengine'}</p>
                    </div>
                </div>
                <div class="listTxt">
                    <div class="img"><img src="{$img_dir}picto-follow.png" alt="{l s='screen' mod='shippingengine'}" class="img-responsive"/></div>
                    <div class="text">
                        <h4>{l s='Gérer' mod='shippingengine'}</h4>
                        <p>{l s='Suivis en ligne de tous vos envois de courriers, colis, palettes.' mod='shippingengine'}</p>
                    </div>
                </div>
                <div class="bottomLink">
                    <a href="#" class="fistSend" title="{l s='Commencer un envoi' mod='shippingengine'}">{l s='Commencer un envoi' mod='shippingengine'}</a>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="info-section text-center">
    <div class="container">
        <div class="col-md-12">
            <h3>{l s='Envoyez vos colis avec' mod='shippingengine'} <strong class="texte-orange">{l s='BoxSend'  mod='shippingengine'}</strong>, {l s='C\'est bénéficier de réductions exclusives pour tous vos envois.' mod='shippingengine'}</h3>
            <p>{l s='Avec BoxSend, c\'est un service client à votre ecoute pour tous vos envois.' mod='shippingengine'}</p>
            <a href="#" class="btnbouton">{l s='En savoir plus' mod='shippingengine'}</a>
        </div>
    </div>
</div>
<div class="last-section">
    <div class="container">
        <div class="row">
            <div class="col-md-7 texte-gris">
                <p>{l s='Envoyez vos colis vers plus de 220 destinations à travers le monde et profitez de nombreux avantages!' mod='shippingengine'}</p>
                <div>
                    <ul class="list-unstyled block-avantage">
                        <li>{l s='Jusqu\'à -70% de remise sur vos envois' mod='shippingengine'}</li>
                        <li>{l s='Des transporteurs mondiaux pour vos colis' mod='shippingengine'}</li>
                        <li>{l s='Sans contrat ni engagement' mod='shippingengine'}</li>
                        <li>{l s='Un seul service client pour tout vos envois' mod='shippingengine'}</li>
                    </ul>
                </div>

            </div>
            <div class="col-md-5">
                <img src="{$img_dir}package-forwarding1.png" class="img-responsive" alt="">
            </div>

            <div class="col-md-12 texte-noir text-center">
                <p> </p><h3 class="texte18"><strong class="texte-orange">{l s='BoxSend' mod='shippingengine'}</strong>, {l s='la solution adaptée pour tous vos envois de colis à travers le monde.' mod='shippingengine'}</h3><p></p>
                <div class="col-md-6 col-md-offset-3">
                    <img src="{$img_dir}dhl_logo.png" alt="" class="col-sm-3 col-md-3">
                    <img src="{$img_dir}tnt_logo.png" alt="" class="col-sm-3 col-md-3">
                    <img src="{$img_dir}UPS_logo.png" alt="" class="col-sm-3 col-md-3">
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var linkModule = '{$link->getModuleLink('shippingengine', 'autocomplete', [], true)}';
</script>
{literal}
    <script type="text/javascript">
        $(document).ready(function(){

            $(".autocomplete-location-country").each(function(i,e){
                var $departureCountry = $(e);
                var $departureCpAutocomplete = $departureCountry.parents('.data-parent-location:first').find(".autocomplete-location-cp:first");

                $departureCountry.on("change",function(){
                    $departureCpAutocomplete.select2({
                        placeholder: "",
                        minimumInputLength: 3,
                        width: '100%',
                        dropdownCssClass: "bootstrap",
                        ajax: {
                            url: linkModule,
                            dataType: 'json',
                            data: function (term) {
                                return {
                                    q: term,
                                    country : $departureCountry.val()
                                };
                            },
                            results: function (data) {
                                return {
                                    results: data
                                }
                            }
                        },
                        id: function(data){return data.cp + ", " +  data.city},
                        formatResult: function(data, term){
                            return '<a role="option">' + data.cp + ', ' + data.city + '</a>';
                        },
                        formatSelection : function(item){
                            return item.cp + ", " + item.city;
                        },
                    });
                });
            });
        });
    </script>
{/literal}