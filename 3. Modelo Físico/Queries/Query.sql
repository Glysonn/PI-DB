-- LISTA DE TODAS AS PESSOAS QUE TEM MAIS DE UM CARTÃO DE CRÉDITO SALVO NA CONTA, TRAZENDO OS NÚMEROS E O NOME DA PESSOA
SELECT ucc.CartaoDeCredito_Numero "Cartão de crédito", u.Nome FROM usuarios_cartaodecredito ucc
inner join usuarios u on u.CPF = ucc.Usuarios_CPF GROUP BY CartaoDeCredito_Numero having count(CartaoDeCredito_Numero) > 1;


-- LISTA DE TODAS AS DOAÇÕES MOSTRANDO NOME, VALOR, DATA E O TIPO DO PAGAMENTO
SELECT u.Nome, p.Valor, p.DataPagamento, p.Tipo from pagamentos p
INNER JOIN doacoes d ON d.ID = p.Doacoes_ID
INNER JOIN usuarios u ON u.CPF = d.Usuarios_CPF;