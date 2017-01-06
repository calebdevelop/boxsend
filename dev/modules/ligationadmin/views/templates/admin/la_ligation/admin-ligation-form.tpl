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

<script type="text/javascript">
    var id_lang = {$id_lang|escape:'htmlall':'UTF-8'};
    var displayMode = '{$displayMode|escape:'htmlall':'UTF-8'}';
    var listArrayProducts = new Array();
    var zAjaxSearchSupplier = '../modules/ligationadmin/ajax.php';
    var jsonSubTypeTemplate = {Tools::jsonEncode($laSubTypeTemplates)};
</script>

<div style="display:none">
    <span id="messageNoEmail">{l s='Aucun email n\'a été entré alors que la case \"Envoyer un mail à la création du litige\" est coché. Dans ce cas : \"Aucun emails fournisseur n\'a été entré, voulez vous continuer sans envoyer de mail à la création ?' mod='ligationadmin'}</span>
    <span id="messageNoProducts">{l s='Aucun produit n\'a été sélectionné. Dans ce cas : "Aucun produit n\'a été renseigné pour ce litige, voulez­vous continuer ?' mod='ligationadmin'}</span>
</div>


<div class="modal fade" id="modalComfirmRevive">
    <form method="post" action="{$link->getAdminLink('AdminLaLigation')|escape:'htmlall':'UTF-8'}&id_la_ligation={$laLigation->id|escape:'htmlall':'UTF-8'}&action=resendMail">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">{l s='Confirmation' mod='ligationadmin'}</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <textarea name="revive_comment" id="revive_comment" class="textarea-autosize autoload_rte"></textarea>
                        <br/>
                        {l s='Would you like to resend mail ?' mod='ligationadmin'}
                    </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-info" data-dismiss="modal">{l s='No' mod='ligationadmin'}</button>
                    <button type="submit" class="btn btn-warning">{l s='No' mod='ligationadmin'}</button>
                </div>
            </div>
        </div>
    </form>
</div>


