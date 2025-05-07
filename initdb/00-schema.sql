-- 00-schema.sql

CREATE TABLE IF NOT EXISTS public.pedidos (
  id            SERIAL PRIMARY KEY,
  cliente       VARCHAR(100) NOT NULL,
  status        VARCHAR(30)  NOT NULL,
  data_criacao  TIMESTAMP     NOT NULL
);

CREATE TABLE IF NOT EXISTS public.pagamentos (
  id             SERIAL PRIMARY KEY,
  pedido_id      INTEGER NOT NULL REFERENCES public.pedidos(id),
  status         VARCHAR(20)  NOT NULL,
  criado_em      TIMESTAMPTZ  NOT NULL,
  confirmado_em  TIMESTAMPTZ,
  correlation_id VARCHAR(36)  UNIQUE
);