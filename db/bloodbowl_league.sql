DROP TABLE games;
DROP TABLE teams;

CREATE TABLE teams
(
  id SERIAL4 primary key,
  name VARCHAR(255) not null
);

CREATE TABLE games
(
  id SERIAL4 primary key,
  team1_id INT4 references teams(id) ON DELETE CASCADE,
  team2_id INT4 references teams(id) ON DELETE CASCADE,
  team1_score INT4,
  team2_score INT4,
  date_of_game DATE
);
