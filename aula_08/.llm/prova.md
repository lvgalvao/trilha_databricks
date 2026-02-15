# Databricks Certified Associate Developer for Apache Spark
## Simulado com 10 Questões + Mapa de Conteúdo

---

## Mapa do Exame — O que cai na prova

```mermaid
mindmap
  root((Exame Databricks<br/>Apache Spark<br/>45 questões · 90 min))
    **Seção 1 — Arquitetura**
      Cluster, Driver, Workers, Executors
      Hierarquia: Job → Stage → Task
      Lazy Evaluation
      Shuffling e Partições
      Caching e Storage Levels
      Garbage Collection
    **Seção 2 — Spark SQL**
      spark.read: CSV, JSON, Parquet, ORC, Delta, JDBC
      spark.sql e queries diretas em arquivos
      Save modes: overwrite, append, error, ignore
      Temp Views
      partitionBy na escrita
    **Seção 3 — DataFrame API**
      select, withColumn, drop, rename, explode
      filter, sort, dropDuplicates
      groupBy, agg, count, approx_count_distinct, mean
      Joins: inner, left, cross, broadcast, multi-key
      union, unionAll
      Manipulação de datas
      UDFs com e sem state
      Broadcast variables e Accumulators
    **Seção 4 — Troubleshooting**
      repartition vs coalesce
      Data skew
      Reduzir shuffling
      AQE Adaptive Query Execution
      Spark UI, Driver Logs, Executor Logs
      Diagnóstico de OOM
    **Seção 5 — Structured Streaming**
      Micro-batch processing
      Exactly-once semantics
      Fault tolerance e checkpointing
      Output modes: append, complete, update
      Window aggregations em streaming
      Deduplication com e sem watermark
    **Seção 6 — Spark Connect**
      Features do Spark Connect
      Deployment modes: Client, Cluster, Local
    **Seção 7 — Pandas API on Spark**
      Vantagens da API Pandas distribuída
      Pandas UDF
```

---

## Questão 1 — Write com partitionBy e overwrite

**Seção 2 — Spark SQL · Leitura e Escrita**

```mermaid
flowchart TB
    ENUNCIADO["Um engenheiro precisa escrever um DataFrame df<br/>em Parquet, particionado por country,<br/>sobrescrevendo dados existentes"]

    A["A — mode append + partitionBy ❌<br/>Append não sobrescreve"]
    B["B — partitionBy sem mode ❌<br/>Modo padrão é error, vai falhar"]
    C["C — mode overwrite sem partitionBy ❌<br/>Sobrescreve mas não particiona"]
    D["D — mode overwrite + partitionBy ✅<br/>df.write.mode·overwrite·.partitionBy·country·.parquet·path·"]

    ENUNCIADO --> A
    ENUNCIADO --> B
    ENUNCIADO --> C
    ENUNCIADO --> D

    style D fill:#4caf50,color:#fff,stroke:#2e7d32,stroke-width:3px
    style A fill:#ffebee,color:#c62828
    style B fill:#ffebee,color:#c62828
    style C fill:#ffebee,color:#c62828
    style ENUNCIADO fill:#e3f2fd,color:#1565c0
```

---

## Questão 2 — Onde encontrar Executor Logs

**Seção 4 — Troubleshooting · Logs e Monitoring**

```mermaid
flowchart TB
    ENUNCIADO["Um engenheiro nota aumento no tempo de execução<br/>e quer verificar os logs dos Executors<br/>para diagnosticar problemas de performance"]

    A["A — spark-submit --verbose ❌<br/>Isso mostra config, não executor logs"]
    B["B — Logs no master node /tmp ❌<br/>Executor logs ficam nos workers, não no master"]
    C["C — Spark UI → Stages → Executor logs ✅<br/>Caminho correto para acessar logs"]
    D["D — spark-sql CLI ❌<br/>CLI de queries, não de logs"]

    ENUNCIADO --> A
    ENUNCIADO --> B
    ENUNCIADO --> C
    ENUNCIADO --> D

    style C fill:#4caf50,color:#fff,stroke:#2e7d32,stroke-width:3px
    style A fill:#ffebee,color:#c62828
    style B fill:#ffebee,color:#c62828
    style D fill:#ffebee,color:#c62828
    style ENUNCIADO fill:#e3f2fd,color:#1565c0
```

