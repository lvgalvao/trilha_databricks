-- Databricks notebook source
-- COMMAND ----------
-- DBTITLE 1,Bronze: Ingestão de Policies
-- Ingestão de dados de policies para a camada bronze usando DLT
-- Fonte: Volume /Volumes/smart_claims_dev/00_landing/sql_server/policies/
-- Destino: smart_claims_dev.01_bronze.policies
-- 
-- Processa automaticamente todos os arquivos dentro da pasta policies/

CREATE OR REFRESH TABLE smart_claims_dev.01_bronze.policies
COMMENT "Tabela bronze com dados brutos de policies"
AS
SELECT *
FROM read_files(
  '/Volumes/smart_claims_dev/00_landing/sql_server/policies/',
  format => 'csv'
);
