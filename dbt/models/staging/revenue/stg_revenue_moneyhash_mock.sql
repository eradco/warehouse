WITH BASE AS (
SELECT
'2022-05-26'                    as DATE,
'2346'                          as CUSTOMER_ID,
'stripe'                     as REVENUE_SOURCE, 
'USD'                           as CURRENCY_CODE,
10000                          as REVENUE

UNION ALL

SELECT
'2022-05-26'                    as DATE,
'2346'                          as CUSTOMER_ID,
'stripe'                     as REVENUE_SOURCE, 
'USD'                           as CURRENCY_CODE,
10000                          as REVENUE

UNION ALL

SELECT
'2022-05-27'                    as DATE,
'2346'                          as CUSTOMER_ID,
'stripe'                     as REVENUE_SOURCE,  
'USD'                           as CURRENCY_CODE,
10000                          as REVENUE

UNION ALL

SELECT
'2022-05-28'                    as DATE,
'2346'                          as CUSTOMER_ID,
'stripe'                     as REVENUE_SOURCE,
'USD'                           as CURRENCY_CODE,
10000                          as REVENUE

UNION ALL

SELECT
'2022-05-29'                    as DATE,
'2346'                          as CUSTOMER_ID,
'stripe'                     as REVENUE_SOURCE, 
'USD'                           as CURRENCY_CODE,
10000                          as REVENUE

UNION ALL

SELECT
'2022-05-30'                    as DATE,
'2346'                          as CUSTOMER_ID,
'stripe'                     as REVENUE_SOURCE,
'USD'                           as CURRENCY_CODE,
10000                          as REVENUE

UNION ALL

SELECT
'2022-06-01'                    as DATE,
'2346'                          as CUSTOMER_ID,
'stripe'                        as REVENUE_SOURCE, 
'USD'                           as CURRENCY_CODE,
10000                           as REVENUE

UNION ALL
-- customer 2
SELECT
'2022-06-01'                    as DATE,
'142'                           as CUSTOMER_ID,
'stripe'                        as REVENUE_SOURCE, 
'USD'                           as CURRENCY_CODE,
1000585                         as REVENUE
)

SELECT 
DATE,
CUSTOMER_ID,
REVENUE_SOURCE,
CURRENCY_CODE,
'moneyhash_fivetran' as ERAD_SOURCE,

REVENUE,

current_timestamp()::timestamp_tz as ERAD_UPDATED_AT
FROM BASE