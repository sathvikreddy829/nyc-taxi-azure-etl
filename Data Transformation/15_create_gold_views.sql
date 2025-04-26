use nyc_taxi_ldw
go 

drop view if exists gold.vw_trip_data_green
go 

create view gold.vw_trip_data_green
as 
select result.filepath(1) as year,
       result.filepath(2) as month,
       result.*
    from 
       OPENROWSET(
            bulk 'gold/trip_data_green/year=*/month=*/*.parquet',
            data_source = 'nyc_taxi_src',
            format = 'PARQUET'
         )
         with
         ( 
             borough varchar(15),
             trip_date date,
             trip_day varchar(10),
             trip_day_weekend_ind char(1),
             card_trip_count int,
             cash_trip_count int,
             street_hail_trip_count int,
             dispatch_trip_count int,
             trip_distance float,
             fare_amount float,
             trip_duration int  
         ) as [result]
go         