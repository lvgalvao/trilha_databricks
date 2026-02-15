# PRD — Aula 08: Projeto Prático PySpark com Northwind
## Trilha Databricks · Jornada de Dados

---

## 1. Visão Geral

**Repositório:** `github.com/lvgalvao/trilha_databricks/aula_08`

**Produto:** Projeto prático de PySpark focado em sintaxe e operações com DataFrames, usando o banco Northwind como case analítico.

**Objetivo:** Ensinar PySpark DataFrame API de forma prática, reconstruindo relatórios analíticos clássicos do Northwind, que os alunos já conhecem em SQL, agora usando Spark. Este é o primeiro contato do aluno com código PySpark extensivo na trilha.

**Duração:** ~4 horas de conteúdo prático (5 blocos).

**Formato:** Notebooks Databricks (.py) com células Markdown + código PySpark intercalados.

**Dataset:** Northwind Traders. Fonte: arquivo `script.sql` disponível na pasta `aula_08/`.

---

## 2. Contexto na Trilha — O que já foi ensinado (Aulas 01–07)

A aula_08 é a continuação direta de 7 aulas + 1 workshop que o aluno já completou. É fundamental não repetir conteúdo. Abaixo está o mapeamento completo do que já foi coberto:

### 2.1 Mapa de Conteúdo Anterior

| Aula | Duração | Tópico | O que o aluno JÁ SABE |
|------|---------|--------|----------------------|
| **Aula 01** | 1h | Setup Databricks | Criar conta Free Edition, configurar workspace, navegar na interface |
| **Aula 02** | 1h | Databricks Fundamentals | Conceitos da plataforma, clusters, notebooks, visão geral da arquitetura |
| **Aula 03** | 1h | Unity Catalog | Governança de dados, catálogos, schemas, tabelas, volumes |
| **Aula 04** | 1h | Data Ingestion + Lakeflow Connect | Ingestão de dados, conectores, volumes, Auto Loader |
| **Aula 05** | 1h | Lakeflow Jobs | Orquestração com Databricks Workflows, agendamento |
| **Workshop 01** | 4h | Modelagem de Dados | Arquitetura Medallion (Bronze/Silver/Gold), SCD2, tabelas fato/dimensão, views analíticas |
| **Aula 06** | 1h | Lakeflow Declarative Pipelines | DLT (Delta Live Tables), pipelines declarativas |
| **Aula 07** | 1h | *(conteúdo mais recente — base direta para aula_08)* |

### 2.2 O que a Aula 08 NÃO deve cobrir (já ensinado)

- ❌ Setup do Databricks, criação de conta, navegação na interface (Aulas 01-02)
- ❌ Unity Catalog, catálogos, schemas, governança (Aula 03)
- ❌ Auto Loader, Lakeflow Connect, volumes (Aula 04)
- ❌ Databricks Workflows/Jobs (Aula 05)
- ❌ Arquitetura Medallion, SCD2, modelagem dimensional (Workshop 01)
- ❌ DLT / Pipelines declarativas (Aula 06)
- ❌ Conceitos teóricos de Spark (arquitetura, lazy evaluation, clusters) — já passados na introdução

### 2.3 O que a Aula 08 ADICIONA de novo

A aula_08 é o **primeiro mergulho profundo em PySpark DataFrame API** da trilha. Até agora os alunos usaram Databricks principalmente via SQL e conceitos de plataforma. Agora vão aprender a sintaxe PySpark pura para manipulação de dados:

- ✅ PySpark DataFrame API completa (read, transform, aggregate, write)
- ✅ Equivalência SQL ↔ PySpark (ponte para quem já sabe SQL)
- ✅ Window Functions em PySpark
- ✅ Joins avançados (anti, semi, broadcast)
- ✅ Pipeline completo: leitura → transformação → escrita em Delta
- ✅ Case real com dataset relacional (Northwind verificar o dataset.sql para ver as tabelas e as colunas.)
- ✅ Projeto completo: leitura → transformação → escrita em Delta
- ✅ Converter o script.sql para um notebook Databricks que vai criar todo o dataset Northwind no Databricks.

