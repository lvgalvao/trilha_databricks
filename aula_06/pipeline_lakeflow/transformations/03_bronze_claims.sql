-- Databricks notebook source
-- COMMAND ----------
-- DBTITLE 1,Bronze: Ingestão de Claims
-- Ingestão de dados de claims para a camada bronze usando DLT
-- Processa TODOS os arquivos claims*.csv do volume automaticamente
-- Fonte: Volume /Volumes/${catalog}/00_landing/sql_server/claims*.csv
-- Destino: ${catalog}.${schema_bronze}.claims
-- 
-- IMPORTANTE: O padrão glob claims*.csv processa automaticamente todos os arquivos
-- que correspondem (claims.csv, claims_02.csv, claims_03.csv, etc.)

CREATE OR REFRESH TABLE bronze_claims
COMMENT "Tabela bronze com dados brutos de claims (processa todos os arquivos claims*.csv)"
AS
SELECT *
FROM read_files(
  '/Volumes/${catalog}/00_landing/sql_server/claims*.csv',
  format => 'csv'
);

