---
title: DH API Reference
app: dh
language_tabs:
  - shell: cURL

toc_footers:
  - <a href='https://api.apihighways.org/auth/sign-up'>Sign Up for a Developer Key</a>
  - <a href='https://github.com/tripit/slate'>Documentation Powered by Slate</a>

includes:
  - api/authentication
  - api/dataset
  - api/query
  - api/fields
  - api/metadata
  - api/vocabulary
  - api/geostore
  - api/favourites
  - api/graph
  - errors

logo: logo-api-highways.svg

search: true
---

# Introduction

Welcome to the Data Highways API Documentation. This API documentation covers a
wide range of use cases, from querying data to uploading your own datasets. Some of 
the most common use cases include:

- [Searching for a dataset](#filters)
- [Querying a given dataset](#query)
- [Accessing metadata](#getting-metadata)


The API also supports more advanced uses cases, for which you may need to be authenticated
and have special permissions given by an admin. There may include:

- [Uploading your own dataset](#creating-a-dataset)
- [Updating an existing dataset](#updating-a-dataset)
- [Creating](#creating-a-metadata-object) or [updating](#updating-a-metadata) metadata for a dataset
- [Deleting a dataset](#deleting-a-dataset)

