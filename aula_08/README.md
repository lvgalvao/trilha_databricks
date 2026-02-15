# Aula 08 - PySpark DataFrame API com Northwind

## Objetivo

Ensinar a **PySpark DataFrame API** de forma pratica, reconstruindo relatorios analiticos classicos do banco Northwind — que os alunos ja conhecem em SQL — agora usando Spark.

Este e o primeiro mergulho profundo em PySpark da trilha. Ate agora os alunos usaram Databricks principalmente via SQL e conceitos de plataforma.

### O que vamos aprender:

1. **Leitura de dados** com `spark.table()` e `spark.read` (CSV, JSON, Parquet, Delta)
2. **Transformacoes** com `select`, `filter`, `withColumn`, funcoes de string/data/nulos
3. **Agregacoes** com `groupBy().agg()` e multiplas funcoes
4. **Joins** completos: inner, left, right, full, anti, semi, broadcast
5. **Window Functions**: ranking, YTD, LAG/LEAD, NTILE, pivot
6. **Escrita** em Delta, Parquet, CSV com controle de modo e particao
7. **Pipeline completo**: leitura -> transformacao -> escrita

---

## Dataset: Northwind Traders

O Northwind e um banco de dados classico de uma empresa ficticia de importacao/exportacao de alimentos. E um ERP completo com 8 tabelas principais.

### Diagrama ER

![Northwind ER Diagram](northwind-er-diagram.png)

### Tabelas

| Tabela | Registros | Descricao |
|--------|-----------|-----------|
| `customers` | 91 | Clientes da empresa |
| `orders` | 830 | Pedidos de venda |
| `order_details` | 2.155 | Itens de cada pedido |
| `products` | 77 | Catalogo de produtos |
| `categories` | 8 | Categorias de produtos |
| `employees` | 9 | Funcionarios/vendedores |
| `suppliers` | 29 | Fornecedores |
| `shippers` | 3 | Transportadoras |

### Formula Central de Receita

```
receita = unit_price * quantity * (1.0 - discount)
```

### Relacionamentos

```
customers --< orders --< order_details >-- products >-- categories
                |                              |
                +-- employees                  +-- suppliers
                +-- shippers
```

---

## Estrutura do Projeto

```
aula_08/
├── README.md
├── .llm/
│   └── prd.md                              # PRD com definicao completa
├── dataset/
│   └── script.sql                          # Script Databricks SQL (cria e popula as tabelas)
└── notebooks/
    ├── bloco_01_leitura.ipynb              # Leitura e Exploracao (~50 min)
    ├── bloco_02_transformacoes.ipynb       # Transformacoes Essenciais (~60 min)
    ├── bloco_03_agregacoes_joins.ipynb     # Agregacoes e Joins (~50 min)
    ├── bloco_04_window_functions.ipynb     # Window Functions (~40 min)
    └── bloco_05_escrita_projeto.ipynb      # Escrita e Projeto Final (~40 min)
```

---

## Conteudo por Bloco

### Bloco 01 — Leitura e Exploracao de Dados (~50 min)

- `spark.table()` e `spark.read.csv()` / `.json()` / `.parquet()` / `.format("delta")`
- Schema inference vs schema explicito com `StructType`
- Exploracao: `display()`, `printSchema()`, `describe()`, `count()`
- DataFrame API vs `spark.sql()` — equivalencia

### Bloco 02 — Transformacoes Essenciais (~60 min)

- `select()`, `filter()`, `withColumn()`, `drop()`, `distinct()`
- `col()`, `lit()`, `when().otherwise()`, `cast()`
- Strings: `upper()`, `lower()`, `concat()`, `split()`
- Datas: `year()`, `month()`, `datediff()`, `to_date()`
- Nulos: `isNull()`, `coalesce()`, `fillna()`, `dropna()`
- **Formula central:** `receita = unit_price * quantity * (1.0 - discount)`

### Bloco 03 — Agregacoes e Joins (~50 min)

- `groupBy().agg()` com multiplas agregacoes
- `orderBy()`, `limit()`
- Joins: inner, left, right, full, anti, semi
- `broadcast()` para tabelas pequenas
- Filtro pos-agregacao (equivalente HAVING)
- **4 relatorios Northwind:**
  1. Receita total 1997
  2. Receita por cliente
  3. Top 10 produtos
  4. Clientes UK com pagamento > 1000

### Bloco 04 — Window Functions (~40 min)

