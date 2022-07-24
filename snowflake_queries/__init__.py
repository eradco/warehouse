import os
import snowflake.connector
from contextlib import contextmanager
import time
import logging
import sys

# Constant Variables
SNOWFLAKE_ACCOUNT = os.environ['SNOWFLAKE_ACCOUNT']
SNOWFLAKE_DATABASE = os.environ['SNOWFLAKE_DATABASE']
SNOWFLAKE_USER = os.environ['SNOWFLAKE_USER']
SNOWFLAKE_PASSWORD = os.environ['SNOWFLAKE_PASSWORD']
SNOWFLAKE_WAREHOUSE = os.environ['SNOWFLAKE_WAREHOUSE']

APP_ROLE = os.environ['SNOWFLAKE_APP_ROLE']
APP_USER= os.environ['SNOWFLAKE_APP_USER']
APP_INTEGRATION= os.environ['SNOWFLAKE_APP_INTEGRATION_NAME']

# Schemas
ANALYTICS_SCHEMA = 'analytics'


def setup_logging(module=None, level=logging.INFO):  # pragma: no cover
    """Configures the given logger (or the root logger) to output to the supplied
    stream (or standard out) at the supplied logging level (or INFO).  Also
    configures all additional loggers."""
    logger = logging.getLogger(module or '')
    logger.setLevel(level)
    logging.Formatter.converter = time.gmtime
    formatter = logging.Formatter(
        '%(asctime)s - %(name)s - %(processName)s - %(levelname)s - %(message)s'
    )
    stream_handler = logging.StreamHandler(sys.stderr)
    stream_handler.setLevel(level)
    stream_handler.setFormatter(formatter)
    logger.addHandler(stream_handler)
    return logger


log = setup_logging(__name__)


def snowflake_connection():
    return snowflake.connector.connect(
        account=SNOWFLAKE_ACCOUNT,
        user=SNOWFLAKE_USER,
        password=SNOWFLAKE_PASSWORD,
        database=SNOWFLAKE_DATABASE,
        warehouse=SNOWFLAKE_WAREHOUSE,
        role='SYSADMIN',
        autocommit=False
    )


@contextmanager
def snowflake_cursor():
    with snowflake_connection() as conn:
        yield conn.cursor(snowflake.connector.DictCursor)


def execute_sql(cursor, sql, verbose=True, sql_vars=None):
    """
    sql: string of one or more sql commands
    sql_vars: list if %s style replacement strings were used.
              dict if %(varname)s style replacement strings were used.
    Snowflake cursors can only execute one sql command at a time,
    this parses multiple statements into individual commands.
    """
    all_sql = sql.split(';;')
    for sqlcmd in all_sql:
        # Ignore any trailing whitespace that shows up as the final item
        if sqlcmd.strip():
            sqlcmd = sqlcmd + ';'
            if verbose:
                log.info('Executing sql: %s', sqlcmd)
            cursor.execute(sqlcmd, sql_vars)