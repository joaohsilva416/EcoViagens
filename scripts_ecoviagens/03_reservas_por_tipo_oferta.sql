/* Distribuição de reservas por tipo de oferta 
e tipo de oferta com mais viajantes 
*/
SELECT
	tipo_oferta,
	COUNT(rsv.id_reserva) AS total_reserva,
	SUM(rsv.qtd_pessoas) AS total_viajantes
FROM
	ofertas oft
INNER JOIN
	reservas rsv
ON
	oft.id_oferta = rsv.id_oferta
GROUP BY
	tipo_oferta;