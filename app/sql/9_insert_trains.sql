BEGIN TRANSACTION;

INSERT INTO trains (
	coach,
	team,
	public_trust,
	board_trust
)

VALUES (
    (SELECT id FROM public.coach WHERE coach.name = 'Vítor Pereira'),
	(SELECT id FROM public.team WHERE team.name = 'Corinthians'),
    (SELECT name FROM public.team WHERE team.id = (SELECT id FROM public.team WHERE team.name = 'Corinthians')),
	100,
	100
),
(
    (SELECT id FROM public.coach WHERE coach.name = 'Paulo Pezzolano'),
	(SELECT id FROM public.team WHERE team.name = 'Cruzeiro'),
    (SELECT name FROM public.team WHERE team.id = (SELECT id FROM public.team WHERE team.name = 'Cruzeiro')),
	100,
	100
),
(
    (SELECT id FROM public.coach WHERE coach.name = 'Dorival Júnior'),
	(SELECT id FROM public.team WHERE team.name = 'Flamengo'),
     (SELECT name FROM public.team WHERE team.id = (SELECT id FROM public.team WHERE team.name = 'Flamengo')),
	100,
	100
);

COMMIT TRANSACTION;