CREATE SCHEMA IF NOT EXISTS vct;
USE vct;

SET SQL_SAFE_UPDATES = 0;

-- team
drop table team;
CREATE TABLE team (
	team_id VARCHAR(4) PRIMARY KEY,
	team_name VARCHAR(15),
    region VARCHAR(5),
    total_winnings DECIMAL(8,2),
    qualification_status VARCHAR(1),
	active_status VARCHAR(1) NOT NULL
);

-- player
drop table player;
CREATE TABLE player (
	player_id		INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
	player_ign		VARCHAR(20) NOT NULL,
	player_name		VARCHAR(50),
    team_id			VARCHAR(4),
    active_status	VARCHAR(1),
    
    CONSTRAINT FOREIGN KEY (team_id) REFERENCES team(team_id)
);

-- team history
drop table team_history;
CREATE TABLE team_history (
	player_id	INT NOT NULL,
    start_date	DATE NOT NULL,
    team_id		VARCHAR(4) NOT NULL,
    end_date	DATE,
    
    PRIMARY KEY (player_id, start_date),
    CONSTRAINT FOREIGN KEY (player_id) REFERENCES player(player_id),
    CONSTRAINT FOREIGN KEY (team_id) REFERENCES team(team_id)
);

-- tournament
drop table tournament;
CREATE TABLE Tournament (
	tournament_id VARCHAR(7) PRIMARY KEY,
	tournament_name VARCHAR(50),
    prize_pool DECIMAL(12,2),
    tournament_type VARCHAR(50),
	start_date DATE,
    end_date DATE,
	country VARCHAR(50),
	venue VARCHAR(50)
);

-- player stats
drop table player_stats;
CREATE TABLE player_stats (
	player_id			INT NOT NULL,
    tournament_id		VARCHAR(7) NOT NULL,
	agents_used			VARCHAR(100),
	headshot_pct		DECIMAL(5,2),
	kd_ratio			DECIMAL(4,2),
	avg_combat_score	DECIMAL(6,2),
	mvps				VARCHAR(100),
    
    PRIMARY KEY (player_id, tournament_id),
    CONSTRAINT FOREIGN KEY (player_id) REFERENCES player(player_id),
    CONSTRAINT FOREIGN KEY (tournament_id) REFERENCES tournament(tournament_id)

    -- CONSTRAINT fk_mvps FOREIGN KEY (mvps) REFERENCES match(match_id)
);

-- team placement
drop table team_placement;
CREATE TABLE team_placement (
	team_id VARCHAR(4),
    CONSTRAINT FOREIGN KEY (team_id) REFERENCES team(team_id),
    tournament_id VARCHAR(7),
    FOREIGN KEY (tournament_id) REFERENCES tournament(tournament_id),
    placement VARCHAR(3),
    winnings DECIMAL(8,2),
    
    PRIMARY KEY(team_id, tournament_id)
);

-- attendee
drop table attendee;
CREATE TABLE attendee (
	ticket_id INT AUTO_INCREMENT PRIMARY KEY UNIQUE,
	customer_name VARCHAR(50),
	date_of_ticket DATE,
    tournament_id VARCHAR(7),
    CONSTRAINT FOREIGN KEY (tournament_id) REFERENCES tournament(tournament_id),
    seat_id VARCHAR(4),
    ticket_price DECIMAL (8,2),
    mode_of_payment VARCHAR(16),
    verified BIT DEFAULT 0
);

INSERT INTO team (team_id, active_status)
VALUES	-- Masters Reykjavik 2021 + current teams
		('SEN', 'Y'),
		('V1', 'N'),
        ('APK', 'N'),
		('TL', 'Y'),
		('1TAP', 'Y'),
        ('BBL', 'Y'),
        ('FNC', 'Y'),
        ('EP', 'Y'),
        ('VIT', 'Y'),
        ('RED', 'Y'),
        ('KC', 'Y'),
        ('NU', 'N'),
        ('SHK', 'N'),
        ('RED', 'Y'),
        ('SET', 'Y'),
        ('KRU', 'Y'),
        ('9ZG', 'Y'),
        ('CR', 'N'),
        ('SZ', 'Y'),
        ('FL', 'Y'),
        ('X10', 'N'),
        ('XGOD', 'Y'),
        ('MTV', 'Y'),
        ('TLN', 'Y');
        
INSERT INTO team (team_id, active_status)
VALUES	-- Masters Berlin 2021 + current teams added
        ('100T', 'Y'),
        ('NRG', 'Y'),
        ('EG', 'Y'),
        ('VS', 'N'),
        ('T1', 'Y'),
        ('NS', 'Y'),
        ('DRX', 'Y'),
        ('G2', 'N'),
        ('MDR', 'Y'),
        ('ACE', 'N'),
        ('JL', 'Y'),
        ('FUT', 'Y'),
        ('GMB', 'N'),
        ('OXJ', 'Y');
        
INSERT INTO player (player_ign, player_name, team_id, active_status)
VALUES	-- Masters Reykjavik 2021
		-- Sentinels (SEN)
		('ShahZaM', 'Shahzeeb Khan', NULL, 'N'), -- 1
        ('SicK', 'Hunter Mims', 'SEN', 'N'), -- 2
        ('TenZ', 'Tyson Ngo', NULL, 'N'), -- 3
        ('zombs', 'Jared Gitlin', NULL, 'N'), -- 4
        ('dapr', 'Michael Gulino', NULL, 'N'), -- 5
        
        -- Version1 (V1)
		('penny', 'Erik Penny', 'APK', 'N'), -- 6
        ('jammyz', 'Jamal Bangash', NULL, 'N'), -- 7
        ('effys', 'Loic Sauvageau', NULL, 'N'), -- 8
        ('Zellsis', 'Jordan Montemurro', 'SEN', 'Y'), -- 9
        ('vanity', 'Anthony Malaspina', NULL, 'N'), -- 10
        
        -- Team Liquid (TL)
        ('ScreaM', 'Adil Benrlitom', '1TAP', 'Y'), -- 11
        ('Kryptix', 'James Affleck', NULL, 'N'), -- 12
        ('L1NK', 'Travis Mendoza', NULL, 'N'), -- 13
        ('soulcas', 'Dom Sulcas', NULL, 'N'), -- 14
        ('Jamppi', 'Elias Olkkonen', 'BBL', 'Y'), -- 15
        
        -- FNATIC (FNC)
        ('Boaster', 'Jake Howlett', 'FNC', 'Y'), -- 16
        ('doma', 'Domagoj Fancev', 'EP', 'Y'), -- 17
        ('Mistic', 'James Orfila', NULL, 'N'), -- 18
        ('MAGNUM', 'Martin Penkov', 'BBL', 'N'), -- 19
        ('Derke', 'Nikita Sirmitev', 'VIT', 'Y'), -- 20
        
        -- Team Vikings (VKS1)
        ('frz', 'Leandro Fukuda Gomes', 'RED', 'Y'), -- 21
        ('Sacy', 'Gustavo Rossi', NULL, 'N'), -- 22
        ('saadhak', 'Matias Delipetro', 'KC', 'Y'), -- 23
        ('gtn', 'Gustavo Moura', NULL, 'N'), -- 24
        ('sutecas', 'Gabriel Dias', NULL, 'N'), -- 25
        
        -- NUTURN (NU)
        ('peri', 'Jung Beom-gi', NULL, 'N'), -- 26
        ('Lakia', 'Kim Jong-min', NULL, 'N'), -- 27
        ('allow', 'Park Sang-wook', NULL, 'N'), -- 28
        ('Suggest', 'Seo Jae-young', NULL, 'N'), -- 29
        ('solo', 'Kang Keun-chul', NULL, 'N'), -- 30
        
        -- Sharks Esports (SHK)
        ('fra', 'Matheus Fragozo', NULL, 'N'), -- 31
        ('light', 'Winicius César', NULL, 'N'), -- 32
        ('prozin', 'Wallacy Sales', 'RED', 'Y'), -- 33
        ('deNaro', 'Matheus Hipólito', 'SET', 'Y'), -- 34
        ('gaabxx', 'Gabriel Carli', 'RED', 'Y'), -- 35
        
        -- KRU Esports (KRU)
        ('NagZ', 'Juan Pablo Lopez Miranda', '9ZG', 'Y'), -- 36
        ('bnj', 'Benjamin Rabinovich', NULL, 'N'), -- 37
        ('delz1k', 'Joaquin Espinoza', '9ZG', 'Y'), -- 38
        ('Klaus', 'Nicolas Ferrari', '9ZG', 'Y'), -- 39
        ('Mazino', 'Roberto Rivas', 'KRU', 'N'), -- 40
        
        -- Crazy Raccoon (CR)
        ('Munchkin', 'Byeon Sang-beom', NULL, 'N'), -- 41
        ('zepher', 'Jyousuke Matsuda', NULL, 'N'), -- 42
        ('rion', 'Hiroto Tateno', NULL, 'N'), -- 43
        ('Medusa', 'An Min-cheol', 'SZ', 'Y'), -- 44
        ('neth', 'Yusuke Matsuda', 'FL', 'Y'), -- 45
        
        -- X10 Esports (X10)
        ('foxz', 'Itthirit Ngamsaard', 'XGOD', 'Y'), -- 46
        ('Patiphan', 'Patiphan Chaiwong', NULL, 'N'), -- 47
        ('Sushiboys', 'Panyawat Subsiriroj', 'MTV', 'Y'), -- 48
        ('Crws', 'Thanamethk Mahatthananuyut', 'TLN', 'Y'), -- 49
        ('sScary', 'Nutchapon Matarat', NULL, 'N'); -- 50
        
INSERT INTO player (player_ign, player_name, team_id, active_status)
VALUES	-- Masters Berlin 2021 added
        -- 100 Thieves (100T)
        ('Hiko', 'Spencer Martin', NULL, 'N'), -- 51
        ('Asuna', 'Peter Mazuryk', '100T', 'N'), -- 52
        ('nitr0', 'Nick Cannella', NULL, 'N'), -- 53
        ('steel', 'Joshua Nissan', NULL, 'N'), -- 54
        ('Ethan', 'Ethan Arnold', 'NRG', 'Y'), -- 55
        
        -- ENVY (NV)
        ('crashies', 'Austin Roberts', 'FNC', 'Y'), -- 56
        ('Victor', 'Victor Wong', NULL, 'N'), -- 57
        ('Marved', 'Jimmy Nguyen', NULL, 'N'), -- 58
        ('FiNESSE', 'Pujan Mehta', NULL, 'N'), -- 59
        ('yay', 'Jaccob Whiteaker', 'NG', 'Y'), -- 60
        
        -- Vision Strikers (VS)
        ('stax', 'Kim Gu-taek', 'T1', 'Y'), -- 61
        ('Rb', 'Goo Sang-min', 'NS', 'Y'), -- 62
        ('k1Ng', 'Lee Seung-won', NULL, 'N'), -- 63
        ('BuZz', 'Yu Byeong-cheol', 'T1', 'Y'), -- 64
        ('MaKo', 'Kim Myeong-gwan', 'DRX', 'Y'), -- 65
        
        -- G2 Esports (G2)
        ('Mixwell', 'Oscar Cañellas', NULL, 'N'), -- 66
        ('koldamenta', 'Jose Luis Aranguren', NULL, 'N'), -- 67
        ('AvovA', 'Auni Chahade', NULL, 'N'), -- 68
        ('nukkye', 'Žygimantas Chmieliauskas', NULL, 'N'), -- 69
        ('keloqz', 'Cista Wassim', 'MDR', 'Y'), -- 70
        
        -- KRU Esports (KRU)
        ('keznit', 'Angelo Mori', 'KRU', 'N'), -- 71
        
        -- Acend (ACE)
        ('zeek', 'Aleksander Zygmunt', 'EP', 'Y'), -- 72
        ('starxo', 'Patryk Kopczynski', 'JL', 'Y'), -- 73
        ('cNed', 'Patryk Kopczynski', 'FUT', 'N'), -- 74
        ('Kiles', 'Vlad Shvets', 'EP', 'Y'), -- 75
        ('BONECOLD', 'Santeri Sassi', NULL, 'N'), -- 76
        
        -- Gambit Esports (GMB)
        ('d3ffo', 'Nikita Sudakov', NULL, 'N'), -- 77
        ('nAts', 'Ayaz Akhmetshin', 'TL', 'Y'), -- 78
        ('Chronicle', 'Timofey Khromov', 'VIT', 'Y'), -- 79
        ('Redgar', 'Igor Vlasov', 'OXJ', 'Y'), -- 80
        ('sheydos', 'Bogdan Naumov', NULL, 'N'), -- 81
        
        -- Papara SuperMassive (SUP)
        ('Turko', 'Mehmet Özen', 'S2G', 'Y'), -- 82
        ('pAura', 'Melih Karaduran', 'S2G', 'Y'), -- 83
        ('russ', 'Batuhan Malgaç', 'LIBE', 'Y'), -- 84
        ('Brave', 'Eren Kasırga', 'EF', 'Y'), -- 85
        ('Izzy', 'Baran Yılmaz', 'EF', 'Y'), -- 86
        
        -- Liberty (LBR)
        ('krain', 'Gustavo Melara', NULL, 'N'), -- 87
        ('pleets', 'Marcelo Leite', NULL, 'N'), -- 88
        ('shion', 'Gabriel Vilela', 'SCCP', 'Y'), -- 89
        ('Myssen', 'Rodrigo Myssen', NULL, 'N'), -- 90
        ('liazzi', 'Felipe Galiazzi', 'SCCP', 'Y'), -- 91
        
        -- Keyd Stars (VKS2)
        ('murizzz', 'Murillo Tuchtenhagen', 'SHI', 'Y'), -- 92
        ('JhoW', 'Jonathan Glória', NULL, 'N'), -- 93
        ('v1xen', 'Gabriel Martins', NULL, 'N'), -- 94
        ('ntk', 'Lucas Martins', NULL, 'N'), -- 95
        ('heat', 'Olavo Marcelo', 'FUR', 'Y'), -- 96
        
        -- F4Q (F4Q)
        ('fiveK', 'Yoo Sung-min', NULL, 'N'), -- 97
        ('zunba', 'Kim Joon-hyuk', NULL, 'N'), -- 98
        ('Efina', 'Kim Nak-yeon', 'T1A', 'N'), -- 99
        ('Esperanza', 'Jeong Jin-cheol', 'NFX', 'Y'), -- 100
        ('Bunny', 'Chae Joon-hyuk', NULL, 'N'), -- 101
        
        -- Bren Esports
        ('BORKUM', 'Jim Timbreza', 'KDM', 'Y'), -- 102
        ('JessieVash', 'Jessie Cuyco', 'TS', 'Y'), -- 103
        ('dispenser', 'Kevin Te', NULL, 'N'), -- 104
        ('DubsteP', 'Jayvee Paguirigan', NULL, 'N'), -- 105
        ('Witz', 'Riley Go', NULL, 'N'), -- 106
        
        -- Paper Rex (PRX)
        ('mindfreak', 'Aaron Leonhart', NULL, 'N'), -- 107
        ('f0rsakeN', 'Jason Susanto', 'PRX', 'Y'), -- 108
        ('Benkai', 'Benedict Tan', NULL, 'N'), -- 109
        ('d4v41', 'Khalish Rusyaidee', 'PRX', 'Y'), -- 110
        ('shiba', 'Zhan Teng Toh', NULL, 'N'), -- 111
        
        -- Crazy Raccoon (CR)
        ('Bazzi', 'Park Jun-ki', NULL, 'N'), -- 112
        ('ade', 'Teppei Kuno', NULL, 'N'), -- 113
        ('Fisker', 'Hideki Sasaki', NULL, 'N'), -- 114
        ('Minty', 'Daiki Kato', 'RID', 'Y'), -- 115
        
        -- ZETA DIVISION (ZETA)
        ('Laz', 'Ushida Koji', NULL, 'N'), -- 116
        ('crow', 'Maruoka Tomoaki', NULL, 'N'), -- 117
        ('barce', 'Takebayashi Ryo', 'NFX', 'N'), -- 118
        ('takej', 'Takemori Shogo', NULL, 'N'), -- 119
        ('Reita', 'Oshiro Ryu', 'MRSH', 'Y'), -- 120
        ('makiba', 'Miyamoto Akatsuki', NULL, 'N'); -- 121
        
INSERT INTO player (player_ign, player_name, team_id, active_status)
VALUES	-- Valorant Champions 2021 added
		-- Keyd Stars (VKS2)
        ('mwzera', 'Leonardo Serrati', 'LOS', 'Y'), -- 122

		-- Team Liquid (TL)
        ('Nivera', 'Nabil Benrlitom', NULL, 'N'), -- 123
        
        -- Cloud9 (C9)
        ('xeta', 'Son Seon-ho', NULL, 'N'), -- 124
        ('mitch', 'Mitch Semago', NULL, 'N'), -- 125
        ('Xeppaa', 'Erick Bach', 'C9', 'Y'), -- 126
        ('leaf', 'Nathan Orf', 'G2', 'Y'), -- 127
        
        -- FURIA (FUR)
        ('xand', 'Alexandre Zizi', NULL, 'N'), -- 128
        ('nzr', 'Agustin Ibarra', 'MIBR', 'N'), -- 129
        ('Quick', 'Gabriel Lima', 'LOS', 'Y'), -- 130
        ('Khalil', 'Khalil Schmidt', NULL, 'N'), -- 131
        ('mazin', 'Matheus Araújo', 'LOS', 'Y'), -- 132
        
        -- FULL SENSE (FS)
        ('PTC', 'Kititkawin Rattanasukol', NULL, 'N'), -- 133
        ('SuperBusS', 'Nattawat Yoosawat', NULL, 'N'), -- 134
        ('SantaGolf', 'Chanitpak Suwanaprateep', NULL, 'N'), -- 135
		('JohnOlsen', 'Chanawin Nakchain', NULL, 'N'), -- 136
        ('LAMMYSNAX', 'Elamrahim Khanpathan', NULL, 'N'); -- 137
        
INSERT INTO player (player_ign, player_name, team_id, active_status)
VALUES	-- Masters Reykjavík 2022 added
		-- FNATIC (FNC)
        ('Enzo', 'Enzo Mestari', 'MDR', 'Y'), -- 138
        ('H1ber', 'Joona Parviainen', 'HGE', 'Y'), -- 139
        
        -- DRX (DRX)
        ('Zest', 'Kim Ki-seok', NULL, 'N'), -- 140
        
        -- ZETA DIVISION (ZETA)
        ('Dep', 'Yuma Hashimoto', 'ZETA', 'Y'), -- 141
        ('TENNN', 'Tenta Asai', 'MRSH', 'Y'), -- 142
        ('SugarZ3ro', 'Shota Watanabe', 'ZETA', 'Y'), -- 143
        
        -- XERXIA Esports (XIA)
        ('Surf', 'Thanachart Rungapajaratkul', 'TLNA', 'Y'), -- 144
        
        -- Ninjas In Pyjamas (NIP)
        ('Jonn', 'Walney Reis', NULL, 'N'), -- 145
        ('bezn1', 'Gabriel Luiz da Costa', NULL, 'N'), -- 146
        ('cauanzin', 'Cauan Pereira', 'LOUD', 'Y'), -- 147
        
        -- G2 Esports (G2)
        ('Meddo', 'Johan Renbjörk Lundborg', 'GODS', 'Y'), -- 148
        ('hoody', 'Aaro Peltokangas', NULL, 'N'), -- 149
        
        -- The Guard (TGRD)
        ('valyn', 'Jacob Batio', 'G2', 'Y'), -- 150
        ('Sayaplayer', 'Ha Jeong-woo', NULL, 'N'), -- 151
        ('JonahP', 'Jonah Pulice', 'G2', 'Y'), -- 152
        ('neT', 'Michael Bernet', NULL, 'N'), -- 153
        ('trent', 'Trent Cairns', 'G2', 'Y'), -- 154
        
        -- Paper Rex (PRX)
        ('Jinggg', 'Wang Jing Jie', 'PRX', 'Y'), -- 155
        
        -- LOUD (LOUD)
        ('pANcada', 'Bryan Luna', 'LOUD', 'Y'), -- 156
        ('Less', 'Felipe de Loyola Basso', 'VIT', 'Y'), -- 157
        ('aspas', 'Erick Santos', 'MIBR', 'Y'); -- 158
        
INSERT INTO tournament (tournament_id)
VALUES ('2021_M1');
        
