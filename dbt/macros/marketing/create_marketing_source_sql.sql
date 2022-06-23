{% macro create_marketing_source_sql(marketing_channel, marketing_table, required_columns, 
                                    currency_column='', currency_keys='', currency_table='', 
                                    timezone_column='', timezone_table='', timezone_keys='') %}

-- Getting All possible marketing tables
{% set tables %}
   {{ get_marketing_tables(
                        marketing_channel = marketing_channel, 
                        marketing_table = marketing_table, 
                        currency_table = currency_table, 
                        timezone_table = timezone_table) }}
{% endset %}

-- Setting Base Schemas
{% set base_tables_schema = tables.columns[0].values() %}
{% set base_tables_name= tables.columns[1].values() %}
{% set customer_ids = tables.columns[2].values() %}
{% set col_index = 2 %}

-- Setting Currency Schemas
{% if currency_table !='' %}
    {% set col_index = col_index + 1 %}
    {% set currency_tables_schema = tables.columns[col_index].values() %}
    {% set col_index = col_index + 1 %}
    {% set currency_tables_schema = tables.columns[col_index].values() %}
{% endif %}

-- Setting Timezone Schemas
{% if timezone_table !='' %}
    {% set col_index = col_index + 1 %}
    {% set  timezone_tables_schema = tables.columns[col_index].values() %}
    {% set col_index = col_index + 1 %}
    {% set  timezone_tables_schema = tables.columns[col_index].values() %}
{% endif %}

-- Building the base CTEs #TODO Check for required columns
{% set base_ctes %}
    {% for table_name in  base_tables_name %}
        {% set schema_name = base_tables_schema[loop.index] %}
        {% set customer_id = customer_ids[loop.index] %}
        {{  create_cte_from_source_sql(required_columns, schema_name, table_name, cte_name, where_clause='') }}
    {% endfor %}
{% endset %}







-- Set revenue column

-- Set revenue calculation

-- Identify required columns

-- Identify all of the source fact tables 

-- Identify all of the source currency tables

{% endmacro %}