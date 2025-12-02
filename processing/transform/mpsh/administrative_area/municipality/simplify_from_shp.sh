mapshaper processing/intermediate_data/data_source/mlit/N03-20250101.shp \
  -proj EPSG:3857 \
  -simplify visvalingam weighting=0.7 keep-shapes variable percentage="this.area < 200000 ? 0.04 : 0.005" \
  -filter-islands min-area=50000 \
  -proj EPSG:4326 \
  -o format=geojson \
     processing/intermediate_data/transformed/ja_municipality_area_simplified_from_shp.geojson