INSERT INTO player_stats (player_id, match_id, headshot_pct, kd_ratio, avg_combat_score, mvps)
VALUES	-- Masters Reykjavik 2021
		-- FNC vs KRU 1
		-- FNATIC (FNC)
		(17, 'MR21_UR1_01', '35', '2.00', '211', 'N'), -- doma
		(20, 'MR21_UR1_01', '29', '1.58', '331', 'Y'), -- Derke
		(19, 'MR21_UR1_01', '33', '1.88', '213', 'N'), -- MAGNUM
		(18, 'MR21_UR1_01', '27', '1.11', '169', 'N'), -- Mistic
		(16, 'MR21_UR1_01', '42', '0.92', '170', 'N'), -- Boaster
		-- KRU Esports (KRU)
		(40, 'MR21_UR1_01', '9', '0.73', '213', 'N'), -- Mazino
		(36, 'MR21_UR1_01', '38', '0.87', '221', 'N'), -- NagZ
		(39, 'MR21_UR1_01', '18', '1.08', '191', 'N'), -- Klaus
		(37, 'MR21_UR1_01', '20', '0.47', '127', 'N'), -- bnj
		(38, 'MR21_UR1_01', '19', '0.33', '76', 'N'), -- delz1k

		-- FNC vs KRU 2
		-- FNATIC (FNC)
		(20, 'MR21_UR1_02', '29', '1.40', '396', 'Y'), -- Derke
		(19, 'MR21_UR1_02', '19', '1.40', '239', 'N'), -- MAGNUM
		(18, 'MR21_UR1_02', '24', '1.44', '192', 'N'), -- Mistic
		(16, 'MR21_UR1_02', '23', '1.20', '206', 'N'), -- Boaster
		(17, 'MR21_UR1_02', '39', '1.10', '189', 'N'), -- doma
		-- KRU Esports (KRU)
		(39, 'MR21_UR1_02', '24', '1.08', '247', 'N'), -- Klaus
		(40, 'MR21_UR1_02', '24', '1.00', '250', 'N'), -- Mazino
		(37, 'MR21_UR1_02', '26', '0.67', '157', 'N'), -- bnj
		(38, 'MR21_UR1_02', '23', '0.79', '166', 'N'), -- delz1k
		(36, 'MR21_UR1_02', '35', '0.35', '109', 'N'), -- NagZ
        
		-- V1 vs CR 1
		-- Version1 (V1)
		(9, 'MR21_UR1_03', '25', '1.35', '259', 'N'), -- Zellsis
		(7, 'MR21_UR1_03', '11', '1.40', '248', 'N'), -- jammyz
		(6, 'MR21_UR1_03', '17', '1.31', '239', 'N'), -- penny
		(8, 'MR21_UR1_03', '23', '1.00', '196', 'N'), -- effys
		(10, 'MR21_UR1_03', '7', '0.53', '132', 'N'), -- vanity
		-- Crazy Raccoon (CR)
		(41, 'MR21_UR1_03', '13', '1.28', '302', 'Y'), -- Munchkin
		(43, 'MR21_UR1_03', '33', '0.83', '209', 'N'), -- rion
		(44, 'MR21_UR1_03', '27', '0.83', '193', 'N'), -- Medusa
		(42, 'MR21_UR1_03', '29', '0.84', '193', 'N'), -- zepher
		(45, 'MR21_UR1_03', '15', '0.71', '123', 'N'), -- neth

		-- V1 vs CR 2
		-- Version1 (V1)
		(6, 'MR21_UR1_04', '17', '1.41', '274', 'Y'), -- penny
		(9, 'MR21_UR1_04', '15', '1.11', '210', 'N'), -- Zellsis
		(8, 'MR21_UR1_04', '16', '1.08', '126', 'N'), -- effys
		(10, 'MR21_UR1_04', '18', '0.82', '142', 'N'), -- vanity
		(7, 'MR21_UR1_04', '15', '0.76', '160', 'N'), -- jammyz
		-- Crazy Raccoon (CR)
		(45, 'MR21_UR1_04', '22', '1.29', '187', 'N'), -- neth
		(41, 'MR21_UR1_04', '13', '0.90', '230', 'N'), -- Munchkin
		(44, 'MR21_UR1_04', '37', '0.83', '180', 'N'), -- Medusa
		(42, 'MR21_UR1_04', '17', '0.94', '162', 'N'), -- zepher
		(43, 'MR21_UR1_04', '31', '0.94', '156', 'N'), -- rion
        
		-- SHK vs NU 1
		-- Sharks Esports (SHK)
		(35, 'MR21_UQF_01', '47', '3.67', '311', 'N'), -- gaabxx
		(34, 'MR21_UQF_01', '25', '1.67', '259', 'N'), -- deNaro
		(33, 'MR21_UQF_01', '26', '1.43', '337', 'Y'), -- prozin
		(31, 'MR21_UQF_01', '17', '0.75', '143', 'N'), -- fra
		(32, 'MR21_UQF_01', '9', '0.50', '86', 'N'), -- light
		-- NUTURN (NU)
		(27, 'MR21_UQF_01', '33', '0.93', '221', 'N'), -- Lakia
		(28, 'MR21_UQF_01', '34', '0.85', '190', 'N'), -- allow
		(26, 'MR21_UQF_01', '22', '0.79', '180', 'N'), -- peri
		(29, 'MR21_UQF_01', '14', '0.53', '157', 'N'), -- Suggest
		(30, 'MR21_UQF_01', '32', '0.53', '134', 'N'), -- solo

		-- SHK vs NU 2
		-- Sharks Esports (SHK)
		(31, 'MR21_UQF_02', '54', '1.00', '196', 'N'), -- fra
		(35, 'MR21_UQF_02', '36', '0.87', '204', 'N'), -- gaabxx
		(32, 'MR21_UQF_02', '17', '0.53', '155', 'N'), -- light
		(33, 'MR21_UQF_02', '18', '0.53', '168', 'N'), -- prozin
		(34, 'MR21_UQF_02', '15', '0.27', '77', 'N'), -- deNaro
		-- NUTURN (NU)
		(26, 'MR21_UQF_02', '28', '2.33', '315', 'Y'), -- peri
		(27, 'MR21_UQF_02', '44', '1.40', '220', 'N'), -- Lakia
		(29, 'MR21_UQF_02', '34', '1.88', '233', 'N'), -- Suggest
		(28, 'MR21_UQF_02', '30', '1.33', '174', 'N'), -- allow
		(30, 'MR21_UQF_02', '30', '1.10', '185', 'N'), -- solo

		-- SHK vs NU 3
		-- Sharks Esports (SHK)
		(35, 'MR21_UQF_03', '15', '0.92', '198', 'N'), -- gaabxx
		(32, 'MR21_UQF_03', '23', '0.33', '107', 'N'), -- light
		(34, 'MR21_UQF_03', '20', '0.40', '111', 'N'), -- deNaro
		(33, 'MR21_UQF_03', '32', '0.60', '142', 'N'), -- prozin
		(31, 'MR21_UQF_03', '22', '0.27', '105', 'N'), -- fra
		-- NUTURN (NU)
		(27, 'MR21_UQF_03', '14', '2.60', '231', 'N'), -- Lakia
		(30, 'MR21_UQF_03', '16', '2.71', '314', 'Y'), -- solo
		(29, 'MR21_UQF_03', '27', '2.00', '230', 'N'), -- Suggest
		(26, 'MR21_UQF_03', '20', '1.60', '190', 'N'), -- peri
		(28, 'MR21_UQF_03', '13', '1.50', '187', 'N'), -- allow

		-- VKS1 vs X10 1
		-- Team Vikings (VKS1)
		(25, 'MR21_UQF_04', NULL, '1.35', NULL, NULL), -- sutecas
		(21, 'MR21_UQF_04', NULL, '1.38', NULL, NULL), -- frz
		(22, 'MR21_UQF_04', NULL, '1.24', NULL, NULL), -- Sacy
		(23, 'MR21_UQF_04', NULL, '1.06', NULL, NULL), -- saadhak
		(24, 'MR21_UQF_04', NULL, '0.39', NULL, NULL), -- gtn
		-- X10 Esports (X10)
		(49, 'MR21_UQF_04', NULL, '1.21', NULL, NULL), -- Crws
		(47, 'MR21_UQF_04', NULL, '1.00', NULL, NULL), -- Patiphan
		(46, 'MR21_UQF_04', NULL, '1.00', NULL, NULL), -- foxz
		(48, 'MR21_UQF_04', NULL, '0.83', NULL, NULL), -- Sushiboys
		(50, 'MR21_UQF_04', NULL, '0.59', NULL, NULL), -- sScary

		-- VKS1 vs X10 2
		-- Team Vikings (VKS1)
		(22, 'MR21_UQF_05', '30', '1.86', '262', 'Y'), -- Sacy
		(23, 'MR21_UQF_05', '18', '1.29', '210', 'N'), -- saadhak
		(25, 'MR21_UQF_05', '36', '1.06', '221', 'N'), -- sutecas
		(24, 'MR21_UQF_05', '20', '0.84', '191', 'N'), -- gtn
		(21, 'MR21_UQF_05', '23', '0.79', '181', 'N'), -- frz
		-- X10 Esports (X10)
		(47, 'MR21_UQF_05', '27', '1.05', '234', 'N'), -- Patiphan
		(46, 'MR21_UQF_05', '19', '0.90', '218', 'N'), -- foxz
		(50, 'MR21_UQF_05', '14', '0.88', '177', 'N'), -- Sushiboys
		(48, 'MR21_UQF_05', '19', '0.88', '167', 'N'), -- sScary
		(49, 'MR21_UQF_05', '15', '0.79', '161', 'N'), -- Crws

		-- TL vs V1 1
		-- Team Liquid (TL)
		(12, 'MR21_UQF_06', '21', '1.29', '208', 'N'), -- Kryptix
		(11, 'MR21_UQF_06', '36', '1.50', '281', 'Y'), -- ScreaM
		(14, 'MR21_UQF_06', '33', '1.09', '233', 'N'), -- soulcas
		(13, 'MR21_UQF_06', '25', '1.15', '224', 'N'), -- L1NK
		(15, 'MR21_UQF_06', '17', '0.58', '150', 'N'), -- Jamppi
		-- Version1 (V1)
		(6, 'MR21_UQF_06', '22', '1.10', '217', 'N'), -- penny
		(8, 'MR21_UQF_06', '20', '1.16', '192', 'N'), -- effys
		(10, 'MR21_UQF_06', '15', '1.00', '244', 'N'), -- vanity
		(7, 'MR21_UQF_06', '8', '0.76', '195', 'N'), -- jammyz
		(9, 'MR21_UQF_06', '12', '0.64', '185', 'N'), -- Zellsis

		-- TL vs V1 2
		-- Team Liquid (TL)
		(15, 'MR21_UQF_07', '28', '1.63', '338', 'Y'), -- Jamppi
		(11, 'MR21_UQF_07', '31', '1.20', '218', 'N'), -- ScreaM
		(12, 'MR21_UQF_07', '25', '0.87', '176', 'N'), -- Kryptix
		(14, 'MR21_UQF_07', '48', '0.81', '172', 'N'), -- soulcas
		(13, 'MR21_UQF_07', '24', '0.76', '170', 'N'), -- L1NK
		-- Version1 (V1)
		(6, 'MR21_UQF_07', '21', '1.24', '297', 'N'), -- penny
		(9, 'MR21_UQF_07', '17', '0.94', '209', 'N'), -- Zellsis
		(8, 'MR21_UQF_07', '26', '0.88', '182', 'N'), -- effys
		(10, 'MR21_UQF_07', '23', '0.88', '185', 'N'), -- vanity
		(7, 'MR21_UQF_07', '20', '0.63', '126', 'N'), -- jammyz

		-- TL vs V1 3
		-- Team Liquid (TL)
		(11, 'MR21_UQF_08', '55', '1.08', '210', 'N'), -- ScreaM
		(13, 'MR21_UQF_08', '35', '0.92', '212', 'N'), -- L1NK
		(12, 'MR21_UQF_08', '19', '1.09', '196', 'N'), -- Kryptix
		(14, 'MR21_UQF_08', '38', '0.67', '159', 'N'), -- soulcas
		(15, 'MR21_UQF_08', '21', '0.59', '201', 'N'), -- Jamppi
		-- Version1 (V1)
		(9, 'MR21_UQF_08', '14', '2.40', '387', 'Y'), -- Zellsis
		(8, 'MR21_UQF_08', '30', '1.33', '183', 'N'), -- effys
		(6, 'MR21_UQF_08', '23', '1.08', '241', 'N'), -- penny
		(7, 'MR21_UQF_08', '25', '0.80', '132', 'N'), -- jammyz
		(10, 'MR21_UQF_08', '30', '0.67', '174', 'N'), -- vanity

		-- SEN vs FNC 1
		-- Sentinels (SEN)
		(1, 'MR21_UQF_09', '30', '1.55', '368', 'Y'), -- ShahZaM
		(3, 'MR21_UQF_09', '13', '1.39', '277', 'N'), -- TenZ
		(4, 'MR21_UQF_09', '13', '0.72', '183', 'N'), -- zombs
		(5, 'MR21_UQF_09', '15', '0.44', '106', 'N'), -- dapr
		(2, 'MR21_UQF_09', '31', '0.60', '105', 'N'), -- SicK
		-- FNATIC (FNC)
		(18, 'MR21_UQF_09', '31', '1.71', '289', 'N'), -- Mistic
		(19, 'MR21_UQF_09', '26', '0.94', '216', 'N'), -- MAGNUM
		(16, 'MR21_UQF_09', '29', '0.89', '205', 'N'), -- Boaster
		(17, 'MR21_UQF_09', '38', '0.82', '163', 'N'), -- doma
		(20, 'MR21_UQF_09', '28', '0.94', '215', 'N'), -- Derke

		-- SEN vs FNC 2
		-- Sentinels (SEN)
		(3, 'MR21_UQF_10', '23', '1.50', '316', 'Y'), -- TenZ
		(5, 'MR21_UQF_10', '19', '1.46', '216', 'N'), -- dapr
		(4, 'MR21_UQF_10', '11', '1.06', '211', 'N'), -- zombs
		(1, 'MR21_UQF_10', '21', '0.82', '192', 'N'), -- ShahZaM
		(2, 'MR21_UQF_10', '26', '0.72', '169', 'N'), -- SicK
		-- FNATIC (FNC)
		(20, 'MR21_UQF_10', '26', '1.26', '312', 'N'), -- Derke
		(16, 'MR21_UQF_10', '21', '1.00', '220', 'N'), -- Boaster
		(17, 'MR21_UQF_10', '20', '0.83', '179', 'N'), -- doma
		(18, 'MR21_UQF_10', '48', '0.71', '159', 'N'), -- Mistic
		(19, 'MR21_UQF_10', '28', '0.76', '147', 'N'), -- MAGNUM

		-- X10 vs CR 1
		-- X10 Esports (X10)
		(47, 'MR21_LR1_01', '34', '2.18', '319', 'Y'), -- Patiphan
		(48, 'MR21_LR1_01', '20', '1.50', '196', 'N'), -- sScary
		(46, 'MR21_LR1_01', '25', '1.25', '238', 'N'), -- foxz
		(49, 'MR21_LR1_01', '18', '0.92', '178', 'N'), -- Crws
		(50, 'MR21_LR1_01', '10', '1.00', '174', 'N'), -- Sushiboys
		-- Crazy Raccoon (CR)
		(41, 'MR21_LR1_01', '17', '0.89', '215', 'N'), -- Munchkin
		(45, 'MR21_LR1_01', '18', '0.93', '185', 'N'), -- neth
		(42, 'MR21_LR1_01', '14', '0.78', '209', 'N'), -- zepher
		(44, 'MR21_LR1_01', '24', '0.65', '153', 'N'), -- Medusa
		(43, 'MR21_LR1_01', '16', '0.47', '97', 'N'), -- rion

		-- X10 vs CR 2
		-- X10 Esports (X10)
		(50, 'MR21_LR1_02', '29', '1.54', '300', 'N'), -- Sushiboys
		(49, 'MR21_LR1_02', '14', '1.70', '267', 'N'), -- Crws
		(48, 'MR21_LR1_02', '18', '1.83', '152', 'N'), -- sScary
		(47, 'MR21_LR1_02', '28', '1.20', '292', 'N'), -- Patiphan
		(46, 'MR21_LR1_02', '28', '0.80', '225', 'N'), -- foxz
		-- Crazy Raccoon (CR)
		(45, 'MR21_LR1_02', '24', '1.27', '317', 'Y'), -- neth
		(42, 'MR21_LR1_02', '31', '1.21', '246', 'N'), -- zepher
		(44, 'MR21_LR1_02', '14', '0.59', '187', 'N'), -- Medusa
		(43, 'MR21_LR1_02', '35', '0.50', '132', 'N'), -- rion
		(41, 'MR21_LR1_02', '9', '0.31', '95', 'N'), -- Munchkin

		-- SHK vs KRU 1
		-- Sharks Esports (SHK)
		(33, 'MR21_LR1_03', '33', '1.00', '253', 'N'), -- prozin
		(34, 'MR21_LR1_03', '21', '0.87', '230', 'N'), -- deNaro
		(32, 'MR21_LR1_03', '22', '0.36', '100', 'N'), -- light
		(31, 'MR21_LR1_03', '19', '0.27', '73', 'N'), -- fra
		(35, 'MR21_LR1_03', '13', '0.50', '137', 'N'), -- gaabxx
		-- KRU Esports (KRU)
		(37, 'MR21_LR1_03', '18', '2.25', '300', 'Y'), -- bnj
		(36, 'MR21_LR1_03', '30', '2.71', '250', 'N'), -- NagZ
		(38, 'MR21_LR1_03', '19', '1.50', '180', 'N'), -- delz1k
		(39, 'MR21_LR1_03', '20', '1.00', '249', 'N'), -- Klaus
		(40, 'MR21_LR1_03', '20', '1.25', '227', 'N'), -- Mazino

		-- SHK vs KRU 2
		-- Sharks Esports (SHK)
		(33, 'MR21_LR1_04', '13', '1.13', '287', 'N'), -- prozin
		(32, 'MR21_LR1_04', '35', '0.92', '179', 'N'), -- light
		(35, 'MR21_LR1_04', '31', '0.64', '148', 'N'), -- gaabxx
		(34, 'MR21_LR1_04', '15', '0.47', '128', 'N'), -- deNaro
		(31, 'MR21_LR1_04', '19', '0.36', '95', 'N'), -- fra
		-- KRU Esports (KRU)
		(38, 'MR21_LR1_04', '27', '2.38', '253', 'N'), -- delz1k
		(40, 'MR21_LR1_04', '16', '1.73', '289', 'Y'), -- Mazino
		(39, 'MR21_LR1_04', '22', '1.63', '198', 'N'), -- Klaus
		(36, 'MR21_LR1_04', '20', '1.10', '157', 'N'), -- NagZ
		(37, 'MR21_LR1_04', '20', '0.71', '150', 'N'), -- bnj

		-- SEN vs VKS1 1
		-- Sentinels (SEN)
		(3, 'MR21_USF_01', '21', '1.46', '266', 'N'), -- TenZ
		(1, 'MR21_USF_01', '14', '1.24', '318', 'Y'), -- ShahZaM
		(2, 'MR21_USF_01', '2', '1.67', '202', 'N'), -- SicK
		(5, 'MR21_USF_01', '19', '1.00', '171', 'N'), -- dapr
		(4, 'MR21_USF_01', '25', '0.77', '139', 'N'), -- zombs
		-- Team Vikings (VKS1)
		(22, 'MR21_USF_01', '41', '1.07', '260', 'N'), -- Sacy
		(24, 'MR21_USF_01', '11', '0.85', '181', 'N'), -- gtn
		(23, 'MR21_USF_01', '21', '1.08', '215', 'N'), -- saadhak
		(25, 'MR21_USF_01', '16', '0.81', '193', 'N'), -- sutecas
		(21, 'MR21_USF_01', '21', '0.59', '165', 'N'), -- frz

		-- SEN vs VKS1 2
		-- Sentinels (SEN)
		(3, 'MR21_USF_02', '16', '2.33', '309', 'Y'), -- TenZ
		(2, 'MR21_USF_02', '46', '2.11', '277', 'N'), -- SicK
		(1, 'MR21_USF_02', '27', '1.89', '239', 'N'), -- ShahZaM
		(5, 'MR21_USF_02', '16', '0.83', '152', 'N'), -- dapr
		(4, 'MR21_USF_02', '8', '0.90', '148', 'N'), -- zombs
		-- Team Vikings (VKS1)
		(22, 'MR21_USF_02', '24', '0.93', '234', 'N'), -- Sacy
		(25, 'MR21_USF_02', '34', '0.80', '170', 'N'), -- sutecas
		(21, 'MR21_USF_02', '31', '0.73', '144', 'N'), -- frz
		(24, 'MR21_USF_02', '26', '0.44', '136', 'N'), -- gtn
		(23, 'MR21_USF_02', '26', '0.38', '127', 'N'), -- saadhak

		-- V1 vs NU 1
		-- Version1 (V1)
		(9, 'MR21_USF_03', '15', '2.57', '252', 'N'), -- Zellsis
		(6, 'MR21_USF_03', '15', '1.70', '309', 'Y'), -- penny
		(7, 'MR21_USF_03', '29', '1.56', '264', 'N'), -- jammyz
		(8, 'MR21_USF_03', '20', '1.11', '169', 'N'), -- effys
		(10, 'MR21_USF_03', '22', '1.10', '200', 'N'), -- vanity
		-- NUTURN (NU)
		(29, 'MR21_USF_03', '38', '1.00', '264', 'N'), -- Suggest
		(28, 'MR21_USF_03', '34', '0.79', '211', 'N'), -- allow
		(27, 'MR21_USF_03', '53', '0.60', '174', 'N'), -- Lakia
		(26, 'MR21_USF_03', '17', '0.50', '116', 'N'), -- peri
		(30, 'MR21_USF_03', '25', '0.33', '85', 'N'), -- solo

		-- V1 vs NU 2
		-- Version1 (V1)
		(8, 'MR21_USF_04', '23', '2.14', '302', 'N'), -- effys
		(10, 'MR21_USF_04', '25', '1.00', '212', 'N'), -- vanity
		(7, 'MR21_USF_04', '16', '0.86', '189', 'N'), -- jammyz
		(9, 'MR21_USF_04', '15', '0.73', '187', 'N'), -- Zellsis
		(6, 'MR21_USF_04', '20', '0.90', '179', 'N'), -- penny
		-- NUTURN (NU)
		(26, 'MR21_USF_04', '25', '1.33', '218', 'N'), -- peri
		(27, 'MR21_USF_04', '24', '1.00', '181', 'N'), -- Lakia
		(30, 'MR21_USF_04', '21', '0.91', '252', 'Y'), -- solo
		(28, 'MR21_USF_04', '20', '0.82', '193', 'N'), -- allow
		(29, 'MR21_USF_04', '40', '0.77', '157', 'N'), -- Suggest

		-- V1 vs NU 3
		-- Version1 (V1)
		(9, 'MR21_USF_05', '17', '1.56', '258', 'N'), -- Zellsis
		(10, 'MR21_USF_05', '15', '1.00', '211', 'N'), -- vanity
		(7, 'MR21_USF_05', '16', '0.74', '178', 'N'), -- jammyz
		(6, 'MR21_USF_05', '22', '0.64', '184', 'N'), -- penny
		(8, 'MR21_USF_05', '18', '0.40', '91', 'N'), -- effys
		-- NUTURN (NU)
		(27, 'MR21_USF_05', '27', '1.64', '261', 'Y'), -- Lakia
		(26, 'MR21_USF_05', '24', '1.57', '234', 'N'), -- peri
		(29, 'MR21_USF_05', '34', '1.13', '180', 'N'), -- Suggest
		(28, 'MR21_USF_05', '22', '0.94', '185', 'N'), -- allow
		(30, 'MR21_USF_05', '21', '0.89', '204', 'N'), -- solo

		-- FNC vs X10 1
		-- FNATIC (FNC)
		(18, 'MR21_LR2_01', '22', '3.33', '289', 'Y'), -- Mistic
		(17, 'MR21_LR2_01', '24', '3.00', '274', 'N'), -- doma
		(19, 'MR21_LR2_01', '26', '2.20', '185', 'N'), -- MAGNUM
		(16, 'MR21_LR2_01', '19', '1.50', '222', 'N'), -- Boaster
		(20, 'MR21_LR2_01', '15', '1.08', '246', 'N'), -- Derke
		-- X10 Esports (X10)
		(46, 'MR21_LR2_01', '34', '1.29', '278', 'N'), -- foxz
		(49, 'MR21_LR2_01', '35', '0.50', '143', 'N'), -- Crws
		(47, 'MR21_LR2_01', '29', '0.47', '159', 'N'), -- Patiphan
		(48, 'MR21_LR2_01', '14', '0.20', '85', 'N'), -- Sushiboys
		(50, 'MR21_LR2_01', '7', '0.19', '90', 'N'), -- sScary

		-- FNC vs X10 2
		-- FNATIC (FNC)
		(17, 'MR21_LR2_02', '38', '1.50', '251', 'Y'), -- doma
		(18, 'MR21_LR2_02', '28', '1.36', '222', 'N'), -- Mistic
		(20, 'MR21_LR2_02', '26', '0.89', '215', 'N'), -- Derke
		(16, 'MR21_LR2_02', '22', '0.81', '178', 'N'), -- Boaster
		(19, 'MR21_LR2_02', '34', '0.85', '213', 'N'), -- MAGNUM
		-- X10 Esports (X10)
		(50, 'MR21_LR2_02', '9', '1.20', '240', 'N'), -- sScary
		(47, 'MR21_LR2_02', '23', '1.19', '229', 'N'), -- Patiphan
		(49, 'MR21_LR2_02', '15', '0.83', '195', 'N'), -- Crws
		(46, 'MR21_LR2_02', '19', '0.84', '219', 'N'), -- foxz
		(48, 'MR21_LR2_02', '15', '0.78', '184', 'N'), -- Sushiboys

		-- TL vs KRU 1
		-- Team Liquid (TL)
		(11, 'MR21_LR2_03', '35', '3.00', '355', 'Y'), -- ScreaM
		(14, 'MR21_LR2_03', '30', '2.14', '266', 'N'), -- soulcas
		(15, 'MR21_LR2_03', '8', '2.17', '248', 'N'), -- Jamppi
		(13, 'MR21_LR2_03', '23', '1.63', '244', 'N'), -- L1NK
		(12, 'MR21_LR2_03', '18', '1.00', '116', 'N'), -- Kryptix
		-- KRU Esports (KRU)
		(39, 'MR21_LR2_03', '24', '0.79', '195', 'N'), -- Klaus
		(40, 'MR21_LR2_03', '15', '0.58', '153', 'N'), -- Mazino
		(38, 'MR21_LR2_03', '17', '0.31', '102', 'N'), -- delz1k
		(37, 'MR21_LR2_03', '13', '0.47', '145', 'N'), -- bnj
		(36, 'MR21_LR2_03', '30', '0.31', '93', 'N'), -- NagZ

		-- TL vs KRU 2
		-- Team Liquid (TL)
		(13, 'MR21_LR2_04', '35', '1.46', '225', 'N'), -- L1NK
		(11, 'MR21_LR2_04', '30', '1.25', '299', 'N'), -- ScreaM
		(14, 'MR21_LR2_04', '20', '1.30', '175', 'N'), -- soulcas
		(15, 'MR21_LR2_04', '20', '1.43', '237', 'N'), -- Jamppi
		(12, 'MR21_LR2_04', '16', '0.71', '181', 'N'), -- Kryptix
		-- KRU Esports (KRU)
		(39, 'MR21_LR2_04', '23', '1.35', '325', 'Y'), -- Klaus
		(40, 'MR21_LR2_04', '16', '0.73', '150', 'N'), -- Mazino
		(37, 'MR21_LR2_04', '21', '0.67', '161', 'N'), -- bnj
		(38, 'MR21_LR2_04', '17', '0.67', '166', 'N'), -- delz1k
		(36, 'MR21_LR2_04', '33', '0.74', '184', 'N'), -- NagZ

		-- FNC vs V1 1
		-- Version1 (V1)
		(8, 'MR21_LR3_01', '25', '1.50', '259', 'N'), -- effys
		(6, 'MR21_LR3_01', '18', '1.19', '201', 'N'), -- penny
		(10, 'MR21_LR3_01', '19', '1.11', '237', 'N'), -- vanity
		(9, 'MR21_LR3_01', '23', '0.74', '174', 'N'), -- Zellsis
		(7, 'MR21_LR3_01', '17', '0.57', '157', 'N'), -- jammyz
		-- FNATIC (FNC)
		(20, 'MR21_LR3_01', '20', '1.79', '382', 'Y'), -- Derke
		(19, 'MR21_LR3_01', '28', '1.14', '284', 'N'), -- MAGNUM
		(16, 'MR21_LR3_01', '20', '0.88', '178', 'N'), -- Boaster
		(17, 'MR21_LR3_01', '32', '0.61', '126', 'N'), -- doma
		(18, 'MR21_LR3_01', '3', '0.41', '97', 'N'), -- Mistic

		-- FNC vs V1 2
		-- Version1 (V1)
		(10, 'MR21_LR3_02', '23', '0.94', '239', 'N'), -- vanity
		(8, 'MR21_LR3_02', '38', '0.80', '166', 'N'), -- effys
		(9, 'MR21_LR3_02', '14', '0.69', '184', 'N'), -- Zellsis
		(7, 'MR21_LR3_02', '26', '0.44', '115', 'N'), -- jammyz
		(6, 'MR21_LR3_02', '19', '0.53', '138', 'N'), -- penny
		-- FNATIC (FNC)
		(17, 'MR21_LR3_02', '43', '1.75', '311', 'N'), -- doma
		(20, 'MR21_LR3_02', '29', '1.50', '317', 'Y'), -- Derke
		(18, 'MR21_LR3_02', '29', '1.63', '177', 'N'), -- Mistic
		(16, 'MR21_LR3_02', '22', '1.25', '222', 'N'), -- Boaster
		(19, 'MR21_LR3_02', '23', '1.00', '165', 'N'), -- MAGNUM

		-- TL vs VKS1 1
		-- Team Vikings (VKS1)
		(23, 'MR21_LR3_03', '16', '1.21', '238', 'N'), -- saadhak
		(25, 'MR21_LR3_03', '21', '0.94', '196', 'N'), -- sutecas
		(22, 'MR21_LR3_03', '23', '0.71', '156', 'N'), -- Sacy
		(24, 'MR21_LR3_03', '21', '0.53', '126', 'N'), -- gtn
		(21, 'MR21_LR3_03', '17', '0.53', '136', 'N'), -- frz
		-- Team Liquid (TL)
		(15, 'MR21_LR3_03', '20', '2.18', '306', 'Y'), -- Jamppi
		(13, 'MR21_LR3_03', '30', '1.70', '195', 'N'), -- L1NK
		(11, 'MR21_LR3_03', '30', '0.93', '203', 'N'), -- ScreaM
		(12, 'MR21_LR3_03', '17', '0.83', '152', 'N'), -- Kryptix
		(14, 'MR21_LR3_03', '17', '0.73', '146', 'N'), -- soulcas

		-- TL vs VKS1 2
		-- Team Vikings (VKS1)
		(22, 'MR21_LR3_04', '30', '0.93', '240', 'N'), -- Sacy
		(24, 'MR21_LR3_04', '17', '0.69', '173', 'N'), -- gtn
		(21, 'MR21_LR3_04', '24', '0.50', '142', 'N'), -- frz
		(23, 'MR21_LR3_04', '29', '0.56', '142', 'N'), -- saadhak
		(25, 'MR21_LR3_04', '35', '0.38', '107', 'N'), -- sutecas
		-- Team Liquid (TL)
		(15, 'MR21_LR3_04', '25', '2.43', '272', 'N'), -- Jamppi
		(11, 'MR21_LR3_04', '27', '2.56', '330', 'Y'), -- ScreaM
		(13, 'MR21_LR3_04', '48', '1.60', '245', 'N'), -- L1NK
		(14, 'MR21_LR3_04', '18', '1.25', '226', 'N'), -- soulcas
		(12, 'MR21_LR3_04', '24', '0.80', '124', 'N'), -- Kryptix

		-- SEN vs NU 1
		-- Sentinels (SEN)
		(2, 'MR21_UF_01', '31', '2.00', '325', 'N'), -- SicK
		(3, 'MR21_UF_01', '19', '1.58', '273', 'N'), -- TenZ
		(5, 'MR21_UF_01', '8', '1.88', '217', 'N'), -- dapr
		(1, 'MR21_UF_01', '21', '0.82', '129', 'N'), -- ShahZaM
		(4, 'MR21_UF_01', '21', '0.69', '161', 'N'), -- zombs
		-- NUTURN (NU)
		(27, 'MR21_UF_01', '40', '1.33', '355', 'Y'), -- Lakia
		(29, 'MR21_UF_01', '44', '1.42', '246', 'N'), -- Suggest
		(30, 'MR21_UF_01', '27', '0.50', '149', 'N'), -- solo
		(28, 'MR21_UF_01', '9', '0.21', '124', 'N'), -- allow
		(26, 'MR21_UF_01', '12', '0.07', '56', 'N'), -- peri

		-- SEN vs NU 2
		-- Sentinels (SEN)
		(2, 'MR21_UF_02', '31', '1.36', '277', 'N'), -- SicK
		(3, 'MR21_UF_02', '30', '1.90', '296', 'Y'), -- TenZ
		(1, 'MR21_UF_02', '30', '1.50', '227', 'N'), -- ShahZaM
		(5, 'MR21_UF_02', '33', '1.18', '225', 'N'), -- dapr
		(4, 'MR21_UF_02', '23', '1.33', '170', 'N'), -- zombs
		-- NUTURN (NU)
		(30, 'MR21_UF_02', '21', '1.29', '294', 'N'), -- solo
		(26, 'MR21_UF_02', '32', '0.54', '98', 'N'), -- peri
		(28, 'MR21_UF_02', '19', '0.59', '220', 'N'), -- allow
		(27, 'MR21_UF_02', '59', '0.60', '157', 'N'), -- Lakia
		(29, 'MR21_UF_02', '14', '0.47', '130', 'N'), -- Suggest

		-- FNC vs TL 1
		-- FNATIC (FNC)
		(18, 'MR21_LR4_01', '27', '1.00', '155', 'N'), -- Mistic
		(17, 'MR21_LR4_01', '27', '1.13', '238', 'Y'), -- doma
		(16, 'MR21_LR4_01', '36', '1.27', '223', 'N'), -- Boaster
		(19, 'MR21_LR4_01', '35', '0.93', '173', 'N'), -- MAGNUM
		(20, 'MR21_LR4_01', '37', '0.75', '161', 'N'), -- Derke
		-- Team Liquid (TL)
		(12, 'MR21_LR4_01', '34', '1.40', '165', 'N'), -- Kryptix
		(13, 'MR21_LR4_01', '32', '0.94', '217', 'N'), -- L1NK
		(15, 'MR21_LR4_01', '22', '1.00', '195', 'N'), -- Jamppi
		(14, 'MR21_LR4_01', '32', '1.07', '201', 'N'), -- soulcas
		(11, 'MR21_LR4_01', '28', '0.74', '171', 'N'), -- ScreaM

		-- FNC vs TL 2
		-- FNATIC (FNC)
		(19, 'MR21_LR4_02', '33', '1.63', '326', 'Y'), -- MAGNUM
		(18, 'MR21_LR4_02', '28', '2.00', '176', 'N'), -- Mistic
		(16, 'MR21_LR4_02', '18', '1.13', '222', 'N'), -- Boaster
		(20, 'MR21_LR4_02', '29', '1.00', '188', 'N'), -- Derke
		(17, 'MR21_LR4_02', '24', '0.87', '164', 'N'), -- doma
		-- Team Liquid (TL)
		(11, 'MR21_LR4_02', '34', '1.33', '318', 'N'), -- ScreaM
		(13, 'MR21_LR4_02', '27', '1.19', '236', 'N'), -- L1NK
		(14, 'MR21_LR4_02', '38', '0.44', '122', 'N'), -- soulcas
		(15, 'MR21_LR4_02', '28', '0.65', '118', 'N'), -- Jamppi
		(12, 'MR21_LR4_02', '14', '0.40', '137', 'N'), -- Kryptix

		-- FNC vs NU 1
		-- NUTURN (NU)
		(27, 'MR21_LF_01', '33', '1.20', '258', 'N'), -- Lakia
		(26, 'MR21_LF_01', '39', '1.23', '209', 'N'), -- peri
		(29, 'MR21_LF_01', '30', '1.00', '219', 'N'), -- Suggest
		(28, 'MR21_LF_01', '25', '0.71', '171', 'N'), -- allow
		(30, 'MR21_LF_01', '18', '0.39', '120', 'N'), -- solo
		-- FNATIC (FNC)
		(17, 'MR21_LF_01', '25', '1.29', '270', 'Y'), -- doma
		(20, 'MR21_LF_01', '27', '1.23', '243', 'N'), -- Derke
		(19, 'MR21_LF_01', '33', '1.00', '221', 'N'), -- MAGNUM
		(18, 'MR21_LF_01', '28', '1.07', '204', 'N'), -- Mistic
		(16, 'MR21_LF_01', '39', '1.08', '137', 'N'), -- Boaster

		-- FNC vs NU 2
		-- NUTURN (NU)
		(28, 'MR21_LF_02', '27', '1.77', '307', 'N'), -- allow
		(26, 'MR21_LF_02', '35', '1.67', '252', 'N'), -- peri
		(27, 'MR21_LF_02', '21', '1.40', '180', 'N'), -- Lakia
		(30, 'MR21_LF_02', '8', '0.86', '175', 'N'), -- solo
		(29, 'MR21_LF_02', '29', '0.73', '132', 'N'), -- Suggest
		-- FNATIC (FNC)
		(20, 'MR21_LF_02', '37', '1.56', '356', 'Y'), -- Derke
		(19, 'MR21_LF_02', '27', '0.87', '161', 'N'), -- MAGNUM
		(18, 'MR21_LF_02', '19', '0.63', '153', 'N'), -- Mistic
		(17, 'MR21_LF_02', '34', '0.50', '140', 'N'), -- doma
		(16, 'MR21_LF_02', '19', '0.47', '101', 'N'), -- Boaster

		-- FNC vs NU 3
		-- NUTURN (NU)
		(27, 'MR21_LF_03', '23', '1.53', '308', 'Y'), -- Lakia
		(28, 'MR21_LF_03', '24', '0.94', '217', 'N'), -- allow
		(26, 'MR21_LF_03', '18', '0.67', '159', 'N'), -- peri
		(30, 'MR21_LF_03', '14', '0.69', '156', 'N'), -- solo
		(29, 'MR21_LF_03', '33', '0.41', '105', 'N'), -- Suggest
		-- FNATIC (FNC)
		(18, 'MR21_LF_03', '37', '1.56', '175', 'N'), -- Mistic
		(16, 'MR21_LF_03', '28', '1.64', '228', 'N'), -- Boaster
		(19, 'MR21_LF_03', '17', '1.07', '219', 'N'), -- MAGNUM
		(20, 'MR21_LF_03', '27', '1.12', '280', 'N'), -- Derke
		(17, 'MR21_LF_03', '22', '0.87', '173', 'N'), -- doma

		-- SEN vs FNC 1
		-- SENTINELS (SEN)
		(2, 'MR21_GF_01', '16', '1.14', '175', 'N'), -- SicK
		(4, 'MR21_GF_01', '18', '1.15', '259', 'N'), -- zombs
		(3, 'MR21_GF_01', '18', '1.09', '268', 'Y'), -- TenZ
		(1, 'MR21_GF_01', '21', '1.09', '258', 'N'), -- ShahZaM
		(5, 'MR21_GF_01', '19', '0.94', '163', 'N'), -- dapr
		-- FNATIC (FNC)
		(19, 'MR21_GF_01', '27', '1.20', '267', 'N'), -- MAGNUM
		(17, 'MR21_GF_01', '29', '0.95', '233', 'N'), -- doma
		(18, 'MR21_GF_01', '33', '1.11', '216', 'N'), -- Mistic
		(16, 'MR21_GF_01', '25', '0.90', '203', 'N'), -- Boaster
		(20, 'MR21_GF_01', '23', '0.45', '126', 'N'), -- Derke

		-- SEN vs FNC 2
		-- SENTINELS (SEN)
		(3, 'MR21_GF_02', '19', '1.74', '323', 'Y'), -- TenZ
		(1, 'MR21_GF_02', '23', '1.43', '195', 'N'), -- ShahZaM
		(4, 'MR21_GF_02', '11', '1.13', '155', 'N'), -- zombs
		(5, 'MR21_GF_02', '14', '0.94', '162', 'N'), -- dapr
		(2, 'MR21_GF_02', '18', '1.10', '231', 'N'), -- SicK
		-- FNATIC (FNC)
		(18, 'MR21_GF_02', '21', '1.00', '134', 'N'), -- Mistic
		(16, 'MR21_GF_02', '24', '0.96', '216', 'N'), -- Boaster
		(20, 'MR21_GF_02', '19', '0.77', '176', 'N'), -- Derke
		(17, 'MR21_GF_02', '15', '0.65', '173', 'N'), -- doma
		(19, 'MR21_GF_02', '32', '0.65', '160', 'N'), -- MAGNUM

		-- SEN vs FNC 3
		-- SENTINELS (SEN)
		(1, 'MR21_GF_03', '29', '1.54', '234', 'N'), -- ShahZaM
		(3, 'MR21_GF_03', '28', '1.10', '277', 'Y'), -- TenZ
		(5, 'MR21_GF_03', '27', '1.11', '250', 'N'), -- dapr
		(2, 'MR21_GF_03', '23', '0.89', '208', 'N'), -- SicK
		(4, 'MR21_GF_03', '16', '0.56', '107', 'N'), -- zombs
		-- FNATIC (FNC)
		(19, 'MR21_GF_03', '29', '1.20', '261', 'N'), -- MAGNUM
		(18, 'MR21_GF_03', '30', '1.00', '252', 'N'), -- Mistic
		(17, 'MR21_GF_03', '27', '0.94', '200', 'N'), -- doma
		(20, 'MR21_GF_03', '32', '0.71', '223', 'N'), -- Derke
		(16, 'MR21_GF_03', '12', '0.63', '124', 'N'); -- Boaster

