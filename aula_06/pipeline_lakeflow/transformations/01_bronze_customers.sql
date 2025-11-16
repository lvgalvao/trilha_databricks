-- Databricks notebook source
-- DBTITLE 1,Bronze: Ingestão de Customers
-- Ingestão de dados de customers para a camada bronze usando DLT
-- Fonte: Volume /Volumes/smart_claims_dev/00_landing/sql_server/customers/
-- Destino: smart_claims_dev.01_bronze.customers
-- 
-- Processa automaticamente todos os arquivos dentro da pasta customers/

CREATE OR REFRESH STREAMING TABLE smart_claims_dev.01_bronze.customers
COMMENT "Tabela bronze com dados brutos de customers"
AS
SELECT *
FROM STREAM read_files(
  '/Volumes/smart_claims_dev/00_landing/sql_server/customers/',
  format => 'csv'
);
