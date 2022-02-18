#! /bin/bash


# Uses UI t ocreate and read up a csv to BigQuery

# To make a dataset
bq --location=location mk --dataset --default_table_expiration integer1 \
   --default_partition_expiration integer2 --default_kms_key kms_key_name \
   --description description project_id:dataset

# For example, the following command creates a dataset named mydataset with data location set to US, a default table expiration of 3600 seconds (1 hour), and a description of This is my dataset
bq --location=US mk -d \
--default_table_expiration 3600 \
--description "This is my dataset." \
mydataset

# Create tables
bq mk --table --expiration integer --description description \
  --label key_1:value_1 --label key_2:value_2 project_id:dataset.table schema

# Load data from local file
bq load --source_format=CSV mydataset.mytable gs://mybucket/mydata.csv ./myschema.json

#standardSQL
SELECT
  *
FROM
  nyctaxi.2018trips
ORDER BY
  fare_amount DESC
LIMIT  5

# Load from cloud storage using Cloud Shell
# this subset is to be appended to the existing 2018trips table was created with the UI
bq load --source_format=CSV --autodetect --noreplace nyctaxi.2018trips gs://cloud-training/OCBL013/nyc_tlc_yellow_trips_2018_subset_2.csv

#
# Create tables from other tables with DDL
#

# 1. CREATE TABLE
#standardSQL
CREATE TABLE
  nyctaxi.january_trips AS
SELECT
  *
FROM
  nyctaxi.2018trips
WHERE
  EXTRACT(Month
  FROM
    pickup_datetime)=1;

# longest distance traveled in the month of January
#standardSQL
SELECT
  *
FROM
  nyctaxi.january_trips
ORDER BY
  trip_distance DESC
LIMIT
  1
