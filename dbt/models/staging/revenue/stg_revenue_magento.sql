WITH
{{ build_fivetran_ctes_from_one_schema_table(
    schema_base_name = 'MAGENTO', 
    table_name = 'ORDERS', 
    columns = ['ENTITY_ID',	'STORE_ID',	'TAX_AMOUNT',	'TAX_INVOICED',	'CUSTOMER_NOTE_NOTIFY',	'SHIPPING_DISCOUNT_AMOUNT',	'BASE_DISCOUNT_TAX_COMPENSATION_INVOICED',	'CUSTOMER_FIRSTNAME',	'DISCOUNT_AMOUNT',	'BILLING_ADDRESS',	'TOTAL_PAID',	'INCREMENT_ID',	'PAYMENT',	'STATE',	'BASE_SHIPPING_TAX_AMOUNT',	'BASE_GRAND_TOTAL',	'BILLING_ADDRESS_ID',	'CUSTOMER_LASTNAME',	'_FIVETRAN_BATCH',	'QUOTE_ID',	'SHIPPING_INVOICED',	'DISCOUNT_TAX_COMPENSATION_AMOUNT',	'WEIGHT',	'BASE_TOTAL_INVOICED',	'BASE_SHIPPING_AMOUNT',	'BASE_SUBTOTAL_INVOICED',	'SUBTOTAL_INCL_TAX',	'_FIVETRAN_INDEX',	'BASE_SHIPPING_DISCOUNT_TAX_COMPENSATION_AMNT',	'SUBTOTAL',	'BASE_SHIPPING_INCL_TAX',	'CUSTOMER_EMAIL',	'BASE_DISCOUNT_INVOICED',	'TOTAL_INVOICED',	'BASE_TO_GLOBAL_RATE',	'CUSTOMER_IS_GUEST',	'ITEMS',	'GLOBAL_CURRENCY_CODE',	'STATUS',	'IS_VIRTUAL',	'BASE_TOTAL_INVOICED_COST',	'DISCOUNT_TAX_COMPENSATION_INVOICED',	'STATUS_HISTORIES',	'STORE_CURRENCY_CODE',	'CREATED_AT',	'TOTAL_ITEM_COUNT',	'SHIPPING_TAX_AMOUNT',	'STORE_TO_BASE_RATE',	'UPDATED_AT',	'BASE_SHIPPING_DISCOUNT_AMOUNT',	'STORE_NAME',	'GRAND_TOTAL',	'BASE_CURRENCY_CODE',	'BASE_TOTAL_PAID',	'BASE_TAX_AMOUNT',	'SHIPPING_DISCOUNT_TAX_COMPENSATION_AMOUNT',	'TOTAL_QTY_ORDERED',	'BASE_DISCOUNT_AMOUNT',	'EXTENSION_ATTRIBUTES',	'SHIPPING_DESCRIPTION',	'STORE_TO_ORDER_RATE',	'SHIPPING_AMOUNT',	'BASE_DISCOUNT_TAX_COMPENSATION_AMOUNT',	'SUBTOTAL_INVOICED',	'BASE_TO_ORDER_RATE',	'BASE_SUBTOTAL',	'PROTECT_CODE',	'CUSTOMER_DOB',	'BASE_SUBTOTAL_INCL_TAX',	'CUSTOMER_ID',	'CUSTOMER_GROUP_ID',	'DISCOUNT_INVOICED',	'ORDER_CURRENCY_CODE',	'BASE_TAX_INVOICED',	'CUSTOMER_GENDER',	'SHIPPING_INCL_TAX',	'BASE_SHIPPING_INVOICED',	'_FIVETRAN_SYNCED',	'DISCOUNT_REFUNDED',	'TOTAL_REFUNDED',	'BASE_TAX_REFUNDED',	'BASE_DISCOUNT_REFUNDED',	'SHIPPING_TAX_REFUNDED',	'SHIPPING_REFUNDED',	'BASE_DISCOUNT_TAX_COMPENSATION_REFUNDED',	'BASE_ADJUSTMENT_NEGATIVE',	'SUBTOTAL_REFUNDED',	'ADJUSTMENT_POSITIVE',	'BASE_TOTAL_REFUNDED',	'TOTAL_OFFLINE_REFUNDED',	'ADJUSTMENT_NEGATIVE',	'BASE_SHIPPING_REFUNDED',	'BASE_TOTAL_OFFLINE_REFUNDED',	'BASE_SHIPPING_TAX_REFUNDED',	'BASE_ADJUSTMENT_POSITIVE',	'BASE_SUBTOTAL_REFUNDED',	'DISCOUNT_TAX_COMPENSATION_REFUNDED',	'TAX_REFUNDED',	'REMOTE_IP',	'X_FORWARDED_FOR',	'APPLIED_RULE_IDS',	'TOTAL_DUE',	'BASE_TOTAL_DUE'],
    cte_prefix='base') }}