- `Window.partitionBy().orderBy()`
- Ranking: `row_number()`, `rank()`, `dense_rank()`
- Analiticas: `lead()`, `lag()`, `sum().over()`
- `ntile()` para segmentacao
- Pivot tables
- **3 relatorios Northwind:**
  5. Receitas acumuladas mensais com YTD
  6. Segmentacao de clientes (5 grupos)
  7. Clientes para marketing

### Bloco 05 — Escrita e Projeto Final (~40 min)

- Formatos: Delta, Parquet, CSV
- Modos: overwrite, append, error, ignore
- `partitionBy()` na escrita
- `repartition()` vs `coalesce()`
- **Projeto final:** Pipeline completo leitura -> transformacao -> escrita
  - 5 relatorios analiticos salvos como Delta tables
  - CSV de exportacao

---

## SQL vs PySpark — Tabela de Equivalencia

| Operacao | SQL | PySpark DataFrame API |
|----------|-----|----------------------|
| Leitura | `SELECT * FROM table` | `spark.table("table")` |
| Selecao | `SELECT col1, col2` | `df.select("col1", "col2")` |
| Filtro | `WHERE condition` | `df.filter(condition)` |
| Nova coluna | `col AS alias` | `df.withColumn("alias", expr)` |
| Join | `JOIN ... ON ...` | `df1.join(df2, "key")` |
| Agregacao | `GROUP BY ... SUM(...)` | `df.groupBy(...).agg(F.sum(...))` |
| Ordenacao | `ORDER BY col DESC` | `df.orderBy(F.col("col").desc())` |
| Limite | `LIMIT 10` | `df.limit(10)` |
| Having | `HAVING condition` | `.agg(...).filter(condition)` |
| Window | `SUM() OVER (PARTITION BY ...)` | `F.sum().over(Window.partitionBy(...))` |
| Ranking | `RANK() OVER (ORDER BY ...)` | `F.rank().over(Window.orderBy(...))` |
| NTILE | `NTILE(5) OVER (...)` | `F.ntile(5).over(w)` |
| Pivot | N/A (complexo) | `df.groupBy(...).pivot(...).agg(...)` |

---

## 7 Relatorios Analiticos

Estes relatorios SQL do Northwind sao reconstruidos em PySpark nos notebooks:

| # | Relatorio | Bloco | Conceitos PySpark |
|---|-----------|-------|-------------------|
| 1 | Receita total 1997 | 03 | `filter(year)`, `join`, `agg(sum)` |
| 2 | Receita por cliente | 03 | multi-join, `groupBy`, `orderBy(desc)` |
| 3 | Top 10 produtos | 03 | `join`, `groupBy`, `orderBy`, `limit` |
| 4 | Clientes UK > 1000 | 03 | `filter(country)`, `groupBy`, filtro pos-agg |
| 5 | Receitas acumuladas YTD | 04 | `Window(SUM OVER, LAG)`, encadeamento |
| 6 | Segmentacao de clientes | 04 | `groupBy` + `ntile()` Window |
| 7 | Clientes para marketing | 04 | `ntile` + `filter` |

---

## Como Executar

### Pre-requisitos

1. Acesso ao Databricks Workspace
2. Cluster Spark configurado (DBR 13+)
3. Catalogo Unity Catalog disponivel

### Passos

1. **Criar o dataset Northwind:**
   - Abra `dataset/script.sql` no Databricks
   - Ajuste `${catalog}` pelo nome do seu catalogo
   - Execute todas as celulas — cria o schema `northwind` com as 8 tabelas

2. **Ajustar catalogo nos notebooks:**
   - Em cada notebook, altere a variavel `CATALOG` para o nome do seu catalogo:
   ```python
   CATALOG = "seu_catalogo_aqui"
   ```

3. **Executar os notebooks na ordem:**
   - `bloco_01_leitura.ipynb`
   - `bloco_02_transformacoes.ipynb`
   - `bloco_03_agregacoes_joins.ipynb`
   - `bloco_04_window_functions.ipynb`
   - `bloco_05_escrita_projeto.ipynb`

4. **Explorar os resultados:**
   - Use `display()` para visualizacoes interativas
   - Use `printSchema()` para ver estruturas
   - Faca os exercicios ao final de cada bloco

---

## Imports Padrao

```python
from pyspark.sql import functions as F
from pyspark.sql.window import Window
from pyspark.sql.types import StructType, StructField, StringType, IntegerType, FloatType, DateType
```

---

## Recursos Adicionais

- [Documentacao PySpark](https://spark.apache.org/docs/latest/api/python/)
- [PySpark SQL Functions](https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/functions.html)
- [Databricks PySpark Guide](https://docs.databricks.com/spark/latest/dataframes-datasets/introduction-to-dataframes-python.html)
