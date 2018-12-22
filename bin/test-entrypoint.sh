#!/bin/bash
export PATH=$PATH:~/.local/bin

# http://linuxcommand.org/lc3_man_pages/seth.html:
# -e  Exit immediately if a command exits with a non-zero status.
set -e

# Collect static files
python -Wall manage.py collectstatic --noinput

# apply any migrations
python -Wall manage.py migrate --noinput

pytest -n 4