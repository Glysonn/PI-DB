INSERT INTO usuarios_cartaodecredito (`Usuarios_CPF`,`CartaoDeCredito_Numero`)
VALUES ('123.456.789-00','4389 3514 7562 8012'),
('411.800.454-24','4389 3514 7562 8012'),
('123.456.789-00','3463 6883 6202 8441'),
('295.705.164-88','3463 6883 6202 8441'),
('309.608.974-45','3478 7047 3232 8100'),
('198.118.514-33','5273 3910 2249 6584'),
('212.341.773-23','5176 2881 7872 0130'),
('361.119.764-51','5341 7542 9637 5720'),
('986.836.624-03','5346 2915 7626 3377'),
('021.131.621-05','5417 6687 5181 4070'),
('376.365.854-80','5576 3284 5336 4547'),
('514.698.984-20','6011 2329 1152 1816');

SELECT CartaoDeCredito_Numero "Cartão de crédito", u.Nome FROM usuarios_cartaodecredito ucc
inner join usuarios u on u.CPF = ucc.Usuarios_CPF GROUP BY CartaoDeCredito_Numero having count(CartaoDeCredito_Numero) > 1;