---

## Questão 3 — Renomear e substituir colunas

**Seção 3 — DataFrame API · Manipulação de Colunas**

```mermaid
flowchart TB
    ENUNCIADO["Substituir coluna division por state<br/>e renomear mName para managerName"]

    A["A ✅<br/>withColumn·state, col·division··<br/>.drop·division·<br/>.withColumnRenamed·mName, managerName·"]
    B["B ❌<br/>withColumnRenamed com argumentos invertidos<br/>Renomeia state para division — ao contrário"]
    C["C ❌<br/>Sintaxe errada: col·division· como primeiro arg<br/>e managerName/mName invertidos"]
    D["D ❌<br/>lit· · em withColumnRenamed não funciona<br/>e columns={} não é sintaxe válida"]

    ENUNCIADO --> A
    ENUNCIADO --> B
    ENUNCIADO --> C
    ENUNCIADO --> D

    style A fill:#4caf50,color:#fff,stroke:#2e7d32,stroke-width:3px
    style B fill:#ffebee,color:#c62828
    style C fill:#ffebee,color:#c62828
    style D fill:#ffebee,color:#c62828
    style ENUNCIADO fill:#e3f2fd,color:#1565c0
```

---

## Questão 4 — Sort, printSchema e conversão para lista

**Seção 3 — DataFrame API · Operações em DataFrames**

```mermaid
flowchart TB
    ENUNCIADO["Ordenar employeeDF por salary e age DESC,<br/>imprimir schema e converter para lista de rows"]

    A["A ❌<br/>toPandas·· .values.toList·· funciona<br/>mas orderBy·desc·salary·· usa função desc·· errado"]
    B["B ❌<br/>schema·· não existe — é printSchema··<br/>toList·· não é método do DataFrame"]
    C["C ✅<br/>orderBy·col·salary·.desc··, col·age·.desc···<br/>.collect··<br/>printSchema··<br/>list comprehension com row.asDict··"]
    D["D ❌<br/>descending=True não é parâmetro válido<br/>describe·· não é printSchema··<br/>show·· retorna None"]

    ENUNCIADO --> A
    ENUNCIADO --> B
    ENUNCIADO --> C
    ENUNCIADO --> D

    style C fill:#4caf50,color:#fff,stroke:#2e7d32,stroke-width:3px
    style A fill:#ffebee,color:#c62828
    style B fill:#ffebee,color:#c62828
    style D fill:#ffebee,color:#c62828
    style ENUNCIADO fill:#e3f2fd,color:#1565c0
```

---

## Questão 5 — spark.sql.shuffle.partitions = 200

**Seção 1 — Arquitetura · Particionamento e Shuffling**

```mermaid
flowchart TB
    ENUNCIADO["Qual o impacto de configurar<br/>spark.sql.shuffle.partitions = 200?"]

    A["A ✅<br/>DataFrames serão divididos em 200 partições<br/>durante operações de shuffle"]
    B["B ❌<br/>Não tem relação com memória de 200 executors<br/>É sobre número de partições, não executors"]
    C["C ❌<br/>Não afeta TODOS os DataFrames<br/>Só os que passam por shuffle"]
    D["D ❌<br/>Spark não limita processamento às primeiras 200<br/>Todas as partições são processadas"]

    ENUNCIADO --> A
    ENUNCIADO --> B
    ENUNCIADO --> C
    ENUNCIADO --> D

    style A fill:#4caf50,color:#fff,stroke:#2e7d32,stroke-width:3px
    style B fill:#ffebee,color:#c62828
    style C fill:#ffebee,color:#c62828
    style D fill:#ffebee,color:#c62828
    style ENUNCIADO fill:#e3f2fd,color:#1565c0
```

