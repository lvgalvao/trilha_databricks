# 🐍 Aula 07 - API de DataFrame do PySpark

## 📌 Objetivo

Esta aula demonstra como usar a **API de DataFrame do PySpark** para realizar as mesmas transformações que fizemos na Aula 06 com SQL, mas agora usando programação imperativa com Python.

### O que vamos aprender:

1. **Leitura de CSVs** com schema inference vs schema explícito
2. **Transformações básicas**: `select`, `filter`, `withColumn`, `orderBy`
3. **Joins** entre DataFrames
4. **Agregações** com `groupBy` e `agg`
5. **Transformations vs Actions** (lazy evaluation)

---

## 📊 Datasets Utilizados

Esta aula utiliza os **mesmos datasets da Aula 06**:

* `customers.csv` - Dados de clientes
* `policies.csv` - Dados de apólices
* `claims.csv` - Dados de sinistros

**Localização dos dados:** `aula_07/data/`

> 💡 **Nota:** Os datasets são os mesmos da Aula 06, copiados para facilitar o acesso.

---

## 📁 Estrutura do Projeto

```
aula_07/
├── data/
│   ├── customers.csv
│   ├── policies.csv
│   └── claims.csv
├── notebooks/
│   └── 01_pyspark_dataframe_api.ipynb
└── README.md
```

---

## 🎯 Conteúdo da Aula

### Parte 1: Leitura de Dados com PySpark

#### 1.1. SparkSession
- No Databricks, a `SparkSession` já está disponível como `spark`
- Para ambiente local, é necessário criar manualmente

#### 1.2. Schema Inference
- Leitura com `inferSchema=True`
- Vantagens: Prático para exploração
- Desvantagens: Custo extra, pode errar tipos

#### 1.3. Schema Explícito
- Definição de schema usando `StructType` e `StructField`
- Boa prática para produção
- Melhor performance e garantia de tipos corretos

### Parte 2: Camada Bronze - Transformações Básicas

#### 2.1. Seleção e Renomeação
- `select()` - Selecionar colunas
- `alias()` - Renomear colunas
- Uso de `F.col()` para referenciar colunas

#### 2.2. Criando Novas Colunas
- `withColumn()` - Adicionar ou modificar colunas
- Uso de funções do Spark (`F.current_timestamp()`)

#### 2.3. Filtros
- `filter()` e `where()` - Ambos fazem a mesma coisa
- Expressões condicionais com `F.col()`

#### 2.4. Ordenação
- `orderBy()` - Ordenar por uma ou mais colunas
- `.desc()` e `.asc()` - Ordem descendente/ascendente

### Parte 3: Camada Silver - Joins e Enriquecimento

#### 3.1. Preparando DataFrames Bronze
- Seleção e transformação de colunas
- Cast de tipos para garantir compatibilidade nos joins

#### 3.2. Join Claims + Policies
- `join()` - Método para fazer joins
- Tipos de join: `inner`, `left`, `right`, `outer`
- Condição de join usando `on=`

#### 3.3. Join Final: Claims + Policies + Customers
- Múltiplos joins em sequência
- Enriquecimento de dados

#### 3.4. Seleção de Colunas Finais
- Seleção explícita de colunas desejadas
- Equivalente ao `SELECT` do SQL

### Parte 4: Camada Gold - Agregações e Métricas

#### 4.1. Agregações Básicas
- `agg()` - Agregações sem agrupamento
- Funções: `count()`, `countDistinct()`, `avg()`, `sum()`, `max()`

#### 4.2. Agregações por Grupo
- `groupBy()` - Agrupar por uma ou mais colunas
- `agg()` - Aplicar funções de agregação
- Exemplos: métricas por borough, tipo de colisão, severidade

### Parte 5: Conceitos Importantes

#### 5.1. Transformations vs Actions
- **Transformations** (lazy): `select`, `filter`, `join`, `groupBy`, etc.
- **Actions** (eager): `show()`, `count()`, `collect()`, `write()`, etc.
- Lazy evaluation: Transformations só executam quando uma action é chamada

#### 5.2. Plano de Execução
- `explain()` - Ver o plano de execução do Spark
- `explain(True)` - Plano detalhado com estatísticas

#### 5.3. Salvando Resultados
- `write.format("delta").saveAsTable()` - Salvar como tabela Delta
- `write.format("parquet").save()` - Salvar como Parquet

---

## 🔄 Comparação: SQL vs PySpark DataFrame API

| Operação | SQL (Aula 06) | PySpark DataFrame API (Aula 07) |
|----------|---------------|----------------------------------|
| Leitura | `CREATE TABLE ... AS SELECT * FROM read_files(...)` | `spark.read.format("csv").load(...)` |
| Seleção | `SELECT col1, col2 FROM table` | `df.select("col1", "col2")` |
| Filtro | `WHERE condition` | `df.filter(condition)` ou `df.where(condition)` |
| Join | `INNER JOIN ... ON ...` | `df1.join(df2, on=..., how="inner")` |
| Agregação | `GROUP BY ... COUNT(*), AVG(...)` | `df.groupBy(...).agg(F.count("*"), F.avg(...))` |
| Nova coluna | `SELECT ..., new_col AS alias` | `df.withColumn("new_col", expression)` |
| Ordenação | `ORDER BY col DESC` | `df.orderBy(F.col("col").desc())` |

---

