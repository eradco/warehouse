{% macro create_ctes_and_unions_list_from_tables(tables, schemas, cte_names, required_columns, cte_query_template='SELECT \n{columns},\n{meta_columns}\nFROM {schema}.{table}', customer_ids=[], where_clause='') %}
    {% set ctes = [] %}
    {% set cte_selects = [] %}
    {% for table_name in tables %}
        {% set i = loop.index-1 %}
        {% set table_name = '"{}"'.format(table_name|upper) %}
        {% set schema_name = '"{}"'.format(schemas[i]|upper) %}
        {% set cte_name = cte_names[i] %}
        {{ cte_selects.append("SELECT * FROM {}".format(cte_name) ) }}

        {# Adding metadate to CTE #}
        {% if customer_ids|length >0 %}
            {% set customer_id = customer_ids[i] %}
            {% set meta_columns = "'{}' as erad_schema,\n'{}' as erad_table,\n{} as erad_customer_id".format(schema_name, table_name, customer_id) %}
        {% else %}
            {% set meta_columns = "'{}' as erad_schema,\n'{}' as erad_table".format(schema_name, table_name) %}
        {% endif %}

        {% set cte_query = cte_query_template.format(schema=schema_name, table=table_name, columns= required_columns|join(",\n"), meta_columns=meta_columns) %}
        {% set cte = "{cte_name} as (\n{cte_query})\n".format(cte_name=cte_name, cte_query=cte_query) %}
        {{ ctes.append(cte) }}
    {% endfor %}

    {{ return({
        "ctes" : ctes,
        "cte_selects" : cte_selects
    })}}

{% endmacro %}