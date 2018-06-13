# Query

In order to retrieve data from the datasets it is possible to send queries to the API using the SQL or Feature Service languages.

It is possible to refer to the dataset using its table name, its slug or just its id. Two different endpoints are provided (under the dataset path and a generic one) and the sql query can be provided via query parameters or in the body of a POST request.

```shell
curl -i -H 'Authorization: Bearer your-token>' -H 'Content-Type: application/json' -XPOST 'http://api.apihighways.org/v1/query/<dataset_id>/' -d '{
    "sql": "select * from <dataset_id> limit 10"
}
'
```

```shell
curl -i -XGET http\://api.apihighways.org/v1/query\?sql\=select\ \*\ from\ <dataset.slug>
```

```
## Some query examples

### Select and aggregations

select * from table
select count(*) from table
select a, b from table
select a, count(*) from table

### Functions and alias

select sum(int) from table
select avg(int) from table
select max(int) from table
select min(int) from table
select min(int) as minimum from table

select * from table limit=20
select a as b from table limit=20

### Where conditionals

select * from table where a > 2
select * from table where a = 2
select * from table where a < 2
select * from table where a >= 2
select * from table where a = 2 and b < 2
select * from table where text like ‘a%’
Select * from table where st_intersects(st_setsrid(st_geomfromgeojson(‘{}’), 4326), the_geom)

### Group by

select a, count(int) from table group by a
select count(*) FROM tablename group by ST_GeoHash(the_geom, 8)

### Raster queries available

SELECT ST_METADATA(rast) from table
SELECT ST_BANDMETADATA(rast, occurrence) from table
SELECT ST_SUMMARYSTATS() from table
SELECT ST_HISTOGRAM(rast, 1, auto, true) from table
SELECT ST_valueCount(rast, 1, true) from table
```

### Freeze query

It is possible generate a json file in a bucket of the sql result. You only need send a query param freeze with value true and you will obtain the url of the json file.

<aside class="notice">
    This is an authenticated feature!
</aside>

```shell
curl -i -XGET http\://api.apihighways.org/v1/query\?sql\=select\ \*\ from\ <dataset.slug>&freeze=true
```

## Rasdaman queries

SQL-like queries can be employed for accessing data stored in Rasdaman datasets. Subsets on the original axes of the data may be provided in the WHERE statement. So far, only operations that result in a single scalar can be obtained from Rasdaman - averages, minimums, maximums.

```shell
curl -XGET https://api.apihighways.org/v1/query?sql=select avg(Green) from 18c0b71d-2f55-4a45-9e5b-c35db3ebfe94 where Lat > 0 and  Lat < 45 \
	-H 'Content-Type: application/json' \
	-H 'Authorization: Bearer <token>'
```

## NEX-GDDP queries

A SQL wrapper is offered for accessing the NASA NEX-GDDP dataset with sql-like statements. The API stores calculated indexes over the original data, and several views over the data are available. These can be accessed in the following ways:

### Spatial aggregates over a layer

Access spatial aggregates over the data by listing all dataset data for a particular year:

```shell
curl -i -XGET http\://api.apihighways.org/v1/query/b99c5f5e-00c6-452e-877c-ced2b9f0b393\?sql\=select\ \*\ from\ nexgddp-historical-ACCESS1_0-prmaxday\ where\ year\ \=\ 1960
```

Access particular aggregates:

```shell
curl -i -XGET http\://api.apihighways.org/v1/query/b99c5f5e-00c6-452e-877c-ced2b9f0b393\?sql\=select\ avg\,\ min\ from\ nexgddp-historical-ACCESS1_0-prmaxday\ where\ year\ \=\ 1960
```

Calculate statistics for a range of years:

```shell
curl -i -XGET http\://api.apihighways.org/v1/query/b99c5f5e-00c6-452e-877c-ced2b9f0b393\?sql\=select\ \*\ from\ nexgddp-historical-ACCESS1_0-prmaxday\ \ where\ year\ between\ 1960\ and\ 1962
```

You can delimit an area of interest by providing a geostore id as a parameter:

```shell
curl -i -XGET http\://api.apihighways.org/v1/query/b99c5f5e-00c6-452e-877c-ced2b9f0b393\?sql\=select\ \*\ from\ nexgddp-historical-ACCESS1_0-prmaxday\ \ where\ year\ between\ 1960\ and\ 1962&geostore\=0279093c278a64f4c3348ff63e4cfce0
```

