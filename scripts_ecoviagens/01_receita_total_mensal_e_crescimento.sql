--- Receita Total mensal e Crescimento
WITH receita_mensal AS (
	SELECT
		-- Padroniza data para o 1° dia do mês (para agrupar o volume mensal)
		DATE_TRUNC('month', rsv.data_reserva::DATE) AS data_referencia, 
		ROUND(SUM(oft.preco * rsv.qtd_pessoas)::NUMERIC, 2) AS receita_total
	FROM
		ofertas oft
	INNER JOIN
		reservas rsv
	ON
		oft.id_oferta = rsv.id_oferta
	WHERE
		-- Uso do LOWER para prevenir erros de digitação
		LOWER(rsv.status) IN ('confirmada', 'concluída') 
	GROUP BY
		data_referencia
)

SELECT
	-- TO_CHAR para ficar visualmente bonito
	TO_CHAR(data_referencia, 'YYYY') AS ano,
	TO_CHAR(data_referencia, 'Mon') AS mes,
	receita_total,
	LAG(receita_total) OVER (ORDER BY data_referencia) AS receita_anterior,
	-- Cálculo do crescimento mensal (* 100 para porcentagem)
	ROUND(((receita_total / NULLIF(LAG(receita_total) OVER (ORDER BY data_referencia), 0)) - 1) * 100
	, 2) || '%' AS crescimento_mensal
FROM
	receita_mensal
ORDER BY
	data_referencia DESC;