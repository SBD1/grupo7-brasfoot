# Sobre
Este documento tem a inteção de servir como Wiki do projeto Brasfoot, na
matéria Sistema de Bancos de Dados 1, Universidade de Brasília, Faculdade
do Gama, semestre letivo 2022.1.

### Link da Wiki
[Wiki Brasfoot SBD 2022.1](https://sbd1.github.io/grupo7-brasfoot/)

## Brasfoot
No Brasfoot você comanda um time de futebol, compra e vende jogadores,
define o preço dos ingressos, escolhe as táticas e participa dos campeonatos
que simulam a realidade. O jogo é super leve, e várias temporadas podem
ser jogadas de forma rápida e divertida!

# Integrantes
Abaixo segue tabela com os integrantes do projeto e as suas reespectivas informações:

|        | <img src="docs/images/paulo.jpeg" alt="drawing" style="border-radius: 50%" width="200"/> | <img src="docs/images/daniel.jpg" alt="drawing" style="border-radius: 50%" width="200"/> | <img src="docs/images/matheus.jpeg" alt="drawing" style="border-radius: 50%" width="200"/> |
|--------|:----------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------:|
| Nome   |                                      Paulo Gontijo                                       |                                        Daniel Oda                                        |                                     Matheus Clementes                                      |
| Github |                   [paulohgontijoo](https://github.com/paulohgontijoo)                    |                        [danieloda](https://github.com/danieloda)                         |                   [matheusclemente](https://github.com/matheusclemente)                    |

# Instruções para executar o Brasfoot
## Pré-requisitos
O nosso app, Brasfoot, foi criado usando Docker, ou seja, de forma conteinerizada. Dessa forma, garante-se
que, uma vez que o Docker e Docker-compose for instalado corretamente em qualquer máquina, a aplicação também funcionará.
Portanto, os pré-requisitos para executar o aplicativo são o Docker e o Docker-compose. Segue o link de instalação oficial
dos mesmos:

- [Docker](https://docs.docker.com/desktop/)
- [Docker-compose](https://docs.docker.com/compose/install/compose-desktop/)

## Executar o APP
Uma vez finalizada as devidas intalações mencionadas acima, estamos prontos para executar o app Brasfoot, de forma simples 
e fácil. Vá ao diretório **grupo7-brasfoot/app/** e execute o comando a seguir:

```shell
docker compose up
```

Caso encontre algum problema para inicializar o container da aplicação, execute os comandos com a adição de alguns parâmetros,
conforme mostra os blocos de código abaixo:

```shell
docker compose down --volumes
```

Em seguida:

```shell
docker compose up --remove-orphans --build --always-recreate-deps
```

## Conectar ao Banco de Dados
Ao executar o comando *docker compose up*, a aplicação ficará disponível na porta 5432 do seu computador, ou seja, no *localhost*.
Com isso, é possível se conectar com o banco de dados através de um sistema gerenciador de bancos de dados (SGBD) de sua preferência.
No nosso exemplo foi usado uma *feature* do PyCharm, mas existem diversos outros. O SGBD oficial do **Postgres** é o
**pgAdmin 4**, você pode instalá-lo facilmente por este [link aqui](https://www.pgadmin.org/download/).

Os parâmetros de conexão com o banco são mostrados a seguir:

* **Host:** localhost (0.0.0.0)
* **Porta:** 5432
* **Método de autenticação:** Usuário e senha
* **Usuário:** postgres
* **Senha:** postgres
* **Database:** postgres

![img_1.png](docs/images/postgres-connection.png)
