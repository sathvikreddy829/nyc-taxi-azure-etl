use nyc_taxi_ldw
go

--create external table vendor csv using cetas 
if object_id('silver.vendor') is not NULL
 drop external table silver.vendor

create external table silver.vendor
  with(
     data_source = nyc_taxi_src,
     location = 'silver/vendor',
     file_format = parquet_file_format
  )
AS
select * from bronze.vendor
go