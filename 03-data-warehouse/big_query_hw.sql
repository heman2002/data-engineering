CREATE OR REPLACE EXTERNAL TABLE `taxi-rides-ny-412715.nytaxi.external_green_tripdata` 
OPTIONS (
  format='PARQUET',
  uris=['gs://nyc-tl-data-heman/green_tripdata_2022-*.parquet']
);

CREATE OR REPLACE TABLE `taxi-rides-ny-412715.nytaxi.green_tripdata_non_partitioned`
AS SELECT * FROM `taxi-rides-ny-412715.nytaxi.external_green_tripdata`;

SELECT COUNT(1) FROM `taxi-rides-ny-412715.nytaxi.external_green_tripdata`;

SELECT COUNT(DISTINCT PULocationID) FROM `taxi-rides-ny-412715.nytaxi.external_green_tripdata`;

SELECT COUNT(DISTINCT PULocationID) FROM `taxi-rides-ny-412715.nytaxi.green_tripdata_non_partitioned`;

SELECT COUNT(1) FROM `taxi-rides-ny-412715.nytaxi.green_tripdata_non_partitioned` WHERE fare_amount = 0;

CREATE OR REPLACE TABLE `taxi-rides-ny-412715.nytaxi.green_tripdata_partitioned_clustered`
PARTITION BY DATE(lpep_pickup_datetime)
CLUSTER BY PUlocationID
AS SELECT * FROM `taxi-rides-ny-412715.nytaxi.green_tripdata_non_partitioned`;

SELECT DISTINCT(PULocationID) 
FROM `taxi-rides-ny-412715.nytaxi.green_tripdata_non_partitioned` 
WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30';

SELECT DISTINCT(PULocationID) 
FROM `taxi-rides-ny-412715.nytaxi.green_tripdata_partitioned_clustered`
WHERE DATE(lpep_pickup_datetime) BETWEEN '2022-06-01' AND '2022-06-30';

SELECT count(*) FROM `taxi-rides-ny-412715.nytaxi.green_tripdata_non_partitioned`;