## Querying a GEE dataset

### Querying a GEE Image

Some examples of possible queries to a GEE `Image`. Queries can be done through the dataset URL path, or using the generic `query` endpoint, providing the slug in the query. The result is identical for both calls.


```shell
curl -X GET https://api.apihighways.org/v1/query/:dataset_id?sql=SELECT ST_HISTOGRAM(raster, lossyear, 15, true) FROM 'UMD/hansen/global_forest_change_2015_v1_3' \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"
```

```shell
curl -X GET https://api.apihighways.org/v1/query?sql=SELECT ST_HISTOGRAM(raster, lossyear, 15, true) FROM {:dataset_slug} \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"
```

> Response 

```json
{
   "data": [
      {
         "st_histogram": {
            "lossyear": [
               [
                  0,
                  7081461.5
               ],
               [
                  1.0666667,
                  0
               ],
               [
                  2.1333334,
                  0
               ],
               [
                  3.2,
                  0
               ],
               [
                  4.266667,
                  1
               ],
               [
                  5.3333335,
                  0
               ],
               [
                  6.4,
                  0
               ],
               [
                  7.4666667,
                  1
               ],
               [
                  8.533334,
                  1
               ],
               [
                  9.6,
                  1
               ],
               [
                  10.666667,
                  2
               ],
               [
                  11.733334,
                  0
               ],
               [
                  12.8,
                  0
               ],
               [
                  13.866667,
                  4
               ],
               [
                  14.933333,
                  2
               ]
            ]
         }
      }
   ],
   "meta": {}
}
```

