-- Databricks notebook source
-- COMMAND ----------
-- DBTITLE 1,Bronze: Ingestão de Policies
-- Ingestão de dados de policies para a camada bronze usando DLT
-- Fonte: Volume /Volumes/${catalog}/00_landing/sql_server/policies.csv
-- Destino: ${catalog}.${schema_bronze}.policies

CREATE OR REFRESH TABLE bronze_policies
COMMENT "Tabela bronze com dados brutos de policies"
AS
SELECT *
FROM read_files(
  '/Volumes/${catalog}/00_landing/sql_server/policies.csv',
  format => 'csv'
);

