use nyc_taxi_ldw;
--file format csv with parser version 2.0
if not exists (select * from sys.external_file_formats where name = 'csv_file_format')
 create external file format csv_file_format
  with(
    format_type = DELIMITEDTEXT,
    FORMAT_OPTIONS (
        FIELD_TERMINATOR = ',',
        STRING_DELIMITER = '"',
        PARSER_VERSION = '2.0',
        FIRST_ROW = 2 ,
        USE_TYPE_DEFAULT = FALSE,
        ENCODING = 'UTF8' )
  );

--file format for csv with parser version 1.0 
if not exists (select * from sys.external_file_formats where name = 'csv_file_format_pv1')

  create external file format csv_file_format_pv1
   with(
     format_type = DELIMITEDTEXT,
     FORMAT_OPTIONS (
        FIELD_TERMINATOR = ',',
        STRING_DELIMITER = '"',
        PARSER_VERSION = '1.0',
        FIRST_ROW = 2 ,
        USE_TYPE_DEFAULT = FALSE,
        ENCODING = 'UTF8' )
    );

--file format for tsv file 

if not exists (select * from sys.external_file_formats where name = 'tsv_file_format')

   create external file FORMAT tsv_file_format
      with(
        format_type = DELIMITEDTEXT,
        FORMAT_OPTIONS(
          FIELD_TERMINATOR = '\t',
          STRING_DELIMITER = '"',
          FIRST_ROW = 2,
          PARSER_VERSION = '1.0',
          encoding = 'UTF8',
          use_type_default = FALSE
        )
      )


--Create an external file format for PARQUET files.
if not exists (select * from sys.external_file_formats where name = 'parquet_file_format')
  CREATE EXTERNAL FILE FORMAT parquet_file_format
    WITH (
         FORMAT_TYPE = PARQUET,
         DATA_COMPRESSION ='org.apache.hadoop.io.compress.SnappyCodec'
      );



--Create an external file format for delta files.
if not exists (select * from sys.external_file_formats where name = 'delta_file_format')
  CREATE EXTERNAL FILE FORMAT delta_file_format
    WITH (
         FORMAT_TYPE = DELTA,
         DATA_COMPRESSION ='org.apache.hadoop.io.compress.SnappyCodec'
      );


   

