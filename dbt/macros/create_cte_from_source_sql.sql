{% macro create_cte_from_source_sql(columns, schema_name, table_name, cte_name, where_clause='') %}

{% set columns_str %}
    {{ columns|join(',\n') }}
{% endset %}

{{ cte_name }} as (
    SELECT
    {{ columns_str }}
    FROM {{schema_name}}.{{table_name}}

    {% if where_clause!= '' %}
        {{ where_clause }}
    {% endif %}
)

{% endmacro %}