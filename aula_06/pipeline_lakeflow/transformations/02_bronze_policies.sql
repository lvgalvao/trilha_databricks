-- Databricks notebook source
-- COMMAND ----------
-- DBTITLE 1,Bronze: Ingestão de Policies
-- Ingestão de dados de policies para a camada bronze usando DLT
-- Fonte: Volume /Volumes/smart_claims_dev/00_landing/sql_server/policies.csv
-- Destino: smart_claims_dev.01_bronze.policies
-- 
-- Perform incremental reads with checkpoints

CREATE OR REFRESH STREAMING TABLE smart_claims_dev.01_bronze.policies
COMMENT "Tabela bronze com dados brutos de policies"
AS
SELECT 
  *,
  current_timestamp() AS processing_time,
  _metadata.file_name AS source_file
FROM STREAM read_files(
  '/Volumes/smart_claims_dev/00_landing/sql_server/policies.csv',
  format => 'csv'
);
