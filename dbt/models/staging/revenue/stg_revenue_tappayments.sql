WITH
{{ build_fivetran_ctes_from_one_schema_table(
    schema_base_name = 'TAPPAYMENTS', 
    table_name = 'ORDERS', 
    columns = ['ID',	'AMOUNT',	'METADATA',	'_FIVETRAN_BATCH',	'_FIVETRAN_INDEX',	'SHIPPING',	'CREATED',	'CURRENCY',	'TAX',	'ITEMS',	'STATUS',	'CUSTOMER',	'_FIVETRAN_SYNCED'],
    cte_prefix='base') }}

SELECT 
BASE_UNION.ERAD_CUSTOMER_ID,
'UTC' as TIMEZONE_NAME, -- TODO timezone is static because there isnt a column currently providing the field
{{ convert_to_erad_tz("DATEADD('MS',BASE_UNION.CREATED,'1970-01-01')::DATE", 'TIMEZONE_NAME') }} as ERAD_TIMESTAMP,
1 as transactions,
BASE_UNION.ID,
BASE_UNION.AMOUNT,
BASE_UNION.METADATA,
BASE_UNION._FIVETRAN_BATCH,
BASE_UNION._FIVETRAN_INDEX,
BASE_UNION.SHIPPING,
BASE_UNION.CREATED,
BASE_UNION.CURRENCY,
BASE_UNION.TAX,
BASE_UNION.ITEMS,
BASE_UNION.STATUS,
BASE_UNION.CUSTOMER,
BASE_UNION._FIVETRAN_SYNCED,
{{ convert_to_erad_currency('BASE_UNION.CURRENCY' ,'BASE_UNION.AMOUNT') }} as ERAD_REVENUE,
BASE_UNION.ERAD_SCHEMA,
BASE_UNION.ERAD_TABLE

FROM BASE_UNION