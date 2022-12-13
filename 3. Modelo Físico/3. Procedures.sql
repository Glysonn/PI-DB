-- 1
DELIMITER //
CREATE PROCEDURE BuscarUsuario (IN Email VARCHAR(45), IN Senha CHAR(87))
BEGIN
	SELECT * FROM Usuarios U WHERE U.Email = Email AND U.Senha = Senha;
END //
DELIMITER ;

-- 2
DELIMITER //
CREATE PROCEDURE AdicionarUsuario (IN CPF VARCHAR(14), IN Nome VARCHAR(255), IN Sobrenome VARCHAR(255), IN Email VARCHAR(45), IN Telefone VARCHAR(14), IN Senha CHAR(87))
BEGIN
	INSERT INTO Usuarios VALUES (CPF, Nome, Sobrenome, Email, Telefone, Senha, NULL);
END //
DELIMITER ;

-- 3
DELIMITER //
CREATE PROCEDURE BuscarSenhaPorEmail (IN Email VARCHAR(45))
BEGIN
	SELECT Senha FROM Usuarios U WHERE U.Email = Email;
END // 
DELIMITER ;

-- 4
DELIMITER //
CREATE FUNCTION BandeiraDoCartao(NumeroCartao VARCHAR(19)) RETURNS VARCHAR(45) DETERMINISTIC
BEGIN
	DECLARE Bandeira VARCHAR(45);
	SELECT CASE
		WHEN substring(NumeroCartao FROM 1 FOR 2) LIKE "4%" THEN "VISA"
		WHEN substring(NumeroCartao FROM 1 FOR 2) LIKE "51" OR substring(NumeroCartao FROM 1 FOR 2) LIKE "52" OR substring(NumeroCartao FROM 1 FOR 2) LIKE "53" OR substring(NumeroCartao FROM 1 FOR 2) LIKE "54" OR substring(NumeroCartao FROM 1 FOR 2) LIKE "55" THEN "Mastercard"
		WHEN substring(NumeroCartao FROM 1 FOR 2) LIKE "36" OR substring(NumeroCartao FROM 1 FOR 2) LIKE "38" THEN "Diners Club"
		WHEN substring(NumeroCartao FROM 1 FOR 4) LIKE "6011" OR substring(NumeroCartao FROM 1 FOR 2) LIKE "65" THEN "Discover"
		WHEN substring(NumeroCartao FROM 1 FOR 2) LIKE "35" THEN "JBC"
		WHEN substring(NumeroCartao FROM 1 FOR 2) LIKE "34" OR substring(NumeroCartao FROM 1 FOR 2) LIKE "37" THEN "American Express"
		ELSE NULL
	END INTO Bandeira;
  RETURN Bandeira;
END //
DELIMITER ;

-- 5
DELIMITER //
CREATE PROCEDURE FazerDoacao (IN CPF VARCHAR(14), IN Valor DECIMAL (6,2), IN Tipo ENUM('Cartao', 'Pix', 'Boleto'), IN Parcelas TINYINT)
BEGIN
	SELECT CASE WHEN Tipo != "Cartao" THEN NULL END INTO Parcelas;
	INSERT INTO doacoes VALUES (NULL, CPF, NULL);
    INSERT INTO pagamentos VALUES (last_insert_id(), Valor, NULL, Tipo, NULL);
END // 
DELIMITER ;

-- 6
DELIMITER //
CREATE PROCEDURE VerDoacoesPorTipo (IN Tipo ENUM('Cartao', 'Pix', 'Boleto'))
BEGIN
	SELECT u.Nome, p.Valor, p.DataPagamento, p.Tipo FROM pagamentos p
	INNER JOIN doacoes d ON d.ID = p.Doacoes_ID
	INNER JOIN usuarios u ON u.CPF = d.Usuarios_CPF
    WHERE p.Tipo = Tipo;
END // 
DELIMITER ;

-- 7
DELIMITER //
CREATE PROCEDURE AlterarSenhaUsuario (IN CPF VARCHAR(14), IN Senha CHAR(87))
BEGIN
	UPDATE usuarios SET usuarios.senha = Senha WHERE usuarios.CPF = CPF;
END // 
DELIMITER ;

-- 8
DELIMITER //
CREATE PROCEDURE DoacoesPorUsuario (IN CPF VARCHAR(14))
BEGIN
	SELECT u.NomeCompleto, p.Valor "Valor (R$)", p.DataPagamento, p.Tipo FROM pagamentos p
	INNER JOIN doacoes d ON d.ID = p.Doacoes_ID
	INNER JOIN usuarios u ON u.CPF = d.Usuarios_CPF
		WHERE u.CPF = CPF
			ORDER BY p.Valor DESC;
END //
DELIMITER ;