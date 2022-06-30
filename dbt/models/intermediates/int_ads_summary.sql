WITH 

BASE AS (
    SELECT 
        ERAD_TIMESTAMP::DATE    as Date,
        ERAD_CUSTOMER_ID        as CUSTOMER_ID,
        'Google Ads'            as AD_CHANNEL,
        'USD'                   as CURRENCY_CODE,
        CONCAT(ERAD_SCHEMA,'.',ERAD_TABLE) as ERAD_SOURCE,
        0                       as CONVERSIONS,
        CLICKS                  as CLICKS,
        0                       as ACQUSITIONS,
        ERAD_COST               as COST
    FROM {{ ref('stg_ads_google_ads') }}

    UNION ALL

    SELECT 
        ERAD_TIMESTAMP::DATE    as Date,
        ERAD_CUSTOMER_ID        as CUSTOMER_ID,
        'TikTok Ads'            as AD_CHANNEL,
        'USD'                   as CURRENCY_CODE,
        CONCAT(ERAD_SCHEMA,'.',ERAD_TABLE) as ERAD_SOURCE,
        0                       as CONVERSIONS,
        CLICKS                  as CLICKS,
        0                       as ACQUSITIONS,
        ERAD_COST               as COST
    FROM {{ ref('stg_ads_tiktok') }}

    UNION ALL

    SELECT 
        ERAD_TIMESTAMP::DATE    as Date,
        ERAD_CUSTOMER_ID        as CUSTOMER_ID,
        'Facebook Ads'          as AD_CHANNEL,
        'USD'                   as CURRENCY_CODE,
        CONCAT(ERAD_SCHEMA,'.',ERAD_TABLE) as ERAD_SOURCE,
        0                       as CONVERSIONS,
        CLICKS                  as CLICKS,
        0                       as ACQUSITIONS,
        ERAD_COST               as COST
    FROM {{ ref('stg_ads_facebook') }}
    )


SELECT * FROM BASE