INSERT INTO player_stats (player_id, match_id, headshot_pct, kd_ratio, avg_combat_score, mvps)
VALUES	-- Masters Berlin 2021 added
		-- GROUP STAGE
		-- SUP vs ACE 1
		-- Papara SuperMassive (SUP)
		(83, 'MB21_OA_01', '46', '1.38', '264', 'N'), -- pAura
		(86, 'MB21_OA_01', '19', '1.14', '265', 'N'), -- Izzy
		(84, 'MB21_OA_01', '18', '0.50', '135', 'N'), -- russ
		(85, 'MB21_OA_01', '29', '0.53', '154', 'N'), -- Brave
		(82, 'MB21_OA_01', '23', '0.57', '111', 'N'), -- Turko
		-- Acend (ACE)
		(74, 'MB21_OA_01', '26', '2.00', '318', 'Y'), -- cNed
		(72, 'MB21_OA_01', '27', '1.73', '292', 'N'), -- zeek
		(76, 'MB21_OA_01', '35', '0.92', '220', 'N'), -- BONECOLD
		(73, 'MB21_OA_01', '17', '1.10', '159', 'N'), -- starxo
		(75, 'MB21_OA_01', '18', '0.42', '100', 'N'), -- Kiles

		-- SUP vs ACE 2
		-- Papara SuperMassive (SUP)
		(82, 'MB21_OA_02', '44', '1.13', '226', 'N'), -- Turko
		(85, 'MB21_OA_02', '32', '0.83', '211', 'N'), -- Brave
		(86, 'MB21_OA_02', '21', '0.81', '166', 'N'), -- Izzy
		(83, 'MB21_OA_02', '29', '0.94', '195', 'N'), -- pAura
		(84, 'MB21_OA_02', '27', '0.67', '178', 'N'), -- russ
		-- Acend (ACE)
		(73, 'MB21_OA_02', '21', '1.50', '251', 'N'), -- starxo
		(72, 'MB21_OA_02', '14', '1.36', '225', 'N'), -- zeek
		(74, 'MB21_OA_02', '25', '1.40', '268', 'Y'), -- cNed
		(75, 'MB21_OA_02', '25', '1.12', '224', 'N'), -- Kiles
		(76, 'MB21_OA_02', '27', '0.47', '89', 'N'), -- BONECOLD

		-- G2 vs F4Q 1
		-- G2 Esports (G2)
		(69, 'MB21_GD_01', '22', '1.44', '199', 'N'), -- nukkye
		(66, 'MB21_GD_01', '21', '1.45', '238', 'N'), -- Mixwell
		(67, 'MB21_GD_01', '25', '1.20', '197', 'N'), -- koldamenta
		(70, 'MB21_GD_01', '34', '1.50', '253', 'Y'), -- keloqz
		(68, 'MB21_GD_01', '31', '1.08', '199', 'N'), -- AvovA
		-- F4Q (F4Q)
		(100, 'MB21_GD_01', '36', '1.07', '249', 'N'), -- Esperanza
		(98, 'MB21_GD_01', '27', '1.00', '207', 'N'), -- zunba
		(101, 'MB21_GD_01', '13', '0.73', '199', 'N'), -- Bunny
		(99, 'MB21_GD_01', '10', '0.47', '151', 'N'), -- Efina
		(97, 'MB21_GD_01', '18', '0.50', '89', 'N'), -- fiveK

		-- G2 vs F4Q 2
		-- G2 Esports (G2)
		(67, 'MB21_GD_02', '28', '0.81', '191', 'N'), -- koldamenta
		(70, 'MB21_GD_02', '39', '1.06', '228', 'N'), -- keloqz
		(68, 'MB21_GD_02', '23', '0.93', '180', 'N'), -- AvovA
		(69, 'MB21_GD_02', '18', '0.89', '228', 'N'), -- nukkye
		(66, 'MB21_GD_02', '19', '0.73', '137', 'N'), -- Mixwell
		-- F4Q (F4Q)
		(100, 'MB21_GD_02', '35', '1.36', '249', 'N'), -- Esperanza
		(101, 'MB21_GD_02', '14', '1.14', '213', 'N'), -- Bunny
		(97, 'MB21_GD_02', '21', '1.29', '264', 'Y'), -- fiveK
		(98, 'MB21_GD_02', '18', '1.07', '212', 'N'), -- zunba
		(99, 'MB21_GD_02', '13', '0.67', '118', 'N'), -- Efina

		-- G2 vs F4Q 3
		-- G2 Esports (G2)
		(69, 'MB21_GD_03', '27', '1.73', '226', 'N'), -- nukkye
		(70, 'MB21_GD_03', '45', '1.50', '301', 'Y'), -- keloqz
		(68, 'MB21_GD_03', '21', '1.08', '206', 'N'), -- AvovA
		(67, 'MB21_GD_03', '19', '0.75', '126', 'N'), -- koldamenta
		(66, 'MB21_GD_03', '20', '0.81', '184', 'N'), -- Mixwell
		-- F4Q (F4Q)
		(100, 'MB21_GD_03', '27', '1.21', '236', 'N'), -- Esperanza
		(101, 'MB21_GD_03', '14', '1.13', '262', 'N'), -- Bunny
		(98, 'MB21_GD_03', '29', '1.00', '195', 'N'), -- zunba
		(99, 'MB21_GD_03', '24', '0.60', '128', 'N'), -- Efina
		(97, 'MB21_GD_03', '31', '0.44', '124', 'N'), -- fiveK

        -- 100T vs LBR 1
        -- 100 Thieves (100T)
        (54, 'MB21_OC_01', '27', '1.35', '250', 'N'), -- steel
        (51, 'MB21_OC_01', '27', '1.32', '198', 'N'), -- Hiko
        (55, 'MB21_OC_01', '36', '1.26', '250', 'N'), -- Ethan
        (53, 'MB21_OC_01', '24', '0.78', '237', 'N'), -- nitr0
        (52, 'MB21_OC_01', '26', '0.50', '228', 'N'), -- Asuna
        -- Liberty (LBR)
        (87, 'MB21_OC_01', '33', '1.23', '284', 'Y'), -- krain
        (88, 'MB21_OC_01', '24', '0.82', '165', 'N'), -- pleets
        (91, 'MB21_OC_01', '20', '0.71', '199', 'N'), -- liazzi
        (89, 'MB21_OC_01', '50', '0.40', '100', 'N'), -- shion
        (90, 'MB21_OC_01', '52', '0.31', '130', 'N'), -- Myssen

        -- 100T vs LBR 2
        -- 100 Thieves (100T)
        (52, 'MB21_OC_02', '31', '1.83', '333', 'Y'), -- Asuna
        (55, 'MB21_OC_02', '24', '2.10', '291', 'N'), -- Ethan
        (51, 'MB21_OC_02', '34', '1.75', '209', 'N'), -- Hiko
        (53, 'MB21_OC_02', '24', '1.43', '126', 'N'), -- nitr0
        (54, 'MB21_OC_02', '25', '0.92', '176', 'N'), -- steel
        -- Liberty (LBR)
        (90, 'MB21_OC_02', '41', '0.73', '182', 'N'), -- Myssen
        (87, 'MB21_OC_02', '12', '0.53', '160', 'N'), -- krain
        (89, 'MB21_OC_02', '18', '0.71', '182', 'N'), -- shion
        (88, 'MB21_OC_02', '17', '0.59', '175', 'N'), -- pleets
        (91, 'MB21_OC_02', '14', '0.60', '125', 'N'), -- liazzi

        -- VS vs PRX 1
        -- Vision Strikers (VS)
        (62, 'MB21_OA_03', '31', '2.10', '252', 'N'), -- Rb
        (63, 'MB21_OA_03', '34', '1.69', '275', 'N'), -- k1Ng
        (64, 'MB21_OA_03', '18', '1.13', '242', 'N'), -- BuZz
        (65, 'MB21_OA_03', '27', '1.27', '172', 'N'), -- MaKo
        (61, 'MB21_OA_03', '22', '1.00', '117', 'N'), -- stax
        -- Paper Rex (PRX)
        (108, 'MB21_OA_03', '28', '1.11', '281', 'Y'), -- f0rsakeN
        (107, 'MB21_OA_03', '21', '0.69', '139', 'N'), -- mindfreak
        (111, 'MB21_OA_03', '16', '0.50', '108', 'N'), -- shiba
        (109, 'MB21_OA_03', '33', '0.63', '122', 'N'), -- Benkai
        (110, 'MB21_OA_03', '28', '0.55', '165', 'N'), -- d4v41

        -- VS vs PRX 2
        -- Vision Strikers (VS)
        (65, 'MB21_OA_04', '27', '1.38', '213', 'N'), -- MaKo
        (62, 'MB21_OA_04', '28', '1.33', '224', 'N'), -- Rb
        (61, 'MB21_OA_04', '29', '1.36', '186', 'N'), -- stax
        (64, 'MB21_OA_04', '19', '0.95', '240', 'N'), -- BuZz
        (63, 'MB21_OA_04', '29', '0.65', '161', 'N'), -- k1Ng
        -- Paper Rex (PRX)
        (108, 'MB21_OA_04', '30', '1.50', '307', 'Y'), -- f0rsakeN
        (110, 'MB21_OA_04', '31', '1.13', '199', 'N'), -- d4v41
        (109, 'MB21_OA_04', '28', '0.94', '188', 'N'), -- Benkai
        (107, 'MB21_OA_04', '11', '0.56', '137', 'N'), -- mindfreak
        (111, 'MB21_OA_04', '22', '0.50', '127', 'N'), -- shiba

        -- GMB vs CR 1
        -- Gambit Esports (GMB)
        (78, 'MB21_OC_03', '33', '2.00', '359', 'Y'), -- nAts
        (80, 'MB21_OC_03', '48', '2.50', '266', 'N'), -- Redgar
        (79, 'MB21_OC_03', '22', '2.20', '202', 'N'), -- Chronicle
        (77, 'MB21_OC_03', '29', '2.17', '255', 'N'), -- d3ffo
        (81, 'MB21_OC_03', '27', '1.33', '126', 'N'), -- sheydos
        -- Crazy Raccoon (CR)
        (41, 'MB21_OC_03', '38', '0.85', '235', 'N'), -- Munchkin
        (112, 'MB21_OC_03', '31', '0.67', '204', 'N'), -- Bazzi
        (114, 'MB21_OC_03', '50', '0.38', '97', 'N'), -- Fisker
        (45, 'MB21_OC_03', '12', '0.31', '102', 'N'), -- neth
        (113, 'MB21_OC_03', '19', '0.29', '97', 'N'), -- ade

        -- GMB vs CR 2
        -- Gambit Esports (GMB)
        (81, 'MB21_OC_04', '30', '6.33', '312', 'Y'), -- sheydos
        (80, 'MB21_OC_04', '54', '2.80', '260', 'N'), -- Redgar
        (79, 'MB21_OC_04', '26', '2.60', '252', 'N'), -- Chronicle
        (77, 'MB21_OC_04', '13', '1.80', '212', 'N'), -- d3ffo
        (78, 'MB21_OC_04', '31', '2.00', '241', 'N'), -- nAts
        -- Crazy Raccoon (CR)
        (112, 'MB21_OC_04', '19', '0.58', '207', 'N'), -- Bazzi
        (41, 'MB21_OC_04', '12', '0.57', '175', 'N'), -- Munchkin
        (113, 'MB21_OC_04', '11', '0.29', '88', 'N'), -- ade
        (45, 'MB21_OC_04', '11', '0.21', '75', 'N'), -- neth
        (114, 'MB21_OC_04', '40', '0.14', '51', 'N'), -- Fisker

        -- VKS vs NV 1
        -- Team Vikings (VKS1)
        (92, 'MB21_OB_01', '20', '1.38', '297', 'Y'), -- murizzz
        (96, 'MB21_OB_01', '25', '1.19', '229', 'N'), -- heat
        (94, 'MB21_OB_01', '26', '0.84', '170', 'N'), -- v1xen
        (93, 'MB21_OB_01', '16', '0.68', '172', 'N'), -- JhoW
        (95, 'MB21_OB_01', '14', '0.82', '175', 'N'), -- ntk
        -- ENVY (NV)
        (56, 'MB21_OB_01', '30', '1.44', '270', 'N'), -- crashies
        (60, 'MB21_OB_01', '25', '1.53', '291', 'N'), -- yay
        (57, 'MB21_OB_01', '21', '0.95', '214', 'N'), -- Victor
        (58, 'MB21_OB_01', '29', '0.74', '193', 'N'), -- Marved
        (59, 'MB21_OB_01', '14', '0.61', '135', 'N'), -- FiNESSE

        -- VKS vs NV 2
        -- Team Vikings (VKS1)
        (96, 'MB21_OB_02', '21', '1.63', '375', 'Y'), -- heat
        (95, 'MB21_OB_02', '12', '0.75', '161', 'N'), -- ntk
        (93, 'MB21_OB_02', '21', '0.71', '119', 'N'), -- JhoW
        (94, 'MB21_OB_02', '21', '0.71', '150', 'N'), -- v1xen
        (92, 'MB21_OB_02', '22', '0.47', '127', 'N'), -- murizzz
        -- ENVY (NV)
        (60, 'MB21_OB_02', '32', '1.29', '231', 'N'), -- yay
        (59, 'MB21_OB_02', '25', '1.13', '226', 'N'), -- FiNESSE
        (56, 'MB21_OB_02', '28', '1.23', '210', 'N'), -- crashies
        (57, 'MB21_OB_02', '24', '1.17', '186', 'N'), -- Victor
        (58, 'MB21_OB_02', '39', '1.14', '184', 'N'), -- Marved

        -- KRU vs ZETA 1
        -- KRU Esports (KRU)
        (38, 'MB21_OB_03', '24', '1.58', '250', 'N'), -- delz1k
        (71, 'MB21_OB_03', '51', '1.25', '271', 'N'), -- keznit
        (36, 'MB21_OB_03', '24', '0.93', '181', 'N'), -- NagZ
        (39, 'MB21_OB_03', '13', '0.91', '144', 'N'), -- Klaus
        (40, 'MB21_OB_03', '28', '1.17', '162', 'N'), -- Mazino
        -- ZETA DIVISION (ZETA)
        (116, 'MB21_OB_03', '42', '1.33', '278', 'Y'), -- Laz
        (119, 'MB21_OB_03', '38', '1.00', '206', 'N'), -- takej
        (117, 'MB21_OB_03', '34', '0.93', '184', 'N'), -- crow
        (120, 'MB21_OB_03', '24', '0.50', '111', 'N'), -- makiba
        (118, 'MB21_OB_03', '20', '0.50', '107', 'N'), -- Reita

        -- KRU vs ZETA 2
        -- KRU Esports (KRU)
        (36, 'MB21_OB_04', '10', '1.07', '284', 'N'), -- NagZ
        (40, 'MB21_OB_04', '21', '1.00', '231', 'N'), -- Mazino
        (38, 'MB21_OB_04', '36', '0.53', '128', 'N'), -- delz1k
        (71, 'MB21_OB_04', '13', '0.47', '173', 'N'), -- keznit
        (39, 'MB21_OB_04', '8', '0.31', '106', 'N'), -- Klaus
        -- ZETA DIVISION (ZETA)
        (119, 'MB21_OB_04', '31', '2.75', '297', 'Y'), -- takej
        (116, 'MB21_OB_04', '23', '2.22', '283', 'N'), -- Laz
        (117, 'MB21_OB_04', '20', '1.50', '199', 'N'), -- crow
        (118, 'MB21_OB_04', '15', '0.82', '144', 'N'), -- barce
        (120, 'MB21_OB_04', '14', '1.00', '256', 'N'), -- Reita

        -- KRU vs ZETA 3
        -- KRU Esports (KRU)
        (71, 'MB21_OB_05', '19', '1.83', '318', 'Y'), -- keznit
        (39, 'MB21_OB_05', '22', '1.60', '238', 'N'), -- Klaus
        (36, 'MB21_OB_05', '20', '1.50', '208', 'N'), -- NagZ
        (40, 'MB21_OB_05', '19', '1.15', '179', 'N'), -- Mazino
        (38, 'MB21_OB_05', '23', '0.69', '138', 'N'), -- delz1k
        -- ZETA DIVISION (ZETA)
        (119, 'MB21_OB_05', '27', '1.07', '229', 'N'), -- takej
        (117, 'MB21_OB_05', '12', '0.85', '158', 'N'), -- crow
        (116, 'MB21_OB_05', '43', '0.82', '212', 'N'), -- Laz
        (120, 'MB21_OB_05', '17', '0.50', '120', 'N'), -- makiba
        (118, 'MB21_OB_05', '18', '0.59', '143', 'N'), -- Reita

        -- SEN vs G2 1
        -- Sentinels (SEN)
        (1, 'MB21_GD_04', '24', '2.36', '369', 'Y'), -- ShahZaM
        (4, 'MB21_GD_04', '15', '1.40', '203', 'N'), -- zombs
        (2, 'MB21_GD_04', '27', '1.17', '202', 'N'), -- SicK
        (3, 'MB21_GD_04', '21', '1.10', '169', 'N'), -- TenZ
        (5, 'MB21_GD_04', '13', '1.00', '160', 'N'), -- dapr
        -- G2 Esports (G2)
        (67, 'MB21_GD_04', '21', '0.93', '217', 'N'), -- koldamenta
        (69, 'MB21_GD_04', '13', '0.76', '252', 'N'), -- nukkye
        (70, 'MB21_GD_04', '31', '0.67', '165', 'N'), -- keloqz
        (68, 'MB21_GD_04', '36', '0.79', '174', 'N'), -- AvovA
        (66, 'MB21_GD_04', '13', '0.40', '108', 'N'), -- Mixwell

        -- SEN vs G2 2
        -- Sentinels (SEN)
        (3, 'MB21_GD_05', '24', '1.71', '327', 'Y'), -- TenZ
        (4, 'MB21_GD_05', '20', '1.00', '192', 'N'), -- zombs
        (2, 'MB21_GD_05', '23', '0.87', '174', 'N'), -- SicK
        (1, 'MB21_GD_05', '28', '0.75', '155', 'N'), -- ShahZaM
        (5, 'MB21_GD_05', '15', '0.39', '111', 'N'), -- dapr
        -- G2 Esports (G2)
        (69, 'MB21_GD_05', '14', '1.83', '317', 'N'), -- nukkye
        (67, 'MB21_GD_05', '26', '1.25', '187', 'N'), -- koldamenta
        (70, 'MB21_GD_05', '24', '1.18', '265', 'N'), -- keloqz
        (66, 'MB21_GD_05', '18', '0.80', '164', 'N'), -- Mixwell
        (68, 'MB21_GD_05', '21', '0.60', '123', 'N'), -- AvovA

        -- SEN vs G2 3
        -- Sentinels (SEN)
        (2, 'MB21_GD_06', '20', '2.25', '360', 'Y'), -- SicK
        (3, 'MB21_GD_06', '18', '2.38', '249', 'N'), -- TenZ
        (1, 'MB21_GD_06', '24', '1.00', '195', 'N'), -- ShahZaM
        (4, 'MB21_GD_06', '20', '0.92', '155', 'N'), -- zombs
        (5, 'MB21_GD_06', '22', '0.77', '138', 'N'), -- dapr
        -- G2 Esports (G2)
        (68, 'MB21_GD_06', '27', '0.87', '172', 'N'), -- AvovA
        (66, 'MB21_GD_06', '20', '0.75', '171', 'N'), -- Mixwell
        (70, 'MB21_GD_06', '26', '0.82', '168', 'N'), -- keloqz
        (69, 'MB21_GD_06', '29', '0.71', '189', 'N'), -- nukkye
        (67, 'MB21_GD_06', '21', '0.50', '126', 'N'), -- koldamenta

        -- GMB vs 100T 1
        -- Gambit Esports (GMB)
        (80, 'MB21_WC_01', '18', '2.11', '238', 'N'), -- Redgar
        (77, 'MB21_WC_01', '24', '1.36', '284', 'Y'), -- d3ffo
        (81, 'MB21_WC_01', '14', '1.18', '218', 'N'), -- sheydos
        (79, 'MB21_WC_01', '27', '0.73', '157', 'N'), -- Chronicle
        (78, 'MB21_WC_01', '27', '1.00', '178', 'N'), -- nAts
        -- 100 Thieves (100T)
        (55, 'MB21_WC_01', '25', '1.23', '271', 'N'), -- Ethan
        (53, 'MB21_WC_01', '23', '0.93', '202', 'N'), -- nitr0
        (52, 'MB21_WC_01', '28', '0.87', '220', 'N'), -- Asuna
        (51, 'MB21_WC_01', '7', '0.69', '161', 'N'), -- Hiko
        (54, 'MB21_WC_01', '18', '0.38', '111', 'N'), -- steel

        -- GMB vs 100T 2
        -- Gambit Esports (GMB)
        (81, 'MB21_WC_02', '24', '1.73', '289', 'Y'), -- sheydos
        (77, 'MB21_WC_02', '19', '1.53', '267', 'N'), -- d3ffo
        (78, 'MB21_WC_02', '20', '1.00', '182', 'N'), -- nAts
        (79, 'MB21_WC_02', '23', '0.71', '159', 'N'), -- Chronicle
        (80, 'MB21_WC_02', '55', '0.55', '134', 'N'), -- Redgar
        -- 100 Thieves (100T)
        (52, 'MB21_WC_02', '24', '1.21', '271', 'N'), -- Asuna
        (51, 'MB21_WC_02', '29', '0.86', '165', 'N'), -- Hiko
        (53, 'MB21_WC_02', '14', '0.88', '161', 'N'), -- nitr0
        (55, 'MB21_WC_02', '32', '0.94', '207', 'N'), -- Ethan
        (54, 'MB21_WC_02', '27', '0.80', '208', 'N'), -- steel

        -- GMB vs 100T 3
        -- Gambit Esports (GMB)
        (81, 'MB21_WC_03', '43', '1.35', '265', 'Y'), -- sheydos
        (79, 'MB21_WC_03', '17', '1.06', '223', 'N'), -- Chronicle
        (78, 'MB21_WC_03', '35', '1.13', '208', 'N'), -- nAts
        (80, 'MB21_WC_03', '28', '0.65', '152', 'N'), -- Redgar
        (77, 'MB21_WC_03', '18', '0.61', '142', 'N'), -- d3ffo
        -- 100 Thieves (100T)
        (51, 'MB21_WC_03', '34', '1.58', '218', 'N'), -- Hiko
        (53, 'MB21_WC_03', '27', '1.25', '207', 'N'), -- nitr0
        (52, 'MB21_WC_03', '24', '1.10', '301', 'N'), -- Asuna
        (54, 'MB21_WC_03', '12', '0.70', '151', 'N'), -- steel
        (55, 'MB21_WC_03', '26', '0.83', '164', 'N'), -- Ethan

        -- NV vs KRU 1
        -- Team Envy (NV)
        (60, 'MB21_WB_01', '20', '1.73', '349', 'Y'), -- yay
        (57, 'MB21_WB_01', '23', '1.53', '294', 'N'), -- Victor
        (58, 'MB21_WB_01', '34', '0.94', '202', 'N'), -- Marved
        (59, 'MB21_WB_01', '17', '0.80', '160', 'N'), -- FiNESSE
        (56, 'MB21_WB_01', '22', '0.93', '160', 'N'), -- crashies
        -- KRU Esports (KRU)
        (36, 'MB21_WB_01', '27', '1.25', '255', 'N'), -- NagZ
        (40, 'MB21_WB_01', '25', '0.89', '218', 'N'), -- Mazino
        (71, 'MB21_WB_01', '46', '0.90', '222', 'N'), -- keznit
        (39, 'MB21_WB_01', '22', '0.67', '167', 'N'), -- Klaus
        (38, 'MB21_WB_01', '28', '0.47', '104', 'N'), -- delz1k

        -- NV vs KRU 2
        -- Team Envy (NV)
        (56, 'MB21_WB_02', '45', '3.20', '295', 'Y'), -- crashies
        (58, 'MB21_WB_02', '19', '2.80', '239', 'N'), -- Marved
        (60, 'MB21_WB_02', '23', '1.55', '294', 'N'), -- yay
        (57, 'MB21_WB_02', '22', '1.18', '235', 'N'), -- Victor
        (59, 'MB21_WB_02', '10', '1.00', '119', 'N'), -- FiNESSE
        -- KRU Esports (KRU)
        (38, 'MB21_WB_02', '36', '1.00', '219', 'N'), -- delz1k
        (39, 'MB21_WB_02', '28', '0.85', '239', 'N'), -- Klaus
        (36, 'MB21_WB_02', '7', '0.50', '176', 'N'), -- NagZ
        (40, 'MB21_WB_02', '18', '0.36', '132', 'N'), -- Mazino
        (71, 'MB21_WB_02', '43', '0.29', '80', 'N'), -- keznit

        -- VS vs ACE 1
        -- Vision Strikers (VS)
        (64, 'MB21_WA_01', '24', '2.70', '352', 'Y'), -- BuZz
        (62, 'MB21_WA_01', '25', '1.89', '234', 'N'), -- Rb
        (65, 'MB21_WA_01', '23', '1.86', '156', 'N'), -- MaKo
        (61, 'MB21_WA_01', '29', '1.10', '153', 'N'), -- stax
        (63, 'MB21_WA_01', '24', '0.85', '181', 'N'), -- k1Ng
        -- Acend (ACE)
        (74, 'MB21_WA_01', '30', '0.87', '177', 'N'), -- cNed
        (75, 'MB21_WA_01', '26', '0.69', '172', 'N'), -- Kiles
        (73, 'MB21_WA_01', '15', '0.56', '126', 'N'), -- starxo
        (72, 'MB21_WA_01', '16', '0.65', '172', 'N'), -- zeek
        (76, 'MB21_WA_01', '17', '0.31', '76', 'N'), -- BONECOLD

        -- VS vs ACE 2
        -- Vision Strikers (VS)
        (65, 'MB21_WA_02', '26', '1.71', '307', 'Y'), -- MaKo
        (62, 'MB21_WA_02', '28', '1.45', '194', 'N'), -- Rb
        (61, 'MB21_WA_02', '35', '1.31', '190', 'N'), -- stax
        (63, 'MB21_WA_02', '23', '0.93', '189', 'N'), -- k1Ng
        (64, 'MB21_WA_02', '11', '0.76', '155', 'N'), -- BuZz
        -- Acend (ACE)
        (76, 'MB21_WA_02', '41', '1.40', '261', 'N'), -- BONECOLD
        (74, 'MB21_WA_02', '18', '1.23', '270', 'N'), -- cNed
        (72, 'MB21_WA_02', '20', '0.83', '230', 'N'), -- zeek
        (73, 'MB21_WA_02', '18', '0.50', '121', 'N'), -- starxo
        (75, 'MB21_WA_02', '28', '0.30', '69', 'N'), -- Kiles

        -- F4Q vs SEN 1
        -- F4Q (F4Q)
        (99, 'MB21_GD_07', '18', '1.00', '263', 'N'), -- Efina
        (98, 'MB21_GD_07', '28', '1.07', '195', 'N'), -- zunba
        (100, 'MB21_GD_07', '19', '0.68', '174', 'N'), -- Esperanza
        (97, 'MB21_GD_07', '18', '0.65', '135', 'N'), -- fiveK
        (101, 'MB21_GD_07', '18', '0.74', '199', 'N'), -- Bunny
        -- Sentinels (SEN)
        (1, 'MB21_GD_07', '18', '1.73', '321', 'Y'), -- ShahZaM
        (3, 'MB21_GD_07', '21', '1.38', '290', 'N'), -- TenZ
        (2, 'MB21_GD_07', '37', '1.46', '217', 'N'), -- SicK
        (4, 'MB21_GD_07', '10', '0.77', '136', 'N'), -- zombs
        (5, 'MB21_GD_07', '29', '0.73', '145', 'N'), -- dapr

        -- F4Q vs SEN 2
        -- F4Q (F4Q)
        (101, 'MB21_GD_08', '24', '0.83', '206', 'N'), -- Bunny
        (99, 'MB21_GD_08', '28', '0.92', '172', 'N'), -- Efina
        (100, 'MB21_GD_08', '69', '0.67', '175', 'N'), -- Esperanza
        (97, 'MB21_GD_08', '24', '0.33', '106', 'N'), -- fiveK
        (98, 'MB21_GD_08', '33', '0.53', '133', 'N'), -- zunba
        -- Sentinels (SEN)
        (3, 'MB21_GD_08', '35', '4.57', '478', 'Y'), -- TenZ
        (2, 'MB21_GD_08', '23', '1.10', '180', 'N'), -- SicK
        (1, 'MB21_GD_08', '32', '0.89', '147', 'N'), -- ShahZaM
        (5, 'MB21_GD_08', '18', '0.90', '145', 'N'), -- dapr
        (4, 'MB21_GD_08', '21', '1.00', '120', 'N'), -- zombs

        -- F4Q vs G2 1
        -- F4Q (F4Q)
        (100, 'MB21_GD_09', '41', '0.86', '224', 'N'), -- Esperanza
        (99, 'MB21_GD_09', '40', '0.77', '194', 'N'), -- Efina
        (101, 'MB21_GD_09', '20', '0.43', '150', 'N'), -- Bunny
        (97, 'MB21_GD_09', '7', '0.36', '112', 'N'), -- fiveK
        (98, 'MB21_GD_09', '7', '0.19', '67', 'N'), -- zunba
        -- G2 Esports (G2)
        (66, 'MB21_GD_09', '32', '1.88', '246', 'N'), -- Mixwell
        (67, 'MB21_GD_09', '19', '1.67', '189', 'N'), -- koldamenta
        (69, 'MB21_GD_09', '20', '2.29', '285', 'N'), -- nukkye
        (68, 'MB21_GD_09', '14', '3.00', '167', 'N'), -- AvovA
        (70, 'MB21_GD_09', '49', '1.50', '293', 'Y'), -- keloqz

        -- F4Q vs G2 2
        -- F4Q (F4Q)
        (101, 'MB21_GD_10', '13', '0.93', '225', 'N'), -- Bunny
        (98, 'MB21_GD_10', '31', '0.93', '183', 'N'), -- zunba
        (100, 'MB21_GD_10', '31', '0.71', '199', 'N'), -- Esperanza
        (99, 'MB21_GD_10', '24', '0.79', '166', 'N'), -- Efina
        (97, 'MB21_GD_10', '5', '0.47', '117', 'N'), -- fiveK
        -- G2 Esports (G2)
        (69, 'MB21_GD_10', '25', '1.82', '276', 'Y'), -- nukkye
        (67, 'MB21_GD_10', '24', '1.36', '219', 'N'), -- koldamenta
        (66, 'MB21_GD_10', '26', '1.20', '177', 'N'), -- Mixwell
        (70, 'MB21_GD_10', '38', '1.17', '188', 'N'), -- keloqz
        (68, 'MB21_GD_10', '28', '1.07', '204', 'N'), -- AvovA

        -- VKS2 vs ZETA 1
        -- Keyd Stars (VKS2)
        (92, 'MB21_EB_01', '20', '2.33', '273', 'N'), -- murizzz
        (96, 'MB21_EB_01', '34', '3.00', '362', 'Y'), -- heat
        (94, 'MB21_EB_01', '21', '1.60', '142', 'N'), -- v1xen
        (93, 'MB21_EB_01', '11', '1.00', '130', 'N'), -- JhoW
        (95, 'MB21_EB_01', '16', '1.11', '168', 'N'), -- ntk
        -- ZETA DIVISION (ZETA)
        (117, 'MB21_EB_01', '24', '0.83', '175', 'N'), -- crow
        (116, 'MB21_EB_01', '38', '0.67', '155', 'N'), -- Laz
        (120, 'MB21_EB_01', '24', '0.58', '138', 'N'), -- Reita
        (119, 'MB21_EB_01', '29', '0.57', '145', 'N'), -- takej
        (121, 'MB21_EB_01', '17', '0.21', '100', 'N'), -- makiba

        -- VKS2 vs ZETA 2
        -- Keyd Stars (VKS2)
        (96, 'MB21_EB_02', '37', '2.88', '371', 'Y'), -- heat
        (92, 'MB21_EB_02', '22', '2.00', '315', 'N'), -- murizzz
        (95, 'MB21_EB_02', '19', '1.44', '212', 'N'), -- ntk
        (94, 'MB21_EB_02', '13', '1.00', '105', 'N'), -- v1xen
        (93, 'MB21_EB_02', '16', '1.00', '157', 'N'), -- JhoW
        -- ZETA DIVISION (ZETA)
        (116, 'MB21_EB_02', '31', '1.46', '315', 'N'), -- Laz
        (119, 'MB21_EB_02', '23', '0.60', '171', 'N'), -- takej
        (117, 'MB21_EB_02', '13', '0.36', '109', 'N'), -- crow
        (120, 'MB21_EB_02', '9', '0.46', '119', 'N'), -- Reita
        (118, 'MB21_EB_02', '16', '0.24', '83', 'N'), -- barce

        -- CR vs LBR 1
        -- Crazy Raccoon (CR)
        (45, 'MB21_EC_01', '15', '1.36', '260', 'N'), -- neth
        (44, 'MB21_EC_01', '30', '1.38', '217', 'N'), -- Medusa
        (113, 'MB21_EC_01', '23', '1.07', '206', 'N'), -- ade
        (41, 'MB21_EC_01', '18', '1.20', '207', 'N'), -- Munchkin
        (114, 'MB21_EC_01', '21', '0.63', '128', 'N'), -- Fisker
        -- Liberty (LBR)
        (91, 'MB21_EC_01', '24', '1.13', '224', 'N'), -- liazzi
        (87, 'MB21_EC_01', '27', '1.06', '267', 'Y'), -- krain
        (88, 'MB21_EC_01', '19', '0.88', '188', 'N'), -- pleets
        (90, 'MB21_EC_01', '41', '0.73', '151', 'N'), -- Myssen
        (89, 'MB21_EC_01', '20', '0.67', '156', 'N'), -- shion

        -- CR vs LBR 2
        -- Crazy Raccoon (CR)
        (114, 'MB21_EC_02', '23', '1.75', '268', 'N'), -- Fisker
        (45, 'MB21_EC_02', '18', '1.45', '187', 'N'), -- neth
        (113, 'MB21_EC_02', '22', '1.42', '195', 'N'), -- ade
        (41, 'MB21_EC_02', '17', '1.00', '266', 'N'), -- Munchkin
        (44, 'MB21_EC_02', '15', '0.88', '203', 'N'), -- Medusa
        -- Liberty (LBR)
        (89, 'MB21_EC_02', '12', '1.26', '335', 'Y'), -- shion
        (90, 'MB21_EC_02', '50', '0.87', '164', 'N'), -- Myssen
        (88, 'MB21_EC_02', '8', '0.72', '198', 'N'), -- pleets
        (91, 'MB21_EC_02', '20', '0.71', '175', 'N'), -- liazzi
        (87, 'MB21_EC_02', '7', '0.44', '111', 'N'), -- krain

        -- PRX vs SUP 1
        -- Paper Rex (PRX)
        (110, 'MB21_EA_01', '33', '1.67', '277', 'Y'), -- d4v41
        (111, 'MB21_EA_01', '21', '1.29', '206', 'N'), -- shiba
        (109, 'MB21_EA_01', '22', '0.67', '135', 'N'), -- Benkai
        (108, 'MB21_EA_01', '37', '0.95', '196', 'N'), -- f0rsakeN
        (107, 'MB21_EA_01', '20', '0.83', '154', 'N'), -- mindfreak
        -- Papara SuperMassive (SUP)
        (83, 'MB21_EA_01', '29', '0.95', '215', 'N'), -- pAura
        (86, 'MB21_EA_01', '19', '1.24', '205', 'N'), -- Izzy
        (85, 'MB21_EA_01', '33', '0.88', '183', 'N'), -- Brave
        (82, 'MB21_EA_01', '39', '0.88', '148', 'N'), -- Turko
        (84, 'MB21_EA_01', '33', '0.76', '141', 'N'), -- russ

        -- PRX vs SUP 2
        -- Paper Rex (PRX)
        (110, 'MB21_EA_02', '18', '0.57', '175', 'N'), -- d4v41
        (107, 'MB21_EA_02', '19', '0.62', '160', 'N'), -- mindfreak
        (109, 'MB21_EA_02', '12', '0.38', '106', 'N'), -- Benkai
        (108, 'MB21_EA_02', '39', '0.40', '154', 'N'), -- f0rsakeN
        (111, 'MB21_EA_02', '0', '0.00', '28', 'N'), -- shiba
        -- Papara SuperMassive (SUP)
        (84, 'MB21_EA_02', '32', '4.00', '268', 'N'), -- russ
        (83, 'MB21_EA_02', '38', '2.67', '259', 'N'), -- pAura
        (85, 'MB21_EA_02', '27', '2.00', '284', 'Y'), -- Brave
        (82, 'MB21_EA_02', '33', '2.25', '169', 'N'), -- Turko
        (86, 'MB21_EA_02', '19', '2.17', '217', 'N'), -- Izzy

        -- PRX vs SUP 3
        -- Paper Rex (PRX)
        (109, 'MB21_EA_03', '24', '1.15', '194', 'N'), -- Benkai
        (107, 'MB21_EA_03', '14', '0.82', '173', 'N'), -- mindfreak
        (111, 'MB21_EA_03', '27', '0.81', '175', 'N'), -- shiba
        (108, 'MB21_EA_03', '29', '0.84', '200', 'N'), -- f0rsakeN
        (110, 'MB21_EA_03', '14', '0.53', '137', 'N'), -- d4v41
        -- Papara SuperMassive (SUP)
        (85, 'MB21_EA_03', '43', '1.77', '250', 'Y'), -- Brave
        (82, 'MB21_EA_03', '17', '1.46', '232', 'N'), -- Turko
        (86, 'MB21_EA_03', '12', '1.12', '238', 'N'), -- Izzy
        (84, 'MB21_EA_03', '29', '1.20', '228', 'N'), -- russ
        (83, 'MB21_EA_03', '41', '0.55', '72', 'N'), -- pAura

        -- G2 vs SEN 1
        -- G2 Esports (G2)
        (70, 'MB21_GD_11', '26', '4.60', '376', 'Y'), -- keloqz
        (69, 'MB21_GD_11', '21', '2.13', '315', 'N'), -- nukkye
        (68, 'MB21_GD_11', '23', '2.20', '149', 'N'), -- AvovA
        (66, 'MB21_GD_11', '13', '1.10', '211', 'N'), -- Mixwell
        (67, 'MB21_GD_11', '13', '1.00', '172', 'N'), -- koldamenta
        -- Sentinels (SEN)
        (1, 'MB21_GD_11', '11', '0.79', '219', 'N'), -- ShahZaM
        (3, 'MB21_GD_11', '21', '0.71', '201', 'N'), -- TenZ
        (2, 'MB21_GD_11', '34', '0.60', '174', 'N'), -- SicK
        (5, 'MB21_GD_11', '25', '0.50', '147', 'N'), -- dapr
        (4, 'MB21_GD_11', '10', '0.07', '59', 'N'), -- zombs

        -- G2 vs SEN 2
        -- G2 Esports (G2)
        (68, 'MB21_GD_12', '30', '1.63', '285', 'Y'), -- AvovA
        (69, 'MB21_GD_12', '27', '1.67', '228', 'N'), -- nukkye
        (70, 'MB21_GD_12', '22', '1.12', '225', 'N'), -- keloqz
        (66, 'MB21_GD_12', '18', '0.89', '237', 'N'), -- Mixwell
        (67, 'MB21_GD_12', '19', '0.75', '148', 'N'), -- koldamenta
        -- Sentinels (SEN)
        (5, 'MB21_GD_12', '23', '1.13', '221', 'N'), -- dapr
        (4, 'MB21_GD_12', '12', '0.76', '155', 'N'), -- zombs
        (2, 'MB21_GD_12', '19', '0.90', '217', 'N'), -- SicK
        (3, 'MB21_GD_12', '18', '0.77', '208', 'N'), -- TenZ
        (1, 'MB21_GD_12', '17', '0.74', '177', 'N'), -- ShahZaM

        -- KRU vs VKS2 1
        -- KRU Esports (KRU)
        (71, 'MB21_DB_01', '15', '1.72', '360', 'Y'), -- keznit
        (39, 'MB21_DB_01', '19', '2.00', '248', 'N'), -- Klaus
        (36, 'MB21_DB_01', '22', '0.75', '183', 'N'), -- NagZ
        (40, 'MB21_DB_01', '18', '0.65', '124', 'N'), -- Mazino
        (38, 'MB21_DB_01', '23', '0.71', '135', 'N'), -- delz1k
        -- Keyd Stars (VKS2)
        (94, 'MB21_DB_01', '28', '1.24', '226', 'N'), -- v1xen
        (93, 'MB21_DB_01', '13', '1.21', '193', 'N'), -- JhoW
        (96, 'MB21_DB_01', '31', '0.84', '184', 'N'), -- heat
        (92, 'MB21_DB_01', '22', '0.68', '221', 'N'), -- murizzz
        (95, 'MB21_DB_01', '17', '0.74', '183', 'N'), -- ntk

        -- KRU vs VKS2 2
        -- KRÜ Esports (KRU)
        (36, 'MB21_DB_02', '29', '1.38', '217', 'N'), -- NagZ
        (38, 'MB21_DB_02', '35', '1.35', '260', 'Y'), -- delz1k
        (71, 'MB21_DB_02', '24', '1.29', '181', 'N'), -- keznit
        (40, 'MB21_DB_02', '17', '1.00', '205', 'N'), -- Mazino
        (39, 'MB21_DB_02', '18', '0.63', '148', 'N'), -- Klaus
        -- Keyd Stars (VKS2)
        (94, 'MB21_DB_02', '38', '1.58', '204', 'N'), -- v1xen
        (92, 'MB21_DB_02', '22', '0.94', '201', 'N'), -- murizzz
        (93, 'MB21_DB_02', '10', '0.79', '196', 'N'), -- JhoW
        (95, 'MB21_DB_02', '26', '0.82', '169', 'N'), -- ntk
        (96, 'MB21_DB_02', '26', '0.63', '161', 'N'), -- heat

        -- ACE vs SUP 1
        -- Acend (ACE)
        (72, 'MB21_DA_01', '8', '1.23', '265', 'N'), -- zeek
        (73, 'MB21_DA_01', '24', '0.80', '178', 'N'), -- starxo
        (75, 'MB21_DA_01', '23', '0.75', '195', 'N'), -- Kiles
        (74, 'MB21_DA_01', '15', '0.65', '222', 'N'), -- cNed
        (76, 'MB21_DA_01', '17', '0.57', '101', 'N'), -- BONECOLD
        -- SuperMassive Blaze (SUP)
        (86, 'MB21_DA_01', '28', '2.17', '344', 'Y'), -- Izzy
        (84, 'MB21_DA_01', '28', '1.21', '271', 'N'), -- russ
        (85, 'MB21_DA_01', '33', '1.00', '194', 'N'), -- Brave
        (82, 'MB21_DA_01', '27', '1.09', '150', 'N'), -- Turko
        (83, 'MB21_DA_01', '29', '0.91', '146', 'N'), -- pAura

        -- ACE vs SUP 2
        -- Acend (ACE)
        (73, 'MB21_DA_02', '23', '1.67', '263', 'N'), -- starxo
        (74, 'MB21_DA_02', '22', '1.91', '279', 'Y'), -- cNed
        (76, 'MB21_DA_02', '36', '1.50', '253', 'N'), -- BONECOLD
        (72, 'MB21_DA_02', '13', '1.40', '196', 'N'), -- zeek
        (75, 'MB21_DA_02', '25', '1.00', '146', 'N'), -- Kiles
        -- SuperMassive Blaze (SUP)
        (85, 'MB21_DA_02', '25', '0.76', '238', 'N'), -- Brave
        (84, 'MB21_DA_02', '35', '0.88', '225', 'N'), -- russ
        (83, 'MB21_DA_02', '32', '0.76', '167', 'N'), -- pAura
        (82, 'MB21_DA_02', '27', '0.50', '97', 'N'), -- Turko
        (86, 'MB21_DA_02', '17', '0.42', '125', 'N'), -- Izzy

        -- ACE vs SUP 3
        -- Acend (ACE)
        (72, 'MB21_DA_03', '12', '1.69', '348', 'Y'), -- zeek
        (74, 'MB21_DA_03', '21', '1.60', '301', 'N'), -- cNed
        (73, 'MB21_DA_03', '21', '1.12', '218', 'N'), -- starxo
        (75, 'MB21_DA_03', '25', '0.87', '144', 'N'), -- Kiles
        (76, 'MB21_DA_03', '40', '0.63', '138', 'N'), -- BONECOLD
        -- SuperMassive Blaze (SUP)
        (82, 'MB21_DA_03', '41', '1.07', '173', 'N'), -- Turko
        (84, 'MB21_DA_03', '26', '1.05', '251', 'N'), -- russ
        (83, 'MB21_DA_03', '29', '0.70', '214', 'N'), -- pAura
        (86, 'MB21_DA_03', '19', '0.90', '215', 'N'), -- Izzy
        (85, 'MB21_DA_03', '23', '0.60', '159', 'N'), -- Brave

        -- GMB vs CR 1
        -- Gambit Esports (GMB)
        (78, 'MB21_DC_01', '33', '3.00', '387', 'Y'), -- nAts
        (79, 'MB21_DC_01', '23', '1.50', '191', 'N'), -- Chronicle
        (81, 'MB21_DC_01', '21', '1.36', '232', 'N'), -- sheydos
        (77, 'MB21_DC_01', '35', '1.00', '175', 'N'), -- d3ffo
        (80, 'MB21_DC_01', '24', '0.80', '157', 'N'), -- Redgar
        -- Crazy Raccoon (CR)
        (45, 'MB21_DC_01', '27', '1.22', '289', 'N'), -- neth
        (44, 'MB21_DC_01', '27', '0.94', '232', 'N'), -- Medusa
        (113, 'MB21_DC_01', '21', '0.56', '133', 'N'), -- ade
        (41, 'MB21_DC_01', '4', '0.44', '89', 'N'), -- Munchkin
        (114, 'MB21_DC_01', '38', '0.30', '98', 'N'), -- Fisker

        -- GMB vs CR 2
        -- Gambit Esports (GMB)
        (77, 'MB21_DC_02', '31', '1.25', '271', 'Y'), -- d3ffo
        (79, 'MB21_DC_02', '34', '1.11', '221', 'N'), -- Chronicle
        (78, 'MB21_DC_02', '37', '1.00', '236', 'N'), -- nAts
        (81, 'MB21_DC_02', '25', '0.94', '167', 'N'), -- sheydos
        (80, 'MB21_DC_02', '32', '0.68', '152', 'N'), -- Redgar
        -- Crazy Raccoon (CR)
        (113, 'MB21_DC_02', '33', '1.14', '183', 'N'), -- ade
        (41, 'MB21_DC_02', '20', '1.05', '227', 'N'), -- Munchkin
        (112, 'MB21_DC_02', '21', '1.00', '223', 'N'), -- Bazzi
        (114, 'MB21_DC_02', '39', '1.05', '243', 'N'), -- Fisker
        (45, 'MB21_DC_02', '29', '0.79', '162', 'N'), -- neth

		-- SEN vs F4Q 1
		-- Sentinels (SEN)
		(3, 'MB21_GD_13', '20', '3.43', '391', 'Y'), -- TenZ
		(1, 'MB21_GD_13', '20', '2.13', '266', 'N'), -- ShahZaM
		(5, 'MB21_GD_13', '14', '1.33', '203', 'N'), -- dapr
		(4, 'MB21_GD_13', '26', '0.89', '147', 'N'), -- zombs
		(2, 'MB21_GD_13', '17', '1.00', '167', 'N'), -- SicK
		-- F4Q (F4Q)
		(101, 'MB21_GD_13', '17', '1.15', '259', 'N'), -- Bunny
		(99, 'MB21_GD_13', '29', '0.77', '183', 'N'), -- Efina
		(97, 'MB21_GD_13', '20', '0.50', '163', 'N'), -- fiveK
		(98, 'MB21_GD_13', '27', '0.43', '137', 'N'), -- zunba
		(100, 'MB21_GD_13', '27', '0.21', '70', 'N'), -- Esperanza

		-- SEN vs F4Q 2
		-- Sentinels (SEN)
		(4, 'MB21_GD_14', '16', '1.12', '238', 'N'), -- zombs
		(2, 'MB21_GD_14', '15', '0.81', '201', 'N'), -- SicK
		(5, 'MB21_GD_14', '18', '0.65', '146', 'N'), -- dapr
		(3, 'MB21_GD_14', '16', '0.74', '174', 'N'), -- TenZ
		(1, 'MB21_GD_14', '11', '0.50', '127', 'N'), -- ShahZaM
		-- F4Q (F4Q)
		(97, 'MB21_GD_14', '21', '1.57', '294', 'N'), -- fiveK
		(101, 'MB21_GD_14', '15', '1.86', '321', 'Y'), -- Bunny
		(98, 'MB21_GD_14', '20', '1.17', '203', 'N'), -- zunba
		(100, 'MB21_GD_14', '32', '1.33', '210', 'N'), -- Esperanza
		(99, 'MB21_GD_14', '24', '0.54', '79', 'N'), -- Efina

		-- SEN vs F4Q 3
		-- Sentinels (SEN)
		(1, 'MB21_GD_15', '24', '2.17', '197', 'N'), -- ShahZaM
		(2, 'MB21_GD_15', '28', '1.58', '321', 'Y'), -- SicK
		(4, 'MB21_GD_15', '26', '1.22', '157', 'N'), -- zombs
		(3, 'MB21_GD_15', '23', '1.29', '303', 'N'), -- TenZ
		(5, 'MB21_GD_15', '12', '0.90', '142', 'N'), -- dapr
		-- F4Q (F4Q)
		(98, 'MB21_GD_15', '34', '1.08', '206', 'N'), -- zunba
		(101, 'MB21_GD_15', '15', '1.00', '254', 'N'), -- Bunny
		(97, 'MB21_GD_15', '31', '0.67', '194', 'N'), -- fiveK
		(100, 'MB21_GD_15', '43', '0.50', '128', 'N'), -- Esperanza
		(99, 'MB21_GD_15', '22', '0.43', '105', 'N'), -- Efina
        
        -- PLAYOFFS
		-- VS vs GMB 1
		-- Vision Strikers (VS)
		(61, 'MB21_QF_01', '37', '0.80', '212', 'N'), -- stax
		(65, 'MB21_QF_01', '42', '0.54', '178', 'N'), -- MaKo
		(27, 'MB21_QF_01', '33', '0.50', '147', 'N'), -- Lakia
		(64, 'MB21_QF_01', '19', '0.54', '127', 'N'), -- BuZz
		(62, 'MB21_QF_01', '0', '0.07', '57', 'N'), -- Rb
		-- Gambit Esports (GMB)
		(78, 'MB21_QF_01', '26', '2.67', '460', 'Y'), -- nAts
		(79, 'MB21_QF_01', '20', '2.67', '127', 'N'), -- Chronicle
		(77, 'MB21_QF_01', '12', '2.17', '220', 'N'), -- d3ffo
		(80, 'MB21_QF_01', '32', '1.67', '154', 'N'), -- Redgar
		(81, 'MB21_QF_01', '33', '1.40', '226', 'N'), -- sheydos

		-- VS vs GMB 2
		-- Vision Strikers (VS)
		(61, 'MB21_QF_02', '50', '1.91', '231', 'N'), -- stax
		(64, 'MB21_QF_02', '21', '1.80', '248', 'Y'), -- BuZz
		(65, 'MB21_QF_02', '38', '1.36', '218', 'N'), -- MaKo
		(62, 'MB21_QF_02', '26', '1.00', '207', 'N'), -- Rb
		(63, 'MB21_QF_02', '21', '0.69', '147', 'N'), -- k1Ng
		-- Gambit Esports (GMB)
		(79, 'MB21_QF_02', '16', '0.94', '233', 'N'), -- Chronicle
		(77, 'MB21_QF_02', '20', '0.93', '185', 'N'), -- d3ffo
		(80, 'MB21_QF_02', '31', '0.75', '171', 'N'), -- Redgar
		(78, 'MB21_QF_02', '24', '1.00', '204', 'N'), -- nAts
		(81, 'MB21_QF_02', '29', '0.38', '80', 'N'), -- sheydos

		-- VS vs GMB 3
		-- Vision Strikers (VS)
		(64, 'MB21_QF_03', '23', '1.44', '303', 'Y'), -- BuZz
		(65, 'MB21_QF_03', '23', '1.00', '194', 'N'), -- MaKo
		(61, 'MB21_QF_03', '34', '0.86', '151', 'N'), -- stax
		(63, 'MB21_QF_03', '36', '1.00', '171', 'N'), -- k1Ng
		(62, 'MB21_QF_03', '23', '0.37', '126', 'N'), -- Rb
		-- Gambit Esports (GMB)
		(79, 'MB21_QF_03', '24', '1.40', '299', 'N'), -- Chronicle
		(81, 'MB21_QF_03', '40', '1.33', '220', 'N'), -- sheydos
		(77, 'MB21_QF_03', '40', '1.33', '207', 'N'), -- d3ffo
		(78, 'MB21_QF_03', '23', '1.23', '224', 'N'), -- nAts
		(80, 'MB21_QF_03', '30', '0.53', '97', 'N'), -- Redgar

		-- G2 vs KRU 1
		-- G2 Esports (G2)
		(70, 'MB21_QF_04', '18', '1.73', '332', 'Y'), -- keloqz
		(68, 'MB21_QF_04', '29', '1.38', '201', 'N'), -- AvovA
		(67, 'MB21_QF_04', '42', '1.20', '214', 'N'), -- koldamenta
		(69, 'MB21_QF_04', '11', '1.14', '234', 'N'), -- nukkye
		(66, 'MB21_QF_04', '24', '0.62', '105', 'N'), -- Mixwell
		-- KRÜ Esports (KRU)
		(71, 'MB21_QF_04', '23', '1.22', '294', 'N'), -- keznit
		(38, 'MB21_QF_04', '35', '0.83', '208', 'N'), -- delz1k
		(36, 'MB21_QF_04', '13', '0.75', '191', 'N'), -- NagZ
		(40, 'MB21_QF_04', '19', '0.59', '143', 'N'), -- Mazino
		(39, 'MB21_QF_04', '17', '0.65', '127', 'N'), -- Klaus

		-- G2 vs KRU 2
		-- G2 Esports (G2)
		(70, 'MB21_QF_05', '25', '2.17', '372', 'Y'), -- keloqz
		(67, 'MB21_QF_05', '16', '2.38', '261', 'N'), -- koldamenta
		(66, 'MB21_QF_05', '20', '1.60', '237', 'N'), -- Mixwell
		(69, 'MB21_QF_05', '12', '1.30', '183', 'N'), -- nukkye
		(68, 'MB21_QF_05', '13', '0.62', '124', 'N'), -- AvovA
		-- KRÜ Esports (KRU)
		(36, 'MB21_QF_05', '20', '0.71', '188', 'N'), -- NagZ
		(38, 'MB21_QF_05', '19', '0.80', '177', 'N'), -- delz1k
		(39, 'MB21_QF_05', '32', '0.69', '166', 'N'), -- Klaus
		(71, 'MB21_QF_05', '26', '0.59', '144', 'N'), -- keznit
		(40, 'MB21_QF_05', '27', '0.47', '131', 'N'), -- Mazino

		-- 100T vs ACE 1
		-- 100 Thieves (100T)
		(51, 'MB21_QF_06', '26', '1.13', '255', 'N'), -- Hiko
		(53, 'MB21_QF_06', '30', '1.13', '221', 'N'), -- nitr0
		(54, 'MB21_QF_06', '17', '0.58', '173', 'N'), -- steel
		(55, 'MB21_QF_06', '16', '0.83', '181', 'N'), -- Ethan
		(52, 'MB21_QF_06', '20', '0.50', '120', 'N'), -- Asuna
		-- Acend (ACE)
		(74, 'MB21_QF_06', '13', '1.64', '287', 'Y'), -- cNed
		(72, 'MB21_QF_06', '19', '1.73', '235', 'N'), -- zeek
		(73, 'MB21_QF_06', '25', '1.46', '223', 'N'), -- starxo
		(75, 'MB21_QF_06', '29', '1.07', '215', 'N'), -- Kiles
		(76, 'MB21_QF_06', '43', '0.47', '92', 'N'), -- BONECOLD

		-- 100T vs ACE 2
		-- 100 Thieves (100T)
		(51, 'MB21_QF_07', '17', '1.70', '240', 'N'), -- Hiko
		(52, 'MB21_QF_07', '22', '1.40', '303', 'N'), -- Asuna
		(55, 'MB21_QF_07', '28', '1.31', '216', 'N'), -- Ethan
		(53, 'MB21_QF_07', '22', '1.15', '184', 'N'), -- nitr0
		(54, 'MB21_QF_07', '20', '0.92', '131', 'N'), -- steel
		-- Acend (ACE)
		(74, 'MB21_QF_07', '31', '1.44', '307', 'Y'), -- cNed
		(75, 'MB21_QF_07', '29', '1.00', '219', 'N'), -- Kiles
		(76, 'MB21_QF_07', '26', '0.60', '133', 'N'), -- BONECOLD
		(73, 'MB21_QF_07', '21', '0.41', '117', 'N'), -- starxo
		(72, 'MB21_QF_07', '15', '0.47', '106', 'N'), -- zeek

		-- 100T vs ACE 3
		-- 100 Thieves (100T)
		(53, 'MB21_QF_08', '19', '1.85', '237', 'N'), -- nitr0
		(54, 'MB21_QF_08', '26', '1.36', '213', 'N'), -- steel
		(52, 'MB21_QF_08', '27', '1.17', '261', 'Y'), -- Asuna
		(51, 'MB21_QF_08', '31', '1.00', '176', 'N'), -- Hiko
		(55, 'MB21_QF_08', '24', '1.11', '187', 'N'), -- Ethan
		-- Acend (ACE)
		(74, 'MB21_QF_08', '10', '1.41', '249', 'N'), -- cNed
		(72, 'MB21_QF_08', '35', '0.85', '188', 'N'), -- zeek
		(73, 'MB21_QF_08', '20', '0.68', '171', 'N'), -- starxo
		(75, 'MB21_QF_08', '33', '0.71', '149', 'N'), -- Kiles
		(76, 'MB21_QF_08', '12', '0.32', '90', 'N'), -- BONECOLD

		-- NV vs SEN 1
		-- ENVY (NV)
		(60, 'MB21_QF_09', '26', '1.26', '239', 'N'), -- yay
		(56, 'MB21_QF_09', '15', '1.16', '229', 'N'), -- crashies
		(58, 'MB21_QF_09', '33', '0.89', '161', 'N'), -- Marved
		(57, 'MB21_QF_09', '29', '0.86', '190', 'N'), -- Victor
		(59, 'MB21_QF_09', '27', '0.81', '200', 'N'), -- FiNESSE
		-- Sentinels (SEN)
		(3, 'MB21_QF_09', '16', '1.76', '287', 'Y'), -- TenZ
		(1, 'MB21_QF_09', '24', '1.06', '208', 'N'), -- ShahZaM
		(4, 'MB21_QF_09', '20', '0.83', '132', 'N'), -- zombs
		(5, 'MB21_QF_09', '22', '0.91', '203', 'N'), -- dapr
		(2, 'MB21_QF_09', '18', '0.65', '203', 'N'), -- SicK

		-- NV vs SEN 2
		-- ENVY (NV)
		(60, 'MB21_QF_10', '27', '2.00', '295', 'Y'), -- yay
		(57, 'MB21_QF_10', '31', '2.11', '229', 'N'), -- Victor
		(58, 'MB21_QF_10', '26', '1.42', '246', 'N'), -- Marved
		(56, 'MB21_QF_10', '19', '0.80', '193', 'N'), -- crashies
		(59, 'MB21_QF_10', '19', '0.71', '141', 'N'), -- FiNESSE
		-- Sentinels (SEN)
		(2, 'MB21_QF_10', '20', '1.00', '228', 'N'), -- SicK
		(5, 'MB21_QF_10', '13', '0.81', '214', 'N'), -- dapr
		(4, 'MB21_QF_10', '10', '0.86', '188', 'N'), -- zombs
		(1, 'MB21_QF_10', '22', '0.75', '167', 'N'), -- ShahZaM
		(3, 'MB21_QF_10', '13', '0.44', '157', 'N'), -- TenZ

		-- GMB vs G2 1
		-- Gambit Esports (GMB)
		(78, 'MB21_SF_01', '41', '1.56', '318', 'Y'), -- nAts
		(77, 'MB21_SF_01', '36', '1.13', '214', 'N'), -- d3ffo
		(81, 'MB21_SF_01', '39', '1.00', '183', 'N'), -- sheydos
		(79, 'MB21_SF_01', '25', '0.94', '191', 'N'), -- Chronicle
		(80, 'MB21_SF_01', '33', '0.73', '141', 'N'), -- Redgar
		-- G2 Esports (G2)
		(70, 'MB21_SF_01', '20', '1.41', '266', 'N'), -- keloqz
		(68, 'MB21_SF_01', '27', '0.75', '159', 'N'), -- AvovA
		(69, 'MB21_SF_01', '31', '1.06', '236', 'N'), -- nukkye
		(66, 'MB21_SF_01', '22', '0.75', '139', 'N'), -- Mixwell
		(67, 'MB21_SF_01', '30', '0.68', '173', 'N'), -- koldamenta

		-- GMB vs G2 2
		-- Gambit Esports (GMB)
		(79, 'MB21_SF_02', '35', '7.00', '264', 'N'), -- Chronicle
		(81, 'MB21_SF_02', '20', '3.00', '294', 'N'), -- sheydos
		(78, 'MB21_SF_02', '44', '1.67', '326', 'Y'), -- nAts
		(77, 'MB21_SF_02', '35', '2.80', '277', 'N'), -- d3ffo
		(80, 'MB21_SF_02', '33', '1.75', '151', 'N'), -- Redgar
		-- G2 Esports (G2)
		(66, 'MB21_SF_02', '21', '0.69', '217', 'N'), -- Mixwell
		(70, 'MB21_SF_02', '50', '0.54', '169', 'N'), -- keloqz
		(68, 'MB21_SF_02', '26', '0.38', '128', 'N'), -- AvovA
		(69, 'MB21_SF_02', '8', '0.15', '91', 'N'), -- nukkye
		(67, 'MB21_SF_02', '22', '0.15', '62', 'N'), -- koldamenta

		-- 100T vs NV 1
		-- 100 Thieves (100T)
		(53, 'MB21_SF_03', '33', '0.93', '180', 'N'), -- nitr0
		(55, 'MB21_SF_03', '24', '0.81', '230', 'N'), -- Ethan
		(54, 'MB21_SF_03', '21', '0.60', '187', 'N'), -- steel
		(52, 'MB21_SF_03', '22', '0.56', '160', 'N'), -- Asuna
		(51, 'MB21_SF_03', '20', '0.40', '120', 'N'), -- Hiko
		-- ENVY (NV)
		(60, 'MB21_SF_03', '35', '3.44', '449', 'Y'), -- yay
		(57, 'MB21_SF_03', '37', '1.55', '266', 'N'), -- Victor
		(58, 'MB21_SF_03', '29', '1.20', '174', 'N'), -- Marved
		(56, 'MB21_SF_03', '19', '0.80', '126', 'N'), -- crashies
		(59, 'MB21_SF_03', '16', '0.80', '146', 'N'), -- FiNESSE

		-- 100T vs NV 2
		-- 100 Thieves (100T)
		(53, 'MB21_SF_04', '42', '1.85', '272', 'N'), -- nitr0
		(52, 'MB21_SF_04', '19', '1.12', '277', 'N'), -- Asuna
		(51, 'MB21_SF_04', '11', '0.44', '128', 'N'), -- Hiko
		(55, 'MB21_SF_04', '24', '0.60', '130', 'N'), -- Ethan
		(54, 'MB21_SF_04', '21', '0.56', '143', 'N'), -- steel
		-- ENVY (NV)
		(56, 'MB21_SF_04', '27', '1.58', '267', 'N'), -- crashies
		(60, 'MB21_SF_04', '25', '1.18', '284', 'Y'), -- yay
		(58, 'MB21_SF_04', '40', '1.38', '212', 'N'), -- Marved
		(57, 'MB21_SF_04', '28', '0.92', '132', 'N'), -- Victor
		(59, 'MB21_SF_04', '19', '0.64', '126', 'N'), -- FiNESSE

		-- NV vs GMB 1
		-- ENVY (NV)
		(57, 'MB21_GF_01', '26', '1.11', '225', 'N'), -- Victor
		(56, 'MB21_GF_01', '23', '0.86', '193', 'N'), -- crashies
		(58, 'MB21_GF_01', '22', '0.95', '208', 'N'), -- Marved
		(60, 'MB21_GF_01', '31', '0.95', '175', 'N'), -- yay
		(59, 'MB21_GF_01', '13', '0.52', '114', 'N'), -- FiNESSE
		-- Gambit Esports (GMB)
		(79, 'MB21_GF_01', '25', '1.93', '268', 'Y'), -- Chronicle
		(78, 'MB21_GF_01', '26', '1.50', '247', 'N'), -- nAts
		(80, 'MB21_GF_01', '21', '0.78', '147', 'N'), -- Redgar
		(77, 'MB21_GF_01', '26', '0.90', '186', 'N'), -- d3ffo
		(81, 'MB21_GF_01', '19', '0.84', '170', 'N'), -- sheydos

		-- NV vs GMB 2
		-- ENVY (NV)
		(60, 'MB21_GF_02', '26', '1.59', '324', 'Y'), -- yay
		(58, 'MB21_GF_02', '15', '0.94', '175', 'N'), -- Marved
		(56, 'MB21_GF_02', '31', '0.67', '164', 'N'), -- crashies
		(59, 'MB21_GF_02', '12', '0.45', '133', 'N'), -- FiNESSE
		(57, 'MB21_GF_02', '15', '0.38', '103', 'N'), -- Victor
		-- Gambit Esports (GMB)
		(79, 'MB21_GF_02', '23', '1.50', '236', 'N'), -- Chronicle
		(80, 'MB21_GF_02', '19', '1.38', '254', 'N'), -- Redgar
		(78, 'MB21_GF_02', '36', '1.33', '225', 'N'), -- nAts
		(77, 'MB21_GF_02', '34', '1.43', '202', 'N'), -- d3ffo
		(81, 'MB21_GF_02', '16', '0.94', '176', 'N'), -- sheydos

		-- NV vs GMB 3
		-- ENVY (NV)
		(56, 'MB21_GF_03', '24', '1.15', '293', 'N'), -- crashies
		(57, 'MB21_GF_03', '26', '0.81', '159', 'N'), -- Victor
		(58, 'MB21_GF_03', '24', '0.76', '171', 'N'), -- Marved
		(60, 'MB21_GF_03', '18', '0.61', '151', 'N'), -- yay
		(59, 'MB21_GF_03', '25', '0.61', '141', 'N'), -- FiNESSE
		-- Gambit Esports (GMB)
		(81, 'MB21_GF_03', '23', '1.67', '230', 'N'), -- sheydos
		(79, 'MB21_GF_03', '28', '1.44', '321', 'Y'), -- Chronicle
		(80, 'MB21_GF_03', '38', '1.15', '176', 'N'), -- Redgar
		(77, 'MB21_GF_03', '27', '1.07', '209', 'N'), -- d3ffo
		(78, 'MB21_GF_03', '32', '1.00', '193', 'N'); -- nAts
        
