#! /bin/bash

# http://linuxcommand.org/lc3_man_pages/seth.html:
# -e  Exit immediately if a command exits with a non-zero status.
set -e

echo Debug: $DEBUG

# Pull in environment variables values from AWS Parameter Store
/code/bin/get-ssm-parameters.sh

python -Wall manage.py collectstatic --noinput

gunicorn $PROJECT_NAME.wsgi -c gunicorn_config.py
