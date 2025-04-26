use nyc_taxi_discovery;

-- This is auto-generated code
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://nyctaxidatalake123.dfs.core.windows.net/nyctaxidata/raw/trip_data_green_csv/year=2020/month=01/green_tripdata_2020-01.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        header_row = True
    ) AS [result]
    
--select data from a folder 
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'trip_data_green_csv/year=2020/month=01/*.csv',
        data_source = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        header_row = True
    ) AS [result]

--select data from subfolders
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'trip_data_green_csv/year=2020/**',
        data_source = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        header_row = True
    ) AS [result]

--get data from more than one file 
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK ('trip_data_green_csv/year=2020/month=01/*.csv',
        'trip_data_green_csv/year=2020/month=03/*.csv'),
        data_source = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        header_row = True
    ) AS [result]

--use more than one wild card character 
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'trip_data_green_csv/year=*/month=*/*.csv',
        data_source = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        header_row = True
    ) AS [result]
    
--file metadata function filename()
SELECT
    result.filename() as file_name,
    count(1) as record_count
FROM
    OPENROWSET(
        BULK 'trip_data_green_csv/year=*/month=*/*.csv',
        data_source = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        header_row = True
    ) AS [result]
group by result.filename()
order by result.filename();

--limit data using filename()--
SELECT
    result.filename() as file_name,
    count(1) as record_count
FROM
    OPENROWSET(
        BULK 'trip_data_green_csv/year=*/month=*/*.csv',
        data_source = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        header_row = True
    ) AS [result]
where result.filename() in ('green_tripdata_2020-01.csv','green_tripdata_2021-01.csv')
group by result.filename()
order by result.filename();

--using filepath function
SELECT
    result.filename() as file_name,
    result.filepath(1) as year,
    result.filepath(2) as month,
    count(1) as record_count
FROM
    OPENROWSET(
        BULK 'trip_data_green_csv/year=*/month=*/*.csv',
        data_source = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        header_row = True
    ) AS [result]
where result.filename() in ('green_tripdata_2020-01.csv','green_tripdata_2021-01.csv')
group by result.filename(), result.filepath(1), result.filepath(2)
order by result.filename(), result.filepath(1), result.filepath(2);

--total record count of trip data green csv
SELECT
    result.filepath(1) as year,
    result.filepath(2) as month,
    count(1) as record_count
FROM
    OPENROWSET(
        BULK 'trip_data_green_csv/year=*/month=*/*.csv',
        data_source = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        header_row = True
    ) AS [result]
group by result.filepath(1), result.filepath(2)
order by result.filepath(1), result.filepath(2);

--using where clause in filepath function 
SELECT
    result.filepath(1) as year,
    result.filepath(2) as month,
    count(1) as record_count
FROM
    OPENROWSET(
        BULK 'trip_data_green_csv/year=*/month=*/*.csv',
        data_source = 'nyc_taxi_data_raw',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        header_row = True
    ) AS [result]
where result.filepath(1) = '2020'
  and result.filepath(2) in ('06','07','08')
group by result.filepath(1), result.filepath(2)
order by result.filepath(1), result.filepath(2);
































