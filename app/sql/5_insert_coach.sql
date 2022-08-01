BEGIN TRANSACTION;

INSERT INTO coach (
	name,
	country
)

VALUES (
    'Vítor Pereira',
	'Brazil'
),
(
    'Paulo Pezzolano',
    'Brazil'
),
(
    'Dorival Júnior',
    'Brazil'
);

COMMIT TRANSACTION;