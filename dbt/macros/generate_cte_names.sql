{% macro generate_cte_names(base_name, value_list) %}
    {% set names = [] %}
    {% for value_name in value_list %}
        {{ names.append(base_name ~ "_" ~ value_name ) }}
    {% endfor %}
    {{ return(names) }}
{% endmacro %}