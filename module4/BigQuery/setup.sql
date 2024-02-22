-- create tables using source data
CREATE OR REPLACE TABLE `dataeng-zoomcamp-412722.trips_data_all.green_tripdata` AS
SELECT * FROM `dataeng-zoomcamp-412722.nyc_tlc_trips.tlc_green_trips_2019`;

CREATE OR REPLACE TABLE `dataeng-zoomcamp-412722.trips_data_all.yellow_tripdata` AS
SELECT * FROM `dataeng-zoomcamp-412722.nyc_tlc_trips.tlc_yellow_trips_2019`;

-- insert data from subsequent years
INSERT INTO `dataeng-zoomcamp-412722.trips_data_all.green_tripdata`
SELECT * FROM `dataeng-zoomcamp-412722.nyc_tlc_trips.tlc_green_trips_2020`;

INSERT INTO `dataeng-zoomcamp-412722.trips_data_all.yellow_tripdata`
SELECT * FROM `dataeng-zoomcamp-412722.nyc_tlc_trips.tlc_yellow_trips_2020`;