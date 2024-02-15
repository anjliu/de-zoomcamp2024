-- how many records?
SELECT COUNT(*) FROM dataeng-zoomcamp-412722.green_taxi.green_taxi_tripdata;

-- comparing query memory usage between paritioned and non-partitioned tables
SELECT COUNT( DISTINCT PULocationID) FROM dataeng-zoomcamp-412722.green_taxi.green_taxi_tripdata;
SELECT COUNT( DISTINCT PULocationID) FROM dataeng-zoomcamp-412722.green_taxi.green_taxi_tripdata_nonPartitioned_internal;

-- records with no fares
SELECT COUNT(*) 
FROM dataeng-zoomcamp-412722.green_taxi.green_taxi_tripdata
WHERE fare_amount = 0;
