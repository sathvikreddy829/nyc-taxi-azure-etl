use master
go 

create database nyc_taxi_ldw
go

alter database nyc_taxi_ldw collate Latin1_General_100_BIN2_UTF8    
go

use nyc_taxi_ldw
go

create schema bronze
go

create schema silver 
go

create schema gold
go