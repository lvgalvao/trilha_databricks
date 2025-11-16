-- Databricks notebook source
-- COMMAND ----------
-- DBTITLE 1,Silver: Deduplicação de Claims
-- Deduplicação de claims da camada bronze para silver
-- Remove duplicatas mantendo apenas o registro mais recente por claim_no
-- Fonte: bronze_claims
-- Destino: ${catalog}.${schema_silver}.claims_dedup

CREATE OR REFRESH TABLE silver_claims_dedup
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
  FROM bronze_claims
)
WHERE rn = 1;

