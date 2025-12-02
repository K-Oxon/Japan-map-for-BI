# Japan-map-for-BI

Power BIやTableauで使用できる日本地図(TopoJSON, GeoJSON)

## 提供物一覧（data配下）

### 行政区域地図

<table>
  <thead>
    <tr>
      <th>単位</th>
      <th>id</th>
      <th>説明</th>
      <th>TopoJSON</th>
      <th>GeoJSON</th>
      <th>画像</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>基礎自治体</td>
      <td>地方公共団体コード6桁</td>
      <td>1741市区町村境界</td>
      <td><a href="data/administrative_area/municipality/ja_municipality_area.topojson">ja_municipality_area.topojson</a></td>
      <td>WIP</td>
      <td>WIP</td>
    </tr>
    <tr>
      <td>基礎自治体</td>
      <td>地方公共団体コード5桁</td>
      <td>1741市区町村境界</td>
      <td><a href="data/administrative_area/municipality/ja_municipality_area_5.topojson">ja_municipality_area_5.topojson</a></td>
      <td>WIP</td>
      <td><img src="img/ja_municipality_area_5.jpg" alt="ja_municipality_area_5.topojson プレビュー" width="300" /></td>
    </tr>
    <tr>
      <td>基礎自治体</td>
      <td>地方公共団体コード6桁</td>
      <td>1741市区町村境界<wbr>（都道府県界含む）</td>
      <td><a href="data/administrative_area/municipality/ja_municipality_area_with_pref_boundary.topojson">ja_municipality_area_&#8203;with_pref_boundary.topojson</a></td>
      <td>WIP</td>
      <td>WIP</td>
    </tr>
    <tr>
      <td>基礎自治体</td>
      <td>地方公共団体コード5桁</td>
      <td>1741市区町村境界<wbr>（都道府県界含む）</td>
      <td><a href="data/administrative_area/municipality/ja_municipality_area_with_pref_boundary_5.topojson">ja_municipality_area_&#8203;with_pref_boundary_5.topojson</a></td>
      <td>WIP</td>
      <td>WIP</td>
    </tr>
    <tr>
      <td>都道府県</td>
      <td>都道府県コード2桁</td>
      <td>47都道府県境界</td>
      <td><a href="data/administrative_area/prefecture/ja_prefecture_area.topojson">ja_prefecture_area.topojson</a></td>
      <td>WIP</td>
      <td>WIP</td>
    </tr>
  </tbody>
</table>

## 加工処理のイメージ

### 行政区分

[国土数値情報の行政区域データ](https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-N03-2025.html)から取得したデータを元に、以下の処理を行っています。

1. ポリゴンの簡素化
2. 面積が小さいポリゴン(50000m²未満の小島や防波堤など)を省略
3. 基礎自治体単位(1741市区町村)単位でポリゴンを結合 <br/>(都道府県: 47都道府県単位)

## ライセンス

- **ソースコード**
  このリポジトリに含まれるソースコードは [MIT License](./LICENSE) の下で提供されています。

- **データ**
  このリポジトリに含まれるデータは、国土交通省「[国土数値情報ダウンロードサイト](https://nlftp.mlit.go.jp/ksj/)」のデータを加工して作成したものであり、
  「国土数値情報ダウンロードサイトコンテンツ利用規約（政府標準利用規約準拠版）」および
  [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/legalcode.ja) に従って利用可能です。
  
  出典：国土交通省 国土数値情報ダウンロードサイト（URL）
  
  加工：oxon
