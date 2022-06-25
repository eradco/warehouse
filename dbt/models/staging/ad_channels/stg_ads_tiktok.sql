WITH
{{ build_fivetran_ctes_from_one_schema_table(
    schema_base_name = 'TIKTOK_ADS', 
    table_name = 'AD_REPORT_DAILY', 
    columns = ['AD_ID',	'STAT_TIME_DAY',	'REAL_TIME_RESULT',	'SKAN_TOTAL_SALES_LEAD',	'SALES_LEAD',	'TOTAL_SALES_LEAD_VALUE',	'COST_PER_CONVERSION',	'COST_PER_1000_REACHED',	'CLICKS',	'RESULT_RATE',	'COST_PER_RESULT',	'CPC',	'VIDEO_VIEWS_P_100',	'RESULT',	'SKAN_SALES_LEAD',	'REAL_TIME_CONVERSION',	'PROFILE_VISITS',	'SPEND',	'SECONDARY_GOAL_RESULT_RATE',	'CONVERSION',	'VIDEO_VIEWS_P_25',	'TOTAL_SALES_LEAD',	'VIDEO_WATCHED_2_S',	'SKAN_TOTAL_SALES_LEAD_VALUE',	'LIKES',	'CTR',	'REAL_TIME_COST_PER_RESULT',	'IMPRESSIONS',	'VIDEO_VIEWS_P_50',	'COST_PER_SECONDARY_GOAL_RESULT',	'REAL_TIME_CONVERSION_RATE',	'VIDEO_VIEWS_P_75',	'FOLLOWS',	'COMMENTS',	'REAL_TIME_COST_PER_CONVERSION',	'PROFILE_VISITS_RATE',	'SHARES',	'TOTAL_PURCHASE',	'AVERAGE_VIDEO_PLAY',	'CONVERSION_RATE',	'VIDEO_WATCHED_6_S',	'SKAN_CONVERSION',	'CPM',	'TOTAL_PURCHASE_VALUE',	'AVERAGE_VIDEO_PLAY_PER_USER',	'VIDEO_PLAY_ACTIONS',	'REACH',	'SKAN_COST_PER_CONVERSION',	'REAL_TIME_RESULT_RATE',	'SECONDARY_GOAL_RESULT',	'_FIVETRAN_SYNCED'],
    cte_prefix='base') }}

,{{ build_fivetran_ctes_from_one_schema_table(
    schema_base_name = 'TIKTOK_ADS', 
    table_name = 'ADVERTISER', 
    columns = ['ID', 'NAME', 'CURRENCY', 'TIMEZONE'],
    cte_prefix='ACCOUNT',
    cte_query_template = '
    SELECT DISTINCT
    ID,
    FIRST_VALUE(NAME) over (partition by ID order by CREATE_TIME desc) as ACCOUNT_NAME,
    FIRST_VALUE(CURRENCY) over (partition by ID order by CREATE_TIME desc) as CURRENCY,
    FIRST_VALUE(TIMEZONE) over (partition by ID order by CREATE_TIME desc) as TIMEZONE_NAME,
    {meta_columns} 
    FROM {schema}.{table} 
    LIMIT 1') }}
    
SELECT 
BASE_UNION.ERAD_CUSTOMER_ID,
ACCOUNT_UNION.CURRENCY,
ACCOUNT_UNION.TIMEZONE_NAME,
{{ convert_to_erad_tz('STAT_TIME_DAY', 'ACCOUNT_UNION.TIMEZONE_NAME') }} as ERAD_TIMESTAMP,
BASE_UNION.AD_ID,
BASE_UNION.STAT_TIME_DAY,
BASE_UNION.REAL_TIME_RESULT,
BASE_UNION.SKAN_TOTAL_SALES_LEAD,
BASE_UNION.SALES_LEAD,
BASE_UNION.TOTAL_SALES_LEAD_VALUE,
BASE_UNION.COST_PER_CONVERSION,
BASE_UNION.COST_PER_1000_REACHED,
BASE_UNION.CLICKS,
BASE_UNION.RESULT_RATE,
BASE_UNION.COST_PER_RESULT,
BASE_UNION.CPC,
BASE_UNION.VIDEO_VIEWS_P_100,
BASE_UNION.RESULT,
BASE_UNION.SKAN_SALES_LEAD,
BASE_UNION.REAL_TIME_CONVERSION,
BASE_UNION.PROFILE_VISITS,
BASE_UNION.SPEND,
BASE_UNION.SECONDARY_GOAL_RESULT_RATE,
BASE_UNION.CONVERSION,
BASE_UNION.VIDEO_VIEWS_P_25,
BASE_UNION.TOTAL_SALES_LEAD,
BASE_UNION.VIDEO_WATCHED_2_S,
BASE_UNION.SKAN_TOTAL_SALES_LEAD_VALUE,
BASE_UNION.LIKES,
BASE_UNION.CTR,
BASE_UNION.REAL_TIME_COST_PER_RESULT,
BASE_UNION.IMPRESSIONS,
BASE_UNION.VIDEO_VIEWS_P_50,
BASE_UNION.COST_PER_SECONDARY_GOAL_RESULT,
BASE_UNION.REAL_TIME_CONVERSION_RATE,
BASE_UNION.VIDEO_VIEWS_P_75,
BASE_UNION.FOLLOWS,
BASE_UNION.COMMENTS,
BASE_UNION.REAL_TIME_COST_PER_CONVERSION,
BASE_UNION.PROFILE_VISITS_RATE,
BASE_UNION.SHARES,
BASE_UNION.TOTAL_PURCHASE,
BASE_UNION.AVERAGE_VIDEO_PLAY,
BASE_UNION.CONVERSION_RATE,
BASE_UNION.VIDEO_WATCHED_6_S,
BASE_UNION.SKAN_CONVERSION,
BASE_UNION.CPM,
BASE_UNION.TOTAL_PURCHASE_VALUE,
BASE_UNION.AVERAGE_VIDEO_PLAY_PER_USER,
BASE_UNION.VIDEO_PLAY_ACTIONS,
BASE_UNION.REACH,
BASE_UNION.SKAN_COST_PER_CONVERSION,
BASE_UNION.REAL_TIME_RESULT_RATE,
BASE_UNION.SECONDARY_GOAL_RESULT,
BASE_UNION._FIVETRAN_SYNCED,
{{ convert_to_erad_currency('CURRENCY' ,'BASE_UNION.SPEND') }} as ERAD_COST,
BASE_UNION.ERAD_SCHEMA,
BASE_UNION.ERAD_TABLE,
current_timestamp()::timestamp_tz   as ERAD_UPDATED_AT
FROM BASE_UNION
INNER JOIN ACCOUNT_UNION ON (BASE_UNION.ERAD_CUSTOMER_ID = ACCOUNT_UNION.ERAD_CUSTOMER_ID)
