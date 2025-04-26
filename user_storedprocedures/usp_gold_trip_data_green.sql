use nyc_taxi_ldw
go 

create or alter procedure gold.usp_gold_trip_data_green
@year varchar(4),
@month varchar(2)
AS
BEGIN

    DECLARE @create_sql_stmt NVARCHAR(max),
            @drop_sql_stmt NVARCHAR(max);

    SET @create_sql_stmt = 
            'create external table gold.trip_data_green_' + @year + '_' + @month +'
               with(
                    data_source = nyc_taxi_src,
                    location = ''gold/trip_data_green/year=' + @year + '/month=' + @month +''',
                    file_format = parquet_file_format
                     )
              AS
              select td.year,
                     td.month,
                     convert(DATE, td.lpep_pickup_datetime) as trip_date,
                     tz.borough,
                     cal.day_name as trip_day,
                     case when cal.day_name in (''Saturday'',''Sunday'') then ''Y'' else ''N'' end as trip_day_weekend_ind,
                     sum(case when pt.description = ''Credit card'' then 1 else 0 end) as card_trip_count,
                     sum(case when pt.description = ''Cash'' then 1 else 0 end) as cash_trip_count,
                     sum(case when tt.trip_type_desc = ''Street-hail'' then 1 else 0 end) as street_hail_trip_count,
                     sum(case when tt.trip_type_desc = ''Dispatch'' then 1 else 0 end) as dispatch_trip_count,
                     sum(td.trip_distance) as trip_distance,
                     sum(td.fare_amount) as fare_amount,
                     sum(datediff(minute, td.lpep_pickup_datetime, td.lpep_dropoff_datetime )) as trip_duration
                 from silver.vw_trip_data_green td
                 join silver.taxi_zone tz on (td.pu_location_id = tz.location_id)
                 join silver.calendar cal on (convert(DATE, td.lpep_pickup_datetime) = cal.date)
                 join silver.payment_type pt on (td.payment_type = pt.payment_type)
                 join silver.trip_type tt on (td.trip_type = tt.trip_type)
                 where td.year =''' + @year + '''
                 and td.month =''' + @month +'''
                 group by td.year,
                          td.month,
                          convert(DATE, td.lpep_pickup_datetime),
                          tz.borough,
                          cal.day_name';

    print(@create_sql_stmt)

    EXEC sp_executesql @create_sql_stmt;

    SET @drop_sql_stmt = 
         'drop external table gold.trip_data_green_' + @year + '_' + @month + '';

    print(@drop_sql_stmt)

    EXEC sp_executesql @drop_sql_stmt;

END;