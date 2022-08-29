BEGIN TRANSACTION;

INSERT INTO trains (
	coach,
	team,
    name_team
)

VALUES (
    (SELECT id FROM public.coach WHERE coach.name = 'Vítor Pereira'),
	(SELECT id FROM public.team WHERE team.name = 'Corinthians'),
    (SELECT name FROM public.team WHERE team.id = (SELECT id FROM public.team WHERE team.name = 'Corinthians'))
),
(
    (SELECT id FROM public.coach WHERE coach.name = 'Paulo Pezzolano'),
	(SELECT id FROM public.team WHERE team.name = 'Cruzeiro'),
    (SELECT name FROM public.team WHERE team.id = (SELECT id FROM public.team WHERE team.name = 'Cruzeiro'))
),
(
    (SELECT id FROM public.coach WHERE coach.name = 'Dorival Júnior'),
	(SELECT id FROM public.team WHERE team.name = 'Flamengo'),
     (SELECT name FROM public.team WHERE team.id = (SELECT id FROM public.team WHERE team.name = 'Flamengo'))
);

COMMIT TRANSACTION;