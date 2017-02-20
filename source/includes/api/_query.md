# Query

In order to retrieve data from the created datasets it is possible to do queries in SQL or Feature Service languages to the API.

Thanks to ```/query``` endpoint, the final user can get the desired information just sending a valid sql query.

## Query examples

```
# Select and aggregations

select * from table
select count(*) from table
select a, b from table
select a, count(*) from table

# Functions and alias

select sum(int) from table
select avg(int) from table
select max(int) from table
select min(int) from table
select min(int) as minimun from table

select * from table limit=20
select a as b from table limit=20

# Where conditionals

select * from table where a > 2
select * from table where a = 2
select * from table where a < 2
select * from table where a >= 2
select * from table where a = 2 and b < 2
select * from table where text like ‘a%’
Select * from table where st_intersects(st_setsrid(st_geomfromgeojson(‘{}’), 4326), the_geom)

# Group by

select a, count(int) from table group by a
select count(*) FROM tablename group by ST_GeoHash(the_geom, 8)

```