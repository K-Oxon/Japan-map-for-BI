# dissolveして量子化1e5でtopojsonにして出力
# 1e4だとドラクエみたいになる
mapshaper processing/intermediate_data/transformed/ja_municipality_area_simplified_1741.geojson \
  -clean \
  -dissolve fields=lg_code,city_name,county_name,is_hoppo_city,lg_code_5,prefecture_code,prefecture_name \
  -clean \
  -o format=topojson \
     quantization=1e5 \
     id-field=lg_code_5 \
     processing/intermediate_data/transformed/ja_municipality_area_5_tmp.topojson

# clean & 再output
mapshaper processing/intermediate_data/transformed/ja_municipality_area_5_tmp.topojson \
  -clean \
  -o format=topojson \
     data/administrative_area/municipality/ja_municipality_area_5.topojson

# ID数チェック
mapshaper data/administrative_area/municipality/ja_municipality_area_5.topojson \
  -info

# 量子化後にclean、県レイヤー・県境追加ver.
# レイヤー順: pref_layer(県ポリゴン), 元の市区町村レイヤー, pref_boundaries(県境ライン)
mapshaper processing/intermediate_data/transformed/ja_municipality_area_5_tmp.topojson \
  -clean \
  -join processing/intermediate_data/transformed/ja_municipality_area_5.csv keys=lg_code_5,lg_code_5 fields=pref_code_label,pref_name_label string-fields=lg_code_5 \
  -each 'id = lg_code_5' \
  -dissolve2 fields=pref_code_label,pref_name_label + name=pref_layer \
  -target pref_layer \
  -each 'id = pref_code_label' \
  -dissolve2 fields=pref_name_label + name=pref_boundaries \
  -target pref_boundaries \
  -innerlines \
  -buffer 150 units=meters \
  -each 'boundary_id = this.id' \
  -target pref_layer,1,pref_boundaries \
  -merge-layers force \
  -o format=topojson \
     id-field=id \
     data/administrative_area/municipality/ja_municipality_area_overlay_pref.topojson

mapshaper data/administrative_area/municipality/ja_municipality_area_overlay_pref.topojson \
  -info
