#! /usr/bin/env python
import os
import sys
from snowflake_queries import setup_logging, snowflake_cursor, execute_sql, APP_ROLE

log = setup_logging(__name__)

GRANTS = f"""
grant usage on procedure ANALYTICS.GET_REVENUE_SUMMARY(varchar,varchar) to role {APP_ROLE} ;;
grant usage on procedure ANALYTICS.BUILD_ADS_JSON(varchar) to role {APP_ROLE} ;;
"""

UP_SQL = """
CREATE OR REPLACE FUNCTION analytics.construct_json_from_arrays(json_keys array, json_values array)
  RETURNS variant
  LANGUAGE JAVASCRIPT
AS
$$
    var json_transform = {}
    for (var i = 0; i < JSON_ARRAY.length; i++) {
        k= JSON_ARRAY[i]
        v= JSON_VALUES[i]
        json_transform[k] = v
      }
  return str(json_transform)
$$ ;;


CREATE OR REPLACE PROCEDURE ANALYTICS.BUILD_ADS_JSON(LOOKBACKDAYS VARCHAR)
RETURNS VARCHAR
               
LANGUAGE JAVASCRIPT as
$$
var base_results_sql = `
      SELECT DISTINCT
      CUSTOMER_ID,
      AD_CHANNEL,
      SUM(EXPENSES) OVER (PARTITION BY CUSTOMER_ID,AD_CHANNEL) as AD_EXPENSES,
      SUM(EXPENSES) OVER (PARTITION BY CUSTOMER_ID) as TOTAL_EXPENSES
    FROM 
        ANALYTICS.FCT_REVENUE_SUMMARY
    WHERE
        date between dateadd(day, -${LOOKBACKDAYS}, current_date()) and current_date()  
`

var base_results = snowflake.createStatement({sqlText: base_results_sql}).execute()
var base_obj = {}

while (base_results.next()){
    var customer_id = base_results.getColumnValue("CUSTOMER_ID")
    var ad_channel = base_results.getColumnValue("AD_CHANNEL")
    var ad_expenses = base_results.getColumnValue("AD_EXPENSES")
    var total_expenses = base_results.getColumnValue("TOTAL_EXPENSES")
    
    if (typeof base_obj[parseInt(customer_id)] == 'undefined'){
        base_obj[customer_id] = {}
    }
    
    if (ad_channel != null){
        base_obj[customer_id][ad_channel] = ad_expenses / total_expenses
    }
    
}

return JSON.stringify(base_obj)
$$ ;;



CREATE OR REPLACE PROCEDURE ANALYTICS.GET_REVENUE_SUMMARY(LOOKBACKDAYS VARCHAR, CUSTOMER_ID varchar)
RETURNS ARRAY
               
LANGUAGE JAVASCRIPT as
$$
var NEGATIVE_LOOKBACKDAYS = '-' + LOOKBACKDAYS

var ads_json_results = snowflake.createStatement({sqlText: "Call ANALYTICS.BUILD_ADS_JSON((?))", binds: [LOOKBACKDAYS]}).execute()
ads_json_results.next()

var ads_json = JSON.parse(ads_json_results.getColumnValue(1))

var customer_stmt = snowflake.createStatement(
            {sqlText: `SELECT 
                CUSTOMER_ID,
                CURRENCY_CODE,
                ARRAY_AGG(DISTINCT AD_CHANNEL) as AD_CHANNELS,
                ARRAY_AGG(DISTINCT REVENUE_SOURCE) as REVENUE_SOURCES,
                SUM(REVENUE) as TOTAL_REVENUE,
                SUM(EXPENSES) as AD_EXPENSES,
                DIV0( SUM(EXPENSES),SUM(TRANSACTIONS) ) as CAC,
                DIV0( SUM(REVENUE), SUM(EXPENSES) ) as ROAS,
                DIV0( SUM(TRANSACTIONS), SUM(CLICKS) ) as CONVERSION_RATE,
                MAX(CASE WHEN REVENUE_SOURCE IS NOT NULL THEN ERAD_UPDATED_AT END) as REVENUE_LAST_UPDATED_AT,
                MAX(CASE WHEN AD_CHANNEL IS NOT NULL THEN ERAD_UPDATED_AT END) as AD_CHANNEL_LAST_UPDATED_AT
                FROM ANALYTICS.FCT_REVENUE_SUMMARY
WHERE 
customer_id = (?) and
date between dateadd(day, (?), current_date()) and current_date()
GROUP BY
1,2`,
binds: [CUSTOMER_ID,NEGATIVE_LOOKBACKDAYS]})


var no_customer_stmt = snowflake.createStatement(
            {sqlText: `SELECT 
                CUSTOMER_ID,
                CURRENCY_CODE,
                ARRAY_AGG(DISTINCT AD_CHANNEL) as AD_CHANNELS,
                ARRAY_AGG(DISTINCT REVENUE_SOURCE) as REVENUE_SOURCES,
                SUM(REVENUE) as TOTAL_REVENUE,
                SUM(EXPENSES) as AD_EXPENSES,
                DIV0( SUM(EXPENSES),SUM(TRANSACTIONS) ) as CAC,
                DIV0( SUM(REVENUE), SUM(EXPENSES) ) as ROAS,
                DIV0( SUM(TRANSACTIONS), SUM(CLICKS) ) as CONVERSION_RATE,
                MAX(CASE WHEN REVENUE_SOURCE IS NOT NULL THEN ERAD_UPDATED_AT END) as REVENUE_LAST_UPDATED_AT,
                MAX(CASE WHEN AD_CHANNEL IS NOT NULL THEN ERAD_UPDATED_AT END) as AD_CHANNEL_LAST_UPDATED_AT
                FROM ANALYTICS.FCT_REVENUE_SUMMARY
WHERE 
date between dateadd(day, (?), current_date()) and current_date()
GROUP BY
1,2`,
binds: [NEGATIVE_LOOKBACKDAYS]})

if(CUSTOMER_ID != ''){
    resultSet = customer_stmt.execute()
}
else{
    resultSet = no_customer_stmt.execute()
}

var results = []
while (resultSet.next()){
var CUSTOMER_ID = resultSet.getColumnValue("CUSTOMER_ID")
var values = {
    "CUSTOMER_ID" : CUSTOMER_ID,
    "CURRENCY_CODE" : resultSet.getColumnValue("CURRENCY_CODE"),
    "AD_CHANNELS" : resultSet.getColumnValue("AD_CHANNELS"),
    "REVENUE_SOURCES" : resultSet.getColumnValue("REVENUE_SOURCES"),
    "TOTAL_REVENUE" : resultSet.getColumnValue("TOTAL_REVENUE"),
    "AD_EXPENSES" : resultSet.getColumnValue("AD_EXPENSES"),
    "CAC" : resultSet.getColumnValue("CAC"),
    "ROAS" : resultSet.getColumnValue("ROAS"),
    "CONVERSION_RATE" : resultSet.getColumnValue("CONVERSION_RATE"),
    "TOP_AD_SOURCES_PCT" : ads_json[CUSTOMER_ID] ?? {},
    "REVENUE_LAST_UPDATED_AT" : resultSet.getColumnValue("REVENUE_LAST_UPDATED_AT"),
    "AD_CHANNEL_LAST_UPDATED_AT" : resultSet.getColumnValue("AD_CHANNEL_LAST_UPDATED_AT"),
} 
results.push(values)
}
return results
$$ ;;

""" + GRANTS

DOWN_SQL = """
--None
"""


def upgrade():
    log.info('Upgrading %s', __file__)
    with snowflake_cursor() as cur:
        execute_sql(cur, UP_SQL)


def downgrade():
    log.info('Downgrading %s', __file__)
    with snowflake_cursor() as cur:
        execute_sql(cur, DOWN_SQL)


def main(argv):
    if len(argv) == 1:
        upgrade()
    else:
        arg = argv[1].lower()
        if arg == 'upgrade':
            upgrade()
        elif arg == 'downgrade':
            downgrade()


if __name__ == '__main__':  # pragma: no cover
    main(sys.argv)
