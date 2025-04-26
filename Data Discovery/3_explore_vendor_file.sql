use nyc_taxi_discovery;
--querying nyc_taxi_data vendor file
select * 
  from openrowset(
    bulk 'vendor.csv',
    data_source = 'nyc_taxi_data_raw',
    format = 'csv',
    PARSER_VERSION = '2.0',
    HEADER_ROW = true,
    FIELDQUOTE = '"'
  )as vendor;

--querying nyctaxidata vendor unquoted file 
select * 
  from openrowset(
    bulk 'vendor_unquoted.csv',
    data_source = 'nyc_taxi_data_raw',
    format = 'csv',
    PARSER_VERSION = '2.0',
    HEADER_ROW = true,
    ESCAPECHAR = '\\'
  )as vendor_unq;



