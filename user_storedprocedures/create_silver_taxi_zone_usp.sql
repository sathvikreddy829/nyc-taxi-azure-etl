use nyc_taxi_ldw
go 

create or alter procedure silver.usp_silver_taxi_zone
as 
BEGIN
    if object_id('silver.taxi_zone') is not NULL
     drop external table silver.taxi_zone; 

    create external table silver.taxi_zone
        with
          (  data_source = nyc_taxi_src,
             location = 'silver/taxi_zone',
             file_format = parquet_file_format
            ) 
     AS
     select * 
     from bronze.taxi_zone;

END;