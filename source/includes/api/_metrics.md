# Metrics

The API includes a metrics component that allows gathering data about its usage.

<aside class="notice">
    This is an authenticated feature!
</aside>


## Basic usage

```
https://api.apihighways.org/api/v1/statistic
```

<aside class="warning">
    Loading statistics without specifying additional parameters, or with restrictions that yield too many results, 
    will result in an an "Executor error during find command" 500 error. If you see this, try further restricting 
    your results using the filter options. 
</aside>


## Output format

By default, the response will be served in `JSON` format. If you'd like to have the results in `CSV` format, you can do so
using `format=csv` query parameter.


## Filter values

There are several filter criteria you can use to get a more manageable subset of the data

| Filter          | Description  | Example |
|-----------------|---|---|
| authenticated   | Show only requests done by authenticated/anonymous users  | `/api/v1/statistic?authenticated=false`  |
| period          | Comma separated start and end datetime. Date format should follow M/D/Y format, or any format [supported by NodeJS](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date) | `/api/v1/statistic?period=07/02/2018,07/03/2018`  |
| userEmail       | Email address of the user to filter by  | `/api/v1/statistic?userEmail=admin@control-tower.org`  |
| sandbox         | Filter requests done to sandboxed datasets  | `/api/v1/statistic?sandbox=false`  |
| code            | Filter by HTTP response code  | `/api/v1/statistic?code=200`  |
| datasetProvider | Filter dataset and query requests by their corresponding dataset provider  | `/api/v1/statistic?datasetProvider=cartodb`  |
| datasetId       | Filter dataset and query requests by their corresponding dataset id  | `/api/v1/statistic?datasetId=16aceffb-b544-4ad3-8f63-8e85f18ad9b2`  |
| datasetName     | Filter dataset and query requests by their corresponding dataset name  | `/api/v1/statistic?datasetName=Water%20basins%20in%20South%20Africa`  |
| requestType     | Filter dataset and query requests by their corresponding type | `/api/v1/statistic?requestType=query`  |
| client          | Filter requests originating from API Highways site (`front`) from other clients (`other`) | `/api/v1/statistic?client=front`  |

Multiple filters can be combined in a single query.


## Sort criteria

There are several filter criteria you can use to sort your data:

| Sort criteria  |
|-----------------|
| authenticated   |
| userEmail       |
| userId          |
| sandbox         |
| code            |
| datasetProvider |
| datasetId       |
| datasetName     |
| client          |


```
https://api.apihighways.org/api/v1/statistic?authenticated=true&sort=userEmail
```

## Group criteria

There are several filter criteria you can use to group your data:

| Group criteria  |
|-----------------|
| authenticated   |
| userEmail       |
| userId          |
| sandbox         |
| code            |
| datasetProvider |
| datasetId       |
| datasetName     |
| client          |

```
https://api.apihighways.org/api/v1/statistic?client=other&group=userId

[
  {"_id":null,"count":14},
  {"_id":"1a10d7c6e0a37126611fd7a7","count":16}
]
```

## Example queries

### Top users

```
https://api.apihighways.org/api/v1/statistic?authenticated=true&group=userEmail
```

### Top queries

```
https://api.apihighways.org/api/v1/statistic?group=datasetId&requestType=query
```
