CREATE SCHEMA IF NOT EXISTS vct;
USE vct;

SET SQL_SAFE_UPDATES = 0;

-- team
drop table team;
CREATE TABLE team (
	team_id VARCHAR(3) PRIMARY KEY,
	team_name VARCHAR(15),
    region VARCHAR(4),
    total_winnings DECIMAL(10,2),
	active_status BIT NOT NULL
);

TRUNCATE team;

INSERT INTO team(team_id, team_name, region, total_winnings, active_status)
-- NA
VALUES ('100T', '100 Thieves', 'NA', 478500, 1),
	   ('BERZ', 'Berzerkers', 'NA', 3695, 1),
	   ('BLU', 'Blue Otter', 'NA', 10235, 1),
	   ('CUA', 'Cubert Academy', 'NA', 7250, 1),
	   ('NRG', 'NRG', 'NA', 1415375, 1),
       ('TH', 'Team Heretics', 'NA', 1402894, 1),
       ('EG', 'Evil Genuises', 'NA', 1283000, 1),
       ('NV', 'ENVY', 'NA', 324750, 0),
       ('G2', 'G2 Esports', 'NA', 747250, 1),
       ('TSM', 'TSM', 'NA', 254019, 1),
       ('SEN', 'Sentinels', 'NA', 608000, 1),
       ('C9', 'Cloud9', 'NA', 259143, 1),
-- EMEA
       ('FNC', 'FNATIC', 'EMEA', 2158026, 1), 
-- APAC
	   ('PRX', 'Paper Rex', 'APAC', 1899351, 1),
-- CN
       ('EDG', 'Edward Gaming', 'CN', 1367287, 1),
       ('AG', 'All Gamers', 'CN', 3334, 1),
       ('ALG', 'Ambitious Legend Gaming', 'CN', 4159, 1);

SELECT * FROM team;