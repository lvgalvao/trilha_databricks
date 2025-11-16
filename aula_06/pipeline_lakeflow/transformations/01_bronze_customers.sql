-- Databricks notebook source
-- COMMAND ----------
-- DBTITLE 1,Bronze: Ingestão de Customers
-- Ingestão de dados de customers para a camada bronze usando DLT
-- Fonte: Volume /Volumes/${catalog}/00_landing/sql_server/customers.csv
-- Destino: ${catalog}.${schema_bronze}.customers

CREATE OR REFRESH TABLE bronze_customers
COMMENT "Tabela bronze com dados brutos de customers"
AS
SELECT *
FROM read_files(
  '/Volumes/${catalog}/00_landing/sql_server/customers.csv',
  format => 'csv'
);

