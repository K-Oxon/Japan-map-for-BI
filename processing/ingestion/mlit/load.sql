load spatial
;

create or replace table mlit.japan_administrative_area as (
    from ST_Read('processing/intermediate_data/data_source/mlit/N03-20250101.geojson')
);

create or replace table mlit.japan_prefecture_area as (
    from ST_Read('processing/intermediate_data/data_source/mlit/N03-20250101_prefecture.geojson')
);

-- データ確認
select table_catalog, table_schema, table_name, table_type
from information_schema.tables
where table_schema = 'mlit'
;
