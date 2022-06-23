{% macro get_marketing_tables(marketing_channel, marketing_table, currency_table='', timezone_table='') %}

    {{ log("Getting marketing tables for {}".format(marketing_channel) ) }}
    -- Identifying the base tables to use
    {% set base_tables_sql %}
        {{ list_all_matching_tables_sql(marketing_channel, marketing_table, 'base_table') }}
    {% endset %}

    -- Identifying the currency tables
    {% set currency_tables_sql %}
        {{ list_all_matching_tables_sql(marketing_channel, currency_table, 'currency_table') }}
    {% endset %}

    -- Identifying timezone tables
    {% set timezone_tables_sql %}
        {{ list_all_matching_tables_sql(marketing_channel, timezone_table, 'timezone_table') }}
    {% endset %}

    -- All Marketing Tables
        WITH 
        BASE_TABLES as (
            {{base_tables_sql}}
        )

        {% if currency_table != '' %}
            ,CURRENCY_TABLES as (
                {{currency_tables_sql}}
            )
        {% endif %}

        {% if timezone_table != '' %}
            ,TIMEZONE_TABLES as (
            {{timezone_tables_sql}}
            )
        {% endif %}


        SELECT DISTINCT
        BASE_TABLES.TABLE_SCHEMA                       as BASE_SCHEMA
        ,BASE_TABLES.TABLE_NAME                        as BASE_TABLE_NAME
        ,BASE_TABLES.CUSTOMER_ID                       as CUSTOMER_ID

        {% if currency_table != '' %}
        -- Adding Currency Tables
        ,CURRENCY_TABLES.TABLE_SCHEMA           as CURRENCY_SCHEMA
        ,CURRENCY_TABLES.TABLE_NAME             as CURRENCY_TABLE_NAME
        {% endif %}

        {% if timezone_table != '' %}
        -- Adding Timezone Tables
        ,TIMEZONE_TABLES.TABLE_SCHEMA           as TIMEZONE_SCHEMA
        ,TIMEZONE_TABLES.TABLE_NAME             as TIMEZONE_TABLE_NAME
        {% endif %}

        FROM BASE_TABLES

        {% if currency_table != '' %}
        INNER JOIN CURRENCY_TABLES ON (BASE_TABLES.CUSTOMER_ID = CURRENCY_TABLES.CUSTOMER_ID)
        {% endif %}

        {% if timezone_table != '' %}
        INNER JOIN TIMEZONE_TABLES ON (BASE_TABLES.CUSTOMER_ID = TIMEZONE_TABLES.CUSTOMER_ID)
        {% endif %}

        WHERE BASE_TABLES.CUSTOMER_ID is not null


{% endmacro %}
