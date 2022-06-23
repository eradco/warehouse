{% macro create_ctes_and_unions_list_from_tables(cte_names, queries) %}
    {% set ctes = [] %}
    {% set cte_selects = [] %}
    {% for table_name in tables %}
        {% set i = loop.index-1 %}
        {% set cte_name = cte_names[i] %}

        {{ cte_selects.append('SELECT * FROM ' ~ cte_name) }}
        {{ set cte = queries[i] }}

        {% set cte = create_cte_from_source_sql(required_columns, schema_name, table_name, cte_name, where_clause=where_clause) %}
        {{ ctes.append(cte) }}
    {% endfor %}

    {{ return({
        "ctes" : ctes,
        "cte_selects" : cte_selects
    })}}

{% endmacro %}