{*
* 2015 Stigmi.eu
*
* @author Stigmi.eu <www.stigmi.eu>
* @copyright 2015 Stigmi.eu
* @license http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
*}
{if !isset($shops.status) || $shops.status == 0}
    {if $ps_minor_version < 6}
    <link rel="stylesheet" type="text/css" href="{$module_css_root|escape:'htmlall':'UTF-8'}bootstrap-grids.css" >
    {/if}
    <link rel="stylesheet" type="text/css" href="{$module_css_root|escape:'htmlall':'UTF-8'}dhl-front.css" >
    <script type="text/javascript" src="{$module_js_root|escape:'htmlall':'UTF-8'}maps.js"></script>
    <script type="text/javascript">

        var geocoder;
        var google;

        function localGeocode( callback )  {
            geocoder = new google.maps.Geocoder();
            geocoder.geocode({ address: search_string }, function(results, status) {
                if ( status == google.maps.GeocoderStatus.OK ) {
                    pos = results[0].geometry.location;
                    latitude = pos.lat();
                    longitude = pos.lng();
                    callback();
                }
            });
        }

        window.gmLoadedCallback = function() {
            $( window ).trigger( 'gMapsLoaded' );

            // Geocode the address
            localGeocode( function(){} );
        }

        var i18n_dhl = {
            'please_select_shop' : "{l s='You must select a DHL Parcelshop before continuing.' mod='dhlparcelbelux' js=1}"
        };

        var ps_version    = "{$ps_version|escape:'htmlall':'UTF-8'}";
        var ps_column_index_for_description = (ps_version < 1.6 ) ? 1 : 2;
        var module_dir    = "{$module_dir|escape:'htmlall':'UTF-8'}";
        var dhl_shops     = {$shops};
        var text_closed   = "{$text_closed|escape:'htmlall':'UTF-8'}";
        var search_string = "{$search_string|escape:'htmlall':'UTF-8'}";
        var latitude      = false;
        var longitude     = false;
        var pos = false;

        $(function() {
            if ( typeof google == 'undefined' ) {
                var script_tag = document.createElement('script');
                script_tag.setAttribute('type','text/javascript');
                script_tag.setAttribute('src','{$maps_url|escape:'htmlall':'UTF-8'}&callback=gmLoadedCallback');
                (document.getElementsByTagName('head')[0] || document.documentElement).appendChild(script_tag);
            }

            // Append the extra information to the right carriers

            $.each({$dhl_carriers_json}, function(variable, index) {

                var $origin = $('#dhl-' + variable + '-extra');
                
                if (ps_version < 1.5) {
                    var $destination = $('#carrierTable tbody tr').eq(index).find('td.carrier_infos');
                } else {
                    var $destination = $('.delivery_option').eq(index).find('td').eq(ps_column_index_for_description);
                }
                
                $origin.detach().appendTo($destination).hide();
            });

            $('input.delivery_option_radio:checked').first().parents('.delivery_option').find('.dhl-extra').show();
            if (ps_version < 1.5 ) {
                $('input[name="id_carrier"]:checked').first().parents('tr').find('.dhl-extra').show();
            }

            // Prestashop 1.4

            if (ps_version < 1.5 ) {
                $(document).on('change', 'input[name="id_carrier"]', function() {
                    $('.dhl-extra').hide();
                    
                    $dhl_extra = $(this).first().parents('tr').find('.dhl-extra');
                    $dhl_extra.show();
                    
                    $('#dhl-delivery-options').appendTo($dhl_extra).show();
                });

                $(document).on('change', 'body#order-opc [name="id_address_delivery"', function(e) {
                    $(document).ajaxSuccess(function() {
                        $('.opc-main-block').append($('#dhl-loader').clone());
                        $('#opc_account-overlay, #opc_delivery_methods-overlay, #opc_payment_methods-overlay').show();
                        location.reload();
                    });
                });
            }

            // Prestashop 1.5 and 1.6

            $(document).on('change', 'input.delivery_option_radio', function() {                
                $('.dhl-extra').hide();
                
                $dhl_extra = $(this).first().parents('.delivery_option').find('.dhl-extra');
                $dhl_extra.show();
                
                $('#dhl-delivery-options').appendTo($dhl_extra).show();
            });

            $('.delivery_options').css('position', 'relative').append($('#dhl-loader'));
            $('#carrierTable tbody').css('position', 'relative').append($('#dhl-loader'));
                    
            var startMap = function () {
                localGeocode( function() {
                    DHLParcelBeluxJS.setPoints(dhl_shops);

                    DHLParcelBeluxJS.init('map-canvas', dhl_shops, latitude, longitude);

                    google.maps.event.trigger(DHLParcelBeluxJS.map, "resize");
                    DHLParcelBeluxJS.updateMapMarkers();
                    if ( pos != false) {
                        DHLParcelBeluxJS.map.setCenter(pos);
                    }
                });
            };

            $(document).unbind('click.fb-start');
            $('#dhl-lightbox-button').fancybox({
                width           : (ps_version < 1.5 ? 860 : 900),
                height          : 600,
                padding         : 0,
                autoScale       : false,
                modal           : true,
                autoDimensions  : false,
                centerOnScroll  : true,
                showCloseButton : false,
                closeBtn        : false,
                type            : 'ajax',
                afterShow       : startMap,
                onComplete      : startMap
            });

            $(document).on('change', '.me-checkboxes', function(e) {
                if($('.me-checkboxes').filter(':checked').length > 0) {
                    $('.me-checkboxes').each(function(index, checkbox) {
                        if(!$(checkbox).is(':checked')) {
                            $(checkbox).attr('disabled', 'disabled');
                            $(checkbox).removeAttr('checked');
                            $(checkbox).parent().find('label').addClass('dhl-disabled');
                        } else {
                            $(checkbox).removeAttr('disabled');
                            $(checkbox).parent().find('label').removeClass('dhl-disabled');
                        }
                    });
                } else {
                    $('.me-checkboxes').removeAttr('disabled');
                    $('.me-checkboxes').removeAttr('checked');
                    $('label').removeClass('dhl-disabled');
                }
            });
        });
    </script>

    {* Display DHL delivery type *}

    <div id="dhl-loader" style="display: none" class="prestashop-1-{$ps_minor_version|escape:'htmlall':'UTF-8'}">
        <div class="loader-icon-wrapper">
            <div class="loader-icon"></div>
            <span>{l s='Loading' mod='dhlparcelbelux'} &hellip;</span>
        </div>
    </div>
    {if isset($dhl_carriers_indexes.home) && $dhl_carriers_indexes.home !== null && isset($display_by_country) && $display_by_country}
    <div id="dhl-home-extra" class="dhl-extra prestashop-1-{$ps_minor_version|escape:'htmlall':'UTF-8'}" style="display: none">
        {if $neighbour == true || $evening_delivery == true}
        <div class="inner">
            <div class="row">
                <div class="col-xs-12 col-sm-8 col-md-12">
                    {if $neighbour == true}
                    <p class="checkbox" style="margin-bottom: 10px">
                        <input type="checkbox" name="neighbour" value="1" />
                        <label for="neighbour">{l s='No neighbour delivery' mod='dhlparcelbelux'}</label>
                    </p>
                    {else}
                    <input type="hidden" name="neighbour" value="0" />
                    {/if}
                    {if $evening_delivery == true}
                    <p class="checkbox" style="margin-bottom: 10px">
                        <input type="checkbox" name="evening" value="1" class="me-checkboxes" />
                        <label for="evening">{l s='Evening delivery (Tuesday to Thursday)' mod='dhlparcelbelux'}</label>
                    </p>
                    {else}
                    <input type="hidden" name="evening" value="0" />
                    {/if}
                    {if $saturdays_delivery == true}
                    <p class="checkbox">
                        <input type="checkbox" name="saturdays" value="1" class="me-checkboxes" />
                        <label for="saturdays">{l s='Saturday delivery' mod='dhlparcelbelux'}</label>
                    </p>
                    {else}
                    <input type="hidden" name="saturdays" value="0" />
                    {/if}
                </div>
            </div>
        </div>
        {/if}
        <input type="hidden" value="{$country_iso_code|escape:'htmlall':'UTF-8'}" name="country-iso-code" />
    </div>
    {/if}

    {if isset($dhl_carriers_indexes.parcelshop) && $dhl_carriers_indexes.parcelshop !== null} 
    <div id="dhl-parcelshop-extra" class="dhl-extra row prestashop-1-{$ps_minor_version|escape:'htmlall':'UTF-8'}" style="display: none">
        <div class="col-xs-12 1-{$ps_minor_version|escape:'htmlall':'UTF-8'} {if $ps_minor_version == 4}col-sm-12{else}col-sm-8{/if}">
            <div class="result"></div>
            
            <a id="dhl-lightbox-button" data-fancybox-type="ajax" href="{$lightbox_url|escape:'htmlall':'UTF-8'} #lightbox-popin" class="fancybox-btn">
                <span>{l s='Choose a delivery point' mod='dhlparcelbelux'}</span>
            </a>
            
            <input type="hidden" name="dpb-shop-id" value="" />
            <input type="hidden" name="country-iso-code" value="" />
        </div>
    </div>
    {/if}
{else}
    <p class="error">{l s='There was an error with the DHL Parcelshop delivery module. Please contact your administrator' mod='dhlparcelbelux'}</p>
{/if}