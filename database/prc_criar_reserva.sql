CREATE OR REPLACE PROCEDURE criar_reserva (
    p_data_entrada TIMESTAMP,
    p_data_saida   TIMESTAMP,
    p_hospede_id   INT,
    p_qtd_hospedes INT,
    p_forma_pagamento VARCHAR,
    p_valor_total NUMERIC(10,2),
    p_quartos INT[]
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_reserva_id INT;
    v_quarto_id INT;
BEGIN
    
    IF p_data_entrada >= p_data_saida THEN
        RAISE EXCEPTION 'Data de entrada deve ser anterior à saída';
    END IF;

    
    IF NOT EXISTS (SELECT 1 FROM hospede WHERE pk_idhospede = p_hospede_id) THEN
        RAISE EXCEPTION 'Hóspede % não encontrado', p_hospede_id;
    END IF;

    
    INSERT INTO reserva (
        dataentrada, datasaida, statusreserva, fk_hospedeid, 
        qtdhospedes, valortotalreserva, formapagamentoreserva, statuspagamentoreserva
    ) VALUES (
        p_data_entrada, p_data_saida, 'Agendada', p_hospede_id,
        p_qtd_hospedes, p_valor_total, p_forma_pagamento, 'Pendente'
    )
    RETURNING pk_idreserva INTO v_reserva_id;

    
    FOREACH v_quarto_id IN ARRAY p_quartos LOOP

        -- Verifica disponibilidade
        IF EXISTS (
            SELECT 1 
            FROM quarto_reserva qr 
            JOIN reserva r ON r.pk_idreserva = qr.fk_reservaid
            WHERE qr.fk_quartoid = v_quarto_id
            AND r.dataentrada <= p_data_saida
            AND r.datasaida >= p_data_entrada
            AND r.statusreserva != 'Cancelada'
        ) THEN
            RAISE EXCEPTION 'Quarto % não está disponível no período informado', v_quarto_id;
        END IF;

        -- Relaciona quarto-reserva
        INSERT INTO quarto_reserva (fk_quartoid, fk_reservaid)
        VALUES (v_quarto_id, v_reserva_id);

        -- Atualiza status do quarto
        UPDATE quarto SET statusquarto = 'Reservado'
        WHERE pk_idquarto = v_quarto_id;

    END LOOP;

    RAISE NOTICE 'Reserva % criada com sucesso', v_reserva_id;
END$$;