---

## 3. Público-Alvo

| Perfil | Nível neste ponto da trilha |
|--------|----------------------------|
| Analistas de dados | SQL intermediário, Python básico, Databricks funcional, Spark conceitual |
| Cientistas de dados | SQL/Python intermediários, familiaridade com notebooks Databricks |
| Engenheiros de dados | Python/SQL sólidos, entendem Unity Catalog e Workflows |

**O aluno chega na aula_08 sabendo:** configurar Databricks, navegar em Unity Catalog, criar pipelines com DLT, modelar dados em Medallion, orquestrar com Jobs. **Falta:** dominar PySpark DataFrame API na prática.

---

## 4. Dataset Northwind

### 4.1 Sobre o Dataset

O Northwind Traders é um banco de dados clássico de uma empresa fictícia de importação/exportação de alimentos especiais. É um ERP completo com clientes, pedidos, produtos, funcionários e transportadoras.

### 4.2 Tabelas Principais (usadas no projeto)

| Tabela | Colunas-Chave | Papel no Projeto |
|--------|---------------|------------------|
| **orders** | order_id (PK), customer_id (FK), employee_id (FK), order_date, shipped_date, freight, ship_country | Tabela central — pedidos |
| **order_details** | order_id (FK), product_id (FK), unit_price, quantity, discount | Itens de cada pedido — base para cálculo de receita |
| **customers** | customer_id (PK), company_name, contact_name, country, city | Segmentação e análise por cliente |
| **products** | product_id (PK), product_name, supplier_id (FK), category_id (FK), unit_price, discontinued | Ranking de produtos |
| **categories** | category_id (PK), category_name, description | Agrupamento por categoria |
| **employees** | employee_id (PK), last_name, first_name, title, hire_date, reports_to | Performance por vendedor |
| **suppliers** | supplier_id (PK), company_name, country | Análise de fornecedores |
| **shippers** | shipper_id (PK), company_name | Transportadoras |

### 4.3 Tabelas Secundárias (referência, pouco usadas)

region, territories, employee_territories, customer_customer_demo, customer_demographics, us_states

### 4.4 Fórmula Central de Receita

```
receita = unit_price * quantity * (1.0 - discount)
```

Essa fórmula vem de `order_details` e é o coração analítico do projeto.

### 4.5 Relacionamentos Principais

```
customers ──< orders ──< order_details >── products >── categories
                │                              │
                ├── employees                  └── suppliers
                └── shippers
```

---

## 5. Estrutura da Aula — 5 Blocos

> **Premissa:** O aluno já sabe usar Databricks, Unity Catalog, e conceitos de Spark. A aula_08 vai direto para código PySpark. Não há introdução teórica — é 100% prática.

---

### Bloco 1 — Leitura e Exploração de Dados (~50 min)

**Objetivo:** O aluno carrega as tabelas Northwind no Spark e explora a estrutura dos DataFrames.

**Por que isso é novo:** Nas aulas anteriores o aluno ingeriu dados via Auto Loader/Volumes (aula_04) e DLT (aula_06), mas nunca usou `spark.read` diretamente com controle de schema, nem explorou DataFrames via código Python.

**Conteúdo:**

1. **Carga do Northwind no Databricks**
   - Executar `script.sql` para criar as tabelas
   - Ler tabelas como DataFrames: `spark.table("northwind.orders")`
   - Alternativa: ler de arquivos CSV/Parquet com `spark.read`

2. **spark.read — Formatos e opções**
   - CSV: `spark.read.csv(path, header=True, inferSchema=True, sep=",")`
   - JSON: `spark.read.json(path)`
   - Parquet: `spark.read.parquet(path)` — explicar vantagem colunar
   - Delta: `spark.read.format("delta").load(path)` — formato nativo
   - `spark.table()` vs `spark.read` — quando usar cada um

