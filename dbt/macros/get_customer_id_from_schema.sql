{% macro list_all_matching_schema(column) %}

    -- Setting the regex string to match customers to
    {% set regex_str = "c(.*?)_" %}

    -- Creating the sql string
    {% set sql_query = "REGEX_INSTR(" ~  column ~ "," ~ regex_str  ~ ")" %}
    
{% endmacro %}