CREATE OR REPLACE VIEW vw_reservas_ativas AS
SELECT *
FROM vw_reservas_detalhadas
WHERE status_pagamento = 'Pago'
  AND data_fim >= CURRENT_DATE;

