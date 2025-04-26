use nyc_taxi_ldw
go

--create view for rate code json file
drop view if exists bronze.vw_rate_code
go

create view bronze.vw_rate_code
as 
select rate_code_id,rate_code
 from openrowset(
    bulk 'raw/rate_code.json',
    data_source = 'nyc_taxi_src',
    format = 'csv',
    FIELDTERMINATOR = '0x0b',
    FIELDQUOTE = '0x0b',
    ROWTERMINATOR = '0x0b'
  )
  with(
    jsonDoc nvarchar(max) 
  )as rate_code
  cross apply openjson(jsonDoc)
  with(
    rate_code_id tinyint,
    rate_code varchar(20)
  )
go


--create view for payment type file 
drop view if exists bronze.vw_payment_type 
go 

create view bronze.vw_payment_type 
as 
select payment_type,description
  from openrowset(
     bulk 'raw/payment_type.json',
     data_source = 'nyc_taxi_src',
     format = 'CSV',
     fieldterminator = '0x0b',
     fieldquote = '0x0b',
     rowterminator = '0x0a'
  )
  with(
    jsonDoc NVARCHAR(MAX)
  )as Payment_type
  cross apply openjson(jsonDoc)
  with
  (
    payment_type smallint,
    description varchar(15) '$.payment_type_desc'
  )
go

--create view for trip data green csv 
drop view if exists bronze.vw_trip_data_green_csv 
go 


create view bronze.vw_trip_data_green_csv
as 
SELECT
    result.filepath(1) as year,
    result.filepath(2) as month,
    result.*
FROM
    OPENROWSET(
        BULK 'raw/trip_data_green_csv/year=*/month=*/*.csv',
        data_source = 'nyc_taxi_src',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        header_row = True
    )
    with
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
    )as[result]
go 






