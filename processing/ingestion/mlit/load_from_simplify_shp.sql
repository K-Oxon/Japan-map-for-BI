load spatial
;

create or replace table dwh.dwh.ja_admnstrtv_area_simplify as (
    from ST_Read('processing/intermediate_data/transformed/ja_municipality_area_simplified_from_shp.geojson')
);

-- データ確認
select count(*) as cnt from dwh.dwh.ja_admnstrtv_area_simplify;
