--- Desempenho médio dos operadores por categoria de oferta
WITH reservas_concluidas AS (
    SELECT 
		DISTINCT id_oferta
    FROM 
		reservas
    WHERE 
		UPPER(status) = 'CONCLUÍDA'
)
SELECT
	op.nome_fantasia,
	oft.tipo_oferta,
	ROUND(AVG(ava.nota), 2) AS media_avaliacao
FROM
	avaliacoes ava
INNER JOIN
	ofertas oft
ON
	ava.id_oferta = oft.id_oferta
INNER JOIN
	reservas_concluidas rsv
ON
	rsv.id_oferta = oft.id_oferta
INNER JOIN
	operadores op
ON
	op.id_operador = oft.id_operador
GROUP BY
	1, 2
ORDER BY
	2, 3;