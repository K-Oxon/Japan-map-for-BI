load spatial;

-- 都道府県ポリゴンを市区町村ID(lg_code_5)付きで出力
-- 1741市区町村それぞれに、所属する都道府県(島嶼部分離)のポリゴンを割り当てる
COPY (
  WITH with_pref_name_map AS (
    SELECT *,
      CASE
        WHEN CAST(lg_code AS INT64) BETWEEN 133612 AND 134210 THEN '東京都（島嶼部）'
        WHEN CAST(lg_code AS INT64) BETWEEN 325252 AND 325287 THEN '島根県（隠岐郡）'
        WHEN CAST(lg_code AS INT64) IN (422096, 422100, 422118, 423831, 424111) THEN '長崎県（離島地域）'
        WHEN CAST(lg_code AS INT64) IN (462136, 462225, 463035, 463043) THEN '鹿児島県（島嶼部）'
        WHEN CAST(lg_code AS INT64) BETWEEN 465011 AND 465356 THEN '鹿児島県（島嶼部）'
        WHEN CAST(lg_code AS INT64) IN (472077, 473570, 473588, 473618, 473758, 473812, 473821, 472140) THEN '沖縄県（離島地域）'
        WHEN prefecture_name = '沖縄県' THEN '沖縄県（本島地域）'
        ELSE prefecture_name
      END AS pref_name_map
    FROM dwh.dwh.ja_admnstrtv_area_simplify_1741
  ),
  pref_polygons AS (
    SELECT
      pref_name_map,
      ST_Union_Agg(ST_MakeValid(geom)) AS geom
    FROM with_pref_name_map
    GROUP BY pref_name_map
  )
  SELECT
    m.lg_code,
    m.lg_code_5,
    m.prefecture_code,
    m.prefecture_name,
    m.pref_name_map,
    m.county_name,
    m.city_name,
    m.is_hoppo_city,
    p.geom
  FROM (
    SELECT DISTINCT lg_code, lg_code_5, prefecture_code, prefecture_name,
           pref_name_map, county_name, city_name, is_hoppo_city
    FROM with_pref_name_map
  ) m
  JOIN pref_polygons p ON m.pref_name_map = p.pref_name_map
  ORDER BY m.lg_code
) TO 'processing/intermediate_data/transformed/ja_pref_area_by_municipality.geojson' WITH (
  FORMAT GDAL, DRIVER 'GeoJSON', SRS 'EPSG:4326'
);
