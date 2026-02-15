-- =============================================================
-- Northwind Traders — Criação de Tabelas
-- Aula 08 · Trilha Databricks · Jornada de Dados
-- =============================================================

-- COMMAND ----------

CREATE CATALOG IF NOT EXISTS northwind;

-- COMMAND ----------

CREATE SCHEMA IF NOT EXISTS northwind.bronze
COMMENT 'Northwind Traders — Dataset para Aula 08 (PySpark DataFrame API)';

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS northwind.bronze.categories (
    category_id SMALLINT NOT NULL,
    category_name STRING NOT NULL,
    description STRING,
    picture STRING
);

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS northwind.bronze.customer_customer_demo (
    customer_id STRING NOT NULL,
    customer_type_id STRING NOT NULL
);

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS northwind.bronze.customer_demographics (
    customer_type_id STRING NOT NULL,
    customer_desc STRING
);

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS northwind.bronze.customers (
    customer_id STRING NOT NULL,
    company_name STRING NOT NULL,
    contact_name STRING,
    contact_title STRING,
    address STRING,
    city STRING,
    region STRING,
    postal_code STRING,
    country STRING,
    phone STRING,
    fax STRING
);

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS northwind.bronze.employees (
    employee_id SMALLINT NOT NULL,
    last_name STRING NOT NULL,
    first_name STRING NOT NULL,
    title STRING,
    title_of_courtesy STRING,
    birth_date DATE,
    hire_date DATE,
    address STRING,
    city STRING,
    region STRING,
    postal_code STRING,
    country STRING,
    home_phone STRING,
    extension STRING,
    photo STRING,
    notes STRING,
    reports_to SMALLINT,
    photo_path STRING
);

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS northwind.bronze.employee_territories (
    employee_id SMALLINT NOT NULL,
    territory_id STRING NOT NULL
);

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS northwind.bronze.order_details (
    order_id SMALLINT NOT NULL,
    product_id SMALLINT NOT NULL,
    unit_price FLOAT NOT NULL,
    quantity SMALLINT NOT NULL,
    discount FLOAT NOT NULL
);

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS northwind.bronze.orders (
    order_id SMALLINT NOT NULL,
    customer_id STRING,
    employee_id SMALLINT,
    order_date DATE,
    required_date DATE,
    shipped_date DATE,
    ship_via SMALLINT,
    freight FLOAT,
    ship_name STRING,
    ship_address STRING,
    ship_city STRING,
    ship_region STRING,
    ship_postal_code STRING,
    ship_country STRING
);

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS northwind.bronze.products (
    product_id SMALLINT NOT NULL,
    product_name STRING NOT NULL,
    supplier_id SMALLINT,
    category_id SMALLINT,
    quantity_per_unit STRING,
    unit_price FLOAT,
    units_in_stock SMALLINT,
    units_on_order SMALLINT,
    reorder_level SMALLINT,
    discontinued INT NOT NULL
);

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS northwind.bronze.region (
    region_id SMALLINT NOT NULL,
    region_description STRING NOT NULL
);

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS northwind.bronze.shippers (
    shipper_id SMALLINT NOT NULL,
    company_name STRING NOT NULL,
    phone STRING
);

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS northwind.bronze.suppliers (
    supplier_id SMALLINT NOT NULL,
    company_name STRING NOT NULL,
    contact_name STRING,
    contact_title STRING,
    address STRING,
    city STRING,
    region STRING,
    postal_code STRING,
    country STRING,
    phone STRING,
    fax STRING,
    homepage STRING
);

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS northwind.bronze.territories (
    territory_id STRING NOT NULL,
    territory_description STRING NOT NULL,
    region_id SMALLINT NOT NULL
);

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS northwind.bronze.us_states (
    state_id SMALLINT NOT NULL,
    state_name STRING,
    state_abbr STRING,
    state_region STRING
);
