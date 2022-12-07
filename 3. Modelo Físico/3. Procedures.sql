-- PROCEDURE 1 -----------------------------------------------------
DELIMITER //
CREATE PROCEDURE BuscarUsuario (IN Email VARCHAR(45), IN Senha CHAR(87))
BEGIN
	SELECT * FROM Usuarios U WHERE U.Email = Email AND U.Senha = Senha;
END //
DELIMITER ;
-- ---------------------------------------------------

-- PROCEDURE 2
DELIMITER //
CREATE PROCEDURE AdicionarUsuario (IN CPF VARCHAR(14), IN Nome VARCHAR(255), IN Sobrenome VARCHAR(255), IN Email VARCHAR(45), IN Telefone VARCHAR(14), IN Senha CHAR(87))
BEGIN
	INSERT INTO Usuarios VALUES (CPF, Nome, Sobrenome, Email, Telefone, Senha, NULL);
END //
DELIMITER ;
-- -----------------------------------------------------

-- PROCEDURE 3
DELIMITER //
CREATE PROCEDURE BuscarSenhaPorEmail (IN Email VARCHAR(45))
BEGIN
	SELECT Senha FROM Usuarios U WHERE U.Email = Email;
END // 
DELIMITER ;
-- ---------------------------------------------------

-- FUNCTION 1
-- RETORNA A BANDEIRA DO CARTÃO DE CRÉDITO A PARTIR DE SEU NÚMERO
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
