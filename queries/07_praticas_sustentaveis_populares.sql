--- Práticas sustentáveis mais populares
SELECT
	ROW_NUMBER() OVER (ORDER BY COUNT(id_reserva) DESC) AS ranking,
	nome AS pratica_sustentavel,
	COUNT(id_reserva) AS total_reservas
FROM
	praticas_sustentaveis ps
INNER JOIN
	oferta_pratica op
ON
	ps.id_pratica = op.id_pratica
INNER JOIN
	reservas r 
ON 
	op.id_oferta = r.id_oferta	
GROUP BY
	2;