#!/bin/bash

set -eu

from=$1

ROOT=$(git rev-parse --show-toplevel)

find "$from" -name '*.json' | xargs -n1 "$ROOT/scripts/format-json.sh"


