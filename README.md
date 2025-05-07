# Infraestrutura: Docker Compose

Este repositório contém a orquestração Docker Compose para desenvolvimento local dos microsserviços:

- **pedido-service**  
  https://github.com/Augusto-Pellizzari/act-pedido-service  
- **pagamento-service**  
  https://github.com/Augusto-Pellizzari/act-pagamento-service  

## Tecnologias utilizadas

- RabbitMQ para gerenciar as mensagens (broker)  
- PostgreSQL como banco de dados  

## Pré-requisitos

- Docker & Docker Compose  
- Git  
- Os projetos devem estar clonados nos caminhos:

D:\Projetos\VISUAL-SPRING\pedido-service  
D:\Projetos\VISUAL-SPRING\pagamento-service  

## Estrutura

```
infrastructure-docker-compose/
├── docker-compose.yml       # define containers: postgres, rabbitmq, pedidos e pagamentos
├── initdb/
│   └── 00-schema.sql        # cria tabelas pedidos e pagamentos no Postgres
└── README.md                # este guia de uso
```

## 1. Clonar este repositório

```bash
cd D:\Projetos\VISUAL-SPRING
git clone https://github.com/Augusto-Pellizzari/infrastructure-docker-compose.git docker-compose
cd docker-compose
```

## 2. Estrutura dos serviços

Dentro do `docker-compose.yml` configuramos:

- **loja-postgres**: contêiner PostgreSQL inicializa o banco e executa `initdb/00-schema.sql`  
- **rabbitmq**: contêiner RabbitMQ com painel de gerenciamento em http://localhost:15672  
- **pedido-service**: constrói e executa a partir de `../pedido-service/Dockerfile` na porta **8080**  
- **pagamento-service**: constrói e executa a partir de `../pagamento-service/Dockerfile` na porta **8081**

## 3. Subir os containers

```bash
docker-compose up -d --build
```

Esse comando irá:

1. Criar a rede `backend` e o volume `postgres-data`  
2. Construir as imagens dos microsserviços  
3. Iniciar os contêineres do Postgres, RabbitMQ e dos serviços

## 4. Verificar status

```bash
docker ps
```

Você deve ver os contêineres `loja-postgres`, `rabbitmq`, `pedido-service` e `pagamento-service` como `Up (healthy)`

Para acompanhar logs:

```bash
docker logs -f loja-postgres
# ou
docker logs -f rabbitmq
```

## 5. Testar as APIs via Postman (ou outra ferramenta REST)

### 5.1 Criar um pedido

**POST** http://localhost:8080/api/pedidos  
**Content-Type**: application/json

```json
{
  "cliente": "José da Silva"
}
```

**Resposta esperada:**

```json
{
  "id": 1,
  "cliente": "José da Silva",
  "status": "AGUARDANDO_PAGAMENTO",
  "dataCriacao": "2025-05-07T..."
}
```

### 5.2 Listar pedidos

**GET** http://localhost:8080/api/pedidos

### 5.3 Confirmar pagamento

**POST** http://localhost:8081/api/pagamentos/confirmar  
**Content-Type**: application/json

```json
{
  "pedidoId": 1,
  "status": "CONFIRMADO"
}
```

Ou usando o endpoint PUT:

**PUT** http://localhost:8081/api/pagamentos/1/status?status=CONFIRMADO

## 6. Parar e limpar tudo

```bash
docker-compose down -v
```

Isso irá parar os contêineres e remover o volume, apagando todos os dados.
