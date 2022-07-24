#! /usr/bin/env python
import os
import sys
from snowflake_queries import setup_logging, snowflake_cursor, execute_sql, APP_ROLE, APP_USER, APP_INTEGRATION

log = setup_logging(__name__)


UP_SQL = f"""
create or replace security integration {APP_INTEGRATION}
    type=oauth
    enabled=true
    oauth_client=CUSTOM
    oauth_client_type='CONFIDENTIAL'
    oauth_redirect_uri='https://oauth.pstmn.io/v1/browser-callback'
    blocked_roles_list = ('SYSADMIN','ERAD_DEV_ADMIN','ERAD_PROD_ADMIN','ERAD_TEST_ADMIN')
    oauth_issue_refresh_tokens=true
    oauth_refresh_token_validity=31536000 ;;

ALTER USER {APP_USER} ADD DELEGATED AUTHORIZATION
    OF ROLE {APP_ROLE}
    TO SECURITY INTEGRATION {APP_INTEGRATION} ;;

--desc integration {APP_INTEGRATION};
--select SYSTEM$SHOW_OAUTH_CLIENT_SECRETS({APP_INTEGRATION})

""" 

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
