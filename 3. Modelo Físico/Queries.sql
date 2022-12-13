-- Query 1: Listar a lista de todas as doações.
SELECT u.Nome, p.Valor, p.DataPagamento, p.Tipo FROM pagamentos p
	INNER JOIN doacoes d ON d.ID = p.Doacoes_ID
	INNER JOIN usuarios u ON u.CPF = d.Usuarios_CPF
		ORDER BY p.Valor DESC;

-- Query 2: Listar o valor total em pagamentos do ano 2022
SELECT YEAR(d.`Data`) "Ano", SUM(p.Valor) "Valor Total (R$)" FROM pagamentos p
	INNER JOIN doacoes d ON d.ID = p.Doacoes_ID
	INNER JOIN usuarios u ON u.CPF = d.Usuarios_CPF
		WHERE YEAR(d.`Data`) = "2022"
			GROUP BY YEAR(p.`DataPagamento`)
				ORDER BY p.`DataPagamento` ASC;

-- Query 3: Mostrar o valor total em pagamentos de cada mês do ano 2022
SELECT CONCAT(MONTH(d.`Data`),"/", YEAR(d.`Data`)) "Período", SUM(p.Valor) "Valor Total (R$)" FROM pagamentos p
	INNER JOIN doacoes d ON d.ID = p.Doacoes_ID
	INNER JOIN usuarios u ON u.CPF = d.Usuarios_CPF
		WHERE YEAR(d.`Data`) = "2022"
        GROUP BY YEAR(p.`DataPagamento`), MONTH(p.`DataPagamento`)
			ORDER BY p.`DataPagamento` ASC;


-- Query 4: Lista de todas as pessoas que possuem mais de um cartão de crédito salvo.
SELECT ucc.CartaoDeCredito_Numero "Cartão de crédito", u.Nome FROM usuarios_cartaodecredito ucc
	INNER JOIN usuarios u ON u.CPF = ucc.Usuarios_CPF
		GROUP BY CartaoDeCredito_Numero 
			HAVING count(CartaoDeCredito_Numero) > 1;

-- Query 5: Lista a quantidade de cartões registrados para cada bandeira
SELECT count(Bandeira) "Quantidade de cartões", Bandeira FROM cartaodecredito
	GROUP BY Bandeira
		ORDER BY count(Bandeira) DESC;

-- Query 6: Lista de todas as publicações e o nome do adm que fez.
SELECT u.Nome "Responsável", pub.Legenda, pub.Imagem, pub.`Data` FROM publicacoes pub
	INNER JOIN administradores adm ON adm.Usuario_CPF = pub.Administradores_Usuario_CPF
    INNER JOIN usuarios u ON u.CPF = pub.Administradores_Usuario_CPF
		ORDER BY pub.`Data` DESC, u.Nome ASC;

-- Query 7: Lista de todas as pessoas que possuem cartão de crédito salvo
SELECT u.NomeCompleto, u.Email, cc.Numero "Número do Cartão", cc.NomeTitular "Titular do cartão" FROM usuarios_cartaodecredito ucc
	INNER JOIN cartaodecredito cc ON cc.Numero = ucc.CartaoDeCredito_Numero
    LEFT JOIN usuarios u on u.CPF = ucc.Usuarios_CPF
        ORDER BY Nome;
        
-- Query 8: Lista de cartões onde os usuários são os titulares.
SELECT u.Nome, u.Email, cc.Numero "Número do Cartão", cc.NomeTitular "Titular do cartão" FROM usuarios_cartaodecredito ucc
	INNER JOIN cartaodecredito cc ON cc.Numero = ucc.CartaoDeCredito_Numero
    INNER JOIN usuarios u on u.CPF = ucc.Usuarios_CPF
		WHERE SUBSTRING_INDEX( u.NomeCompleto, ' ', 1 ) = SUBSTRING_INDEX( cc.NomeTitular, ' ', 1 )
		AND SUBSTRING_INDEX( u.NomeCompleto, ' ', -1 ) = SUBSTRING_INDEX( cc.NomeTitular, ' ', -1 )
			ORDER BY Nome;

-- Query 9: Todas as doações que foram feitas a partir do cpf da pessoa, do nome e a data que foi feita
SELECT u.NomeCompleto, p.Valor "Valor (R$)", p.DataPagamento, p.Tipo FROM pagamentos p
	INNER JOIN doacoes d ON d.ID = p.Doacoes_ID
	INNER JOIN usuarios u ON u.CPF = d.Usuarios_CPF
		WHERE u.CPF = "411.800.454-24" -- usando um CPF qualquer de exemplo (também existe uma procedure que faz isso recebendo o cpf por parâmetro)
			ORDER BY p.Valor DESC;

-- Query 10: Lista de todas as pessoas que NÃO possuem NENHUM cartão de crédito salvo, trazendo o CPF, nome completo, email e o telefone
SELECT u.CPF, u.NomeCompleto "Nome Completo", u.Email, u.Telefone FROM usuarios_cartaodecredito ucc
	INNER JOIN cartaodecredito cc ON cc.Numero = ucc.CartaoDeCredito_Numero
    RIGHT JOIN usuarios u on u.CPF = ucc.Usuarios_CPF
		WHERE cc.Numero IS NULL
			ORDER BY Nome;

-- Query 11: Lista de todas as doações que foram realizadas no mês de dezembro de 2022
SELECT u.NomeCompleto, p.Valor "Valor (R$)", p.DataPagamento, p.Tipo FROM pagamentos p
	LEFT JOIN doacoes d ON d.ID = p.Doacoes_ID
	INNER JOIN usuarios u ON u.CPF = d.Usuarios_CPF
		WHERE MONTH(d.`Data`) = "12" AND YEAR(d.`Data`) = "2022"
			ORDER BY p.Valor DESC;
            
