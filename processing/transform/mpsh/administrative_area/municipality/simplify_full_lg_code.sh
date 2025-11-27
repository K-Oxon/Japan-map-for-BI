# 軽量化(400km^2未満の地物は3.4%、それ以上の地物は0.5% | 隠岐の島町で400km^2くらい)& 小島省略 & topojson化
# 3.4%は竹島がギリギリ雰囲気を保てるくらいのレベル
mapshaper processing/intermediate_data/transformed/ja_municipality_area_1741.geojson \
  -proj EPSG:3857 \
  -simplify visvalingam weighting=0.7 keep-shapes variable percentage="this.area < 400000000 ? 0.034 : 0.005" \
  -filter-islands min-area=50000 \
  -proj EPSG:4326 \
  -o format=topojson \
     quantization=1e5 \
     id-field=lg_code \
     processing/intermediate_data/transformed/ja_municipality_area_tmp.topojson

# 量子化後にclean
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
