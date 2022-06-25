WITH
{{ build_fivetran_ctes_from_one_schema_table(
    schema_base_name = 'facebook', 
    table_name = 'REACH_FREQUENCY', 
    columns = ['COUNTRY_CODE', 'ACCOUNT_ID', 'MIN_REACH_LIMITS', 'MAX_DAYS_TO_FINISH', 'MIN_CAMPAIGN_DURATION', 'MAX_CAMPAIGN_DURATION'],
    cte_prefix='base') }}

    
SELECT * FROM BASE_UNION
