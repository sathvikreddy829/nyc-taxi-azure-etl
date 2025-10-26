use nyc_taxi_ldw
go 

create or alter procedure silver.usp_silver_rate_code
as 
BEGIN
    if object_id('silver.rate_code') is not NULL
     drop external table silver.rate_code; 

    create external table silver.rate_code
        with
          (  data_source = nyc_taxi_src,
             location = 'silver/rate_code',
             file_format = parquet_file_format
            ) 
    AS
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
    );

END;