## ✅ Vantagens do PySpark DataFrame API

- ✅ **Programação imperativa**: Mais flexível para lógica complexa
- ✅ **Reutilização**: Funções e classes podem ser reutilizadas
- ✅ **Testes**: Mais fácil de testar com unit tests
- ✅ **Integração**: Integra melhor com outras bibliotecas Python
- ✅ **Type safety**: Melhor suporte a type hints e IDEs

---

## 🤔 Quando usar SQL vs PySpark?

### Use SQL quando:
- Queries ad-hoc e análise exploratória
- Equipes mais orientadas a SQL
- Transformações simples e diretas
- Queries que serão compartilhadas com analistas de negócio

### Use PySpark quando:
- Pipelines complexos com lógica reutilizável
- Necessidade de integração com outras bibliotecas Python
- Lógica condicional complexa
- Necessidade de testes unitários
- Transformações que fazem parte de aplicações Python maiores

---

## 🚀 Como Executar

### Pré-requisitos

1. ✅ Acesso ao Databricks Workspace
2. ✅ Cluster Spark configurado
3. ✅ Datasets disponíveis em `aula_07/data/`

### Passos

1. **Abra o notebook** `notebooks/01_pyspark_dataframe_api.ipynb` no Databricks

2. **Ajuste o caminho dos dados** se necessário:
   ```python
   data_path = "file:/Workspace/Repos/trilha_databricks/aula_07/data"
   ```

3. **Execute as células sequencialmente**:
   - Cada parte do notebook é independente
   - Execute do início ao fim para ver o fluxo completo

4. **Explore os resultados**:
   - Use `show()` para visualizar dados
   - Use `printSchema()` para ver a estrutura
   - Use `explain()` para entender o plano de execução

---

## 📚 Conceitos Fundamentais

### Lazy Evaluation

O Spark usa **lazy evaluation** (avaliação preguiçosa):

- **Transformations** não executam imediatamente
- Elas apenas constroem um plano de execução
- A execução só acontece quando uma **Action** é chamada
- Isso permite otimizações automáticas pelo Spark

**Exemplo:**
```python
# Isso é uma TRANSFORMATION (não executa)
df_filtered = df.filter(F.col("age") > 18)

# Isso é uma ACTION (executa agora)
count = df_filtered.count()  # Agora sim o Spark executa tudo
```

### Transformations Comuns

- `select()` - Selecionar colunas
- `filter()` / `where()` - Filtrar linhas
- `withColumn()` - Adicionar/modificar colunas
- `drop()` - Remover colunas
- `join()` - Fazer joins
- `groupBy()` - Agrupar dados
- `orderBy()` - Ordenar dados
- `distinct()` - Remover duplicatas
- `union()` - Combinar DataFrames

### Actions Comuns

- `show()` - Mostrar dados no console
- `count()` - Contar linhas
- `collect()` - Coletar todos os dados (cuidado com datasets grandes!)
- `take(n)` - Pegar n primeiras linhas
- `first()` - Pegar primeira linha
- `write()` - Escrever dados
- `foreach()` - Aplicar função a cada linha

---

## 🎓 Exercícios Sugeridos

1. **Criar uma nova coluna** que calcule a idade do cliente baseado na data de nascimento
2. **Filtrar claims** com valor total maior que a média
3. **Agrupar por borough** e calcular o total de claims e valor médio
4. **Fazer um join** adicional com uma tabela fictícia de produtos
5. **Salvar o resultado** em formato Delta ou Parquet

---

## 🔍 Explorando Mais

### Funções Úteis do PySpark

```python
from pyspark.sql import functions as F

# Funções de data
F.current_date()
F.current_timestamp()
F.year(), F.month(), F.dayofmonth()

# Funções de string
F.upper(), F.lower(), F.trim()
F.substring(), F.concat()

# Funções condicionais
F.when().otherwise()
F.coalesce()

# Funções de agregação
F.count(), F.sum(), F.avg(), F.min(), F.max()
F.countDistinct()
F.collect_list(), F.collect_set()
```

### Window Functions

```python
from pyspark.sql.window import Window

window = Window.partitionBy("borough").orderBy("claim_total")
df.withColumn("rank", F.rank().over(window))
```

---

## 📖 Recursos Adicionais

- [Documentação PySpark](https://spark.apache.org/docs/latest/api/python/)
- [PySpark SQL Functions](https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/functions.html)
- [Best Practices PySpark](https://spark.apache.org/docs/latest/api/python/user_guide/best_practices.html)
- [Databricks PySpark Guide](https://docs.databricks.com/spark/latest/dataframes-datasets/introduction-to-dataframes-python.html)

---

## 🚀 Próximos Passos

Na próxima aula, vamos explorar:
- **Spark Runtime Architecture**: Jobs, Stages, Tasks
- **Otimizações**: Partitions, Broadcast Joins, Caching
- **Performance Tuning**: Como otimizar suas transformações
- **Structured Streaming**: Processamento de dados em tempo real

---

## 💡 Dicas Importantes

1. **Sempre defina schemas explícitos** em produção
2. **Use `explain()`** para entender o plano de execução
3. **Evite `collect()`** em datasets grandes
4. **Cache DataFrames** que serão reutilizados múltiplas vezes
5. **Use broadcast joins** para tabelas pequenas
6. **Partitione dados** adequadamente para melhor performance

---

**Bons estudos! 🎉**

