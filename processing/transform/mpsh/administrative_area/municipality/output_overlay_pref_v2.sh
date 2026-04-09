# --- デュアルレイヤー版(1layer統合): 市区町村ポリゴン + 都道府県ポリゴン(市区町村ID付き) + 県境 ---
# 市区町村コード(lg_code_5)で引くと市区町村ポリゴンと都道府県ポリゴンの2レコードが当たる
# レイヤー構成: municipality(1747) + pref_by_municipality(1747) + pref_boundaries(県境ライン) → merge-layers force

# DuckDB で都道府県ポリゴンを市区町村ID付きでGeoJSON出力
duckdb processing/intermediate_data/ddb/dwh.duckdb \
  -f processing/transform/ddb/administrative_area/municipality/export_pref_by_municipality.sql

# 2つのGeoJSONを同時に読み込み、県境追加 & 1layer統合
# 量子化は1e4とする
mapshaper \
  -i processing/intermediate_data/transformed/ja_municipality_area_simplified_1741.geojson name=municipality \
  -i processing/intermediate_data/transformed/ja_pref_area_by_municipality.geojson name=pref_by_municipality combine-files \
  -target municipality \
  -dissolve fields=lg_code,city_name,county_name,is_hoppo_city,lg_code_5,prefecture_code,prefecture_name \
  -clean \
  -each 'id = lg_code_5' \
  -target pref_by_municipality \
  -dissolve fields=lg_code,city_name,county_name,is_hoppo_city,lg_code_5,prefecture_code,prefecture_name,pref_name_map \
  -each 'id = lg_code_5' \
  -dissolve2 fields=pref_name_map + name=pref_boundaries \
  -target pref_boundaries \
  -innerlines \
  -buffer 150 units=meters \
  -each 'boundary_id = this.id' \
  -target pref_by_municipality,municipality,pref_boundaries \
  -merge-layers force \
  -o format=topojson \
     quantization=1e4 \
     id-field=id \
     data/administrative_area/municipality/ja_municipality_area_pref_dual_layer.topojson

mapshaper data/administrative_area/municipality/ja_municipality_area_pref_dual_layer.topojson \
  -info
