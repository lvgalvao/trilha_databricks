-- Databricks notebook source
-- COMMAND ----------
-- DBTITLE 1,Gold: Métricas de Claims
-- Cria view materializada na camada gold com métricas agregadas da tabela claims_enriched
-- Fonte: smart_claims_dev.02_silver.claims_enriched
-- Destino: smart_claims_dev.03_gold.claims_metrics

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
FROM smart_claims_dev.02_silver.claims_enriched;

