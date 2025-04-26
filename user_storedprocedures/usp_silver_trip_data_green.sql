use nyc_taxi_ldw
go 

create or alter procedure silver.usp_silver_trip_data_green
@year varchar(4),
@month varchar(2)
AS
BEGIN

    DECLARE @create_sql_stmt NVARCHAR(max),
            @drop_sql_stmt NVARCHAR(max);

    SET @create_sql_stmt = 
            'create external table silver.trip_data_green_' + @year + '_' + @month + '
               with(
                    data_source = nyc_taxi_src,
                    location = ''silver/trip_data_green/year=' + @year + '/month=' + @month + ''',
                    file_format = parquet_file_format
                     )
              AS
            select [VendorID] as vendor_id,
                [lpep_pickup_datetime] ,
                [lpep_dropoff_datetime],
                [store_and_fwd_flag],
                [passenger_count] ,
                [trip_distance] ,
                [fare_amount],
                [extra] ,
                [mta_tax],
                [tip_amount] ,
                [tolls_amount] ,
                [ehail_fee] ,
                [improvement_surcharge] ,
                [total_amount] ,
                [payment_type] ,
                [trip_type] ,
                [congestion_surcharge],
                [RatecodeID] as rate_code_id ,
                [PULocationID] as pu_location_id,
                [DOLocationID] as do_location_id 
             from bronze.vw_trip_data_green_csv
             where year = ''' + @year + '''
               and month = ''' + @month + '''';

    print(@create_sql_stmt)

    EXEC sp_executesql @create_sql_stmt;

    SET @drop_sql_stmt = 
         'drop external table silver.trip_data_green_' + @year + '_' + @month + '';

    print(@drop_sql_stmt)

    EXEC sp_executesql @drop_sql_stmt;

END;