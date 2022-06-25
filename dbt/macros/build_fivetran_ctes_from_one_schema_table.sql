{% macro build_fivetran_ctes_from_one_schema_table(schema_base_name, table_name, columns, cte_prefix='base') %}

    {% if execute %}
        {# This macro creates ctes for all the tables matching the schema with the provided table #}

        {# Getting Tables and Customer Ids #}
        {%- set tables_sql = list_all_matching_tables_sql(schema_base_name, table_name) %}
        {%- set table_results = run_query(tables_sql) %}

        {%- set schemas = table_results.columns[0].values() %}
        {%- set tables = table_results.columns[1].values() %}
        {%- set customer_ids = table_results.columns[2].values() %}
        {{ log("Compiling {} reports for {} erad customers:\n{}".format(schema_base_name, tables|length,  customer_ids|join('\n') ) ) }}

        {# Creating the source sql compiler elements #}
        {%- set cte_names = generate_cte_names(
                                            base_name = cte_prefix, 
                                            value_list = customer_ids
                                            ) %}

        {%- set ctes_dict = create_ctes_and_unions_list_from_tables(
                                                                tables = table_results.columns[0].values(), 
                                                                schemas = table_results.columns[1].values(), 
                                                                cte_names = cte_names, 
                                                                required_columns = columns) %}

        -- Start of {{cte_prefix}} CTEs
        {{ ctes_dict['ctes']|join(',\n') }}
        ,{{cte_prefix}}_union as ({{ ctes_dict['cte_selects']|join('\nUNION ALL\n') }})
        -- END of {{cte_prefix}} CTEs

    {%- else %}
        Select 1 as a
    {%- endif %}

{% endmacro %}