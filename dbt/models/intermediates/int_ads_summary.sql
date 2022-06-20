WITH BASE AS (
    SELECT 
        Date,
        CUSTOMER_ID,
        AD_CHANNEL,
        CURRENCY_CODE,
        ERAD_SOURCE,

        CONVERSIONS,
        ACQUSITIONS,
        COST
    FROM {{ref('stg_ads_twitter')}}

    UNION ALL

    SELECT 
        DATE,
        CUSTOMER_ID,
        AD_CHANNEL,
        CURRENCY_CODE,
        ERAD_SOURCE,

        CONVERSIONS,
        ACQUSITIONS,
        COST
    FROM {{ref('stg_ads_facebook')}}
)

    SELECT 
        Date,
        CUSTOMER_ID,
        AD_CHANNEL,
        CURRENCY_CODE,
        LISTAGG(ERAD_SOURCE,', ') as ERAD_SOURCE,

        SUM(CONVERSIONS) CONVERSIONS,
        SUM(ACQUSITIONS) ACQUSITIONS,
        SUM(COST) COST
    FROM BASE   

    GROUP BY
        DATE,
        CUSTOMER_ID,
        CURRENCY_CODE
    