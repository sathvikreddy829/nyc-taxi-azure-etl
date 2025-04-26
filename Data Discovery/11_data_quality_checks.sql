use nyc_taxi_discovery;

---identify any data quality iossues in trip total amount 
SELECT
    min(total_amount) as min_total_amount,
    max(total_amount) as max_total_amount,
    count(1) as total_record_count,
    count(total_amount) as null_excluded_total_record_count
FROM
    OPENROWSET(
        BULK 'trip_data_green_parquet/year=2020/month=01/*.parquet',
        data_source = 'nyc_taxi_data_raw',
        FORMAT = 'PARQUET'
    ) AS trip_data;



SELECT
    payment_type,
    count(1) as total_record_count
FROM
    OPENROWSET(
        BULK 'trip_data_green_parquet/year=2020/month=01/*.parquet',
        data_source = 'nyc_taxi_data_raw',
        FORMAT = 'PARQUET'
    ) AS trip_data
    where total_amount < 0 
group by payment_type;

