BEGIN TRANSACTION;

INSERT INTO player (
	name,
	team,
	age,
	position,
	side,
	strength,
	energy,
	salary,
    contract_due_date,
	market_value,
	feature1,
	feature2
)

VALUES (
	'Cássio',
    (SELECT id FROM public.team WHERE team.name = 'Corinthians'),
	35,
	'G',
	'E',
	71,
    100,
	100000.00,
    '01/01/2023',
	1900000.00,
	'saida gol',
	'penalty'
),
(
    'Rafael Cabral',
    (SELECT id FROM public.team WHERE team.name = 'Cruzeiro'),
    32,
    'G',
    'D',
    60,
    100,
    50000.00,
    '01/01/2023',
    550000.00,
    'saida gol',
	'reflexo'
),
(
    'Santos',
    (SELECT id FROM public.team WHERE team.name = 'Flamengo'),
    32,
    'G',
    'D',
    72,
    100,
    300000.00,
    '01/01/2023',
    3700000.00,
    'penalty',
    'reflexo'
 );

COMMIT TRANSACTION;