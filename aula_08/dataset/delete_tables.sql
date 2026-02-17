-- ============================================================
-- delete_tables.sql
-- Reseta todo o projeto da Aula 08, removendo tabelas, volumes,
-- schemas e o catalogo Northwind.
--
-- Ordem de execucao: tabelas -> volumes -> schemas -> catalogo
-- (de dentro para fora, respeitando dependencias)
-- ============================================================

-- ============================================================
-- 1. GOLD LAYER — Tabelas analiticas (bloco_05)
-- ============================================================
DROP TABLE IF EXISTS northwind.northwind_gold.receita_mensal_ytd;
DROP TABLE IF EXISTS northwind.northwind_gold.top_10_produtos;
DROP TABLE IF EXISTS northwind.northwind_gold.segmentacao_clientes;
DROP TABLE IF EXISTS northwind.northwind_gold.clientes_uk_1000;
DROP TABLE IF EXISTS northwind.northwind_gold.receita_categoria_ano;

-- ============================================================
-- 2. BRONZE LAYER — Tabelas do dataset Northwind
-- ============================================================
-- Tabelas com FK primeiro (dependem das outras)
DROP TABLE IF EXISTS northwind.bronze.order_details;
DROP TABLE IF EXISTS northwind.bronze.orders;
DROP TABLE IF EXISTS northwind.bronze.products;
DROP TABLE IF EXISTS northwind.bronze.employee_territories;
DROP TABLE IF EXISTS northwind.bronze.customer_customer_demo;

-- Tabelas de referencia
DROP TABLE IF EXISTS northwind.bronze.customers;
DROP TABLE IF EXISTS northwind.bronze.employees;
DROP TABLE IF EXISTS northwind.bronze.categories;
DROP TABLE IF EXISTS northwind.bronze.suppliers;
DROP TABLE IF EXISTS northwind.bronze.shippers;
DROP TABLE IF EXISTS northwind.bronze.territories;
DROP TABLE IF EXISTS northwind.bronze.region;
DROP TABLE IF EXISTS northwind.bronze.customer_demographics;
DROP TABLE IF EXISTS northwind.bronze.us_states;

-- Tabela demo criada no bloco_05
DROP TABLE IF EXISTS northwind.bronze.demo_delta;

-- ============================================================
-- 3. VOLUMES — Arquivos de demonstracao (bloco_01 e bloco_05)
-- ============================================================
DROP VOLUME IF EXISTS northwind.bronze.demo_files;

-- ============================================================
-- 4. SCHEMAS
-- ============================================================
DROP SCHEMA IF EXISTS northwind.northwind_gold;
DROP SCHEMA IF EXISTS northwind.bronze;

-- ============================================================
-- 5. CATALOGO
-- ============================================================
DROP CATALOG IF EXISTS northwind;
