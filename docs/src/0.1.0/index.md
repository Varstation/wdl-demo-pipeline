---
layout: default
title: Home
---

Este pipeline usa vários programas para chamada de variantes e agregação dos resultados.
- Ferramenta A
- Ferramenta B

Este pipeline é parte do [Varstation][https://varstation.com/] desenvolvido pelo time de bioinformática no [Hospital Israelita Albert Einstein](https://einstein.br/)

## Como executar

Este pipeline pode executado usando [Cromwell](http://cromwell.readthedocs.io/en/stable/):

```bash
java -jar cromwell-<version>.jar run -i inputs.json hellopipeline.wdl
```
Este pipeline também pode ser executando o [Oliver](https://stjudecloud.github.io/oliver/) desenvolvido pelo St. Jude Cloud Team.

```bash
oliver submit hellopipeline.wdl inputs.json
```

### Inputs

Os Inputs de entrada são disponibilizados via arquivo. Os inputs obrigatórios são descritos abaixo
e o template contendo todos os inputs podem ser gerados por meio da ferramenta Womtool descrito em
[WOMtool documentation](http://cromwell.readthedocs.io/en/stable/WOMtool/).
Para uma visão geral de todas as entradas disponíveis, leia [esta página](./inputs.html).

```json
{
  "HelloPipeline.file": "A sample file with text contents"
}
```

Alguns inputs adicionais opcionais:

```json
{
  "HelloPipeline.optionalParameter": "Optional parameter here"
}
```

O diretório de saída deve ser configurado usndo o `options.json`. Visualize [a documentação cromwell](
https://cromwell.readthedocs.io/en/stable/wf_options/Overview/) para mais informações.

Exemplo de arquivo `options.json`:
```JSON
{
"final_workflow_outputs_dir": "my-analysis-output",
"use_relative_output_paths": true,
"default_runtime_attributes": {
  "docker_user": "$EUID"
  }
}
```

### Requisitos e versões de ferramentas
Os pipelines do Varstation usam imagens docker para garantir reproducibilidade. Isto significa que os pipelines irão executar em quaisquer arquiteturas que possuam o docker instalados.

Para mais informações sobre as configurações do docker, mais informações em [cromwell documentation on containers](
https://cromwell.readthedocs.io/en/stable/tutorials/Containers/).

As imagens de nosso projeto estão no nosso [repositório de containers](https://github.com/Varstation/containers)

### Output
Arquivos VCF para cada chamador de variantes e o arquivo de variantes combinado.
## Contato
<p>
Para qualquer dúvidas sobre executar este workflow ou requisições de features, por favor entre em contato com 
<a href='https://github.com/varstation/pipeline-template/issues'>github issue tracker</a>
</p>