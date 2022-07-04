# Modelo Relacional

|    Data    | Versão | Descrição | Autor |
| :---: | :----: | :---: | :---: |
| 03/07/2022 | 0.1 | Início do Documento | [Daniel Oda](https://github.com/danieloda) |



## O que é?

O MREL (Modelo Relacional) é utilizado para apoiar a implementação das aplicações, apresentando um projeto lógico de como as entidades e relacionamentos serão mapeadas no SGBD, porém é um modelo lógico não atrelado a algum SGBD específico.

## Entidades

- **coach** { <ins>id_coach</ins>,  name, nationality }
- **team** { <ins>id_team</ins>, id_coach, name, country, state, balance }
- **finance** { <ins>id_finance</ins>, id_team, year, month, description, monthly_cost_or_gain }
- **stadium** { <ins>id_stadium</ins>, id_team, capacity, ticket_value }
- **player** { <ins>id_player</ins>, id_team, id_national_team, name, age, nationality, position, side, strength, feature_1, feature_2, value, is_junior }
- **contract** { <ins>id_contract</ins>,  id_team, id_player, inital_date, due_date, salary }
- **trades** { <ins>id_trade</ins>, id_seller_team, id_buyer_team, value }
- **lends** { <ins>id_lend</ins>, id_lender_team, id_borrower_team, initial_date, due_date, monthly_value }
- **championship** { <ins>id_championship</ins>, name, country, type }
- **round** { <ins>id_round</ins>,  id_championship, date }
- **match** { <ins>id_match</ins>,  id_round, id_team1, id_team_2, id_stadium }
-  **lineup** { <ins>id_match, id_team, id_coach, id_player</ins>, is_bench_player }
- **played_match** {  <ins>id_match, id_team, id_coach, id_player</ins>, cards, wrong_passes, assistences, disarms, time_with_ball, goals }
- **match_revenue** { id_match, public, revenue }
- **national_team** { <ins>id_national_team</ins>, id_coach, country }
- **world_cup** { <ins>id_world_cup</ins>, host_country, year }
- **national_round** { <ins>id_round</ins>,  id_world_cup, date } 
- **national_match** { <ins>id_match</ins>,  id_round, id_national_team1, id_national_team_2 }
- **national_played_match** {  <ins>id_match, id_team, id_coach, id_player</ins>, cards, wrong_passes, assistences, disarms, time_with_ball, goals }

