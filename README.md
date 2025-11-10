# Repositório da Trilha de Databricks da Jornada de Dados

Este repositório contém os materiais e exercícios práticos da **Trilha de Databricks da Jornada de Dados**, uma formação completa que cobre desde os fundamentos da plataforma até a implementação de um Data Warehouse completo seguindo o padrão Bronze → Silver → Gold.

## Aulas Realizadas

| Aula | Duração | Tópico Principal | Conteúdo Abordado |
|------|---------|------------------|-------------------|
| **Aula 01** | 1h | Setup Databricks | Introdução à plataforma e criação da contra Free |
| **Aula 02** | 1h | Databricks Fundamentals | Conceitos fundamentais da plataforma, interface, clusters e notebooks |
| **Aula 03** | 1h | Unity Catalog | Governança de dados, catálogo unificado, schemas, tabelas e volumes |
| **Aula 04** | 1h | Lakeflow Connect | Ingestão de dados, conectores, volumes, Auto Loader e pipelines DLT |
| **Aula 05** | 1h | Lakeflow Jobs | Orquestração de workflows, DAGs, triggers, dependências e observabilidade |
| **Aula 06** | 4h | Modelagem de Dados | Workshop completo: arquitetura Bronze/Silver/Gold, SCD Type 2, tabelas fato/dimensão, views analíticas |

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
