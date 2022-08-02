BEGIN TRANSACTION;

INSERT INTO player (name, team, age, position, side, strength, energy, salary, contract_due|_date, market_value, feature1, feature2)

-- Corinthians
VALUES ('Cassio', (SELECT id FROM public.team WHERE team.name = 'Corinthians'), 35, 'G', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Rafael Ramos', (SELECT id FROM public.team WHERE team.name = 'Corinthians'), 27, 'L', 'D', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Balbuena', (SELECT id FROM public.team WHERE team.name = 'Corinthians'), 30, 'Z', 'D', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Bruno Méndez', (SELECT id FROM public.team WHERE team.name = 'Corinthians'), 22, 'Z', 'D', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Fabio Santos', (SELECT id FROM public.team WHERE team.name = 'Corinthians'), 36, 'L', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Maycon', (SELECT id FROM public.team WHERE team.name = 'Corinthians'), 24, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Fausto Vera', (SELECT id FROM public.team WHERE team.name = 'Corinthians'), 22, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Du Queiroz', (SELECT id FROM public.team WHERE team.name = 'Corinthians'), 22, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Yuri Alberto', (SELECT id FROM public.team WHERE team.name = 'Corinthians'), 21, 'A', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Adson', (SELECT id FROM public.team WHERE team.name = 'Corinthians'), 21, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Willian', (SELECT id FROM public.team WHERE team.name = 'Corinthians'), 33, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),

-- Flamengo
('Santos', (SELECT id FROM public.team WHERE team.name = 'Flamengo'), 32, 'G', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Rodinei', (SELECT id FROM public.team WHERE team.name = 'Flamengo'), 30, 'L', 'D', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Fabricio Bruno', (SELECT id FROM public.team WHERE team.name = 'Flamengo'), 26, 'Z', 'D', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Pablo', (SELECT id FROM public.team WHERE team.name = 'Flamengo'), 31, 'Z', 'D', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Ayrton Lucas', (SELECT id FROM public.team WHERE team.name = 'Flamengo'), 25, 'L', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Thiago Maia', (SELECT id FROM public.team WHERE team.name = 'Flamengo'), 25, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Diego', (SELECT id FROM public.team WHERE team.name = 'Flamengo'), 37, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Everton Ribeiro', (SELECT id FROM public.team WHERE team.name = 'Flamengo'), 33, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Vitinho', (SELECT id FROM public.team WHERE team.name = 'Flamengo'), 28, 'A', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Gabriel', (SELECT id FROM public.team WHERE team.name = 'Flamengo'), 25, 'A', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Everton', (SELECT id FROM public.team WHERE team.name = 'Flamengo'), 26, 'A', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),

-- Palmeiras
('Weverton', (SELECT id FROM public.team WHERE team.name = 'Palmeiras'), 34, 'G', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Mayke', (SELECT id FROM public.team WHERE team.name = 'Palmeiras'), 29, 'L', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Gustavo Gomez', (SELECT id FROM public.team WHERE team.name = 'Palmeiras'), 29, 'Z', 'D', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Murilo', (SELECT id FROM public.team WHERE team.name = 'Palmeiras'), 25, 'Z', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Vanderlan', (SELECT id FROM public.team WHERE team.name = 'Palmeiras'), 19, 'L', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Danilo', (SELECT id FROM public.team WHERE team.name = 'Palmeiras'), 21, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Ze Rafael', (SELECT id FROM public.team WHERE team.name = 'Palmeiras'), 29, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Gustavo Scarpa', (SELECT id FROM public.team WHERE team.name = 'Palmeiras'), 28, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Gabriel Menino', (SELECT id FROM public.team WHERE team.name = 'Palmeiras'), 21, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Breno Lopes', (SELECT id FROM public.team WHERE team.name = 'Palmeiras'), 26, 'A', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Rafael Navarro', (SELECT id FROM public.team WHERE team.name = 'Palmeiras'), 22, 'A', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),