-- Query 12: Lista das pessoas que fizeram doações cujo o valor é ABAIXO da média retornando Nome completo da pessoa, o CPF dela, o valor, o tipo de pagamento e a quantidade de parcelas (caso não haja o tipo de pagamento cartão, não retornar essa coluna)
SELECT u.NomeCompleto, SUM(p.Valor), p.Tipo,
CASE WHEN p.Tipo = "Cartao" THEN p.Parcelas END "Parcelas"
FROM doacoes d
	INNER JOIN usuarios u ON u.CPF = d.Usuarios_CPF
	INNER JOIN pagamentos p ON p.Doacoes_ID = d.ID
        GROUP BY u.CPF HAVING (SELECT SUM(VALOR)) < (SELECT AVG(Valor) FROM pagamentos)
			ORDER BY u.NomeCompleto ASC, p.Valor;
            
-- Query 13: Lista de pagamentos do tipo cartão que foram feitas com pelo menos 2 parcelas
SELECT d.Usuarios_CPF "CPF", u.NomeCompleto "Nome Completo", d.`Data`, p.Valor, p.Tipo, p.Parcelas FROM doacoes d
	INNER JOIN pagamentos p ON p.Doacoes_ID = d.ID
	INNER JOIN usuarios u ON u.CPF = d.Usuarios_CPF
		WHERE p.Tipo LIKE "Cart%o" AND p.Parcelas >= 2
        ORDER BY p.Parcelas DESC;

-- Query 14: Lista de doações realizadas por administradores
SELECT u.CPF, u.NomeCompleto, DATE_FORMAT(d.`Data`, "%Y-%m-%d") "Data", p.Valor, p.Tipo FROM usuarios u 
	INNER JOIN administradores adm ON adm.Usuario_CPF = u.CPF
	INNER JOIN doacoes d ON d.Usuarios_CPF = adm.Usuario_CPF
	INNER JOIN pagamentos p ON p.Doacoes_ID = d.ID
		ORDER BY u.Nome;

-- Query 15: Doação de maior valor, trazendo os dados de contato do usuário
SELECT p.Valor, u.NomeCompleto "Nome Completo", u.Email, u.Telefone FROM usuarios u
	INNER JOIN doacoes d ON u.CPF = d.Usuarios_CPF
	INNER JOIN pagamentos p ON p.Doacoes_ID = d.ID
		WHERE p.Valor = (SELECT MAX(Valor) FROM pagamentos);

-- Query 16: Para cada pessoa que realizou pelo menos uma doação, listar o valor total doado e o percentual de participação no total de doações
SELECT u.CPF, u.NomeCompleto "Nome Completo", SUM(p.Valor) "Valor total doado",
CONCAT(TRUNCATE( (SUM(valor) / (SELECT SUM(valor) FROM pagamentos) )*100, 1), "%") "Participação no valor total das doações" -- isso aqui tá uma bagunça, mas é para retornar o percentual de participação no valor total das doações
FROM usuarios u
	INNER JOIN doacoes d ON u.CPF = d.Usuarios_CPF
	INNER JOIN pagamentos p ON p.Doacoes_ID = d.ID
		GROUP BY u.CPF
        ORDER BY SUM(p.Valor) DESC;

-- Query 17: Listar os cartões de créditos que vencem no próximo ano e o contato dos seus donos.
SELECT u.Nome, u.Email, cc.AnoMesVencimento, SUBSTRING(cc.Numero, -4) "Últimos dígitos do cartão", cc.Bandeira FROM usuarios_cartaodecredito ucc
	INNER JOIN cartaodecredito cc ON cc.Numero = ucc.CartaoDeCredito_Numero
    INNER JOIN usuarios u ON u.CPF = ucc.Usuarios_CPF
		WHERE YEAR(cc.DataVencimento) - YEAR(NOW()) <= 1;

-- Query 18: Listar a quantidade de doações que cada usuário realizou, independente do valor
SELECT u.NomeCompleto "Nome Completo", COUNT(u.CPF) "Doações Realizadas", u.Email, u.Telefone FROM pagamentos p
	INNER JOIN doacoes d ON d.ID = p.Doacoes_ID
    INNER JOIN usuarios u ON u.CPF = d.Usuarios_CPF
		GROUP BY u.CPF
			ORDER BY COUNT(u.CPF) DESC;

-- Query 19: Listar todas as publicações que foram postadas no mês de DEZEMBRO
SELECT u.Nome "Responsável", pub.Legenda, pub.Imagem, pub.`Data` FROM publicacoes pub
	INNER JOIN administradores adm ON adm.Usuario_CPF = pub.Administradores_Usuario_CPF
    INNER JOIN usuarios u ON u.CPF = pub.Administradores_Usuario_CPF
		WHERE MONTH(pub.`Data`) = 12
			ORDER BY pub.`Data` DESC, u.Nome ASC;
            
-- Query 20: Listar as doações em que o pagamento foi realizado em um dia diferente da doação (um exemplo seria pagamentos em boleto, onde você tem alguns dias para pagar)
SELECT d.ID "Número Doação", u.NomeCompleto "Nome Completo", u.CPF, u.Email, d.`Data` "Data Doação", p.DataPagamento "Data Pagamento", TIMESTAMPDIFF(DAY, d.`Data`, p.DataPagamento) "Pagou após (dias)" FROM pagamentos p
	INNER JOIN doacoes d ON d.ID = p.Doacoes_ID
	INNER JOIN usuarios u ON u.CPF = d.Usuarios_CPF
		ORDER BY d.ID;