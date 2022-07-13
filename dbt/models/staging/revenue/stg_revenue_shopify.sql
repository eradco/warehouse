WITH
{{ build_fivetran_ctes_from_one_schema_table(
    schema_base_name = 'SHOPIFY', 
    table_name = 'ORDER', 
    columns = ['ID',	'NOTE',	'EMAIL',	'TAXES_INCLUDED',	'CURRENCY',	'SUBTOTAL_PRICE',	'SUBTOTAL_PRICE_SET',	'TOTAL_TAX',	'TOTAL_TAX_SET',	'TOTAL_PRICE',	'TOTAL_PRICE_USD',	'TOTAL_PRICE_SET',	'CREATED_AT',	'UPDATED_AT',	'NAME',	'SHIPPING_ADDRESS_ID',	'SHIPPING_ADDRESS_NAME',	'SHIPPING_ADDRESS_FIRST_NAME',	'SHIPPING_ADDRESS_LAST_NAME',	'SHIPPING_ADDRESS_COMPANY',	'SHIPPING_ADDRESS_PHONE',	'SHIPPING_ADDRESS_ADDRESS_1',	'SHIPPING_ADDRESS_ADDRESS_2',	'SHIPPING_ADDRESS_CITY',	'SHIPPING_ADDRESS_COUNTRY',	'SHIPPING_ADDRESS_COUNTRY_CODE',	'SHIPPING_ADDRESS_PROVINCE',	'SHIPPING_ADDRESS_PROVINCE_CODE',	'SHIPPING_ADDRESS_ZIP',	'SHIPPING_ADDRESS_LATITUDE',	'SHIPPING_ADDRESS_LONGITUDE',	'BILLING_ADDRESS_ID',	'BILLING_ADDRESS_NAME',	'BILLING_ADDRESS_FIRST_NAME',	'BILLING_ADDRESS_LAST_NAME',	'BILLING_ADDRESS_COMPANY',	'BILLING_ADDRESS_PHONE',	'BILLING_ADDRESS_ADDRESS_1',	'BILLING_ADDRESS_ADDRESS_2',	'BILLING_ADDRESS_CITY',	'BILLING_ADDRESS_COUNTRY',	'BILLING_ADDRESS_COUNTRY_CODE',	'BILLING_ADDRESS_PROVINCE',	'BILLING_ADDRESS_PROVINCE_CODE',	'BILLING_ADDRESS_ZIP',	'BILLING_ADDRESS_LATITUDE',	'BILLING_ADDRESS_LONGITUDE',	'CUSTOMER_ID',	'LOCATION_ID',	'USER_ID',	'APP_ID',	'NUMBER',	'ORDER_NUMBER',	'FINANCIAL_STATUS',	'FULFILLMENT_STATUS',	'PROCESSED_AT',	'PROCESSING_METHOD',	'REFERRING_SITE',	'CANCEL_REASON',	'CANCELLED_AT',	'CLOSED_AT',	'TOTAL_DISCOUNTS',	'TOTAL_TIP_RECEIVED',	'CURRENT_TOTAL_PRICE',	'CURRENT_TOTAL_DISCOUNTS',	'CURRENT_SUBTOTAL_PRICE',	'CURRENT_TOTAL_TAX',	'CURRENT_TOTAL_DISCOUNTS_SET',	'CURRENT_TOTAL_DUTIES_SET',	'CURRENT_TOTAL_PRICE_SET',	'CURRENT_SUBTOTAL_PRICE_SET',	'CURRENT_TOTAL_TAX_SET',	'TOTAL_DISCOUNTS_SET',	'TOTAL_SHIPPING_PRICE_SET',	'TOTAL_LINE_ITEMS_PRICE',	'TOTAL_LINE_ITEMS_PRICE_SET',	'ORIGINAL_TOTAL_DUTIES_SET',	'TOTAL_WEIGHT',	'SOURCE_NAME',	'BROWSER_IP',	'BUYER_ACCEPTS_MARKETING',	'CONFIRMED',	'TOKEN',	'CART_TOKEN',	'CHECKOUT_TOKEN',	'CUSTOMER_LOCALE',	'DEVICE_ID',	'LANDING_SITE_REF',	'PRESENTMENT_CURRENCY',	'REFERENCE',	'SOURCE_IDENTIFIER',	'SOURCE_URL',	'_FIVETRAN_DELETED',	'ORDER_STATUS_URL',	'TEST',	'PAYMENT_GATEWAY_NAMES',	'NOTE_ATTRIBUTES',	'CLIENT_DETAILS_USER_AGENT',	'LANDING_SITE_BASE_URL',	'_FIVETRAN_SYNCED'],
    cte_prefix='base') }}

