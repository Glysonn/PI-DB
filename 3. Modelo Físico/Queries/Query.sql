-- Query 1: LISTA DE TODAS AS DOAÇÕES MOSTRANDO NOME, VALOR, DATA E O TIPO DO PAGAMENTO ORDENADOS PELO VALOR
SELECT u.Nome, p.Valor, p.DataPagamento, p.Tipo FROM pagamentos p
	INNER JOIN doacoes d ON d.ID = p.Doacoes_ID
	INNER JOIN usuarios u ON u.CPF = d.Usuarios_CPF
		ORDER BY p.Valor DESC;
        
-- Query 2: LISTA DE TODAS AS PESSOAS QUE TEM MAIS DE UM CARTÃO DE CRÉDITO SALVO NA CONTA, TRAZENDO OS NÚMEROS E O NOME DA PESSOA ORDENADO POR NOME
SELECT ucc.CartaoDeCredito_Numero "Cartão de crédito", u.Nome FROM usuarios_cartaodecredito ucc
	INNER JOIN usuarios u ON u.CPF = ucc.Usuarios_CPF
		GROUP BY CartaoDeCredito_Numero 
			HAVING count(CartaoDeCredito_Numero) > 1;

-- Query 3: mostrar a quantidade de cartões registrados para cada bandeira
SELECT count(Bandeira) "Quantidade de cartões", Bandeira FROM cartaodecredito
	GROUP BY Bandeira
		ORDER BY count(Bandeira) DESC;

-- Query 4: trazer todos os posts, e o nome do adm que fez, ordenado por data
SELECT u.Nome, pub.Legenda, pub.Imagem, pub.`Data` FROM publicacoes pub
	INNER JOIN administradores adm ON adm.Usuario_CPF = pub.Administradores_Usuario_CPF
    INNER JOIN usuarios u ON u.CPF = pub.Administradores_Usuario_CPF
		ORDER BY pub.`Data`, u.Nome;

-- Query 5: Lista de todas as pessoas que possuem cartão de crédito salvo, trazendo o nome completo, email, o número do cartão e o titular do cartão
SELECT u.NomeCompleto, u.Email, cc.Numero "Número do Cartão", cc.NomeTitular "Titular do cartão" FROM usuarios_cartaodecredito ucc
	INNER JOIN cartaodecredito cc ON cc.Numero = ucc.CartaoDeCredito_Numero
    INNER JOIN usuarios u on u.CPF = ucc.Usuarios_CPF
        ORDER BY Nome;
        
-- Query 6: TRAGA TODOS OS CARTÕES ONDE OS USUÁRIOS SÃO OS TITULARES DO CARTÃO
SELECT u.Nome, u.Email, cc.Numero "Número do Cartão", cc.NomeTitular "Titular do cartão" FROM usuarios_cartaodecredito ucc
	INNER JOIN cartaodecredito cc ON cc.Numero = ucc.CartaoDeCredito_Numero
    INNER JOIN usuarios u on u.CPF = ucc.Usuarios_CPF
		WHERE SUBSTRING_INDEX( u.NomeCompleto, ' ', 1 ) = SUBSTRING_INDEX( cc.NomeTitular, ' ', 1 )
		AND SUBSTRING_INDEX( u.NomeCompleto, ' ', -1 ) = SUBSTRING_INDEX( cc.NomeTitular, ' ', -1 )
        ORDER BY Nome;

-- Query 7
