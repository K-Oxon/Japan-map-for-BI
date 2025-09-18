create or replace table dwh.dwh.mst_city as (
    with mt_city_all as (
        select
            lg_code,
            pref,
            county,
            city,
            ward
        from da_abr.mt_city_all
    ),

    add_flags as (
        -- 基礎自治体フラグ (区名がないのは結果論だが、一番簡単)
        select
            *,
            if(ward is null, true, false) as is_local_gov,
            case
                when lg_code in (
                    '016951',
                    '016969',
                    '016977',
                    '016985',
                    '016993',
                    '017001'
                ) then true
                else false
            end as is_hoppo_city
        from mt_city_all
    ),

    seirei as (
        select *
        from mt_city_all
        where city in (
            '札幌市',
            '仙台市',
            'さいたま市',
            '千葉市',
            '横浜市',
            '川崎市',
            '相模原市',
            '新潟市',
            '静岡市',
            '浜松市',
            '名古屋市',
            '京都市',
            '大阪市',
            '堺市',
            '神戸市',
            '岡山市',
            '広島市',
            '北九州市',
            '福岡市',
            '熊本市'
        )
        and ward is null
    ),

    add_seirei_code as (
        -- 政令指定都市の行政区を政令指定都市の地方公共団体コードに変換するためのcodeを付与
        select
            *,
            coalesce(seirei.lg_code, add_flags.lg_code) as municipality_code
        from add_flags
        left outer join seirei on
            add_flags.pref = seirei.pref
            and add_flags.city = seirei.city
    ),

    final as (
        select
            lg_code,
            left(lg_code, 5) as lg_code_5,
            left(lg_code, 2) as prefecture_code,
            pref,
            county,
            city,
            ward,
            municipality_code,
            is_local_gov,
            is_hoppo_city
        from add_seirei_code
    )

    select *
    from final
);