Several PostGIS operations are supported on GEE Image queries: [ST_HISTOGRAM](https://postgis.net/docs/RT_ST_Histogram.html), [ST_BANDMETADATA](https://postgis.net/docs/RT_ST_BandMetaData.html), [ST_SUMMARYSTATS](https://postgis.net/docs/RT_ST_SummaryStats.html) and [ST_VALUECOUNT](https://postgis.net/docs/RT_ST_ValueCount.html).

```shell
curl -X GET https://api.apihighways.org/v1/query?sql=select ST_BANDMETADATA(raster, {:band_name}) FROM  {:dataset_slug} \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"
```

```shell
curl -X GET https://api.apihighways.org/v1/query?sql=select ST_SUMMARYSTATS({:band_name}) FROM  {:dataset_slug} \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"
```

```shell
curl -X GET https://api.apihighways.org/v1/query?sql=select ST_VALUECOUNT(raster, {:band_name}, true) FROM  {:dataset_slug} \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"
```

### Querying a GEE ImageCollection

Queries done to GEE ImageCollection are done to the information of the ImageCollection, not the Images themselves.

```shell
curl -X GET https://api.apihighways.org/v1/query/:dataset_id?sql=SELECT * from 'COPERNICUS/S2' limit 10 \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"
```

> Response 

```json
{
          "data": [
             {
                "CLOUDY_PIXEL_PERCENTAGE": 0,
                "CLOUD_COVERAGE_ASSESSMENT": 0.010707692,
                "DATASTRIP_ID": "S2A_OPER_MSI_L1C_DS_EPA__20160606T223605_S20150627T102531_N02.02",
                "DATATAKE_IDENTIFIER": "GS2A_20150627T102537_000062_N02.02",
                "DATATAKE_TYPE": "INS-NOBS",
                "DEGRADED_MSI_DATA_PERCENTAGE": 0,
                "ECMWF_DATA_REF": "S2__OPER_AUX_ECMWFD_FAKE_19800101T000000_V19800101T000000_19800101T000000",
                "FORMAT_CORRECTNESS_FLAG": "PASSED",
                "GENERAL_QUALITY_FLAG": "PASSED",
                "GENERATION_TIME": 1465314766000,
                "GEOMETRIC_QUALITY_FLAG": "PASSED",
                "GRANULE_ID": "S2A_OPER_MSI_L1C_TL_EPA__20160606T223605_A000062_T31RCL_N02.02",
                "GRI_FILENAME": "S2A_OPER_AUX_GRI065_PDMC_20130621T120000_S20130101T000000",
                "IERS_BULLETIN_FILENAME": "S2__OPER_AUX_UT1UTC_PDMC_20150625T000000_V20150626T000000_20160625T000000",
                "MEAN_INCIDENCE_AZIMUTH_ANGLE_B1": 103.96547,
                "MEAN_INCIDENCE_AZIMUTH_ANGLE_B10": 102.24578,
                "MEAN_INCIDENCE_AZIMUTH_ANGLE_B11": 103.091484,
                "MEAN_INCIDENCE_AZIMUTH_ANGLE_B12": 103.75323,
                "MEAN_INCIDENCE_AZIMUTH_ANGLE_B2": 101.277176,
                "MEAN_INCIDENCE_AZIMUTH_ANGLE_B3": 101.89762,
                "MEAN_INCIDENCE_AZIMUTH_ANGLE_B4": 102.41693,
                "MEAN_INCIDENCE_AZIMUTH_ANGLE_B5": 102.72599,
                "MEAN_INCIDENCE_AZIMUTH_ANGLE_B6": 103.02373,
                "MEAN_INCIDENCE_AZIMUTH_ANGLE_B7": 103.33026,
                "MEAN_INCIDENCE_AZIMUTH_ANGLE_B8": 101.58725,
                "MEAN_INCIDENCE_AZIMUTH_ANGLE_B8A": 103.62593,
                "MEAN_INCIDENCE_AZIMUTH_ANGLE_B9": 104.26828,
                "MEAN_INCIDENCE_ZENITH_ANGLE_B1": 10.449345,
                "MEAN_INCIDENCE_ZENITH_ANGLE_B10": 10.3420725,
                "MEAN_INCIDENCE_ZENITH_ANGLE_B11": 10.37812,
                "MEAN_INCIDENCE_ZENITH_ANGLE_B12": 10.398034,
                "MEAN_INCIDENCE_ZENITH_ANGLE_B2": 10.354081,
                "MEAN_INCIDENCE_ZENITH_ANGLE_B3": 10.367636,
                "MEAN_INCIDENCE_ZENITH_ANGLE_B4": 10.363364,
                "MEAN_INCIDENCE_ZENITH_ANGLE_B5": 10.37667,
                "MEAN_INCIDENCE_ZENITH_ANGLE_B6": 10.391888,
                "MEAN_INCIDENCE_ZENITH_ANGLE_B7": 10.409047,
                "MEAN_INCIDENCE_ZENITH_ANGLE_B8": 10.359886,
                "MEAN_INCIDENCE_ZENITH_ANGLE_B8A": 10.428017,
                "MEAN_INCIDENCE_ZENITH_ANGLE_B9": 10.472695,
                "MEAN_SOLAR_AZIMUTH_ANGLE": 98.29342,
                "MEAN_SOLAR_ZENITH_ANGLE": 18.869585,
                "MGRS_TILE": "31RCL",
                "PROCESSING_BASELINE": "02.02",
                "PRODUCTION_DEM_TYPE": "S2__OPER_DEM_GLOBEF_PDMC_19800101T000000_S19800101T000000",
                "PRODUCT_ID": "S2A_OPER_PRD_MSIL1C_PDMC_20160607T155246_R062_V20150627T102531_20150627T102531",
                "PRODUCT_URI": "754_2016-06-07T01_11",
                "RADIOMETRIC_QUALITY_FLAG": "PASSED",
                "REFLECTANCE_CONVERSION_CORRECTION": 0.96796227,
                "SENSING_ORBIT_DIRECTION": "DESCENDING",
                "SENSING_ORBIT_NUMBER": 62,
                "SENSOR_QUALITY_FLAG": "PASSED",
                "SOLAR_IRRADIANCE_B1": 1913.57,
                "SOLAR_IRRADIANCE_B10": 367.15,
                "SOLAR_IRRADIANCE_B11": 245.59,
                "SOLAR_IRRADIANCE_B12": 85.25,
                "SOLAR_IRRADIANCE_B2": 1941.63,
                "SOLAR_IRRADIANCE_B3": 1822.61,
                "SOLAR_IRRADIANCE_B4": 1512.79,
                "SOLAR_IRRADIANCE_B5": 1425.56,
                "SOLAR_IRRADIANCE_B6": 1288.32,
                "SOLAR_IRRADIANCE_B7": 1163.19,
                "SOLAR_IRRADIANCE_B8": 1036.39,
                "SOLAR_IRRADIANCE_B8A": 955.19,
                "SOLAR_IRRADIANCE_B9": 813.04,
                "SPACECRAFT_NAME": "Sentinel-2A",
                "system:asset_size": 129008712,
                "system:footprint": {
                   "coordinates": [
                      [
                         2.082342,
                         28.022371
                      ],
                      [
                         2.0822623,
                         28.02246
                      ],
                      [
                         1.7870268,
                         28.020172
                      ],
                      [
                         1.7863864,
                         28.0193
                      ],
                      [
                         1.7840385,
                         28.0106
                      ],
                      [
                         1.7583696,
                         27.90747
                      ],
                      [
                         1.7138484,
                         27.728071
                      ],
                      [
                         1.7112349,
                         27.717205
                      ],
                      [
                         1.7112612,
                         27.714973
                      ],
                      [
                         1.7119349,
                         27.714682
                      ],
                      [
                         1.7139838,
                         27.714066
                      ],
                      [
                         1.767642,
                         27.705345
                      ],
                      [
                         1.9106693,
                         27.682352
                      ],
                      [
                         1.965306,
                         27.673565
                      ],
                      [
                         1.9709928,
                         27.672703
                      ],
                      [
                         1.9756638,
                         27.672016
                      ],
                      [
                         2.0845964,
                         27.656439
                      ],
                      [
                         2.0853071,
                         27.656443
                      ],
                      [
                         2.0854056,
                         27.657703
                      ],
                      [
                         2.082342,
                         28.022371
                      ]
                   ],
                   "type": "LinearRing"
                },
                "system:index": "20150627T102531_20160606T223605_T31RCL",
                "system:time_end": 1435400731456,
                "system:time_start": 1435400731456
             }
          ],
          "meta": {}
       }
```

### Querying a GEE FeatureCollections

```shell
curl -X GET https://api.apihighways.org/v1/query/:dataset_id?sql=SELECT * from 'GLIMS/2016' where area > 0.09 limit 10 \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"
```

> Response 

```json
{
   "data": [
      {
         "analysts": "Rabatel, Antoine",
         "anlys_id": 121404,
         "anlys_time": "2013-03-20T00:00:00",
         "area": 0.0905,
         "chief_affl": "Laboratoire de Glaciologie et G�ophysique de l'Environnement (LGGE)",
         "db_area": 0.090459,
         "geog_area": "French Alps",
         "glac_id": "G006237E44775N",
         "glac_name": "Plat",
         "glac_stat": "exists",
         "length": 506.485,
         "line_type": "glac_bound",
         "local_id": "None",
         "max_elev": 2970,
         "mean_elev": 2892,
         "min_elev": 2802,
         "parent_id": "",
         "primeclass": 0,
         "proc_desc": "Automatic delineation using combination of SWIR, NIR, and GREEN; individual checking and manual corrections when necessary; First, NDSI was calculated on the images.  From the resulting maps, glacier outlines were extracted.  Second, the shapefiles result",
         "rc_id": 33,
         "rec_status": "okay",
         "release_dt": "2013-12-25T14:01:59",
         "src_date": "1988-09-12T00:00:00",
         "subm_id": 569,
         "submitters": "Rabatel, Antoine",
         "system:index": "0000f1dd8747bff0d0b9",
         "wgms_id": "F4N01172H02",
         "width": 0
      },
      {
         "analysts": "Rabatel, Antoine",
         "anlys_id": 120866,
         "anlys_time": "2013-03-25T00:00:00",
         "area": 0.1112,
         "chief_affl": "Laboratoire de Glaciologie et G�ophysique de l'Environnement (LGGE)",
         "db_area": 0.111206,
         "geog_area": "French Alps",
         "glac_id": "G006231E44772N",
         "glac_name": "de Crupillouse",
         "glac_stat": "exists",
         "length": 325.129,
         "line_type": "debris_cov",
         "local_id": "None",
         "max_elev": 2961,
         "mean_elev": 2784,
         "min_elev": 2628,
         "parent_id": "",
         "primeclass": 0,
         "proc_desc": "Manual adjustment of the 1985 contour lines for each individual glacier; This submission concerns the glacier outlines in 2003. The shapefiles resulting from the 1985 delineation have been overlaid on the 2003 images displayed with a band combination asso",
         "rc_id": 33,
         "rec_status": "okay",
         "release_dt": "2013-12-25T14:08:34",
         "src_date": "2003-09-21T00:00:00",
         "subm_id": 568,
         "submitters": "Rabatel, Antoine",
         "system:index": "00001debd5b09c25aa80",
         "wgms_id": "F4N01172H03",
         "width": 0
      }
   ],
   "meta": {}
}
```