SELECT 
BASE_UNION.ERAD_CUSTOMER_ID,
'UTC' as TIMEZONE_NAME, -- TODO timezone is static because there isnt a column currently providing the field
{{ convert_to_erad_tz('BASE_UNION.CREATED_AT::date', 'TIMEZONE_NAME') }} as ERAD_TIMESTAMP,
1 as transactions,
BASE_UNION.ID,
BASE_UNION.NOTE,
BASE_UNION.EMAIL,
BASE_UNION.TAXES_INCLUDED,
BASE_UNION.CURRENCY,
BASE_UNION.SUBTOTAL_PRICE,
BASE_UNION.SUBTOTAL_PRICE_SET,
BASE_UNION.TOTAL_TAX,
BASE_UNION.TOTAL_TAX_SET,
BASE_UNION.TOTAL_PRICE,
BASE_UNION.TOTAL_PRICE_USD,
BASE_UNION.TOTAL_PRICE_SET,
BASE_UNION.CREATED_AT,
BASE_UNION.UPDATED_AT,
BASE_UNION.NAME,
BASE_UNION.SHIPPING_ADDRESS_ID,
BASE_UNION.SHIPPING_ADDRESS_NAME,
BASE_UNION.SHIPPING_ADDRESS_FIRST_NAME,
BASE_UNION.SHIPPING_ADDRESS_LAST_NAME,
BASE_UNION.SHIPPING_ADDRESS_COMPANY,
BASE_UNION.SHIPPING_ADDRESS_PHONE,
BASE_UNION.SHIPPING_ADDRESS_ADDRESS_1,
BASE_UNION.SHIPPING_ADDRESS_ADDRESS_2,
BASE_UNION.SHIPPING_ADDRESS_CITY,
BASE_UNION.SHIPPING_ADDRESS_COUNTRY,
BASE_UNION.SHIPPING_ADDRESS_COUNTRY_CODE,
BASE_UNION.SHIPPING_ADDRESS_PROVINCE,
BASE_UNION.SHIPPING_ADDRESS_PROVINCE_CODE,
BASE_UNION.SHIPPING_ADDRESS_ZIP,
BASE_UNION.SHIPPING_ADDRESS_LATITUDE,
BASE_UNION.SHIPPING_ADDRESS_LONGITUDE,
BASE_UNION.BILLING_ADDRESS_ID,
BASE_UNION.BILLING_ADDRESS_NAME,
BASE_UNION.BILLING_ADDRESS_FIRST_NAME,
BASE_UNION.BILLING_ADDRESS_LAST_NAME,
BASE_UNION.BILLING_ADDRESS_COMPANY,
BASE_UNION.BILLING_ADDRESS_PHONE,
BASE_UNION.BILLING_ADDRESS_ADDRESS_1,
BASE_UNION.BILLING_ADDRESS_ADDRESS_2,
BASE_UNION.BILLING_ADDRESS_CITY,
BASE_UNION.BILLING_ADDRESS_COUNTRY,
BASE_UNION.BILLING_ADDRESS_COUNTRY_CODE,
BASE_UNION.BILLING_ADDRESS_PROVINCE,
BASE_UNION.BILLING_ADDRESS_PROVINCE_CODE,
BASE_UNION.BILLING_ADDRESS_ZIP,
BASE_UNION.BILLING_ADDRESS_LATITUDE,
BASE_UNION.BILLING_ADDRESS_LONGITUDE,
BASE_UNION.CUSTOMER_ID,
BASE_UNION.LOCATION_ID,
BASE_UNION.USER_ID,
BASE_UNION.APP_ID,
BASE_UNION.NUMBER,
BASE_UNION.ORDER_NUMBER,
BASE_UNION.FINANCIAL_STATUS,
BASE_UNION.FULFILLMENT_STATUS,
BASE_UNION.PROCESSED_AT,
BASE_UNION.PROCESSING_METHOD,
BASE_UNION.REFERRING_SITE,
BASE_UNION.CANCEL_REASON,
BASE_UNION.CANCELLED_AT,
BASE_UNION.CLOSED_AT,
BASE_UNION.TOTAL_DISCOUNTS,
BASE_UNION.TOTAL_TIP_RECEIVED,
BASE_UNION.CURRENT_TOTAL_PRICE,
BASE_UNION.CURRENT_TOTAL_DISCOUNTS,
BASE_UNION.CURRENT_SUBTOTAL_PRICE,
BASE_UNION.CURRENT_TOTAL_TAX,
BASE_UNION.CURRENT_TOTAL_DISCOUNTS_SET,
BASE_UNION.CURRENT_TOTAL_DUTIES_SET,
BASE_UNION.CURRENT_TOTAL_PRICE_SET,
BASE_UNION.CURRENT_SUBTOTAL_PRICE_SET,
BASE_UNION.CURRENT_TOTAL_TAX_SET,
BASE_UNION.TOTAL_DISCOUNTS_SET,
BASE_UNION.TOTAL_SHIPPING_PRICE_SET,
BASE_UNION.TOTAL_LINE_ITEMS_PRICE,
BASE_UNION.TOTAL_LINE_ITEMS_PRICE_SET,
BASE_UNION.ORIGINAL_TOTAL_DUTIES_SET,
BASE_UNION.TOTAL_WEIGHT,
BASE_UNION.SOURCE_NAME,
BASE_UNION.BROWSER_IP,
BASE_UNION.BUYER_ACCEPTS_MARKETING,
BASE_UNION.CONFIRMED,
BASE_UNION.TOKEN,
BASE_UNION.CART_TOKEN,
BASE_UNION.CHECKOUT_TOKEN,
BASE_UNION.CUSTOMER_LOCALE,
BASE_UNION.DEVICE_ID,
BASE_UNION.LANDING_SITE_REF,
BASE_UNION.PRESENTMENT_CURRENCY,
BASE_UNION.REFERENCE,
BASE_UNION.SOURCE_IDENTIFIER,
BASE_UNION.SOURCE_URL,
BASE_UNION._FIVETRAN_DELETED,
BASE_UNION.ORDER_STATUS_URL,
BASE_UNION.TEST,
BASE_UNION.PAYMENT_GATEWAY_NAMES,
BASE_UNION.NOTE_ATTRIBUTES,
BASE_UNION.CLIENT_DETAILS_USER_AGENT,
BASE_UNION.LANDING_SITE_BASE_URL,
BASE_UNION._FIVETRAN_SYNCED,
{{ convert_to_erad_currency('CURRENCY' ,'BASE_UNION.TOTAL_PRICE_USD') }} as ERAD_REVENUE,
BASE_UNION.ERAD_SCHEMA,
BASE_UNION.ERAD_TABLE

FROM BASE_UNION
WHERE BASE_UNION.Financial_Status ilike 'Paid' AND BASE_UNION.Fulfilment_Status ilike 'Fulfilled'
