use nyc_taxi_discovery;

--Exploring single line json doc--
select cast(json_value(jsonDoc, '$.payment_type') as smallint) payment_type,
       cast(json_value(jsonDoc, '$.payment_type_desc') as varchar(15)) payment_type_desc
  from openrowset(
     bulk 'payment_type.json',
     data_source = 'nyc_taxi_data_raw',
     format = 'CSV',
     fieldterminator = '0x0b',
     fieldquote = '0x0b',
     rowterminator = '0x0a'
  )
  with(
    jsonDoc NVARCHAR(MAX)
  )as Payment_type;


exec sp_describe_first_result_set N'
select cast(json_value(jsonDoc, ''$.payment_type'') as smallint) payment_type,
       cast(json_value(jsonDoc, ''$.payment_type_desc'') as varchar(15)) payment_type_desc
  from openrowset(
     bulk ''payment_type.json'',
     data_source = ''nyc_taxi_data_raw'',
     format = ''CSV'',
     fieldterminator = ''0x0b'',
     fieldquote = ''0x0b'',
     rowterminator = ''0x0a''
  )
  with(
    jsonDoc NVARCHAR(MAX)
  )as Payment_type;'


select payment_type,description
  from openrowset(
     bulk 'payment_type.json',
     data_source = 'nyc_taxi_data_raw',
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

-- reading json array file--
select payment_type,payment_type_desc_value
  from openrowset(
     bulk 'payment_type_array.json',
     data_source = 'nyc_taxi_data_raw',
     format = 'CSV',
     fieldterminator = '0x0b',
     fieldquote = '0x0b',
     rowterminator = '0x0a'
  )
  with(
    jsonDoc NVARCHAR(MAX)
  )as Payment_type_array
  cross apply openjson(jsonDoc)
  with(
    payment_type smallint,
    payment_type_desc NVARCHAR(max) as JSON
  )
  cross apply openjson(payment_type_desc)
  with(
    sub_type smallint,
    payment_type_desc_value varchar(20) '$.value'
  );






