<div class="col-lg-12">
    <form id="la_ligation_form" class="defaultForm form-horizontal AdminLaLigation" novalidate action="{$link->getAdminLink('AdminLaLigation')|escape:'htmlall':'UTF-8'}" method="post" enctype="multipart/form-data">
        {if $displayMode == 'edit'}
            <select name="action_mode" class="hidden" id="action_mode">
                {foreach $tzActions as $zAction}
                    <option value="{$zAction|escape:'htmlall':'UTF-8'}">{$zAction|escape:'htmlall':'UTF-8'}</option>
                {/foreach}
            </select>
        {/if}
        <input type="hidden" name="id_la_ligation" value="{$laLigation->id|escape:'htmlall':'UTF-8'}"/>
        <input type="hidden" name="submitAddla_ligation" value="1" />
        <div class="panel" id="fieldset_0">
            <div class="panel-heading">
                <i class="icon-time"></i>{l s='Ligation' mod='ligationadmin'}
            </div>
            <div class="form-wrapper">

                <div class="form-group">
                    {if $displayMode=="edit"}
                        <label class="control-label col-lg-3 required">
                        <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="">
                            {l s='Ref' mod='ligationadmin'}
                        </span>
                        </label>
                        <div class="col-lg-4">
                            <input type="text" class="fixed-width-xl" disabled value="{$laLigation->reference|escape:'htmlall':'UTF-8'}">
                        </div>
                    {/if}
                </div>

                <div class="form-group">
                    <label class="control-label col-lg-3 required">
                        <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="">
                            {l s='Type' mod='ligationadmin'}
                        </span>
                    </label>
                    <div class="col-lg-4">
                        <select class="changeData" data-action-mode="type" name="id_la_type" required class="fixed-width-xl" id="id_la_type">
                            <option value="">-</option>
                            {foreach $laType_array as $item}
                                <option {if $laLigation->id_la_type == $item.id}selected{/if} value="{$item.id|escape:'htmlall':'UTF-8'}">{$item.name|escape:'htmlall':'UTF-8'}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-lg-3 required">
                        <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="">
                            {l s='Supplier' mod='ligationadmin'}
                        </span>
                    </label>
                    <div class="col-lg-4">
                        {if $displayMode == 'edit'}
                            <input type="hidden" required name="id_supplier" id="id_supplier" value="{$laLigation->id_supplier|escape:'htmlall':'UTF-8'}">
                            <input type="text" {$disableCss|escape:'htmlall':'UTF-8'} value="{$laLigation->getSupplierName()|escape:'htmlall':'UTF-8'}">
                        {else}
                            <input type="hidden" required name="id_supplier" id="id_supplier">
                            <input type="text" required id="inputSupplierAutocomplete"/>
                            <!--select name="id_supplier" {$disableCss|escape:'htmlall':'UTF-8'} required class="fixed-width-xl" id="id_supplier">
                            <option value="">-</option>
                            {foreach $supplier_array as $item}
                                <option {if $laLigation->id_supplier == $item.id}selected{/if} value="{$item.id|escape:'htmlall':'UTF-8'}">{$item.name|escape:'htmlall':'UTF-8'}</option>
                            {/foreach}
                        </select-->
                        {/if}
                    </div>
                </div>

                {if $displayMode == 'edit'}
                    <hr/>
                    <div class="form-group">
                        <label class="control-label col-lg-3">
                        <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="">
                            {l s='Cretead at' mod='ligationadmin'}
                        </span>
                        </label>
                        <div class="col-lg-4">
                            <input type="text" {$disableCss|escape:'htmlall':'UTF-8'} class="fixed-width-xl" value="{date('d/m/Y H:i',strtotime($laLigation->date_add))|escape:'htmlall':'UTF-8'}" />
                        </div>
                    </div>


                    <div class="form-group">
                        <label class="control-label col-lg-3">
                        <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="">
                            {l s='Resolution date' mod='ligationadmin'}
                        </span>
                        </label>
                        <div class="col-lg-4">
                            <input type="text" {$disableCss|escape:'htmlall':'UTF-8'} class="fixed-width-xl" value="{if $laLigation->isResolved()}{date('d/m/Y H:i',strtotime($laLigation->date_resolution))|escape:'htmlall':'UTF-8'}{/if}" />
                        </div>
                    </div>


                    <div class="form-group">
                        <label class="control-label col-lg-3">
                        <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="">
                            {l s='Employee' mod='ligationadmin'}
                        </span>
                        </label>
                        <div class="col-lg-4">
                            <input type="text" {$disableCss|escape:'htmlall':'UTF-8'} class="fixed-width-xl" value="{$laLigation->getEmployee()->firstname|escape:'htmlall':'UTF-8'}{$laLigation->getEmployee()->lastname|escape:'htmlall':'UTF-8'}"/>
                        </div>
                    </div>


                    <hr/>
                    <div class="form-group">
                        <label class="control-label col-lg-3">
                        </label>
                        <div class="col-lg-9">
                            <a class="btn btn-info btnr-etid" data-toggle="modal" href="#modalAddComment"><i class="icon icon-add"></i>{l s='Add comment' mod='ligationadmin'}</a>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-lg-3">
                        </label>
                        <div class="col-lg-9">
                            <a class="btn btn-success btnr-etid" data-toggle="modal" href="#modalComfirmRevive"><i class="icon icon-add"></i>{l s='Reminder' mod='ligationadmin'}</a>
                        </div>
                    </div>


                    <hr/>
                    <!-- Staut -->
                    <div class="form-group">
                        <label class="control-label col-lg-3 required">
                        <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="">
                            {l s='Status' mod='ligationadmin'}
                        </span>
                        </label>
                        <div class="col-lg-4">
                            <select name="id_la_status" data-action-mode="status" required class="fixed-width-xl changeData" id="id_la_status">
                                <option value="">-</option>
                                {foreach $status_array as $item}
                                    <option {if $laLigation->id_la_status == $item.id}selected{/if} value="{$item.id|escape:'htmlall':'UTF-8'}">{$item.name|escape:'htmlall':'UTF-8'}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label col-lg-3">
                        <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="">
                            {l s='Comment' mod='ligationadmin'}
                        </span>
                        </label>
                        <div class="col-lg-4">
                            <textarea name="status_comment" id="status_comment" class="textarea-autosize"></textarea>
                        </div>
                    </div>

                    <hr/>
                {/if}

                <div class="form-group">
                    <label class="control-label col-lg-3">
                        {l s='Supplier order reference' mod='ligationadmin'}
                    </label>
                    <div class="col-lg-9">
                        <input type="text" name="order_reference_supplier" class="fixed-width-xl" id="order_reference_supplier" value="{$laLigation->order_reference_supplier|escape:'htmlall':'UTF-8'}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-3">
                        {l s='Customer order reference' mod='ligationadmin'}
                    </label>
                    <div class="col-lg-9">
                        <input type="text" name="order_reference_customer" class="fixed-width-xl" id="order_reference_customer" value="{$laLigation->order_reference_customer|escape:'htmlall':'UTF-8'}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-3 required">
                        <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="">
                            {l s='Sub type' mod='ligationadmin'}
                        </span>
                    </label>
                    <div class="col-lg-4">
                        <select name="id_la_subtype"  class="changeData" data-action-mode="subtype" required class=" fixed-width-xl" id="id_la_subtype">
                            <option value="">-</option>
                            {foreach $laSubType_array as $item}
                                <option {if $laLigation->id_la_subtype == $item.id}selected{/if} value="{$item.id|escape:'htmlall':'UTF-8'}">{$item.name|escape:'htmlall':'UTF-8'}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-lg-3 required">
                        <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="">
                            {l s='Lang' mod='ligationadmin'}
                        </span>
                    </label>
                    <div class="col-lg-4">
                        <select name="id_la_lang"  class="changeData" required class=" fixed-width-xl" id="id_la_lang">
                            <option value="">-</option>
                            {foreach $laLangs as $item}
                                <option {if $laLigation->id_la_lang == $item.id_la_lang}selected{/if} value="{$item.id_la_lang|escape:'htmlall':'UTF-8'}">{$item.name|escape:'htmlall':'UTF-8'}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-lg-3">
                        <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="Invalid characters: &lt;&gt;;=#{}">
                            {l s='Mail' mod='ligationadmin'}
                        </span>
                    </label>
                    <div class="col-lg-9">
                        {if ($displayMode == 'edit')}
                            <div>
                                {assign var='mailContent' value=$laLigation->mail_content}
                                <div style="display:none" id="mail-content-show">
                                    {$mailContent|escape:'quotes':'UTF-8'}
                                </div>
                            </div>
                        {else}
                            <div class="form-group translatable-field">
                                <div class="col-lg-9">
                                    <textarea class="autoload_rte textarea-autosize" id="mail_content" required name="mail_content"></textarea>
                                </div>
                            </div>
                        {/if}
                    </div>
                </div>

                <hr/>

                <div class="form-group">
                    <label class="control-label col-lg-3 required">
                        <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="">
                            {l s='Products' mod='ligationadmin'}
                        </span>
                    </label>
                    <div class="col-lg-5 panel" style="max-height: 350px;overflow: auto;">
                        <table class="table table-striped">
                            <thead>

                                {if ($displayMode == "add")}
                                    <!--tr>
                                        <th></th>
                                        <th>{l s='Product' mod='ligationadmin'}</th>
                                        <th>{l s='Qte concerned' mod='ligationadmin'}</th>
                                        <th>{l s='Comment' mod='ligationadmin'}</th>
                                        <th></th>
                                    </tr-->

                                    <tr>
                                        <th></th>
                                        <th>{l s='Product' mod='ligationadmin'}</th>
                                    </tr>
                                {elseif ($displayMode =='edit')}
                                    <tr>
                                        <th></th>
                                        <th>{l s='Product' mod='ligationadmin'}</th>
                                        <th>{l s='Qte concerned' mod='ligationadmin'}</th>
                                        <th>{l s='Qte validated' mod='ligationadmin'}</th>
                                        <th>{l s='Qte resolved' mod='ligationadmin'}</th>
                                        <th>{l s='Comment' mod='ligationadmin'}</th>
                                        <!--th></th-->
                                    </tr>
                                {/if}

                            </thead>
                            <tbody id="product-litige-added">
                                {if ($displayMode == 'edit' && !empty($laProducts))}
                                    {assign var="iCount" value=0}
                                    {foreach $laProducts as $laProduct}
                                        <script type="text/javascript">
                                            listArrayProducts.push({$laProduct.id_product|escape:'htmlall':'UTF-8'});
                                        </script>
                                        <tr id="rowItempProductAdded-{$laProduct.id_product|escape:'htmlall':'UTF-8'}">
                                            <td><span class="hidden">{$iCount++|escape:'htmlall':'UTF-8'}</span><img class="rowImgP" src="{$link->getImageLink($laProduct.link_rewrite, $laProduct.id_image, 'small_default')|escape:'html':'UTF-8'}" alt="{if !empty($laProduct.legend)}{$laProduct.legend|escape:'html':'UTF-8'}{else}{$laProduct.name|escape:'html':'UTF-8'}{/if}" title="{if !empty($laProduct.legend)}{$laProduct.legend|escape:'html':'UTF-8'}{else}{$laProduct.name|escape:'html':'UTF-8'}{/if}"/></td>
                                            <td><input type="hidden" name="products[{$iCount|escape:'htmlall':'UTF-8'}][id]" value="{$laProduct.id_product|escape:'htmlall':'UTF-8'}">{$laProduct.name|escape:'htmlall':'UTF-8'}</td>
                                            <td><input type="number" class="form-control" {$disableCss|escape:'htmlall':'UTF-8'} name="products[{$iCount|escape:'htmlall':'UTF-8'}][quantity_concerned]" value="{$laProduct.quantity_concerned|escape:'htmlall':'UTF-8'}"/>
                                            <td><input type="number" class="form-control" name="products[{$iCount|escape:'htmlall':'UTF-8'}][quantity_validated]" value="{$laProduct.quantity_validated|escape:'htmlall':'UTF-8'}" max="{$laProduct.quantity_concerned|escape:'htmlall':'UTF-8'}" min="0"/>
                                            <td><input type="number" class="form-control" name="products[{$iCount|escape:'htmlall':'UTF-8'}][quantity_resolved]" value="{$laProduct.quantity_resolved|escape:'htmlall':'UTF-8'}" max="{$laProduct.quantity_concerned|escape:'htmlall':'UTF-8'}" min="0"/>
                                            <td><textarea name="products[{$iCount|escape:'htmlall':'UTF-8'}][comment]">{$laProduct.comment|escape:'htmlall':'UTF-8'}</textarea></td>
                                        </tr>
                                    {/foreach}
                                {/if}
                            </tbody>
                        </table>
                    </div>
                    <div class="col-lg-3 col-md-offset-1 panel" style="max-height: 350px;overflow: auto;">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th></th>
                                <th>{l s='Product' mod='ligationadmin'}</th>
                                <th>{l s='Action' mod='ligationadmin'}</th>
                            </tr>
                            </thead>
                            <tbody id="ligationatmin_products">
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label col-lg-3">
                        <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="Invalid characters: &lt;&gt;;=#{}">
                            {l s='Email address of the supplier' mod='ligationadmin'}
                        </span>
                    </label>
                    <div class="col-lg-9">
                        <input type="text" name="supplier_emails" id="supplier_emails" value="{if $laLigation->id}{implode(',',Tools::jsonDecode($laLigation->mail_addresses))|escape:'html':'UTF-8'}{/if}"/>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-3">
                        <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="{l s='Upload files from your computer.' mod='ligationadmin'}">
                            {l s='Attachment' mod='ligationadmin'}
                        </span>
                    </label>
                    <div class="col-lg-9">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-lg-5">
                                    <table class="table">
                                        <thead>
                                        <tr>
                                            <th>-</th>
                                            <th>{l s='Name' mod='ligationadmin'}</th>
                                            <th></th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                            {assign var="iCountFile" value=1}
                                            {if $displayMode == 'edit'}
                                                {foreach $laLigation->getFiles() as $mlaFile}
                                                    <tr>
                                                        <td>{$iCountFile++|escape:'htmlall':'UTF-8'}</td>
                                                        <td><a class="fancybox" target="_blank" href="../modules/{strtolower(get_class($currController->module)|escape:'htmlall':'UTF-8')}/files/{$mlaFile.id_la_ligation|escape:'htmlall':'UTF-8'}/{$mlaFile.name|escape:'htmlall':'UTF-8'}">{$mlaFile.original_name|escape:'htmlall':'UTF-8'}</a></td>
                                                        <td><a class="btn btn-default ajax-remove-file" data-id-file="{$mlaFile['id_la_file']|escape:'htmlall':'UTF-8'}" href="#"><i class="icon icon-remove"></i></a></td>
                                                    </tr>
                                                {/foreach}
                                            {/if}

                                            {for $i=$iCountFile;$i<4;$i++}
                                                <tr>
                                                    <td></td>
                                                    <td colspan="2"><input type="file" name="attachment[]" /></td>
                                                </tr>
                                            {/for}
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-lg-3">
                        {l s='Send mail after creating the dispute' mod='ligationadmin'}
                    </label>
                    <div class="col-lg-9">
                        {if $displayMode == 'add'}
                            <span class="switch prestashop-switch fixed-width-lg">
                                <input type="radio" name="send_mail" id="send_mail_on" value="1" checked="checked"/>
                                <label for="send_mail_on">{l s='Yes' mod='ligationadmin'}</label>
                                <input type="radio" name="send_mail" id="send_mail_off" value="0"/>
                                <label for="send_mail_off">{l s='No' mod='ligationadmin'}</label>
                                <a class="slide-button btn"></a>
                            </span>
                        {else}
                            {if $laLigation->send_mail}
                                <span class="label label-info col-lg-1" style="padding: 5px;">{l s='Yes' mod='ligationadmin'}</span>
                            {else}
                                <span class="label label-warning col-lg-1" style="padding: 5px;">{l s='No' mod='ligationadmin'}</span>
                            {/if}
                        {/if}
                    </div>
                </div>

                {if ($displayMode == 'edit') }
                    <div class="modal fade" id="modalConfirmChange">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title">{l s='Confirmation' mod='ligationadmin'}</h4>
                                </div>
                                <div class="modal-body">
                                    <p>
                                        {l s='Do you realy want to change this information ?' mod='ligationadmin'}
                                    </p>
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-succes" data-dismiss="modal">{l s='No' mod='ligationadmin'}</button>
                                    <button type="submit" class="btn btn-warning">{l s='Yes' mod='ligationadmin'}</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal fade" id="modalAddComment">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                    <h4 class="modal-title">{l s='Details' mod='ligationadmin'}</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label class="control-label col-lg-3">
                                            <span class="label-tooltip" data-toggle="tooltip" data-html="true" title="">
                                            {l s='Comment' mod='ligationadmin'}
                                            </span>
                                        </label>
                                        <div class="col-lg-9">
                                            <textarea name="comment" required col="9" id="comment" class="textarea-autosize"></textarea>
                                        </div>
                                    </div>
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-info" data-dismiss="modal">{l s='Close' mod='ligationadmin'}</button>
                                    <button type="submit" onclick="$('#action_mode').val('comment');" class="btn btn-warning">{l s='Save' mod='ligationadmin'}</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr/>
                    {include file='./admin-ligation-history.tpl'}
                {/if}

            </div>
            <!-- /.form-wrapper -->
            <div class="panel-footer">
                <button type="submit" value="1" id="la_ligation_form_submit_btn" name="submitAddla_ligation" class="btn btn-default pull-right">
                    <i class="process-icon-save"></i> {l s='Save' mod='ligationadmin'}
                </button>
                <a href="{$link->getAdminLink('AdminLaLigation')|escape:'htmlall':'UTF-8'}" class="btn btn-default" onclick="window.history.back();">
                    <i class="process-icon-cancel"></i> {l s='Cancel' mod='ligationadmin'}
                </a>
            </div>
        </div>
    </form>
