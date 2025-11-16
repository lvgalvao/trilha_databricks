-- Databricks notebook source
-- MAGIC %md
-- MAGIC ### Notebook de Exploração - Pipeline Claims
-- MAGIC
-- MAGIC Use este notebook para explorar os dados gerados pelo pipeline DLT.
-- MAGIC
-- MAGIC **Nota**: Este notebook não é executado como parte do pipeline.
-- MAGIC
-- MAGIC **Catálogo**: smart_claims_dev

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Explorar Camada Bronze (01_bronze)

-- COMMAND ----------

-- Explorar dados de customers
SELECT * FROM smart_claims_dev.01_bronze.customers LIMIT 10;

-- COMMAND ----------

-- Explorar dados de policies
SELECT * FROM smart_claims_dev.01_bronze.policies LIMIT 10;

-- COMMAND ----------

-- Explorar dados de claims
SELECT COUNT(*) AS total_claims FROM smart_claims_dev.01_bronze.claims;
SELECT * FROM smart_claims_dev.01_bronze.claims LIMIT 10;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Explorar Camada Silver (02_silver)

-- COMMAND ----------

-- Explorar claims enriquecidos
SELECT * FROM smart_claims_dev.02_silver.claims_enriched LIMIT 10;

-- COMMAND ----------

-- Verificar total de registros enriquecidos
SELECT COUNT(*) AS total_enriched FROM smart_claims_dev.02_silver.claims_enriched;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ### Explorar Camada Gold (03_gold)

-- COMMAND ----------

-- Consultar métricas agregadas
SELECT * FROM smart_claims_dev.03_gold.claims_metrics;
