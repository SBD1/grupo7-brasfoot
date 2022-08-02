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
    'Palmeiras',
    'SP',
	'Brazil'
),
(
	'Flamengo',
	'RJ',
	'Brazil'
),
(
	'Fluminense',
	'RJ',
	'Brazil'
),
(
	'AthleticoPR',
	'PR',
	'Brazil'
),
(
	'Internacional',
	'RS',
	'Brazil'
),
(
	'AtleticoMG',
	'MG',
	'Brazil'
),
(
	'Bragantino',
	'SP',
	'Brazil'
),
(
	'SaoPaulo',
	'SP',
	'Brazil'
),
(
	'Cruzeiro',
	'MG',
	'Brazil'
);

COMMIT TRANSACTION;