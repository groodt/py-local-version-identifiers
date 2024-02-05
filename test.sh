#!/usr/bin/env bash
# shellcheck shell=bash

set -eu -o pipefail

get_dependencies_to_install() {
  python -m pip install \
    --disable-pip-version-check \
    --quiet \
    --dry-run \
    --ignore-installed \
    --report - \
    --index http://127.0.0.1:8000 \
    --requirement ./requirements.in \
  | \
  jq \
    .install
}

main() {
  echo "START!"

  if lsof -Pi :8000 -sTCP:LISTEN -t >/dev/null ; then
      echo "simpleindex is running..."
  else
      echo "Please run 'simpleindex fakeindex/configuration.toml' before running this script"
      exit 1
  fi

  local deps_to_install
  deps_to_install=$(get_dependencies_to_install)

  if diff <( printf '%s\n' "${deps_to_install}" ) expected.json ; then
    echo "Dependencies matched expected.json"
  else
    echo "Dependencies did not match expected.json"
    exit 1
  fi

  echo "END!"
}

main "$@"