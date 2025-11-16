-- Databricks notebook source
-- COMMAND ----------
-- DBTITLE 1,Silver: Deduplicação de Claims
-- Deduplicação de claims da camada bronze para silver
-- Remove duplicatas mantendo apenas o registro mais recente por claim_no
-- Fonte: smart_claims_dev.01_bronze.claims
-- Destino: smart_claims_dev.02_silver.claims_dedup

CREATE OR REFRESH TABLE smart_claims_dev.02_silver.claims_dedup
COMMENT "Tabela silver com claims deduplicados (mantém apenas o registro mais recente por claim_no)"
AS
SELECT *
FROM (
  SELECT 
    *,
    ROW_NUMBER() OVER (
      PARTITION BY claim_no 
      ORDER BY claim_date DESC NULLS LAST
    ) AS rn
  FROM smart_claims_dev.01_bronze.claims
)
WHERE rn = 1;
