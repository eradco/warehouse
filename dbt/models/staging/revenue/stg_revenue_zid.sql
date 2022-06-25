WITH
{{ build_fivetran_ctes_from_one_schema_table(
    schema_base_name = 'ZID', 
    table_name = 'ORDERS', 
    columns = ['ID',	'CODE',	'REQUIRES_SHIPPING',	'TRANSACTION_AMOUNT',	'CREATED_AT',	'HAS_DIFFERENT_TRANSACTION_CURRENCY',	'ORDER_TOTAL_STRING',	'CURRENCY_CODE',	'STORE_URL',	'PRODUCTS_SUM_TOTAL_STRING',	'ORDER_URL',	'ORDER_STATUS',	'UPDATED_AT',	'SHIPPING',	'STORE_NAME',	'PAYMENT',	'STORE_ID',	'TRANSACTION_AMOUNT_STRING',	'_FIVETRAN_BATCH',	'SHIPPING_METHOD_CODE',	'_FIVETRAN_INDEX',	'HAS_DIFFERENT_CONSIGNEE',	'ORDER_TOTAL',	'CUSTOMER',	'_FIVETRAN_SYNCED'],
    cte_prefix='base') }}

SELECT 
BASE_UNION.ERAD_CUSTOMER_ID,
CURRENCY_CODE as CURRENCY,
'Asia/Dubai' as TIMEZONE_NAME, -- TODO timezone is static because there isnt a column currently providing the field
{{ convert_to_erad_tz('BASE_UNION.CREATED_AT', 'TIMEZONE_NAME') }} as ERAD_TIMESTAMP,
BASE_UNION.ID,
BASE_UNION.CODE,
BASE_UNION.REQUIRES_SHIPPING,
BASE_UNION.TRANSACTION_AMOUNT,
BASE_UNION.CREATED_AT,
BASE_UNION.HAS_DIFFERENT_TRANSACTION_CURRENCY,
BASE_UNION.ORDER_TOTAL_STRING,
BASE_UNION.STORE_URL,
BASE_UNION.PRODUCTS_SUM_TOTAL_STRING,
BASE_UNION.ORDER_URL,
BASE_UNION.ORDER_STATUS,
BASE_UNION.UPDATED_AT,
BASE_UNION.SHIPPING,
BASE_UNION.STORE_NAME,
BASE_UNION.PAYMENT,
BASE_UNION.STORE_ID,
BASE_UNION.TRANSACTION_AMOUNT_STRING,
BASE_UNION._FIVETRAN_BATCH,
BASE_UNION.SHIPPING_METHOD_CODE,
BASE_UNION._FIVETRAN_INDEX,
BASE_UNION.HAS_DIFFERENT_CONSIGNEE,
BASE_UNION.ORDER_TOTAL,
BASE_UNION.CUSTOMER,
{{ convert_to_erad_currency('CURRENCY' ,'TRANSACTION_AMOUNT') }} as ERAD_REVENUE,
BASE_UNION._FIVETRAN_SYNCED,
BASE_UNION.ERAD_SCHEMA,
BASE_UNION.ERAD_TABLE
FROM BASE_UNION