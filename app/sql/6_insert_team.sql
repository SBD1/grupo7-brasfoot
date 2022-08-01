BEGIN TRANSACTION;

INSERT INTO team (
	name,
	state_br,
	country
)

VALUES (
    'Corinthians',
	'SP',
	'Brazil'
),
(
    'Cruzeiro',
    'MG',
	'Brazil'
),
(
	'Flamengo',
	'RJ',
	'Brazil'
);

COMMIT TRANSACTION;