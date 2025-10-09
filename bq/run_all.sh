#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/env"
echo "Using project: $PROJECT_ID, dataset: $DATASET"
bq --location=$LOCATION --project_id=$PROJECT_ID mk -d $DATASET || true
bq --project_id=$PROJECT_ID query --use_legacy_sql=false < ./sql/10_views_analysis.sql
echo "Done. Connect Looker Studio to $PROJECT_ID.$DATASET views"
