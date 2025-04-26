use nyc_taxi_discovery;

--altering database to utf 8 collation
alter DATABASE nyc_taxi_discovery collate Latin1_General_100_CI_AI_SC_UTF8;

-- This is auto-generated code(fix column names)
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'https://nyctaxidatalake123.dfs.core.windows.net/nyctaxidata/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n'
    )
    WITH(
        location_id  SMALLINT 1,
        borough VARCHAR(15) 2,
        zone VARCHAR(50) 3,
        service_zone VARCHAR(50) 4
    ) AS [result]

--retriving csv taxi zone file without header
SELECT
    TOP 100 *
FROM
    OPENROWSET(
        BULK 'abfss://nyctaxidata@nyctaxidatalake123.dfs.core.windows.net/raw/taxi_zone_without_header.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        HEADER_ROW = FALSE,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n'
    )
    WITH(
        location_id  SMALLINT 1,
        borough VARCHAR(15) 2,
        zone VARCHAR(50) 3,
        service_zone VARCHAR(50) 4
    ) AS [result]

--Create external data source for raw container
CREATE EXTERNAL DATA SOURCE nyc_taxi_data_raw
with(
    Location = 'abfss://nyctaxidata@nyctaxidatalake123.dfs.core.windows.net/raw/'
)






