use nyc_taxi_discovery;

--check for the duplicates in the taxi zone file 
SELECT
     location_id,
     count(1) as record_count
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
    group by location_id
    having count(1) > 1;

    
