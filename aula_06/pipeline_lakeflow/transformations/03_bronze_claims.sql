-- Databricks notebook source
-- DBTITLE 1,Bronze: Ingestão de Claims
-- Ingestão de dados de claims para a camada bronze usando DLT
-- Fonte: Volume /Volumes/smart_claims_dev/00_landing/sql_server/claims/
-- Destino: smart_claims_dev.01_bronze.claims
-- 
-- Processa automaticamente todos os arquivos dentro da pasta claims/
-- Isso inclui: claims.csv, claims_02.csv, claims_03.csv, etc.

CREATE OR REFRESH STREAMING TABLE smart_claims_dev.01_bronze.claims
COMMENT "Tabela bronze com dados brutos de claims (processa todos os arquivos da pasta claims/)"
AS
SELECT *
FROM STREAM read_files(
  '/Volumes/smart_claims_dev/00_landing/sql_server/claims/',
  format => 'csv'
);
