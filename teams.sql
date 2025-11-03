CREATE SCHEMA IF NOT EXISTS vct;
USE vct;

SET SQL_SAFE_UPDATES = 0;

-- team
drop table team;
CREATE TABLE team (
	team_id VARCHAR(4) PRIMARY KEY,
	team_name VARCHAR(15),
    region VARCHAR(4),
    total_winnings DECIMAL(10,2),
	active_status BIT NOT NULL
);

TRUNCATE team;

INSERT INTO team(team_id, team_name, region, total_winnings, active_status)
-- Americas
	-- active teams
	-- NA (North America)
VALUES  ('100T', '100 Thieves', 'NA', 478500, 1),
	   	('BERZ', 'Berzerkers', 'NA', 3695, 1),
	    ('BLU', 'Blue Otter', 'NA', 10235, 1),
		('C9', 'Cloud9', 'NA', 259143, 1),
	    ('CUA', 'Cubert Academy', 'NA', 7250, 1),
		('ENVY', 'ENVY', 'NA', 324750, 1),
		('EG', 'Evil Genuises', 'NA', 1283000, 1),
		('FCN', 'Fisher College Navy', 'NA', 31300, 1),
		('FLY', 'FlyQuest Red', 'NA', 51955, 1),
		('G2', 'G2 Esports', 'NA', 747250, 1),
		('JMU', 'James Madison University', 'NA', 2750, 1),
		('LDR', 'Landor', 'NA', 6625, 1),
		('ME', 'Maryville Esports', 'NA', 35285, 1),
		('NBG', 'Nightblood Gaming', 'NA', 7225, 1),
		('NU', 'Northwood University', 'NA', 91019, 1),
	    ('NRG', 'NRG', 'NA', 1415375, 1),
		('OC', 'OC Esports', 'NA', 14900, 1),
		('QOR', 'QoR Gaming', 'NA', 25865, 1),
		('SAD', 'SaD Esports', 'NA', 17120, 1),
		('SJSU', 'San Jose State University Esports', 'NA', 20275, 1),
		('SEN', 'Sentinels', 'NA', 608000, 1),
		('SCS', 'St. Clair College', 'NA', 30620, 1),
		('TAMU', 'Texas A&M University', 'NA', 29388, 1),
        ('TSM', 'TSM', 'NA', 254019, 1),
		('UH', 'University of Houston', 'NA', 19025, 1),
		('UM', 'University of Missouri', 'NA', 14750, 1),
		('UST', 'University of St. Thomas', 'NA', 17625, 1),
		('VT', 'Virginia Tech', 'NA', 3300, 1),
		('WU', 'Winthrop University', 'NA', 57838, 1),
		('YFP', 'YFP', 'NA', 24375, 1),

	-- BR (Brazil)
		('2G', '2GAME Academy', 'BR', 10737, 1),
		('CE', 'Corinthians Esports', 'BR', 13299, 1),
		('EL', 'Elevate', 'BR', 10038, 1),
		('FUR', 'FURIA', 'BR', 147889, 1),
		('FURA', 'FURIA Academy', 'BR', 6101, 1),
		('LOS', 'LOS', 'BR', 34322, 1),
		('LOUD', 'LOUD', 'BR', 950156, 1),
		('MIBR', 'MIBR', 'BR', 119458, 1),
		('MIBA', 'MIBR Academy', 'BR', 3553, 1),
		('RC', 'RED Canids', 'BR', 55593, 1),
	
    -- inactive
	-- NA
		('GG', 'Ghost Gaming', 'NA', 49100, 0),
		('SR', 'Shopify Rebellion', 'NA', 38000, 0),
-- EMEA
        ('FNC', 'FNATIC', 'EMEA', 2158026, 1), 
		('TH', 'Team Heretics', 'NA', 1402894, 1),
-- APAC
	    ('PRX', 'Paper Rex', 'APAC', 1899351, 1),
-- CN
        ('EDG', 'Edward Gaming', 'CN', 1367287, 1),
        ('AG', 'All Gamers', 'CN', 3334, 1),
        ('ALG', 'Ambitious Legend Gaming', 'CN', 4159, 1);

SELECT * FROM team;
