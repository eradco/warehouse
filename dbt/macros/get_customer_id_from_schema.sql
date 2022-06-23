{% macro get_customer_id_from_schema(schema_name, client_prefix='C') %}
    {{ "TRY_TO_NUMBER(REPLACE(LEFT({schema}, POSITION('_' IN {schema})-1), '{client_prefix}'))".format(schema=schema_name, client_prefix=client_prefix) }}
{% endmacro %}