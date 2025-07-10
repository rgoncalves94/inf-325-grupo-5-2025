# Dependencias

- docker
- docker-compose

# Instalação

## MacOS

### Caso não tenha o docker e docker-compose instalados
```sh
brew install docker docker-compose
```

# Como executar?

```sh
docker compose up --build
```

# Acessando o Jupyter LAB

Abra no navegador a URL [http://localhost:8888/lab](http://localhost:8888/lab)

```sh
open http://localhost:8888/lab
```

# Sobre

Este projeto configura um ambiente de desenvolvimento combinando o uso de mariadb, mongodb e redis no Jupyter Lab. Desta forma, é possível executar os notebooks com os comandos necessários para criar as bases de dados e também executar consultas.

## Diretório /notebooks

Este diretório contém todos os notebooks que devem ser utilizados para criar as bases.

**Importante:** O ambiente docker foi configurado para transformar o diretorio em um **volume**. Sendo possível utilizar a interface web do jupyter lab para realizar as modificações necessárias sem a necessidade de baixar arquivos manualmente e atualizar na base de código. Uma vez finalizada as alterações, basta salvar dentro do jupyter.

Não esqueça de realizar o commit das modificações caso tenha alterado os arquivos da pasta.

# Images
- https://hub.docker.com/_/mariadb
- https://hub.docker.com/_/redis
- https://hub.docker.com/r/mongodb/mongodb-community-server