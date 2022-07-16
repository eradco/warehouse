{% macro check_and_set_not_existing_columns(table_name, table_schema, required_columns, default_value='null') %}
    {% set columns_query="SELECT DISTINCT UPPER(COLUMN_NAME) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA ilike '{table_schema}' and TABLE_NAME ilike '{table_name}'".format(
                                                                                                                                                    table_schema=table_schema.replace('"',''),
                                                                                                                                                    table_name=table_name.replace('"','')) %}
    {% set table_columns=run_query(columns_query).columns[0].values() %} 
    {% set mapped_columns = [] %}
    {% for col in required_columns %}
        {% if col.upper() in table_columns  %}
            {{ mapped_columns.append(col) }}
        {% else %}
            {{ log("Table {}.{} missing column {}".format(table_schema, table_name, col) )  }}
            {{ mapped_columns.append("{default_value} AS {col}".format(col=col, default_value=default_value) ) }}
        {% endif %}
    {% endfor %}

    {{ return(mapped_columns) }}

{% endmacro %}