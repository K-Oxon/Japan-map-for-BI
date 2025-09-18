# 軽量化&topojson化
mapshaper processing/intermediate_data/transformed/ja_municipality_area_1741.geojson \
  -proj EPSG:3857 \
  -simplify visvalingam weighting=0.7 keep-shapes percentage=0.005 \
  -filter-islands min-area=50000 \
  -proj EPSG:4326 \
  -o format=topojson \
     quantization=1e5 \
     id-field=lg_code \
     bbox \
     processing/intermediate_data/transformed/ja_municipality_area_tmp.topojson

# 量子化後にclean
mapshaper processing/intermediate_data/transformed/ja_municipality_area_tmp.topojson \
  -clean \
  -o format=topojson \
     bbox \
     data/administrative_area/municipality/ja_municipality_area.topojson

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
     bbox \
     data/administrative_area/municipality/ja_municipality_area_with_pref_boundary.topojson
