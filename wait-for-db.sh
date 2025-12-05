#!/bin/bash
# wait-for-db.sh
set -e

host="$1"
shift
cmd="$@"

until nc -z -v -w30 $host 3306; do
  echo "Esperant DB... (${host}:3306)"
  sleep 1
done

echo "DB llesta! Executant: $cmd"
exec $cmd
