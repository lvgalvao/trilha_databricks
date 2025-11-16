-- Databricks notebook source
-- MAGIC %md
-- MAGIC ### Notebook de Exploração - Pipeline Claims
-- MAGIC
-- MAGIC Use este notebook para explorar os dados gerados pelo pipeline DLT.
-- MAGIC
-- MAGIC **Nota**: Este notebook não é executado como parte do pipeline.
-- MAGIC
-- MAGIC **Importante**: Substitua `${catalog}` pelo nome do seu catálogo (ex: `smart_claims_dev`)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Explorar Camada Bronze (01_bronze)

-- COMMAND ----------

-- Explorar dados de customers
SELECT * FROM ${catalog}.01_bronze.customers LIMIT 10;

-- COMMAND ----------

-- Explorar dados de policies
SELECT * FROM ${catalog}.01_bronze.policies LIMIT 10;

-- COMMAND ----------

-- Explorar dados de claims
SELECT COUNT(*) AS total_claims FROM ${catalog}.01_bronze.claims;
SELECT * FROM ${catalog}.01_bronze.claims LIMIT 10;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Explorar Camada Silver (02_silver)

-- COMMAND ----------

-- Verificar deduplicação
SELECT 
  (SELECT COUNT(*) FROM ${catalog}.01_bronze.claims) AS total_bronze,
  (SELECT COUNT(*) FROM ${catalog}.02_silver.claims_dedup) AS total_silver,
  (SELECT COUNT(*) FROM ${catalog}.01_bronze.claims) - (SELECT COUNT(*) FROM ${catalog}.02_silver.claims_dedup) AS duplicates_removed;

-- COMMAND ----------

-- Explorar claims enriquecidos
SELECT * FROM ${catalog}.02_silver.claims_enriched LIMIT 10;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Explorar Camada Gold (03_gold)

-- COMMAND ----------

-- Consultar métricas agregadas
SELECT * FROM ${catalog}.03_gold.claims_metrics;
