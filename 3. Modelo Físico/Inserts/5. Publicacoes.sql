INSERT INTO publicacoes (`ID`,`Administradores_Usuario_CPF`,`Data`,`Legenda`,`Imagem`) VALUES
(NULL,'003.401.585-06',NULL,'A próxima doação de sopa ocorrerá nesta quarta-feira(14/12)...',NULL),
(NULL,'003.401.585-06',NULL,'Saiba de tudo que ocorreu na nossa última reunião...',NULL),
(NULL,'429.877.404-09',NULL,'Nossa reunião para ajudar moradores de rua ocorr...',NULL),
(NULL,'429.877.404-09',NULL,'Legenda aqui.....',NULL),
(NULL,'003.401.585-06',NULL,'Legenda aqui....',NULL);

-- saber o caminho para guardar as imagens
select @@secure_file_priv;
-- adicionar as imagens
UPDATE publicacoes SET Imagem = LOAD_FILE("C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\imagem.formato")
WHERE ID = 1;
