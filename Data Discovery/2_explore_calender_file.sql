use nyc_taxi_discovery;

--checking the datatypes of columns
exec sp_describe_first_result_set N'select *
   from openrowset(
     bulk ''calendar.csv'',
     data_source = ''nyc_taxi_data_raw'',
     format = ''csv'',
     HEADER_ROW = true,
     parser_version = ''2.0''
    )as cal
'
--querying nyctaxidata calender file 
select *
   from openrowset(
     bulk 'calendar.csv',
     data_source = 'nyc_taxi_data_raw',
     format = 'csv',
     HEADER_ROW = true,
     parser_version = '2.0'
 )
 with(
     date_key INT,
     date  date,
     year  smallint,
     month  tinyint,
     day tinyint,
     day_name varchar(10),
     day_of_year smallint,
     week_of_month tinyint,
     week_of_year tinyint,
     month_name varchar(10),
     year_month int,
     year_week int
    )as cal; 