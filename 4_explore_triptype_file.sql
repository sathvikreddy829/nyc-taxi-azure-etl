use nyc_taxi_discovery;

--quering tab seperated file 
select * 
  from openrowset(
    bulk 'trip_type.tsv',
    data_source = 'nyc_taxi_data_raw',
    format = 'csv',
    parser_version = '2.0',
    header_row = true,
    fieldterminator = '\t'
  )as trip_type;