INSERT INTO player_stats (player_id, match_id, headshot_pct, kd_ratio, avg_combat_score, mvps)
VALUES	-- Valorant Champions 2021 added
		-- GROUP STAGE
		-- VS vs FS 1
		-- Vision Strikers (VS)
		(61, 'VC21_OD_01', '53', '2.00', '262', 'Y'), -- stax
		(65, 'VC21_OD_01', '24', '1.63', '209', 'N'), -- MaKo
		(62, 'VC21_OD_01', '33', '1.30', '212', 'N'), -- Rb
		(64, 'VC21_OD_01', '38', '1.17', '206', 'N'), -- BuZz
		(63, 'VC21_OD_01', '24', '1.00', '212', 'N'), -- k1Ng
		-- FULL SENSE (FS)
		(133, 'VC21_OD_01', '17', '0.86', '182', 'N'), -- PTC
		(136, 'VC21_OD_01', '21', '0.72', '227', 'N'), -- JohnOlsen
		(135, 'VC21_OD_01', '31', '0.85', '175', 'N'), -- SantaGolf
		(134, 'VC21_OD_01', '26', '0.71', '153', 'N'), -- SuperBusS
		(137, 'VC21_OD_01', '29', '0.50', '147', 'N'), -- LAMMYSNAX

		-- VS vs FS 2
		-- Vision Strikers (VS)
		(64, 'VC21_OD_02', '20', '2.89', '366', 'Y'), -- BuZz
		(62, 'VC21_OD_02', '37', '2.17', '187', 'N'), -- Rb
		(63, 'VC21_OD_02', '33', '1.64', '293', 'N'), -- k1Ng
		(65, 'VC21_OD_02', '29', '0.90', '147', 'N'), -- MaKo
		(61, 'VC21_OD_02', '29', '0.29', '81', 'N'), -- stax
		-- FULL SENSE (FS)
		(137, 'VC21_OD_02', '28', '1.38', '280', 'N'), -- LAMMYSNAX
		(136, 'VC21_OD_02', '24', '0.73', '192', 'N'), -- JohnOlsen
		(134, 'VC21_OD_02', '37', '0.71', '161', 'N'), -- SuperBusS
		(135, 'VC21_OD_02', '60', '0.36', '80', 'N'), -- SantaGolf
		(133, 'VC21_OD_02', '25', '0.43', '114', 'N'), -- PTC

		-- VKS2 vs CR 1
		-- Keyd Stars (VKS2)
		(92, 'VC21_OC_01', '20', '1.81', '357', 'Y'), -- murizzz
		(95, 'VC21_OC_01', '7', '1.92', '296', 'N'), -- ntk
		(94, 'VC21_OC_01', '21', '1.00', '182', 'N'), -- v1xen
		(93, 'VC21_OC_01', '19', '0.87', '158', 'N'), -- JhoW
		(96, 'VC21_OC_01', '28', '0.76', '173', 'N'), -- heat
		-- Crazy Raccoon (CR)
		(112, 'VC21_OC_01', '29', '0.94', '216', 'N'), -- Bazzi
		(113, 'VC21_OC_01', '30', '1.05', '249', 'N'), -- ade
		(114, 'VC21_OC_01', '28', '0.80', '189', 'N'), -- Fisker
		(115, 'VC21_OC_01', '42', '0.56', '122', 'N'), -- Minty
		(118, 'VC21_OC_01', '29', '0.67', '207', 'N'), -- barce

		-- VKS2 vs CR 2
		-- Keyd Stars (VKS2)
		(94, 'VC21_OC_02', '18', '1.62', '318', 'Y'), -- v1xen
		(92, 'VC21_OC_02', '29', '1.58', '217', 'N'), -- murizzz
		(93, 'VC21_OC_02', '30', '1.50', '206', 'N'), -- JhoW
		(96, 'VC21_OC_02', '48', '1.18', '154', 'N'), -- heat
		(95, 'VC21_OC_02', '30', '1.18', '170', 'N'), -- ntk
		-- Crazy Raccoon (CR)
		(114, 'VC21_OC_02', '29', '1.40', '275', 'N'), -- Fisker
		(118, 'VC21_OC_02', '28', '0.94', '248', 'N'), -- barce
		(113, 'VC21_OC_02', '13', '0.38', '97', 'N'), -- ade
		(112, 'VC21_OC_02', '15', '0.47', '94', 'N'), -- Bazzi
		(115, 'VC21_OC_02', '15', '0.39', '146', 'N'), -- Minty

		-- FNC vs C9 1
		-- FNATIC (FNC)
		(20, 'VC21_OD_03', '22', '2.14', '336', 'Y'), -- Derke
		(16, 'VC21_OD_03', '19', '1.22', '281', 'N'), -- Boaster
		(18, 'VC21_OD_03', '27', '1.00', '148', 'N'), -- Mistic
		(19, 'VC21_OD_03', '12', '1.21', '195', 'N'), -- MAGNUM
		(17, 'VC21_OD_03', '11', '0.86', '150', 'N'), -- doma
		-- Cloud9 (C9)
		(127, 'VC21_OD_03', '25', '1.05', '273', 'N'), -- leaf
		(124, 'VC21_OD_03', '27', '0.89', '196', 'N'), -- xeta
		(126, 'VC21_OD_03', '12', '0.85', '191', 'N'), -- Xeppaa
		(70, 'VC21_OD_03', '10', '0.50', '137', 'N'), -- vanity
		(125, 'VC21_OD_03', '9', '0.56', '112', 'N'), -- mitch

		-- FNC vs C9 2
		-- FNATIC (FNC)
		(19, 'VC21_OD_04', '22', '1.24', '236', 'N'), -- MAGNUM
		(17, 'VC21_OD_04', '29', '1.12', '211', 'N'), -- doma
		(20, 'VC21_OD_04', '13', '0.80', '215', 'N'), -- Derke
		(18, 'VC21_OD_04', '19', '0.59', '113', 'N'), -- Mistic
		(16, 'VC21_OD_04', '9', '0.50', '122', 'N'), -- Boaster
		-- Cloud9 (C9)
		(125, 'VC21_OD_04', '12', '1.40', '261', 'Y'), -- mitch
		(124, 'VC21_OD_04', '25', '1.58', '190', 'N'), -- xeta
		(70, 'VC21_OD_04', '18', '1.19', '225', 'N'), -- vanity
		(127, 'VC21_OD_04', '13', '1.00', '177', 'N'), -- leaf
		(126, 'VC21_OD_04', '24', '0.88', '191', 'N'), -- Xeppaa

		-- FNC vs C9 3
		-- FNATIC (FNC)
		(17, 'VC21_OD_05', '29', '1.38', '231', 'N'), -- doma
		(20, 'VC21_OD_05', '25', '1.40', '323', 'Y'), -- Derke
		(18, 'VC21_OD_05', '35', '1.50', '188', 'N'), -- Mistic
		(19, 'VC21_OD_05', '26', '1.13', '176', 'N'), -- MAGNUM
		(16, 'VC21_OD_05', '16', '0.67', '101', 'N'), -- Boaster
		-- Cloud9 (C9)
		(126, 'VC21_OD_05', '16', '1.39', '292', 'N'), -- Xeppaa
		(124, 'VC21_OD_05', '13', '1.00', '171', 'N'), -- xeta
		(70, 'VC21_OD_05', '17', '0.79', '163', 'N'), -- vanity
		(125, 'VC21_OD_05', '26', '0.63', '144', 'N'), -- mitch
		(127, 'VC21_OD_05', '20', '0.43', '129', 'N'), -- leaf

		-- GMB vs TS 1
		-- Gambit Esports (GMB)
		(77, 'VC21_OC_03', '34', '1.36', '298', 'Y'), -- d3ffo
		(81, 'VC21_OC_03', '26', '0.87', '209', 'N'), -- sheydos
		(78, 'VC21_OC_03', '35', '0.67', '159', 'N'), -- nAts
		(79, 'VC21_OC_03', '40', '0.75', '172', 'N'), -- Chronicle
		(80, 'VC21_OC_03', '27', '0.44', '118', 'N'), -- Redgar
		-- Team Secret (TS)
		(104, 'VC21_OC_03', '24', '2.00', '249', 'N'), -- dispenser
		(105, 'VC21_OC_03', '28', '1.33', '291', 'N'), -- DubsteP
		(106, 'VC21_OC_03', '26', '1.15', '210', 'N'), -- Witz
		(103, 'VC21_OC_03', '31', '1.00', '183', 'N'), -- JessieVash
		(102, 'VC21_OC_03', '20', '0.82', '139', 'N'), -- BORKUM

		-- GMB vs TS 2
		-- Gambit Esports (GMB)
		(78, 'VC21_OC_04', '19', '14.00', '251', 'N'), -- nAts
		(79, 'VC21_OC_04', '36', '4.00', '295', 'N'), -- Chronicle
		(81, 'VC21_OC_04', '26', '1.88', '303', 'Y'), -- sheydos
		(80, 'VC21_OC_04', '11', '1.75', '127', 'N'), -- Redgar
		(77, 'VC21_OC_04', '26', '1.22', '251', 'N'), -- d3ffo
		-- Team Secret (TS)
		(103, 'VC21_OC_04', '21', '0.75', '239', 'N'), -- JessieVash
		(106, 'VC21_OC_04', '33', '0.50', '166', 'N'), -- Witz
		(102, 'VC21_OC_04', '11', '0.23', '89', 'N'), -- BORKUM
		(104, 'VC21_OC_04', '21', '0.31', '88', 'N'), -- dispenser
		(105, 'VC21_OC_04', '20', '0.31', '104', 'N'), -- DubsteP

		-- GMB vs TS 3
		-- Gambit Esports (GMB)
		(78, 'VC21_OC_05', '22', '1.75', '292', 'Y'), -- nAts
		(77, 'VC21_OC_05', '29', '1.45', '226', 'N'), -- d3ffo
		(79, 'VC21_OC_05', '31', '1.29', '273', 'N'), -- Chronicle
		(80, 'VC21_OC_05', '50', '1.08', '164', 'N'), -- Redgar
		(81, 'VC21_OC_05', '23', '0.71', '166', 'N'), -- sheydos
		-- Team Secret (TS)
		(103, 'VC21_OC_05', '28', '0.87', '226', 'N'), -- JessieVash
		(104, 'VC21_OC_05', '20', '0.75', '173', 'N'), -- dispenser
		(105, 'VC21_OC_05', '18', '1.00', '192', 'N'), -- DubsteP
		(102, 'VC21_OC_05', '19', '0.88', '201', 'N'), -- BORKUM
		(106, 'VC21_OC_05', '27', '0.56', '151', 'N'), -- Witz

		-- SEN vs FUR 1
		-- Sentinels (SEN)
		(1, 'VC21_OB_01', '18', '1.43', '291', 'Y'), -- ShahZaM
		(3, 'VC21_OB_01', '18', '1.31', '262', 'N'), -- TenZ
		(4, 'VC21_OB_01', '23', '1.09', '147', 'N'), -- zombs
		(2, 'VC21_OB_01', '22', '0.88', '185', 'N'), -- SicK
		(5, 'VC21_OB_01', '18', '0.86', '163', 'N'), -- dapr
		-- FURIA (FUR)
		(129, 'VC21_OB_01', '24', '1.21', '220', 'N'), -- nzr
		(131, 'VC21_OB_01', '13', '1.00', '225', 'N'), -- Khalil
		(132, 'VC21_OB_01', '27', '1.20', '186', 'N'), -- mazin
		(128, 'VC21_OB_01', '29', '0.65', '175', 'N'), -- xand
		(130, 'VC21_OB_01', '27', '0.50', '116', 'N'), -- Quick

		-- SEN vs FUR 2
		-- Sentinels (SEN)
		(3, 'VC21_OB_02', '30', '1.29', '270', 'Y'), -- TenZ
		(4, 'VC21_OB_02', '22', '1.15', '174', 'N'), -- zombs
		(2, 'VC21_OB_02', '28', '0.71', '152', 'N'), -- SicK
		(1, 'VC21_OB_02', '13', '0.53', '127', 'N'), -- ShahZaM
		(5, 'VC21_OB_02', '25', '0.47', '137', 'N'), -- dapr
		-- FURIA (FUR)
		(129, 'VC21_OB_02', '18', '1.70', '186', 'N'), -- nzr
		(130, 'VC21_OB_02', '46', '1.33', '203', 'N'), -- Quick
		(131, 'VC21_OB_02', '17', '1.50', '220', 'N'), -- Khalil
		(128, 'VC21_OB_02', '29', '1.06', '237', 'N'), -- xand
		(132, 'VC21_OB_02', '44', '0.87', '156', 'N'), -- mazin

		-- SEN vs FUR 3
		-- Sentinels (SEN)
		(3, 'VC21_OB_03', '16', '1.38', '267', 'Y'), -- TenZ
		(4, 'VC21_OB_03', '10', '1.31', '169', 'N'), -- zombs
		(1, 'VC21_OB_03', '26', '0.93', '193', 'N'), -- ShahZaM
		(5, 'VC21_OB_03', '15', '1.13', '231', 'N'), -- dapr
		(2, 'VC21_OB_03', '21', '1.00', '214', 'N'), -- SicK
		-- FURIA (FUR)
		(128, 'VC21_OB_03', '15', '1.19', '239', 'N'), -- xand
		(129, 'VC21_OB_03', '23', '0.94', '225', 'N'), -- nzr
		(131, 'VC21_OB_03', '10', '0.89', '234', 'N'), -- Khalil
		(130, 'VC21_OB_03', '19', '0.65', '159', 'N'), -- Quick
		(132, 'VC21_OB_03', '40', '0.72', '150', 'N'), -- mazin

		-- KRU vs TL 1
		-- KRU Esports (KRU)
		(40, 'VC21_OB_04', '31', '1.00', '258', 'N'), -- Mazino
		(36, 'VC21_OB_04', '27', '0.87', '209', 'N'), -- NagZ
		(39, 'VC21_OB_04', '14', '0.92', '187', 'N'), -- Klaus
		(71, 'VC21_OB_04', '33', '0.50', '154', 'N'), -- keznit
		(38, 'VC21_OB_04', '17', '0.33', '91', 'N'), -- delz1k
		-- Team Liquid (TL)
		(123, 'VC21_OB_04', '43', '2.00', '304', 'Y'), -- Nivera
		(14, 'VC21_OB_04', '31', '1.70', '289', 'N'), -- soulcas
		(13, 'VC21_OB_04', '42', '1.25', '244', 'N'), -- L1NK
		(11, 'VC21_OB_04', '22', '1.00', '194', 'N'), -- ScreaM
		(15, 'VC21_OB_04', '21', '0.91', '148', 'N'), -- Jamppi

		-- KRU vs TL 2
		-- KRU Esports (KRU)
		(40, 'VC21_OB_05', '22', '1.06', '270', 'N'), -- Mazino
		(36, 'VC21_OB_05', '19', '1.08', '172', 'N'), -- NagZ
		(38, 'VC21_OB_05', '19', '0.67', '180', 'N'), -- delz1k
		(71, 'VC21_OB_05', '22', '0.78', '176', 'N'), -- keznit
		(39, 'VC21_OB_05', '38', '0.56', '156', 'N'), -- Klaus
		-- Team Liquid (TL)
		(13, 'VC21_OB_05', '42', '1.46', '242', 'N'), -- L1NK
		(123, 'VC21_OB_05', '28', '1.36', '195', 'N'), -- Nivera
		(11, 'VC21_OB_05', '27', '1.12', '272', 'Y'), -- ScreaM
		(14, 'VC21_OB_05', '35', '0.94', '188', 'N'), -- soulcas
		(15, 'VC21_OB_05', '16', '0.94', '210', 'N'), -- Jamppi

		-- VS vs FNC 1
		-- Vision Strikers (VS)
		(61, 'VC21_WD_01', '34', '1.20', '199', 'N'), -- stax
		(65, 'VC21_WD_01', '32', '0.93', '178', 'N'), -- MaKo
		(62, 'VC21_WD_01', '37', '0.88', '172', 'N'), -- Rb
		(27, 'VC21_WD_01', '17', '0.94', '203', 'N'), -- Lakia
		(64, 'VC21_WD_01', '36', '0.56', '146', 'N'), -- BuZz
		-- FNATIC (FNC)
		(20, 'VC21_WD_01', '39', '2.00', '268', 'Y'), -- Derke
		(17, 'VC21_WD_01', '39', '1.33', '177', 'N'), -- doma
		(16, 'VC21_WD_01', '19', '1.00', '197', 'N'), -- Boaster
		(19, 'VC21_WD_01', '13', '0.87', '166', 'N'), -- MAGNUM
		(18, 'VC21_WD_01', '39', '0.69', '168', 'N'), -- Mistic

		-- VS vs FNC 2
		-- Vision Strikers (VS)
		(64, 'VC21_WD_02', '16', '1.23', '208', 'N'), -- BuZz
		(61, 'VC21_WD_02', '33', '1.19', '225', 'N'), -- stax
		(62, 'VC21_WD_02', '32', '1.06', '203', 'N'), -- Rb
		(65, 'VC21_WD_02', '19', '1.13', '201', 'N'), -- MaKo
		(63, 'VC21_WD_02', '24', '0.93', '174', 'N'), -- k1Ng
		-- FNATIC (FNC)
		(19, 'VC21_WD_02', '26', '1.33', '242', 'Y'), -- MAGNUM
		(16, 'VC21_WD_02', '21', '1.00', '182', 'N'), -- Boaster
		(17, 'VC21_WD_02', '32', '0.88', '172', 'N'), -- doma
		(20, 'VC21_WD_02', '17', '0.67', '180', 'N'), -- Derke
		(18, 'VC21_WD_02', '23', '0.69', '131', 'N'), -- Mistic

		-- VS vs FNC 3
		-- Vision Strikers (VS)
		(65, 'VC21_WD_03', '25', '1.13', '236', 'N'), -- MaKo
		(64, 'VC21_WD_03', '29', '1.07', '250', 'N'), -- BuZz
		(61, 'VC21_WD_03', '27', '0.71', '138', 'N'), -- stax
		(62, 'VC21_WD_03', '27', '0.50', '108', 'N'), -- Rb
		(63, 'VC21_WD_03', '30', '0.21', '81', 'N'), -- k1Ng
		-- FNATIC (FNC)
		(20, 'VC21_WD_03', '26', '2.50', '376', 'Y'), -- Derke
		(17, 'VC21_WD_03', '25', '2.10', '285', 'N'), -- doma
		(19, 'VC21_WD_03', '45', '1.67', '193', 'N'), -- MAGNUM
		(16, 'VC21_WD_03', '3', '0.60', '105', 'N'), -- Boaster
		(18, 'VC21_WD_03', '25', '0.36', '62', 'N'), -- Mistic

		-- NV vs X10 1
		-- Envy (NV)
		(60, 'VC21_OA_01', '14', '1.50', '273', 'Y'), -- yay
		(56, 'VC21_OA_01', '25', '1.31', '217', 'N'), -- crashies
		(58, 'VC21_OA_01', '38', '1.25', '205', 'N'), -- Marved
		(57, 'VC21_OA_01', '20', '1.25', '181', 'N'), -- Victor
		(59, 'VC21_OA_01', '20', '1.00', '242', 'N'), -- FiNESSE
		-- X10 Esports (X10)
		(50, 'VC21_OA_01', '18', '1.13', '220', 'N'), -- sScary
		(47, 'VC21_OA_01', '17', '0.89', '231', 'N'), -- Patiphan
		(46, 'VC21_OA_01', '27', '0.93', '200', 'N'), -- foxz
		(48, 'VC21_OA_01', '19', '0.76', '177', 'N'), -- Sushiboys
		(49, 'VC21_OA_01', '24', '0.40', '139', 'N'), -- Crws

		-- NV vs X10 2
		-- Envy (NV)
		(56, 'VC21_OA_02', '16', '1.56', '192', 'N'), -- crashies
		(60, 'VC21_OA_02', '11', '1.45', '216', 'N'), -- yay
		(58, 'VC21_OA_02', '27', '1.08', '210', 'N'), -- Marved
		(59, 'VC21_OA_02', '22', '1.18', '171', 'N'), -- FiNESSE
		(57, 'VC21_OA_02', '28', '1.07', '189', 'N'), -- Victor
		-- X10 Esports (X10)
		(49, 'VC21_OA_02', '27', '1.58', '252', 'Y'), -- Crws
		(47, 'VC21_OA_02', '21', '0.93', '230', 'N'), -- Patiphan
		(50, 'VC21_OA_02', '39', '0.64', '133', 'N'), -- sScary
		(46, 'VC21_OA_02', '18', '0.64', '146', 'N'), -- foxz
		(48, 'VC21_OA_02', '15', '0.38', '100', 'N'), -- Sushiboys

		-- GMB vs VKS1 1
		-- Gambit Esports (GMB)
		(77, 'VC21_WC_01', '26', '1.83', '347', 'Y'), -- d3ffo
		(79, 'VC21_WC_01', '13', '1.54', '308', 'N'), -- Chronicle
		(81, 'VC21_WC_01', '44', '1.58', '229', 'N'), -- sheydos
		(78, 'VC21_WC_01', '27', '0.85', '185', 'N'), -- nAts
		(80, 'VC21_WC_01', '23', '0.62', '93', 'N'), -- Redgar
		-- Team Vikings (VKS1)
		(25, 'VC21_WC_01', '41', '1.07', '181', 'N'), -- sutecas
		(22, 'VC21_WC_01', '31', '1.00', '233', 'N'), -- Sacy
		(23, 'VC21_WC_01', '13', '0.93', '209', 'N'), -- saadhak
		(24, 'VC21_WC_01', '21', '0.61', '197', 'N'), -- gtn
		(21, 'VC21_WC_01', '28', '0.44', '140', 'N'), -- frz

		-- GMB vs VKS1 2
		-- Gambit Esports (GMB)
		(80, 'VC21_WC_02', '26', '1.50', '334', 'N'), -- Redgar
		(81, 'VC21_WC_02', '24', '0.77', '182', 'N'), -- sheydos
		(77, 'VC21_WC_02', '18', '0.67', '162', 'N'), -- d3ffo
		(78, 'VC21_WC_02', '26', '0.43', '107', 'N'), -- nAts
		(79, 'VC21_WC_02', '25', '0.44', '132', 'N'), -- Chronicle
		-- Team Vikings (VKS1)
		(22, 'VC21_WC_02', '39', '2.57', '285', 'N'), -- Sacy
		(23, 'VC21_WC_02', '14', '1.75', '344', 'Y'), -- saadhak
		(25, 'VC21_WC_02', '22', '1.40', '186', 'N'), -- sutecas
		(24, 'VC21_WC_02', '12', '1.09', '166', 'N'), -- gtn
		(21, 'VC21_WC_02', '20', '0.43', '100', 'N'), -- frz

		-- GMB vs VKS1 3
		-- Gambit Esports (GMB)
		(81, 'VC21_WC_03', '33', '1.56', '270', 'Y'), -- sheydos
		(79, 'VC21_WC_03', '35', '1.19', '226', 'N'), -- Chronicle
		(77, 'VC21_WC_03', '26', '0.82', '213', 'N'), -- d3ffo
		(78, 'VC21_WC_03', '26', '0.90', '210', 'N'), -- nAts
		(80, 'VC21_WC_03', '29', '0.67', '133', 'N'), -- Redgar
		-- Team Vikings (VKS1)
		(22, 'VC21_WC_03', '27', '1.30', '280', 'N'), -- Sacy
		(21, 'VC21_WC_03', '22', '1.00', '209', 'N'), -- frz
		(24, 'VC21_WC_03', '18', '1.11', '193', 'N'), -- gtn
		(25, 'VC21_WC_03', '28', '0.83', '180', 'N'), -- sutecas
		(23, 'VC21_WC_03', '28', '0.88', '174', 'N'), -- saadhak

		-- TL vs SEN 1
		-- Team Liquid (TL)
		(13, 'VC21_WB_01', '41', '1.43', '227', 'N'), -- L1NK
		(123, 'VC21_WB_01', '26', '1.33', '230', 'N'), -- Nivera
		(15, 'VC21_WB_01', '11', '1.18', '221', 'N'), -- Jamppi
		(14, 'VC21_WB_01', '48', '1.05', '227', 'Y'), -- soulcas
		(11, 'VC21_WB_01', '36', '0.58', '115', 'N'), -- ScreaM
		-- Sentinels (SEN)
		(2, 'VC21_WB_01', '23', '1.25', '216', 'N'), -- SicK
		(1, 'VC21_WB_01', '19', '1.16', '233', 'N'), -- ShahZaM
		(5, 'VC21_WB_01', '27', '0.94', '166', 'N'), -- dapr
		(4, 'VC21_WB_01', '13', '0.92', '140', 'N'), -- zombs
		(3, 'VC21_WB_01', '19', '0.67', '163', 'N'), -- TenZ

		-- TL vs SEN 2
		-- Team Liquid (TL)
		(11, 'VC21_WB_02', '25', '0.83', '185', 'N'), -- ScreaM
		(123, 'VC21_WB_02', '47', '0.73', '140', 'N'), -- Nivera
		(15, 'VC21_WB_02', '30', '0.57', '184', 'N'), -- Jamppi
		(13, 'VC21_WB_02', '15', '0.43', '153', 'N'), -- L1NK
		(14, 'VC21_WB_02', '36', '0.36', '101', 'N'), -- soulcas
		-- Sentinels (SEN)
		(3, 'VC21_WB_02', '19', '3.50', '369', 'Y'), -- TenZ
		(1, 'VC21_WB_02', '19', '3.00', '279', 'N'), -- ShahZaM
		(4, 'VC21_WB_02', '11', '1.50', '176', 'N'), -- zombs
		(2, 'VC21_WB_02', '11', '1.13', '148', 'N'), -- SicK
		(5, 'VC21_WB_02', '9', '0.73', '192', 'N'), -- dapr

		-- TL vs SEN 3
		-- Team Liquid (TL)
		(11, 'VC21_WB_03', '26', '1.67', '321', 'Y'), -- ScreaM
		(14, 'VC21_WB_03', '26', '1.60', '257', 'N'), -- soulcas
		(15, 'VC21_WB_03', '19', '1.15', '191', 'N'), -- Jamppi
		(13, 'VC21_WB_03', '38', '1.00', '165', 'N'), -- L1NK
		(123, 'VC21_WB_03', '40', '1.00', '158', 'N'), -- Nivera
		-- Sentinels (SEN)
		(2, 'VC21_WB_03', '18', '1.27', '220', 'N'), -- SicK
		(5, 'VC21_WB_03', '13', '1.00', '247', 'N'), -- dapr
		(1, 'VC21_WB_03', '24', '0.68', '159', 'N'), -- ShahZaM
		(4, 'VC21_WB_03', '12', '0.41', '127', 'N'), -- zombs
		(3, 'VC21_WB_03', '18', '0.60', '141', 'N'), -- TenZ

		-- ACE vs VKS2 1
		-- Acend (ACE)
		(74, 'VC21_OA_03', '30', '1.06', '246', 'N'), -- cNed
		(75, 'VC21_OA_03', '27', '1.00', '195', 'N'), -- Kiles
		(73, 'VC21_OA_03', '26', '0.93', '188', 'N'), -- starxo
		(76, 'VC21_OA_03', '30', '0.88', '163', 'N'), -- BONECOLD
		(72, 'VC21_OA_03', '15', '1.00', '195', 'Y'), -- zeek
		-- Keyd Stars (VKS2)
		(122, 'VC21_OA_03', '12', '1.62', '265', 'N'), -- mwzera
		(96, 'VC21_OA_03', '50', '1.44', '269', 'Y'), -- heat
		(92, 'VC21_OA_03', '24', '1.33', '229', 'N'), -- murizzz
		(94, 'VC21_OA_03', '21', '0.57', '121', 'N'), -- v1xen
		(93, 'VC21_OA_03', '14', '0.33', '105', 'N'), -- JhoW

		-- ACE vs VKS2 2
		-- Acend (ACE)
		(72, 'VC21_OA_04', '22', '2.38', '332', 'Y'), -- zeek
		(74, 'VC21_OA_04', '24', '1.50', '291', 'N'), -- cNed
		(75, 'VC21_OA_04', '42', '1.38', '193', 'N'), -- Kiles
		(76, 'VC21_OA_04', '21', '0.89', '138', 'N'), -- BONECOLD
		(73, 'VC21_OA_04', '7', '0.83', '160', 'N'), -- starxo
		-- Keyd Stars (VKS2)
		(122, 'VC21_OA_04', '11', '0.93', '253', 'N'), -- mwzera
		(96, 'VC21_OA_04', '30', '1.00', '224', 'N'), -- heat
		(94, 'VC21_OA_04', '11', '0.75', '154', 'N'), -- v1xen
		(92, 'VC21_OA_04', '28', '0.42', '111', 'N'), -- murizzz
		(93, 'VC21_OA_04', '21', '0.54', '168', 'N'), -- JhoW

		-- ACE vs VKS2 3
		-- Acend (ACE)
		(72, 'VC21_OA_05', '21', '1.08', '163', 'N'), -- zeek
		(76, 'VC21_OA_05', '34', '1.30', '158', 'N'), -- BONECOLD
		(73, 'VC21_OA_05', '24', '0.69', '151', 'N'), -- starxo
		(74, 'VC21_OA_05', '35', '0.71', '127', 'N'), -- cNed
		(75, 'VC21_OA_05', '24', '0.62', '99', 'N'), -- Kiles
		-- Keyd Stars (VKS2)
		(96, 'VC21_OA_05', '35', '1.64', '201', 'Y'), -- heat
		(93, 'VC21_OA_05', '17', '1.27', '166', 'N'), -- JhoW
		(94, 'VC21_OA_05', '29', '1.30', '143', 'N'), -- v1xen
		(122, 'VC21_OA_05', '24', '0.92', '133', 'N'), -- mwzera
		(92, 'VC21_OA_05', '21', '0.82', '106', 'N'), -- murizzz

		-- TS vs CR 1
		-- Team Secret (TS)
		(106, 'VC21_EC_01', '22', '2.00', '281', 'Y'), -- Witz
		(102, 'VC21_EC_01', '18', '2.57', '233', 'N'), -- BORKUM
		(104, 'VC21_EC_01', '35', '1.50', '217', 'N'), -- dispenser
		(105, 'VC21_EC_01', '17', '1.00', '237', 'N'), -- DubsteP
		(103, 'VC21_EC_01', '18', '0.58', '126', 'N'), -- JessieVash
		-- Crazy Raccoon (CR)
		(45, 'VC21_EC_01', '27', '0.85', '204', 'N'), -- neth
		(112, 'VC21_EC_01', '22', '0.86', '194', 'N'), -- Bazzi
		(41, 'VC21_EC_01', '40', '0.92', '178', 'N'), -- Munchkin
		(113, 'VC21_EC_01', '35', '0.50', '107', 'N'), -- ade
		(114, 'VC21_EC_01', '33', '0.59', '168', 'N'), -- Fisker

		-- TS vs CR 2
		-- Team Secret (TS)
		(104, 'VC21_EC_02', '21', '2.57', '308', 'N'), -- dispenser
		(103, 'VC21_EC_02', '34', '1.67', '313', 'Y'), -- JessieVash
		(102, 'VC21_EC_02', '29', '1.83', '145', 'N'), -- BORKUM
		(106, 'VC21_EC_02', '26', '1.43', '171', 'N'), -- Witz
		(105, 'VC21_EC_02', '23', '1.75', '244', 'N'), -- DubsteP
		-- Crazy Raccoon (CR)
		(41, 'VC21_EC_02', '31', '0.62', '160', 'N'), -- Munchkin
		(45, 'VC21_EC_02', '29', '0.62', '167', 'N'), -- neth
		(114, 'VC21_EC_02', '35', '0.71', '176', 'N'), -- Fisker
		(44, 'VC21_EC_02', '30', '0.50', '139', 'N'), -- Medusa
		(113, 'VC21_EC_02', '18', '0.29', '84', 'N'), -- ade,

		-- KRU vs FUR 1
		-- KRU Esports (KRU)
		(71, 'VC21_EB_01', '33', '1.59', '312', 'Y'), -- keznit
		(40, 'VC21_EB_01', '25', '1.06', '230', 'N'), -- Mazino
		(36, 'VC21_EB_01', '17', '0.89', '195', 'N'), -- NagZ
		(38, 'VC21_EB_01', '32', '0.78', '148', 'N'), -- delz1k
		(39, 'VC21_EB_01', '21', '0.58', '155', 'N'), -- Klaus
		-- FURIA (FUR)
		(130, 'VC21_EB_01', '20', '1.53', '295', 'Y'), -- Quick
		(129, 'VC21_EB_01', '23', '1.29', '207', 'N'), -- nzr
		(128, 'VC21_EB_01', '37', '1.00', '213', 'N'), -- xand
		(131, 'VC21_EB_01', '27', '0.71', '193', 'N'), -- Khalil
		(132, 'VC21_EB_01', '39', '0.75', '131', 'N'), -- mazin

		-- KRU vs FUR 2
		-- KRU Esports (KRU)
		(38, 'VC21_EB_02', '36', '1.58', '258', 'N'), -- delz1k
		(71, 'VC21_EB_02', '13', '1.75', '261', 'Y'), -- keznit
		(40, 'VC21_EB_02', '19', '1.25', '204', 'N'), -- Mazino
		(36, 'VC21_EB_02', '18', '1.38', '248', 'N'), -- NagZ
		(39, 'VC21_EB_02', '13', '0.50', '108', 'N'), -- Klaus
		-- FURIA (FUR)
		(128, 'VC21_EB_02', '25', '1.13', '246', 'Y'), -- xand
		(129, 'VC21_EB_02', '14', '0.87', '205', 'N'), -- nzr
		(130, 'VC21_EB_02', '21', '1.00', '208', 'N'), -- Quick
		(131, 'VC21_EB_02', '13', '0.69', '148', 'N'), -- Khalil
		(132, 'VC21_EB_02', '26', '0.33', '99', 'N'), -- mazin

		-- KRU vs FUR 3
		-- KRU Esports (KRU)
		(36, 'VC21_EB_03', '16', '1.36', '235', 'N'), -- NagZ
		(39, 'VC21_EB_03', '20', '1.31', '254', 'Y'), -- Klaus
		(71, 'VC21_EB_03', '25', '1.19', '223', 'N'), -- keznit
		(40, 'VC21_EB_03', '26', '0.73', '176', 'N'), -- Mazino
		(38, 'VC21_EB_03', '27', '0.69', '150', 'N'), -- delz1k
		-- FURIA (FUR)
		(128, 'VC21_EB_03', '19', '1.18', '277', 'Y'), -- xand
		(129, 'VC21_EB_03', '19', '1.07', '192', 'N'), -- nzr
		(132, 'VC21_EB_03', '25', '1.12', '244', 'N'), -- mazin
		(130, 'VC21_EB_03', '23', '0.87', '151', 'N'), -- Quick
		(131, 'VC21_EB_03', '16', '0.56', '159', 'N'), -- Khalil

        -- FS vs C9 1
        -- FULL SENSE (FS)
        (134, 'VC21_ED_01', '16', '0.87', '191', 'N'), -- SuperBusS
        (135, 'VC21_ED_01', '21', '0.87', '181', 'N'), -- SantaGolf
        (137, 'VC21_ED_01', '29', '0.69', '158', 'N'), -- LAMMYSNAX
        (133, 'VC21_ED_01', '41', '0.65', '152', 'N'), -- PTC
        (136, 'VC21_ED_01', '26', '0.76', '190', 'N'), -- JohnOlsen
        -- Cloud9 (C9)
        (125, 'VC21_ED_01', '18', '1.89', '238', 'N'), -- mitch
        (127, 'VC21_ED_01', '27', '1.54', '284', 'Y'), -- leaf
        (124, 'VC21_ED_01', '46', '1.64', '215', 'N'), -- xeta
        (126, 'VC21_ED_01', '16', '0.93', '220', 'N'), -- Xeppaa
        (10,  'VC21_ED_01', '13', '0.85', '150', 'N'), -- vanity

        -- FS vs C9 2
        -- FULL SENSE (FS)
        (137, 'VC21_ED_02', '23', '1.20', '267', 'N'), -- LAMMYSNAX
        (133, 'VC21_ED_02', '21', '1.12', '227', 'N'), -- PTC
        (134, 'VC21_ED_02', '23', '1.06', '212', 'N'), -- SuperBusS
        (135, 'VC21_ED_02', '35', '0.75', '122', 'N'), -- SantaGolf
        (136, 'VC21_ED_02', '28', '0.89', '159', 'N'), -- JohnOlsen
        -- Cloud9 (C9)
        (127, 'VC21_ED_02', '22', '1.42', '308', 'Y'), -- leaf
        (124, 'VC21_ED_02', '30', '1.28', '255', 'N'), -- xeta
        (10,  'VC21_ED_02', '20', '0.83', '184', 'N'), -- vanity
        (126, 'VC21_ED_02', '19', '0.65', '127', 'N'), -- Xeppaa
        (125, 'VC21_ED_02', '22', '0.76', '125', 'N'), -- mitch

        -- ACE vs NV 1
        -- Acend (ACE)
        (75, 'VC21_WA_01', '24', '1.64', '213', 'N'), -- Kiles
        (72, 'VC21_WA_01', '24', '1.40', '206', 'N'), -- zeek
        (73, 'VC21_WA_01', '26', '1.31', '218', 'N'), -- starxo
        (74, 'VC21_WA_01', '29', '1.21', '235', 'Y'), -- cNed
        (76, 'VC21_WA_01', '7',  '1.00', '169', 'N'), -- BONECOLD
        -- ENVY (NV)
        (60, 'VC21_WA_01', '22', '1.13', '222', 'N'), -- yay
        (58, 'VC21_WA_01', '25', '0.81', '184', 'N'), -- Marved
        (56, 'VC21_WA_01', '33', '0.93', '184', 'N'), -- crashies
        (59, 'VC21_WA_01', '15', '0.67', '153', 'N'), -- FiNESSE
        (57, 'VC21_WA_01', '17', '0.35', '101', 'N'), -- Victor

        -- ACE vs NV 2
        -- Acend (ACE)
        (74, 'VC21_WA_02', '24', '1.58', '207', 'N'), -- cNed
        (72, 'VC21_WA_02', '23', '1.18', '244', 'N'), -- zeek
        (75, 'VC21_WA_02', '32', '0.84', '195', 'N'), -- Kiles
        (73, 'VC21_WA_02', '22', '0.88', '176', 'N'), -- starxo
        (76, 'VC21_WA_02', '45', '0.81', '191', 'N'), -- BONECOLD
        -- ENVY (NV)
        (56, 'VC21_WA_02', '22', '1.75', '240', 'N'), -- crashies
        (60, 'VC21_WA_02', '25', '1.26', '304', 'Y'), -- yay
        (58, 'VC21_WA_02', '35', '0.84', '177', 'N'), -- Marved
        (59, 'VC21_WA_02', '21', '0.78', '169', 'N'), -- FiNESSE
        (57, 'VC21_WA_02', '21', '0.56', '122', 'N'), -- Victor

        -- VKS2 vs X10 1
        -- Keyd Stars (VKS2)
        (96, 'VC21_EA_01', '41', '1.60', '379', 'Y'), -- heat
        (122, 'VC21_EA_01', '19', '0.69', '175', 'N'), -- mwzera
        (93, 'VC21_EA_01', '26', '0.53', '128', 'N'), -- JhoW
        (92, 'VC21_EA_01', '17', '0.56', '181', 'N'), -- murizzz
        (94, 'VC21_EA_01', '40', '0.35', '70', 'N'), -- v1xen
        -- X10 Esports (X10)
        (47, 'VC21_EA_01', '24', '1.92', '336', 'N'), -- Patiphan
        (48, 'VC21_EA_01', '21', '2.00', '300', 'N'), -- Sushiboys
        (46, 'VC21_EA_01', '38', '1.09', '196', 'N'), -- foxz
        (49, 'VC21_EA_01', '25', '1.00', '181', 'N'), -- Crws
        (50, 'VC21_EA_01', '20', '0.92', '163', 'N'), -- sScary

        -- VKS2 vs X10 2
        -- Keyd Stars (VKS2)
        (92, 'VC21_EA_02', '26', '0.93', '195', 'N'), -- murizzz
        (93, 'VC21_EA_02', '28', '0.71', '201', 'N'), -- JhoW
        (94, 'VC21_EA_02', '40', '0.69', '195', 'N'), -- v1xen
        (122, 'VC21_EA_02', '25', '0.47', '118', 'N'), -- mwzera
        (96, 'VC21_EA_02', '32', '0.59', '163', 'N'), -- heat
        -- X10 Esports (X10)
        (48, 'VC21_EA_02', '18', '3.67', '300', 'N'), -- Sushiboys
        (46, 'VC21_EA_02', '30', '2.00', '327', 'Y'), -- foxz
        (47, 'VC21_EA_02', '22', '0.86', '194', 'N'), -- Patiphan
        (50, 'VC21_EA_02', '20', '1.10', '201', 'N'), -- sScary
        (49, 'VC21_EA_02', '25', '0.62', '109', 'N'), -- Crws

        -- SEN vs KRU 1
        -- Sentinels (SEN)
        (1, 'VC21_DB_01', '14', '2.09', '279', 'Y'), -- ShahZaM
        (2, 'VC21_DB_01', '28', '1.73', '262', 'N'), -- SicK
        (3, 'VC21_DB_01', '18', '1.08', '202', 'N'), -- TenZ
        (5, 'VC21_DB_01', '9',  '1.18', '172', 'N'), -- dapr
        (4, 'VC21_DB_01', '19', '0.93', '202', 'N'), -- zombs
        -- KRU Esports (KRU)
        (40, 'VC21_DB_01', '22', '1.00', '261', 'N'), -- Mazino
        (71, 'VC21_DB_01', '26', '1.14', '229', 'N'), -- keznit
        (38, 'VC21_DB_01', '34', '0.76', '178', 'N'), -- delz1k
        (39, 'VC21_DB_01', '26', '0.61', '183', 'N'), -- Klaus
        (36, 'VC21_DB_01', '30', '0.24', '69', 'N'), -- NagZ

        -- SEN vs KRU 2
        -- Sentinels (SEN)
        (1, 'VC21_DB_02', '27', '1.93', '296', 'Y'), -- ShahZaM
        (3, 'VC21_DB_02', '17', '1.20', '234', 'N'), -- TenZ
        (2, 'VC21_DB_02', '25', '0.95', '218', 'N'), -- SicK
        (5, 'VC21_DB_02', '21', '0.82', '173', 'N'), -- dapr
        (4, 'VC21_DB_02', '5',  '0.33', '82', 'N'), -- zombs
        -- KRU Esports (KRU)
        (40, 'VC21_DB_02', '30', '1.24', '252', 'N'), -- Mazino
        (36, 'VC21_DB_02', '17', '1.29', '270', 'N'), -- NagZ
        (39, 'VC21_DB_02', '28', '1.21', '204', 'N'), -- Klaus
        (71, 'VC21_DB_02', '23', '0.75', '186', 'N'), -- keznit
        (38, 'VC21_DB_02', '30', '0.69', '115', 'N'), -- delz1k

        -- SEN vs KRU 3
        -- Sentinels (SEN)
        (5, 'VC21_DB_03', '18', '1.22', '282', 'Y'), -- dapr
        (2, 'VC21_DB_03', '25', '0.88', '215', 'N'), -- SicK
        (4, 'VC21_DB_03', '22', '0.94', '175', 'N'), -- zombs
        (1, 'VC21_DB_03', '16', '0.74', '177', 'N'), -- ShahZaM
        (3, 'VC21_DB_03', '24', '0.45', '119', 'N'), -- TenZ
        -- KRU Esports (KRU)
        (71, 'VC21_DB_03', '13', '1.50', '250', 'N'), -- keznit
        (36, 'VC21_DB_03', '13', '1.64', '215', 'N'), -- NagZ
        (39, 'VC21_DB_03', '23', '1.20', '199', 'N'), -- Klaus
        (40, 'VC21_DB_03', '30', '0.94', '202', 'N'), -- Mazino
        (38, 'VC21_DB_03', '22', '0.94', '216', 'N'), -- delz1k

        -- VS vs C9 1
        -- Vision Strikers (VS)
        (61, 'VC21_DD_01', '33', '1.26', '278', 'N'), -- stax
        (63, 'VC21_DD_01', '24', '0.87', '167', 'N'), -- k1Ng
        (64, 'VC21_DD_01', '21', '0.85', '231', 'N'), -- BuZz
        (62, 'VC21_DD_01', '23', '0.56', '112', 'N'), -- Rb
        (65, 'VC21_DD_01', '30', '0.56', '106', 'N'), -- MaKo
        -- Cloud9 (C9)
        (127, 'VC21_DD_01', '20', '1.63', '355', 'Y'), -- leaf
        (126, 'VC21_DD_01', '25', '1.40', '237', 'N'), -- Xeppaa
        (125, 'VC21_DD_01', '10', '1.07', '184', 'N'), -- mitch
        (10,  'VC21_DD_01', '16', '0.75', '135', 'N'), -- vanity
        (124, 'VC21_DD_01', '18', '1.00', '139', 'N'), -- xeta

        -- VS vs C9 2
        -- Vision Strikers (VS)
        (65, 'VC21_DD_02', '16', '1.70', '221', 'N'), -- MaKo
        (64, 'VC21_DD_02', '27', '1.57', '313', 'Y'), -- BuZz
        (61, 'VC21_DD_02', '23', '1.27', '175', 'N'), -- stax
        (62, 'VC21_DD_02', '27', '1.29', '217', 'N'), -- Rb
        (63, 'VC21_DD_02', '33', '0.92', '124', 'N'), -- k1Ng
        -- Cloud9 (C9)
        (127, 'VC21_DD_02', '13', '1.00', '218', 'N'), -- leaf
        (125, 'VC21_DD_02', '14', '0.75', '186', 'N'), -- mitch
        (124, 'VC21_DD_02', '10', '0.57', '113', 'N'), -- xeta
        (10,  'VC21_DD_02', '17', '0.63', '136', 'N'), -- vanity
        (126, 'VC21_DD_02', '10', '0.74', '213', 'N'), -- Xeppaa

        -- VS vs C9 3
        -- Vision Strikers (VS)
        (63, 'VC21_DD_03', '33', '1.27', '190', 'N'), -- k1Ng
        (62, 'VC21_DD_03', '31', '0.94', '185', 'N'), -- Rb
        (65, 'VC21_DD_03', '29', '0.88', '190', 'N'), -- MaKo
        (61, 'VC21_DD_03', '35', '0.79', '183', 'N'), -- stax
        (64, 'VC21_DD_03', '17', '0.71', '179', 'N'), -- BuZz
        -- Cloud9 (C9)
        (125, 'VC21_DD_03', '28', '1.86', '263', 'Y'), -- mitch
        (126, 'VC21_DD_03', '23', '1.33', '238', 'N'), -- Xeppaa
        (127, 'VC21_DD_03', '29', '1.24', '256', 'N'), -- leaf
        (124, 'VC21_DD_03', '18', '0.73', '135', 'N'), -- xeta
        (10,  'VC21_DD_03', '32', '0.56', '149', 'N'), -- vanity

        -- VKS1 vs TS 1
        -- Team Vikings (VKS1)
        (23, 'VC21_DC_01', '22', '1.07', '245', 'N'), -- saadhak
        (25, 'VC21_DC_01', '39', '1.00', '192', 'N'), -- sutecas
        (22, 'VC21_DC_01', '20', '0.59', '170', 'N'), -- Sacy
        (24, 'VC21_DC_01', '28', '0.60', '135', 'N'), -- gtn
        (21, 'VC21_DC_01', '24', '0.44', '137', 'N'), -- frz
        -- Team Secret (TS)
        (105, 'VC21_DC_01', '40', '2.15', '432', 'Y'), -- DubsteP
        (104, 'VC21_DC_01', '19', '2.22', '254', 'N'), -- dispenser
        (103, 'VC21_DC_01', '21', '0.91', '173', 'N'), -- JessieVash
        (106, 'VC21_DC_01', '18', '1.08', '158', 'N'), -- Witz
        (102, 'VC21_DC_01', '24', '0.55', '94', 'N'), -- BORKUM

        -- VKS1 vs TS 2
        -- Team Vikings (VKS1)
        (21, 'VC21_DC_02', '22', '1.19', '272', 'Y'), -- frz
        (22, 'VC21_DC_02', '30', '0.88', '234', 'N'), -- Sacy
        (25, 'VC21_DC_02', '29', '0.80', '177', 'N'), -- sutecas
        (23, 'VC21_DC_02', '9',  '0.50', '131', 'N'), -- saadhak
        (24, 'VC21_DC_02', '19', '0.67', '179', 'N'), -- gtn
        -- Team Secret (TS)
        (102, 'VC21_DC_02', '12', '1.73', '269', 'N'), -- BORKUM
        (104, 'VC21_DC_02', '34', '1.36', '267', 'N'), -- dispenser
        (105, 'VC21_DC_02', '36', '1.31', '225', 'N'), -- DubsteP
        (106, 'VC21_DC_02', '28', '1.14', '215', 'N'), -- Witz
        (103, 'VC21_DC_02', '20', '0.92', '163', 'N'), -- JessieVash

        -- NV vs X10 1
        -- ENVY (NV)
        (58, 'VC21_DA_01', '31', '1.38', '277', 'Y'), -- Marved
        (56, 'VC21_DA_01', '33', '1.46', '239', 'N'), -- crashies
        (59, 'VC21_DA_01', '17', '1.23', '204', 'N'), -- FiNESSE
        (57, 'VC21_DA_01', '24', '1.00', '204', 'N'), -- Victor
        (60, 'VC21_DA_01', '24', '0.73', '139', 'N'), -- yay
        -- X10 Esports (X10)
        (48, 'VC21_DA_01', '27', '1.29', '201', 'N'), -- Sushiboys
        (47, 'VC21_DA_01', '24', '0.89', '235', 'N'), -- Patiphan
        (50, 'VC21_DA_01', '25', '0.71', '182', 'N'), -- sScary
        (49, 'VC21_DA_01', '43', '0.83', '191', 'N'), -- Crws
        (46, 'VC21_DA_01', '37', '0.71', '114', 'N'), -- foxz

        -- NV vs X10 2
        -- ENVY (NV)
        (60, 'VC21_DA_02', '31', '1.19', '263', 'N'), -- yay
        (59, 'VC21_DA_02', '17', '1.00', '191', 'N'), -- FiNESSE
        (58, 'VC21_DA_02', '30', '0.88', '217', 'N'), -- Marved
        (57, 'VC21_DA_02', '27', '0.81', '182', 'N'), -- Victor
        (56, 'VC21_DA_02', '27', '0.39', '98', 'N'), -- crashies
        -- X10 Esports (X10)
        (48, 'VC21_DA_02', '18', '1.60', '294', 'Y'), -- Sushiboys
        (46, 'VC21_DA_02', '30', '1.19', '270', 'N'), -- foxz
        (47, 'VC21_DA_02', '13', '1.00', '189', 'N'), -- Patiphan
        (49, 'VC21_DA_02', '18', '1.17', '166', 'N'), -- Crws
        (50, 'VC21_DA_02', '10', '0.92', '161', 'N'), -- sScary

        -- NV vs X10 3
        -- ENVY (NV)
        (56, 'VC21_DA_03', '33', '1.56', '267', 'N'), -- crashies
        (60, 'VC21_DA_03', '25', '1.41', '282', 'N'), -- yay
        (59, 'VC21_DA_03', '24', '0.75', '192', 'N'), -- FiNESSE
        (57, 'VC21_DA_03', '32', '0.83', '157', 'N'), -- Victor
        (58, 'VC21_DA_03', '38', '0.63', '136', 'N'), -- Marved
        -- X10 Esports (X10)
        (47, 'VC21_DA_03', '25', '1.69', '285', 'Y'), -- Patiphan
        (48, 'VC21_DA_03', '14', '0.95', '232', 'N'), -- Sushiboys
        (50, 'VC21_DA_03', '24', '1.00', '160', 'N'), -- sScary
        (46, 'VC21_DA_03', '16', '0.85', '182', 'N'), -- foxz
        (49, 'VC21_DA_03', '29', '0.60', '114', 'N'), -- Crws
        
        -- PLAYOFFS
        -- ACE vs TS 1
        -- Acend (ACE)
        (74, 'VC21_QF_01', '34', '1.56', '345', 'Y'), -- cNed
        (76, 'VC21_QF_01', '34', '1.46', '234', 'N'), -- BONECOLD
        (72, 'VC21_QF_01', '23', '1.24', '283', 'N'), -- zeek
        (75, 'VC21_QF_01', '19', '0.69', '164', 'N'), -- Kiles
        (73, 'VC21_QF_01', '11', '0.60', '106', 'N'), -- starxo
        -- Team Secret (TS)
        (106, 'VC21_QF_01', '18', '0.94', '282', 'Y'), -- Witz
        (102, 'VC21_QF_01', '25', '1.19', '247', 'N'), -- BORKUM
        (105, 'VC21_QF_01', '28', '1.00', '198', 'N'), -- DubsteP
        (104, 'VC21_QF_01', '32', '0.67', '166', 'N'), -- dispenser
        (103, 'VC21_QF_01', '32', '0.76', '191', 'N'), -- JessieVash

        -- ACE vs TS 2
        -- Acend (ACE)
        (72, 'VC21_QF_02', '16', '1.89', '238', 'N'), -- zeek
        (76, 'VC21_QF_02', '25', '1.70', '246', 'N'), -- BONECOLD
        (74, 'VC21_QF_02', '32', '1.64', '264', 'Y'), -- cNed
        (73, 'VC21_QF_02', '17', '1.00', '136', 'N'), -- starxo
        (75, 'VC21_QF_02', '23', '1.15', '186', 'N'), -- Kiles
        -- Team Secret (TS)
        (106, 'VC21_QF_02', '24', '0.93', '207', 'N'), -- Witz
        (105, 'VC21_QF_02', '26', '0.81', '216', 'Y'), -- DubsteP
        (104, 'VC21_QF_02', '29', '0.80', '186', 'N'), -- dispenser
        (103, 'VC21_QF_02', '23', '0.61', '201', 'N'), -- JessieVash
        (102, 'VC21_QF_02', '25', '0.36', '75', 'N'), -- BORKUM

		-- TL vs C9 1
		-- Team Liquid (TL)
		(11, 'VC21_QF_03', '37', '1.44', '334', 'Y'), -- ScreaM
		(15, 'VC21_QF_03', '20', '1.31', '199', 'N'), -- Jamppi
		(13, 'VC21_QF_03', '27', '1.31', '177', 'N'), -- L1NK
		(123, 'VC21_QF_03', '48', '1.00', '155', 'N'), -- Nivera
		(14, 'VC21_QF_03', '32', '0.83', '205', 'N'), -- soulcas
		-- Cloud9 (C9)
		(127, 'VC21_QF_03', '26', '1.56', '327', 'Y'), -- leaf
		(71, 'VC21_QF_03', '26', '0.71', '148', 'N'), -- vanity
		(125, 'VC21_QF_03', '28', '0.78', '184', 'N'), -- mitch
		(124, 'VC21_QF_03', '24', '0.71', '169', 'N'), -- xeta
		(126, 'VC21_QF_03', '8', '0.58', '158', 'N'), -- Xeppaa

		-- TL vs C9 2
		-- Team Liquid (TL)
		(11, 'VC21_QF_04', '35', '1.60', '275', 'Y'), -- ScreaM
		(123, 'VC21_QF_04', '25', '1.54', '244', 'N'), -- Nivera
		(14, 'VC21_QF_04', '37', '0.86', '149', 'N'), -- soulcas
		(15, 'VC21_QF_04', '13', '0.95', '214', 'N'), -- Jamppi
		(13, 'VC21_QF_04', '23', '0.64', '112', 'N'), -- L1NK
		-- Cloud9 (C9)
		(127, 'VC21_QF_04', '26', '1.39', '307', 'Y'), -- leaf
		(124, 'VC21_QF_04', '25', '1.14', '216', 'N'), -- xeta
		(71, 'VC21_QF_04', '30', '1.00', '174', 'N'), -- vanity
		(125, 'VC21_QF_04', '13', '0.75', '149', 'N'), -- mitch
		(126, 'VC21_QF_04', '17', '0.32', '84', 'N'), -- Xeppaa

		-- GMB vs X10 1
		-- Gambit Esports (GMB)
		(81, 'VC21_QF_05', '27', '1.50', '244', 'N'), -- sheydos
		(79, 'VC21_QF_05', '25', '1.31', '230', 'N'), -- Chronicle
		(77, 'VC21_QF_05', '15', '1.24', '330', 'Y'), -- d3ffo
		(78, 'VC21_QF_05', '34', '1.17', '211', 'N'), -- nAts
		(80, 'VC21_QF_05', '19', '0.79', '113', 'N'), -- Redgar
		-- X10 Esports (X10)
		(47, 'VC21_QF_05', '17', '1.27', '265', 'N'), -- Patiphan
		(48, 'VC21_QF_05', '24', '1.00', '226', 'N'), -- Sushiboys
		(49, 'VC21_QF_05', '16', '0.76', '198', 'N'), -- Crws
		(50, 'VC21_QF_05', '36', '0.65', '132', 'N'), -- sScary
		(46, 'VC21_QF_05', '28', '0.59', '171', 'N'), -- foxz

		-- GMB vs X10 2
		-- Gambit Esports (GMB)
		(78, 'VC21_QF_06', '31', '1.07', '220', 'N'), -- nAts
		(77, 'VC21_QF_06', '26', '0.87', '198', 'N'), -- d3ffo
		(79, 'VC21_QF_06', '32', '1.13', '243', 'N'), -- Chronicle
		(80, 'VC21_QF_06', '41', '0.54', '107', 'N'), -- Redgar
		(81, 'VC21_QF_06', '19', '0.47', '109', 'N'), -- sheydos
		-- X10 Esports (X10)
		(46, 'VC21_QF_06', '18', '2.00', '239', 'Y'), -- foxz
		(49, 'VC21_QF_06', '25', '1.18', '198', 'N'), -- Crws
		(47, 'VC21_QF_06', '19', '1.07', '238', 'N'), -- Patiphan
		(48, 'VC21_QF_06', '27', '1.23', '201', 'N'), -- Sushiboys
		(50, 'VC21_QF_06', '45', '0.92', '131', 'N'), -- sScary

		-- GMB vs X10 3
		-- Gambit Esports (GMB)
		(79, 'VC21_QF_07', '29', '2.00', '264', 'Y'), -- Chronicle
		(80, 'VC21_QF_07', '39', '1.56', '194', 'N'), -- Redgar
		(77, 'VC21_QF_07', '23', '1.36', '195', 'N'), -- d3ffo
		(78, 'VC21_QF_07', '20', '1.27', '186', 'N'), -- nAts
		(81, 'VC21_QF_07', '22', '0.81', '215', 'N'), -- sheydos
		-- X10 Esports (X10)
		(50, 'VC21_QF_07', '20', '0.92', '168', 'N'), -- sScary
		(48, 'VC21_QF_07', '32', '0.81', '197', 'N'), -- Sushiboys
		(46, 'VC21_QF_07', '31', '0.73', '154', 'N'), -- foxz
		(49, 'VC21_QF_07', '10', '0.63', '157', 'N'), -- Crws
		(47, 'VC21_QF_07', '20', '0.69', '169', 'N'), -- Patiphan

		-- FNC vs KRU 1
		-- FNATIC (FNC)
		(20, 'VC21_QF_08', '32', '1.61', '285', 'Y'), -- Derke
		(16, 'VC21_QF_08', '27', '1.11', '218', 'N'), -- Boaster
		(18, 'VC21_QF_08', '41', '1.06', '186', 'N'), -- Mistic
		(17, 'VC21_QF_08', '40', '0.89', '164', 'N'), -- doma
		(19, 'VC21_QF_08', '23', '0.88', '156', 'N'), -- MAGNUM
		-- KRU Esports (KRU)
		(38, 'VC21_QF_08', '30', '1.37', '278', 'N'), -- delz1k
		(71, 'VC21_QF_08', '44', '0.91', '225', 'N'), -- keznit
		(36, 'VC21_QF_08', '28', '0.83', '146', 'N'), -- NagZ
		(39, 'VC21_QF_08', '35', '0.89', '159', 'N'), -- Klaus
		(40, 'VC21_QF_08', '35', '0.67', '125', 'N'), -- Mazino

		-- FNC vs KRU 2
		-- FNATIC (FNC)
		(20, 'VC21_QF_09', '37', '1.53', '333', 'N'), -- Derke
		(16, 'VC21_QF_09', '29', '1.38', '171', 'N'), -- Boaster
		(19, 'VC21_QF_09', '44', '1.00', '179', 'N'), -- MAGNUM
		(17, 'VC21_QF_09', '38', '1.17', '211', 'N'), -- doma
		(18, 'VC21_QF_09', '44', '0.83', '145', 'N'), -- Mistic
		-- KRU Esports (KRU)
		(71, 'VC21_QF_09', '32', '2.15', '382', 'Y'), -- keznit
		(40, 'VC21_QF_09', '26', '0.53', '146', 'N'), -- Mazino
		(36, 'VC21_QF_09', '17', '0.64', '151', 'N'), -- NagZ
		(39, 'VC21_QF_09', '13', '0.53', '138', 'N'), -- Klaus
		(38, 'VC21_QF_09', '38', '0.46', '108', 'N'), -- delz1k

		-- FNC vs KRU 3
		-- FNATIC (FNC)
		(17, 'VC21_QF_10', '27', '1.07', '218', 'N'), -- doma
		(18, 'VC21_QF_10', '34', '0.75', '169', 'N'), -- Mistic
		(16, 'VC21_QF_10', '17', '0.64', '125', 'N'), -- Boaster
		(19, 'VC21_QF_10', '15', '0.60', '151', 'N'), -- MAGNUM
		(20, 'VC21_QF_10', '12', '0.68', '187', 'N'), -- Derke
		-- KRU Esports (KRU)
		(71, 'VC21_QF_10', '17', '1.91', '304', 'Y'), -- keznit
		(40, 'VC21_QF_10', '29', '2.00', '237', 'N'), -- Mazino
		(39, 'VC21_QF_10', '13', '1.38', '242', 'N'), -- Klaus
		(36, 'VC21_QF_10', '6', '0.86', '140', 'N'), -- NagZ
		(38, 'VC21_QF_10', '21', '0.55', '81', 'N'), -- delz1k

		-- ACE vs TL 1
		-- Acend (ACE)
		(73, 'VC21_SF_01', '28', '1.82', '267', 'N'), -- starxo
		(72, 'VC21_SF_01', '18', '1.67', '308', 'Y'), -- zeek
		(74, 'VC21_SF_01', '31', '1.30', '169', 'N'), -- cNed
		(75, 'VC21_SF_01', '29', '1.00', '169', 'N'), -- Kiles
		(76, 'VC21_SF_01', '44', '0.90', '119', 'N'), -- BONECOLD
		-- Team Liquid (TL)
		(123, 'VC21_SF_01', '28', '0.93', '195', 'N'), -- Nivera
		(11, 'VC21_SF_01', '38', '0.93', '216', 'N'), -- ScreaM
		(15, 'VC21_SF_01', '24', '0.73', '180', 'N'), -- Jamppi
		(13, 'VC21_SF_01', '30', '0.67', '148', 'N'), -- L1NK
		(14, 'VC21_SF_01', '25', '0.43', '80', 'N'), -- soulcas

		-- ACE vs TL 2
		-- Acend (ACE)
		(73, 'VC21_SF_02', '29', '2.00', '288', 'N'), -- starxo
		(75, 'VC21_SF_02', '31', '1.27', '183', 'N'), -- Kiles
		(72, 'VC21_SF_02', '22', '0.92', '174', 'N'), -- zeek
		(74, 'VC21_SF_02', '25', '1.00', '231', 'N'), -- cNed
		(76, 'VC21_SF_02', '32', '0.87', '221', 'N'), -- BONECOLD
		-- Team Liquid (TL)
		(11, 'VC21_SF_02', '29', '1.57', '354', 'Y'), -- ScreaM
		(13, 'VC21_SF_02', '44', '0.71', '162', 'N'), -- L1NK
		(123, 'VC21_SF_02', '36', '0.67', '158', 'N'), -- Nivera
		(15, 'VC21_SF_02', '18', '0.67', '139', 'N'), -- Jamppi
		(14, 'VC21_SF_02', '18', '0.73', '188', 'N'), -- soulcas

		-- GMB vs KRU 1
		-- Gambit Esports (GMB)
		(79, 'VC21_SF_03', '31', '2.18', '305', 'N'), -- Chronicle
		(80, 'VC21_SF_03', '37', '1.21', '202', 'N'), -- Redgar
		(77, 'VC21_SF_03', '15', '0.88', '203', 'N'), -- d3ffo
		(81, 'VC21_SF_03', '30', '0.85', '126', 'N'), -- sheydos
		(78, 'VC21_SF_03', '29', '0.59', '151', 'N'), -- nAts
		-- KRU Esports (KRU)
		(36, 'VC21_SF_03', '33', '1.92', '345', 'Y'), -- NagZ
		(71, 'VC21_SF_03', '37', '1.11', '289', 'N'), -- keznit
		(39, 'VC21_SF_03', '32', '0.54', '115', 'N'), -- Klaus
		(40, 'VC21_SF_03', '30', '0.53', '124', 'N'), -- Mazino
		(38, 'VC21_SF_03', '38', '0.65', '132', 'N'), -- delz1k

		-- GMB vs KRU 2
		-- Gambit Esports (GMB)
		(79, 'VC21_SF_04', '28', '1.17', '204', 'N'), -- Chronicle
		(77, 'VC21_SF_04', '23', '0.93', '191', 'N'), -- d3ffo
		(80, 'VC21_SF_04', '32', '0.88', '191', 'N'), -- Redgar
		(81, 'VC21_SF_04', '26', '0.57', '154', 'N'), -- sheydos
		(78, 'VC21_SF_04', '33', '0.63', '141', 'N'), -- nAts
		-- KRU Esports (KRU)
		(40, 'VC21_SF_04', '23', '2.33', '383', 'Y'), -- Mazino
		(36, 'VC21_SF_04', '16', '1.30', '177', 'N'), -- NagZ
		(71, 'VC21_SF_04', '26', '0.94', '220', 'N'), -- keznit
		(39, 'VC21_SF_04', '27', '0.82', '145', 'N'), -- Klaus
		(38, 'VC21_SF_04', '26', '0.64', '103', 'N'), -- delz1k

		-- GMB vs KRU 3
		-- Gambit Esports (GMB)
		(79, 'VC21_SF_05', '35', '1.36', '278', 'Y'), -- Chronicle
		(78, 'VC21_SF_05', '35', '1.45', '239', 'N'), -- nAts
		(80, 'VC21_SF_05', '21', '1.00', '179', 'N'), -- Redgar
		(77, 'VC21_SF_05', '32', '1.17', '237', 'N'), -- d3ffo
		(81, 'VC21_SF_05', '24', '0.86', '167', 'N'), -- sheydos
		-- KRU Esports (KRU)
		(39, 'VC21_SF_05', '26', '1.19', '204', 'N'), -- Klaus
		(38, 'VC21_SF_05', '24', '1.00', '211', 'N'), -- delz1k
		(71, 'VC21_SF_05', '18', '0.93', '237', 'N'), -- keznit
		(40, 'VC21_SF_05', '17', '0.76', '146', 'N'), -- Mazino
		(36, 'VC21_SF_05', '12', '0.48', '112', 'N'), -- NagZ

		-- ACE vs GMB 1
		-- Acend (ACE)
		(72, 'VC21_GF_01', '47', '0.76', '170', 'N'), -- zeek
		(76, 'VC21_GF_01', '57', '0.88', '168', 'N'), -- BONECOLD
		(74, 'VC21_GF_01', '20', '1.00', '178', 'N'), -- cNed
		(73, 'VC21_GF_01', '48', '0.60', '144', 'N'), -- starxo
		(75, 'VC21_GF_01', '26', '0.58', '120', 'N'), -- Kiles
		-- Gambit Esports (GMB)
		(78, 'VC21_GF_01', '27', '2.90', '337', 'Y'), -- nAts
		(79, 'VC21_GF_01', '29', '1.57', '260', 'N'), -- Chronicle
		(77, 'VC21_GF_01', '24', '1.07', '168', 'N'), -- d3ffo
		(81, 'VC21_GF_01', '27', '0.92', '151', 'N'), -- sheydos
		(80, 'VC21_GF_01', '17', '0.67', '122', 'N'), -- Redgar

		-- ACE vs GMB 2
		-- Acend (ACE)
		(76, 'VC21_GF_02', '41', '1.70', '246', 'N'), -- BONECOLD
		(73, 'VC21_GF_02', '31', '1.45', '212', 'N'), -- starxo
		(74, 'VC21_GF_02', '22', '1.55', '209', 'N'), -- cNed
		(72, 'VC21_GF_02', '31', '1.25', '206', 'N'), -- zeek
		(75, 'VC21_GF_02', '31', '0.83', '141', 'N'), -- Kiles
		-- Gambit Esports (GMB)
		(80, 'VC21_GF_02', '39', '1.13', '249', 'Y'), -- Redgar
		(81, 'VC21_GF_02', '27', '1.00', '219', 'N'), -- sheydos
		(77, 'VC21_GF_02', '29', '0.64', '160', 'N'), -- d3ffo
		(78, 'VC21_GF_02', '31', '0.56', '138', 'N'), -- nAts
		(79, 'VC21_GF_02', '56', '0.36', '76', 'N'), -- Chronicle

		-- ACE vs GMB 3
		-- Acend (ACE)
		(73, 'VC21_GF_03', '19', '0.73', '188', 'N'), -- starxo
		(76, 'VC21_GF_03', '24', '0.43', '113', 'N'), -- BONECOLD
		(72, 'VC21_GF_03', '16', '0.40', '130', 'N'), -- zeek
		(74, 'VC21_GF_03', '24', '0.33', '127', 'N'), -- cNed
		(75, 'VC21_GF_03', '25', '0.13', '42', 'N'), -- Kiles
		-- Gambit Esports (GMB)
		(78, 'VC21_GF_03', '35', '8.67', '394', 'Y'), -- nAts
		(79, 'VC21_GF_03', '30', '4.25', '296', 'N'), -- Chronicle
		(80, 'VC21_GF_03', '24', '2.50', '164', 'N'), -- Redgar
		(77, 'VC21_GF_03', '31', '1.22', '182', 'N'), -- d3ffo
		(81, 'VC21_GF_03', '32', '1.00', '159', 'N'), -- sheydos

		-- ACE vs GMB 4
		-- Acend (ACE)
		(73, 'VC21_GF_04', '27', '1.26', '243', 'N'), -- starxo
		(72, 'VC21_GF_04', '24', '1.20', '260', 'N'), -- zeek
		(74, 'VC21_GF_04', '30', '1.09', '271', 'Y'), -- cNed
		(76, 'VC21_GF_04', '33', '0.69', '121', 'N'), -- BONECOLD
		(75, 'VC21_GF_04', '21', '0.56', '131', 'N'), -- Kiles
		-- Gambit Esports (GMB)
		(78, 'VC21_GF_04', '45', '1.00', '189', 'N'), -- nAts
		(79, 'VC21_GF_04', '35', '1.15', '254', 'N'), -- Chronicle
		(81, 'VC21_GF_04', '21', '1.05', '235', 'N'), -- sheydos
		(77, 'VC21_GF_04', '24', '1.11', '226', 'N'), -- d3ffo
		(80, 'VC21_GF_04', '26', '0.76', '143', 'N'), -- Redgar

		-- ACE vs GMB 5
		-- Acend (ACE)
		(74, 'VC21_GF_05', '26', '1.64', '257', 'N'), -- cNed
		(72, 'VC21_GF_05', '23', '1.45', '229', 'N'), -- zeek
		(73, 'VC21_GF_05', '25', '1.43', '255', 'N'), -- starxo
		(76, 'VC21_GF_05', '37', '1.00', '181', 'N'), -- BONECOLD
		(75, 'VC21_GF_05', '24', '1.08', '131', 'N'), -- Kiles
		-- Gambit Esports (GMB)
		(79, 'VC21_GF_05', '19', '0.93', '212', 'N'), -- Chronicle
		(77, 'VC21_GF_05', '29', '1.06', '271', 'Y'), -- d3ffo
		(78, 'VC21_GF_05', '18', '0.75', '169', 'N'), -- nAts
		(81, 'VC21_GF_05', '21', '0.56', '110', 'N'), -- sheydos
		(80, 'VC21_GF_05', '20', '0.53', '125', 'N'); -- Redgar
        
