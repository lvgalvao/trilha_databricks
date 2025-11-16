-- Databricks notebook source
-- MAGIC %md
-- MAGIC ### Notebook de Exploração - Pipeline Claims
-- MAGIC
-- MAGIC Use este notebook para explorar os dados gerados pelo pipeline DLT.
-- MAGIC
-- MAGIC **Nota**: Este notebook não é executado como parte do pipeline.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Explorar Camada Bronze

-- COMMAND ----------

-- Explorar dados de customers
SELECT * FROM bronze_customers LIMIT 10;

-- COMMAND ----------

-- Explorar dados de policies
SELECT * FROM bronze_policies LIMIT 10;

-- COMMAND ----------

-- Explorar dados de claims
SELECT COUNT(*) AS total_claims FROM bronze_claims;
SELECT * FROM bronze_claims LIMIT 10;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Explorar Camada Silver

-- COMMAND ----------

-- Verificar deduplicação
SELECT 
  (SELECT COUNT(*) FROM bronze_claims) AS total_bronze,
  (SELECT COUNT(*) FROM silver_claims_dedup) AS total_silver,
  (SELECT COUNT(*) FROM bronze_claims) - (SELECT COUNT(*) FROM silver_claims_dedup) AS duplicates_removed;

-- COMMAND ----------

-- Explorar claims enriquecidos
SELECT * FROM silver_claims_enriched LIMIT 10;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Explorar Camada Gold

-- COMMAND ----------

-- Consultar métricas agregadas
SELECT * FROM gold_claims_metrics;
