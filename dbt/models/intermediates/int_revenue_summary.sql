WITH BASE AS (
    SELECT 
        DATE,
        CUSTOMER_ID,
        REVENUE_SOURCE,
        CURRENCY_CODE,
        ERAD_SOURCE,

        REVENUE
    FROM {{ref('stg_revenue_moneyhash_mock')}}

    UNION ALL

    SELECT 
        DATE,
        CUSTOMER_ID,
        REVENUE_SOURCE,
        CURRENCY_CODE,
        ERAD_SOURCE,

        REVENUE
    FROM {{ref('stg_revenue_salla')}}
)

    SELECT 
        DATE,
        CUSTOMER_ID,
        REVENUE_SOURCE,
        CURRENCY_CODE,
        ERAD_SOURCE,

        REVENUE
    FROM BASE