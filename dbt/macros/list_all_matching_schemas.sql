{% macro list_all_matching_schemas(base_name) %}
    -- Creating SQL
    {% set info_table = 'INFORMATION_SCHEMA.TABLES' %}

    {% set query %}
        SELECT
        TABLE_SCHEMA,
        TABLE_NAME,
        {{ get_customer_id_from_schema('TABLE_SCHEMA') }} as CUSTOMER_ID

        FROM {{ info_table }}
        WHERE CUSTOMER_ID IS NOT NULL
    {% endset %}

    {% set results = run_query(query) %}

    {{ return(results) }}

{% endmacro %}