3. **Schema: inferência vs definição explícita**
   - Ler `orders` com `inferSchema=True` e inspecionar tipos
   - Definir schema com `StructType` / `StructField` para `order_details`
   - Trade-off: inferência (rápido) vs explícito (seguro em produção)

4. **Exploração de DataFrames**
   - `display()` — visualização nativa Databricks
   - `printSchema()` — árvore de tipos
   - `describe()` — estatísticas descritivas
   - `dtypes`, `columns`, `count()`
   - `show(n, truncate=False)`

5. **DataFrame API vs spark.sql()**
   - `df.createOrReplaceTempView("orders")`
   - Mesma consulta nos dois estilos — mostrar equivalência
   - Exemplo: listar produtos com preço > 50

**Exercícios:**
- Carregar `customers` e mostrar schema, contagem, 10 primeiros registros
- Carregar `products` com schema explícito e comparar com inferido
- Escrever mesma query em DataFrame API e spark.sql()

---

### Bloco 2 — Transformações Essenciais (~60 min)

**Objetivo:** Dominar as operações de transformação de colunas, filtros e manipulação de dados em PySpark.

**Por que isso é novo:** O aluno sabe fazer essas operações em SQL. Agora aprende a sintaxe equivalente em PySpark DataFrame API.

**Conteúdo:**

1. **Operações básicas**
   - `select()` — com string e `col()`
   - `filter()` / `where()` — filtrar linhas
   - `withColumn()` — criar/modificar colunas
   - `withColumnRenamed()` — renomear
   - `drop()` — remover colunas
   - `distinct()` / `dropDuplicates()`

2. **Funções essenciais**
   - `col()`, `lit()` — referência a colunas e valores literais
   - `when().otherwise()` — lógica condicional
   - `cast()` — conversão de tipos
   - **Northwind:** Criar coluna de receita em `order_details`:
     ```python
     df.withColumn("receita", col("unit_price") * col("quantity") * (1.0 - col("discount")))
     ```

3. **Operações com strings**
   - `upper()`, `lower()`, `trim()`, `split()`, `concat()`, `substring()`
   - `regexp_replace()`, `regexp_extract()`
   - **Northwind:** Padronizar nomes de países em `customers`

4. **Operações com datas**
   - `to_date()`, `date_format()`, `year()`, `month()`, `dayofweek()`
   - `datediff()`, `months_between()`
   - `current_date()`, `current_timestamp()`
   - **Northwind:** Extrair ano/mês de `order_date`, calcular dias entre pedido e entrega

5. **Tratamento de nulos**
   - `isNull()`, `isNotNull()`, `coalesce()`
   - `fillna()` / `na.fill()`, `dropna()` / `na.drop()`
   - **Northwind:** Identificar pedidos sem `shipped_date`, tratar `region` nula

**Cada operação: primeiro sintaxe isolada, depois equivalente SQL, depois aplicação Northwind.**

**Exercícios:**
- Criar coluna `receita_total` e filtrar receitas > 1000
- Criar colunas `ano`, `mes` e `dias_para_entrega`
- Padronizar países para maiúsculo e tratar nulos em `region`

---

### Bloco 3 — Agregações e Joins (~50 min)

**Objetivo:** Agrupar dados, fazer múltiplas agregações e combinar tabelas com diferentes tipos de join.

**Por que isso é novo:** O aluno sabe JOIN e GROUP BY em SQL. Agora aprende `groupBy().agg()` e os 6 tipos de join do PySpark, incluindo anti e semi join.

**Conteúdo:**

1. **GroupBy + Agregações**
   - `groupBy().count()`, `.sum()`, `.avg()`, `.min()`, `.max()`
   - Múltiplas agregações com `.agg()` + `.alias()`
   - **Northwind — Relatório 1:** Receita total de 1997
     ```python
     # Equivalente SQL: total_revenues_1997_view
     ```
   - **Northwind — Relatório 2:** Receita total por cliente
     ```python
     # Equivalente SQL: view_total_revenues_per_customer
     ```
   - **Northwind — Relatório 3:** Top 10 produtos mais vendidos
     ```python
     # Equivalente SQL: top_10_products
     ```