---

## Questão 6 — Remover linhas com valores missing

**Seção 3 — DataFrame API · Deduplicação e Validação**

```mermaid
flowchart TB
    ENUNCIADO["Retornar novo DataFrame excluindo<br/>TODAS as linhas com pelo menos<br/>um valor missing em qualquer coluna"]

    A["A ❌<br/>na.drop·all· — remove só se TODOS<br/>os valores forem null, não 'pelo menos um'"]
    B["B ❌<br/>na.drop·subset=sqft· — remove apenas<br/>baseado na coluna sqft, não em todas"]
    C["C ✅<br/>na.drop·· — sem parâmetros,<br/>default how=any remove linhas<br/>com qualquer null"]
    D["D ❌<br/>dropna·all· — mesmo que A,<br/>remove só se todos forem null"]

    ENUNCIADO --> A
    ENUNCIADO --> B
    ENUNCIADO --> C
    ENUNCIADO --> D

    style C fill:#4caf50,color:#fff,stroke:#2e7d32,stroke-width:3px
    style A fill:#ffebee,color:#c62828
    style B fill:#ffebee,color:#c62828
    style D fill:#ffebee,color:#c62828
    style ENUNCIADO fill:#e3f2fd,color:#1565c0
```

---

## Questão 7 — Deployment mode com single node

**Seção 6 — Spark Connect · Deployment Modes**

```mermaid
flowchart TB
    ENUNCIADO["Qual modo de deploy requer que todos<br/>os executors rodem em um único worker node?"]

    A["A ❌<br/>Cluster mode — driver roda no cluster<br/>mas executors ficam em múltiplos workers"]
    B["B ✅<br/>Local mode — tudo roda em uma<br/>única JVM na mesma máquina"]
    C["C ❌<br/>Client mode — driver roda na máquina cliente<br/>mas executors ficam distribuídos no cluster"]
    D["D ❌<br/>Standard mode — não existe<br/>esse modo no Spark"]

    ENUNCIADO --> A
    ENUNCIADO --> B
    ENUNCIADO --> C
    ENUNCIADO --> D

    style B fill:#4caf50,color:#fff,stroke:#2e7d32,stroke-width:3px
    style A fill:#ffebee,color:#c62828
    style C fill:#ffebee,color:#c62828
    style D fill:#ffebee,color:#c62828
    style ENUNCIADO fill:#e3f2fd,color:#1565c0
```

---

## Questão 8 — Streaming vs Batch DataFrames

**Seção 5 — Structured Streaming · Conceitos**

```mermaid
flowchart TB
    ENUNCIADO["Calcular métricas rolling em tempo real<br/>de clickstream: avg session duration 1h,<br/>top 10 products 15min, atualizar a cada 2min.<br/>Por que usar Streaming DataFrames?"]

    A["A ❌<br/>Streaming não é automaticamente mais rápido<br/>para dados históricos — batch pode ser melhor"]
    B["B ✅<br/>Processamento contínuo com atualizações<br/>incrementais — não reprocessa tudo a cada 2min"]
    C["C ❌<br/>Error handling não é a vantagem principal<br/>e 'network recovery mechanism' não existe"]
    D["D ❌<br/>Streaming NÃO usa mais memória por design<br/>e a premissa da resposta está errada"]

    ENUNCIADO --> A
    ENUNCIADO --> B
    ENUNCIADO --> C
    ENUNCIADO --> D

    style B fill:#4caf50,color:#fff,stroke:#2e7d32,stroke-width:3px
    style A fill:#ffebee,color:#c62828
    style C fill:#ffebee,color:#c62828
    style D fill:#ffebee,color:#c62828
    style ENUNCIADO fill:#e3f2fd,color:#1565c0
```

