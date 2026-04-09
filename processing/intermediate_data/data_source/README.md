# 中間データ置き場

## 国土数値情報

### GeoJSONの仕様

`gdal info`の結果

EPSGは6668になっている。

```json
{
  "description":"N03-20250101.geojson",
  "driverShortName":"GeoJSON",
  "driverLongName":"GeoJSON",
  "layers":[
    {
      "name":"N03-20250101",
      "metadata":{
      },
      "geometryFields":[
        {
          "name":"",
          "type":"Polygon",
          "nullable":true,
          "extent":[
            122.93260636799999,
            20.422746413999999,
            153.986675123,
            45.557243413999998
          ],
          "coordinateSystem":{
            "wkt":"GEOGCRS[\"JGD2011\",\n    DATUM[\"Japanese Geodetic Datum 2011\",\n        ELLIPSOID[\"GRS 1980\",6378137,298.257222101,\n            LENGTHUNIT[\"metre\",1]]],\n    PRIMEM[\"Greenwich\",0,\n        ANGLEUNIT[\"degree\",0.0174532925199433]],\n    CS[ellipsoidal,2],\n        AXIS[\"geodetic latitude (Lat)\",north,\n            ORDER[1],\n            ANGLEUNIT[\"degree\",0.0174532925199433]],\n        AXIS[\"geodetic longitude (Lon)\",east,\n            ORDER[2],\n            ANGLEUNIT[\"degree\",0.0174532925199433]],\n    ID[\"EPSG\",6668]]",
            "projjson":{
              "$schema":"https://proj.org/schemas/v0.7/projjson.schema.json",
              "type":"GeographicCRS",
              "name":"JGD2011",
              "datum":{
                "type":"GeodeticReferenceFrame",
                "name":"Japanese Geodetic Datum 2011",
                "ellipsoid":{
                  "name":"GRS 1980",
                  "semi_major_axis":6378137,
                  "inverse_flattening":298.257222101
                }
              },
              "coordinate_system":{
                "subtype":"ellipsoidal",
                "axis":[
                  {
                    "name":"Geodetic latitude",
                    "abbreviation":"Lat",
                    "direction":"north",
                    "unit":"degree"
                  },
                  {
                    "name":"Geodetic longitude",
                    "abbreviation":"Lon",
                    "direction":"east",
                    "unit":"degree"
                  }
                ]
              },
              "id":{
                "authority":"EPSG",
                "code":6668
              }
            },
            "dataAxisToSRSAxisMapping":[
              2,
              1
            ]
          },
          "xyCoordinateResolution":1.0000000000000001e-09
        }
      ],
      "featureCount":124094,
      "fields":[
        {
          "name":"N03_001",
          "type":"String",
          "nullable":true,
          "uniqueConstraint":false
        },
        {
          "name":"N03_002",
          "type":"String",
          "nullable":true,
          "uniqueConstraint":false
        },
        {
          "name":"N03_003",
          "type":"String",
          "nullable":true,
          "uniqueConstraint":false
        },
        {
          "name":"N03_004",
          "type":"String",
          "nullable":true,
          "uniqueConstraint":false
        },
        {
          "name":"N03_005",
          "type":"String",
          "nullable":true,
          "uniqueConstraint":false
        },
        {
          "name":"N03_007",
          "type":"String",
          "nullable":true,
          "uniqueConstraint":false
        }
      ]
    }
  ],
  "metadata":{
  },
  "domains":{
  },
  "relationships":{
  }
}
```
