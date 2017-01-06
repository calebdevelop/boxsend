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

<hr/>
<div class="row">
    <div class="col-lg-3"></div>
    <div class="col-lg-9">
        <h3>
            {l s='Historique' mod='ligationadmin'}
        </h3>
        <div class="div-table-historique">
            <table class="table">
                <thead>
                <tr>
                    <th>{l s='Date' mod='ligationadmin'}</th>
                    <th>{l s='Action' mod='ligationadmin'}</th>
                    <th>{l s='Employee' mod='ligationadmin'}</th>
                    <th>{l s='Type' mod='ligationadmin'}</th>
                    <th>{l s='Subtype' mod='ligationadmin'}</th>
                    <th>{l s='Mail addresses' mod='ligationadmin'}</th>
                    <th>{l s='Status' mod='ligationadmin'}</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                {if !empty($laHistories)}
                    {foreach $laHistories as $laHistory}
                        {assign var='historyProducts' value=LaHistory::getHistoryProducts($laHistory['id_la_history'],$id_lang)}
                        <tr>
                            <!--td>{$laHistory.id_la_history|escape:'htmlall':'UTF-8'}</td-->
                            <td>{date('d/m/Y H:i',strtotime($laHistory.date_add))|escape:'htmlall':'UTF-8'}</td>
                            <td>
                                {if $laHistory.mode == 'create'}
                                    <span class="label label-success">{l s='Creation' mod='ligationadmin'}</span>
                                {elseif $laHistory.mode == 'comment'}
                                    <span class="label label-success">{l s='Comment' mod='ligationadmin'}</span>
                                {elseif $laHistory.mode == 'products'}
                                    <span class="label label-success">{l s='Products' mod='ligationadmin'}</span>
                                {elseif $laHistory.mode == 'status'}
                                    <span class="label label-success">{l s='Status' mod='ligationadmin'}</span>
                                {elseif $laHistory.mode == 'type'}
                                    <span class="label label-success">{l s='Type' mod='ligationadmin'}</span>
                                {elseif $laHistory.mode == 'subttype'}
                                    <span class="label label-success">{l s='Subt type' mod='ligationadmin'}</span>
                                {elseif $laHistory.mode == 'revive'}
                                    <span class="label label-success">{l s='Revive' mod='ligationadmin'}</span>
                                {elseif $laHistory.mode == 'edit'}
                                    <span class="label label-info">{l s='Modification' mod='ligationadmin'}</span>
                                {/if}
                            </td>
                            <td>{$laHistory.employee|escape:'htmlall':'UTF-8'}</td>
                            <td>{$laHistory.la_type|escape:'htmlall':'UTF-8'}</td>
                            <td>{$laHistory.la_subtype|escape:'htmlall':'UTF-8'}</td>

                            <td>
                                <a href="javascript:void(0)" class="popover-click btn btn-default" data-trigger="hover" data-toggle="tooltip" data-html="true" data-content='<table><tr><td><span class="label label-info">{implode('</span></td></tr> <tr><td><span class="label label-info">',Tools::jsonDecode($laHistory.mail_addresses))|escape:'quotes':'UTF-8'}</span></td></tr></table>'>
                                    <i class='icon icon-envelope'></i>
                                </a>
                            </td>
                            <td><span class="badge" style="background-color:{$laHistory.status_color|escape:'htmlall':'UTF-8'}">{$laHistory.la_status|escape:'htmlall':'UTF-8'}</span></td>
                            <td>
                                <div class="modal fade" id="modalHistory-{$laHistory.id_la_history|escape:'htmlall':'UTF-8'}">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                <h4 class="modal-title">{l s='Details' mod='ligationadmin'}</h4>
                                            </div>
                                            <div class="modal-body">
                                                <div class="row">
                                                    <h5>{l s='Comment' mod='ligationadmin'}</h5>
                                                    <div>
                                                        {if $laHistory.comment}{$laHistory.comment|escape:'htmlall':'UTF-8'}{else}{l s='(Empty)' mod='ligationadmin'}{/if}
                                                    </div>
                                                </div>
                                                <hr/>
                                                <div class="row">
                                                    <h5>{l s='Status comment' mod='ligationadmin'}</h5>
                                                    <div>
                                                        {if $laHistory.comment_status}{$laHistory.comment_status|escape:'htmlall':'UTF-8'}{else}{l s='(Empty)' mod='ligationadmin'}{/if}
                                                    </div>
                                                </div>

                                                <hr/>
                                                <div class="row">
                                                    <table class="table">
                                                        <thead>
                                                        <tr>
                                                            <th>{l s='Product' mod='ligationadmin'}</th>
                                                            <th>{l s='Comment' mod='ligationadmin'}</th>
                                                            <th>{l s='Qte concerned' mod='ligationadmin'}</th>
                                                            <th>{l s='Qte validated' mod='ligationadmin'}</th>
                                                            <th>{l s='Qte resolved' mod='ligationadmin'}</th>
                                                            <!--th></th-->
                                                        </tr>
                                                        </thead>
                                                        <tbody>
                                                        {foreach $historyProducts as $historyProduct}
                                                            <tr>
                                                                <td>{$historyProduct.name|escape:'htmlall':'UTF-8'}</td>
                                                                <td>{$historyProduct.comment|escape:'htmlall':'UTF-8'}</td>
                                                                <td>{$historyProduct.quantity_concerned|escape:'htmlall':'UTF-8'}</td>
                                                                <td>{$historyProduct.quantity_validated|escape:'htmlall':'UTF-8'}</td>
                                                                <td>{$historyProduct.quantity_resolved|escape:'htmlall':'UTF-8'}</td>
                                                            </tr>
                                                        {/foreach}
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">{l s='Close' mod='ligationadmin'}</button>
                                            </div>
                                        </div><!-- /.modal-content -->
                                    </div><!-- /.modal-dialog -->
                                </div><!-- /.modal -->

                                <a href="#modalHistory-{$laHistory.id_la_history|escape:'htmlall':'UTF-8'}" data-toggle="modal" class="btn btn-default"><span class="icon icon-eye"></span></a>
                            </td>
                        </tr>
                    {/foreach}
                {else}
                    <tr>
                        <td colspan="8">{l s='(Empty)' mod='ligationadmin'}</td>
                    </tr>
                {/if}
                </tbody>
            </table>
        </div>
    </div>
</div>