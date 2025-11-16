-- Databricks notebook source
-- COMMAND ----------
-- DBTITLE 1,Gold: Métricas de Claims
-- Cria view materializada na camada gold com métricas agregadas da tabela claims_enriched
-- Fonte: claims_enriched (tabela silver do pipeline)
-- Destino: smart_claims_dev.03_gold.claims_metrics
-- 
-- Aggregates the full claims_enriched streaming table with optimizations where applicable
-- NOTA: No DLT, ao referenciar tabelas do mesmo pipeline, use apenas o nome da tabela

CREATE OR REFRESH MATERIALIZED VIEW smart_claims_dev.03_gold.claims_metrics
COMMENT "View materializada gold com métricas agregadas de claims enriquecidos"
AS
SELECT
  COUNT(*) AS total_enriched_records,
  COUNT(DISTINCT claim_no) AS unique_claims,
  COUNT(DISTINCT policy_no) AS unique_policies,
  COUNT(DISTINCT customer_id) AS unique_customers,
  CONCAT('Join concluido. Total de registros enriquecidos: ', COUNT(*)) AS result_message,
  current_timestamp() AS calculated_at
FROM claims_enriched;
