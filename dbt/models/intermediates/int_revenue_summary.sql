WITH BASE AS (
    SELECT 
        ERAD_TIMESTAMP::DATE            as DATE,
        ERAD_CUSTOMER_ID                as CUSTOMER_ID,
        'Zid'                           as REVENUE_SOURCE,
        'USD'                           as CURRENCY_CODE,
        CONCAT(ERAD_SCHEMA,'.',ERAD_TABLE) as ERAD_SOURCE,
        ERAD_REVENUE                    as REVENUE
    FROM {{ref('stg_revenue_zid')}}

    UNION ALL

    SELECT 
        ERAD_TIMESTAMP::DATE            as DATE,
        ERAD_CUSTOMER_ID                as CUSTOMER_ID,
        'Stripe'                        as REVENUE_SOURCE,
        'USD'                           as CURRENCY_CODE,
        CONCAT(ERAD_SCHEMA,'.',ERAD_TABLE) as ERAD_SOURCE,
        ERAD_REVENUE                    as REVENUE
    FROM {{ref('stg_revenue_stripe')}}

)
    SELECT 
        DATE,
        CUSTOMER_ID,
        REVENUE_SOURCE,
        CURRENCY_CODE,
        ERAD_SOURCE,

        REVENUE
    FROM BASE