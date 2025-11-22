--- Fidelização de Clientes
WITH frequencia_por_cliente AS (
	SELECT
		id_cliente,
		COUNT(id_reserva) AS total_reservas
	FROM
		reservas
	WHERE
		LOWER(status) = 'concluída'
	GROUP BY
		id_cliente,
		status
)

SELECT
	total_reservas,
	COUNT(id_cliente) AS numero_de_clientes,
	ROUND(COUNT(id_cliente) * 100 / SUM(COUNT(id_cliente)) OVER (), 2) || '%' AS percentual_clientes
FROM
	frequencia_por_cliente
GROUP BY
	total_reservas
ORDER BY
	total_reservas DESC;

