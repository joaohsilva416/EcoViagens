# 🌿 EcoViagens - Projeto de SQL e Análise de Dados
## 📌 Sobre o Projeto
Este é um projeto prático desenvolvido durante o curso [EBA](https://renatabiaggi.com/eba/), da professora Renata Biaggi. 
O objetivo foi simular o dia a dia de um analista de dados na EcoViagens, uma empresa fictícia de turismo sustentável. 
Minha missão foi estruturar o banco de dados e usar SQL para responder a perguntas reais de negócio.

## 🛠️ Etapas do Projeto
### 1. Modelagem de Dados
Precisei entender como as informações da empresa se conectavam. 
Analisei as tabelas disponíveis (clientes, reservas, ofertas, etc) e montei o Modelo Lógico abaixo para garantir que as relações estavam corretas.

<img width="700" height="500" alt="EcoViagens_Modelo_Logico" src="https://github.com/user-attachments/assets/b7376c34-fcfd-4409-a980-93acac3bbc47" />

### 2. Definindo as Métricas (KPIs)
O desafio aqui foi receber perguntas da "diretoria" (ex: "Estamos fidelizando os clientes?") e traduzir isso para métricas que eu pudesse calcular com dados.
Abaixo, listo os KPIs que defini e como cheguei no cálculo de cada um:
| KPIs                               | Pergunta que ele responde       | Como calculei                                                                  |
| ---------------------------------- | ------------------------------- | ------------------------------------------------------------------------------ |
| Receita Mensal & Crescimento (MoM) | A empresa está crescendo?       | Soma de (preço × pessoas) e a variação percentual em relação ao mês anterior.  |
| Ticket Médio por Pessoa            | Quanto cada cliente gasta?      | Receita total dividida pelo total de pessoas (viajantes).                      |
| Volume de Reservas por Categoria   | O que vende mais?               | Contagem de reservas e total de viajantes por tipo (Atividade vs. Hospedagem). |
| Taxa de Clientes Recorrentes       | Estamos fidelizando?            | Distribuição percentual de clientes que fizeram 1 vs. múltiplas reservas.      |
| Ranking de Melhores Ofertas        | O que os clientes mais gostam?  | Lista de ofertas ordenadas pela nota média.                                    |
| Índice de Adoção Sustentável       | A empresa é sustentável mesmo?  | % de ofertas que possuem pelo menos uma prática sustentável cadastrada.        |
| Práticas Mais Populares            | O que atrai o cliente?          | Ranking das práticas sustentáveis que mais aparecem nas reservas.              |
| Tempo Médio de Recompra            | Quando o cliente volta?         | Média de dias que um cliente fiel demora para comprar novamente.               |
| Nota Média por Operador            | Quem são os melhores parceiros? | Média das avaliações agrupada por operador e categoria.                        |

### 3. Implementação com SQL
Todos os scripts utilizados estão organizados na pasta [scripts_ecoviagens](./scripts_ecoviagens)

**1. Receita Total:** Analisando a tabela, observei que Outubro/2024 foi o melhor mês, com um crescimento de quase 50%. 
O período de Nov/2024 e Dez/2024 mostra uma queda natural, provavelmente devido às festas de fim de ano. 
Nota: Os dados de Jun/2025 aparecem negativos pois o mês ainda não foi encerrado contabilmente.
| Ano  | Mês | Receita Total | Crescimento (%) |
| :--- | :--- | :--- | :--- |
| 2025 | Jun | R$ 35.539,11 | -73.14% |
| 2025 | Mai | R$ 132.302,73 | +7.96% |
| 2025 | Abr | R$ 122.542,49 | -4.76% |
| 2025 | Mar | R$ 128.668,93 | +16.87% |
| 2025 | Fev | R$ 110.094,89 | -8.97% |
| 2025 | Jan | R$ 120.941,88 | +1.32% |
| 2024 | Dez | R$ 119.363,59 | -7.13% |
| 2024 | Nov | R$ 128.521,02 | -12.49% |
| 2024 | Out | R$ 146.871,25 | +49.33% |
| 2024 | Set | R$ 98.350,88 | -18.19% |
| 2024 | Ago | R$ 120.217,22 | -5.33% |
| 2024 | Jul | R$ 126.981,04 | +30.86% |
| 2024 | Jun | R$ 97.032,37 | - |

**2. Ticket Médio:** Observando o ticket médio, vemos que o valor gasto por cliente é de R$ 280,49. 
Os gastos estão bem distribuídos: alguns clientes optam por experiências premium, enquanto outros preferem opções econômicas. 
Essa distribuição equilibrada se confirma quando olhamos para a Mediana (R$ 280,96). Como a média e a mediana são praticamente 
iguais, concluímos que não temos valores muito destoantes (outliers) distorcendo a análise.
| Indicador | Valor (R$) |
| :--- | :--- |
| Ticket Médio | R$ 280,49 |
| Mediana | R$ 280,96 |

**3. Distribuição de reservas por tipo de oferta:** Aqui observamos que o tipo de oferta mais popular entre os viajantes são as Hospedagens. 
Embora as duas categorias tenham números próximos, as hospedagens lideram tanto no volume total de reservas quanto na quantidade de viajantes atraídos.
| Tipo de Oferta | Total de Reservas | Total de Viajantes |
| :--- | :--- | :--- |
| Hospedagem | 1.053 | 3.043 |
| Atividade | 947 | 2.801 |

**4. Fidelização de clientes:** Esta é a análise mais preocupante dentre as nove. Vemos que, apesar de um bom número total de compradores, 
a vasta maioria (76,71%) fez apenas uma reserva. Isso acende um alerta vermelho sobre o índice de Churn (abandono). 
Temos um grupo pequeno mas firme de clientes fiéis (que reservaram 2 ou mais vezes), mas o grande desafio estratégico agora é incentivar a "segunda compra" 
para não perdermos essa base majoritária.
| Reservas por Cliente | Qtd. Clientes | Percentual (%) |
| :--- | :--- | :--- |
| 5 reservas | 1 | 0.16% |
| 4 reservas | 6 | 0.98% |
| 3 reservas | 19 | 3.09% |
| 2 reservas | 117 | 19.06% |
| 1 reserva | 471 | 76.71% |

**5. Avaliação média das ofertas:** Identificamos experiências com excelência máxima (nota 5.0), que devem ser priorizadas na vitrine da plataforma. 
Por outro lado, notei que a média sozinha pode esconder nuances: temos ofertas com nota 0.00 (que indicam falta de avaliações, 
não necessariamente má qualidade) e ofertas com notas baixas reais (1.0 ou 2.0), que exigem ação imediata do time de Operações.
| Ranking | Tipo de Oferta | Título da Oferta | Nota Média |
| :--- | :--- | :--- | :--- |
| 1 | Hospedagem | Hospedagem Oferta 1108 | 5.00 |
| 2 | Hospedagem | Hospedagem Oferta 848 | 5.00 |
| 3 | Hospedagem | Hospedagem Oferta 70 | 5.00 |
| 4 | Hospedagem | Hospedagem Oferta 960 | 5.00 |
| 5 | Atividade | Atividade Oferta 610 | 5.00 |
| 6 | Atividade | Atividade Oferta 620 | 5.00 |
| 7 | Hospedagem | Hospedagem Oferta 986 | 5.00 |
| 8 | Hospedagem | Hospedagem Oferta 540 | 4.75 |
| 9 | Hospedagem | Hospedagem Oferta 880 | 4.67 |
| 10 | Atividade | Atividade Oferta 19 | 4.67 |

**6. Índice de adoção de práticas sustentáveis:** Observamos que a maioria das ofertas (66,83%) já possui práticas sustentáveis cadastradas. 
Isso indica um forte alinhamento de grande parte dos parceiros com os valores da EcoViagens. No entanto, é crucial investigar os ~33% restantes: 
precisamos entender se esses parceiros não possuem práticas ou apenas não as cadastraram no sistema, pois essa lacuna pode impactar negativamente a percepção da marca pelo público.
| Indicador | Taxa de Adoção (%) |
| :--- | :--- |
| Ofertas com Práticas Sustentáveis | 66.83% |
| Ofertas sem Práticas (Gap) | 33.17% |

**7. Práticas sustentáveis mais populares:** Dando ênfase ao Top 3, vemos que as reservas giram em torno de práticas tangíveis: 
Reutilização de materiais e Certificação Fair Trade. Isso sinaliza ao Marketing que o selo "Comércio Justo" é um diferencial competitivo 
forte para atrair clientes. Por outro lado, a Agricultura Regenerativa aparece em último lugar (apenas 43 reservas). Precisamos investigar 
se isso se deve à falta de interesse do público ou — o que é mais provável — à escassez de ofertas cadastradas com essa prática específica no nosso portfólio.
| Ranking | Prática Sustentável | Total de Reservas |
| :--- | :--- | :--- |
| 1 | Reutilização de materiais | 116 |
| 2 | Certificação Fair Trade | 112 |
| 3 | Monitoramento ambiental | 111 |
| 4 | Compostagem de resíduos orgânicos | 103 |
| 5 | Economia circular | 103 |
| 6 | Gestão sustentável de florestas | 101 |
| 7 | Redução do uso de papel | 101 |
| 8 | Uso de sensores para otimizar recursos | 99 |
| 9 | Redução de desperdício de alimentos | 98 |
| 10 | Captação de água da chuva | 97 |

**8. Frequência que clientes fiés fazem novas reservas:** Os dados mostram que o tempo médio entre reservas é de 114 dias (aprox. 4 meses), mas esse 
número esconde uma variação extrema. Temos clientes que compram novamente na mesma semana (0 a 5 dias), enquanto outros levam quase um ano (335 dias) para retornar. 
Para o time de CRM, isso indica que não podemos usar uma régua única. Campanhas de reengajamento devem ser segmentadas: ofertas agressivas de curto prazo para os "viajantes frequentes" 
e campanhas de relacionamento de longo prazo para quem tem um ciclo de compra mais lento.
| ID Cliente | Tempo Médio (Dias) |
| :--- | :--- |
| 36 | 36.00 |
| 64 | 177.00 |
| 79 | 154.00 |
| 81 | 65.00 |
| 111 | 5.00 |
...

**9. Desempenho médio dos operadores por categoria de oferta:** Ao calcular as métricas, tive uma surpresa estratégica. Embora a categoria Hospedagem possua o parceiro com a maior n
ota absoluta (4.40), ela também sofre com maior variação de qualidade, tendo as piores avaliações (Mín: 1.50). Por ser mais consistente, a categoria Atividade vence no quesito 
"Média Geral de Satisfação" (3.01 vs 2.95), provando que volume de vendas (onde Hospedagem ganha) não garante automaticamente a melhor experiência média.
| Categoria | Ranking | Operador (Nome Fantasia) | Nota Média |
| :--- | :--- | :--- | :--- |
| 🏨 Hospedagem | 1º | Silva e Filhos | 4.40 |
| 🏨 Hospedagem | 2º | Melo Dias Ltda. | 3.78 |
| 🏨 Hospedagem | 3º | Novaes Ltda. | 3.75 |
| 🏨 Hospedagem | 4º | Porto | 3.67 |
| 🏨 Hospedagem | 5º | Pereira Pereira S/A | 3.64 |
| --- | --- | --- | --- |
| 🧗 Atividade | 1º | Gomes | 4.25 |
| 🧗 Atividade | 2º | Pinto Moura - EI | 3.83 |
| 🧗 Atividade | 3º | Aragão S/A | 3.75 |
| 🧗 Atividade | 4º | Gonçalves | 3.73 |
| 🧗 Atividade | 5º | Fernandes | 3.67 |
