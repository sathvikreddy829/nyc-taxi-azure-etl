use nyc_taxi_discovery;

-- This is auto-generated code
SELECT
    top 100 *
FROM
    OPENROWSET(
        BULK 'trip_data_green_parquet/year=2020/month=01/',
        data_source = 'nyc_taxi_data_raw',
        FORMAT = 'PARQUET'
    ) AS [result]

--specifying datatypes 
SELECT
    top 100 *
FROM
    OPENROWSET(
        BULK 'trip_data_green_parquet/year=2020/month=01/',
        data_source = 'nyc_taxi_data_raw',
        FORMAT = 'PARQUET'
    )with(
        VendorID int,
        lpep_pickup_datetime datetime2(7),
        lpep_dropoff_datetime datetime2(7),
        store_and_fwd_flag char(1),
        RatecodeID INT,
        PULocationID INT,
        DOLocationID int,
        passenger_count int,
        trip_distance float,
        fare_amount float,
        extra float,
        mta_tax float,
        tip_amount float,
        tolls_amount float,
        ehail_fee int,
        improvement_surcharge float,
        total_amount float,
        payment_type int,
        trip_type int,
        congestion_surcharge float
    ) AS [result]

--query from folders using wildcard characters 
SELECT
    top 100 *
FROM
    OPENROWSET(
        BULK 'trip_data_green_parquet/year=2020/month=01/*.parquet',
        data_source = 'nyc_taxi_data_raw',
        FORMAT = 'PARQUET'
    ) AS [result]

--use filename function
SELECT
    trip_data.filename() as file_name,
    trip_data.*
FROM
    OPENROWSET(
        BULK 'trip_data_green_parquet/year=2020/month=01/*.parquet',
        data_source = 'nyc_taxi_data_raw',
        FORMAT = 'PARQUET'
    ) AS trip_data;

--query from subfolders 
SELECT
    top 100 *
FROM
    OPENROWSET(
        BULK 'trip_data_green_parquet/**',
        data_source = 'nyc_taxi_data_raw',
        FORMAT = 'PARQUET'
    ) AS trip_data;

--use filepath to target partitions 
SELECT
    trip_data.filepath(1) as year,
    trip_data.filepath(2) as month,
    count(1) as record_count
FROM
    OPENROWSET(
        BULK 'trip_data_green_parquet/year=*/month=*/*.parquet',
        data_source = 'nyc_taxi_data_raw',
        FORMAT = 'PARQUET'
    ) AS trip_data
    where trip_data.filepath(1) = '2020'
      and trip_data.filepath(2) in ('06','07','08')
    group by trip_data.filepath(1), trip_data.filepath(2)
    order by trip_data.filepath(1), trip_data.filepath(2);





