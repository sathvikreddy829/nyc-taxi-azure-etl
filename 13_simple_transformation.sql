use nyc_taxi_discovery;

--taxi trips fall within each hourly trip duration range (e.g., 0–1 hours, 1–2 hours, etc.)
SELECT
       datediff(minute, lpep_pickup_datetime, lpep_dropoff_datetime) / 60 as from_hour,
       (datediff(minute, lpep_pickup_datetime, lpep_dropoff_datetime) / 60) +1 as to_hour,
       count(1) as number_of_trips
 FROM
    OPENROWSET(
                BULK 'trip_data_green_parquet/year=2020/month=01/',
                data_source = 'nyc_taxi_data_raw',
                FORMAT = 'PARQUET'
              ) AS trip_data
group by datediff(minute, lpep_pickup_datetime, lpep_dropoff_datetime) / 60 ,
(datediff(minute, lpep_pickup_datetime, lpep_dropoff_datetime) / 60) +1
order by from_hour, to_hour;

