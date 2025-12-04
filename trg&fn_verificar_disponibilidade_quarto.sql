
CREATE OR REPLACE FUNCTION verificar_disponibilidade_quarto()
RETURNS TRIGGER AS $$
DECLARE
    conflito INT;
BEGIN
    SELECT COUNT(*)
    INTO conflito
    FROM quarto_reserva qr
    JOIN reserva r ON r.pk_idreserva = qr.fk_reservaid
    WHERE qr.fk_quartoid = NEW.fk_quartoid
      AND (
            r.dataentrada < (SELECT dataSaida FROM reserva WHERE pk_idreserva = NEW.fk_reservaid)
        AND r.datasaida > (SELECT dataEntrada FROM reserva WHERE pk_idreserva = NEW.fk_reservaid)
      );

    IF conflito > 0 THEN
        RAISE EXCEPTION 'Quarto % já está reservado no período especificado.', NEW.fk_quartoid;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_verificar_disponibilidade_quarto
BEFORE INSERT ON quarto_reserva
FOR EACH ROW
EXECUTE FUNCTION verificar_disponibilidade_quarto();

