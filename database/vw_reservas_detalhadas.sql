CREATE OR REPLACE VIEW vw_reservas_detalhadas AS
SELECT
    r.pk_idreserva AS id_reserva,
    h.nomehospede AS nome_hospede,
    h.cpfhospede AS cpf_hospede,
    ht.nomehotel AS nome_hotel,
    STRING_AGG(DISTINCT q.numeroquarto::text, ', ') AS quartos_reservados,
    STRING_AGG(DISTINCT s.nomeservico, ', ') AS servicos_utilizados,
    r.dataentrada AS data_inicio,
    r.datasaida AS data_fim,
    r.valortotalreserva AS valor_total,
    r.formapagamentoreserva AS forma_pagamento,
    r.statuspagamentoreserva AS status_pagamento
FROM reserva r
JOIN hospede h ON h.pk_idhospede = r.fk_hospedeid
LEFT JOIN quarto_reserva qr ON qr.fk_reservaid = r.pk_idreserva
LEFT JOIN quarto q ON q.pk_idquarto = qr.fk_quartoid
LEFT JOIN hotel ht ON ht.pk_idhotel = q.fk_hotelid
LEFT JOIN reserva_servico rs ON rs.fk_reservaid = r.pk_idreserva
LEFT JOIN servico s ON s.pk_idservico = rs.fk_servicoid
GROUP BY
    r.pk_idreserva,
    h.nomehospede,
    h.cpfhospede,
    ht.nomehotel,
    r.dataentrada,
    r.datasaida,
    r.valortotalreserva,
    r.formapagamentoreserva,
    r.statuspagamentoreserva;

