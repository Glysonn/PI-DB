-- TRIGGER 1
-- Preenche automaticamente a coluna NomeCompleto da tabela usuarios
DELIMITER //
CREATE TRIGGER tgr_usuarios_Insert_Bf BEFORE INSERT ON usuarios
FOR EACH ROW
BEGIN
	SET NEW.NomeCompleto = CONCAT(NEW.Nome, ' ', NEW.Sobrenome);
END //
DELIMITER ;

-- TRIGGER 2
-- Salva o mês e ano da data de vencimento
DELIMITER //
CREATE TRIGGER tgr_cartaodecredito_Insert_Bf BEFORE INSERT ON cartaodecredito
FOR EACH ROW
BEGIN
	SET NEW.MesAnoVencimento = DATE_FORMAT(NEW.DataVencimento, "%y/%m");
END //
DELIMITER ;

-- TRIGGER 3
-- Insere a hora atual no campo "Data" automaticamente
DELIMITER //
CREATE TRIGGER tgr_doacoes_Insert_Bf BEFORE INSERT ON doacoes
FOR EACH ROW
BEGIN
	SET NEW.`Data` = NOW();
END //
DELIMITER ;


-- TRIGGER 4
-- Insere a hora atual no campo "DataPagamento" automaticamente
DELIMITER //
CREATE TRIGGER tgr_pagamentos_Insert_Bf BEFORE INSERT ON pagamentos
FOR EACH ROW
BEGIN
	SET NEW.DataPagamento = NOW();
END //
DELIMITER ;


-- TRIGGER 5
-- Insere a Bandeira do cartão de acordo com o seu número
DELIMITER //
CREATE TRIGGER tgr_Numerocartaodecredito_Insert_Bf BEFORE INSERT ON cartaodecredito
FOR EACH ROW
BEGIN
	SET NEW.Bandeira = BandeiraDoCartao(NEW.Numero);
END //
DELIMITER ;