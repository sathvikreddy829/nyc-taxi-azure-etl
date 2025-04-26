use nyc_taxi_discovery;

--querying rate code json file (standard json)
select rate_code_id,rate_code
 from openrowset(
    bulk 'rate_code.json',
    data_source = 'nyc_taxi_data_raw',
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

--process multi line file 

select rate_code_id,rate_code
 from openrowset(
    bulk 'rate_code_multi_line.json',
    data_source = 'nyc_taxi_data_raw',
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
