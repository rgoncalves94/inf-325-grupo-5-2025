# Sobre

Este projeto configura um ambiente de desenvolvimento combinando o uso de mariadb, mongodb e redis no Jupyter Lab. Desta forma, é possível executar os notebooks com os comandos necessários para criar as bases de dados e também executar consultas.

# Dependencias

- docker
- docker-compose

# Instalação

## MacOS

### Caso não tenha o docker e docker-compose instalados
```sh
brew install docker docker-compose
```

# Clone o projeto

```sh

git clone git@github.com:rgoncalves94/inf-325-grupo-5-2025.git

# ou

git clone https://github.com/rgoncalves94/inf-325-grupo-5-2025.git

cd inf-325-grupo-5
```

# Como executar?

```sh
docker compose up --build
```

# Acessando o Jupyter LAB

## Via navegador

Abra no navegador a URL [http://localhost:8888/lab](http://localhost:8888/lab)

```sh
open http://localhost:8888/lab
```

## Via VSCode

[Acessar tutorial: Connect VS Code Jupyter notebook to a Jupyter container](https://medium.com/@FredAsDev/connect-vs-code-jupyter-notebook-to-a-jupyter-container-a63293f29325)

## Diretório /notebooks

Este diretório contém todos os notebooks que devem ser utilizados para criar as bases.

**Importante:** O ambiente docker foi configurado para transformar o diretorio em um **volume**. Sendo possível utilizar a interface web do jupyter lab para realizar as modificações necessárias sem a necessidade de baixar arquivos manualmente e atualizar na base de código. Uma vez finalizada as alterações, basta salvar dentro do jupyter.

Não esqueça de realizar o commit das modificações caso tenha alterado os arquivos da pasta.

# Imagens utilizadas

- https://hub.docker.com/_/mariadb
- https://hub.docker.com/_/redis
- https://hub.docker.com/r/mongodb/mongodb-community-server