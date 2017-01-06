{**
* Ligation Admin
*
* @category  Module
* @author    Jean Karl Arno <contact@jk-creation.fr>
* @support   Jean Karl Arno <contact@silbersaiten.de>
* @copyright 2017 silbersaiten
* @version   1.0.0
* @link      http://www.jk-creation.fr/
* @license   See joined file licence.txt
*}

<div class="col-lg-12">
    <form id="la_subtype_form" class="defaultForm form-horizontal AdminlaSubtype" novalidate action="{$link->getAdminLink('AdminLaSubtype')|escape:'htmlall':'UTF-8'}" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id_la_subtype" value="{$obj->id|escape:'htmlall':'UTF-8'}"/>
        <input type="hidden" name="submitAddla_subtype" value="1" />
        <div class="panel" id="fieldset_0">
            <div class="panel-heading">
                <i class="icon-time"></i>{l s='Ligation' mod='ligationadmin'}
            </div>
            <div class="form-wrapper">
                <div class="form-group">
                    <label class="control-label col-lg-3 required">
                    <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="">
                        {l s='Name' mod='ligationadmin'}
                    </span>
                    </label>
                    <div class="col-lg-4">
                        <input type="text" class="fixed-width-xl" name="name_{$id_lang|escape:'htmlall':'UTF-8'}"  value="{$obj->name[$id_lang]|escape:'htmlall':'UTF-8'}">
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-lg-1"><span class="pull-right"></span></div>
                    <label for="active" class="control-label col-lg-2">
			        <span>
				        {l s='Active' mod='ligationadmin'}
			        </span>
                    </label>
                    <div class="col-lg-8">
                    <span class="switch prestashop-switch fixed-width-lg">
                        <input type="radio" name="active" id="active_on" value="1" {if $obj->active}checked{/if} required/>
                        <label  for="active_on">{l s='Yes' mod='ligationadmin'}</label>

                        <input type="radio" name="active" id="active_off" value="0" {if !$obj->active}checked{/if} required/>
                        <label  for="active_off">{l s='No' mod='ligationadmin'}</label>
                        <a class="slide-button btn"></a>
                    </span>
                    </div>
                </div>

                <hr/>
                <div class="form-group">
                    <div class="col-lg-3">
                    </div>
                    <div class="col-lg-8">
                        {l s='List of available variables' mod='ligationadmin'}
                        <ul>
                            <li>{literal}{DISPUTEID}{/literal} : {l s='Will be replaced by the dispute identifier' mod='ligationadmin'}</li>
                            <li>{literal}{DATE}{/literal} : {l s='Will be replaced by the date of initiation of the original dispute' mod='ligationadmin'}</li>
                            <li>{literal}{ORIGINAL}{/literal}  : {l s='Copy of original dispute' mod='ligationadmin'}</li>
                            <li>{literal}{NOTE}{/literal}  : {l s='Related Supplier Order Reference (If filled)' mod='ligationadmin'} </li>
                        </ul>
                    </div>
                </div>

                <div class="form-group">
                    <label for="active" class="control-label col-lg-3"><span>{l s='Template' mod='ligationadmin'}</span></label>
                    <div class="col-lg-8">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>{l s='Lang' mod='ligationadmin'}</th>
                                    <th>{l s='Content' mod='ligationadmin'}</th>
                                    <th>{l s='Active' mod='ligationadmin'}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {foreach $laLangs as $laLang}
                                    <tr>
                                        <td>{$laLang.name|escape:'htmlall':'UTF-8'}</td>
                                        <td>
                                            <textarea class="autoload_rte textarea-autosize" name="mail_content[{$laLang.id_la_lang|escape:'htmlall':'UTF-8'}]" id="mail_content[{$laLang.id_la_lang|escape:'htmlall':'UTF-8'}]">{if !empty($listTemplate)}{foreach $listTemplate as $templateTemp}{if $templateTemp.id_la_lang == $laLang.id_la_lang}{$templateTemp.content|escape:'htmlall':'UTF-8'}{/if}{/foreach}{/if}</textarea>
                                        </td>
                                        <td><input type="checkbox" value="1" name="activeContent[{$laLang.id_la_lang|escape:'htmlall':'UTF-8'}]" {if !empty($listTemplate)}{foreach $listTemplate as $templateTemp}{if $templateTemp.id_la_lang == $laLang.id_la_lang && $templateTemp.active}checked{/if}{/foreach}{/if}/></td>
                                    </tr>
                                {/foreach}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- /.form-wrapper -->
            <div class="panel-footer">
                <button type="submit" value="1" id="la_subtype_form_submit_btn" name="submitAddla_subtype" class="btn btn-default pull-right">
                    <i class="process-icon-save"></i> {l s='Save' mod='ligationadmin'}
                </button>
                <a href="{$link->getAdminLink('AdminLaSubtype')|escape:'htmlall':'UTF-8'}" class="btn btn-default" onclick="window.history.back();">
                    <i class="process-icon-cancel"></i> {l s='Cancel' mod='ligationadmin'}
                </a>
            </div>
        </div>
    </form>
</div>

<script type="text/javascript">
    var ad = "{$ad|escape:'htmlall':'UTF-8'}";
    var iso = "{$iso_tiny_mce|escape:'htmlall':'UTF-8'}";
    $(document).ready(function(){
        tinySetup({
            editor_selector :"autoload_rte"
        });
    });
</script>