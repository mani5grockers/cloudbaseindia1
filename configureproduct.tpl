{include file="orderforms/Redcheap_Professional/common.tpl"}

<script>
var _localLang = {
    'addToCart': '{$LANG.orderForm.addToCart|escape}',
    'addedToCartRemove': '{$LANG.orderForm.addedToCartRemove|escape}'
}
</script>

<div id="order-standard_cart">

    <div class="row">
        <div class="cart-sidebar">
            {include file="orderforms/Redcheap_Professional/sidebar-categories.tpl"}
        </div>
        <div class="cart-body">
            
            <div class="header-lined">
                <h2 class="font-size-22">{$LANG.orderconfigure}</h2>
            </div>

            {include file="orderforms/Redcheap_Professional/sidebar-categories-collapsed.tpl"}

            <form id="frmConfigureProduct">
                <input type="hidden" name="configure" value="true" />
                <input type="hidden" name="i" value="{$i}" />

                <div class="row">
                    <div class="secondary-cart-body">

                        <p>{$LANG.orderForm.configureDesiredOptions}</p>

                        <div class="product-info">
                            <p class="product-title">{$productinfo.name}</p>
                            <p>{$productinfo.description}</p>
                        </div>

                        <div class="alert alert-danger w-hidden" role="alert" id="containerProductValidationErrors">
                            <p>{$LANG.orderForm.correctErrors}:</p>
                            <ul id="containerProductValidationErrorsList"></ul>
                        </div>

