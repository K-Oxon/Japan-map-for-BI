set -eu

# データ取得
URL="https://nlftp.mlit.go.jp/ksj/gml/data/N03/N03-2025/N03-20250101_GML.zip"

curl -L $URL | ditto -x -k - processing/intermediate_data/data_source/mlit

# データを読み込む
# duckdb processing/intermediate_data/ddb/dwh.duckdb -f processing/ingestion/mlit/load.sql
