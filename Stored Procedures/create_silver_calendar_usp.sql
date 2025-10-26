use nyc_taxi_ldw
go 

create or alter procedure silver.usp_silver_calendar
as 
BEGIN
    if object_id('silver.calendar') is not NULL
     drop external table silver.calendar; 

    create external table silver.calendar
        with
          (  data_source = nyc_taxi_src,
             location = 'silver/calendar',
             file_format = parquet_file_format
            ) 
     AS
     select * 
     from bronze.calendar;

END;