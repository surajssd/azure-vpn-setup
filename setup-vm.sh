#!/usr/bin/env bash
# This file is used to setup OpenVPN access server.

set -euo pipefail

sudo apt update
sudo apt upgrade -y

sudo apt install -y --no-install-recommends python3-virtualenv

git clone https://github.com/trailofbits/algo
cd algo

python3 -m virtualenv --python="$(command -v python3)" .env && \
  source .env/bin/activate && \
  python3 -m pip install -U pip virtualenv && \
  python3 -m pip install -r requirements.txt

./algo

# Choose Local
# More information here: https://github.com/trailofbits/algo/blob/master/docs/deploy-to-ubuntu.md
