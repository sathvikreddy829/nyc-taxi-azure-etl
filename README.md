# NyctaxiData-Project
![image alt](https://github.com/sathvikreddy829/NyctaxiData-Project/blob/625365e5d44db19b1c00ebc323ea75a12cb0f49c/Screenshot%202025-04-26%20201608.png)

NYC Taxi Trips Data Analysis with Azure Synapse

This project demonstrates an end-to-end pipeline for ingesting, transforming, and analyzing NYC Taxi Trips data using Azure Synapse Analytics (Serverless SQL Pools) and Azure Data Lake Storage Gen2, leveraging a Lakehouse architecture (Bronze, Silver, Gold layers).

Project Overview

The main goal of this project is to efficiently explore and analyze NYC Taxi Trips data using Serverless SQL Pools — without provisioning dedicated compute resources.
By optimizing query patterns, managing data quality, and adhering to best practices for performance and GDPR compliance, this project sets up a scalable analytical environment.

The dataset includes various formats:
CSV
Standard JSON
Multi-line JSON

Key Steps & Implementation🔍
Data Exploration & Discovery
Query Optimization Techniques:

Specified datatypes with sizes using the WITH clause to minimize scanned data volume.
Queried only a subset of required columns to improve performance.
Applied filters on large datasets to limit processing to relevant records.
Used field terminators and row terminators to correctly interpret CSV structures following RFC 4180 standards

Data Quality Checks:

Identified and removed duplicates in key columns.
Handled missing values (nulls) appropriately.
Addressed data mismatches discovered after ingestion.
Removed personal information (PII) to ensure GDPR compliance.

Performance Optimization:

Limited columns retrieved during queries.
Applied partition pruning where possible.
Used dynamic SQL (sp_executesql) and sp_describe_first_result_set to manage metadata effectively.

🏗️ Data Lakehouse Architecture
Following a Medallion Architecture approach:

Bronze Layer (Raw Data)
Ingested raw files into external tables using CREATE EXTERNAL TABLE with customized EXTERNAL FILE FORMAT, DATA SOURCE, and OPENROWSET.
Examples: Handling CSV and JSON using correct field/row terminators like '0x0a' for line feeds and '0x0b' for vertical tabs in JSON.

Silver Layer (Curated Data)
Transformed raw data into Parquet format for optimized querying.
Partitioned datasets based on year and month using file path functions like filepath() to enable partition pruning.
Created external tables and views exposing cleaned, validated data.

Gold Layer (Aggregated Data)

Built summarizations and aggregations ready for business intelligence (BI) consumption.
Dynamic SQL procedures were used to:
Create external tables per partition.
Generate analytical views dynamically.

CSV & JSON Parsing
Used standard-compliant parsing rules to handle real-world messy data.
Ensured quotes and special characters (like \n, \t, \\) were handled correctly.
Read JSON documents via WITH (jsonDoc NVARCHAR(MAX)) and parsed nested objects using OPENJSON, JSON_VALUE, and JSON_QUERY.

Data Types & Optimization

Chose appropriate types like TINYINT, SMALLINT, INT, BIGINT based on expected data ranges to balance performance and storage.
Used DATETIME2(7) for precise timestamps.

Join Strategies

Efficient use of INNER JOIN, LEFT JOIN, FULL JOIN depending on the use case.
Managed aliasing and column order carefully to comply with SQL Server behavior.

Dynamic & Parameterized SQL

Utilized variables (DECLARE) and dynamic SQL (sp_executesql) for flexibility.
Explained limitations on direct parameter usage in pure SQL (compared to environments like Databricks).

Tools & Technologies
Azure Synapse Analytics (Serverless SQL Pool)
Azure Data Lake Storage Gen2
T-SQL / SQL Scripts
Parquet File Format
Lakehouse Architecture (Bronze, Silver, Gold)

Conclusion
This project showcases how Serverless SQL Pools can power cost-effective, scalable, and GDPR-compliant big data analytics in Azure — using well-architected pipelines and optimizing every stage from raw ingestion to curated reporting layers.

✅ After implementing all these best practices and optimizations, I have successfully built an end-to-end, robust data pipeline — capable of handling real-world messy datasets, ensuring data quality, optimizing performance, and enabling efficient downstream analytics in a fully serverless environment.










