--- Índice de práticas sustentáveis
SELECT
	ROUND(COUNT(DISTINCT op.id_oferta) * 100.0 / (
	SELECT
		COUNT(DISTINCT id_oferta)
	FROM
		ofertas
	), 2) || '%' AS indice_sustentavel_pct
FROM
	oferta_pratica op;