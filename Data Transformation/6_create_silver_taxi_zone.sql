use nyc_taxi_ldw
go 

--create external table taxi_zone using CETAS statment and transforming the data to parquet columnar format 
if object_id('silver.taxi_zone') is not NULL
 drop external table silver.taxi_zone
go 

create external table silver.taxi_zone
  with(
     data_source = nyc_taxi_src,
     location = 'silver/taxi_zone',
     file_format = parquet_file_format
  )
AS
select * from bronze.taxi_zone
go