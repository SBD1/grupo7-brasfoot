BEGIN TRANSACTION;

INSERT INTO stadium (
	team,
	capacity,
	ticket_price
)

VALUES (
    (SELECT id FROM public.team WHERE team.name = 'Corinthians'),
	40000,
	15.00
),
(
    (SELECT id FROM public.team WHERE team.name = 'Cruzeiro'),
	50000,
	10.00
),
(
    (SELECT id FROM public.team WHERE team.name = 'Flamengo'),
	45000,
	5.00
);

COMMIT TRANSACTION;