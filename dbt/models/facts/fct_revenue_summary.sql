{{ 
    config(materialized='table') 
}}

WITH BASE AS (
    SELECT

    '12346'                         as CUSTOMER_ID,
    23232.1212                      as CAC,
    22.444                          as conversion_rate,
    parse_json(
        '{"FACEBOOK-INSTAGRAM": {"AD_SPEND": 1234.22, "CAC": 12.24, "CONVERSION_RATE": 12.23}, "TWITTER": {"AD_SPEND": 1234.22, "CAC": 12.24, "CONVERSION_RATE": 12.23} }'
    )                              as main_ad_channels
)

SELECT
CUSTOMER_ID::number(22,2)           as CUSTOMER_ID,
CAC::number(22,2)                   as CAC,
conversion_rate::number(22,2)       as conversion_rate,
main_ad_channels::variant           as main_ad_channels

FROM BASE