2. **OrderBy / Sort**
   - `orderBy()` com `.desc()`, `.asc()`
   - Múltiplas colunas de ordenação
   - `limit(n)` — equivalente ao TOP / LIMIT do SQL

3. **Tipos de Join**
   - `inner` — pedidos com clientes
   - `left` — todos os clientes, mesmo sem pedidos
   - `right` — todos os pedidos, mesmo sem cliente
   - `full` / `outer` — combinação completa
   - `anti` — clientes que NUNCA fizeram pedido
   - `semi` — clientes que fizeram pelo menos 1 pedido (sem duplicar colunas)
   - **Northwind:** Join completo `customers + orders + order_details`

4. **Broadcast Join**
   - Conceito: tabela pequena replicada em todos os nós
   - `broadcast()` hint — quando usar (categories, shippers)
   - **Northwind:** Broadcast de `categories` no join com `products`

5. **Filtro pós-agregação (equivalente HAVING)**
   - `groupBy().agg().filter()`
   - **Northwind — Relatório 4:** Clientes UK com pagamento > 1000
     ```python
     # Equivalente SQL: uk_clients_who_pay_more_then_1000
     ```

**Exercícios:**
- Reconstruir `total_revenues_1997_view` em PySpark
- Receita por categoria (join products + categories + order_details)
- Encontrar clientes sem pedidos usando anti join

---

### Bloco 4 — Window Functions e Transformações Avançadas (~40 min)

**Objetivo:** Dominar window functions e transformações complexas, reconstruindo os relatórios avançados do Northwind.

**Por que isso é novo:** Window functions são conceito avançado que o aluno viu no Workshop de Modelagem em SQL (SCD2, views analíticas). Agora aprende a sintaxe PySpark com `Window.partitionBy().orderBy()`.

**Conteúdo:**

1. **Window Functions — Conceito PySpark**
   - `from pyspark.sql.window import Window`
   - `Window.partitionBy().orderBy()`
   - Diferença fundamental: groupBy agrega (reduz linhas), window mantém todas as linhas

2. **Funções de ranking**
   - `row_number()`, `rank()`, `dense_rank()`
   - **Northwind:** Ranking de clientes por receita total

3. **Funções analíticas**
   - `lead()` e `lag()` — valor da próxima/anterior linha
   - `sum().over()` — soma acumulada (running total / YTD)
   - **Northwind — Relatório 5:** Crescimento mensal e YTD
     ```python
     # Equivalente SQL: view_receitas_acumuladas
     # LAG para diferença mensal, SUM OVER para YTD
     ```

4. **Segmentação com NTILE**
   - `ntile(5)` — dividir em N grupos iguais
   - **Northwind — Relatório 6:** Segmentação de clientes em 5 grupos
     ```python
     # Equivalente SQL: view_total_revenues_per_customer_group
     ```
   - **Northwind — Relatório 7:** Filtrar grupos 3, 4 e 5 para marketing
     ```python
     # Equivalente SQL: clients_to_marketing
     ```

5. **Pivot**
   - `groupBy().pivot().agg()` — transformar linhas em colunas
   - **Northwind:** Receita por categoria pivotada por ano

6. **Explode (conceitual)**
   - `explode()` para arrays, `explode_outer()` para manter nulos
   - Demonstração conceitual (simular cenário — Northwind não tem arrays nativos)

7. **UDFs — quando usar (e quando evitar)**
   - Conceito e sintaxe básica
   - Por que funções nativas são preferíveis (performance Catalyst)

**Exercícios:**
- Reconstruir `view_receitas_acumuladas` em PySpark (YTD + crescimento mensal)
- Segmentar clientes com NTILE(5) e filtrar baixo valor
- Tabela pivotada: receita por país × ano

---

### Bloco 5 — Escrita, Particionamento e Projeto Final (~40 min)

**Objetivo:** Persistir dados transformados e executar um pipeline completo.

