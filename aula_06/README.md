# 🧠 Aula 06 — Spark Declarative Pipelines (SDP)

### *Parte Teórica – Sem Código*

## 📌 1. O que são Spark Declarative Pipelines?

Spark Declarative Pipelines (SDP) são a nova abordagem da Databricks para construção de pipelines de dados de maneira **declarativa**, simplificando a forma como engenheiros criam, operam e escalam pipelines batch e streaming.

Eles são a evolução do antigo **Delta Live Tables**, agora integrados ao ecossistema do **Lakeflow**, unificando ingestão, transformação, governança e orquestração dentro da Data Intelligence Platform.

A ideia central é simples:

### *Você declara o que o pipeline precisa fazer e o Databricks cuida do resto.*

---

## 📌 2. Por que Spark Declarative Pipelines existem?

As imagens reforçam que pipelines tradicionais sofrem com:

### ❌ Desenvolvimento trabalhoso

* Muito código boilerplate
* Criação manual de roteiros, triggers, capturas de erros e checkpoints

### ❌ Complexidade operacional

* Alto custo para manter
* Dificuldade em orquestrar tarefas
* Fragilidade em caso de falhas

### ❌ Workloads isolados

* Lógica separada para batch e streaming
* Arquitetura duplicada e difícil de manter

Essas limitações levam a:

* Pipelines lentos
* Alto custo operacional
* Baixa flexibilidade

---

## 📌 3. A proposta das Declarative Pipelines

A visão da Databricks é clara:

### ✔ *SDP tornam pipelines confiáveis mais fáceis de construir e operar.*

Isso acontece porque grande parte da “infraestrutura invisível” é assumida automaticamente pelo sistema:

* Controle de versão
* Qualidade dos dados
* Governança
* Infraestrutura de deploy
* Particionamento
* Checkpointing & retries
* Gerenciamento de dependências
* Data discovery

Tudo isso é automático.

Assim, o foco do engenheiro passa a ser apenas:

### 👉 **A lógica de transformação**

Nada mais.

---

## 📌 4. Benefícios principais das Declarative Pipelines

### **🔹 1. Simplificação radical na criação de pipelines**

* Você declara entradas e saídas
* O Databricks cria a infraestrutura necessária
* Funciona tanto para batch quanto para streaming

### **🔹 2. Otimizações automáticas no nível do cluster**

* Escalonamento automático
* Recuperação de falhas
* Menos retrabalho manual
* Redução de custos

### **🔹 3. Batch e streaming unificados**

A mesma definição funciona para:

* Workloads em lote
* Workloads em streaming
* Materialized views
* Incremental processing

Isso reduz drasticamente pipelines duplicados.

### **🔹 4. Operação mais confiável**

* Dados com níveis de qualidade Bronze → Silver → Gold
* Pipelines autogerenciáveis
* Lineage e governança via Unity Catalog

### **🔹 5. Desenvolvimento acelerado**

* Menos boilerplate
* Menos dependência em notebooks gigantes
* Melhor manutenção

---

## 📌 5. Como criar uma Declarative Pipeline (visão teórica)

A criação pode ser feita de duas maneiras (mostradas nas imagens):

### **Opção 1 — Pelo Workspace**

* Clique no menu de contexto
* Selecione *Create → ETL Pipeline*

### **Opção 2 — Pelo menu Jobs & Pipelines**

* Vá em *Jobs & Pipelines*
* Clique em *Create*
* Escolha *ETL Pipeline*

O Databricks então abre a interface dedicada, onde o usuário define:

* Nome da pipeline
* Local das tabelas
* Configurações de cluster
* Estratégias de processamento

---

## 📌 6. Pipeline Declarativo na arquitetura Medallion

As imagens reforçam como o SDP opera naturalmente no modelo Bronze → Silver → Gold.

### **Bronze**

* Tabelas de ingestão
* Raw data
* Entrada em streaming ou batch

### **Silver**

* Dados limpos
* Normalizados
* Com governança e qualidade aplicada

### **Gold**

* Agregações de negócio
* Métricas
* Materialized views
* Bases para BI, AI e Analytics

O SDP:

* Controla o fluxo incremental automaticamente
* Identifica novos arquivos (file 1, file 2…)
* Processa apenas o que mudou
* Mantém histórico e atomicidade

---

## 📌 7. Incremental Processing

Um ponto muito importante:

### **Spark Declarative Pipelines processam dados incrementalmente por padrão.**

Isso significa:

* A cada execução, apenas novos dados são processados
* Tabelas Bronze e Silver funcionam como tabelas de streaming
* Gold funciona como visão materializada (materialized view)

E tudo isso é otimizado automaticamente no Serverless.

---

## 📌 8. Conexão com fontes de dados (Lakeflow Connect)

Outra parte da teoria crucial:

Declarative Pipelines podem receber dados de:

* **Cloud Storage** (S3, ADLS, GCS)
* **Message Queues** (Kafka, Pub/Sub, Kinesis)
* **Databases** (SQL Server, PostgreSQL, etc.)
* **SaaS** (Salesforce, Workday, etc.)

