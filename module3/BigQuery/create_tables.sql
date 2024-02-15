
-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `green_taxi.green_taxi_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://green-taxi-ajl/green_taxi_data_2022*']
);

-- Create a non partitioned table from external table
CREATE OR REPLACE TABLE green_taxi.green_taxi_tripdata_nonPartitioned_internal AS
SELECT * FROM green_taxi.green_taxi_tripdata;

-- Create a partitioned table from external table
CREATE OR REPLACE TABLE green_taxi.green_taxi_tripdata_partitioned_internal
PARTITION BY
  DATE(lpep_pickup_datetime_ts)
CLUSTER BY PUlocationID
  AS
SELECT 
  VendorID,
  TIMESTAMP_SECONDS(CAST(lpep_pickup_datetime / 1000000000 AS INT64)) AS lpep_pickup_datetime_ts,
  lpep_dropoff_datetime,
  store_and_fwd_flag,
  RatecodeID,
  PULocationID,
  DOLocationID,
  passenger_count,
  trip_distance,
  fare_amount,
  extra,
  mta_tax,
  tip_amount,
  tolls_amount,
  ehail_fee,
  improvement_surcharge,
  total_amount,
  payment_type,
  trip_type,
  congestion_surcharge
FROM green_taxi.green_taxi_tripdata;

