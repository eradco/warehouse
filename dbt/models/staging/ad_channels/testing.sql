
{{
create_marketing_source_sql('facebook', 'REACH_FREQUENCY', ['COUNTRY_CODE', 'ACCOUNT_ID', 'MIN_REACH_LIMITS', 'MAX_DAYS_TO_FINISH', 'MIN_CAMPAIGN_DURATION', 'MAX_CAMPAIGN_DURATION'], 
                                    currency_column='CURRENCY', currency_keys='', currency_sql='ACCOUNT_HISTORY', 
                                    currency_table='ACCOUNT_HISTORY', timezone_table='ACCOUNT_HISTORY',
                                    timezone_column='TIMEZONE_NAME', timezone_sql='', timezone_keys='')
}}