-- Fluminense
('Fabio', (SELECT id FROM public.team WHERE team.name = 'Fluminense'), 41, 'G', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('David Duarte', (SELECT id FROM public.team WHERE team.name = 'Fluminense'), 27, 'Z', 'D', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Nino', (SELECT id FROM public.team WHERE team.name = 'Fluminense'), 25, 'Z', 'D', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Manoel', (SELECT id FROM public.team WHERE team.name = 'Fluminense'), 32, 'Z', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Caio Paulista', (SELECT id FROM public.team WHERE team.name = 'Fluminense'), 24, 'L', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Andre', (SELECT id FROM public.team WHERE team.name = 'Fluminense'), 21, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Martinelli', (SELECT id FROM public.team WHERE team.name = 'Fluminense'), 20, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Matheus Martins', (SELECT id FROM public.team WHERE team.name = 'Fluminense'), 19, 'A', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Felipe Melo', (SELECT id FROM public.team WHERE team.name = 'Fluminense'), 39, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Marrony', (SELECT id FROM public.team WHERE team.name = 'Fluminense'), 23, 'A', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Cano', (SELECT id FROM public.team WHERE team.name = 'Fluminense'), 34, 'A', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),

-- Athlético-PR
('Bento', (SELECT id FROM public.team WHERE team.name = 'AthleticoPR'), 23, 'G', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Khellven', (SELECT id FROM public.team WHERE team.name = 'AthleticoPR'), 21, 'L', 'D', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Matheus Felipe', (SELECT id FROM public.team WHERE team.name = 'AthleticoPR'), 23, 'Z', 'D', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Thiago Heleno', (SELECT id FROM public.team WHERE team.name = 'AthleticoPR'), 33, 'Z', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Pedrinho', (SELECT id FROM public.team WHERE team.name = 'AthleticoPR'), 19, 'L', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Fernandinho', (SELECT id FROM public.team WHERE team.name = 'AthleticoPR'), 37, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Erick', (SELECT id FROM public.team WHERE team.name = 'AthleticoPR'), 24, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Leo Cittadini', (SELECT id FROM public.team WHERE team.name = 'AthleticoPR'), 28, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Marcelo Cirino', (SELECT id FROM public.team WHERE team.name = 'AthleticoPR'), 30, 'A', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Vitinho', (SELECT id FROM public.team WHERE team.name = 'AthleticoPR'), 23, 'A', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Romulo', (SELECT id FROM public.team WHERE team.name = 'AthleticoPR'), 20, 'A', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),

-- Internacional
('Daniel', (SELECT id FROM public.team WHERE team.name = 'Internacional'), 28, 'G', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Bustos', (SELECT id FROM public.team WHERE team.name = 'Internacional'), 26, 'L', 'D', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Vitao', (SELECT id FROM public.team WHERE team.name = 'Internacional'), 22, 'Z', 'D', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Kaique Rocha', (SELECT id FROM public.team WHERE team.name = 'Internacional'), 21, 'Z', 'D', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Rene', (SELECT id FROM public.team WHERE team.name = 'Internacional'), 29, 'L', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Gabriel', (SELECT id FROM public.team WHERE team.name = 'Internacional'), 30, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Edenilson', (SELECT id FROM public.team WHERE team.name = 'Internacional'), 32, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Carlos de Pena', (SELECT id FROM public.team WHERE team.name = 'Internacional'), 30, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Johnny', (SELECT id FROM public.team WHERE team.name = 'Internacional'), 20, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Braian Romero', (SELECT id FROM public.team WHERE team.name = 'Internacional'), 31, 'A', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Pedro Henrique', (SELECT id FROM public.team WHERE team.name = 'Internacional'), 32, 'A', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),

-- Atletico-MG
('Everson', (SELECT id FROM public.team WHERE team.name = 'AtleticoMG'), 32, 'G', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Mariano', (SELECT id FROM public.team WHERE team.name = 'AtleticoMG'), 36, 'L', 'D', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Nathan Silva', (SELECT id FROM public.team WHERE team.name = 'AtleticoMG'), 25, 'Z', 'D', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Junior Alonso', (SELECT id FROM public.team WHERE team.name = 'AtleticoMG'), 29, 'Z', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Guilherme Arana', (SELECT id FROM public.team WHERE team.name = 'AtleticoMG'), 25, 'L', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Allan', (SELECT id FROM public.team WHERE team.name = 'AtleticoMG'), 25, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Jair', (SELECT id FROM public.team WHERE team.name = 'AtleticoMG'), 27, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Nacho Fernandez', (SELECT id FROM public.team WHERE team.name = 'AtleticoMG'), 32, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Ademir', (SELECT id FROM public.team WHERE team.name = 'AtleticoMG'), 27, 'A', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Keno', (SELECT id FROM public.team WHERE team.name = 'AtleticoMG'), 32, 'A', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Hulk', (SELECT id FROM public.team WHERE team.name = 'AtleticoMG'), 36, 'A', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),

-- Bragantino
('Cleiton', (SELECT id FROM public.team WHERE team.name = 'Bragantino'), 24, 'G', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Aderlan', (SELECT id FROM public.team WHERE team.name = 'Bragantino'), 31, 'L', 'D', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Leo Ortiz', (SELECT id FROM public.team WHERE team.name = 'Bragantino'), 26, 'Z', 'D', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Natan', (SELECT id FROM public.team WHERE team.name = 'Bragantino'), 21, 'Z', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Luan Candido', (SELECT id FROM public.team WHERE team.name = 'Bragantino'), 21, 'L', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Lucas Evangelista', (SELECT id FROM public.team WHERE team.name = 'Bragantino'), 27, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Raul', (SELECT id FROM public.team WHERE team.name = 'Bragantino'), 26, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Praxedes', (SELECT id FROM public.team WHERE team.name = 'Bragantino'), 20, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Artur', (SELECT id FROM public.team WHERE team.name = 'Bragantino'), 24, 'A', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Jan Hurtado', (SELECT id FROM public.team WHERE team.name = 'Bragantino'), 22, 'A', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Helinho', (SELECT id FROM public.team WHERE team.name = 'Bragantino'), 22, 'A', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),

-- São Paulo
('Felipe Alves', (SELECT id FROM public.team WHERE team.name = 'SaoPaulo'), 34, 'G', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Rafinha', (SELECT id FROM public.team WHERE team.name = 'SaoPaulo'), 36, 'L', 'D', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Miranda', (SELECT id FROM public.team WHERE team.name = 'SaoPaulo'), 37, 'Z', 'D', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Luizao', (SELECT id FROM public.team WHERE team.name = 'SaoPaulo'), 20, 'Z', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Joao Moreira', (SELECT id FROM public.team WHERE team.name = 'SaoPaulo'), 18, 'L', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Pablo Maia', (SELECT id FROM public.team WHERE team.name = 'SaoPaulo'), 20, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Talles', (SELECT id FROM public.team WHERE team.name = 'SaoPaulo'), 19, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Galoppo', (SELECT id FROM public.team WHERE team.name = 'SaoPaulo'), 23, 'M', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Rodriguinho', (SELECT id FROM public.team WHERE team.name = 'SaoPaulo'), 18, 'A', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Marcos Guilherme', (SELECT id FROM public.team WHERE team.name = 'SaoPaulo'), 26, 'A', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao'),
('Nikao', (SELECT id FROM public.team WHERE team.name = 'SaoPaulo'), 30, 'A', 'E', 50, 100, 15000.00, '01/01/2023', 2.00, 'Penalty', 'Colocacao');


COMMIT TRANSACTION;