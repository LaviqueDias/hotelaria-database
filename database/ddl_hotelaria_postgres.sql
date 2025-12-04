CREATE TABLE HOTEL (
    pk_idHotel SERIAL PRIMARY KEY,
    nomeHotel VARCHAR(100) NOT NULL,
    enderecoHotel VARCHAR(150) NOT NULL
);

CREATE TABLE QUARTO (
    pk_idQuarto SERIAL PRIMARY KEY,
    numeroQuarto INT NOT NULL,
    tipoQuarto VARCHAR(30) CHECK (tipoQuarto IN ('Suite', 'Luxo', 'Standard')) DEFAULT 'Suite',
    statusQuarto VARCHAR(20) CHECK (statusQuarto IN ('Disponivel', 'Ocupado', 'Manutencao')) DEFAULT 'Disponivel',
    fk_hotelId INT REFERENCES HOTEL(pk_idHotel),
    precoDiaria NUMERIC(10,2) NOT NULL,
    UNIQUE (numeroQuarto)
);

CREATE TABLE FUNCIONARIO (
    pk_idFuncionario SERIAL PRIMARY KEY,
    matriculaFuncionario INT NOT NULL UNIQUE,
    nomeFuncionario VARCHAR(100) NOT NULL,
    cargoFuncionario VARCHAR(50) NOT NULL,
    salarioFuncionario NUMERIC(10,2) NOT NULL,
    fk_hotelId INT REFERENCES HOTEL(pk_idHotel)
);

CREATE TABLE HOSPEDE (
    pk_idHospede SERIAL PRIMARY KEY,
    nomeHospede VARCHAR(100) NOT NULL,
    cpfHospede VARCHAR(14) NOT NULL UNIQUE,
    telefoneHospede VARCHAR(15) NOT NULL,
    idadeHospede INT NOT NULL
);

CREATE TABLE RESERVA (
    pk_idReserva SERIAL PRIMARY KEY,
    dataEntrada TIMESTAMP NOT NULL,
    dataSaida TIMESTAMP NOT NULL,
    statusReserva VARCHAR(20) CHECK (statusReserva IN ('Agendada', 'Concluida', 'Cancelada')) DEFAULT 'Agendada',
    fk_hospedeId INT REFERENCES HOSPEDE(pk_idHospede),
    qtdHospedes INT NOT NULL,
    valorTotalReserva NUMERIC(10,2) NOT NULL,
    formaPagamentoReserva VARCHAR(20) CHECK (formaPagamentoReserva IN ('Pix', 'Cartao', 'Dinheiro')) DEFAULT 'Pix',
    statusPagamentoReserva VARCHAR(20) CHECK (statusPagamentoReserva IN ('Pendente', 'Pago', 'Cancelado')) DEFAULT 'Pendente'
);

CREATE TABLE QUARTO_RESERVA (
    fk_quartoId INT REFERENCES QUARTO(pk_idQuarto),
    fk_reservaId INT REFERENCES RESERVA(pk_idReserva),
    PRIMARY KEY (fk_quartoId, fk_reservaId)
);

CREATE TABLE SERVICO (
    pk_idServico SERIAL PRIMARY KEY,
    nomeServico VARCHAR(100) NOT NULL,
    statusServico VARCHAR(20) CHECK (statusServico IN ('Disponivel', 'Indisponivel')) DEFAULT 'Disponivel',
    valorServico NUMERIC(10,2) NOT NULL
);

CREATE TABLE RESERVA_SERVICO (
    fk_reservaId INT REFERENCES RESERVA(pk_idReserva),
    fk_servicoId INT REFERENCES SERVICO(pk_idServico),
    PRIMARY KEY (fk_reservaId, fk_servicoId)
);

