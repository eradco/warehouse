{% macro convert_to_erad_currency(current_currency, currency_value) %}
"
CASE 
WHEN {current_currency} ilike 'AED' THEN {currency_value} * 0.2722570106
"

{% endmacro %}