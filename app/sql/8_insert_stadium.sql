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
    (SELECT id FROM public.team WHERE team.name = 'Palmeiras'),
	50000,
	10.00
),
(
    (SELECT id FROM public.team WHERE team.name = 'Flamengo'),
	45000,
	5.00
),
(
    (SELECT id FROM public.team WHERE team.name = 'Fluminense'),
	50000,
	10.00
),
(
    (SELECT id FROM public.team WHERE team.name = 'AthleticoPR'),
	45000,
	5.00
),
(
    (SELECT id FROM public.team WHERE team.name = 'Internacional'),
	50000,
	10.00
),
(
    (SELECT id FROM public.team WHERE team.name = 'AtleticoMG'),
	45000,
	5.00
),
(
    (SELECT id FROM public.team WHERE team.name = 'Bragantino'),
	50000,
	10.00
),
(
    (SELECT id FROM public.team WHERE team.name = 'SaoPaulo'),
	45000,
	5.00
),
(
    (SELECT id FROM public.team WHERE team.name = 'Cruzeiro'),
	70000,
	45.00
);

COMMIT TRANSACTION;