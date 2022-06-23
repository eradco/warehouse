{% macro create_marketing_source_sql(marketing_channel, marketing_table, required_columns, 
                                    currency_column='', currency_keys='', currency_table='', currency_sql='',
                                    timezone_column='', timezone_table='', timezone_sql='', timezone_keys='') %}

-- Getting All possible marketing tables
{{ log("Compiling {} base sql...".format(marketing_channel) ) }}
{% set tables_sql %}
   {{ get_marketing_tables(
                        marketing_channel = marketing_channel, 
                        marketing_table = marketing_table, 
                        currency_table = currency_table, 
                        timezone_table = timezone_table) }}
{% endset %}

{% if execute %}
    {% set tables=run_query(tables_sql)  %}

    -- Setting Base Schemas 
    {% set  base_tables_schema = tables.columns[0].values() %}
    {% set  base_tables_name= tables.columns[1].values() %}
    {% set  customer_ids = tables.columns[2].values() %}
    {% set col_index = 2 %}

    {{ log("Processing {} reports for {} erad customers:\n{}".format(marketing_channel, tables|length,  customer_ids|join('\n') ) ) }}

    -- Setting Currency Schemas
    {% if currency_table !='' %}
        {% set col_index = col_index + 1 %}
        {% set  currency_tables_schema = tables.columns[col_index].values() %}
        {% set col_index = col_index + 1 %}
        {% set  currency_tables_schema = tables.columns[col_index].values() %}
    {% endif %}

    -- Setting Timezone Schemas
    {% if timezone_table !='' %}
        {% set col_index = col_index + 1 %}
        {% set  timezone_tables_schema = tables.columns[col_index].values() %}
        {% set col_index = col_index + 1 %}
        {% set  timezone_tables_schema = tables.columns[col_index].values() %}
    {% endif %}

    -- Building the base CTEs #TODO Check for required columns
    {% set base_ctes = [] %}
    {% set base_cte_selects = [] %}
    {% set codeblock %}
        {% for table_name in  base_tables_name %}
            {% set i = loop.index-1 %}
            {% set schema_name = base_tables_schema[i] %}
            {% set customer_id = customer_ids[i] %}
            {% set cte_name = 'base_' ~ customer_id %}
            {{ base_cte_selects.append('SELECT * FROM ' ~ cte_name) }}
            {% set cte = create_cte_from_source_sql(required_columns, schema_name, table_name, cte_name, where_clause='') %}
            {{ base_ctes.append(cte) }}
        {% endfor %}
    {% endset %}

    -- Building Currency CTEs
    {% set currency_ctes = [] %}
    {% set currency_cte_selects = [] %}
    {% set codeblock %}
        {% for table_name in  base_tables_name %}
            {% set i = loop.index-1 %}
            {% set schema_name = base_tables_schema[i] %}
            {% set customer_id = customer_ids[i] %}
            {% set cte_name = 'base_' ~ customer_id %}
            {{ base_cte_selects.append('SELECT * FROM ' ~ cte_name) }}
            {% set cte = create_cte_from_source_sql(required_columns, schema_name, table_name, cte_name, where_clause='') %}
            {{ base_ctes.append(cte) }}
        {% endfor %}
    {% endset %}

    -- Main SQL
    WITH
    {{ base_ctes|join(',\n') }}

    ,base_union as ({{ base_cte_selects|join('\nUNION ALL\n') }})

{% else %}
    {% set base_tables_schema = '' %}
{% endif %}

{% endmacro %}


