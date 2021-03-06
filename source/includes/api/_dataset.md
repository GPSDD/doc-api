# Dataset

## What is a Dataset?

A dataset abstracts the data that can be obtained from several sources into a common interface. There are several data providers supported in the API, and each of those has a different provider. Datasets can belong to several applications.

## Supported dataset sources

### Third party Dataset connectors

For data stored on third party services.

#### Carto

**`(connectorType: 'rest', provider: 'cartodb')`**<br>
[![](images/dataset/carto.png)](https://www.carto.com) CARTO is an open, powerful, and intuitive map platform for discovering and predicting the key insights underlying the location data in our world.

### ArcGIS Feature service

**`(connectorType: 'rest', provider: 'featureservice')`** [![](https://www.arcgis.com/features/img/logo-esri.png)](https://www.arcgis.com/features/index.html)<br>
ArcGIS for server is a Complete, Cloud-Based Mapping Platform.

### Google Earth Engine

**`(connectorType: 'rest', provider: 'gee')`** [![](https://earthengine.google.com/static/images/GoogleEarthEngine_Grey_108.png)](https://earthengine.google.com/)<br>
Google Earth Engine combines a multi-petabyte catalog of satellite imagery and geospatial datasets with planetary-scale analysis capabilities and makes it available for scientists, researchers, and developers to detect changes, map trends, and quantify differences on the Earth's surface.

#### Web Map Services ([WMS](http://www.opengeospatial.org/standards/wms))

**`(connectorType: 'wms', provider: 'wms')`**

WMS connector provides access to data served through [OGC WMS](http://www.opengeospatial.org/standards/wms) protocol standard.

#### Rasdaman (Raster Data Manager)

**`(connectorType: 'rest', provider: 'rasdaman')`**<br>
[Rasdaman](http://www.rasdaman.com/) is a database with capabilities for storage, manipulation and retrieval of multidimensional arrays.

### Internal storage connectors

For data stored in our system.

#### NEX-GDDP

**`(connectorType: 'rest', provider: 'nexgddp')`**<br>
The NASA Earth Exchange Global Daily Downscaled Projections ([NEX-GDDP](https://nex.nasa.gov/nex/projects/1356/)) dataset is comprised of downscaled climate scenarios for the globe that are derived from the General Circulation Model (GCM) runs conducted under the Coupled Model Intercomparison Project Phase 5 (CMIP5) and across two of the four greenhouse gas emissions scenarios known as Representative Concentration Pathways (RCPs).

#### Comma-Separated Values (CSV)

**`(connectorType: 'document', provider: 'csv')`**<br>
Arbitrary Comma-Separated Values data

##### Tab-Separated Values (TSV)

**`(connectorType: 'document', provider: 'tsv')`**<br>
Arbitrary tab-Separated Values data

#### JavaScript Object Notation (JSON)

**`(connectorType: 'document', provider: 'json')`**<br>
Arbitrary [json](http://www.json.org/) structured data

#### XML

**`(connectorType: 'document', provider: 'xml')`**<br>
Arbitrary [XML](https://www.w3.org/TR/2006/REC-xml11-20060816/) data documents

## Getting all datasets

This endpoint will allow to get all datasets available in the API:


```shell
curl -X GET https://api.apihighways.org/v1/dataset
```

> Response:

```json
{
    "data": [
        {
        "id": "00f2be42-1ee8-4069-a55a-16a988f2b7a0",
        "type": "dataset",
        "attributes": {
            "name": "Glad points",
            "slug": "Glad-points-1490086842129",
            "type": null,
            "subtitle": null,
            "application": ["data4sdgs"],
            "dataPath": null,
            "attributesPath": null,
            "connectorType": "document",
            "provider": "csv",
            "userId": "58333dcfd9f39b189ca44c75",
            "connectorUrl": "http://gfw2-data.s3.amazonaws.com/alerts-tsv/glad_headers.csv",
            "tableName": "data",
            "status": "pending",
            "published": true,
            "overwrite": false,
            "verified": false,
            "blockchain": {},
            "env": "production",
            "geoInfo": false,
            "legend": {
                "date": [],
                "region": [],
                "country": []
                },
            "clonedHost": {},
            "errorMessage": null,
            "updatedAt": "2017-01-13T10:45:46.368Z",
            "widgetRelevantProps": [],
            "layerRelevantProps": []
            }
        },
    ...
  ],
  "links": {
    "self": "http://api.apihighways.org/v1/dataset?page[number]=1&page[size]=10",
    "first": "http://api.apihighways.org/v1/dataset?page[number]=1&page[size]=10",
    "last": "http://api.apihighways.org/v1/dataset?page[number]=99&page[size]=10",
    "prev": "http://api.apihighways.org/v1/dataset?page[number]=1&page[size]=10",
    "next": "http://api.apihighways.org/v1/dataset?page[number]=2&page[size]=10"
  },
  "meta": {
    "total-pages": 99,
    "total-items": 990,
    "size": 10
  }
}
```

### Slug & dataset-id

Datasets have an auto-generated and unique slug and id that allows the user to get, create, update, query or clone that dataset.

The dataset slug and the id cannot be updated even if the name changes.

### Error Message

When a dataset is created the status is set to "pending" by default. Once the adapter validates the dataset, the status is changed to "saved". If the validation fails, the status will be set to "failed" and the adapter will also set an error message indicating the reason.

### Filters

The dataset list provided by the endpoint can be filtered with the following attributes:

Filter        | Description                                                                  | Accepted values
------------- | ---------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
name          | Allow us to filter by name                                                   | any valid text
type          | Allow us to distinguish between tabular and raster datasets                  | `raster` or `tabular`
app           | Applications to which this dataset is being used                             | Available Applications: `["data4sdgs"]`
connectorType |                                                                              | `rest` or `document`
provider      | Dataset provider this include inner connectors and 3rd party ones            | [A valid dataset provider](##supported-dataset-sources)
userId        | the user who registered the dataset                                          | valid id
status        | the internal dataset status at connection time                               | `pending`, `saved` or `failed`
published     |                                                                              | `true`or `false`
env           | If the dataset is in preproduction environment or in production one          | `production`or `preproduction`
overwritted   | If the data can be overwritten (only for being able to make dataset updates) | `true`or `false`
verify        | If this dataset contains data that is verified using blockchain              | `true`or `false`
protected     | If it's a protected layer                                                    | `true`or `false`
geoInfo       | If it contains intersectable geographical info                               | `true`or `false`

> Filtering datasets

```shell
curl -X GET https://api.apihighways.org/v1/dataset?name=birds&provider=cartodb
```

> For inclusive filtering with array props use '@'

```shell
curl -X GET https://api.apihighways.org/v1/dataset?app=data4sdgs@anotherapp
```

### Sorting

You can sort by any dataset property. Prefix with '-' for a 'desc' ordering.

> Sorting datasets

```shell
curl -X GET https://api.apihighways.org/v1/dataset?sort=-provider,slug
```

```shell
curl -X GET https://api.apihighways.org/v1/dataset?sort=slug,-provider,userId&status=saved
```

### Relationships

Available relationships: Any dataset relationship ['widget', 'layer', 'vocabulary', 'metadata']

> Including relationships

```shell
curl -X GET https://api.apihighways.org/v1/dataset?sort=slug,-provider,userId&status=saved&includes=metadata,vocabulary,widget,layer
```

### Advanced filters

By vocabulary-tag matching

> Matching vocabulary tags

```shell
curl -X GET https://api.apihighways.org/v1/dataset?sort=slug,-provider,userId&status=saved&includes=metadata,vocabulary,widget,layer&vocabulary[legacy]=umd
```

### Pagination

Field        |         Description          |   Type
------------ | :--------------------------: | -----:
page[size]   | The number elements per page | Number
page[number] |       The page number        | Number

> Paginating the output

```shell
curl -X GET https://api.apihighways.org/v1/dataset?sort=slug,-provider,userId&status=saved&includes=metadata,vocabulary,widget,layer&vocabulary[legacy]=threshold&page[number]=1
curl -X GET https://api.apihighways.org/v1/dataset?sort=slug,-provider,userId&status=saved&includes=metadata,vocabulary,widget,layer&vocabulary[legacy]=threshold&page[number]=2
```

## How to get a specific dataset

> To get a dataset:

```shell
curl -X GET https://api.apihighways.org/v1/dataset/51943691-eebc-4cb4-bdfb-057ad4fc2145
```

> Response:

```shell
{
    "data": {
        "id": "51943691-eebc-4cb4-bdfb-057ad4fc2145",
        "type": "dataset",
        "attributes": {
            "name": "Timber Production RDC (test)",
            "slug": "Timber-Production-RDC-test-1490086842132",
            "type": null,
            "subtitle": null,
            "application": ["data4sdgs"],
            "dataPath": null,
            "attributesPath": null,
            "connectorType": "document",
            "provider": "csv",
            "userId": "58750a56dfc643722bdd02ab",
            "connectorUrl": "http://wri-forest-atlas.s3.amazonaws.com/COD/temp/annual%20timber%20production%20DRC%20%28test%29%20-%20Sheet1.csv",
            "tableName": "index_51943691eebc4cb4bdfb057ad4fc2145",
            "status": "saved",
            "overwrite": false,
            "legend": {
                "date": ["year"],
                "region": [],
                "country": [],
                "long": "",
                "lat": ""
            },
            "clonedHost": {},
            "errorMessage": null,
            "createdAt": "2017-01-25T21:48:27.535Z",
            "updatedAt": "2017-01-25T21:48:28.675Z"
        }
    }
}
```

> To get the dataset including its relationships:

```shell
curl -X GET https://api.apihighways.org/v1/dataset/06c44f9a-aae7-401e-874c-de13b7764959?includes=metadata,vocabulary,widget,layer
```

## Creating a Dataset

To create a dataset, you will need an authorization token. Follow the steps of this [guide](#generate-your-own-oauth-token) to get yours.

To create a dataset, you need to define all of the required fields in the request body. The fields that compose a dataset are:

Field               |                                                      Description                                                       |    Type |                                                                                                                Values |                                          Required
------------------- | :--------------------------------------------------------------------------------------------------------------------: | ------: | --------------------------------------------------------------------------------------------------------------------: | ------------------------------------------------:
name                |                                                      Dataset name                                                      |    Text |                                                                                                              Any Text |                                               Yes
type                |                                                      Dataset type                                                      |    Text |                                                                                                              Any Text |                                                No
subtitle            |                                                    Dataset subtitle                                                    |    Text |                                                                                                              Any Text |                                                No
application         |                                          Applications the dataset belongs to                                           |   Array |                                                                                         Any valid application name(s) |                                               Yes
sandbox             |                                          Dataset in the sandbox                                                        | Boolean |                                                                                                            true/false |                                                No
connectorType       |                                                     Connector type                                                     |    Text |                                                                                                   rest, document, wms |                                               Yes
provider            |                                               The connectorType provider                                               |    Text |                                                           cartodb, feature service, gee, csv, tsv, xml, json, nexgddp |                                               Yes
connectorUrl        |                                                 Url of the data source                                                 |     Url |                                                                                                               Any url |    Yes (except for gee, nexgddp and json formats)
tableName           |                                                       Table name                                                       |    Text |                                                                                                  Any valid table name |            No (just for GEE and nexgddp datasets)
data                |                             JSON DATA only for json connector if connectorUrl not present                              |    JSON |                                                                                                            [{},{},{}] | No (just for json if connectorUrl is not present)
dataPath            |                                           Path to the data in a json dataset                                           |    Text |                                                                                                    Any valid JSON key | No (just for json if connectorUrl is not present)
dataAttributes      |                                    Data fields - for json connector if data present                                    |  Object |                                                                                     {"key1": {"type": "string"},... } | No (just for json if connectorUrl is not present)
legend              |                                      Legend for dataset. Keys for special fields                                       |  Object | "legend": {"long": "123", "lat": "123", "country": ["pais"], "region": ["barrio"], "date": ["startDate", "endDate"]}} |                                                No
overwrite           |                                          It allows to overwrite dataset data                                           | Boolean |                                                                                                            true/false |                                                No
published           |                                           To set a public or private dataset                                           | Boolean |                                                                                                            true/false |                                                No
protected           |                           If it's a protected layer (not is possible to delete if it's true)                           | Boolean |                                                                                                            true/false |                                                No
verified            |                                    To generate a verified blockchain of the dataset                                    | Boolean |                                                                                                            true/false |                                                No
vocabularies        |                                                    Cluster of tags                                                     |  Object |                                           `{"vocabularyOne": {"tags": [<tags>]},"vocabularyTwo": {"tags": [<tags>]}}` |                                                No
widgetRelevantProps |                                          Group of relevant props of a widget                                           |   Array |                                                                                                              Any Text |                                                No
layerRelevantProps  |                                           Group of relevant props of a layer                                           |   Array |                                                                                                              Any Text |                                                No
subscribable        | Available dataset queries for subscriptions parameters accepted: `{{begin}}` for date begin and `{{end}}` for date end |  Object |                                                                             `{" <queryname>": "<querybodytemplate>"}` | No (just for json if connectorUrl is not present)

There are some differences between datasets types.

### Rest-Carto datasets

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
 '{
    "connectorType":"rest",
    "provider":"cartodb",
    "connectorUrl":"<cartoUrl>",
    "application":[
     "your", "apps"
    ],
    "name":"Example Carto Dataset"
}'
```

> A real example:

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
'{
    "connectorType":"rest",
    "provider":"cartodb",
    "connectorUrl":"https://wri-01.carto.com/tables/wdpa_protected_areas/table",
    "application":[
     "data4sdgs"
    ],
    "name":"World Database on Protected Areas -- Global"
}'
```

<aside class="notice">
    This is an authenticated endpoint!
</aside>

### Rest-ArcGIS feature Service

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
'{
    "connectorType":"rest",
    "provider":"featureservice",
    "connectorUrl":"https://services.arcgis.com/uDTUpUPbk8X8mXwl/arcgis/rest/services/Public_Schools_in_Onondaga_County/FeatureServer/0?f=json",
    "application":[
     "data4sdgs"
    ],
    "name":"Uncontrolled Public-Use Airports -- U.S."
}'
```

<aside class="notice">
    This is an authenticated endpoint!
</aside>

### Google Earth Engine

Google Earth Engine supports several kinds of datasets.
What kind of queries are possible is determined by its kind.

#### Google Earth Engine - Image

This example shows how to register an [Image](https://developers.google.com/earth-engine/image_overview). 
The IDs can be obtained from the [Google Earth Engine explorer](https://explorer.earthengine.google.com/#workspace) -- linking directly to the dataset is not possible.

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
'{
    "name": "umd_hansen_global_forest_change_2015",
    "connectorType": "rest",
    "provider": "gee",
    "application": ["data4sdgs"],
    "tableName": "UMD/hansen/global_forest_change_2015_v1_3"
}'
```

> Response

```json
{
   "data": {
      "attributes": {
         "application": [
            "data4sdgs"
         ],
         "attributesPath": null,
         "blockchain": {},
         "clonedHost": {},
         "connectorType": "rest",
         "connectorUrl": null,
         "dataPath": null,
         "env": "production",
         "errorMessage": null,
         "geoInfo": false,
         "layerRelevantProps": [],
         "legend": {
            "country": [],
            "date": [],
            "nested": [],
            "region": []
         },
         "mainDateField": null,
         "name": "umd_hansen_global_forest_change_2015",
         "overwrite": false,
         "protected": false,
         "provider": "gee",
         "published": true,
         "slug": "umd_hansen_global_forest_change_2015",
         "status": "pending",
         "subtitle": null,
         "tableName": "UMD/hansen/global_forest_change_2015_v1_3",
         "taskId": null,
         "type": null,
         "updatedAt": "2018-05-14T17:09:54.102Z",
         "userId": "599c0e5458113b0001d75c47",
         "verified": false,
         "widgetRelevantProps": []
      },
      "id": "4f507b39-2653-41f9-a880-766baa5a0c47",
      "type": "dataset"
   }
}
```


#### Google Earth Engine - ImageCollections

[ImageCollections](https://developers.google.com/earth-engine/ic_creating) are sets of images. 
They can be registered as datasets, but queries are done to the information of the `ImageCollection`, not the `Images` themselves. 
We'll use the Copernicus S2 1C imagery as an example.

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
'{
    "name": "COPERNICUS S2 Level 1C imagery",
    "connectorType": "rest",
    "provider": "gee",
    "application": ["data4sdgs"],
    "tableName": "COPERNICUS/S2"
}'
```

> Response

```json
{
   "data": {
      "attributes": {
         "application": [
            "data4sdgs"
         ],
         "attributesPath": null,
         "blockchain": {},
         "clonedHost": {},
         "connectorType": "rest",
         "connectorUrl": null,
         "dataPath": null,
         "env": "production",
         "errorMessage": null,
         "geoInfo": false,
         "layerRelevantProps": [],
         "legend": {
            "country": [],
            "date": [],
            "nested": [],
            "region": []
         },
         "mainDateField": null,
         "name": "COPERNICUS S2 Level 1C imagery",
         "overwrite": false,
         "protected": false,
         "provider": "gee",
         "published": true,
         "slug": "COPERNICUS-S2-Level-1C-imagery",
         "status": "pending",
         "subtitle": null,
         "tableName": "COPERNICUS/S2",
         "taskId": null,
         "type": null,
         "updatedAt": "2018-05-14T17:35:33.537Z",
         "userId": "599c0e5458113b0001d75c47",
         "verified": false,
         "widgetRelevantProps": []
      },
      "id": "c38673bf-29a6-4b75-9099-4314ce269a31",
      "type": "dataset"
   }
}
```

#### Google Earth Engine - FeatureCollections

[FeatureCollections](https://developers.google.com/earth-engine/feature_collections) are the homologue of vector layers in the Google Earth Engine ecosystem.

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
'{
    "name": "Global Land Ice Measurements 2016",
    "connectorType": "rest",
    "provider": "gee",
    "application": ["data4sdgs"],
    "tableName": "GLIMS/2016"
}'
```

> Response

```json
{
   "data": {
      "attributes": {
         "application": [
            "data4sdgs"
         ],
         "attributesPath": null,
         "blockchain": {},
         "clonedHost": {},
         "connectorType": "rest",
         "connectorUrl": null,
         "dataPath": null,
         "env": "production",
         "errorMessage": null,
         "geoInfo": false,
         "layerRelevantProps": [],
         "legend": {
            "country": [],
            "date": [],
            "nested": [],
            "region": []
         },
         "mainDateField": null,
         "name": "Global Land Ice Measurements 2016",
         "overwrite": false,
         "protected": false,
         "provider": "gee",
         "published": true,
         "slug": "Global-Land-Ice-Measurements-2016",
         "status": "pending",
         "subtitle": null,
         "tableName": "GLIMS/2016",
         "taskId": null,
         "type": null,
         "updatedAt": "2018-05-14T18:05:29.282Z",
         "userId": "599c0e5458113b0001d75c47",
         "verified": false,
         "widgetRelevantProps": []
      },
      "id": "7416e29b-908a-4e06-a9b0-8bebb1e435b7",
      "type": "dataset"
   }
}
```


### Rest-NEXGDDP

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
'{
    "connectorType":"rest",
    "provider":"nexgddp",
    "tableName": "historical/ACCESS1_0"
    "application":[
     "data4sdgs"
    ],
    "name":"Nexgddp"
}'
```

### Rasdaman

The `connectorUrl` must be a URL pointing to a valid geotiff file.

```shell
curl -XPOST 'https://api.apihighways.org/v1/dataset' -d \
-H 'Authorization: Bearer <your-token>'  \
-H 'Content-Type: application/json' -d \
'{
    "connectorType":"rest",
    "provider":"rasdaman",
    "connectorUrl":"rw.dataset.raw/1508321309784_test_rasdaman_1b.tiff",
    "application":[
     "data4sdgs"
    ],
    "name":"rasdaman dataset"
}'
```

### Document-CSV, Document-TSV, Document-XML

The `connectorUrl` must be an accessible CSV, TSV or XML file, non-compressed - zip, tar, tar.gz, etc are not supported.

CSV datasets support some optional fields on the creation process. They are:

Field      |                  Description                   |   Type |        Values | Required
---------- | :--------------------------------------------: | -----: | ------------: | -------:
legend     |                                                | Object |               |       No
-- lat     |       Name of column with latitude value       |   Text |      Any word |       No
-- long    |      Name of column with longitude value       |   text |      Any word |       No
-- date    |  Name of columns with date value (ISO Format)  |  Array | Any list word |       No
-- region  | Name of columns with region value (ISO3 code)  |  Array | Any list word |       No
-- country | Name of columns with country value (ISO3 code) |  Array | Any list word |       No

z

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
'{
    "connectorType":"document",
    "provider":"csv",
    "connectorUrl":"<csvUrl>",
    "application":[
     "your", "apps"
    ],
    "legend": {
      "lat": "lat-column",
      "long": "long-column",
      "date": ["date1Column", "date2Column"],
      "region": ["region1Column", "region2Column"],
      "country": ["country1Column", "country2Column"]
    },
    "name":"Example CSV Dataset"
}'
```

> Real example:

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
'{
    "connectorType":"document",
    "provider":"csv",
    "connectorUrl":"https://gfw2-data.s3.amazonaws.com/alerts-tsv/glad_headers.csv",
    "application":[
     "data4sdgs"
    ],
    "legend": {
      "lat": "lat",
      "long": "lon"
    },
    "name":"Glad points"
}'
```

<aside class="notice">
    This is an authenticated endpoint!
</aside>

### Big Query

The `tableName` must be the path of an accessible public Big Query Dataset. The `tableName` format is `owner:table.name` (e.g. `bigquery-public-data:world_bank_intl_education.international_education`). View detailed documentation [here](https://cloud.google.com/bigquery/docs/).


```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
 '{
  "connectorType": "rest",
  "provider": "bigquery",
  "tableName": "[table path]",
  "application": [
    "data4sdgs"
  ],
  "name": "Example Big Query Dataset"
}'

```

> Real example:

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
 '{
  "connectorType": "rest",
  "provider": "bigquery",
  "tableName": "[bigquery-public-data:world_bank_intl_education.international_education]",
  "application": [
    "data4sdgs"
  ],
  "name": "World Bank: Education Data. Contains key education statistics from a variety of sources to provide a look at global literacy, spending, and access"
}'

```

<aside class="notice">
    This is an authenticated endpoint!
</aside>


### Document-JSON

The JSON dataset service supports data from external json file or data as json array send in request body.

The `connectorUrl` must be an accessible JSON file

JSON datasets support some optional fields in the creation process. They are:

Field      |                          Description                          |   Type |        Values |                                 Required
---------- | :-----------------------------------------------------------: | -----: | ------------: | ---------------------------------------:
data       | JSON DATA only for json connector if connectorUrl not present |  Array |    [{},{},{}] | Yes for json if connectorUrl not present
legend     |                                                               | Object |               |                                       No
-- lat     |              Name of column with latitude value               |   Text |      Any word |                                       No
-- long    |              Name of column with longitude value              |   text |      Any word |                                       No
-- date    |         Name of columns with date value (ISO Format)          |  Array | Any list word |                                       No
-- region  |         Name of columns with region value (ISO3 code)         |  Array | Any list word |                                       No
-- country |        Name of columns with country value (ISO3 code)         |  Array | Any list word |                                       No

<aside class="notice">
    This is an authenticated endpoint!
</aside>

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
'{
    "connectorType":"document",
    "provider":"json",
    "connectorUrl":"<jsonURL>",
    "application":[
     "your", "apps"
    ],
    "legend": {
      "lat": "lat-column",
      "long": "long-column",
      "date": ["date1Column", "date2Column"],
      "region": ["region1Column", "region2Column"],
      "country": ["country1Column", "country2Column"]
    },
    "name":"Example JSON Dataset",
}'
```

It is also possible to create a JSON dataset by including the data directly in the request:

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
'{
    "connectorType":"document",
    "provider":"json",
    "connectorUrl":"",
    "application":[
     "your", "apps"
    ],
    "data": {"myData":[
            {"name":"nameOne", "id":"random1"},
            {"name":"nameTow", "id":"random2"}
          ]},
    "legend": {
      "lat": "lat-column",
      "long": "long-column",
      "date": ["date1Column", "date2Column"],
      "region": ["region1Column", "region2Column"],
      "country": ["country1Column", "country2Column"]
    },
    "name":"Example JSON Dataset"
}'
```

### World Bank datasets (index)

The World Bank (WB) connector allows indexing datasets which data is available on the WB API.
Datasets created using the WB type are indexed only, so several operations, like querying data or structure, are not available.
However, they will still be presented in dataset list and search operations.
Additionally, metadata for these datasets will be automatically generated when the dataset is created, based on metadata served by the WB API.
You can find details about this mapping [here](https://github.com/GPSDD/world-bank-index-adapter#field-correspondence).

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
 '{
    "name": "Your prefered name for the dataset",
    "provider": "worldbank",
    "connectorType": "rest", 
    "tableName":"<name of the indicator in the WB API>"
  }'
```

> A real example:

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
 '{
    "name": "Coverage of social insurance programs (% of population)",
    "provider": "worldbank",
    "connectorType": "rest", 
    "tableName":"per_si_allsi.cov_pop_tot"
  }'
```

<aside class="notice">
    This is an authenticated endpoint!
</aside>

### Resource Watch API datasets (index)

The Resource Watch API (RW) connector allows indexing datasets which data is available on the RW API.
Datasets created using the RW type are indexed only, so several operations, like querying data or structure, are not available.
However, they will still be presented in dataset list and search operations.
Additionally, metadata for these datasets will be automatically generated when the dataset is created, based on metadata served by the RW API.
You can find details about this mapping [here](https://github.com/GPSDD/resource-watch-index-adapter#field-correspondence).

Note that the RW API serves more than just the RW website, so RW API datasets may feature details associated with other applications
served by the RW API (Aqueduct, GFW, etc). Also, due to this, a single RW dataset may have multiple metadata objects, for different
application and language combinations. To account for this, the RW indexing connector accepts optional `sourceLanguage` and `sourceApplication`
parameters. When specified, this allow choosing which metadata object to use when indexing RW datasets and generating their corresponding
API Highways metadata. If none are provided, one of the objects is picked, based on the order in which the RW metadata enpoint serves them.
Whenever possible, it's recommended that you specify both parameters, ensuring they match an existing metadata object on the RW API.

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
 '{
    "name": "Your prefered name for the dataset",
    "provider": "resourcewatch",
    "connectorType": "rest", 
    "tableName":"<id of the dataset in the RW API>",
    "sourceLanguage":"<language of the RW metadata to use>",
    "sourceApplication":"<application of the RW metadata to use>"
  }'
```

> A real example:

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
 '{
    "name": "All Worldwide Crops",
    "provider": "resourcewatch",
    "connectorType": "rest", 
    "tableName":"b7bf012f-4b8b-4478-b5c9-6af3075ca1e4",
    "sourceLanguage": "en"
  }'
```

<aside class="notice">
    This is an authenticated endpoint!
</aside>

### HDX API datasets (index)

The HDX connector allows indexing datasets which data is available on the [Humanitarian Data Exchange](https://data.humdata.org/) API.
Datasets created using the API type are indexed only, so several operations, like querying data or structure, are not available.
However, they will still be presented in dataset list and search operations.
Additionally, metadata for these datasets will be automatically generated when the dataset is created, based on metadata served by the API API.
You can find details about this mapping [here](https://github.com/GPSDD/hdx-index-connector#field-correspondence).

Note that, due to fundamental differences in data structures between this API and HDX's, not all HDX datasets (also known as `packages`) are supported.
For additional details on what's supported and what's not, read the [connector documentation](https://github.com/GPSDD/hdx-index-connector#field-correspondence).

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
 '{
    "name": "Your prefered name for the dataset",
    "provider": "hdx",
    "connectorType": "rest", 
    "tableName":"<id of the package in the HDX API>"
  }'
```

> A real example:

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
 '{
    "name": "Sierra Leone health facilities",
    "provider": "hdx",
    "connectorType": "rest", 
    "tableName":"141121-sierra-leone-health-facilities"
  }'
```

<aside class="notice">
    This is an authenticated endpoint!
</aside>


### UN API datasets (index)

The UN connector allows indexing datasets which data is available on the [The United Nations Statistics Division](https://unstats.un.org/) API.
Datasets created using the API type are indexed only, so several operations, like querying data or structure, are not available.
However, they will still be presented in dataset list and search operations.
Additionally, metadata for these datasets will be automatically generated when the dataset is created, based on metadata served by the API API.
You can find details about this mapping [here](https://github.com/GPSDD/un-index-connector#field-correspondence).

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
 '{
    "name": "Your prefered name for the dataset",
    "provider": "un",
    "connectorType": "rest", 
    "tableName":"<id of the dataset in the UN API>"
  }'
```

> A real example:

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
 '{
    "name": "Development assistance for water supply and sanitation",
    "provider": "un",
    "connectorType": "rest", 
    "tableName":"DC_TOF_WASHL"
  }'
```

<aside class="notice">
    This is an authenticated endpoint!
</aside>

### Generic datasets (index)

You can create a generic dataset reference in API Highways. This type of dataset does not serve any data - it serves only for indexing
purposes - and, unlike other index connectors, does not generate and update metadata automatically. While not enforced, it's highly
recommended that, when creating the dataset, you set the corresponding metadata. The metadata's required fields should point to the
dataset's data source, which will ensure this dataset serves its purpose - index a 3rd party datasets from virtually any source.

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
 '{
    "name": "Your prefered name for the dataset",
    "provider": "genericindex",
    "connectorType": "rest" 
  }'
```

> A real example:

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
 '{
    "name": "test index dataset",
    "provider": "genericindex",
    "connectorType": "rest"
  }'
```

<aside class="notice">
    This is an authenticated endpoint!
</aside>

## Uploading a Dataset (Binary)

You can upload your raw data directly to S3 making use of the "upload" endpoint. This endpoint accepts a file in the property "dataset" and returns a valid connectorUrl. With this connectorUrl you can create or update a "document" dataset, or a raster dataset in the Rasdaman adapter.

```shell
curl -X POST https://api.apihighways.org/v1/dataset/upload \
-H "Authorization: Bearer <your-token>" \
-F provider=csv,
-F dataset=@<your-file>
```

It returns the following information:

> Response

```json
{
  "connectorUrl": "rw.dataset.raw/tmp/upload_75755182b1ceda30abed717f655c077d-observed_temp.csv"
}
```

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"
'{
    "connectorType":"document",
    "provider":"csv",
    "connectorUrl":"rw.dataset.raw/tmp/upload_75755182b1ceda30abed717f655c077d-observed_temp.csv",
    "application":[
     "your", "apps"
    ],
    "name":"Example RAW Data Dataset"
}'
```

## Updating a Dataset

In order to modify the dataset, you can PATCH a request. It accepts the same parameters as the _create dataset_ endpoint, and you will need an authentication token.

> An example update request:

```shell
curl -X PATCH https://api.apihighways.org/v1/dataset/<dataset-id> \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json" -d \
'{
    "name": "Another name for the dataset"
}'
```

<aside class="notice">
    This is an authenticated endpoint!
</aside>

## Deleting a Dataset

**When a dataset is deleted the user's applications that were present on the dataset will be removed from it. If this results in a dataset without applications, the dataset itself will be then deleted.**

```shell
curl -X DELETE https://api.apihighways.org/v1/dataset/<dataset-id> \
-H "Authorization: Bearer <your-token>"
-H "Content-Type: application/json"
```

<aside class="notice">
    This is an authenticated endpoint!
</aside>

## Cloning a Dataset

```shell
curl -X POST https://api.apihighways.org/v1/dataset/5306fd54-df71-4e20-8b34-2ff464ab28be/clone \
-H "Authorization: Bearer <your-token>"
-H "Content-Type: application/json" -d \
'{
  "dataset": {
    "datasetUrl": "/query/5306fd54-df71-4e20-8b34-2ff464ab28be?sql=select%20%2A%20from%20data%20limit%2010",
    "application": [
      "your",
      "apps"
    ]
  }
}'
```

<aside class="notice">
    This is an authenticated endpoint!
</aside>

## Concatenate Data

You can add more data to a dataset only if the overwrite dataset property has been set to true.

> Concatenate data using external data source:

```shell
curl -X POST https://api.apihighways.org/v1/dataset/:dataset_id/concat \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
'{
   "connectorUrl":"<csvUrl>",
   "dataPath": "data... etc"
}'
```

> Concatenate data using JSON array in post body:

```shell
curl -X POST https://api.apihighways.org/v1/dataset/:dataset_id/concat \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
'{
   "data": [{},{}]
}'
```

<aside class="notice">
    This is an authenticated endpoint!
</aside>

## Overwrite Data

You can overwrite the data if the overwrite dataset property has been set to true.

> Overwrite data using external data source:

```shell
curl -X POST https://api.apihighways.org/v1/dataset/:dataset_id/data-overwrite \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
'{
   "connectorUrl":"<url>",
   "dataPath": "data"
}'
```

> Overwrite data using JSON array in post body:

```shell
curl -X POST https://api.apihighways.org/v1/dataset/:dataset_id/data-overwrite \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
'{
   "data": [{},{}]
}'
```

<aside class="notice">
    This is an authenticated endpoint!
</aside>

## Overwrite specific Data

You can overwrite specific data if the overwrite dataset property has been set to true.

```shell
curl -X POST https://api.apihighways.org/v1/dataset/:dataset_id/data/:data_id \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"  -d \
'{
   "data_id":":data_id",
   "data": {"a": 1}
}'
```

<aside class="notice">
    This is an authenticated endpoint!
</aside>

## Delete specific Data

You can delete specific data if the overwrite dataset property has been set to true.

```shell
curl -X DELETE https://api.apihighways.org/v1/dataset/:dataset_id/data/:data_id \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"
```

<aside class="notice">
    This is an authenticated endpoint!
</aside>

## Dataset data sync

To sync the data of a dataset, you need to choose the action type (concat or overwrite), a cron pattern and a valid url. This configuration should be set in the 'sync' property when creating or updating a document dataset.

Please be sure that the 'overwrite' property is set to true. This could be used as a lock in order to not allow new updates even if the sync task is actually created.

```shell
curl -X POST https://api.apihighways.org/v1/dataset \
-H "Authorization: Bearer <your-token>" \
-H "Content-Type: application/json"
'{
    "connectorType":"document",
    "provider":"csv",
    "connectorUrl":"<csvUrl>",
    "application":[
     "your", "apps"
    ],
    "name":"Example SYNC Dataset",
    "overwrite": true,
    "sync": {
        "action":"concat",
        "cronPattern":"0 * * * * *",
        "url":"<updateCsvUrl>"
    }
}'
```