SELECT 
BASE_UNION.ERAD_CUSTOMER_ID,
'UTC' as TIMEZONE_NAME, -- TODO timezone is static because there isnt a column currently providing the field
{{ convert_to_erad_tz('BASE_UNION.CREATED_AT::date', 'TIMEZONE_NAME') }} as ERAD_TIMESTAMP,
1 as transactions,
BASE_UNION.ENTITY_ID,
BASE_UNION.STORE_ID,
BASE_UNION.TAX_AMOUNT,
BASE_UNION.TAX_INVOICED,
BASE_UNION.CUSTOMER_NOTE_NOTIFY,
BASE_UNION.SHIPPING_DISCOUNT_AMOUNT,
BASE_UNION.BASE_DISCOUNT_TAX_COMPENSATION_INVOICED,
BASE_UNION.CUSTOMER_FIRSTNAME,
BASE_UNION.DISCOUNT_AMOUNT,
BASE_UNION.BILLING_ADDRESS,
BASE_UNION.TOTAL_PAID,
BASE_UNION.INCREMENT_ID,
BASE_UNION.PAYMENT,
BASE_UNION.STATE,
BASE_UNION.BASE_SHIPPING_TAX_AMOUNT,
BASE_UNION.BASE_GRAND_TOTAL,
BASE_UNION.BILLING_ADDRESS_ID,
BASE_UNION.CUSTOMER_LASTNAME,
BASE_UNION._FIVETRAN_BATCH,
BASE_UNION.QUOTE_ID,
BASE_UNION.SHIPPING_INVOICED,
BASE_UNION.DISCOUNT_TAX_COMPENSATION_AMOUNT,
BASE_UNION.WEIGHT,
BASE_UNION.BASE_TOTAL_INVOICED,
BASE_UNION.BASE_SHIPPING_AMOUNT,
BASE_UNION.BASE_SUBTOTAL_INVOICED,
BASE_UNION.SUBTOTAL_INCL_TAX,
BASE_UNION._FIVETRAN_INDEX,
BASE_UNION.BASE_SHIPPING_DISCOUNT_TAX_COMPENSATION_AMNT,
BASE_UNION.SUBTOTAL,
BASE_UNION.BASE_SHIPPING_INCL_TAX,
BASE_UNION.CUSTOMER_EMAIL,
BASE_UNION.BASE_DISCOUNT_INVOICED,
BASE_UNION.TOTAL_INVOICED,
BASE_UNION.BASE_TO_GLOBAL_RATE,
BASE_UNION.CUSTOMER_IS_GUEST,
BASE_UNION.ITEMS,
BASE_UNION.GLOBAL_CURRENCY_CODE,
BASE_UNION.STATUS,
BASE_UNION.IS_VIRTUAL,
BASE_UNION.BASE_TOTAL_INVOICED_COST,
BASE_UNION.DISCOUNT_TAX_COMPENSATION_INVOICED,
BASE_UNION.STATUS_HISTORIES,
BASE_UNION.STORE_CURRENCY_CODE as CURRENCY,
BASE_UNION.CREATED_AT,
BASE_UNION.TOTAL_ITEM_COUNT,
BASE_UNION.SHIPPING_TAX_AMOUNT,
BASE_UNION.STORE_TO_BASE_RATE,
BASE_UNION.UPDATED_AT,
BASE_UNION.BASE_SHIPPING_DISCOUNT_AMOUNT,
BASE_UNION.STORE_NAME,
BASE_UNION.GRAND_TOTAL,
BASE_UNION.BASE_CURRENCY_CODE,
BASE_UNION.BASE_TOTAL_PAID,
BASE_UNION.BASE_TAX_AMOUNT,
BASE_UNION.SHIPPING_DISCOUNT_TAX_COMPENSATION_AMOUNT,
BASE_UNION.TOTAL_QTY_ORDERED,
BASE_UNION.BASE_DISCOUNT_AMOUNT,
BASE_UNION.EXTENSION_ATTRIBUTES,
BASE_UNION.SHIPPING_DESCRIPTION,
BASE_UNION.STORE_TO_ORDER_RATE,
BASE_UNION.SHIPPING_AMOUNT,
BASE_UNION.BASE_DISCOUNT_TAX_COMPENSATION_AMOUNT,
BASE_UNION.SUBTOTAL_INVOICED,
BASE_UNION.BASE_TO_ORDER_RATE,
BASE_UNION.BASE_SUBTOTAL,
BASE_UNION.PROTECT_CODE,
BASE_UNION.CUSTOMER_DOB,
BASE_UNION.BASE_SUBTOTAL_INCL_TAX,
BASE_UNION.CUSTOMER_ID,
BASE_UNION.CUSTOMER_GROUP_ID,
BASE_UNION.DISCOUNT_INVOICED,
BASE_UNION.ORDER_CURRENCY_CODE,
BASE_UNION.BASE_TAX_INVOICED,
BASE_UNION.CUSTOMER_GENDER,
BASE_UNION.SHIPPING_INCL_TAX,
BASE_UNION.BASE_SHIPPING_INVOICED,
BASE_UNION._FIVETRAN_SYNCED,
BASE_UNION.DISCOUNT_REFUNDED,
BASE_UNION.TOTAL_REFUNDED,
BASE_UNION.BASE_TAX_REFUNDED,
BASE_UNION.BASE_DISCOUNT_REFUNDED,
BASE_UNION.SHIPPING_TAX_REFUNDED,
BASE_UNION.SHIPPING_REFUNDED,
BASE_UNION.BASE_DISCOUNT_TAX_COMPENSATION_REFUNDED,
BASE_UNION.BASE_ADJUSTMENT_NEGATIVE,
BASE_UNION.SUBTOTAL_REFUNDED,
BASE_UNION.ADJUSTMENT_POSITIVE,
BASE_UNION.BASE_TOTAL_REFUNDED,
BASE_UNION.TOTAL_OFFLINE_REFUNDED,
BASE_UNION.ADJUSTMENT_NEGATIVE,
BASE_UNION.BASE_SHIPPING_REFUNDED,
BASE_UNION.BASE_TOTAL_OFFLINE_REFUNDED,
BASE_UNION.BASE_SHIPPING_TAX_REFUNDED,
BASE_UNION.BASE_ADJUSTMENT_POSITIVE,
BASE_UNION.BASE_SUBTOTAL_REFUNDED,
BASE_UNION.DISCOUNT_TAX_COMPENSATION_REFUNDED,
BASE_UNION.TAX_REFUNDED,
BASE_UNION.REMOTE_IP,
BASE_UNION.X_FORWARDED_FOR,
--BASE_UNION.APPLIED_RULE_IDS::VARCHAR as APPLIED_RULE_IDS,
BASE_UNION.TOTAL_DUE,
BASE_UNION.BASE_TOTAL_DUE,
{{ convert_to_erad_currency('CURRENCY' ,'TRY_TO_DOUBLE(BASE_UNION.BASE_TOTAL_INVOICED)') }} as ERAD_REVENUE,
BASE_UNION.ERAD_SCHEMA,
BASE_UNION.ERAD_TABLE

FROM BASE_UNION