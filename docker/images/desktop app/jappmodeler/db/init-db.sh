#!/bin/bash
set -e

pg_restore -d dbappmodeler docker-entrypoint-initdb.d/dbappmodeler.backup


