load spatial;
create or replace table dwh.dwh.japan_administrative_area_1741 as (
    with raw_area as (
      select *
      from mlit.japan_administrative_area
    ),
    renamed as (
      select n03_001 as prefecture_name,
        n03_003 as county_name,
        n03_004 as city_name,
        n03_005 as ward_name,
        n03_007 as ld_code_5,
        geom,
        from raw_area
      where n03_003 != '所属未定地' -- 所属未定地を除く
    ),
    join_mst_city as (
      select mst_city.municipality_code as lg_code,
        left(mst_city.municipality_code, 5) as ld_code_5,
        left(mst_city.municipality_code, 2) as prefecture_code,
        renamed.prefecture_name,
        renamed.county_name,
        renamed.city_name,
        renamed.ward_name,
        renamed.geom
      from renamed
        left outer join dwh.dwh.mst_city as mst_city on renamed.ld_code_5 = mst_city.lg_code_5
    ),
    -- 2) 同一市区町村内のマルチパーツを Union
    dissolve_multi_polygon as (
      select lg_code,
        ld_code_5,
        prefecture_code,
        prefecture_name,
        county_name,
        city_name,
        ward_name,
        st_union_agg (geom) as geom
      from join_mst_city
      group by all
    ),
    -- 3) 市政令指定都市を統合
    dissolve_city as (
      select lg_code,
        ld_code_5,
        prefecture_code,
        prefecture_name,
        county_name,
        city_name,
        -- 雑な処理(実際はマスタと結合させるなど)
        st_coverageunion_agg (geom) as geom -- 隣接前提
      from dissolve_multi_polygon
      group by all
    ),
    final as (
      select lg_code,
        ld_code_5,
        prefecture_code,
        prefecture_name,
        county_name,
        city_name,
        st_makevalid (geom) as geom
      from dissolve_city
    )
    select *
    from final
  );
-- GeoJSON FeatureCollectionとしてファイルに出力する
COPY (
  SELECT lg_code,
    ld_code_5,
    prefecture_code,
    prefecture_name,
    county_name,
    city_name,
    geom
  FROM dwh.dwh.japan_administrative_area_1741
  order by lg_code
) TO 'processing/intermediate_data/transformed/ja_municipality_area_1741.geojson' WITH (
  FORMAT GDAL,
  DRIVER 'GeoJSON',
  -- あると便利：BBoxを各フィーチャに付与
  LAYER_CREATION_OPTIONS 'WRITE_BBOX=YES',
  -- 座標参照系メタデータ
  SRS 'EPSG:4326'
);