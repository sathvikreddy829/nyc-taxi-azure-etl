use nyc_taxi_ldw
go

--create external table for rate_code 
if object_id('silver.payment_type') is not NULL
 drop external table silver.payment_type

create external table silver.payment_type
  with(
     data_source = nyc_taxi_src,
     location = 'silver/payment_type',
     file_format = parquet_file_format
  )
AS
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
  );
