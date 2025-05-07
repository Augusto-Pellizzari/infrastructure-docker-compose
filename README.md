# Infraestrutura: Docker Compose

Este repositório contém a orquestração Docker Compose para desenvolvimento local dos microsserviços:

- **pedido-service**  
  https://github.com/Augusto-Pellizzari/act-pedido-service  
- **pagamento-service**  
  https://github.com/Augusto-Pellizzari/act-pagamento-service

## Tecnologias utilizadas
- RabbitMq para gerenciar as mensagens (broker)
- PostgreSQL como banco de dados

## Pré-requisitos

- Docker & Docker Compose
- Git

## Estrutura

```text
.
├── docker-compose.yml       # define containers: postgres, rabbitmq, pedidos e pagamentos
└── initdb/
    └── 00-schema.sql        # cria tabelas pedidos e pagamentos no Postgres
