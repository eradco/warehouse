{% macro convert_to_erad_currency(current_currency, currency_value) %}
{{- "
CASE 
    WHEN {current_currency} ilike 'AED' THEN {currency_value} * {DBT_AED_TO_USD_RATE}
    WHEN {current_currency} ilike 'INR' THEN {currency_value} * {DBT_INR_TO_USD_RATE}
    WHEN {current_currency} ilike 'EUR' THEN {currency_value} * {DBT_EUR_TO_USD_RATE}
    WHEN {current_currency} ilike 'GBP' THEN {currency_value} * {DBT_GBP_TO_USD_RATE}
    WHEN {current_currency} ilike 'USD' THEN {currency_value}
END
".format(
    current_currency = current_currency,
    currency_value = currency_value,
    DBT_AED_TO_USD_RATE = env_var('DBT_AED_TO_USD_RATE'),
    DBT_INR_TO_USD_RATE = env_var('DBT_INR_TO_USD_RATE'),
    DBT_EUR_TO_USD_RATE = env_var('DBT_EUR_TO_USD_RATE'),
    DBT_GBP_TO_USD_RATE = env_var('DBT_GBP_TO_USD_RATE')
)-}}
{% endmacro %}