---

## Questão 9 — UDF sem stateful operators

**Seção 3 — DataFrame API · UDFs**

```mermaid
flowchart TB
    ENUNCIADO["App de streaming com validação customizada<br/>sem funções built-in disponíveis.<br/>Job stateless, escala horizontal,<br/>sem manter histórico de cliente.<br/>Quando usar UDF SEM stateful operators?"]

    A["A ❌<br/>Running totals + histórico = precisa de state<br/>Contradiz o requisito stateless"]
    B["B ❌<br/>Windowed aggregations com updates incrementais<br/>= precisa manter estado entre batches"]
    C["C ❌<br/>Detectar padrões de sessão rastreando sequências<br/>= precisa de state entre eventos"]
    D["D ✅<br/>Aplicar lógica custom sem depender<br/>de dados anteriores — cada transação<br/>é independente = stateless"]

    ENUNCIADO --> A
    ENUNCIADO --> B
    ENUNCIADO --> C
    ENUNCIADO --> D

    style D fill:#4caf50,color:#fff,stroke:#2e7d32,stroke-width:3px
    style A fill:#ffebee,color:#c62828
    style B fill:#ffebee,color:#c62828
    style C fill:#ffebee,color:#c62828
    style ENUNCIADO fill:#e3f2fd,color:#1565c0
```

---

## Questão 10 — approx_count_distinct vs count(distinct)

**Seção 3 — DataFrame API · Agregações**

```mermaid
flowchart TB
    ENUNCIADO["Dashboard com 50M registros de atividade.<br/>Total de eventos + contagem de usuários únicos por tempo.<br/>Atualiza a cada hora. Aceita 2-3% de margem de erro.<br/>Por que usar approx_count_distinct?"]

    A["A ❌<br/>NÃO é mais preciso — é menos preciso<br/>A vantagem é performance, não acurácia"]
    B["B ❌<br/>Tratamento de nulls não é a diferença<br/>Ambas funções lidam com nulls"]
    C["C ✅<br/>Usa HyperLogLog — algoritmo probabilístico<br/>que evita shuffle custoso<br/>Performance muito superior em escala"]
    D["D ❌<br/>Não armazena em formato comprimido<br/>A economia é no algoritmo, não na compressão"]

    ENUNCIADO --> A
    ENUNCIADO --> B
    ENUNCIADO --> C
    ENUNCIADO --> D

    style C fill:#4caf50,color:#fff,stroke:#2e7d32,stroke-width:3px
    style A fill:#ffebee,color:#c62828
    style B fill:#ffebee,color:#c62828
    style D fill:#ffebee,color:#c62828
    style ENUNCIADO fill:#e3f2fd,color:#1565c0
```

---

## Gabarito Rápido

```mermaid
flowchart LR
    Q1["Q1 → D"] --> Q2["Q2 → C"] --> Q3["Q3 → A"] --> Q4["Q4 → C"] --> Q5["Q5 → A"]
    Q5 --> Q6["Q6 → C"] --> Q7["Q7 → B"] --> Q8["Q8 → B"] --> Q9["Q9 → D"] --> Q10["Q10 → C"]

    style Q1 fill:#4caf50,color:#fff
    style Q2 fill:#4caf50,color:#fff
    style Q3 fill:#4caf50,color:#fff
    style Q4 fill:#4caf50,color:#fff
    style Q5 fill:#4caf50,color:#fff
    style Q6 fill:#4caf50,color:#fff
    style Q7 fill:#4caf50,color:#fff
    style Q8 fill:#4caf50,color:#fff
    style Q9 fill:#4caf50,color:#fff
    style Q10 fill:#4caf50,color:#fff
```

---

*Simulado baseado no Exam Guide oficial — Databricks Certified Associate Developer for Apache Spark (Oct 2025)*