{if $pricing.type eq "recurring"}
    <div class="field-container">
        <div class="form-group billing-cycle-grid-wrap">
            <label for="inputBillingcycle">{$LANG.cartchoosecycle}</label>

            <select
                name="billingcycle"
                id="inputBillingcycle"
                class="form-control select-inline custom-select billing-cycle-hidden"
                onchange="updateConfigurableOptions({$i}, this.value); return false"
            >
                {if $pricing.monthly}
                    <option value="monthly"{if $billingcycle eq "monthly"} selected{/if}>{$pricing.monthly}</option>
                {/if}
                {if $pricing.quarterly}
                    <option value="quarterly"{if $billingcycle eq "quarterly"} selected{/if}>{$pricing.quarterly}</option>
                {/if}
                {if $pricing.semiannually}
                    <option value="semiannually"{if $billingcycle eq "semiannually"} selected{/if}>{$pricing.semiannually}</option>
                {/if}
                {if $pricing.annually}
                    <option value="annually"{if $billingcycle eq "annually"} selected{/if}>{$pricing.annually}</option>
                {/if}
                {if $pricing.biennially}
                    <option value="biennially"{if $billingcycle eq "biennially"} selected{/if}>{$pricing.biennially}</option>
                {/if}
                {if $pricing.triennially}
                    <option value="triennially"{if $billingcycle eq "triennially"} selected{/if}>{$pricing.triennially}</option>
                {/if}
            </select>

            <div class="billing-cycle-grid" id="billingCycleGrid">
                {if $pricing.monthly}
                    <div class="billing-cycle-card{if $billingcycle eq 'monthly'} active{/if}" data-value="monthly">
                        <span class="billing-cycle-title">Monthly</span>
                        <span class="billing-cycle-price">{$pricing.monthly}</span>
                    </div>
                {/if}

                {if $pricing.quarterly}
                    <div class="billing-cycle-card{if $billingcycle eq 'quarterly'} active{/if}" data-value="quarterly">
                        <span class="billing-cycle-title">Quarterly</span>
                        <span class="billing-cycle-price">{$pricing.quarterly}</span>
                    </div>
                {/if}

                {if $pricing.semiannually}
                    <div class="billing-cycle-card{if $billingcycle eq 'semiannually'} active{/if}" data-value="semiannually">
                        <span class="billing-cycle-title">Semi-Annually</span>
                        <span class="billing-cycle-price">{$pricing.semiannually}</span>
                    </div>
                {/if}

                {if $pricing.annually}
                    <div class="billing-cycle-card{if $billingcycle eq 'annually'} active{/if}" data-value="annually">
                        <span class="billing-cycle-title">Annually</span>
                        <span class="billing-cycle-price">{$pricing.annually}</span>
                    </div>
                {/if}

                {if $pricing.biennially}
                    <div class="billing-cycle-card{if $billingcycle eq 'biennially'} active{/if}" data-value="biennially">
                        <span class="billing-cycle-title">Biennially</span>
                        <span class="billing-cycle-price">{$pricing.biennially}</span>
                    </div>
                {/if}

                {if $pricing.triennially}
                    <div class="billing-cycle-card{if $billingcycle eq 'triennially'} active{/if}" data-value="triennially">
                        <span class="billing-cycle-title">Triennially</span>
                        <span class="billing-cycle-price">{$pricing.triennially}</span>
                    </div>
                {/if}
            </div>
        </div>
    </div>

    <style>
        .billing-cycle-hidden {
            display: none !important;
        }
       
        .billing-cycle-card {
            transition: all 0.25s ease;
       }
        .billing-cycle-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(170px, 1fr));
            gap: 14px;
            margin-top: 12px;
        }

        .billing-cycle-card {
            position: relative;
            display: flex;
            flex-direction: column;
            gap: 6px;
            padding: 16px 18px;
            border-radius: 14px;
            border: 1px solid #e5e7eb;
            background: #fff;
            cursor: pointer;
            transition: all .25s ease;
            box-shadow: 0 6px 18px rgba(15, 23, 42, 0.06);
        }

        .billing-cycle-card:hover {
            transform: translateY(-2px);
            border-color: #6366f1;
            box-shadow: 0 10px 24px rgba(99, 102, 241, 0.16);
        }

        .billing-cycle-card.active {
            border-color: #6366f1;
            background: linear-gradient(135deg, #eef2ff 0%, #f5f3ff 100%);
            box-shadow: 0 10px 28px rgba(99, 102, 241, 0.18);
        }

        .billing-cycle-card.active::after {
            content: "✓";
            position: absolute;
            top: 10px;
            right: 12px;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            background: #6366f1;
            color: #fff;
            font-size: 13px;
            line-height: 24px;
            text-align: center;
            font-weight: 700;
        }

        .billing-cycle-title {
            font-size: 14px;
            font-weight: 700;
            color: #111827;
        }

        .billing-cycle-price {
            font-size: 13px;
            color: #4b5563;
            word-break: break-word;
        }

        @media (max-width: 575px) {
            .billing-cycle-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>

<script>
jQuery(document).ready(function($){

    $(document).on('click', '.billing-cycle-card', function(){

        var cycle = $(this).attr('data-value');
        var select = document.getElementById('inputBillingcycle');

        // UI active state
        $('.billing-cycle-card').removeClass('active');
        $(this).addClass('active');

        // set value
        select.value = cycle;

        // 🔥 IMPORTANT (WHMCS functions)
        if (typeof updateConfigurableOptions === "function") {
            updateConfigurableOptions({$i}, cycle);
        }

        if (typeof recalctotals === "function") {
            recalctotals();
        }

    });

});
</script>
{/if}

                        {if count($metrics) > 0}
                            <div class="sub-heading">
                                <span class="primary-bg-color">{$LANG.metrics.title}</span>
                            </div>

                            <p>{$LANG.metrics.explanation}</p>

                            <ul>
                                {foreach $metrics as $metric}
                                    <li>
                                        {$metric.displayName}
                                        -
                                        {if count($metric.pricing) > 1}
                                            {$LANG.metrics.startingFrom} {$metric.lowestPrice} / {if $metric.unitName}{$metric.unitName}{else}{$LANG.metrics.unit}{/if}
                                            <button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#modalMetricPricing-{$metric.systemName}">
                                                {$LANG.metrics.viewPricing}
                                            </button>
                                        {elseif count($metric.pricing) == 1}
                                            {$metric.lowestPrice} / {if $metric.unitName}{$metric.unitName}{else}{$LANG.metrics.unit}{/if}
                                            {if $metric.includedQuantity > 0} ({$metric.includedQuantity} {$LANG.metrics.includedNotCounted}){/if}
                                        {/if}
                                        {include file="$template/usagebillingpricing.tpl"}
                                    </li>
                                {/foreach}
                            </ul>

                            <br>
                        {/if}

                        {if $productinfo.type eq "server"}
                            <div class="sub-heading">
                                <span class="primary-bg-color">{$LANG.cartconfigserver}</span>
                            </div>

                            <div class="field-container">

                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputHostname">{$LANG.serverhostname}</label>
                                            <input type="text" name="hostname" class="form-control" id="inputHostname" value="{$server.hostname}" placeholder="servername.example.com">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputRootpw">{$LANG.serverrootpw}</label>
                                            <input type="password" name="rootpw" class="form-control" id="inputRootpw" value="{$server.rootpw}">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputNs1prefix">{$LANG.serverns1prefix}</label>
                                            <input type="text" name="ns1prefix" class="form-control" id="inputNs1prefix" value="{$server.ns1prefix}" placeholder="ns1">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputNs2prefix">{$LANG.serverns2prefix}</label>
                                            <input type="text" name="ns2prefix" class="form-control" id="inputNs2prefix" value="{$server.ns2prefix}" placeholder="ns2">
                                        </div>
                                    </div>
                                </div>

                            </div>
                        {/if}

                        {if $configurableoptions}
                            <div class="sub-heading">
                                <span class="primary-bg-color">{$LANG.orderconfigpackage}</span>
                            </div>
                            <div class="product-configurable-options" id="productConfigurableOptions">
                                <div class="row">
                                    {foreach $configurableoptions as $num => $configoption}
                                    {if $configoption.optiontype eq 1}
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputConfigOption{$configoption.id}">{$configoption.optionname}</label>
                                                <select name="configoption[{$configoption.id}]" id="inputConfigOption{$configoption.id}" class="form-control">
                                                    {foreach key=num2 item=options from=$configoption.options}
                                                        <option value="{$options.id}"{if $configoption.selectedvalue eq $options.id} selected="selected"{/if}>
                                                            {$options.name}
                                                        </option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                        </div>
                                    {elseif $configoption.optiontype eq 2}
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputConfigOption{$configoption.id}">{$configoption.optionname}</label>
                                                {foreach key=num2 item=options from=$configoption.options}
                                                    <br />
                                                    <label>
                                                        <input type="radio" name="configoption[{$configoption.id}]" value="{$options.id}"{if $configoption.selectedvalue eq $options.id} checked="checked"{/if} />
                                                        {if $options.name}
                                                            {$options.name}
                                                        {else}
                                                            {$LANG.enable}
                                                        {/if}
                                                    </label>
                                                {/foreach}
                                            </div>
                                        </div>
                                    {elseif $configoption.optiontype eq 3}
                                        <div class="col-sm-6">
                                            <div class="form-group">
                                                <label for="inputConfigOption{$configoption.id}">{$configoption.optionname}</label>
                                                <br />
                                                <label>
                                                    <input type="checkbox" name="configoption[{$configoption.id}]" id="inputConfigOption{$configoption.id}" value="1"{if $configoption.selectedqty} checked{/if} />
                                                    {if $configoption.options.0.name}
                                                        {$configoption.options.0.name}
                                                    {else}
                                                        {$LANG.enable}
                                                    {/if}
                                                </label>
                                            </div>
                                        </div>
                                    {elseif $configoption.optiontype eq 4}
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label for="inputConfigOption{$configoption.id}">{$configoption.optionname}</label>
                                                {if $configoption.qtymaximum}
                                                {if !$rangesliderincluded}
                                                    <script type="text/javascript" src="{$BASE_PATH_JS}/ion.rangeSlider.min.js"></script>
                                                <link href="{$BASE_PATH_CSS}/ion.rangeSlider.css" rel="stylesheet">
                                                <link href="{$BASE_PATH_CSS}/ion.rangeSlider.skinModern.css" rel="stylesheet">
                                                    {assign var='rangesliderincluded' value=true}
                                                {/if}
                                                    <input type="text" name="configoption[{$configoption.id}]" value="{if $configoption.selectedqty}{$configoption.selectedqty}{else}{$configoption.qtyminimum}{/if}" id="inputConfigOption{$configoption.id}" class="form-control" />
                                                    <script>
                                                        var sliderTimeoutId = null;
                                                        var sliderRangeDifference = {$configoption.qtymaximum} - {$configoption.qtyminimum};
                                                        // The largest size that looks nice on most screens.
                                                        var sliderStepThreshold = 25;
                                                        // Check if there are too many to display individually.
                                                        var setLargerMarkers = sliderRangeDifference > sliderStepThreshold;

                                                        jQuery("#inputConfigOption{$configoption.id}").ionRangeSlider({
                                                            min: {$configoption.qtyminimum},
                                                            max: {$configoption.qtymaximum},
                                                            grid: true,
                                                            grid_snap: setLargerMarkers ? false : true,
                                                            onChange: function() {
                                                                if (sliderTimeoutId) {
                                                                    clearTimeout(sliderTimeoutId);
                                                                }

                                                                sliderTimeoutId = setTimeout(function() {
                                                                    sliderTimeoutId = null;
                                                                    recalctotals();
                                                                }, 250);
                                                            }
                                                        });
                                                    </script>
                                                {else}
                                                    <div>
                                                        <input type="number" name="configoption[{$configoption.id}]" value="{if $configoption.selectedqty}{$configoption.selectedqty}{else}{$configoption.qtyminimum}{/if}" id="inputConfigOption{$configoption.id}" min="{$configoption.qtyminimum}" onchange="recalctotals()" onkeyup="recalctotals()" class="form-control form-control-qty" />
                                                        <span class="form-control-static form-control-static-inline">
                                                                x {$configoption.options.0.name}
                                                            </span>
                                                    </div>
                                                {/if}
                                            </div>
                                        </div>
                                    {/if}
                                    {if $num % 2 != 0}
                                </div>
                                <div class="row">
                                    {/if}
                                    {/foreach}
                                </div>
                            </div>

                        {/if}

                        {if $customfields}

                            <div class="sub-heading pb-1">
                                <span class="primary-bg-color">{$LANG.orderadditionalrequiredinfo}<br><i><small>{lang key='orderForm.requiredField'}</small></i></span>
                            </div>

                            <div class="field-container">
                                {foreach $customfields as $customfield}
                                    <div class="form-group">
                                        <label for="customfield{$customfield.id}">{$customfield.name} {$customfield.required}</label>
                                        {$customfield.input}
                                        {if $customfield.description}
                                            <span class="field-help-text">
                                                {$customfield.description}
                                            </span>
                                        {/if}
                                    </div>
                                {/foreach}
                            </div>

                        {/if}

                        {if $addons || count($addonsPromoOutput) > 0}

                            <div id="productAddonsContainer">
                                <div class="sub-heading">
                                    <span class="primary-bg-color">{$LANG.cartavailableaddons}</span>
                                </div>

                                {foreach $addonsPromoOutput as $output}
                                    <div>
                                        {$output}
                                    </div>
                                {/foreach}

                                <div class="row addon-products">
                                    {foreach $addons as $addon}
                                        <div class="col-sm-{if count($addons) > 1}6{else}12{/if}">
                                            <div class="panel card panel-default panel-addon{if $addon.status} panel-addon-selected{/if}">
                                                <div class="panel-body card-body">
                                                    <label>
                                                        <input type="checkbox" name="addons[{$addon.id}]"{if $addon.status} checked{/if} />
                                                        {$addon.name}
                                                    </label><br />
                                                    {$addon.description}
                                                </div>
                                                <div class="panel-price">
                                                    {$addon.pricing}
                                                </div>
                                                <div class="panel-add">
                                                    <i class="fas fa-plus"></i>
                                                    {$LANG.addtocart}
                                                </div>
                                            </div>
                                        </div>
                                    {/foreach}
                                </div>
                            </div>
                        {/if}

                        <div class="alert alert-warning info-text-sm">
                            <i class="fas fa-question-circle"></i>
                            {$LANG.orderForm.haveQuestionsContact} <a href="{$WEB_ROOT}/contact.php" target="_blank" class="alert-link">{$LANG.orderForm.haveQuestionsClickHere}</a>
                        </div>

                    </div>
                    <div class="secondary-cart-sidebar" id="scrollingPanelContainer">

                        <div id="orderSummary">
                            <div class="order-summary">
                                <div class="loader" id="orderSummaryLoader">
                                    <i class="fas fa-fw fa-sync fa-spin"></i>
                                </div>
                                <h2 class="font-size-30">{$LANG.ordersummary}</h2>
                                <div class="summary-container">
                                    <div id="producttotal"></div>
                                    <div class="text-center">
                                        <button type="submit" id="btnCompleteProductConfig" class="btn btn-block btn-primary btn-lg">
                                            {$LANG.continue}
                                            <i class="fad fa-long-arrow-right"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>

            </form>
        </div>
    </div>
</div>

<script>recalctotals();</script>

{include file="orderforms/Redcheap_Professional/recommendations-modal.tpl"}
