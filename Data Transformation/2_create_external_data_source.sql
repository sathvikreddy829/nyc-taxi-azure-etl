use nyc_taxi_ldw;

if not exists (select * from sys.external_data_sources where name = 'nyc_taxi_src')


create external data source nyc_taxi_src
with(
    LOCATION = 'abfss://nyctaxidata@nyctaxidatalake123.dfs.core.windows.net/'
    )



  