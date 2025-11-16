-- Databricks notebook source
-- COMMAND ----------
-- DBTITLE 1,Bronze: Ingestão de Customers
-- Ingestão de dados de customers para a camada bronze usando DLT
-- Fonte: Volume /Volumes/smart_claims_dev/00_landing/sql_server/customers.csv
-- Destino: smart_claims_dev.01_bronze.customers
-- 
-- Perform incremental reads with checkpoints

CREATE OR REFRESH STREAMING TABLE smart_claims_dev.01_bronze.customers
COMMENT "Tabela bronze com dados brutos de customers"
AS
SELECT 
  *,
  current_timestamp() AS processing_time,
  _metadata.file_name AS source_file
FROM STREAM read_files(
  '/Volumes/smart_claims_dev/00_landing/sql_server/customers.csv',
  format => 'csv'
);
