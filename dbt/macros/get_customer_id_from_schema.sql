{% macro get_customer_id_from_schema(column) %}
    {% set regex_str = "c(.*?)_" %}
    "REGEX_INSTR(" ~  column ~ "," ~ regex_str  ~ ")" 
{% endmacro %}