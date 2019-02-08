#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  ALTER USER postgres WITH PASSWORD '';
  CREATE DATABASE rodrouter_test;
  CREATE DATABASE rodrouter_development;
  GRANT ALL PRIVILEGES ON DATABASE rodrouter_test TO postgres;
  GRANT ALL PRIVILEGES ON DATABASE rodrouter_development TO postgres;
EOSQL
