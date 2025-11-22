--- Avaliação média das ofertas
SELECT
	oft.tipo_oferta,
	oft.titulo,
	ROUND(COALESCE(AVG(ava.nota), 0), 2) AS media_nota
FROM
	ofertas oft
LEFT JOIN
	avaliacoes ava
ON
	oft.id_oferta = ava.id_oferta
GROUP BY
	oft.tipo_oferta,
	oft.titulo
ORDER BY
	media_nota DESC;