O Lakeflow Connect fornece conectores otimizados com:

* Auto-inferência
* Auto-schema
* Auto-refresh
* Retry e controle de offset

---

## 📌 9. Onde o SDP se encaixa na Data Intelligence Platform

Resumindo tudo:

* **Governança:** Unity Catalog
* **Armazenamento:** Delta Lake / Parquet / Iceberg
* **Execução:** Spark + Structured Streaming
* **Ingestão:** Lakeflow Connect
* **Transformação:** Spark Declarative Pipelines
* **Orquestração:** Lakeflow Jobs

Tudo dentro de um ecossistema unificado que reduz custo, complexidade e esforço de manutenção.

---

## 📌 10. O papel do engenheiro de dados com SDP

Com a introdução dos SDP, o papel muda:

### Antigo estilo

* Engenheiro escrevia tudo à mão
* Precisava cuidar de falhas
* Ajustava manualmente cluster e otimizações
* Tratava batch e streaming como mundos separados

### Novo estilo

* Engenheiro **declara o pipeline**
* O Databricks cuida da infraestrutura
* Qualidade, lineage e reprocessamento são automáticos
* O foco vira **modelagem, governança e valor de negócio**

---

# 🎯 **Conclusão da Aula Teórica**

Spark Declarative Pipelines representam a nova forma de construir ETL dentro da arquitetura Lakehouse. Eles simplificam todo o processo:

* Menos manutenção
* Menos custo
* Menos retrabalho
* Mais performance
* Mais confiabilidade

E principalmente:

### 👉 **Você foca no valor — o Databricks foca na engenharia.**

---

## 🛠️ Parte Prática — Pipeline DLT

## 📋 Objetivo

Recriar o pipeline da **Aula 05** usando **Spark Declarative Pipelines (DLT)**, demonstrando como a mesma lógica pode ser implementada de forma mais simples e declarativa.

## 📊 Datasets Utilizados

Esta aula utiliza os **mesmos datasets da Aula 05**:

* `customers.csv` - Dados de clientes
* `policies.csv` - Dados de apólices
* `claims.csv` e `claims_02.csv` - Dados de sinistros

**Localização dos dados:** `/Volumes/smart_claims_dev/00_landing/sql_server/`

Os dados estão organizados em pastas separadas:
* `customers/` - Pasta com arquivos CSV de customers
* `policies/` - Pasta com arquivos CSV de policies
* `claims/` - Pasta com arquivos CSV de claims (claims.csv, claims_02.csv, etc.)

> 💡 **Nota:** Os datasets devem estar disponíveis no volume configurado na Aula 05. Se necessário, execute os notebooks de setup da Aula 05 antes de iniciar esta aula.

## 📁 Estrutura de Schemas

O pipeline utiliza a seguinte estrutura de schemas no Unity Catalog:

* **`00_landing`** - Volume com arquivos CSV brutos (fonte dos dados)
* **`01_bronze`** - Tabelas bronze com dados brutos ingeridos
* **`02_silver`** - Tabelas silver com dados limpos e enriquecidos
* **`03_gold`** - Views materializadas gold com métricas e agregações

Todos os códigos referenciam explicitamente os schemas completos no formato: `smart_claims_dev.{schema}.{tabela}`

## 🏗️ Estrutura do Pipeline DLT

O pipeline está organizado na pasta `pipeline_lakeflow/transformations/` seguindo a arquitetura Medallion:

### 📦 Camada Bronze (Ingestão)

Todas as tabelas bronze usam **CREATE OR REFRESH TABLE** com ingestão batch:

1. **`01_bronze_customers.sql`** - Ingestão de dados de customers usando `read_files()` com pasta `customers/`
2. **`02_bronze_policies.sql`** - Ingestão de dados de policies usando `read_files()` com pasta `policies/`
3. **`03_bronze_claims.sql`** - Ingestão de dados de claims usando `read_files()` com pasta `claims/` (processa todos os arquivos da pasta)

**Características:**
* Cada pasta é ingerida separadamente preservando a organização dos arquivos
* Usa apenas o caminho da pasta (não precisa especificar o nome do arquivo)
* O `read_files()` processa automaticamente todos os arquivos CSV dentro de cada pasta
* Processamento batch com `CREATE OR REFRESH` para reprocessamento automático

### ✨ Camada Silver (Transformação e Limpeza)

A camada silver usa **CREATE OR REFRESH TABLE**:

1. **`04_silver_claims_enriched.sql`** - Enriquecimento de claims através de joins diretos com policies e customers

**Características:**
* Processamento batch com lógica de transformação
* Joins diretos entre tabelas bronze usando endereços completos (`smart_claims_dev.01_bronze.*`)
* Referências explícitas aos schemas completos para maior clareza

### 🏆 Camada Gold (Agregações e Métricas)

A camada gold usa **MATERIALIZED VIEW** para agregações otimizadas:

1. **`05_gold_claims_metrics.sql`** - View materializada com métricas agregadas usando endereço completo da tabela silver

**Características:**
* Agregações otimizadas automaticamente
* Atualização incremental quando possível
* Consultas rápidas para BI e Analytics

## 🔄 Comparação: Aula 05 vs Aula 06

| Aspecto | Aula 05 (Lakeflow Jobs) | Aula 06 (DLT) |
|---------|------------------------|---------------|
| **Sintaxe** | `CREATE TABLE ... AS SELECT` | `CREATE OR REFRESH TABLE` (Bronze/Silver) e `MATERIALIZED VIEW` (Gold) |
| **Orquestração** | Lakeflow Jobs com múltiplas tasks | Pipeline único declarativo |
| **Transformação** | Joins manuais entre tabelas | Joins declarativos entre tabelas bronze |
| **Dependências** | Gerenciadas manualmente no Job | Gerenciadas automaticamente pelo DLT |
| **Reprocessamento** | DROP TABLE manual antes de recriar | `CREATE OR REFRESH` automático |
| **Ingestão** | Caminhos específicos por arquivo CSV | Caminhos específicos por arquivo CSV (preserva nomes) |
| **Manutenção** | Múltiplos arquivos e configurações | Pipeline único e declarativo |
| **Bronze** | Tabelas batch com DROP/CREATE | Tabelas batch com CREATE OR REFRESH |
| **Silver** | Tabelas batch | Tabelas batch com CREATE OR REFRESH |
| **Gold** | Views estáticas | MATERIALIZED VIEW com otimizações automáticas |

## 🚀 Como Executar o Pipeline

### Pré-requisitos

1. ✅ Ter executado a **Aula 05** para configurar:
   * Catálogo e schemas (bronze, silver, gold)
   * Volume com os datasets
   * Estrutura básica do Unity Catalog

2. ✅ Acessar o workspace Databricks com permissões para:
   * Criar pipelines DLT
   * Ler volumes
   * Criar tabelas nos schemas configurados

### Passos para Execução

1. **Acesse a pasta `pipeline_lakeflow/transformations/`**

2. **Execute os arquivos na ordem:**
   * Use `Run file` para testar cada transformação individualmente
   * Use `Run pipeline` para executar todo o pipeline de uma vez

3. **Catálogo e Schemas:**
   * **Catálogo:** `smart_claims_dev`
   * **Schemas:** `01_bronze`, `02_silver`, `03_gold`
   * Todos os códigos referenciam explicitamente: `smart_claims_dev.{schema}.{tabela}`

4. **Monitore a execução:**
   * Acompanhe o progresso na interface do DLT
   * Verifique as tabelas criadas no Unity Catalog
   * Consulte a view `smart_claims_dev.03_gold.claims_metrics` para validar os resultados

## 📈 Resultados Esperados

Após a execução do pipeline, você terá:

* ✅ **Schema `01_bronze`:** 3 tabelas (customers, policies, claims)
* ✅ **Schema `02_silver`:** 1 tabela (claims_enriched)
* ✅ **Schema `03_gold`:** 1 view materializada (claims_metrics)

Todas as tabelas estarão disponíveis no Unity Catalog e podem ser consultadas normalmente via SQL usando a referência completa: `smart_claims_dev.{schema}.{tabela}`

## 💡 Vantagens do DLT Demonstradas

1. **Simplicidade:** Menos código, mesma funcionalidade
2. **Manutenibilidade:** Pipeline único e declarativo
3. **Confiabilidade:** Gerenciamento automático de dependências
4. **Performance:** Reprocessamento eficiente com `CREATE OR REFRESH`
5. **Governança:** Integração nativa com Unity Catalog
6. **Preservação de Arquivos:** Cada CSV é ingerido separadamente preservando os nomes dos arquivos
7. **Otimizações Automáticas:** MATERIALIZED VIEW na camada Gold com agregações otimizadas
8. **Reprocessamento Automático:** `CREATE OR REFRESH` permite reprocessar dados sem DROP manual

## 🔍 Explorando o Pipeline

Use a pasta `explorations/` para criar notebooks ad-hoc e explorar os dados processados pelo pipeline. Exemplo:

```sql
-- Explorar dados bronze
SELECT * FROM smart_claims_dev.01_bronze.customers LIMIT 10;

-- Verificar total de registros
SELECT COUNT(*) FROM smart_claims_dev.01_bronze.claims;
SELECT COUNT(*) FROM smart_claims_dev.02_silver.claims_enriched;

-- Consultar métricas
SELECT * FROM smart_claims_dev.03_gold.claims_metrics;
```

---

# 📚 **Recursos Adicionais**

* [Documentação DLT](https://docs.databricks.com/dlt/)
* [Sintaxe SQL Reference DLT](https://docs.databricks.com/dlt/sql-ref.html)
* [Best Practices DLT](https://docs.databricks.com/dlt/best-practices.html)