</div>

{literal}
    <script type="text/javascript">
        function removeRowLitigation( idProduct ){
            $("#rowItempProductAdded-" + idProduct).remove();
            $("#rowItemProduct-" + idProduct).show();
        }
        $(document).ready(function(){
            $("#la_ligation_form").on("submit",function(e){
                if( $(this).valid() ){
                    if( !$("#supplier_emails").val() && $("#send_mail_on").is(":checked") ){
                        $.fancybox($("#messageNoEmail").html());
                        e.preventDefault();
                    }
                    if( !$("#product-litige-added tr").length ){
                        $.fancybox($("#messageNoProducts").html());
                        e.preventDefault();
                    }
                }
            });
            $("a.ajax-remove-file").on("click",function(e){
                e.preventDefault();
                var $oCurr = $(this);
                if( confirm('Vous voulez vraiment faire cette action ?') ){
                    $.ajax({
                        url : '../modules/ligationadmin/ajax.php',
                        type : 'post',
                        dataType : 'json',
                        data : {
                            'action' : 'files',
                            'file_id' : parseInt($oCurr.attr('data-id-file')),
                            'id_la_ligation' : $("[name=id_la_ligation").val()
                        },
                        success : function( dataJson ){
                            if( dataJson.message == "success" ){
                                $oCurr.closest('tr').remove();
                            }
                        }
                    });
                }
            });

            function setMailContent(id_la_subtype,id_la_lang){
                if( id_la_subtype && id_la_lang ){
                    $.each(jsonSubTypeTemplate,function(i,oTemplate){
                        if( oTemplate.id_la_lang == id_la_lang && oTemplate.id_la_subtype == id_la_subtype ){
                            tinyMCE.get('mail_content').setContent(oTemplate.content);
                        }
                    })
                }
            }

            $('#id_la_subtype,#id_la_lang').on("change keyup",function(){
                setMailContent($('#id_la_subtype').val(),$('#id_la_lang').val());
            });
        });
    </script>
{/literal}

<script type="text/javascript">
    var ad = "{$ad|escape:'htmlall':'UTF-8'}";
    var iso = "{$iso_tiny_mce|escape:'htmlall':'UTF-8'}";
    $(document).ready(function(){
        tinySetup({
            editor_selector :"autoload_rte"
        });
    });
</script>