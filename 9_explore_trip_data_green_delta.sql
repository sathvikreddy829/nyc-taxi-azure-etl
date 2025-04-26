use nyc_taxi_discovery;

-- This is auto-generated code
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'trip_data_green_delta/',
        data_source = 'nyc_taxi_data_raw',
        FORMAT = 'DELTA'
    ) AS [result]

exec sp_describe_first_result_set N'
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK ''trip_data_green_delta/'',
        data_source = ''nyc_taxi_data_raw'',
        FORMAT = ''DELTA''
    ) AS [result]'

--specifying datatypes 
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'trip_data_green_delta/',
        data_source = 'nyc_taxi_data_raw',
        FORMAT = 'DELTA'
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
        congestion_surcharge float,
        year varchar(4),
        month varchar(2)
    )as [result]    

--querying subset of columns
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'trip_data_green_delta/',
        data_source = 'nyc_taxi_data_raw',
        FORMAT = 'DELTA'
 )with(
        tip_amount float,
        trip_type int,
        year varchar(4),
        month varchar(2)
    )as [result]    
