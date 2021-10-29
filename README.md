# Template pipeline
[![Publish Docs](https://github.com/Varstation/pipeline-template/actions/workflows/publish.yml/badge.svg?branch=main)](https://github.com/Varstation/pipeline-template/actions/workflows/publish.yml)

[![Continuous Integration](https://github.com/Varstation/pipeline-template/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/Varstation/pipeline-template/actions/workflows/ci.yml)

[![Latest Release](https://img.shields.io/github/v/release/Varstation/pipeline-template?include_prereleases)](https://github.com/Varstation/pipeline-template/releases)

Este repositório contém um workflow de pipeline em WDL usado como referência para construir outros pipelines de bioinformática.
Descreva aqui nesta seção o objetivo claro do que seu pipeline deverá executar.

Este pipeline **hellopipeline.wdl** irá receber com um arquivo texto em formato txt e irá resultar em imprimir na tela o text escrito no arquivo texto.


## Documentacao


### Check de estilo de código

Para estilo de código, basta rodar o comando:

```
sh tools/lint.sh
```

### Release

Para criar uma release basta rodar o comando abaixo:

```
sh release.sh 
```

Alguns exemplos a seguir:

    Start release candidate     $ release -p patch       1.0.1-rc.0
    Added fixes, update RC      $ release -p build       1.0.1-rc.1
    Add More fixes              $ release -p build       1.0.1-rc.2
    Release                     $ release -p release     1.0.1

### Testes
Para executar os testes basta rodar o comando:

```
sh test.sh tag_release
```

## Sobre
Este workflow é parte da organização [Varstation](https://github.com/varstation/) e desenvolvido pelo time do Hospital Israelita Albert Einstein.
## Contato
<p>
  <!-- Obscure e-mail address for spammers -->
Para qualquer duvida relacionada ao pipeline, use nosso meio de contato pelo github
<a href="https://github.com/Varstation/pipeline-template/issues">github issue tracker</a>.
</p>