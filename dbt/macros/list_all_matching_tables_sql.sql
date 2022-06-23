{% macro list_all_matching_tables(base_name, table_name, category_name='') %}

    SELECT
        TABLE_SCHEMA,
        TABLE_NAME,
        {{ get_customer_id_from_schema(TABLE_SCHEMA) }} as CUSTOMER_ID
        {% if category_name !='' %}
        ,'{{ category_name }}' as category
        {% endif %}

        FROM {{ source("INFORMATION_SCHEMA", "TABLES") }}
        WHERE CUSTOMER_ID IS NOT NULL
        AND TABLE_NAME = '{{ table_name }}'
    {% endset %}


{% endmacro %}