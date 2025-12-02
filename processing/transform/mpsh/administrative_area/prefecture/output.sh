# dissolveして量子化1e5でtopojsonにして出力
mapshaper processing/intermediate_data/transformed/ja_municipality_area_simplified_1741.geojson \
  -clean \
  -dissolve fields=prefecture_code,prefecture_name \
  -clean \
  -o format=topojson \
     quantization=1e5 \
     id-field=prefecture_code \
     processing/intermediate_data/transformed/ja_prefecture_area_tmp.topojson

# clean & 再output
mapshaper processing/intermediate_data/transformed/ja_prefecture_area_tmp.topojson \
  -clean \
  -o format=topojson \
     data/administrative_area/prefecture/ja_prefecture_area.topojson

# ID数チェック
mapshaper data/administrative_area/prefecture/ja_prefecture_area.topojson \
  -info
