# dissolveして量子化1e5でtopojsonにして出力
# 1e4だとドラクエみたいになる
mapshaper processing/intermediate_data/transformed/ja_municipality_area_simplified_1741.geojson \
  -clean \
  -dissolve fields=lg_code,city_name,county_name,is_hoppo_city,lg_code_5,prefecture_code,prefecture_name \
  -clean \
  -o format=topojson \
     quantization=1e5 \
     id-field=lg_code \
     processing/intermediate_data/transformed/ja_municipality_area_tmp.topojson

# clean & 再output
mapshaper processing/intermediate_data/transformed/ja_municipality_area_tmp.topojson \
  -clean \
  -o format=topojson \
     data/administrative_area/municipality/ja_municipality_area.topojson

# ID数チェック
mapshaper data/administrative_area/municipality/ja_municipality_area.topojson \
  -info

# 量子化後にclean、県境追加ver.
mapshaper processing/intermediate_data/transformed/ja_municipality_area_tmp.topojson \
  -clean \
  -dissolve2 fields=prefecture_name + name=pref_boundaries \
  -target pref_boundaries \
  -innerlines \
  -buffer 150 units=meters \
  -each 'boundary_id = this.id' \
  -target 1,pref_boundaries \
  -merge-layers force \
  -o format=topojson \
     data/administrative_area/municipality/ja_municipality_area_with_pref_boundary.topojson
