{{ 
    config(materialized='table') 
}}

WITH 

ADS_BASE AS (
    SELECT
        DATE,
        CUSTOMER_ID,
        AD_CHANNEL,
        null                        as REVENUE_SOURCE,
        CURRENCY_CODE,
        ERAD_SOURCE,
        
        SUM(CONVERSIONS)            as CONVERSIONS,
        SUM(ACQUSITIONS)            as ACQUSITIONS,
        null                        as REVENUE,
        SUM(COST)                   as EXPENSES,
        SUM(CLICKS)                 as CLICKS,
        null                        as TRANSACTIONS

    FROM {{ref('int_ads_summary')}}
    GROUP BY 1,2,3,4,5,6
),


REVENUE_BASE AS (
    SELECT
        DATE,
        CUSTOMER_ID,
        null                        as AD_CHANNEL,
        REVENUE_SOURCE              as REVENUE_SOURCE,
        'USD'                       as CURRENCY_CODE,
        ERAD_SOURCE,
        
        null                        as CONVERSIONS,
        null                        as ACQUSITIONS,
        SUM(REVENUE)                as REVENUE,
        null                        as EXPENSES,
        null                        as CLICKS,
        sum(TRANSACTIONS)           as TRANSACTIONS

    FROM {{ref('int_revenue_summary')}}
    GROUP BY 1,2,3,4,5,6
),

BASE as (
    SELECT * FROM ADS_BASE
    UNION ALL
    SELECT * FROM REVENUE_BASE
)

SELECT
DATE::DATE                          as DATE,
CUSTOMER_ID::varchar(256)           as CUSTOMER_ID,
AD_CHANNEL::varchar(256)            as AD_CHANNEL,
REVENUE_SOURCE::varchar(256)        as REVENUE_SOURCE,
CURRENCY_CODE::varchar(3)           as CURRENCY_CODE,   

REVENUE::number(22,2)               as REVENUE,
EXPENSES::number(22,2)              as EXPENSES,
TRANSACTIONS::number(22,2)          as TRANSACTIONS,

current_timestamp()::timestamp_tz   as ERAD_UPDATED_AT

FROM BASE