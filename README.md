# 🏨 Sistema de Gerenciamento de Hotéis

Este projeto foi desenvolvido com o objetivo de criar um **sistema de gerenciamento de hotéis**, permitindo o controle completo de hospedagens, reservas, quartos, funcionários e serviços oferecidos pelos hotéis.



## 📘 Aplicação

Nosso grupo optou por desenvolver um sistema voltado para o **gerenciamento de hotéis**, com foco em simplicidade, organização e boas práticas de banco de dados relacionais.



## ⚙️ Requisitos Funcionais

- O sistema deve permitir o **cadastro, edição, exclusão e listagem de hotéis**.  
- O sistema deve permitir o **cadastro de hóspedes**, incluindo dados pessoais e de contato.  
- O sistema deve permitir o **cadastro de funcionários** associados a um hotel.  
- O sistema deve permitir o **cadastro e gerenciamento de quartos**, vinculando-os a um hotel.  
- O sistema deve permitir que um hóspede **realize reservas de quartos disponíveis** em um período específico.  
- O sistema deve **verificar a disponibilidade dos quartos** antes de confirmar uma reserva.  
- O sistema deve permitir a **consulta de reservas** por hotel, hóspede ou período.  
- O sistema deve permitir que o funcionário **registre check-in e check-out** de um hóspede.  
- O sistema deve permitir o **cancelamento de reservas**, dentro de regras definidas (ex.: antes da data de entrada).  
- O sistema deve emitir **relatórios de ocupação**, listando quartos disponíveis e ocupados por período.  
- O sistema deve permitir **login e autenticação de funcionários** para acesso às funções administrativas.  
- O sistema deve enviar **notificações** (por e-mail ou internamente) ao hóspede confirmando ou alterando uma reserva.



## 🧱 Requisitos Não Funcionais

- O sistema deve utilizar **autenticação com criptografia básica** (hash de senha).  
- O sistema deve responder a operações comuns (cadastros, reservas) em **menos de 3 segundos**.  
- O sistema deve realizar **backup diário automático** do banco de dados.  
- O sistema deve ser **acessível via web**, compatível com os principais navegadores.  
- O sistema deve ter **controle de acesso por perfil de usuário** (admin, funcionário, hóspede).  
- O sistema deve armazenar dados em um **banco relacional seguro**.



## 📋 Regras de Negócio

1. Um quarto só pode estar vinculado a **um hotel**.  
2. Um quarto não pode ser **reservado por dois hóspedes no mesmo período**.  
3. Um hóspede não pode ter **duas reservas ativas no mesmo hotel e na mesma data**.  
4. A **data de entrada** deve ser **anterior à data de saída**.  
5. A reserva só pode ser **cancelada antes da data de entrada**.  
6. Cada funcionário deve estar vinculado a **exatamente um hotel**.  
7. O **número do quarto** deve ser **único dentro do hotel**.  
8. O **status do quarto** deve ser: `Disponível`, `Reservado`, `Ocupado` ou `Manutenção`.  
9. Somente **funcionários autenticados** podem cadastrar ou editar quartos e reservas.  
10. O hóspede deve possuir **CPF ou passaporte único** no sistema.  
11. Cada reserva deve ter **exatamente um pagamento** (mesmo que o valor seja zero).  
12. O pagamento **não pode ser registrado antes da criação da reserva**.  
13. Uma reserva só é considerada **confirmada** se o pagamento estiver com status `Pago` ou `Confirmado`.  
14. O **valor do pagamento** deve ser igual ao **valor total da reserva**.  
15. Cancelamentos após o pagamento podem gerar o status **“Estornado”**.



## 🧩 Estrutura do Banco de Dados

### Modelo Lógico (BRModelo)
O modelo lógico foi projetado respeitando as regras de negócio acima e com as devidas chaves estrangeiras e relacionamentos (1:N e N:N).



## 🐘 Banco de Dados PostgreSQL com Docker

Para execução do projeto, utilizamos um **container Docker** com **PostgreSQL 16**.

### 🧱 Subindo o container
Arquivo `docker-compose.yml` utilizado:

```yaml


services:
  db:
    image: postgres:16
    container_name: postgres_hotel
    restart: always
    environment:
      POSTGRES_USER: admin
      POSTGRES_PASSWORD: admin123
      POSTGRES_DB: hotelaria
    ports:
      - "5432:5432"
    volumes:
      - db_data:/var/lib/postgresql/data
    networks:
      - hotel_network

  pgadmin:
    image: dpage/pgadmin4:8
    container_name: pgadmin_hotel
    restart: always
    environment:
      PGADMIN_DEFAULT_EMAIL: admin@hotel.com
      PGADMIN_DEFAULT_PASSWORD: admin123
    ports:
      - "8080:80"
    depends_on:
      - db
    networks:
      - hotel_network

volumes:
  db_data:

networks:
  hotel_network:
```

Para subir o container:

```bash
docker-compose up -d
```

## 🗃️ Criação do Esquema (DDL)

Todos os comandos de criação de tabelas foram inseridos no arquivo:

```pgsql
ddl_hotelaria_postgres.sql
```

Execução no banco:

```bash
docker exec -i postgres_hotel psql -U admin -d hotelaria < ddl_hotelaria_postgres.sql
```

## 🌱 Populando Dados (DML)

Para inserir registros de exemplo, utilizamos o arquivo:

```pgsql
populate_hotelaria.sql
```

Execução no banco:

```bash
docker exec -i postgres_hotel psql -U admin -d hotelaria < populate_hotelaria.sql
```

## 👁️ Views Criadas

### 1. vw_reservas_detalhadas

Exibe informações completas das reservas cadastradas, incluindo:

- Dados do hóspede  
- Período da reserva  
- Quartos envolvidos  
- Serviços utilizados  
- Valores totais  
- Status de pagamento  
- Hotel associado  

Essa view facilita consultas como:

- Relatórios de faturamento  
- Histórico de hóspedes  
- Controle de ocupação  

---

### 2. vw_reservas_ativas

Baseada na view anterior, exibe apenas reservas com:

- **Status de pagamento “Pago”**  
- **Data de saída maior ou igual à data atual**

Permite uma visão detalhada das **reservas ativas**.

## 🚀 Tecnologias Utilizadas

- PostgreSQL 16
- Docker e Docker Compose
- SQL (DDL / DML / Views)
- pgAdmin para administração visual
- BRModelo para modelagem do banco

## 💡 Autores

Projeto desenvolvido em grupo como atividade acadêmica para prática de modelagem e implementação de bancos de dados relacionais.

- Lavique Dias  
- Isthanlley Fragoso  
- David Flor  
- João Felipe

**Professor:** Pierre Chambertin
