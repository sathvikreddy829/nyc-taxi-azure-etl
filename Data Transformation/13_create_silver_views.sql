use nyc_taxi_ldw
go 

drop view if exists silver.vw_trip_data_green
go

create view silver.vw_trip_data_green
as 
select 
     result.filepath(1) as year,
     result.filepath(2) as month,
     result.*
  from openrowset(
       bulk 'silver/trip_data_green/year=*/month=*/*.parquet',
       data_source = 'nyc_taxi_src',
       FORMAT = 'PARQUET'
     )
     WITH(      vendor_id INT,
                lpep_pickup_datetime datetime2(7) ,
                lpep_dropoff_datetime datetime2(7),
                store_and_fwd_flag char(1),
                rate_code_id int,
                pu_location_id int,
                do_location_id int,
                passenger_count int,
                trip_distance float,
                fare_amount float,
                extra float,
                mta_tax float,
                tip_amount float,
                tolls_amount float ,
                ehail_fee int ,
                improvement_surcharge float ,
                total_amount float,
                payment_type int,
                trip_type int ,
                congestion_surcharge float
     )as [result]
go


select top 100 * from silver.vw_trip_data_green