
CREATE OR REPLACE FUNCTION atualizar_status_quarto_reserva()
RETURNS TRIGGER AS $$
DECLARE
    dataEntradaReserva DATE;
BEGIN
    SELECT dataEntrada INTO dataEntradaReserva
    FROM reserva
    WHERE pk_idreserva = NEW.fk_reservaid;

    
    IF dataEntradaReserva > CURRENT_DATE THEN
        UPDATE quarto SET statusQuarto = 'Reservado'
        WHERE pk_idquarto = NEW.fk_quartoid;
    ELSE
        UPDATE quarto SET statusQuarto = 'Ocupado'
        WHERE pk_idquarto = NEW.fk_quartoid;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_atualiza_status_quarto_insert
AFTER INSERT ON quarto_reserva
FOR EACH ROW
EXECUTE FUNCTION atualizar_status_quarto_reserva();

