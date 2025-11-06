-- Inserindo HOTEIS
INSERT INTO hotel (nomehotel, enderecohotel) VALUES
('Hotel Paraíso Tropical', 'Av. Beira Mar, 102, Fortaleza - CE'),
('Hotel Serra Verde', 'Rua das Flores, 55, Gramado - RS');

-- Inserindo QUARTOS (20 quartos distribuídos entre os dois hotéis)
INSERT INTO quarto (numeroquarto, tipoquarto, statusquarto, fk_hotelid, precodiaria) VALUES
(101, 'Suite', 'Disponivel', 1, 450.00),
(102, 'Standard', 'Disponivel', 1, 300.00),
(103, 'Luxo', 'Ocupado', 1, 550.00),
(104, 'Suite', 'Disponivel', 1, 500.00),
(105, 'Standard', 'Manutencao', 1, 280.00),
(106, 'Luxo', 'Disponivel', 1, 600.00),
(107, 'Suite', 'Disponivel', 1, 470.00),
(108, 'Standard', 'Disponivel', 1, 290.00),
(201, 'Suite', 'Disponivel', 2, 480.00),
(202, 'Standard', 'Disponivel', 2, 310.00),
(203, 'Luxo', 'Disponivel', 2, 570.00),
(204, 'Suite', 'Ocupado', 2, 520.00),
(205, 'Standard', 'Disponivel', 2, 300.00),
(206, 'Luxo', 'Disponivel', 2, 610.00),
(207, 'Suite', 'Disponivel', 2, 490.00),
(208, 'Standard', 'Manutencao', 2, 295.00),
(209, 'Suite', 'Disponivel', 2, 500.00),
(210, 'Luxo', 'Disponivel', 2, 640.00),
(211, 'Standard', 'Disponivel', 2, 310.00),
(212, 'Suite', 'Disponivel', 2, 520.00);

-- Inserindo FUNCIONARIOS
INSERT INTO funcionario (matriculafuncionario, nomefuncionario, cargofuncionario, salariofuncionario, fk_hotelid) VALUES
(1001, 'João Mendes', 'Gerente', 5200.00, 1),
(1002, 'Carla Silva', 'Recepcionista', 2800.00, 1),
(1003, 'Paulo Lima', 'Camareiro', 1800.00, 1),
(1004, 'Ana Torres', 'Cozinheira', 2500.00, 1),
(1005, 'Rafael Costa', 'Manobrista', 1900.00, 1),
(2001, 'Mariana Souza', 'Gerente', 5400.00, 2),
(2002, 'Lucas Nogueira', 'Recepcionista', 2700.00, 2),
(2003, 'Patrícia Gomes', 'Camareira', 1850.00, 2),
(2004, 'Bruno Teixeira', 'Cozinheiro', 2600.00, 2),
(2005, 'Fernanda Lopes', 'Manobrista', 1950.00, 2);

-- Inserindo HOSPEDES
INSERT INTO hospede (nomehospede, cpfhospede, telefonehospede, idadehospede) VALUES
('Maria Souza', '111.111.111-11', '(85) 98888-0001', 32),
('Carlos Silva', '222.222.222-22', '(85) 98888-0002', 45),
('Fernanda Lima', '333.333.333-33', '(85) 98888-0003', 27),
('João Pedro', '444.444.444-44', '(85) 98888-0004', 35),
('Luciana Gomes', '555.555.555-55', '(85) 98888-0005', 41),
('Rafael Oliveira', '666.666.666-66', '(85) 98888-0006', 29),
('Patrícia Santos', '777.777.777-77', '(85) 98888-0007', 38),
('Rodrigo Costa', '888.888.888-88', '(85) 98888-0008', 34),
('Juliana Rocha', '999.999.999-99', '(85) 98888-0009', 26),
('Gabriel Martins', '000.000.000-00', '(85) 98888-0010', 31);

-- Inserindo SERVICOS
INSERT INTO servico (nomeservico, statusservico, valorservico) VALUES
('Massagem Relaxante', 'Disponivel', 120.00),
('Café da Manhã Especial', 'Disponivel', 45.00),
('Lavanderia', 'Disponivel', 60.00),
('Translado Aeroporto', 'Disponivel', 150.00),
('Spa Completo', 'Disponivel', 250.00),
('Passeio Turístico', 'Disponivel', 200.00);

-- Inserindo RESERVAS
INSERT INTO reserva (dataentrada, datasaida, statusreserva, fk_hospedeid, qtdhospedes, valortotalreserva, formapagamentoreserva, statuspagamentoreserva) VALUES
('2025-01-10', '2025-01-15', 'Concluida', 1, 2, 1800.00, 'Pix', 'Pago'),
('2025-01-20', '2025-01-25', 'Concluida', 2, 3, 2500.00, 'Cartao', 'Pago'),
('2025-02-01', '2025-02-05', 'Agendada', 3, 1, 900.00, 'Pix', 'Pendente'),
('2025-02-03', '2025-02-07', 'Agendada', 4, 2, 1400.00, 'Cartao', 'Pendente'),
('2025-02-10', '2025-02-12', 'Cancelada', 5, 1, 0.00, 'Pix', 'Cancelado'),
('2025-03-01', '2025-03-05', 'Agendada', 6, 2, 1300.00, 'Pix', 'Pendente'),
('2025-03-10', '2025-03-15', 'Agendada', 7, 4, 2800.00, 'Cartao', 'Pendente'),
('2025-03-20', '2025-03-25', 'Concluida', 8, 2, 1700.00, 'Pix', 'Pago'),
('2025-04-01', '2025-04-04', 'Agendada', 9, 2, 1100.00, 'Pix', 'Pendente'),
('2025-04-05', '2025-04-10', 'Concluida', 10, 3, 2300.00, 'Dinheiro', 'Pago'),
('2025-04-15', '2025-04-20', 'Agendada', 2, 2, 1500.00, 'Pix', 'Pendente'),
('2025-04-25', '2025-04-30', 'Agendada', 5, 1, 800.00, 'Pix', 'Pendente'),
('2025-05-01', '2025-05-06', 'Agendada', 7, 2, 1600.00, 'Pix', 'Pendente'),
('2025-05-10', '2025-05-15', 'Concluida', 4, 3, 2400.00, 'Cartao', 'Pago'),
('2025-06-01', '2025-06-05', 'Agendada', 9, 2, 1200.00, 'Pix', 'Pendente');

-- Relacionando QUARTOS e RESERVAS (1–3 quartos por reserva)
INSERT INTO quarto_reserva (fk_quartoid, fk_reservaid) VALUES
(1, 1), (2, 1),
(3, 2),
(4, 3),
(5, 4), (6, 4),
(7, 6),
(8, 7), (9, 7), (10, 7),
(11, 8),
(12, 9),
(13, 10), (14, 10),
(15, 11),
(16, 12), (17, 12),
(18, 13),
(19, 14), (20, 15);

-- Relacionando SERVICOS e RESERVAS
INSERT INTO reserva_servico (fk_reservaid, fk_servicoid) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 1),
(5, 5),
(6, 2),
(7, 6),
(8, 3),
(9, 4),
(10, 2),
(11, 1),
(12, 6),
(13, 5),
(14, 4),
(15, 3);
