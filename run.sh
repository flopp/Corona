#!/usr/bin/env bash

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

python3 -m venv .env
.env/bin/pip install --upgrade pip
.env/bin/pip install --upgrade --requirement requirements.txt

mkdir -p ard-data
gsutil rsync -d -r gs://brdata-public-data/rki-corona-archiv/ ard-data

mkdir -p archive-ard
(cd ard-data/2_parsed && $DIR/.env/bin/python $DIR/convertARD.py -d $DIR/archive-ard/ *.xz)
