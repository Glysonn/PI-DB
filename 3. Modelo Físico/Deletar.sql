-- Dados que serão inseridos para serem DELETADOS
INSERT INTO usuarios (`CPF`,`Nome`,`Sobrenome`,`Email`,`Telefone`,`Senha`,`NomeCompleto`) VALUES ("929.661.524-00", "Vou ser", "Apagado", "naotenhoemail@email.com", "(81)988888888", "$pbkdf2-sha256$50000$4fyf8x5jTAkhpLQ2ZizlnA$wOHwL.Vyc4tFTDx.X3zWFd0.vU/MJacBBz5IiFAj1Zs", NULL), ("129.651.524-00", "Ueblers", "Xeblers", "ueblers@email.com", "(81)912895688", "$pbkdf2-sha256$50000$c46R8r4XAiCkFAKA8J7zPg$Oc43vGhJabZZdPUhtR2Z7koV5t8SMwVPBds5al.Wn9g", NULL);
INSERT INTO administradores (`Usuario_CPF`) VALUES ('129.651.524-00');
INSERT INTO publicacoes (`ID`,`Administradores_Usuario_CPF`,`Data`,`Legenda`,`Imagem`) VALUES (NULL,'129.651.524-00',NULL,'É pra ser apagado',NULL);



UPDATE usuarios SET Nome = "Eu estou sendo" WHERE CPF = "929.661.524-00";
UPDATE usuarios SET Sobrenome = "Apagado!" WHERE CPF = "929.661.524-00";
UPDATE usuarios SET Nome = "Não me apaga" WHERE CPF = "129.651.524-00";
UPDATE usuarios SET Sobrenome = "Por favor" WHERE CPF = "129.331.524-00";
UPDATE usuarios SET Telefone = "(81)995666220" WHERE CPF = "929.661.524-00";
UPDATE usuarios SET Telefone = "(81)937822210" WHERE CPF = "129.331.524-00";
UPDATE publicacoes SET Legenda = "Mudando a legenda" WHERE Administradores_Usuario_CPF = "129.651.524-00";
-- 
DELETE FROM usuarios WHERE CPF = "929.661.524-00";
DELETE FROM usuarios WHERE CPF = "129.651.524-00";
DELETE FROM administradores WHERE Usuario_CPF = "129.651.524-00";
DELETE FROM publicacoes WHERE Administradores_Usuario_CPF = "929.661.524-00";