**Por que isso é novo:** O aluno já sabe sobre Delta Lake (aula 03-04, workshop 01) mas nunca escreveu DataFrames programaticamente com controle de modo, particionamento e otimização.

**Conteúdo:**

1. **Escrita de DataFrames**
   - `write.format("delta").save()` — Delta Lake (preferencial)
   - `write.parquet()` — formato colunar
   - `write.csv()` — exportação
   - `write.saveAsTable()` — tabela gerenciada no Unity Catalog

2. **Modos de escrita**
   - `overwrite`, `append`, `error` (default), `ignore`

3. **Particionamento na escrita**
   - `partitionBy()` na escrita — organizar arquivos por coluna
   - **Northwind:** Particionar receitas por ano/mês
   - Quando particionar vs quando não

4. **Repartition vs Coalesce**
   - `repartition(n)` — com shuffle
   - `coalesce(n)` — sem shuffle (apenas reduzir)

5. **🏆 Projeto Final — Pipeline Northwind Completo**

   O aluno constrói um pipeline end-to-end:

   **Etapa 1 — Leitura**
   - Carregar: orders, order_details, customers, products, categories

   **Etapa 2 — Transformação**
   - Calcular receita por item
   - Joins: orders + order_details + customers + products + categories
   - Colunas derivadas: ano, mês, dias_para_entrega
   - Gerar 5 relatórios como DataFrames:
     1. Receita mensal com YTD e crescimento % (window functions)
     2. Top 10 produtos por receita (groupBy + orderBy + limit)
     3. Segmentação de clientes em 5 grupos (NTILE)
     4. Clientes UK com pagamento > 1000 (filter + groupBy + filter pós-agg)
     5. Receita por categoria pivotada por ano (pivot)

   **Etapa 3 — Escrita**
   - Salvar cada relatório como Delta table no Unity Catalog
   - Salvar CSV consolidado para exportação

   **Entrega:** 5 Delta tables + 1 CSV + notebook documentado

---

## 6. Mapeamento SQL → PySpark

Os relatórios SQL do repositório Northwind-SQL-Analytics são reconstruídos em PySpark:

| # | View SQL Original | Bloco | Conceitos PySpark |
|---|-------------------|-------|-------------------|
| 1 | `total_revenues_1997_view` | 3 | filter(year), join, agg(sum) |
| 2 | `view_receitas_acumuladas` | 4 | Window(SUM OVER, LAG), encadeamento |
| 3 | `view_total_revenues_per_customer` | 3 | multi-join, groupBy, orderBy(desc) |
| 4 | `view_total_revenues_per_customer_group` | 4 | groupBy + ntile() Window |
| 5 | `clients_to_marketing` | 4 | ntile + filter (CTE → encadeamento) |
| 6 | `top_10_products` | 3 | join, groupBy, orderBy, limit |
| 7 | `uk_clients_who_pay_more_then_1000` | 3 | filter(country), groupBy, filter pós-agg |

---

## 7. Diretrizes Pedagógicas

### 7.1 Premissas (baseadas nas aulas anteriores)

- **O aluno já sabe Databricks** — não explicar interface, clusters, notebooks
- **O aluno já sabe Unity Catalog** — usar `spark.table("catalog.schema.table")` sem explicar o conceito
- **O aluno já sabe Delta Lake** — salvar em Delta sem re-explicar ACID, time travel
- **O aluno já sabe Medallion** — referenciar Bronze/Silver/Gold como contexto, sem re-ensinar
- **O aluno já sabe SQL** — mostrar equivalentes como "ponte", não como conteúdo novo

### 7.2 O que é NOVO nesta aula

- PySpark DataFrame API (toda a sintaxe)
- `from pyspark.sql.functions import *`
- `from pyspark.sql.window import Window`
- `from pyspark.sql.types import *`
- Encadeamento de operações (chaining)
- Broadcast joins
- Anti/Semi joins
- Pivot em PySpark
- Escrita programática com controle de modo e partição

