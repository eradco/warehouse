WITH
{{ build_fivetran_ctes_from_one_schema_table(
    schema_base_name = 'facebook_ads', 
    table_name = 'BASIC_CAMPAIGN', 
    columns = ['CAMPAIGN_ID','MONTH', '_FIVETRAN_ID', 'ACCOUNT_ID', 'IMPRESSIONS', 'INLINE_LINK_CLICKS', 'REACH', 'CPC', 'CPM', 'CTR', 'FREQUENCY', 'SPEND', 'CAMPAIGN_NAME', '_FIVETRAN_SYNCED',],
    cte_prefix='base') }}

,{{ build_fivetran_ctes_from_one_schema_table(
    schema_base_name = 'facebook_ads', 
    table_name = 'ACCOUNT_HISTORY', 
    columns = ['ACCOUNT_ID', 'CURRENCY', 'TIMEZONE_NAME'],
    cte_prefix='ACCOUNT',
    cte_query_template = '
    SELECT DISTINCT ID, 
    FIRST_VALUE(CURRENCY) over (partition by ID order by CREATED_TIME desc) as CURRENCY, 
    FIRST_VALUE(TIMEZONE_NAME) over (partition by ID order by CREATED_TIME desc) as TIMEZONE_NAME, 
    FIRST_VALUE(TIMEZONE_OFFSET_HOURS_UTC) over (partition by ID order by CREATED_TIME desc) as TIMEZONE_OFFSET_HOURS_UTC,
    {meta_columns} 
    FROM {schema}.{table}') }}
    
SELECT 
BASE_UNION.*,
ACCOUNT_UNION.CURRENCY,
ACCOUNT_UNION.TIMEZONE_NAME,
ACCOUNT_UNION.TIMEZONE_OFFSET_HOURS_UTC
FROM BASE_UNION
INNER JOIN ACCOUNT_UNION ON (BASE_UNION.ERAD_CUSTOMER_ID = ACCOUNT_UNION.ERAD_CUSTOMER_ID and BASE_UNION.ACCOUNT_ID = ACCOUNT_UNION.ID)
