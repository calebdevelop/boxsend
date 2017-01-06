{*
* 2015 Stigmi.eu
*
* @author Stigmi.eu <www.stigmi.eu>
* @copyright 2015 Stigmi.eu
* @license http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
*}
<script type="text/javascript">
    if ( typeof google == 'undefined' ) {
        var script_tag = document.createElement('script');
        script_tag.setAttribute('type','text/javascript');
        script_tag.setAttribute('src','{$maps_url|escape:'htmlall':'UTF-8'}&callback=gmLoadedCallback');
        (document.getElementsByTagName('head')[0] || document.documentElement).appendChild(script_tag);
    }
</script>
<div id="lightbox-popin" class="prestashop-1-{$ps_minor_version|escape:'htmlall':'UTF-8'}">
    <div id="map-canvas-overlay">
        <div class="loader-icon-wrapper">
            <div class="loader-icon"></div>
            <span>{l s='Loading' mod='dhlparcelbelux'} &hellip;</span>
        </div>
    </div>
    <div class="row dhl-container">
        <div class="button-red pull-right select-shop">
            <a>{l s='Select this shop' mod='dhlparcelbelux'} &rarr;</a>
        </div>
        <div class="col-md-12 header">
            <div class="logo pull-left">
                <a href="#">{l s='Please select your DHL Parcelshop' mod='dhlparcelbelux'}</a>
            </div>
            <div class="close-window dhl-close-window pull-right" id="close">&times;</div>
        </div>
        <div class="col-md-7">
            <div class="row">
                <div class="col-md-12 search-shops">
                    <p class="hidden-xs hidden-sm">{l s='Use this tool to search and find your DHL Parcelshop' mod='dhlparcelbelux'}</p>
                    <div class="search-form">
                        <p>
                            <label>{l s='Find a store near this address' mod='dhlparcelbelux'} : </label>
                            <input type="text" name="dhl-finder-address" value="">
                            <input type="submit" name="dhl-finder-submit" id="submit-postal" value="{l s='Find' mod='dhlparcelbelux'}">
                        </p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 dhl-spacer main-spacer"></div>
                <div class="col-md-6 shop-list">
                    <div class="scroll-region other-items">
                        <div class="col-md-12 shop-list-item shop-list-item-template">
                            <span data-field="item-shopname" class="title"></span><br />
                            <span data-field="item-address"></span><br />
                            <span data-field="item-postal"></span>&nbsp;
                            <span data-field="item-city"></span>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 selected-shop hidden hidden-xs hidden-sm">
                    <div>
                        <div class="shop-address">
                            <h2 data-field="item-shopname"></h2>
                            <span data-field="item-address"></span><br />
                            <span data-field="item-postal"></span> <span data-field="item-city"></span><br />
                            <div class="clear"></div>
                        </div>
                        <div class="dhl-spacer"><hr></div>
                        <div class="times">
                            <h3>{l s='Opening times' mod='dhlparcelbelux'}</h3>
                            <div class="openhours">
                                <div>{l s='Monday' mod='dhlparcelbelux'} : <span class="time" data-field="hours-mo"></span></div>
                                <div>{l s='Tuesday' mod='dhlparcelbelux'} : <span class="time" data-field="hours-tu"></span></div>
                                <div>{l s='Wednesday' mod='dhlparcelbelux'} : <span class="time" data-field="hours-we"></span></div>
                                <div>{l s='Thursday' mod='dhlparcelbelux'} : <span class="time" data-field="hours-th"></span></div>
                                <div>{l s='Friday' mod='dhlparcelbelux'} : <span class="time" data-field="hours-fr"></span></div>
                                <div>{l s='Saturday' mod='dhlparcelbelux'} : <span class="time" data-field="hours-sa"></span></div>
                                <div>{l s='Sunday' mod='dhlparcelbelux'} : <span class="time" data-field="hours-su"></span></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-5 hidden-xs">
            <div class="row" {if $ps_minor_version != 5}style="margin-bottom: 40px"{/if}>
                <div id="map-canvas-outer">
                    <div id="map-canvas" class="col-lg-8 col-md-8">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>