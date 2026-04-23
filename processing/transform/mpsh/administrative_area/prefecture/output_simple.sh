# 離島を除外した都道府県ポリゴン; iconicに地図を使う場合の例
# 除外対象の離島lg_codeは export_pref_by_municipality.sql の island 判定条件と同じ
mapshaper processing/intermediate_data/transformed/ja_municipality_area_simplified_1741.geojson \
  -filter '!(
      (+lg_code >= 133612 && +lg_code <= 134210) ||
      (+lg_code >= 325252 && +lg_code <= 325287) ||
      [422096, 422100, 422118, 423831, 424111].indexOf(+lg_code) >= 0 ||
      [462136, 462225, 463035, 463043].indexOf(+lg_code) >= 0 ||
      (+lg_code >= 465011 && +lg_code <= 465356) ||
      [472077, 473570, 473588, 473618, 473758, 473812, 473821, 472140].indexOf(+lg_code) >= 0
    )' \
  -clean \
  -dissolve fields=prefecture_code,prefecture_name \
  -clean \
  -o format=topojson \
     quantization=1e5 \
     id-field=prefecture_code \
     processing/intermediate_data/transformed/ja_prefecture_area_simple_tmp.topojson

# clean & 再output
mapshaper processing/intermediate_data/transformed/ja_prefecture_area_simple_tmp.topojson \
  -clean \
  -o format=topojson \
     data/administrative_area/prefecture/ja_prefecture_area_simple.topojson

# ID数チェック
mapshaper data/administrative_area/prefecture/ja_prefecture_area_simple.topojson \
  -info