### 7.3 Abordagem

- **100% código PySpark**, pronto para notebooks Databricks
- **Dataset real Northwind** — sem dados inventados
- **Cada conceito:** sintaxe isolada → equivalente SQL → aplicação Northwind
- **Código comentado** com pegadinhas destacadas
- **Tom:** direto, prático, estilo Jornada de Dados — "você já sabe fazer em SQL, em PySpark é assim"

### 7.4 Padrão do Notebook

```
## Conceito X
Explicação breve em Markdown

### PySpark
código pyspark

### Equivalente SQL
código spark.sql()

### Aplicação Northwind
código aplicado ao dataset
```

- 2-3 exercícios ao final de cada bloco
- Cada bloco = 1 notebook separado

### 7.5 Pegadinhas a Reforçar

- **Lazy evaluation:** transformações não executam até action (show, collect, write)
- **collect() é perigoso:** nunca em datasets grandes — usar display() ou show()
- **Imutabilidade:** withColumn() retorna novo DF, não modifica original
- **Broadcast:** tabelas pequenas (categories, shippers) devem usar broadcast
- **Schema explícito:** sempre em produção, inferSchema só para exploração
- **Particionamento:** não particionar por alta cardinalidade

---

## 8. Setup Técnico

### 8.1 Ambiente

- **Plataforma:** Databricks (Free Edition ou Workspace)
- **Runtime:** DBR 13+ (Delta Lake nativo)
- **Linguagem:** Python (PySpark)

### 8.2 Carga dos Dados

O arquivo `script.sql` estará na pasta `aula_08/`.

**Opção preferencial — Via SQL:**
```sql
-- Executar script.sql em notebook SQL
-- Depois ler como DataFrame:
```
```python
orders = spark.table("northwind.orders")
```

**Opção alternativa — Via CSV:**
```python
orders = spark.read.csv("/path/orders.csv", header=True, inferSchema=True)
```

### 8.3 Imports padrão

```python
from pyspark.sql import SparkSession
from pyspark.sql.functions import *
from pyspark.sql.window import Window
from pyspark.sql.types import StructType, StructField, StringType, IntegerType, FloatType, DateType
```

---

## 9. Entregáveis

| Entregável | Caminho | Descrição |
|------------|---------|-----------|
| Notebook Bloco 1 | `aula_08/bloco_01_leitura.py` | Leitura e Exploração |
| Notebook Bloco 2 | `aula_08/bloco_02_transformacoes.py` | Transformações Essenciais |
| Notebook Bloco 3 | `aula_08/bloco_03_agregacoes_joins.py` | Agregações e Joins |
| Notebook Bloco 4 | `aula_08/bloco_04_window_functions.py` | Window Functions |
| Notebook Bloco 5 | `aula_08/bloco_05_escrita_projeto.py` | Escrita e Projeto Final |
| SQL Script | `aula_08/script.sql` | Criação do banco Northwind |
| PRD | `aula_08/PRD.md` | Este documento |

---

## 10. Critérios de Sucesso

Ao final da aula_08, o aluno deve ser capaz de:

- [ ] Carregar dados no Spark via `spark.table()` e `spark.read`
- [ ] Definir schemas explícitos com StructType
- [ ] Aplicar select, filter, withColumn com fluência
- [ ] Manipular strings, datas e nulos em PySpark
- [ ] Fazer joins entre múltiplas tabelas (incluindo anti, semi e broadcast)
- [ ] Usar groupBy + agg para relatórios analíticos
- [ ] Aplicar window functions (ranking, YTD, LAG/LEAD, NTILE)
- [ ] Escrever DataFrames em Delta e CSV com controle de modo e partição
- [ ] Construir pipeline completo: leitura → transformação → escrita
- [ ] Traduzir qualquer query SQL conhecida para PySpark equivalente

---

*PRD v2.0 — Trilha Databricks · Aula 08 · Projeto PySpark Northwind*
*Repositório: github.com/lvgalvao/trilha_databricks*