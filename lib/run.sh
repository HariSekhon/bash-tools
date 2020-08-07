#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2019-12-20 16:01:28 +0000 (Fri, 20 Dec 2019)
#
#  https://github.com/harisekhon/bash-tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback
#
#  https://www.linkedin.com/in/harisekhon
#

# Helper script for calling from vim function to run programs or execute with args extraction
#
# Runs the value of the 'run:' header from the given file

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# #  run: <output this bit>
# // run: <output this bit>
run_cmd="$(perl -ne 'if(/^\s*(#|\/\/)\s*run:/){s/^\s*(#|\/\/)\s*run:\s*//; print $_; exit}' "$1")"

if [ -n "$run_cmd" ]; then
    cd "$(dirname "$1")"
    eval "$run_cmd"
else
    eval "$1" "$("$srcdir/args_extract.sh" "$1")"
fi
