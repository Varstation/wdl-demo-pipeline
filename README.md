# Germline Varcall Dna Pipeline
[![Publish Docs](https://github.com/Varstation/wdl-demo-pipeline/actions/workflows/publish.yml/badge.svg?branch=main)](https://github.com/Varstation/wdl-demo-pipeline/actions/workflows/publish.yml)

[![Continuous Integration](https://github.com/Varstation/wdl-demo-pipeline/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/Varstation/wdl-demo-pipeline/actions/workflows/ci.yml)

[![Latest Release](https://img.shields.io/github/v/release/Varstation/wdl-demo-pipeline?include_prereleases)](https://github.com/Varstation/wdl-demo-pipeline/releases)

Este repositório contém o workflow em WDL para o pipeline de bioinformática de detecção de variantes germinativas a partir dos dados de sequenciamento de nova geração de sequenciadores Illumina.

```
Pipeline apenas para fins demonstrativos. Não usar este pipeline em produção!
```

Este pipeline **germline-varcall-dna.wdl** irá receber como parâmetros os arquivos paired-end FASTQs de uma amostra de DNA humana sequenciada e irá realizar as etapas de alinhamento das sequências de DNA a partir do genoma humano de referência hg19 nos cromossomos 17 e 19 com o alinhador BWA. O alinhamento gerado em formato BAM servirá como entrada para a chamada de variantes pela ferramenta Freebayes, gerando como output de saída o arquivo de saída de variantes em formato VCF.

## Documentacao
Documentação deste workflow pode ser encontrado [aqui](https://varstation.github.io/wdl-demo-pipeline/v1.0.0/index.html).
Documentation for this workflow can be

## Sobre
Este workflow é parte da organização [Varstation](https://github.com/varstation/) e desenvolvido pelo time do Hospital Israelita Albert Einstein.
## Contato
<p>
  <!-- Obscure e-mail address for spammers -->
Para qualquer duvida relacionada ao pipeline, use nosso meio de contato pelo github
<a href="https://github.com/Varstation/wdl-demo-pipeline/issues">github issue tracker</a>.
</p>