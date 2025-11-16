# Repositório da Trilha de Databricks da Jornada de Dados

Este repositório contém os materiais e exercícios práticos da **Trilha de Databricks da Jornada de Dados**, uma formação completa que cobre desde os fundamentos da plataforma até a implementação de um Data Warehouse completo seguindo o padrão Bronze → Silver → Gold.

## Aulas Realizadas

Claro — transformei todo o cronograma no **formato de tabela padronizada**, seguindo o modelo que você enviou.
Organizei em ordem cronológica e nomeei sequencialmente as aulas.

---

## ✅ **Tabela — Trilha Databricks (Semanas 43 a 51)**

| Aula                   | Duração | Tópico Principal                  | Conteúdo Abordado                                               |
| ---------------------- | ------- | --------------------------------- | --------------------------------------------------------------- |
| **Aula 01**            | 1h      | Setup Databricks                  | Configuração do Databricks Free Edition                         |
| **Aula 02**            | 1h      | Databricks Fundamentals           | Fundamentos da plataforma e visão geral                         |
| **Aula 03**            | 1h      | Unity Catalog                     | Governança, catálogos, schemas, tabelas e volumes               |
| **Aula 04**            | 1h      | Data Ingestion + Lakeflow Connect | Ingestão, conectores, volumes, Auto Loader                      |
| **Aula 05**            | 1h      | Lakeflow Jobs                     | Orquestração com Databricks Workflows                           |
| **Workshop 01** | 4h      | Modelagem de Dados                | Arquitetura medallion, SCD2, fatos, dimensões, views analíticas |
| **Aula 06**            | 1h      | Lakeflow Declarative Pipelines    | Pipelines declarativas com DLT                                  |
| **Aula 07**            | 1h      | Apache Spark I                    | Introdução ao Spark e conceitos fundamentais                    |
| **Aula 08**            | 1h      | Apache Spark II                   | Ingestão e aquisição de dados no Spark                          |
| **Aula 09**            | 1h      | Apache Spark III                  | Transformação, limpeza e qualidade de dados                     |
| **Aula 10**            | 1h      | Apache Spark IV                   | Performance e otimização no Databricks                          |
| **Aula 11**            | 1h      | Delta Lake Fundamentals           | Fundamentos e arquitetura Delta Lake                            |
| **Aula 12**            | 1h      | Monitoring & Alerting             | Monitoramento e alertas em pipelines                            |
| **Workshop 02** | 4h      | Mosaic AI & LLMs                  | Introdução ao Mosaic AI, LLMs e uso prático                     |
| **Aula 13**            | 1h      | Performance & Cost Optimization   | Otimização de performance e custos                              |
| **Aula 14**            | 1h      | Delta Sharing & Federation        | Data sharing e federated lakehouse                              |
| **Workshop 03** | 4h      | Ingestão com Erathos              | Pipelines de ingestão com Erathos                               |
| **Aula 15**            | 1h      | Databricks Asset Bundle           | Deploy, versionamento e bundles                                 |
| **Aula 16**            | 2h      | Lakeflow Project                  | Projeto prático: Lakeflow pipelines + DLT                       |

## 📊 Apresentações das Aulas

Links para as apresentações e materiais das aulas:

