--- Ticket médio por Reserva e Mediana
SELECT
	ROUND((SUM(oft.preco * rsv.qtd_pessoas) / SUM(rsv.qtd_pessoas))::NUMERIC, 2) AS ticket_medio,
	ROUND(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY preco)::NUMERIC, 2) AS mediana
FROM
	ofertas oft
INNER JOIN
	reservas rsv
ON
	oft.id_oferta = rsv.id_oferta
WHERE
	--- Uso do LOWER para prevenir erros de digitação
	LOWER(rsv.status) IN ('confirmada', 'concluída');