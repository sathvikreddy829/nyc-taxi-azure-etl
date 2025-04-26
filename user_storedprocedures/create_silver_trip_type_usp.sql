use nyc_taxi_ldw
go 

create or alter procedure silver.usp_silver_trip_type
as 
BEGIN
    if object_id('silver.trip_type') is not NULL
     drop external table silver.trip_type; 

    create external table silver.trip_type
        with
          (  data_source = nyc_taxi_src,
             location = 'silver/trip_type',
             file_format = parquet_file_format
            ) 
     AS
     select * 
     from bronze.trip_type;

END;