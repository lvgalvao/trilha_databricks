-- Databricks notebook source
-- COMMAND ----------
-- DBTITLE 1,Silver: Deduplicação de Claims
-- Deduplicação de claims da camada bronze para silver
-- Remove duplicatas mantendo apenas o registro mais recente por claim_no
-- Fonte: claims (tabela bronze do pipeline)
-- Destino: smart_claims_dev.02_silver.claims_dedup
-- 
-- References the streaming claims bronze table for incrementally processing
-- NOTA: No DLT, ao referenciar tabelas do mesmo pipeline, use apenas o nome da tabela
-- NOTA: Para streaming deduplication, usamos QUALIFY ao invés de subquery com WHERE

CREATE OR REFRESH STREAMING TABLE smart_claims_dev.02_silver.claims_dedup
COMMENT "Tabela silver com claims deduplicados (mantém apenas o registro mais recente por claim_no)"
AS
SELECT *
FROM STREAM claims
QUALIFY ROW_NUMBER() OVER (
  PARTITION BY claim_no 
  ORDER BY claim_date DESC NULLS LAST
) = 1;