- **Boas-vindas**: [Apresentação Canva](https://www.canva.com/design/DAG3Inm_MD4/Rt28PeY86S7vYDMZel7J8g/view?utm_content=DAG3Inm_MD4&utm_campaign=designshare&utm_medium=link2&utm_source=uniquelinks&utlId=h44edc13f4e)
- **Aula 01 - Setup Databricks**: [Vídeo YouTube](https://youtu.be/KJv1bZ6-gSY?si=uDp2O7mu-5S5LXFf)
- **Aula 02 - Databricks Fundamentals**: [Apresentação Canva](https://www.canva.com/design/DAG2smFDVAk/szTX6l4QIOSv6DCZZMu_pA/view?utm_content=DAG2smFDVAk&utm_campaign=designshare&utm_medium=link2&utm_source=uniquelinks&utlId=h311113716d)
- **Aula 03 - Unity Catalog**: [Apresentação Canva](https://www.canva.com/design/DAG3Inm_MD4/Rt28PeY86S7vYDMZel7J8g/view?utm_content=DAG3Inm_MD4&utm_campaign=designshare&utm_medium=link2&utm_source=uniquelinks&utlId=h44edc13f4e)
- **Aula 04 - Data Ingestion**: [Apresentação Canva](https://www.canva.com/design/DAG3WX3R1yo/nquYSiypAaVnTQXCrc7zxw/view?utm_content=DAG3WX3R1yo&utm_campaign=designshare&utm_medium=link2&utm_source=uniquelinks&utlId=hc17ee0f17b)
- **Aula 05 - Lakeflow Jobs**: [Apresentação Canva](https://www.canva.com/design/DAG3znE1hbg/c4ZBh16Qisw4jNEvUaD5Bw/view?utm_content=DAG3znE1hbg&utm_campaign=designshare&utm_medium=link2&utm_source=uniquelinks&utlId=h342c9cdcd1)

## Estrutura do Repositório

O repositório está organizado da seguinte forma:

```text
trilha_databricks/
├── aula_01/          # Setup Databricks - Introdução e conceitos fundamentais
├── aula_02/          # Databricks Fundamentals
├── aula_03/          # Unity Catalog - Governança e catálogo unificado
│   ├── generate/     # Scripts para geração de dados de exemplo
│   └── notebooks/    # Notebooks práticos
├── aula_04/          # Lakeflow Connect - Ingestão de dados
│   ├── data/         # Dados de exemplo (CSV)
│   ├── notebooks/    # Notebooks de setup e ingestão
│   ├── dlt/          # Pipelines DLT (Delta Live Tables)
│   └── source_to_bronze/  # Scripts de ingestão
├── aula_05/          # Lakeflow Jobs - Orquestração
│   ├── data/         # Dados de exemplo
│   ├── notebooks/    # Notebooks de configuração
│   ├── source_to_bronze/  # Scripts de ingestão batch
│   ├── bronze_to_silver/ # Transformações Bronze → Silver
│   └── silver_to_gold/    # Transformações Silver → Gold
├── aula_06/          # Modelagem de Dados (Workshop)
│   ├── notebooks/    # Notebooks das camadas Bronze, Silver e Gold
│   ├── models/       # Modelos SQL (silver e gold)
│   ├── jobs/         # Definições de jobs (Databricks Asset Bundle)
│   └── tests/        # Testes e alertas de qualidade
├── utils/            # Utilitários e scripts auxiliares
│   └── datasets/     # Geradores de dados sintéticos
└── README.md         # Este arquivo
```

## Como Usar

Cada pasta de aula contém:

- **Notebooks**: Materiais práticos e exercícios para execução no Databricks
- **Scripts SQL/Python**: Códigos reutilizáveis para ingestão e transformação
- **Dados de exemplo**: Arquivos CSV, Parquet e outros formatos para prática
- **Documentação**: READMEs específicos com detalhes sobre objetivos, pré-requisitos e exemplos práticos

### Pré-requisitos

- Acesso a um workspace Databricks (Free Edition ou Trial)
- Conhecimento básico de SQL e Python
- Familiaridade com conceitos de ETL/ELT e modelagem de dados

### Ordem Recomendada de Estudo

1. **Aula 01**: Configure seu ambiente e entenda os conceitos fundamentais
2. **Aula 02**: Aprofunde-se nos recursos básicos da plataforma
3. **Aula 03**: Aprenda sobre governança com Unity Catalog
4. **Aula 04**: Pratique ingestão de dados com Lakeflow Connect
5. **Aula 05**: Automatize workflows com Lakeflow Jobs
6. **Aula 06**: Implemente um Data Warehouse completo do zero

## Recursos Adicionais

- **Repositórios de Referência (Aula 06)**:
  - [Workshop Modelagem de Dados - Repositório Oficial](https://github.com/alanceloth/workshop_modelagem_dados_databricks_ao_vivo)
  - [Workshop Modelagem de Dados - Aula ao Vivo](https://github.com/alanceloth/workshop_modelagem_dados_databricks)
