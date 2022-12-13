-- View 1: Lista de doações
CREATE VIEW ListaDoacoes AS
	SELECT u.Nome, p.Valor, p.DataPagamento, p.Tipo FROM pagamentos p
		INNER JOIN doacoes d ON d.ID = p.Doacoes_ID
		INNER JOIN usuarios u ON u.CPF = d.Usuarios_CPF
			ORDER BY p.Valor DESC;

-- View 2: Valor total em pagamentos do ano 2022
CREATE VIEW ValorTotalPagamentos22 AS
	SELECT YEAR(d.`Data`) "Ano", SUM(p.Valor) "Valor Total (R$)" FROM pagamentos p
		INNER JOIN doacoes d ON d.ID = p.Doacoes_ID
		INNER JOIN usuarios u ON u.CPF = d.Usuarios_CPF
			WHERE YEAR(d.`Data`) = "2022"
				GROUP BY YEAR(p.`DataPagamento`)
					ORDER BY p.`DataPagamento` ASC;

-- View 3: Valor total em pagamentos de cada MÊS do ano 2022
CREATE VIEW ValorTotalPorMes22 AS
	SELECT CONCAT(MONTH(d.`Data`),"/", YEAR(d.`Data`)) "Período", SUM(p.Valor) "Valor Total (R$)" FROM pagamentos p
		INNER JOIN doacoes d ON d.ID = p.Doacoes_ID
		INNER JOIN usuarios u ON u.CPF = d.Usuarios_CPF
			WHERE YEAR(d.`Data`) = "2022"
			GROUP BY YEAR(p.`DataPagamento`), MONTH(p.`DataPagamento`)
				ORDER BY p.`DataPagamento` ASC;

-- View 4: Pessoas que possuem mais de um cartão de crédito salvo
CREATE VIEW MaisDeUmCartao AS
	SELECT ucc.CartaoDeCredito_Numero "Cartão de crédito", u.Nome FROM usuarios_cartaodecredito ucc
		INNER JOIN usuarios u ON u.CPF = ucc.Usuarios_CPF
			GROUP BY CartaoDeCredito_Numero 
				HAVING count(CartaoDeCredito_Numero) > 1;

-- View 5: Todas as publicações e quem fez
CREATE VIEW TodasPublicacoes AS
	SELECT u.Nome "Responsável", pub.Legenda, pub.Imagem, pub.`Data` FROM publicacoes pub
		INNER JOIN administradores adm ON adm.Usuario_CPF = pub.Administradores_Usuario_CPF
		INNER JOIN usuarios u ON u.CPF = pub.Administradores_Usuario_CPF
			ORDER BY pub.`Data` DESC, u.Nome ASC;

-- View 6: Todas as pessoas que possuem pelo menos UM cartão salvo na conta
CREATE VIEW PessoasCartoesSalvos AS
	SELECT u.NomeCompleto, u.Email, cc.Numero "Número do Cartão", cc.NomeTitular "Titular do cartão" FROM usuarios_cartaodecredito ucc
		INNER JOIN cartaodecredito cc ON cc.Numero = ucc.CartaoDeCredito_Numero
		LEFT JOIN usuarios u on u.CPF = ucc.Usuarios_CPF
			ORDER BY Nome;

-- View 7: Lista de cartões onde os usuários são os titulares do cartão.
CREATE VIEW PessoasTitularesCartao AS
	SELECT u.Nome, u.Email, cc.Numero "Número do Cartão", cc.NomeTitular "Titular do cartão" FROM usuarios_cartaodecredito ucc
		INNER JOIN cartaodecredito cc ON cc.Numero = ucc.CartaoDeCredito_Numero
		INNER JOIN usuarios u on u.CPF = ucc.Usuarios_CPF
			WHERE SUBSTRING_INDEX( u.NomeCompleto, ' ', 1 ) = SUBSTRING_INDEX( cc.NomeTitular, ' ', 1 )
			AND SUBSTRING_INDEX( u.NomeCompleto, ' ', -1 ) = SUBSTRING_INDEX( cc.NomeTitular, ' ', -1 )
				ORDER BY Nome;

-- View 8: Lista de doações que foram realizadas por administradores
CREATE VIEW DoacoesAdms AS
	SELECT u.CPF, u.NomeCompleto, DATE_FORMAT(d.`Data`, "%Y-%m-%d") "Data", p.Valor, p.Tipo FROM usuarios u 
		INNER JOIN administradores adm ON adm.Usuario_CPF = u.CPF
		INNER JOIN doacoes d ON d.Usuarios_CPF = adm.Usuario_CPF
		INNER JOIN pagamentos p ON p.Doacoes_ID = d.ID
			ORDER BY u.Nome;

-- View 9: Doação de maior valor, e o contato de quem fez
CREATE VIEW DoacaoMaiorValor AS
	SELECT p.Valor, u.NomeCompleto "Nome Completo", u.Email, u.Telefone FROM usuarios u
		INNER JOIN doacoes d ON u.CPF = d.Usuarios_CPF
		INNER JOIN pagamentos p ON p.Doacoes_ID = d.ID
			WHERE p.Valor = (SELECT MAX(Valor) FROM pagamentos);

-- View 10: Valor total doado por cada pessoa e a porcentagem de contribuição comparado ao total de todos os valores.
CREATE VIEW PorcentagemContribuicao AS
	SELECT u.CPF, u.NomeCompleto "Nome Completo", SUM(p.Valor) "Valor total doado",
	CONCAT(TRUNCATE( (SUM(valor) / (SELECT SUM(valor) FROM pagamentos) )*100, 1), "%") "Participação no valor total das doações" -- isso aqui tá uma bagunça, mas é para retornar o percentual de participação no valor total das doações
	FROM usuarios u
		INNER JOIN doacoes d ON u.CPF = d.Usuarios_CPF
		INNER JOIN pagamentos p ON p.Doacoes_ID = d.ID
			GROUP BY u.CPF
				ORDER BY SUM(p.Valor) DESC;