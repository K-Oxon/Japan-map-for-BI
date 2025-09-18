set -eu

# データ取得
URL="https://data.address-br.digital.go.jp/mt_city/mt_city_all.csv.zip"

curl -L $URL | ditto -x -k - processing/intermediate_data/data_source/da_abr

# データを読み込む
duckdb processing/intermediate_data/ddb/dwh.duckdb -c \
  "create or replace table da_abr.mt_city_all as select * from read_csv('processing/intermediate_data/data_source/da_abr/mt_city_all.csv')"
