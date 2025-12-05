
import express from 'express'
import pkg from 'pg'
const { Pool } = pkg

const app = express()
app.use(express.json())

// Conexão com PostgreSQL
const pool = new Pool({
  user: 'admin',
  host: 'localhost',
  database: 'hotelaria',
  password: 'admin123',
  port: 5432
})

// Teste de conexão
app.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT NOW()')
    res.json({ status: 'Online', time: result.rows[0] })
  } catch (error) {
    res.status(500).json({ error: error.message })
  }
})

// CRUD simples para HOSPEDE
app.post('/hospede', async (req, res) => {
  const { nomeHospede, cpfHospede, telefoneHospede, idadeHospede } = req.body

  try {
    const result = await pool.query(
      'INSERT INTO hospede (nomeHospede, cpfHospede, telefoneHospede, idadeHospede) VALUES ($1, $2, $3, $4) RETURNING *',
      [nomeHospede, cpfHospede, telefoneHospede, idadeHospede]
    )
    res.json(result.rows[0])
  } catch (error) {
    res.status(500).json({ error: error.message })
  }
})

app.get('/hospede', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM hospede')
    res.json(result.rows)
  } catch (error) {
    res.status(500).json({ error: error.message })
  }
})

app.post('/reserva', async (req, res) => {
  const {
    dataEntrada,
    dataSaida,
    fk_hospedeId,
    qtdHospedes,
    formaPagamentoReserva,
    valorTotalReserva,
    quartos
  } = req.body;

  try {

    // Chama a procedure
    await pool.query(
      `CALL criar_reserva($1, $2, $3, $4, $5, $6, $7)`,
      [
        dataEntrada,
        dataSaida,
        fk_hospedeId,
        qtdHospedes,
        formaPagamentoReserva,
        valorTotalReserva,
        quartos // array de quartos ex: [1,2]
      ]
    );

    // Recupera a reserva mais recente do hóspede como forma simples de obter o ID gerado
    const result = await pool.query(
      `SELECT *
         FROM reserva
        WHERE fk_hospedeId = $1
        ORDER BY pk_idreserva DESC
        LIMIT 1`,
      [fk_hospedeId]
    );

    res.json({
      message: "Reserva criada com sucesso via procedure",
      reserva: result.rows[0]
    });

  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});


const PORT = 3000
app.listen(PORT, () => console.log(`Backend rodando na porta ${PORT}`))
