use nyc_taxi_ldw;

if object_id('bronze.taxi_zone') is not null
    drop EXTERNAL table bronze.taxi_zone;

--create taxi_zone table
create external table bronze.taxi_zone
    (   location_id  SMALLINT ,
        borough VARCHAR(15) ,
        zone VARCHAR(50) ,
        service_zone VARCHAR(50) 
    )
    with (
        LOCATION = 'raw/taxi_zone.csv',
        DATA_SOURCE = nyc_taxi_src,
        FILE_FORMAT = csv_file_format_pv1  
    );

--create vendor external table 
if object_id('bronze.vendor') is not NULL
  drop external table bronze.vendor;

create external table bronze.vendor
   (
       vendor_id tinyint,
       vendor_name varchar(50)
    )
    with 
    (
    location = 'raw/vendor.csv',
    DATA_SOURCE = nyc_taxi_src,
    FILE_FORMAT = csv_file_format
    );

--create calender extrenal table 
if object_id('bronze.calendar') is not NULL
  drop external table bronze.calendar;

create external table bronze.calendar
     (
     date_key INT,
     date  date,
     year  smallint,
     month  tinyint,
     day tinyint,
     day_name varchar(10),
     day_of_year smallint,
     week_of_month tinyint,
     week_of_year tinyint,
     month_name varchar(10),
     year_month int,
     year_week int
     )
     with(
         location = 'raw/calendar.csv',
         DATA_SOURCE = nyc_taxi_src,
         FILE_FORMAT = csv_file_format
       ); 

--create trip_type external table 

if object_id('bronze.trip_type') is not null
  drop external table bronze.trip_type;
 
create external table bronze.trip_type
     (
      trip_type SMALLINT,
      trip_type_desc varchar(50)
      )
      with
      (
        location = 'raw/trip_type.tsv',
        DATA_SOURCE =nyc_taxi_src,
        FILE_FORMAT = tsv_file_format
      );


--create tripdata external table csv
if object_id('bronze.trip_data_green_csv') is not NULL  
  drop external table bronze.trip_data_green_csv;
  
CREATE EXTERNAL TABLE bronze.trip_data_green_csv
     (
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
     )
     with
     ( 
        LOCATION = 'raw/trip_data_green_csv/**',
        DATA_SOURCE = nyc_taxi_src,
        FILE_FORMAT = csv_file_format_pv1
     );

--create tripdata external table parquet
if object_id('bronze.trip_data_green_parquet') is not NULL  
  drop external table bronze.trip_data_green_parquet;
  
CREATE EXTERNAL TABLE bronze.trip_data_green_parquet
     (
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
     )
     with
     ( 
        LOCATION = 'raw/trip_data_green_parquet/**',
        DATA_SOURCE = nyc_taxi_src,
        FILE_FORMAT = parquet_file_format
     );



--create tripdata external table delta
if object_id('bronze.trip_data_green_delta') is not NULL  
  drop external table bronze.trip_data_green_delta;
  
CREATE EXTERNAL TABLE bronze.trip_data_green_delta
     (
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
     )
     with
     ( 
        LOCATION = 'raw/trip_data_green_delta',
        DATA_SOURCE = nyc_taxi_src,
        FILE_FORMAT = delta_file_format
     );

  



