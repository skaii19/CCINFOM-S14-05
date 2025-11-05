CREATE SCHEMA IF NOT EXISTS vct;
USE vct;

SET SQL_SAFE_UPDATES = 0;

-- team
drop table team;
CREATE TABLE team (
	team_id VARCHAR(4) PRIMARY KEY,
	team_name VARCHAR(15),
    region VARCHAR(5),
    total_winnings DECIMAL(10,2),
	active_status BIT NOT NULL
);

TRUNCATE team;

INSERT INTO team(team_id, team_name, region, total_winnings, active_status)
-- active teams
-- Americas
	-- NA (North America)
VALUES  ('100T', '100 Thieves', 'NA', 478500, 1),
		('C9', 'Cloud9', 'NA', 259143, 1),
		('NV', 'ENVY', 'NA', 324750, 1),
		('EG', 'Evil Genuises', 'NA', 1283000, 1),
		('G2', 'G2 Esports', 'NA', 747250, 1),
	    ('NRG', 'NRG', 'NA', 1415375, 1),
		('SEN', 'Sentinels', 'NA', 608000, 1),

	-- BR (Brazil)
		('FUR', 'FURIA', 'BR', 147889, 1),
		('LOUD', 'LOUD', 'BR', 950156, 1),
		('MIBR', 'MIBR', 'BR', 119458, 1),

	-- LATAM (Latin America)
		('KRU', 'KRU Esports', 'LATAM', 390229, 1),
		('LEV', 'Leviatan', 'LATAM', 565896, 1),

-- EMEA
	-- EU (Europe)
		('FNC', 'FNATIC', 'EU', 2158026, 1),
		('FUT', 'FUT Esports', 'EU', 409236, 1),
		('GX', 'GIANTX', 'EU', 141179, 1),
		('KC', 'Karmine Corp', 'EU', 77516, 1),
		('NAVI', 'Natus Vincere', 'EU', 211380, 1),
		('SUP', 'Papara SuperMassive', 'EU', 62337, 1),
		('TH', 'Team Heretics', 'EU', 1402894, 1),
		('TL', 'Team Liquid', 'EU', 738104, 1),
		('VIT', 'Team Vitality', 'EU', 240876, 1),

-- APAC
		('BOOM', 'BOOM Esports', 'APAC', 189974, 1),
		('FS', 'FULL SENSE', 'APAC', 157047, 1),
		('PRX', 'Paper Rex', 'APAC', 1899351, 1),
		('RRQ', 'Rex Regum Qeon', 'APAC', 206627, 1),
		('TLN', 'TALON', 'APAC', 134025, 1),
		('TS', 'Team Secret', 'APAC', 187970, 1),
	
-- KR (Korea)
		('DRX', 'DRX', 'KR', 1100485, 1),
		('GEN', 'Gen.G Esports', 'KR', 925328, 1),
		('NT', 'NUTURN Gaming', 'KR', 133327, 1),
		('T1', 'T1', 'KR', 537044, 1),

-- JP (Japan)
		('ZETA', 'ZETA DIVISION', 'JP', 305704, 1),
	
-- CN (China)
		('BLG', 'Bilibili Gaming', 'CN', 159088, 1),
		('DRG', 'Dragon Ranger Gaming', 'CN', 37875, 1),
        ('EDG', 'EDward Gaming', 'CN', 1367287, 1),
		('FPX', 'FunPlus Pheonix', 'CN', 574490, 1),
		('TE', 'Trace Esports', 'CN', 89797, 1),
		('WOL', 'Wolves Esports', 'CN', 129915, 1),
		('XLG', 'Xi Lai Gaming', 'CN', 119325, 1),
	
-- inactive teams
-- Americas
	-- NA
		('OPTC', 'OpTic Gaming', 'NA', 499000, 0),
		('TGRD', 'The Guard', 'NA', 164750, 0),
		('V1', 'Version1', 'NA', 152625, 0),
		('XSET', 'XSET', 'NA', 257050, 0),
	
	-- BR
		('VKS2', 'Keyd Stars', 'BR', 94250, 0),
		('LBT', 'Liberty', 'BR', 60132, 0),
		('SHK', 'Sharks Esports', 'BR', 40028, 0),
		('VKS1', 'Team Vikings', 'BR', 108934, 0),

-- EMEA
	-- EU
		('ACE', 'ACEND', 'EU', 584411, 0),
		('GIA', 'Giants', 'EU', 103364, 0),
		('GLD', 'Guild Esports', 'EU', 127215, 0),
	
	-- CIS
		('GMB', 'Gambit Esports', 'EMEA', 495451, 0),

-- APAC
	-- TH (Thailand)
		('X10', 'X10 Esports', 'APAC', 128104, 0),
		('XER', 'XERXIA', 'APAC', 124903, 0),
	
	-- JP (Japan)
		('CR', 'Crazy Raccoon', 'JP', 116529, 0),
		('NTH', 'Northeption', 'JP', 34778, 0),
	
	-- KR 
		('F4Q', 'F4Q', 'KR', 38968, 0),
		('VS', 'Vision Strikers', 'KR', 228818, 0),
	
	-- CN
		('ASE', 'Attacking Soul Esports', 'CN', 23315, 0),
        ('NIP', 'Ninjas in Pyjamas', 'CN', 104657, 0)


SELECT * FROM team;
