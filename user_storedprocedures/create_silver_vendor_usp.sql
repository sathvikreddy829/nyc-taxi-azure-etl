use nyc_taxi_ldw
go 

create or alter procedure silver.usp_silver_vendor
as 
BEGIN
    if object_id('silver.vendor') is not NULL
     drop external table silver.vendor; 

    create external table silver.vendor
        with
          (  data_source = nyc_taxi_src,
             location = 'silver/vendor',
             file_format = parquet_file_format
            ) 
     AS
     select * 
     from bronze.vendor;

END;