WITH BASE AS (
SELECT
'2022-05-26'                    as DATE,
'12346'                         as CUSTOMER_ID,
'facebook'                      as AD_CHANNEL,
12                              as CONVERSIONS,
2                               as ACQUSITIONS,  
'USD'                           as CURRENCY_CODE,
2234.123                        as COST

UNION ALL

SELECT
'2022-05-26'                    as DATE,
'12346'                         as CUSTOMER_ID,
'facebook'                      as AD_CHANNEL,
12                              as CONVERSIONS,
2                               as ACQUSITIONS,  
'USD'                           as CURRENCY_CODE,
2234.123                        as COST

UNION ALL

SELECT
'2022-05-27'                    as DATE,
'12346'                         as CUSTOMER_ID,
'facebook'                      as AD_CHANNEL,
12                              as CONVERSIONS,
2                               as ACQUSITIONS,  
'USD'                           as CURRENCY_CODE,
2234.123                        as COST

UNION ALL

SELECT
'2022-05-28'                    as DATE,
'12346'                         as CUSTOMER_ID,
'facebook'                      as AD_CHANNEL,
12                              as CONVERSIONS,
2                               as ACQUSITIONS,  
'USD'                           as CURRENCY_CODE,
2234.123                        as COST

UNION ALL

SELECT
'2022-05-29'                    as DATE,
'12346'                         as CUSTOMER_ID,
'facebook'                      as AD_CHANNEL,
12                              as CONVERSIONS,
2                               as ACQUSITIONS,  
'USD'                           as CURRENCY_CODE,
2234.123                        as COST

UNION ALL

SELECT
'2022-05-30'                    as DATE,
'12346'                         as CUSTOMER_ID,
'facebook'                      as AD_CHANNEL,
12                              as CONVERSIONS,
2                               as ACQUSITIONS,  
'USD'                           as CURRENCY_CODE,
2234.123                        as COST

UNION ALL

SELECT
'2022-06-01'                    as DATE,
'12346'                         as CUSTOMER_ID,
'facebook'                      as AD_CHANNEL,
12                              as CONVERSIONS,
2                               as ACQUSITIONS,  
'USD'                           as CURRENCY_CODE,
2234.123                        as COST
)

SELECT 
DATE,
CUSTOMER_ID,
AD_CHANNEL,
CURRENCY_CODE,
'facebookads_fivetran' as ERAD_SOURCE,

CONVERSIONS,
ACQUSITIONS,
COST,

current_timestamp()::timestamp_tz as ERAD_UPDATED_AT
FROM BASE