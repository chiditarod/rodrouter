#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  ALTER USER postgres WITH PASSWORD '';
  CREATE DATABASE cartographer_test;
  CREATE DATABASE cartographer_development;
  GRANT ALL PRIVILEGES ON DATABASE cartographer_test TO postgres;
  GRANT ALL PRIVILEGES ON DATABASE cartographer_development TO postgres;
EOSQL
