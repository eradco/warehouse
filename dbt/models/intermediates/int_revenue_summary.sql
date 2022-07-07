WITH 
revenue_payments AS (
    SELECT 
        DATE                            as DATE,
        CUSTOMER_ID                     as CUSTOMER_ID,
        'TAP Payments'                  as REVENUE_SOURCE,
        'USD'                           as CURRENCY_CODE,
        ERAD_SOURCE                     as ERAD_SOURCE,
        REVENUE                         as REVENUE,
        TRANSACTIONS                    as TRANACTIONS
    FROM {{ref('stg_revenue_payments')}}),

revenue_sales AS (
    SELECT 
        DATE                            as DATE,
        CUSTOMER_ID                     as CUSTOMER_ID,
        'Magento'                       as REVENUE_SOURCE,
        'USD'                           as CURRENCY_CODE,
        ERAD_SOURCE                     as ERAD_SOURCE,
        REVENUE                         as REVENUE,
        TRANSACTIONS                    as TRANACTIONS
    FROM {{ref('stg_revenue_sales')}}
    WHERE CUSTOMER_ID NOT IN (SELECT DISTINCT CUSTOMER_ID FROM revenue_payments)
    )

    SELECT 
        DATE,
        CUSTOMER_ID,
        REVENUE_SOURCE,
        CURRENCY_CODE,
        ERAD_SOURCE,
        REVENUE,
        TRANSACTIONS
    FROM {{ref('stg_revenue_sales')}}

    UNION ALL

    SELECT 
        DATE,
        CUSTOMER_ID,
        REVENUE_SOURCE,
        CURRENCY_CODE,
        ERAD_SOURCE,
        REVENUE,
        TRANSACTIONS
    FROM {{ref('stg_revenue_payments')}}
