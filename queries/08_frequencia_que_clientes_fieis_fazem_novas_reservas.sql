--- Frequência em que clientes fiéis fazem novas reservas
WITH diffs AS (
	SELECT
		id_cliente,
		data_reserva,
		data_reserva::DATE - LAG(data_reserva::DATE) OVER (PARTITION BY id_cliente ORDER BY 
		data_reserva) AS dias_desde_ultima_compra
	FROM
		reservas
	WHERE
        status = 'concluída'
)

SELECT
	id_cliente,
	ROUND(AVG(dias_desde_ultima_compra), 2) AS tempo_medio_entre_reservas
FROM
	diffs
WHERE
	dias_desde_ultima_compra IS NOT NULL
GROUP BY
	id_cliente
HAVING
	COUNT(*) >= 1;