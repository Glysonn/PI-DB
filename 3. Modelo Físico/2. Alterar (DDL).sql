-- Alterar tabelas (EXECUTAR LOGO APÓS A CRIAÇÃO DO BANCO)
ALTER TABLE usuarios MODIFY COLUMN Nome VARCHAR(55);
ALTER TABLE usuarios MODIFY COLUMN Sobrenome VARCHAR(200);
ALTER TABLE usuarios MODIFY COLUMN Telefone VARCHAR(15);
ALTER TABLE usuarios RENAME COLUMN HashSenha to Senha;
ALTER TABLE pagamentos MODIFY COLUMN DataPagamento DATETIME NULL;
ALTER TABLE doacoes MODIFY COLUMN `Data` DATETIME NULL;
ALTER TABLE publicacoes MODIFY COLUMN Imagem LONGBLOB NULL;
