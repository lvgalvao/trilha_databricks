# pipeline_lakeflow

Esta pasta define todo o código-fonte do pipeline 'pipeline_lakeflow':

- `explorations`: Notebooks ad-hoc usados para explorar os dados processados por este pipeline.
- `transformations`: Todas as definições de datasets e transformações.

## Como Começar

Para começar, vá para a pasta `transformations` -- a maior parte do código-fonte relevante está lá:

- Por convenção, cada dataset em `transformations` está em um arquivo separado.
- Dê uma olhada nos exemplos para se familiarizar com a sintaxe.
  Leia mais sobre a sintaxe em [Documentação SQL DLT](https://docs.databricks.com/dlt/sql-ref.html).
- Use `Run file` para executar e visualizar uma única transformação.
- Use `Run pipeline` para executar _todas_ as transformações do pipeline inteiro.
- Use `+ Add` no navegador de arquivos para adicionar uma nova definição de dataset.
- Use `Schedule` para executar o pipeline em um agendamento!

Para mais tutoriais e material de referência, consulte [Documentação DLT](https://docs.databricks.com/dlt).