INSERT INTO player_stats (player_id, match_id, headshot_pct, kd_ratio, avg_combat_score, mvps)
VALUES	-- Masters Reykjavik 2022 added
		-- GROUP STAGE
		-- DRX vs ZETA 1
		-- DRX
		(65, 'MR22_OA_01', '28', '3.29', '386', 'Y'), -- MaKo
		(140, 'MR22_OA_01', '43', '2.00', '200', 'N'), -- Zest
		(61, 'MR22_OA_01', '32', '1.09', '237', 'N'), -- stax
		(62, 'MR22_OA_01', '32', '0.73', '160', 'N'), -- Rb
		(64, 'MR22_OA_01', '28', '0.83', '214', 'N'), -- BuZz
		-- ZETA DIVISION (ZETA)
		(116, 'MR22_OA_01', '33', '1.00', '252', 'N'), -- Laz
		(117, 'MR22_OA_01', '32', '0.77', '181', 'N'), -- crow
		(143, 'MR22_OA_01', '35', '0.69', '209', 'N'), -- SugarZ3ro
		(142, 'MR22_OA_01', '36', '0.58', '151', 'N'), -- TENNN
		(141, 'MR22_OA_01', '53', '0.57', '168', 'N'), -- Dep

		-- DRX vs ZETA 2
		-- DRX
		(65, 'MR22_OA_02', '56', '2.80', '226', 'N'), -- MaKo
		(64, 'MR22_OA_02', '27', '1.64', '331', 'Y'), -- BuZz
		(62, 'MR22_OA_02', '13', '1.70', '277', 'N'), -- Rb
		(61, 'MR22_OA_02', '40', '1.43', '168', 'N'), -- stax
		(140, 'MR22_OA_02', '28', '1.38', '189', 'N'), -- Zest
		-- ZETA DIVISION (ZETA)
		(116, 'MR22_OA_02', '30', '1.33', '253', 'N'), -- Laz
		(117, 'MR22_OA_02', '29', '0.54', '139', 'N'), -- crow
		(143, 'MR22_OA_02', '27', '0.43', '138', 'N'), -- SugarZ3ro
		(142, 'MR22_OA_02', '36', '0.40', '113', 'N'), -- TENNN
		(141, 'MR22_OA_02', '23', '0.38', '133', 'N'), -- Dep

		-- KRU vs TL 1
		-- KRU Esports (KRU)
		(38, 'MR22_OB_01', '27', '0.79', '204', 'N'), -- delz1k
		(40, 'MR22_OB_01', '17', '0.71', '166', 'N'), -- Mazino
		(39, 'MR22_OB_01', '21', '0.71', '169', 'N'), -- Klaus
		(36, 'MR22_OB_01', '28', '0.53', '132', 'N'), -- NagZ
		(71, 'MR22_OB_01', '19', '0.53', '135', 'N'), -- keznit
		-- Team Liquid (TL)
		(15, 'MR22_OB_01', '24', '2.11', '282', 'Y'), -- Jamppi
		(13, 'MR22_OB_01', '40', '1.50', '202', 'N'), -- L1NK
		(123, 'MR22_OB_01', '23', '1.56', '205', 'N'), -- Nivera
		(14, 'MR22_OB_01', '13', '1.27', '217', 'N'), -- soulcas
		(11, 'MR22_OB_01', '42', '1.30', '197', 'N'), -- ScreaM

		-- KRU vs TL 2
		-- KRU Esports (KRU)
		(71, 'MR22_OB_02', '28', '1.33', '253', 'Y'), -- keznit
		(36, 'MR22_OB_02', '20', '1.26', '207', 'N'), -- NagZ
		(39, 'MR22_OB_02', '23', '0.77', '186', 'N'), -- Klaus
		(38, 'MR22_OB_02', '40', '1.00', '218', 'N'), -- delz1k
		(40, 'MR22_OB_02', '15', '0.62', '185', 'N'), -- Mazino
		-- Team Liquid (TL)
		(13, 'MR22_OB_02', '38', '1.45', '243', 'N'), -- L1NK
		(11, 'MR22_OB_02', '42', '1.09', '238', 'N'), -- ScreaM
		(123, 'MR22_OB_02', '17', '1.18', '240', 'N'), -- Nivera
		(15, 'MR22_OB_02', '16', '0.87', '204', 'N'), -- Jamppi
		(14, 'MR22_OB_02', '26', '0.59', '161', 'N'), -- soulcas

		-- OPTC vs XIA 1
		-- OpTic Gaming (OPTC)
		(60, 'MR22_OB_03', '34', '1.19', '240', 'N'), -- yay
		(57, 'MR22_OB_03', '28', '0.88', '191', 'N'), -- Victor
		(58, 'MR22_OB_03', '35', '1.00', '229', 'N'), -- Marved
		(56, 'MR22_OB_03', '33', '0.93', '169', 'N'), -- crashies
		(59, 'MR22_OB_03', '29', '0.47', '91', 'N'), -- FiNESSE
		-- XERXIA Esports (XIA)
		(50, 'MR22_OB_03', '35', '1.64', '280', 'Y'), -- sScary
		(144, 'MR22_OB_03', '27', '1.75', '233', 'N'), -- Surf
		(46, 'MR22_OB_03', '20', '1.00', '177', 'N'), -- foxz
		(48, 'MR22_OB_03', '21', '0.94', '189', 'N'), -- Sushiboys
		(49, 'MR22_OB_03', '28', '0.50', '108', 'N'), -- Crws

		-- OPTC vs XIA 2
		-- OpTic Gaming (OPTC)
		(56, 'MR22_OB_04', '27', '1.29', '213', 'N'), -- crashies
		(57, 'MR22_OB_04', '26', '0.89', '204', 'N'), -- Victor
		(60, 'MR22_OB_04', '7', '1.00', '201', 'N'), -- yay
		(58, 'MR22_OB_04', '30', '0.68', '182', 'N'), -- Marved
		(59, 'MR22_OB_04', '16', '0.73', '133', 'N'), -- FiNESSE
		-- XERXIA Esports (XIA)
		(48, 'MR22_OB_04', '22', '1.43', '228', 'N'), -- Sushiboys
		(144, 'MR22_OB_04', '25', '1.43', '262', 'Y'), -- Surf
		(46, 'MR22_OB_04', '19', '1.19', '233', 'N'), -- foxz
		(50, 'MR22_OB_04', '11', '0.93', '182', 'N'), -- sScary
		(49, 'MR22_OB_04', '25', '0.65', '141', 'N'), -- Crws

		-- FNC vs NIP 1
		-- FNATIC (FNC)
		(138, 'MR22_OA_03', '21', '1.27', '282', 'Y'), -- Enzo
		(139, 'MR22_OA_03', '21', '1.13', '277', 'N'), -- H1ber
		(18, 'MR22_OA_03', '35', '0.80', '170', 'N'), -- Mistic
		(19, 'MR22_OA_03', '21', '0.75', '166', 'N'), -- MAGNUM
		(16, 'MR22_OA_03', '9', '0.36', '88', 'N'), -- Boaster
		-- Ninjas In Pyjamas (NIP)
		(37, 'MR22_OA_03', '27', '1.90', '236', 'N'), -- bnj
		(128, 'MR22_OA_03', '21', '1.67', '263', 'N'), -- xand
		(145, 'MR22_OA_03', '33', '1.20', '265', 'N'), -- Jonn
		(147, 'MR22_OA_03', '6', '0.67', '162', 'N'), -- cauanzin
		(146, 'MR22_OA_03', '33', '0.64', '154', 'N'), -- bezn1

		-- FNC vs NIP 2
		-- FNATIC (FNC)
		(138, 'MR22_OA_04', '22', '1.21', '242', 'N'), -- Enzo
		(18, 'MR22_OA_04', '43', '1.08', '178', 'N'), -- Mistic
		(19, 'MR22_OA_04', '21', '0.88', '217', 'N'), -- MAGNUM
		(16, 'MR22_OA_04', '13', '0.69', '146', 'N'), -- Boaster
		(139, 'MR22_OA_04', '11', '0.50', '167', 'N'), -- H1ber
		-- Ninjas In Pyjamas (NIP)
		(145, 'MR22_OA_04', '35', '1.46', '248', 'Y'), -- Jonn
		(37, 'MR22_OA_04', '24', '1.50', '184', 'N'), -- bnj
		(128, 'MR22_OA_04', '22', '1.33', '269', 'N'), -- xand
		(147, 'MR22_OA_04', '35', '0.77', '147', 'N'), -- cauanzin
		(146, 'MR22_OA_04', '27', '0.93', '170', 'N'), -- bezn1
        
		-- XIA vs TL 1
		-- XERXIA Esports (XIA)
		(49, 'MR22_WB_01', '12', '0.94', '229', 'N'), -- Crws
		(46, 'MR22_WB_01', '18', '0.88', '224', 'N'), -- foxz
		(50, 'MR22_WB_01', '16', '0.80', '175', 'N'), -- sScary
		(48, 'MR22_WB_01', '19', '0.57', '124', 'N'), -- Sushiboys
		(144, 'MR22_WB_01', '12', '0.71', '139', 'N'), -- Surf
		-- Team Liquid (TL)
		(11, 'MR22_WB_01', '32', '1.50', '306', 'Y'), -- ScreaM
		(13, 'MR22_WB_01', '38', '1.64', '220', 'N'), -- L1NK
		(15, 'MR22_WB_01', '15', '1.64', '241', 'N'), -- Jamppi
		(14, 'MR22_WB_01', '16', '1.08', '205', 'N'), -- soulcas
		(123, 'MR22_WB_01', '29', '0.45', '67', 'N'), -- Nivera

		-- XIA vs TL 2
		-- XERXIA Esports (XIA)
		(48, 'MR22_WB_02', '27', '1.31', '239', 'N'), -- Sushiboys
		(50, 'MR22_WB_02', '26', '1.25', '248', 'N'), -- sScary
		(46, 'MR22_WB_02', '33', '1.00', '204', 'N'), -- foxz
		(144, 'MR22_WB_02', '29', '1.05', '256', 'N'), -- Surf
		(49, 'MR22_WB_02', '23', '0.72', '149', 'N'), -- Crws
		-- Team Liquid (TL)
		(15, 'MR22_WB_02', '29', '1.14', '305', 'Y'), -- Jamppi
		(11, 'MR22_WB_02', '23', '1.15', '269', 'N'), -- ScreaM
		(14, 'MR22_WB_02', '31', '0.83', '207', 'N'), -- soulcas
		(123, 'MR22_WB_02', '15', '0.87', '152', 'N'), -- Nivera
		(13, 'MR22_WB_02', '46', '0.67', '137', 'N'), -- L1NK

		-- XIA vs TL 3
		-- XERXIA Esports (XIA)
		(50, 'MR22_WB_03', '24', '1.27', '254', 'N'), -- sScary
		(48, 'MR22_WB_03', '25', '0.74', '156', 'N'), -- Sushiboys
		(46, 'MR22_WB_03', '22', '0.77', '193', 'N'), -- foxz
		(49, 'MR22_WB_03', '27', '0.81', '175', 'N'), -- Crws
		(144, 'MR22_WB_03', '14', '0.69', '154', 'N'), -- Surf
		-- Team Liquid (TL)
		(11, 'MR22_WB_03', '25', '1.26', '247', 'N'), -- ScreaM
		(15, 'MR22_WB_03', '25', '1.50', '270', 'Y'), -- Jamppi
		(14, 'MR22_WB_03', '18', '1.05', '242', 'N'), -- soulcas
		(123, 'MR22_WB_03', '31', '1.19', '197', 'N'), -- Nivera
		(13, 'MR22_WB_03', '45', '0.90', '166', 'N'), -- L1NK

		-- NIP vs DRX 1
		-- Ninjas In Pyjamas (NIP)
		(128, 'MR22_WA_01', '15', '1.00', '192', 'N'), -- xand
		(146, 'MR22_WA_01', '38', '0.64', '185', 'N'), -- bezn1
		(147, 'MR22_WA_01', '20', '0.57', '155', 'N'), -- cauanzin
		(145, 'MR22_WA_01', '23', '0.56', '159', 'N'), -- Jonn
		(37, 'MR22_WA_01', '29', '0.38', '94', 'N'), -- bnj
		-- DRX (DRX)
		(61, 'MR22_WA_01', '20', '2.14', '264', 'N'), -- stax
		(65, 'MR22_WA_01', '21', '2.14', '275', 'Y'), -- MaKo
		(62, 'MR22_WA_01', '26', '2.43', '246', 'N'), -- Rb
		(140, 'MR22_WA_01', '48', '1.11', '171', 'N'), -- Zest
		(64, 'MR22_WA_01', '26', '0.92', '201', 'N'), -- BuZz

		-- NIP vs DRX 2
		-- Ninjas In Pyjamas (NIP)
		(128, 'MR22_WA_02', '32', '1.31', '255', 'N'), -- xand
		(147, 'MR22_WA_02', '24', '1.08', '210', 'N'), -- cauanzin
		(146, 'MR22_WA_02', '17', '0.53', '160', 'N'), -- bezn1
		(37, 'MR22_WA_02', '41', '0.41', '116', 'N'), -- bnj
		(145, 'MR22_WA_02', '28', '0.53', '144', 'N'), -- Jonn
		-- DRX (DRX)
		(65, 'MR22_WA_02', '18', '1.60', '212', 'N'), -- MaKo
		(61, 'MR22_WA_02', '43', '1.50', '240', 'N'), -- stax
		(62, 'MR22_WA_02', '18', '1.33', '279', 'Y'), -- Rb
		(64, 'MR22_WA_02', '20', '1.23', '230', 'N'), -- BuZz
		(140, 'MR22_WA_02', '37', '1.09', '160', 'N'), -- Zest

		-- OPTC vs KRU 1
		-- OpTic Gaming (OPTC)
		(60, 'MR22_EB_01', '33', '2.55', '388', 'Y'), -- yay
		(58, 'MR22_EB_01', '30', '1.60', '244', 'N'), -- Marved
		(59, 'MR22_EB_01', '26', '1.18', '209', 'N'), -- FiNESSE
		(56, 'MR22_EB_01', '31', '1.11', '171', 'N'), -- crashies
		(57, 'MR22_EB_01', '20', '0.91', '189', 'N'), -- Victor
		-- KRU Esports (KRU)
		(71, 'MR22_EB_01', '14', '0.81', '261', 'N'), -- keznit
		(39, 'MR22_EB_01', '28', '0.87', '196', 'N'), -- Klaus
		(36, 'MR22_EB_01', '29', '0.67', '166', 'N'), -- NagZ
		(38, 'MR22_EB_01', '11', '0.57', '130', 'N'), -- delz1k
		(40, 'MR22_EB_01', '11', '0.47', '136', 'N'), -- Mazino

		-- OPTC vs KRU 2
		-- OpTic Gaming (OPTC)
		(58, 'MR22_EB_02', '30', '1.40', '267', 'Y'), -- Marved
		(56, 'MR22_EB_02', '32', '1.29', '235', 'N'), -- crashies
		(57, 'MR22_EB_02', '18', '0.88', '171', 'N'), -- Victor
		(60, 'MR22_EB_02', '24', '1.12', '239', 'N'), -- yay
		(59, 'MR22_EB_02', '21', '0.67', '166', 'N'), -- FiNESSE
		-- KRU Esports (KRU)
		(36, 'MR22_EB_02', '44', '1.22', '256', 'N'), -- NagZ
		(40, 'MR22_EB_02', '43', '1.00', '179', 'N'), -- Mazino
		(71, 'MR22_EB_02', '41', '1.00', '167', 'N'), -- keznit
		(39, 'MR22_EB_02', '16', '0.76', '178', 'N'), -- Klaus
		(38, 'MR22_EB_02', '20', '0.72', '169', 'N'), -- delz1k

		-- FNC vs ZETA 1
		-- FNATIC (FNC)
		(138, 'MR22_EA_01', '25', '1.00', '187', 'N'), -- Enzo
		(139, 'MR22_EA_01', '24', '0.84', '251', 'N'), -- H1ber
		(18, 'MR22_EA_01', '30', '0.67', '183', 'N'), -- Mistic
		(19, 'MR22_EA_01', '18', '0.59', '172', 'N'), -- MAGNUM
		(16, 'MR22_EA_01', '26', '0.71', '169', 'N'), -- Boaster
		-- ZETA DIVISION (ZETA)
		(143, 'MR22_EA_01', '33', '2.00', '316', 'Y'), -- SugarZ3ro
		(116, 'MR22_EA_01', '34', '1.75', '281', 'N'), -- Laz
		(142, 'MR22_EA_01', '13', '1.43', '299', 'N'), -- TENNN
		(117, 'MR22_EA_01', '27', '0.75', '126', 'N'), -- crow
		(141, 'MR22_EA_01', '29', '0.79', '141', 'N'), -- Dep

		-- FNC vs ZETA 2
		-- FNATIC (FNC)
		(18, 'MR22_EA_02', '29', '1.17', '263', 'N'), -- Mistic
		(139, 'MR22_EA_02', '24', '1.00', '230', 'N'), -- H1ber
		(138, 'MR22_EA_02', '18', '1.00', '207', 'N'), -- Enzo
		(19, 'MR22_EA_02', '22', '0.80', '195', 'N'), -- MAGNUM
		(16, 'MR22_EA_02', '18', '0.41', '132', 'N'), -- Boaster
		-- ZETA DIVISION (ZETA)
		(143, 'MR22_EA_02', '41', '1.57', '237', 'N'), -- SugarZ3ro
		(116, 'MR22_EA_02', '41', '1.71', '338', 'Y'), -- Laz
		(117, 'MR22_EA_02', '41', '0.93', '185', 'N'), -- crow
		(141, 'MR22_EA_02', '27', '0.89', '205', 'N'), -- Dep
		(142, 'MR22_EA_02', '51', '0.84', '202', 'N'), -- TENNN
        
		-- XIA vs OPTC 1
		-- XERXIA Esports (XIA)
		(48, 'MR22_DB_01', '30', '1.11', '265', 'N'), -- Sushiboys
		(49, 'MR22_DB_01', '30', '1.06', '221', 'N'), -- Crws
		(158, 'MR22_DB_01', '17', '0.75', '174', 'N'), -- sScary
		(144, 'MR22_DB_01', '20', '0.75', '208', 'N'), -- Surf
		(46, 'MR22_DB_01', '19', '0.50', '126', 'N'), -- foxz
		-- OpTic Gaming (OPTC)
		(56, 'MR22_DB_01', '23', '1.29', '251', 'N'), -- crashies
		(57, 'MR22_DB_01', '19', '1.53', '272', 'Y'), -- Victor
		(60, 'MR22_DB_01', '25', '1.43', '262', 'N'), -- yay
		(59, 'MR22_DB_01', '23', '1.00', '187', 'N'), -- FiNESSE
		(58, 'MR22_DB_01', '27', '0.81', '163', 'N'), -- Marved

		-- XIA vs OPTC 2
		-- XERXIA Esports (XIA)
		(144, 'MR22_DB_02', '31', '1.14', '238', 'N'), -- Surf
		(49, 'MR22_DB_02', '29', '0.69', '158', 'N'), -- Crws
		(158, 'MR22_DB_02', '20', '0.71', '187', 'N'), -- sScary
		(46, 'MR22_DB_02', '29', '0.69', '170', 'N'), -- foxz
		(48, 'MR22_DB_02', '19', '0.67', '158', 'N'), -- Sushiboys
		-- OpTic Gaming (OPTC)
		(57, 'MR22_DB_02', '23', '1.43', '310', 'Y'), -- Victor
		(60, 'MR22_DB_02', '24', '2.00', '244', 'N'), -- yay
		(58, 'MR22_DB_02', '29', '1.36', '213', 'N'), -- Marved
		(56, 'MR22_DB_02', '22', '1.08', '171', 'N'), -- crashies
		(59, 'MR22_DB_02', '15', '0.75', '151', 'N'), -- FiNESSE

		-- NIP vs ZETA 1
		-- Ninjas In Pyjamas (NIP)
		(128, 'MR22_DA_01', '15', '1.50', '343', 'Y'), -- xand
		(147, 'MR22_DA_01', '18', '1.92', '319', 'N'), -- cauanzin
		(146, 'MR22_DA_01', '24', '1.40', '227', 'N'), -- bezn1
		(37,  'MR22_DA_01', '16', '1.20', '166', 'N'), -- bnj
		(145, 'MR22_DA_01', '24', '0.69', '126', 'N'), -- Jonn
		-- ZETA DIVISION (ZETA)
		(143, 'MR22_DA_01', '42', '1.14', '228', 'N'), -- SugarZ3ro
		(141, 'MR22_DA_01', '27', '0.71', '214', 'N'), -- Dep
		(142, 'MR22_DA_01', '21', '0.75', '179', 'N'), -- TENNN
		(117, 'MR22_DA_01', '37', '0.69', '148', 'N'), -- crow
		(116, 'MR22_DA_01', '27', '0.50', '157', 'N'), -- Laz

		-- NIP vs ZETA 2
		-- Ninjas In Pyjamas (NIP)
		(147, 'MR22_DA_02', '34', '0.95', '245', 'N'), -- cauanzin
		(37,  'MR22_DA_02', '24', '0.88', '184', 'N'), -- bnj
		(128, 'MR22_DA_02', '19', '0.86', '231', 'N'), -- xand
		(145, 'MR22_DA_02', '29', '0.80', '195', 'N'), -- Jonn
		(146, 'MR22_DA_02', '19', '0.48', '143', 'N'), -- bezn1
		-- ZETA DIVISION (ZETA)
		(143, 'MR22_DA_02', '21', '1.64', '288', 'N'), -- SugarZ3ro
		(141, 'MR22_DA_02', '25', '2.00', '296', 'Y'), -- Dep
		(116, 'MR22_DA_02', '19', '1.24', '256', 'N'), -- Laz
		(142, 'MR22_DA_02', '35', '1.06', '228', 'N'), -- TENNN
		(117, 'MR22_DA_02', '17', '0.60', '126', 'N'), -- crow

		-- NIP vs ZETA 3
		-- Ninjas In Pyjamas (NIP)
		(146, 'MR22_DA_03', '22', '1.56', '304', 'N'), -- bezn1
		(147, 'MR22_DA_03', '21', '0.86', '216', 'N'), -- cauanzin
		(145, 'MR22_DA_03', '27', '0.71', '136', 'N'), -- Jonn
		(37,  'MR22_DA_03', '29', '0.53', '139', 'N'), -- bnj
		(128, 'MR22_DA_03', '25', '0.72', '139', 'N'), -- xand
		-- ZETA DIVISION (ZETA)
		(142, 'MR22_DA_03', '30', '1.69', '308', 'Y'), -- TENNN
		(116, 'MR22_DA_03', '21', '1.33', '271', 'N'), -- Laz
		(143, 'MR22_DA_03', '30', '1.24', '230', 'N'), -- SugarZ3ro
		(117, 'MR22_DA_03', '34', '0.75', '137', 'N'), -- crow
		(141, 'MR22_DA_03', '13', '0.67', '126', 'N'), -- Dep

		-- PLAYOFFS
		-- G2 vs ZETA 1
		-- G2 Esports (G2)
		(149, 'MR22_UQF_01', '20', '1.27', '300', 'Y'), -- hoody
		(68,  'MR22_UQF_01', '47', '1.21', '230', 'N'), -- AvovA
		(69,  'MR22_UQF_01', '16', '1.27', '296', 'N'), -- nukkye
		(66,  'MR22_UQF_01', '15', '1.23', '209', 'N'), -- Mixwell
		(148, 'MR22_UQF_01', '39', '0.85', '133', 'N'), -- Meddo
		-- ZETA DIVISION (ZETA)
		(116, 'MR22_UQF_01', '29', '0.94', '224', 'N'), -- Laz
		(141, 'MR22_UQF_01', '38', '0.88', '235', 'N'), -- Dep
		(143, 'MR22_UQF_01', '33', '1.00', '215', 'N'), -- SugarZ3ro
		(117, 'MR22_UQF_01', '29', '0.76', '179', 'N'), -- crow
		(142, 'MR22_UQF_01', '21', '0.71', '177', 'N'), -- TENNN

		-- G2 vs ZETA 2
		-- G2 Esports (G2)
		(66,  'MR22_UQF_02', '18', '1.80', '315', 'N'), -- Mixwell
		(149, 'MR22_UQF_02', '47', '1.50', '275', 'N'), -- hoody
		(68,  'MR22_UQF_02', '35', '0.47', '106', 'N'), -- AvovA
		(69,  'MR22_UQF_02', '13', '0.61', '176', 'N'), -- nukkye
		(148, 'MR22_UQF_02', '18', '0.53', '111', 'N'), -- Meddo
		-- ZETA DIVISION (ZETA)
		(142, 'MR22_UQF_02', '35', '1.32', '338', 'Y'), -- TENNN
		(141, 'MR22_UQF_02', '25', '1.50', '273', 'N'), -- Dep
		(116, 'MR22_UQF_02', '37', '1.31', '183', 'N'), -- Laz
		(143, 'MR22_UQF_02', '24', '0.63', '126', 'N'), -- SugarZ3ro
		(117, 'MR22_UQF_02', '32', '0.50', '97', 'N'), -- crow

		-- LOUD vs TL 1
		-- LOUD (LOUD)
		(157, 'MR22_UQF_03', '37', '1.83', '262', 'N'), -- aspas
		(22,  'MR22_UQF_03', '40', '1.31', '246', 'N'), -- Sacy
		(156, 'MR22_UQF_03', '23', '1.21', '234', 'N'), -- Less
		(155, 'MR22_UQF_03', '61', '0.73', '136', 'N'), -- pANcada
		(23,  'MR22_UQF_03', '22', '0.76', '174', 'N'), -- saadhak
		-- Team Liquid (TL)
		(120, 'MR22_UQF_03', '31', '1.44', '335', 'Y'), -- Jamppi
		(11,  'MR22_UQF_03', '31', '1.00', '250', 'N'), -- ScreaM
		(13,  'MR22_UQF_03', '37', '0.93', '168', 'N'), -- L1NK
		(123, 'MR22_UQF_03', '33', '0.67', '146', 'N'), -- Nivera
		(14,  'MR22_UQF_03', '32', '0.35', '78', 'N'), -- soulcas

		-- LOUD vs TL 2
		-- LOUD (LOUD)
		(157, 'MR22_UQF_04', '22', '1.00', '273', 'N'), -- aspas
		(22,  'MR22_UQF_04', '25', '0.64', '215', 'N'), -- Sacy
		(155, 'MR22_UQF_04', '59', '0.87', '211', 'N'), -- pANcada
		(23,  'MR22_UQF_04', '18', '0.36', '92',  'N'), -- saadhak
		(156, 'MR22_UQF_04', '20', '0.27', '93',  'N'), -- Less
		-- Team Liquid (TL)
		(11,  'MR22_UQF_04', '49', '2.86', '336', 'N'), -- ScreaM
		(123, 'MR22_UQF_04', '43', '2.33', '340', 'Y'), -- Nivera
		(14,  'MR22_UQF_04', '28', '1.56', '247', 'N'), -- soulcas
		(120, 'MR22_UQF_04', '46', '1.00', '173', 'N'), -- Jamppi
		(13,  'MR22_UQF_04', '29', '0.67', '99',  'N'), -- L1NK,

		-- LOUD vs TL 3
		-- LOUD (LOUD)
		(22,  'MR22_UQF_05', '32', '1.43', '232', 'N'), -- Sacy
		(157, 'MR22_UQF_05', '22', '1.25', '243', 'N'), -- aspas
		(155, 'MR22_UQF_05', '26', '1.11', '234', 'N'), -- pANcada
		(156, 'MR22_UQF_05', '9',  '1.00', '177', 'N'), -- Less
		(23,  'MR22_UQF_05', '27', '0.82', '186', 'N'), -- saadhak
		-- Team Liquid (TL)
		(120, 'MR22_UQF_05', '28', '1.29', '258', 'Y'), -- Jamppi
		(14,  'MR22_UQF_05', '18', '0.93', '186', 'N'), -- soulcas
		(13,  'MR22_UQF_05', '46', '0.89', '204', 'N'), -- L1NK
		(11,  'MR22_UQF_05', '30', '0.70', '185', 'N'), -- ScreaM
		(123, 'MR22_UQF_05', '26', '0.71', '154', 'N'), -- Nivera

		-- PRX vs DRX 1
		-- Paper Rex (PRX)
		(155, 'MR22_UQF_06', '25', '1.21', '285', 'N'), -- Jinggg
		(109, 'MR22_UQF_06', '22', '1.25', '224', 'N'), -- Benkai
		(107, 'MR22_UQF_06', '27', '0.94', '169', 'N'), -- mindfreak
		(110, 'MR22_UQF_06', '38', '0.88', '167', 'N'), -- d4v41
		(108, 'MR22_UQF_06', '31', '0.61', '144', 'N'), -- f0rsakeN
		-- DRX (DRX)
		(65, 'MR22_UQF_06', '27', '1.53', '291', 'Y'), -- MaKo
		(64, 'MR22_UQF_06', '21', '1.25', '267', 'N'), -- BuZz
		(62, 'MR22_UQF_06', '26', '1.06', '238', 'N'), -- Rb
		(61, 'MR22_UQF_06', '35', '0.65', '138', 'N'), -- stax
		(140, 'MR22_UQF_06', '43', '0.63', '136', 'N'), -- Zest

		-- PRX vs DRX 2
		-- Paper Rex (PRX)
		(109, 'MR22_UQF_07', '25', '1.42', '194', 'N'), -- Benkai
		(107, 'MR22_UQF_07', '25', '1.06', '229', 'N'), -- mindfreak
		(110, 'MR22_UQF_07', '23', '1.07', '216', 'N'), -- d4v41
		(108, 'MR22_UQF_07', '16', '0.83', '214', 'N'), -- f0rsakeN
		(155, 'MR22_UQF_07', '10', '0.50', '166', 'N'), -- Jinggg
		-- DRX (DRX)
		(61, 'MR22_UQF_07', '36', '2.18', '288', 'Y'), -- stax
		(64, 'MR22_UQF_07', '42', '1.31', '207', 'N'), -- BuZz
		(65, 'MR22_UQF_07', '16', '0.76', '221', 'N'), -- MaKo
		(62, 'MR22_UQF_07', '22', '0.94', '218', 'N'), -- Rb
		(140,'MR22_UQF_07', '40', '0.71', '138', 'N'), -- Zest

		-- PRX vs DRX 3
		-- Paper Rex (PRX)
		(110, 'MR22_UQF_08', '25', '1.00', '226', 'N'), -- d4v41
		(109, 'MR22_UQF_08', '29', '0.80', '164', 'N'), -- Benkai
		(108, 'MR22_UQF_08', '36', '0.74', '189', 'N'), -- f0rsakeN
		(107, 'MR22_UQF_08', '33', '0.53', '143', 'N'), -- mindfreak
		(155, 'MR22_UQF_08', '6',  '0.50', '160', 'N'), -- Jinggg
		-- DRX (DRX)
		(65, 'MR22_UQF_08', '27', '2.67', '330', 'N'), -- MaKo
		(64, 'MR22_UQF_08', '30', '2.33', '354', 'Y'), -- BuZz
		(140,'MR22_UQF_08', '20', '0.93', '185', 'N'), -- Zest
		(62, 'MR22_UQF_08', '29', '0.86', '155', 'N'), -- Rb
		(61, 'MR22_UQF_08', '46', '0.83', '130', 'N'), -- stax

		-- TGRD vs OPTC 1
		-- The Guard (TGRD)
		(151, 'MR22_UQF_09', '28', '1.20', '227', 'N'), -- Sayaplayer
		(153, 'MR22_UQF_09', '36', '0.94', '215', 'N'), -- neT
		(154, 'MR22_UQF_09', '31', '0.73', '161', 'N'), -- trent
		(150, 'MR22_UQF_09', '29', '0.75', '172', 'N'), -- valyn
		(152, 'MR22_UQF_09', '23', '0.64', '144', 'N'), -- JonahP
		-- OpTic Gaming (OPTC)
		(60, 'MR22_UQF_09', '38', '1.92', '304', 'Y'), -- yay
		(58, 'MR22_UQF_09', '30', '1.55', '225', 'N'), -- Marved
		(57, 'MR22_UQF_09', '29', '0.86', '206', 'N'), -- Victor
		(56, 'MR22_UQF_09', '22', '1.08', '184', 'N'), -- crashies
		(59, 'MR22_UQF_09', '26', '0.69', '163', 'N'), -- FiNESSE

		-- TGRD vs OPTC 2
		-- The Guard (TGRD)
		(151, 'MR22_UQF_10', '41', '2.88', '318', 'Y'), -- Sayaplayer
		(153, 'MR22_UQF_10', '36', '1.60', '208', 'N'), -- neT
		(154, 'MR22_UQF_10', '42', '1.36', '185', 'N'), -- trent
		(150, 'MR22_UQF_10', '15', '0.92', '162', 'N'), -- valyn
		(152, 'MR22_UQF_10', '26', '0.80', '172', 'N'), -- JonahP
		-- OpTic Gaming (OPTC)
		(60, 'MR22_UQF_10', '27', '0.94', '217', 'N'), -- yay
		(59, 'MR22_UQF_10', '15', '0.86', '192', 'N'), -- FiNESSE
		(58, 'MR22_UQF_10', '28', '0.60', '144', 'N'), -- Marved
		(57, 'MR22_UQF_10', '35', '0.69', '168', 'N'), -- Victor
		(56, 'MR22_UQF_10', '56', '0.53', '122', 'N'), -- crashies

		-- TGRD vs OPTC 3
		-- The Guard (TGRD)
		(151, 'MR22_UQF_11', '23', '1.69', '302', 'Y'), -- Sayaplayer
		(153, 'MR22_UQF_11', '30', '1.06', '203', 'N'), -- neT
		(152, 'MR22_UQF_11', '25', '0.88', '169', 'N'), -- JonahP
		(150, 'MR22_UQF_11', '25', '0.72', '167', 'N'), -- valyn
		(154, 'MR22_UQF_11', '19', '0.72', '149', 'N'), -- trent
		-- OpTic Gaming (OPTC)
		(59, 'MR22_UQF_11', '26', '1.31', '246', 'N'), -- FiNESSE
		(58, 'MR22_UQF_11', '25', '1.18', '241', 'N'), -- Marved
		(57, 'MR22_UQF_11', '23', '1.24', '246', 'N'), -- Victor
		(60, 'MR22_UQF_11', '12', '0.82', '189', 'N'), -- yay
		(56, 'MR22_UQF_11', '27', '0.50', '108', 'N'), -- crashies

		-- ZETA vs TL 1
		-- ZETA DIVISION (ZETA)
		(143, 'MR22_LR1_01', '25', '1.83', '298', 'Y'), -- SugarZ3ro
		(141, 'MR22_LR1_01', '39', '1.22', '158', 'N'), -- Dep
		(117, 'MR22_LR1_01', '28', '1.25', '189', 'N'), -- crow
		(116, 'MR22_LR1_01', '15', '1.08', '190', 'N'), -- Laz
		(142, 'MR22_LR1_01', '19', '1.00', '231', 'N'), -- TENNN
		-- Team Liquid (TL)
		(123, 'MR22_LR1_01', '28', '1.14', '214', 'N'), -- Nivera
		(11,  'MR22_LR1_01', '34', '0.88', '208', 'N'), -- ScreaM
		(13,  'MR22_LR1_01', '56', '0.64', '128', 'N'), -- L1NK
		(14,  'MR22_LR1_01', '24', '0.71', '176', 'N'), -- soulcas
		(120, 'MR22_LR1_01', '29', '0.53', '112', 'N'), -- Jamppi

		-- ZETA vs TL 2
		-- ZETA DIVISION (ZETA)
		(143, 'MR22_LR1_02', '26', '0.92', '205', 'N'), -- SugarZ3ro
		(142, 'MR22_LR1_02', '33', '0.86', '205', 'N'), -- TENNN
		(141, 'MR22_LR1_02', '45', '0.69', '181', 'N'), -- Dep
		(116, 'MR22_LR1_02', '14', '0.36', '105', 'N'), -- Laz
		(117, 'MR22_LR1_02', '13', '0.21', '83', 'N'), -- crow
		-- Team Liquid (TL)
		(11,  'MR22_LR1_02', '54', '1.91', '365', 'Y'), -- ScreaM
		(123, 'MR22_LR1_02', '19', '2.00', '216', 'N'), -- Nivera
		(14,  'MR22_LR1_02', '43', '2.00', '203', 'N'), -- soulcas
		(13,  'MR22_LR1_02', '67', '1.43', '164', 'N'), -- L1NK
		(120, 'MR22_LR1_02', '29', '1.09', '191', 'N'), -- Jamppi

		-- ZETA vs TL 3
		-- ZETA DIVISION (ZETA)
		(141, 'MR22_LR1_03', '45', '1.31', '253', 'N'), -- Dep
		(143, 'MR22_LR1_03', '21', '1.64', '223', 'N'), -- SugarZ3ro
		(117, 'MR22_LR1_03', '38', '1.19', '248', 'N'), -- crow
		(142, 'MR22_LR1_03', '16', '0.93', '195', 'N'), -- TENNN
		(116, 'MR22_LR1_03', '24', '0.80', '153', 'N'), -- Laz
		-- Team Liquid (TL)
		(123, 'MR22_LR1_03', '44', '1.43', '257', 'N'), -- Nivera
		(11,  'MR22_LR1_03', '25', '1.20', '265', 'N'), -- ScreaM
		(14,  'MR22_LR1_03', '18', '0.79', '270', 'Y'), -- soulcas
		(120, 'MR22_LR1_03', '15', '0.65', '170', 'N'), -- Jamppi
		(13,  'MR22_LR1_03', '26', '0.36', '76',  'N'), -- L1NK

		-- PRX vs TGRD 1
		-- Paper Rex (PRX)
		(108, 'MR22_LR1_04', '26', '1.38', '280', 'N'), -- f0rsakeN
		(155, 'MR22_LR1_04', '21', '1.50', '277', 'N'), -- Jinggg
		(109, 'MR22_LR1_04', '24', '1.36', '230', 'N'), -- Benkai
		(107, 'MR22_LR1_04', '32', '1.00', '176', 'N'), -- mindfreak
		(110, 'MR22_LR1_04', '22', '0.44', '102', 'N'), -- d4v41
		-- The Guard (TGRD)
		(152, 'MR22_LR1_04', '37', '1.32', '285', 'Y'), -- JonahP
		(150, 'MR22_LR1_04', '30', '0.88', '174', 'N'), -- valyn
		(151, 'MR22_LR1_04', '26', '0.94', '220', 'N'), -- Sayaplayer
		(154, 'MR22_LR1_04', '37', '0.71', '147', 'N'), -- trent
		(153, 'MR22_LR1_04', '29', '0.56', '150', 'N'), -- neT

		-- PRX vs TGRD 2
		-- Paper Rex (PRX)
		(108, 'MR22_LR1_05', '41', '1.75', '262', 'N'), -- f0rsakeN
		(155, 'MR22_LR1_05', '18', '1.56', '385', 'Y'), -- Jinggg
		(107, 'MR22_LR1_05', '28', '1.30', '160', 'N'), -- mindfreak
		(109, 'MR22_LR1_05', '35', '1.00', '145', 'N'), -- Benkai
		(110, 'MR22_LR1_05', '21', '0.86', '186', 'N'), -- d4v41
		-- The Guard (TGRD)
		(150, 'MR22_LR1_05', '24', '1.06', '219', 'N'), -- valyn
		(152, 'MR22_LR1_05', '21', '1.06', '223', 'N'), -- JonahP
		(154, 'MR22_LR1_05', '27', '0.67', '170', 'N'), -- trent
		(153, 'MR22_LR1_05', '41', '0.50', '120', 'N'), -- neT
		(151, 'MR22_LR1_05', '16', '0.58', '188', 'N'), -- Sayaplayer

		-- DRX vs OPTC 1
		-- DRX (DRX)
		(65, 'MR22_USF_01', '30', '1.36', '266', 'Y'), -- MaKo
		(140, 'MR22_USF_01', '23', '1.27', '214', 'N'), -- Zest
		(64, 'MR22_USF_01', '19', '1.21', '205', 'N'), -- BuZz
		(62, 'MR22_USF_01', '18', '0.85', '177', 'N'), -- Rb
		(61, 'MR22_USF_01', '56', '0.93', '171', 'N'), -- stax
		-- OpTic Gaming (OPTC)
		(60, 'MR22_USF_01', '39', '1.12', '258', 'N'), -- yay
		(58, 'MR22_USF_01', '35', '1.20', '215', 'N'), -- Marved
		(59, 'MR22_USF_01', '22', '0.87', '186', 'N'), -- FiNESSE
		(56, 'MR22_USF_01', '17', '0.53', '164', 'N'), -- crashies
		(57, 'MR22_USF_01', '28', '0.75', '159', 'N'), -- Victor

		-- DRX vs OPTC 2
		-- DRX (DRX)
		(61, 'MR22_USF_02', '39', '1.36', '233', 'N'), -- stax
		(140, 'MR22_USF_02', '18', '1.40', '256', 'N'), -- Zest
		(64, 'MR22_USF_02', '21', '0.89', '214', 'N'), -- BuZz
		(65, 'MR22_USF_02', '25', '0.44', '123', 'N'), -- MaKo
		(62, 'MR22_USF_02', '50', '0.42', '103', 'N'), -- Rb
		-- OpTic Gaming (OPTC)
		(57, 'MR22_USF_02', '25', '1.91', '264', 'Y'), -- Victor
		(56, 'MR22_USF_02', '25', '1.27', '211', 'N'), -- crashies
		(58, 'MR22_USF_02', '17', '1.00', '211', 'N'), -- Marved
		(60, 'MR22_USF_02', '41', '0.88', '161', 'N'), -- yay
		(59, 'MR22_USF_02', '26', '1.00', '152', 'N'), -- FiNESSE

		-- DRX vs OPTC 3
		-- DRX (DRX)
		(140, 'MR22_USF_03', '27', '1.59', '263', 'N'), -- Zest
		(65, 'MR22_USF_03', '23', '1.25', '271', 'Y'), -- MaKo
		(61, 'MR22_USF_03', '39', '0.60', '120', 'N'), -- stax
		(64, 'MR22_USF_03', '27', '0.62', '133', 'N'), -- BuZz
		(62, 'MR22_USF_03', '16', '0.54', '139', 'N'), -- Rb
		-- OpTic Gaming (OPTC)
		(60, 'MR22_USF_03', '23', '1.59', '263', 'N'), -- yay
		(56, 'MR22_USF_03', '18', '1.33', '243', 'N'), -- crashies
		(58, 'MR22_USF_03', '28', '1.12', '212', 'N'), -- Marved
		(57, 'MR22_USF_03', '31', '1.00', '209', 'N'), -- Victor
		(59, 'MR22_USF_03', '13', '0.67', '118', 'N'), -- FiNESSE

		-- G2 vs LOUD 1
		-- G2 Esports (G2)
		(149, 'MR22_USF_04', '27', '1.13', '273', 'N'), -- hoody
		(69, 'MR22_USF_04', '24', '0.71', '188', 'N'), -- nukkye
		(68, 'MR22_USF_04', '35', '0.69', '173', 'N'), -- AvovA
		(148, 'MR22_USF_04', '23', '0.60', '146', 'N'), -- Meddo
		(66, 'MR22_USF_04', '11', '0.44', '130', 'N'), -- Mixwell
		-- LOUD (LOUD)
		(22, 'MR22_USF_04', '29', '2.38', '290', 'N'), -- Sacy
		(157, 'MR22_USF_04', '34', '1.75', '318', 'Y'), -- Less
		(158, 'MR22_USF_04', '36', '1.67', '306', 'N'), -- aspas
		(23, 'MR22_USF_04', '4', '0.67', '158', 'N'), -- saadhak
		(156, 'MR22_USF_04', '35', '0.80', '107', 'N'), -- pANcada

		-- G2 vs LOUD 2
		-- G2 Esports (G2)
		(68, 'MR22_USF_05', '27', '0.94', '199', 'N'), -- AvovA
		(149, 'MR22_USF_05', '38', '0.82', '177', 'N'), -- hoody
		(69, 'MR22_USF_05', '22', '0.84', '210', 'N'), -- nukkye
		(66, 'MR22_USF_05', '17', '0.95', '220', 'Y'), -- Mixwell
		(148, 'MR22_USF_05', '53', '0.60', '103', 'N'), -- Meddo
		-- LOUD (LOUD)
		(22, 'MR22_USF_05', '27', '1.82', '257', 'Y'), -- Sacy
		(158, 'MR22_USF_05', '17', '1.25', '240', 'N'), -- aspas
		(156, 'MR22_USF_05', '39', '1.43', '201', 'N'), -- pANcada
		(157, 'MR22_USF_05', '15', '1.08', '160', 'N'), -- Less
		(23, 'MR22_USF_05', '14', '0.70', '176', 'N'), -- saadhak

		-- DRX vs ZETA 1
		-- DRX (DRX)
		(140, 'MR22_LR2_01', '30', '1.25', '243', 'N'), -- Zest
		(61, 'MR22_LR2_01', '21', '1.06', '231', 'N'), -- stax
		(65, 'MR22_LR2_01', '28', '0.67', '157', 'N'), -- MaKo
		(62, 'MR22_LR2_01', '19', '0.76', '135', 'N'), -- Rb
		(64, 'MR22_LR2_01', '27', '0.45', '139', 'N'), -- BuZz
		-- ZETA DIVISION (ZETA)
		(116, 'MR22_LR2_01', '30', '1.67', '270', 'Y'), -- Laz
		(143, 'MR22_LR2_01', '29', '1.21', '225', 'N'), -- SugarZ3ro
		(117, 'MR22_LR2_01', '20', '1.25', '193', 'N'), -- crow
		(141, 'MR22_LR2_01', '27', '1.31', '243', 'N'), -- Dep
		(142, 'MR22_LR2_01', '26', '0.76', '141', 'N'), -- TENNN

		-- DRX vs ZETA 2
		-- DRX (DRX)
		(64, 'MR22_LR2_02', '27', '1.80', '318', 'Y'), -- BuZz
		(65, 'MR22_LR2_02', '20', '1.25', '244', 'N'), -- MaKo
		(140, 'MR22_LR2_02', '23', '1.31', '201', 'N'), -- Zest
		(61, 'MR22_LR2_02', '52', '1.00', '191', 'N'), -- stax
		(62, 'MR22_LR2_02', '50', '0.87', '159', 'N'), -- Rb
		-- ZETA DIVISION (ZETA)
		(141, 'MR22_LR2_02', '27', '0.94', '184', 'N'), -- Dep
		(143, 'MR22_LR2_02', '17', '0.81', '224', 'N'), -- SugarZ3ro
		(117, 'MR22_LR2_02', '27', '0.72', '206', 'N'), -- crow
		(116, 'MR22_LR2_02', '39', '0.95', '221', 'N'), -- Laz
		(142, 'MR22_LR2_02', '23', '0.59', '114', 'N'), -- TENNN

		-- DRX vs ZETA 3
		-- DRX (DRX)
		(61, 'MR22_LR2_03', '23', '1.31', '284', 'N'), -- stax
		(140, 'MR22_LR2_03', '50', '0.86', '195', 'N'), -- Zest
		(65, 'MR22_LR2_03', '29', '0.67', '183', 'N'), -- MaKo
		(64, 'MR22_LR2_03', '18', '0.20', '90', 'N'), -- BuZz
		(62, 'MR22_LR2_03', '10', '0.44', '118', 'N'), -- Rb
		-- ZETA DIVISION (ZETA)
		(142, 'MR22_LR2_03', '38', '1.91', '345', 'Y'), -- TENNN
		(117, 'MR22_LR2_03', '16', '1.56', '198', 'N'), -- crow
		(143, 'MR22_LR2_03', '18', '1.45', '258', 'N'), -- SugarZ3ro
		(141, 'MR22_LR2_03', '16', '1.33', '205', 'N'), -- Dep
		(116, 'MR22_LR2_03', '23', '1.11', '172', 'N'), -- Laz

		-- G2 vs PRX 1
		-- G2 Esports (G2)
		(149, 'MR22_LR2_04', '34', '1.06', '255', 'N'), -- hoody
		(69, 'MR22_LR2_04', '10', '0.94', '217', 'N'), -- nukkye
		(66, 'MR22_LR2_04', '15', '1.06', '223', 'N'), -- Mixwell
		(68, 'MR22_LR2_04', '24', '0.76', '171', 'N'), -- AvovA
		(148, 'MR22_LR2_04', '20', '0.67', '146', 'N'), -- Meddo
		-- Paper Rex (PRX)
		(108, 'MR22_LR2_04', '21', '1.67', '301', 'Y'), -- f0rsakeN
		(107, 'MR22_LR2_04', '41', '1.25', '174', 'N'), -- mindfreak
		(155, 'MR22_LR2_04', '8', '1.05', '292', 'N'), -- Jinggg
		(109, 'MR22_LR2_04', '38', '0.86', '140', 'N'), -- Benkai
		(110, 'MR22_LR2_04', '45', '0.83', '181', 'N'), -- d4v41

		-- G2 vs PRX 2
		-- G2 Esports (G2)
		(148, 'MR22_LR2_05', '28', '1.33', '278', 'N'), -- Meddo
		(66, 'MR22_LR2_05', '24', '0.80', '200', 'N'), -- Mixwell
		(69, 'MR22_LR2_05', '15', '0.69', '180', 'N'), -- nukkye
		(149, 'MR22_LR2_05', '17', '0.75', '177', 'N'), -- hoody
		(68, 'MR22_LR2_05', '22', '0.67', '135', 'N'), -- AvovA
		-- Paper Rex (PRX)
		(108, 'MR22_LR2_05', '55', '2.23', '371', 'Y'), -- f0rsakeN
		(155, 'MR22_LR2_05', '13', '1.20', '242', 'N'), -- Jinggg
		(110, 'MR22_LR2_05', '18', '0.91', '147', 'N'), -- d4v41
		(109, 'MR22_LR2_05', '28', '0.91', '140', 'N'), -- Benkai
		(107, 'MR22_LR2_05', '18', '0.67', '168', 'N'), -- mindfreak

		-- LOUD vs OpTic 1
		-- LOUD (LOUD)
		(158, 'MR22_UF_01', '18', '0.83', '226', 'N'), -- aspas
		(22, 'MR22_UF_01', '35', '0.64', '156', 'N'), -- Sacy
		(157, 'MR22_UF_01', '26', '0.38', '113', 'N'), -- Less
		(156, 'MR22_UF_01', '35', '0.29', '113', 'N'), -- pANcada
		(23, 'MR22_UF_01', '29', '0.43', '112', 'N'), -- saadhak
		-- OpTic Gaming (OPTC)
		(160, 'MR22_UF_01', '33', '3.00', '372', 'Y'), -- Victor
		(159, 'MR22_UF_01', '13', '2.11', '335', 'N'), -- yay
		(161, 'MR22_UF_01', '41', '2.75', '188', 'N'), -- Marved
		(162, 'MR22_UF_01', '31', '1.50', '136', 'N'), -- FiNESSE
		(163, 'MR22_UF_01', '9', '0.78', '161', 'N'), -- crashies

		-- LOUD vs OpTic 2
		-- LOUD (LOUD)
		(157, 'MR22_UF_02', '24', '1.50', '262', 'N'), -- Less
		(156, 'MR22_UF_02', '40', '1.50', '206', 'N'), -- pANcada
		(23, 'MR22_UF_02', '13', '1.23', '238', 'N'), -- saadhak
		(158, 'MR22_UF_02', '29', '1.42', '203', 'N'), -- aspas
		(22, 'MR22_UF_02', '31', '0.67', '139', 'N'), -- Sacy
		-- OpTic Gaming (OPTC)
		(163, 'MR22_UF_02', '27', '1.36', '272', 'Y'), -- crashies
		(159, 'MR22_UF_02', '25', '1.00', '234', 'N'), -- yay
		(161, 'MR22_UF_02', '40', '0.73', '164', 'N'), -- Marved
		(160, 'MR22_UF_02', '18', '0.59', '140', 'N'), -- Victor
		(162, 'MR22_UF_02', '11', '0.50', '139', 'N'), -- FiNESSE

		-- LOUD vs OpTic 3
		-- LOUD (LOUD)
		(157, 'MR22_UF_03', '21', '2.54', '375', 'Y'), -- Less
		(22, 'MR22_UF_03', '29', '1.00', '171', 'N'), -- Sacy
		(23, 'MR22_UF_03', '26', '0.88', '195', 'N'), -- saadhak
		(156, 'MR22_UF_03', '31', '1.06', '199', 'N'), -- pANcada
		(158, 'MR22_UF_03', '32', '0.75', '154', 'N'), -- aspas
		-- OpTic Gaming (OPTC)
		(163, 'MR22_UF_03', '38', '1.13', '214', 'N'), -- crashies
		(161, 'MR22_UF_03', '31', '0.95', '253', 'N'), -- Marved
		(159, 'MR22_UF_03', '19', '0.94', '205', 'N'), -- yay
		(160, 'MR22_UF_03', '25', '0.63', '168', 'N'), -- Victor
		(162, 'MR22_UF_03', '20', '0.62', '157', 'N'), -- FiNESSE

		-- ZETA vs PRX 1
		-- ZETA DIVISION (ZETA)
		(142, 'MR22_LR3_01', '54', '1.29', '288', 'N'), -- TENNN
		(141, 'MR22_LR3_01', '21', '0.63', '153', 'N'), -- Dep
		(143, 'MR22_LR3_01', '57', '0.73', '139', 'N'), -- SugarZ3ro
		(116, 'MR22_LR3_01', '32', '0.65', '158', 'N'), -- Laz
		(117, 'MR22_LR3_01', '18', '0.36', '93', 'N'), -- crow
		-- Paper Rex (PRX)
		(155, 'MR22_LR3_01', '27', '2.20', '298', 'Y'), -- Jinggg
		(110, 'MR22_LR3_01', '31', '1.90', '269', 'N'), -- d4v41
		(109, 'MR22_LR3_01', '24', '1.36', '229', 'N'), -- Benkai
		(107, 'MR22_LR3_01', '27', '1.00', '159', 'N'), -- mindfreak
		(108, 'MR22_LR3_01', '17', '0.71', '172', 'N'), -- f0rsakeN

		-- ZETA vs PRX 2
		-- ZETA DIVISION (ZETA)
		(141, 'MR22_LR3_02', '28', '3.17', '302', 'Y'), -- Dep
		(143, 'MR22_LR3_02', '34', '2.17', '213', 'N'), -- SugarZ3ro
		(116, 'MR22_LR3_02', '19', '1.56', '290', 'N'), -- Laz
		(117, 'MR22_LR3_02', '29', '2.00', '234', 'N'), -- crow
		(142, 'MR22_LR3_02', '28', '1.29', '196', 'N'), -- TENNN
		-- Paper Rex (PRX)
		(109, 'MR22_LR3_02', '38', '0.71', '212', 'N'), -- Benkai
		(108, 'MR22_LR3_02', '25', '0.57', '191', 'N'), -- f0rsakeN
		(110, 'MR22_LR3_02', '19', '0.50', '125', 'N'), -- d4v41
		(155, 'MR22_LR3_02', '20', '0.54', '138', 'N'), -- Jinggg
		(107, 'MR22_LR3_02', '8', '0.21', '88', 'N'), -- mindfreak

		-- ZETA vs PRX 3
		-- ZETA DIVISION (ZETA)
		(143, 'MR22_LR3_03', '32', '1.71', '268', 'N'), -- SugarZ3ro
		(116, 'MR22_LR3_03', '22', '1.13', '212', 'N'), -- Laz
		(141, 'MR22_LR3_03', '27', '0.94', '175', 'N'), -- Dep
		(117, 'MR22_LR3_03', '21', '0.89', '210', 'N'), -- crow
		(142, 'MR22_LR3_03', '20', '0.74', '206', 'N'), -- TENNN
		-- Paper Rex (PRX)
		(108, 'MR22_LR3_03', '22', '1.47', '301', 'Y'), -- f0rsakeN
		(155, 'MR22_LR3_03', '17', '1.16', '263', 'N'), -- Jinggg
		(109, 'MR22_LR3_03', '28', '1.07', '161', 'N'), -- Benkai
		(110, 'MR22_LR3_03', '30', '0.76', '187', 'N'), -- d4v41
		(107, 'MR22_LR3_03', '14', '0.40', '118', 'N'), -- mindfreak

		-- OPTC vs ZETA 1
		-- OpTic Gaming (OPTC)
		(58, 'MR22_LF_01', '41', '2.19', '342', 'Y'), -- Marved
		(60, 'MR22_LF_01', '23', '1.05', '238', 'N'), -- yay
		(56, 'MR22_LF_01', '26', '0.82', '179', 'N'), -- crashies
		(59, 'MR22_LF_01', '22', '0.65', '147', 'N'), -- FiNESSE
		(57, 'MR22_LF_01', '21', '0.76', '177', 'N'), -- Victor
		-- ZETA DIVISION (ZETA)
		(143, 'MR22_LF_01', '29', '1.19', '234', 'N'), -- SugarZ3ro
		(141, 'MR22_LF_01', '32', '1.24', '246', 'N'), -- Dep
		(142, 'MR22_LF_01', '37', '1.00', '231', 'N'), -- TENNN
		(117, 'MR22_LF_01', '35', '0.79', '140', 'N'), -- crow
		(116, 'MR22_LF_01', '26', '0.59', '156', 'N'), -- Laz

		-- OPTC vs ZETA 2
		-- OpTic Gaming (OPTC)
		(57, 'MR22_LF_02', '36', '3.17', '260', 'N'), -- Victor
		(58, 'MR22_LF_02', '37', '1.13', '265', 'N'), -- Marved
		(60, 'MR22_LF_02', '29', '1.42', '263', 'N'), -- yay
		(56, 'MR22_LF_02', '29', '1.08', '201', 'N'), -- crashies
		(59, 'MR22_LF_02', '15', '0.55', '120', 'N'), -- FiNESSE
		-- ZETA DIVISION (ZETA)
		(142, 'MR22_LF_02', '18', '1.27', '295', 'Y'), -- TENNN
		(116, 'MR22_LF_02', '18', '1.00', '218', 'N'), -- Laz
		(117, 'MR22_LF_02', '17', '0.77', '158', 'N'), -- crow
		(143, 'MR22_LF_02', '42', '0.64', '153', 'N'), -- SugarZ3ro
		(141, 'MR22_LF_02', '25', '0.25', '72', 'N'), -- Dep

		-- OPTC vs ZETA 3
		-- OpTic Gaming (OPTC)
		(60, 'MR22_LF_03', '23', '1.73', '263', 'Y'), -- yay
		(58, 'MR22_LF_03', '24', '1.29', '228', 'N'), -- Marved
		(56, 'MR22_LF_03', '18', '1.27', '195', 'N'), -- crashies
		(59, 'MR22_LF_03', '29', '1.42', '222', 'N'), -- FiNESSE
		(57, 'MR22_LF_03', '24', '0.94', '196', 'N'), -- Victor
		-- ZETA DIVISION (ZETA)
		(143, 'MR22_LF_03', '27', '0.88', '224', 'N'), -- SugarZ3ro
		(117, 'MR22_LF_03', '30', '0.88', '189', 'N'), -- crow
		(142, 'MR22_LF_03', '19', '0.88', '213', 'N'), -- TENNN
		(116, 'MR22_LF_03', '20', '0.63', '135', 'N'), -- Laz
		(141, 'MR22_LF_03', '36', '0.59', '130', 'N'), -- Dep
        
		-- LOUD vs OPTC 1
		-- LOUD (LOUD)
		(158, 'MR22_GF_01', '38', '1.11', '240', 'N'), -- aspas
		(156, 'MR22_GF_01', '42', '1.06', '219', 'N'), -- pANcada
		(23,  'MR22_GF_01', '19', '0.84', '229', 'N'), -- saadhak
		(22,  'MR22_GF_01', '30', '0.67', '134', 'N'), -- Sacy
		(157, 'MR22_GF_01', '14', '0.39', '128', 'N'), -- Less
		-- OpTic Gaming (OPTC)
		(58, 'MR22_GF_01', '50', '1.38', '285', 'Y'), -- Marved
		(56, 'MR22_GF_01', '29', '1.55', '248', 'N'), -- crashies
		(60, 'MR22_GF_01', '26', '1.57', '251', 'N'), -- yay
		(59, 'MR22_GF_01', '19', '1.15', '183', 'N'), -- FiNESSE
		(57, 'MR22_GF_01', '15', '0.65', '148', 'N'), -- Victor

		-- LOUD vs OPTC 2
		-- LOUD (LOUD)
		(22,  'MR22_GF_02', '33', '1.53', '266', 'N'), -- Sacy
		(158, 'MR22_GF_02', '24', '1.38', '313', 'Y'), -- aspas
		(23,  'MR22_GF_02', '11', '0.67', '165', 'N'), -- saadhak
		(156, 'MR22_GF_02', '20', '0.65', '150', 'N'), -- pANcada
		(157, 'MR22_GF_02', '14', '0.62', '174', 'N'), -- Less
		-- OpTic Gaming (OPTC)
		(60, 'MR22_GF_02', '37', '1.67', '313', 'Y'), -- yay
		(57, 'MR22_GF_02', '18', '1.25', '274', 'N'), -- Victor
		(58, 'MR22_GF_02', '25', '1.10', '239', 'N'), -- Marved
		(59, 'MR22_GF_02', '29', '0.75', '174', 'N'), -- FiNESSE
		(56, 'MR22_GF_02', '29', '0.47', '89', 'N'), -- crashies

		-- LOUD vs OPTC 3
		-- LOUD (LOUD)
		(158, 'MR22_GF_03', '20', '1.42', '282', 'Y'), -- aspas
		(156, 'MR22_GF_03', '32', '1.10', '210', 'N'), -- pANcada
		(157, 'MR22_GF_03', '17', '1.05', '194', 'N'), -- Less
		(23,  'MR22_GF_03', '15', '0.95', '199', 'N'), -- saadhak
		(22,  'MR22_GF_03', '32', '0.50', '125', 'N'), -- Sacy
		-- OpTic Gaming (OPTC)
		(56, 'MR22_GF_03', '30', '1.56', '277', 'N'), -- crashies
		(60, 'MR22_GF_03', '25', '1.16', '230', 'N'), -- yay
		(58, 'MR22_GF_03', '33', '1.00', '206', 'N'), -- Marved
		(57, 'MR22_GF_03', '21', '0.76', '167', 'N'), -- Victor
		(59, 'MR22_GF_03', '34', '0.62', '137', 'N'); -- FiNESSE

SELECT * FROM player;
SELECT * FROM player_stats ps
JOIN player p ON ps.player_id = p.player_id;