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


