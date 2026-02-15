# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is the **Trilha de Databricks** (Databricks Learning Path) from Jornada de Dados — an educational repository with practical materials, notebooks, SQL scripts, and Python code for learning Databricks and data engineering. All content is in **Brazilian Portuguese**.

## Repository Structure

Each `aula_XX/` directory is a self-contained lesson following a progressive curriculum:

- `aula_01` - Databricks setup
- `aula_03` - Unity Catalog (governance)
- `aula_04` - Data ingestion + Lakeflow Connect + Auto Loader
- `aula_05` - Lakeflow Jobs (orchestration)
- `aula_06` - Spark Declarative Pipelines (DLT)
- `aula_07` - PySpark DataFrame API
- `aula_08` - PySpark DataFrame API with Northwind dataset (5 notebooks, PRD at `.llm/prd.md`)
- `jdsummit/` - Jornada de Dados Summit materials
- `workshop_modelagem_dados/` - Complete data warehouse implementation (SCD2, dimensional modeling)
- `utils/datasets/` - Synthetic data generators (e.g., `gerador_aula_01.py` using Faker)

Each aula typically contains: `notebooks/`, `data/` (sample CSVs), SQL/Python scripts, and a `README.md`.

## Architecture Pattern

The entire curriculum teaches and applies the **Medallion architecture**:

- **Bronze** — Raw data ingestion (CSV/streaming into Delta tables)
- **Silver** — Cleaned, deduplicated, joined data
- **Gold** — Business-ready aggregations, dimensional models, analytical views

Data flows follow: `source_to_bronze/` → `bronze_to_silver/` → `silver_to_gold/` (see `aula_05` for the clearest example).

## Key Technical Details

- **Languages:** SQL (primary for Databricks notebooks), Python (PySpark), YAML (job definitions)
- **Platform:** Databricks (Unity Catalog, Lakeflow, Delta Live Tables, Workflows)
- **No build system:** This is a content repo — no Makefile, pyproject.toml, or requirements.txt. Dependencies are installed inline in notebooks via `%pip install`
- **Dataset used across aulas 04-07:** Insurance claims data (`customers.csv`, `policies.csv`, `claims.csv`)
- **Workshop dataset:** E-commerce (orders, products, customers)
- **Aula 08 dataset:** Northwind (classic SQL Server sample)

## Conventions

- Notebooks are `.ipynb` (Jupyter) or `.dbquery.ipynb` (Databricks query notebooks)
- SQL scripts use Databricks SQL dialect with Unity Catalog three-level namespace: `catalog.schema.table`
- Job orchestration defined in YAML (Databricks Asset Bundles format, see `workshop_modelagem_dados/jobs/`)
- Commit messages have been simple (e.g., "update", "update aula 07")
