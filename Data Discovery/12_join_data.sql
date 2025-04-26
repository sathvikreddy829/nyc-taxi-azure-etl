use nyc_taxi_discovery;

--check PULocationID key is null before joining 
SELECT
   top 100 *
 FROM
    OPENROWSET(
                BULK 'trip_data_green_parquet/year=2020/month=01/',
                data_source = 'nyc_taxi_data_raw',
                FORMAT = 'PARQUET'
              ) AS trip_data
 where PULocationID is NULL;

---identify number of trips made from each borough
SELECT
   taxi_zone.borough,
   count(1) as record_count
 FROM
    OPENROWSET(
                BULK 'trip_data_green_parquet/year=2020/month=01/',
                data_source = 'nyc_taxi_data_raw',
                FORMAT = 'PARQUET'
              ) AS trip_data
    join  
    OPENROWSET(
        BULK 'https://nyctaxidatalake123.dfs.core.windows.net/nyctaxidata/raw/taxi_zone.csv',
        FORMAT = 'CSV',
        PARSER_VERSION = '2.0',
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n'
    )WITH(
        location_id  SMALLINT 1,
        borough VARCHAR(15) 2,
        zone VARCHAR(50) 3,
        service_zone VARCHAR(50) 4
    )as taxi_zone
    on trip_data.PULocationID = taxi_zone.location_id
group by taxi_zone.borough
order by record_count;

    