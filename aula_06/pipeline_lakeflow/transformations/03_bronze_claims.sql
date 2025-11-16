-- Databricks notebook source
-- COMMAND ----------
-- DBTITLE 1,Bronze: Ingestão de Claims
-- Ingestão de dados de claims para a camada bronze usando DLT
-- Processa TODOS os arquivos claims*.csv do volume automaticamente
-- Fonte: Volume /Volumes/smart_claims_dev/00_landing/sql_server/claims*.csv
-- Destino: smart_claims_dev.01_bronze.claims
-- 
-- IMPORTANTE: O padrão glob claims*.csv processa automaticamente todos os arquivos
-- que correspondem (claims.csv, claims_02.csv, claims_03.csv, etc.)
-- Perform incremental reads with checkpoints

CREATE OR REFRESH STREAMING TABLE smart_claims_dev.01_bronze.claims
COMMENT "Tabela bronze com dados brutos de claims (processa todos os arquivos claims*.csv)"
AS
SELECT 
  *,
  current_timestamp() AS processing_time,
  _metadata.file_name AS source_file
FROM STREAM read_files(
  '/Volumes/smart_claims_dev/00_landing/sql_server/claims*.csv',
  format => 'csv'
);
