CREATE SCHEMA IF NOT EXISTS vct;
USE vct;

SET SQL_SAFE_UPDATES = 0;

-- matches
DROP TABLE IF EXISTS matches;
CREATE TABLE matches (
    match_id VARCHAR(20) PRIMARY KEY,
    tournament_id VARCHAR(7) NOT NULL, 			
    match_date DATE,
    match_time TIME,
    bracket VARCHAR(50), 
    team1_id VARCHAR(4) NOT NULL, 
    team2_id VARCHAR(4) NOT NULL,
    map_winner_team_id VARCHAR(4),
    map_played VARCHAR(20),
    score VARCHAR(5), 
    mvp_player_id INT, 							
    
    CONSTRAINT FOREIGN KEY (tournament_id) REFERENCES Tournament(tournament_id),
    CONSTRAINT FOREIGN KEY (team1_id) REFERENCES team(team_id),
    CONSTRAINT FOREIGN KEY (team2_id) REFERENCES team(team_id),
    CONSTRAINT FOREIGN KEY (mvp_player_id) REFERENCES player(player_id), 	
    CONSTRAINT FOREIGN KEY (map_winner_team_id) REFERENCES team(team_id)
);

-- match_agent_picks
DROP TABLE IF EXISTS agent_pick;
CREATE TABLE agent_pick (
    match_id VARCHAR(20) NOT NULL,
    player_id INT NOT NULL, 					
    agent_name VARCHAR(20) NOT NULL,
    
    PRIMARY KEY (match_id, player_id), 			
    CONSTRAINT FOREIGN KEY (match_id) REFERENCES matches(match_id),
    CONSTRAINT FOREIGN KEY (player_id) REFERENCES player(player_id) 
);

INSERT INTO matches (match_id, tournament_id, match_date, match_time, bracket, team1_id, team2_id, map_winner_team_id, map_played, score, mvp_player_id)
VALUES	
		-- ==================================================
		--    TOURNAMENT: Masters Reykjavík 2021 (2021_M1) 
		-- ==================================================
		-- Upper Round 1 --
		-- FNC vs KRU
        ('MR21_UR1_01', '2021_M1', '2021-05-24', '23:00:00', 'Upper Round 1', 'FNC', 'KRU', 'FNC', 'Haven', '13-5', '20'),
        ('MR21_UR1_02', '2021_M1', '2021-05-25', '00:15:00', 'Upper Round 1', 'FNC', 'KRU', 'FNC', 'Icebox', '13-4', '20'),
        -- V1 vs CR
		('MR21_UR1_03', '2021_M1', '2021-05-25', '01:25:00', 'Upper Round 1', 'V1', 'CR', 'V1', 'Ascent', '13-11', '9'),
        ('MR21_UR1_04', '2021_M1', '2021-05-25', '02:45:00', 'Upper Round 1', 'V1', 'CR', 'V1', 'Icebox', '13-10', '6'),
        
		-- Upper QuarterFinals --
        -- SHK vs NU
		('MR21_UQF_01', '2021_M1', '2021-05-25', '04:45:00', 'Upper Quarterfinals', 'SHK', 'NU', 'SHK', 'Haven', '13-5', '35'),
		('MR21_UQF_02', '2021_M1', '2021-05-25', '05:55:00', 'Upper Quarterfinals', 'SHK', 'NU', 'NU', 'Bind', '5-13', '26'),
        ('MR21_UQF_03', '2021_M1', '2021-05-25', '06:45:00', 'Upper Quarterfinals', 'SHK', 'NU', 'NU', 'Ascent', '5-13', '27'),     
        -- VKS1 vs X10
		('MR21_UQF_04', '2021_M1', '2021-05-25', '23:00:00', 'Upper Quarterfinals', 'VKS1', 'X10', 'VKS1', 'Icebox', '13-11', '22'),
        ('MR21_UQF_05', '2021_M1', '2021-05-26', '00:30:00', 'Upper Quarterfinals', 'VKS1', 'X10', 'VKS1', 'Ascent', '14-12', '22'),        
        -- TL vs V1        
		('MR21_UQF_06', '2021_M1', '2021-05-26', '02:05:00', 'Upper Quarterfinals', 'TL', 'V1', 'TL', 'Split', '16-14', '11'),
        ('MR21_UQF_07', '2021_M1', '2021-05-26', '03:40:00', 'Upper Quarterfinals', 'TL', 'V1', 'V1', 'Ascent', '11-13', '6'),
        ('MR21_UQF_08', '2021_M1', '2021-05-26', '05:00:00', 'Upper Quarterfinals', 'TL', 'V1', 'V1', 'Haven', '4-13', '9'),	
        -- SEN vs FNC
        ('MR21_UQF_09', '2021_M1', '2021-05-26', '06:05:00', 'Upper Quarterfinals', 'SEN', 'FNC', 'SEN', 'Icebox', '13-11', '1'),
        ('MR21_UQF_10', '2021_M1', '2021-05-26', '07:25:00', 'Upper Quarterfinals', 'SEN', 'FNC', 'SEN', 'Haven', '13-10', '3'),
        
        -- Lower Round 1 --
        -- X10 vs CR
		('MR21_LR1_01', '2021_M1', '2021-05-26', '23:00:00', 'Lower Round 1', 'X10', 'CR', 'X10', 'Haven', '13-9', '47'),
		('MR21_LR1_02', '2021_M1', '2021-05-27', '00:15:00', 'Lower Round 1', 'X10', 'CR', 'X10', 'Icebox', '13-5', '50'),        
        -- SHK vs KRU
		('MR21_LR1_03', '2021_M1', '2021-05-27', '01:20:00', 'Lower Round 1', 'SHK', 'KRU', 'KRU', 'Icebox', '5-13', '37'),
		('MR21_LR1_04', '2021_M1', '2021-05-27', '02:35:00', 'Lower Round 1', 'SHK', 'KRU', 'KRU', 'Bind', '6-13', '40'),
		
		-- Upper SemiFinals --
        -- SEN vs VKS1
        ('MR21_USF_01', '2021_M1', '2021-05-27', '03:30:00', 'Upper SemiFinals', 'SEN', 'VKS1', 'SEN', 'Icebox', '13-7', '1'),
        ('MR21_USF_02', '2021_M1', '2021-05-27', '04:30:00', 'Upper SemiFinals', 'SEN', 'VKS1', 'SEN', 'Haven', '13-6', '3'),        
        -- V1 vs NU
        ('MR21_USF_03', '2021_M1', '2021-05-27', '23:00:00', 'Upper SemiFinals', 'V1', 'NU', 'V1', 'Haven', '13-3', '6'),
        ('MR21_USF_04', '2021_M1', '2021-05-27', '23:50:00', 'Upper SemiFinals', 'V1', 'NU', 'NU', 'Ascent', '13-15', '30'),
        ('MR21_USF_05', '2021_M1', '2021-05-28', '01:15:00', 'Upper SemiFinals', 'V1', 'NU', 'NU', 'Split', '12-14', '27'),
        
        -- Lower Round 2 --
        -- FNC vs X10
		('MR21_LR2_01', '2021_M1', '2021-05-28', '02:40:00', 'Lower Round 2', 'FNC', 'X10', 'FNC', 'Icebox', '13-4', '18'),
		('MR21_LR2_02', '2021_M1', '2021-05-28', '03:30:00', 'Lower Round 2', 'FNC', 'X10', 'FNC', 'Haven', '13-9', '17'),        
        -- TL vs KRU
		('MR21_LR2_03', '2021_M1', '2021-05-28', '04:45:00', 'Lower Round 2', 'TL', 'KRU', 'TL', 'Split', '13-2', '11'),
		('MR21_LR2_04', '2021_M1', '2021-05-28', '05:25:00', 'Lower Round 2', 'TL', 'KRU', 'TL', 'Ascent', '13-9', '11'),
        
        -- Lower Round 3 --
        -- V1 vs FNC
		('MR21_LR3_01', '2021_M1', '2021-05-28', '23:00:00', 'Lower Round 3', 'V1', 'FNC', 'FNC', 'Icebox', '12-14', '20'),
		('MR21_LR3_02', '2021_M1', '2021-05-29', '00:20:00', 'Lower Round 3', 'V1', 'FNC', 'FNC', 'Ascent', '6-13', '20'),        
        -- VKS1 vs TL
		('MR21_LR3_03', '2021_M1', '2021-05-29', '01:25:00', 'Lower Round 3', 'VKS1', 'TL', 'TL', 'Ascent', '8-13', '15'),
		('MR21_LR3_04', '2021_M1', '2021-05-29', '02:25:00', 'Lower Round 3', 'VKS1', 'TL', 'TL', 'Haven', '5-13', '15'),
        
        -- Upper Final --
        -- SEN vs NU
		('MR21_UF_01', '2021_M1', '2021-05-29', '03:30:00', 'Upper Final', 'SEN', 'NU', 'SEN', 'Bind', '13-5', '2'),
		('MR21_UF_02', '2021_M1', '2021-05-29', '04:30:00', 'Upper Final', 'SEN', 'NU', 'SEN', 'Haven', '13-4', '3'),
        
        -- Lower Round 4 --
        -- FNC vs TL
		('MR21_LR4_01', '2021_M1', '2021-05-30', '01:00:00', 'Lower Round 4', 'FNC', 'TL', 'FNC', 'Bind', '13-10', '17'),
		('MR21_LR4_02', '2021_M1', '2021-05-30', '02:15:00', 'Lower Round 4', 'FNC', 'TL', 'FNC', 'Ascent', '13-10', '19'),
        
        -- Lower Final --
        -- NU vs FNC
		('MR21_LF_01', '2021_M1', '2021-05-30', '03:30:00', 'Lower Final', 'NU', 'FNC', 'FNC', 'Bind', '8-13', '17'),
		('MR21_LF_02', '2021_M1', '2021-05-30', '04:25:00', 'Lower Final', 'NU', 'FNC', 'NU', 'Ascent', '13-8', '28'),
		('MR21_LF_03', '2021_M1', '2021-05-30', '05:15:00', 'Lower Final', 'NU', 'FNC', 'NU', 'Haven', '8-13', '20'),
        
        -- Grand Final --
        -- SEN vs FNC
		('MR21_GF_01', '2021_M1', '2021-05-31', '01:00:00', 'Grand Final', 'SEN', 'FNC', 'SEN', 'Split', '14-12', '3'),
		('MR21_GF_02', '2021_M1', '2021-05-31', '02:35:00', 'Grand Final', 'SEN', 'FNC', 'SEN', 'Bind', '16-14', '3'),
		('MR21_GF_03', '2021_M1', '2021-05-31', '03:50:00', 'Grand Final', 'SEN', 'FNC', 'SEN', 'Haven', '13-11', '3'),
        
		-- ===============================================
		--    TOURNAMENT: Masters Berlin 2021 (2021_M2) 
		-- ===============================================
        -- == GROUP STAGE ==
        -- Group A --
        -- Opening (A)
        -- SUP vs ACE
        ('MB21_OA_01', '2021_M2', '2021-09-10', '21:00:00', 'Opening (A)', 'SUP', 'ASC', 'ASC', 'Bind', '5-13', '74'),
        ('MB21_OA_02', '2021_M2', '2021-09-10', '22:10:00', 'Opening (A)', 'SUP', 'ASC', 'ASC', 'Ascent', '9-13', '74'),
        -- VS vs PRX
        ('MB21_OA_03', '2021_M2', '2021-09-11', '21:00:00', 'Opening (A)', 'VS', 'PRX', 'VS', 'Haven', '13-9', '63'),
        ('MB21_OA_04', '2021_M2', '2021-09-11', '22:15:00', 'Opening (A)', 'VS', 'PRX', 'VS', 'Icebox', '13-11', '64'),
        
        -- Winners A
        -- VS vs ACE
        ('MB21_WA_01', '2021_M2', '2021-09-13', '23:20:00', 'Winners (A)', 'VS', 'ACE', 'VS', 'Haven', '13-7', '64'),
        ('MB21_WA_02', '2021_M2', '2021-09-14', '00:35:00', 'Winners (A)', 'VS', 'ACE', 'VS', 'Icebox', '13-7', '65'),
        
        -- Elimination (A)
        -- PRX vs SUP
        ('MB21_EA_01', '2021_M2', '2021-09-15', '21:00:00', 'Elimination (A)', 'PRX', 'SUP', 'PRX', 'Haven', '14-12', '110'),
        ('MB21_EA_02', '2021_M2', '2021-09-15', '22:20:00', 'Elimination (A)', 'PRX', 'SUP', 'SUP', 'Breeze', '2-13', '84'),
        ('MB21_EA_03', '2021_M2', '2021-09-15', '23:15:00', 'Elimination (A)', 'PRX', 'SUP', 'SUP', 'Split', '10-13', '85'),
        
        -- Decider (A)
        -- ACE vs SUP
        ('MB21_DA_01', '2021_M2', '2021-09-16', '21:00:00', 'Decider (A)', 'ACE', 'SUP', 'SUP', 'Ascent', '6-13', '86'),
        ('MB21_DA_02', '2021_M2', '2021-09-16', '22:10:00', 'Decider (A)', 'ACE', 'SUP', 'ACE', 'Bind', '13-7', '74'),
        ('MB21_DA_03', '2021_M2', '2021-09-16', '23:10:00', 'Decider (A)', 'ACE', 'SUP', 'SUP', 'Split', '13-10', '84'),
        
        -- Group B --
        -- Opening (B)
        -- VKS2 vs NV
		('MB21_OB_01', '2021_M2', '2021-09-12', '02:15:00', 'Opening (B)', 'VKS2', 'NV', 'NV', 'Icebox', '13-15', '60'),
		('MB21_OB_02', '2021_M2', '2021-09-12', '03:30:00', 'Opening (B)', 'VKS2', 'NV', 'NV', 'Bind', '9-13', '60'),
        -- KRU vs ZETA
		('MB21_OB_03', '2021_M2', '2021-09-12', '21:00:00', 'Opening (B)', 'KRU', 'ZETA', 'KRU', 'Ascent', '13-8', '71'),
		('MB21_OB_04', '2021_M2', '2021-09-12', '22:05:00', 'Opening (B)', 'KRU', 'ZETA', 'ZETA', 'Split', '5-13', '119'),
		('MB21_OB_05', '2021_M2', '2021-09-12', '23:00:00', 'Opening (B)', 'KRU', 'ZETA', 'KRU', 'Bind', '13-7', '71'),
		
        -- Winners B
        -- NV vs KRU        
        ('MB21_WB_01', '2021_M2', '2021-09-13', '21:00:00', 'Winners (B)', 'NV', 'KRU', 'NV', 'Icebox', '13-9', '60'),
        ('MB21_WB_02', '2021_M2', '2021-09-13', '22:15:00', 'Winners (B)', 'NV', 'KRU', 'NV', 'Ascent', '13-9', '56'),
        
        -- Elimination (B)
        -- VKS2 vs ZETA
        ('MB21_EB_01', '2021_M2', '2021-09-14', '23:50:00', 'Elimination (B)', 'VKS2', 'ZETA', 'VKS2', 'Breeze', '13-3', '96'),
        ('MB21_EB_02', '2021_M2', '2021-09-15', '00:50:00', 'Elimination (B)', 'VKS2', 'ZETA', 'VKS2', 'Split', '13-4', '96'),
        
        -- Decider (B)
        -- KRU VS VKS2
        ('MB21_DB_01', '2021_M2', '2021-09-16', '03:50:00', 'Decider (B)', 'KRU', 'VKS2', 'KRU', 'Split', '13-11', '71'),
        ('MB21_DB_02', '2021_M2', '2021-09-16', '05:15:00', 'Decider (B)', 'KRU', 'VKS2', 'KRU', 'Haven', '13-11', '38'),
                
        -- Group C --
        -- Opening (C)
        -- 100T vs LBR
        ('MB21_OC_01', '2021_M2', '2021-09-11', '03:50:00', 'Opening (C)', '100T', 'LBR', '100T', 'Ascent', '13-3', '55'),
        ('MB21_OC_02', '2021_M2', '2021-09-11', '05:05:00', 'Opening (C)', '100T', 'LBR', '100T', 'Icebox', '13-6', '52'),
        -- GMB vs CR        
        ('MB21_OC_03', '2021_M2', '2021-09-12', '00:00:00', 'Opening (C)', 'GMB', 'CR', 'GMB', 'Bind', '13-1', '78'),
        ('MB21_OC_04', '2021_M2', '2021-09-12', '01:00:00', 'Opening (C)', 'GMB', 'CR', 'GMB', 'Icebox', '13-1', '81'),
        
        -- Winners C
        -- GMB vs 100T
        ('MB21_WC_01', '2021_M2', '2021-09-13', '04:35:00', 'Winners (C)', 'GMB', '100T', 'GMB', 'Ascent', '13-5', 77),
        ('MB21_WC_02', '2021_M2', '2021-09-13', '05:35:00', 'Winners (C)', 'GMB', '100T', '100T', 'Icebox', '11-13', 52),
        ('MB21_WC_03', '2021_M2', '2021-09-13', '06:55:00', 'Winners (C)', 'GMB', '100T', 'GMB', 'Ascent', '13-5', 81),
        
        -- Elimination (C)
        -- CR vs LBR
        ('MB21_EC_01', '2021_M2', '2021-09-15', '02:15:00', 'Elimination (C)', 'CR', 'LBR', 'CR', 'Haven', '13-9', '45'),
        ('MB21_EC_02', '2021_M2', '2021-09-15', '03:30:00', 'Elimination (C)', 'CR', 'LBR', 'CR', 'Split', '13-8', '114'),
        
        -- Decider (C)
        -- GMB vs CR
        ('MB21_DC_01', '2021_M2', '2021-09-17', '01:15:00', 'Decider (C)', 'GMB', 'CR', 'GMB', 'Ascent', '13-8', '78'),
        ('MB21_DC_02', '2021_M2', '2021-09-17', '02:45:00', 'Decider (C)', 'GMB', 'CR', 'GMB', 'Icebox', '14-12', '77'),
                        
        -- Group D --
        -- G2 vs F4Q
        ('MB21_GD_01', '2021_M2', '2021-09-11', '00:10:00', 'Group D', 'G2', 'F4Q', 'G2', 'Ascent', '13-5', '66'),
        ('MB21_GD_02', '2021_M2', '2021-09-11', '01:15:00', 'Group D', 'G2', 'F4Q', 'F4Q', 'Bind', '9-13', '97'),
        ('MB21_GD_03', '2021_M2', '2021-09-11', '02:25:00', 'Group D', 'G2', 'F4Q', 'G2', 'Haven', '13-8', '70'),
        -- SEN vs G2
        ('MB21_GD_04', '2021_M2', '2021-09-13', '00:50:00', 'Group D', 'SEN', 'G2', 'SEN', 'Split', '13-6', '1'),
        ('MB21_GD_05', '2021_M2', '2021-09-13', '01:45:00', 'Group D', 'SEN', 'G2', 'G2', 'Icebox', '8-13', '69'),
        ('MB21_GD_0', '2021_M2', '2021-09-13', '02:45:00', 'Group D', 'SEN', 'G2', 'SEN', 'Haven', '13-8', '2'),
        -- F4Q vs SEN
        ('MB21_GD_07', '2021_M2', '2021-09-14', '02:00:00', 'Group D', 'F4Q', 'SEN', 'SEN', 'Split', '9-13', '1'),
        ('MB21_GD_08', '2021_M2', '2021-09-14', '03:20:00', 'Group D', 'F4Q', 'SEN', 'SEN', 'Breeze', '4-13', '3'),
        -- F4Q vs G2
        ('MB21_GD_09', '2021_M2', '2021-09-14', '21:00:00', 'Group D', 'F4Q', 'G2', 'G2', 'Bind', '3-13', '70'),
        ('MB21_GD_10', '2021_M2', '2021-09-14', '22:05:00', 'Group D', 'F4Q', 'G2', 'G2', 'Ascent', '6-13', '69'),
        -- G2 vs SEN
        ('MB21_GD_11', '2021_M2', '2021-09-16', '01:00:00', 'Group D', 'G2', 'SEN', 'G2', 'Icebox', '13-3', '70'),
        ('MB21_GD_12', '2021_M2', '2021-09-16', '02:00:00', 'Group D', 'G2', 'SEN', 'G2', 'Split', '13-11', '68'),
        -- SEN vs F4Q
        ('MB21_GD_13', '2021_M2', '2021-09-17', '04:05:00', 'Group D', 'SEN', 'F4Q', 'SEN', 'Breeze', '13-3', '3'),
        ('MB21_GD_14', '2021_M2', '2021-09-17', '05:00:00', 'Group D', 'SEN', 'F4Q', 'F4Q', 'Split', '9-13', '101'),
        ('MB21_GD_15', '2021_M2', '2021-09-17', '06:10:00', 'Group D', 'SEN', 'F4Q', 'SEN', 'Haven', '13-4', '2'),
		
        -- == PLAYOFFS ==
        -- Quarterfinals --
        -- VS vs GMB
        ('MB21_QF_01', '2021_M2', '2021-09-17', '19:00:00', 'Quarterfinals', 'VS', 'GMB', 'GMB', 'Bind', '2-13', '78'),
        ('MB21_QF_02', '2021_M2', '2021-09-17', '19:55:00', 'Quarterfinals', 'VS', 'GMB', 'VS', 'Split', '13-7', '64'),
        ('MB21_QF_03', '2021_M2', '2021-09-17', '21:15:00', 'Quarterfinals', 'VS', 'GMB', 'GMB', 'Icebox', '8-13', '79'),
        -- G2 vs KRU
        ('MB21_QF_04', '2021_M2', '2021-09-17', '22:35:00', 'Quarterfinals', 'G2', 'KRU', 'G2', 'Icebox', '13-9', '70'),
        ('MB21_QF_05', '2021_M2', '2021-09-17', '23:55:00', 'Quarterfinals', 'G2', 'KRU', 'G2', 'Haven', '13-7', '70'),
        -- 100T vs ACE
        ('MB21_QF_06', '2021_M2', '2021-09-18', '01:15:00', 'Quarterfinals', '100T', 'ACE', 'ACE', 'Ascent', '9-13', '74'),
        ('MB21_QF_07', '2021_M2', '2021-09-18', '02:25:00', 'Quarterfinals', '100T', 'ACE', '100T', 'Haven', '13-8', '52'),
        ('MB21_QF_08', '2021_M2', '2021-09-18', '03:30:00', 'Quarterfinals', '100T', 'ACE', '100T', 'Breeze', '14-12', '52'),
        -- NV vs SEN
        ('MB21_QF_09', '2021_M2', '2021-09-18', '04:55:00', 'Quarterfinals', 'NV', 'SEN', 'NV', 'Haven', '15-13', '60'),
        ('MB21_QF_10', '2021_M2', '2021-09-18', '06:15:00', 'Quarterfinals', 'NV', 'SEN', 'NV', 'Split', '13-7', '60'),
        
        -- Semifinals --
        -- GMB vs G2
        ('MB21_SF_01', '2021_M2', '2021-09-19', '00:00:00', 'Semifinals', 'GMB', 'G2', 'GMB', 'Breeze', '13-10', '78'),
        ('MB21_SF_02', '2021_M2', '2021-09-19', '01:15:00', 'Semifinals', 'GMB', 'G2', 'GMB', 'Icebox', '13-0', '78'),
        -- 100T vs NV
        ('MB21_SF_03', '2021_M2', '2021-09-19', '02:35:00', 'Semifinals', '100T', 'NV', 'NV', 'Haven', '5-13', '60'),
        ('MB21_SF_04', '2021_M2', '2021-09-19', '03:35:00', 'Semifinals', '100T', 'NV', 'NV', 'Ascent', '8-13', '60'),
        
        -- Grand Final --
        -- NV vs GMB
        ('MB21_GF_01', '2021_M2', '2021-09-20', '00:00:00', 'Grand Final', 'NV', 'GMB', 'GMB', 'Bind', '13-15', '79'),
        ('MB21_GF_02', '2021_M2', '2021-09-20', '01:30:00', 'Grand Final', 'NV', 'GMB', 'GMB', 'Haven', '11-13', '79'),
        ('MB21_GF_03', '2021_M2', '2021-09-20', '02:40:00', 'Grand Final', 'NV', 'GMB', 'GMB', 'Split', '9-13', '79'),
        
        -- ===================================================
		--    TOURNAMENT: Valorant Champions 2021 (2021_C1) 
		-- ===================================================
		-- == GROUP STAGE ==
        -- Group A --
        -- Opening (A)
        -- NV vs X10 
		('VC21_OA_01', '2021_C1', '2021-12-04', '05:35:00', 'Opening (A)', 'NV', 'X10', 'NV', 'Breeze', '13-8', '60'),
		('VC21_OA_02', '2021_C1', '2021-12-04', '06:50:00', 'Opening (A)', 'NV', 'X10', 'NV', 'Ascent', '13-7', '60'),
		-- ACE vs VKS2 
		('VC21_OA_03', '2021_C1', '2021-12-05', '21:30:00', 'Opening (A)', 'ACE', 'VKS2', 'VKS2', 'Icebox', '9-13', '96'),
		('VC21_OA_04', '2021_C1', '2021-12-05', '23:00:00', 'Opening (A)', 'ACE', 'VKS2', 'ACE', 'Bind', '13-3', '72'),
		('VC21_OA_05', '2021_C1', '2021-12-06', '00:10:00', 'Opening (A)', 'ACE', 'VKS2', 'ACE', 'Breeze', '13-10', '74'),

		-- Winners (A)
		-- ACE vs NV (Acend wins 2-0 and qualifies for playoffs)
		('VC21_WA_01', '2021_C1', '2021-12-06', '22:00:00', 'Winners (A)', 'ACE', 'NV', 'ACE', 'Ascent', '13-8', '74'),
		('VC21_WA_02', '2021_C1', '2021-12-06', '23:25:00', 'Winners (A)', 'ACE', 'NV', 'ACE', 'Bind', '13-11', '72'),

		-- Elimination (A)
		-- VKS2 vs X10 (X10 Crit wins 2-0, VKS2 is eliminated)
		('VC21_EA_01', '2021_C1', '2021-12-07', '01:00:00', 'Elimination (A)', 'VKS2', 'X10', 'X10', 'Icebox', '6-13', '47'),
		('VC21_EA_02', '2021_C1', '2021-12-07', '02:15:00', 'Elimination (A)', 'VKS2', 'X10', 'X10', 'Haven', '5-13', '46'),

		-- Decider (A)
		-- NV vs X10 (X10 Crit wins 2-1 and qualifies for playoffs, NV is eliminated)
		('VC21_DA_01', '2021_C1', '2021-12-08', '05:00:00', 'Decider (A)', 'NV', 'X10', 'NV', 'Icebox', '13-10', '58'),
		('VC21_DA_02', '2021_C1', '2021-12-08', '06:25:00', 'Decider (A)', 'NV', 'X10', 'X10', 'Split', '8-13', '48'),
		('VC21_DA_03', '2021_C1', '2021-12-08', '07:40:00', 'Decider (A)', 'NV', 'X10', 'X10', 'Haven', '12-14', '47'),
        
        -- Group B --
		-- Opening (B)
		-- SEN vs FUR
		('VC21_OB_01', '2021_C1', '2021-12-03', '01:30:00', 'Opening (B)', 'SEN', 'FUR', 'SEN', 'Ascent', '13-9', '1'),
		('VC21_OB_02', '2021_C1', '2021-12-03', '02:55:00', 'Opening (B)', 'SEN', 'FUR', 'FUR', 'Breeze', '10-13', '128'),
		('VC21_OB_03', '2021_C1', '2021-12-03', '04:15:00', 'Opening (B)', 'SEN', 'FUR', 'SEN', 'Haven', '13-9', '3'),
		-- KRU vs TL 
		('VC21_OB_04', '2021_C1', '2021-12-03', '05:45:00', 'Opening (B)', 'KRU', 'TL', 'TL', 'Haven', '5-13', '123'),
		('VC21_OB_05', '2021_C1', '2021-12-03', '06:55:00', 'Opening (B)', 'KRU', 'TL', 'TL', 'Ascent', '8-13', '11'),

		-- Winners (B)
		-- TL vs SEN 
		('VC21_WB_01', '2021_C1', '2021-12-05', '03:00:00', 'Winners (B)', 'TL', 'SEN', 'TL', 'Breeze', '14-12', '123'),
		('VC21_WB_02', '2021_C1', '2021-12-05', '04:30:00', 'Winners (B)', 'TL', 'SEN', 'SEN', 'Bind', '2-13', '3'),
		('VC21_WB_03', '2021_C1', '2021-12-05', '05:35:00', 'Winners (B)', 'TL', 'SEN', 'TL', 'Split', '13-10', '11'),

		-- Elimination (B)
		-- KRU vs FUR 
		('VC21_EB_01', '2021_C1', '2021-12-06', '01:35:00', 'Elimination (B)', 'KRU', 'FUR', 'FUR', 'Fracture', '11-13', '130'),
		('VC21_EB_02', '2021_C1', '2021-12-06', '03:15:00', 'Elimination (B)', 'KRU', 'FUR', 'KRU', 'Ascent', '13-8', '71'),
		('VC21_EB_03', '2021_C1', '2021-12-06', '04:30:00', 'Elimination (B)', 'KRU', 'FUR', 'KRU', 'Haven', '13-9', '39'),

		-- Decider (B)
		-- SEN vs KRU 
		('VC21_DB_01', '2021_C1', '2021-12-07', '03:40:00', 'Decider (B)', 'SEN', 'KRU', 'SEN', 'Fracture', '13-7', '1'),
		('VC21_DB_02', '2021_C1', '2021-12-07', '05:00:00', 'Decider (B)', 'SEN', 'KRU', 'KRU', 'Haven', '11-13', '36'),
		('VC21_DB_03', '2021_C1', '2021-12-07', '06:20:00', 'Decider (B)', 'SEN', 'KRU', 'KRU', 'Split', '11-13', '71'),
        
        -- Group C --
		-- Opening (C)
		-- VKS1 vs CR
		('VC21_OC_01', '2021_C1', '2021-12-02', '01:00:00', 'Opening (C)', 'VKS1', 'CR', 'VKS1', 'Icebox', '13-9', '22'),
		('VC21_OC_02', '2021_C1', '2021-12-02', '02:25:00', 'Opening (C)', 'VKS1', 'CR', 'VKS1', 'Haven', '13-8', '23'),
		-- GMB vs TS 
		('VC21_OC_03', '2021_C1', '2021-12-02', '22:00:00', 'Opening (C)', 'GMB', 'TS', 'TS', 'Icebox', '6-13', '105'),
		('VC21_OC_04', '2021_C1', '2021-12-02', '23:35:00', 'Opening (C)', 'GMB', 'TS', 'GMB', 'Breeze', '13-0', '81'),
		('VC21_OC_05', '2021_C1', '2021-12-03', '00:25:00', 'Opening (C)', 'GMB', 'TS', 'GMB', 'Bind', '13-6', '78'),

		-- Winners (C)
		-- GMB vs VKS1 
		('VC21_WC_01', '2021_C1', '2021-12-04', '23:00:00', 'Winners (C)', 'GMB', 'VKS1', 'GMB', 'Split', '13-6', '77'),
		('VC21_WC_02', '2021_C1', '2021-12-05', '00:25:00', 'Winners (C)', 'GMB', 'VKS1', 'VKS1', 'Bind', '5-13', '23'),
		('VC21_WC_03', '2021_C1', '2021-12-05', '01:40:00', 'Winners (C)', 'GMB', 'VKS1', 'GMB', 'Icebox', '14-12', '81'),

		-- Elimination (C)
		-- TS vs CR 
		('VC21_EC_01', '2021_C1', '2021-12-05', '23:00:00', 'Elimination (C)', 'TS', 'CR', 'TS', 'Split', '13-5', '106'),
		('VC21_EC_02', '2021_C1', '2021-12-06', '00:15:00', 'Elimination (C)', 'TS', 'CR', 'TS', 'Haven', '13-2', '103'),

		-- Decider (C)
		-- VKS1 vs TS 
		('VC21_DC_01', '2021_C1', '2021-12-08', '02:15:00', 'Decider (C)', 'VKS1', 'TS', 'TS', 'Haven', '6-13', '105'),
		('VC21_DC_02', '2021_C1', '2021-12-08', '03:40:00', 'Decider (C)', 'VKS1', 'TS', 'TS', 'Icebox', '7-13', '102'),
        
        -- Group D --
		-- Opening (D)
		-- VS vs FS 
		('VC21_OD_01', '2021_C1', '2021-12-01', '22:00:00', 'Opening (D)', 'VS', 'FS', 'VS', 'Haven', '13-5', '61'),
		('VC21_OD_02', '2021_C1', '2021-12-01', '23:25:00', 'Opening (D)', 'VS', 'FS', 'VS', 'Breeze', '13-5', '64'),
		-- FNC vs C9
		('VC21_OD_03', '2021_C1', '2021-12-02', '03:45:00', 'Opening (D)', 'FNC', 'C9', 'FNC', 'Icebox', '13-11', '20'),
		('VC21_OD_04', '2021_C1', '2021-12-02', '05:10:00', 'Opening (D)', 'FNC', 'C9', 'C9', 'Split', '11-13', '125'),
		('VC21_OD_05', '2021_C1', '2021-12-02', '06:30:00', 'Opening (D)', 'FNC', 'C9', 'FNC', 'Fracture', '14-12', '20'),

		-- Winners (D)
		-- VS vs FNC 
		('VC21_WD_01', '2021_C1', '2021-12-04', '01:55:00', 'Winners (D)', 'VS', 'FNC', 'FNC', 'Icebox', '10-13', '20'),
		('VC21_WD_02', '2021_C1', '2021-12-04', '03:35:00', 'Winners (D)', 'VS', 'FNC', 'VS', 'Haven', '13-10', '61'),
		('VC21_WD_03', '2021_C1', '2021-12-04', '04:50:00', 'Winners (D)', 'VS', 'FNC', 'FNC', 'Fracture', '6-13', '20'),

		-- Elimination (D)
		-- FS vs C9
		('VC21_ED_01', '2021_C1', '2021-12-06', '05:30:00', 'Elimination (D)', 'FS', 'C9', 'C9', 'Split', '7-13', '127'),
		('VC21_ED_02', '2021_C1', '2021-12-06', '06:55:00', 'Elimination (D)', 'FS', 'C9', 'C9', 'Breeze', '12-14', '127'),

		-- Decider (D)
		-- VS vs C9 
		('VC21_DD_01', '2021_C1', '2021-12-07', '22:00:00', 'Decider (D)', 'VS', 'C9', 'C9', 'Ascent', '10-13', '127'),
		('VC21_DD_02', '2021_C1', '2021-12-07', '23:25:00', 'Decider (D)', 'VS', 'C9', 'VS', 'Split', '13-9', '64'),
		('VC21_DD_03', '2021_C1', '2021-12-08', '00:40:00', 'Decider (D)', 'VS', 'C9', 'C9', 'Breeze', '11-13', '125'),
        
        -- == PLAYOFFS ==
        -- Quarterfinals
		-- ACE vs TS 
		('VC21_QF_01', '2021_C1', '2021-12-09', '01:00:00', 'Quarterfinals', 'ACE', 'TS', 'ACE', 'Icebox', '13-8', '74'),
		('VC21_QF_02', '2021_C1', '2021-12-09', '02:25:00', 'Quarterfinals', 'ACE', 'TS', 'ACE', 'Breeze', '13-6', '74'),
		-- TL vs C9
		('VC21_QF_03', '2021_C1', '2021-12-09', '04:00:00', 'Quarterfinals', 'TL', 'C9', 'TL', 'Bind', '13-10', '11'),
		('VC21_QF_04', '2021_C1', '2021-12-09', '05:35:00', 'Quarterfinals', 'TL', 'C9', 'TL', 'Ascent', '13-11', '11'),
		-- GMB vs X10 
		('VC21_QF_05', '2021_C1', '2021-12-10', '01:00:00', 'Quarterfinals', 'GMB', 'X10', 'GMB', 'Fracture', '13-7', '77'),
		('VC21_QF_06', '2021_C1', '2021-12-10', '02:25:00', 'Quarterfinals', 'GMB', 'X10', 'X10', 'Ascent', '7-13', '46'),
		('VC21_QF_07', '2021_C1', '2021-12-10', '03:35:00', 'Quarterfinals', 'GMB', 'X10', 'GMB', 'Breeze', '13-7', '79'),
		-- FNC vs KRU
		('VC21_QF_08', '2021_C1', '2021-12-10', '04:40:00', 'Quarterfinals', 'FNC', 'KRU', 'KRU', 'Haven', '13-15', '38'),
		('VC21_QF_09', '2021_C1', '2021-12-10', '06:25:00', 'Quarterfinals', 'FNC', 'KRU', 'FNC', 'Icebox', '13-6', '20'),
		('VC21_QF_10', '2021_C1', '2021-12-10', '07:35:00', 'Quarterfinals', 'FNC', 'KRU', 'KRU', 'Split', '8-13', '71'),

		-- Semifinals --
		-- ACE vs TL 
		('VC21_SF_01', '2021_C1', '2021-12-12', '01:00:00', 'Semifinals', 'ACE', 'TL', 'ACE', 'Bind', '13-6', '72'),
		('VC21_SF_02', '2021_C1', '2021-12-12', '02:25:00', 'Semifinals', 'ACE', 'TL', 'ACE', 'Split', '13-5', '73'),
		-- GMB vs KRU 
		('VC21_SF_03', '2021_C1', '2021-12-12', '04:00:00', 'Semifinals', 'GMB', 'KRU', 'GMB', 'Breeze', '13-8', '79'),
		('VC21_SF_04', '2021_C1', '2021-12-12', '05:50:00', 'Semifinals', 'GMB', 'KRU', 'KRU', 'Ascent', '7-13', '40'),
		('VC21_SF_05', '2021_C1', '2021-12-12', '07:05:00', 'Semifinals', 'GMB', 'KRU', 'GMB', 'Bind', '18-16', '79'),

		-- Grand Final --
		-- ACE vs GMB 
		('VC21_GF_01', '2021_C1', '2021-12-13', '01:30:00', 'Grand Final', 'ACE', 'GMB', 'GMB', 'Breeze', '11-13', '78'),
		('VC21_GF_02', '2021_C1', '2021-12-13', '03:05:00', 'Grand Final', 'ACE', 'GMB', 'ACE', 'Ascent', '13-7', '76'),
		('VC21_GF_03', '2021_C1', '2021-12-13', '04:15:00', 'Grand Final', 'ACE', 'GMB', 'GMB', 'Fracture', '3-13', '78'),
		('VC21_GF_04', '2021_C1', '2021-12-13', '05:15:00', 'Grand Final', 'ACE', 'GMB', 'ACE', 'Icebox', '14-12', '74'),
		('VC21_GF_05', '2021_C1', '2021-12-13', '06:35:00', 'Grand Final', 'ACE', 'GMB', 'ACE', 'Split', '13-8', '74');
        
        
DROP TABLE IF EXISTS agent_pick;
INSERT INTO agent_pick (match_id, player_id, agent_name)
VALUES	
		-- ==================================================
		--    TOURNAMENT: Masters Reykjavík 2021 (2021_M1) 
		-- ==================================================
		-- Upper Round 1 --
		-- FNC vs KRU
        -- Match 1
        -- FNATIC (FNC)
        ('MR21_UR1_01', '16', 'Astra'),		-- Boaster
        ('MR21_UR1_01', '17', 'Sage'),		-- doma
        ('MR21_UR1_01', '18', 'Skye'),		-- Mistic
        ('MR21_UR1_01', '19', 'Killjoy'),	-- MAGNUM
        ('MR21_UR1_01', '20', 'Jett'),		-- Derke
        -- KRU Esports (KRU)
		('MR21_UR1_01', '36', 'Sage'),		-- NagZ
        ('MR21_UR1_01', '37', 'Skye'),		-- bnj
        ('MR21_UR1_01', '38', 'Astra'),		-- delz1k
        ('MR21_UR1_01', '39', 'Killjoy'),	-- Klaus
        ('MR21_UR1_01', '40', 'Viper'),		-- Mazino
        
        -- Match 2
        -- FNATIC (FNC)
        ('MR21_UR1_02', '16', 'Sova'),		-- Boaster
        ('MR21_UR1_02', '17', 'Sage'),		-- doma
        ('MR21_UR1_02', '18', 'Viper'),		-- Mistic
        ('MR21_UR1_02', '19', 'Killjoy'),	-- MAGNUM
        ('MR21_UR1_02', '20', 'Jett'),		-- Derke
        -- KRU Esports (KRU)
		('MR21_UR1_02', '36', 'Jett'),		-- NagZ
        ('MR21_UR1_02', '37', 'Sova'),		-- bnj
        ('MR21_UR1_02', '38', 'Sage'),		-- delz1k
        ('MR21_UR1_02', '39', 'Killjoy'),	-- Klaus
        ('MR21_UR1_02', '40', 'Viper'),		-- Mazino

		-- V1 vs CR
        -- Match 3
        -- Version1 (V1)
		('MR21_UR1_03', '6', 'Jett'),		-- penny
        ('MR21_UR1_03', '7', 'Killjoy'),	-- jammyz
        ('MR21_UR1_03', '8', 'Sova'),		-- effys
        ('MR21_UR1_03', '9', 'Phoenix'),	-- Zellsis
        ('MR21_UR1_03', '10', 'Astra'),		-- vanity
        -- Crazy Raccoon (CR)
        ('MR21_UR1_03', '41', 'Raze'),		-- Munchkin
        ('MR21_UR1_03', '42', 'Jett'),		-- zepher
        ('MR21_UR1_03', '43', 'Astra'),		-- rion
        ('MR21_UR1_03', '44', 'Sova'),		-- Medusa
        ('MR21_UR1_03', '45', 'Killjoy'),	-- neth
                
        -- Match 4
        -- Version1 (V1)
		('MR21_UR1_04', '6', 'Jett'),		-- penny
        ('MR21_UR1_04', '7', 'Viper'),		-- jammyz
        ('MR21_UR1_04', '8', 'Sova'),		-- effys
        ('MR21_UR1_04', '9', 'Phoenix'),	-- Zellsis
        ('MR21_UR1_04', '10', 'Omen'),		-- vanity
        -- Crazy Raccoon (CR)
        ('MR21_UR1_04', '41', 'Raze'),		-- Munchkin
        ('MR21_UR1_04', '42', 'Jett'),		-- zepher
        ('MR21_UR1_04', '43', 'Omen'),		-- rion
        ('MR21_UR1_04', '44', 'Sova'),		-- Medusa
        ('MR21_UR1_04', '45', 'Killjoy'),	-- neth
        
        -- Upper QuarterFinals --
		-- SHK vs NU
        -- Match 1
        -- Sharks Esports (SHK)
        ('MR21_UQF_01', '31', 'Killjoy'),	-- fra
        ('MR21_UQF_01', '32', 'Omen'),		-- light
        ('MR21_UQF_01', '33', 'Raze'),		-- prozin
        ('MR21_UQF_01', '34', 'Sova'),		-- deNaro
        ('MR21_UQF_01', '35', 'Sage'),		-- gaabxx
        -- NUTURN (NU)
        ('MR21_UQF_01', '26', 'Astra'),		-- peri
        ('MR21_UQF_01', '27', 'Sova'),		-- Lakia
        ('MR21_UQF_01', '28', 'Jett'),		-- allow
        ('MR21_UQF_01', '29', 'Raze'),		-- Suggest
        ('MR21_UQF_01', '30', 'Breach'),	-- solo
        
        -- Match 2
        -- Sharks Esports (SHK)
        ('MR21_UQF_02', '31', 'Skye'),		-- fra
        ('MR21_UQF_02', '32', 'Brimstone'),	-- light
        ('MR21_UQF_02', '33', 'Raze'),		-- prozin
        ('MR21_UQF_02', '34', 'Sova'),		-- deNaro
        ('MR21_UQF_02', '35', 'Viper'),		-- gaabxx
        -- NUTURN (NU)
        ('MR21_UQF_02', '26', 'Omen'),		-- peri
        ('MR21_UQF_02', '27', 'Sova'),		-- Lakia
        ('MR21_UQF_02', '28', 'Jett'),		-- allow
        ('MR21_UQF_02', '29', 'Raze'),		-- Suggest
        ('MR21_UQF_02', '30', 'Breach'),	-- solo
        
        -- Match 3
        -- Sharks Esports (SHK)
        ('MR21_UQF_03', '31', 'Killjoy'),	-- fra
        ('MR21_UQF_03', '32', 'Omen'),		-- light
        ('MR21_UQF_03', '33', 'Phoenix'),	-- prozin
        ('MR21_UQF_03', '34', 'Sova'),		-- deNaro
        ('MR21_UQF_03', '35', 'Raze'),		-- gaabxx
        -- NUTURN (NU)
        ('MR21_UQF_03', '26', 'Astra'),		-- peri
        ('MR21_UQF_03', '27', 'Sova'),		-- Lakia
        ('MR21_UQF_03', '28', 'Jett'),		-- allow
        ('MR21_UQF_03', '29', 'Skye'),		-- Suggest
        ('MR21_UQF_03', '30', 'Killjoy'),	-- solo
        
        -- VKS1 vs X10
        -- Match 4
        -- Team Vikings (VKS1)
        ('MR21_UQF_04', '21', 'Jett'),		-- frz
        ('MR21_UQF_04', '22', 'Sova'),		-- Sacy
        ('MR21_UQF_04', '23', 'Killjoy'),	-- saadhak
        ('MR21_UQF_04', '24', 'Raze'),		-- gtn
        ('MR21_UQF_04', '25', 'Omen'),		-- sutecas
        -- X10 Esports (X10)
        ('MR21_UQF_04', '46', 'Sova'),		-- foxz
        ('MR21_UQF_04', '47', 'Jett'),		-- Patiphan
        ('MR21_UQF_04', '48', 'Cypher'),	-- Sushiboys
        ('MR21_UQF_04', '49', 'Skye'),		-- Crws
        ('MR21_UQF_04', '50', 'Viper'),		-- sScary
        
        -- Match 5
        -- Team Vikings (VKS1)
        ('MR21_UQF_05', '21', 'Phoenix'),	-- frz
        ('MR21_UQF_05', '22', 'Sova'),		-- Sacy
        ('MR21_UQF_05', '23', 'Killjoy'),	-- saadhak
        ('MR21_UQF_05', '24', 'Raze'),		-- gtn
        ('MR21_UQF_05', '25', 'Omen'),		-- sutecas
        -- X10 Esports (X10)
        ('MR21_UQF_05', '46', 'Sova'),		-- foxz
        ('MR21_UQF_05', '47', 'Sage'),		-- Patiphan
        ('MR21_UQF_05', '48', 'Killjoy'),	-- Sushiboys
        ('MR21_UQF_05', '49', 'Skye'),		-- Crws
        ('MR21_UQF_05', '50', 'Astra'),		-- sScary
        
        -- TL vs V1
        -- Match 6
        -- Team Liquid (TL)
        ('MR21_UQF_06', '11', 'Sage'),		-- ScreaM
        ('MR21_UQF_06', '12', 'Viper'),		-- Kryptix
        ('MR21_UQF_06', '13', 'Brimstone'),	-- L1NK
        ('MR21_UQF_06', '14', 'Skye'),		-- soulcas
        ('MR21_UQF_06', '15', 'Jett'),		-- Jamppi
        -- Version1 (V1)
		('MR21_UQF_06', '6', 'Jett'),		-- penny
        ('MR21_UQF_06', '7', 'Viper'),		-- jammyz
        ('MR21_UQF_06', '8', 'Sage'),		-- effys
        ('MR21_UQF_06', '9', 'Killjoy'),	-- Zellsis
        ('MR21_UQF_06', '10', 'Astra'),		-- vanity
        
		-- Match 7
        -- Team Liquid (TL)
        ('MR21_UQF_07', '11', 'Phoenix'),	-- ScreaM
        ('MR21_UQF_07', '12', 'Killjoy'),	-- Kryptix
        ('MR21_UQF_07', '13', 'Omen'),		-- L1NK
        ('MR21_UQF_07', '14', 'Sova'),		-- soulcas
        ('MR21_UQF_07', '15', 'Jett'),		-- Jamppi
        -- Version1 (V1)
		('MR21_UQF_07', '6', 'Jett'),		-- penny
        ('MR21_UQF_07', '7', 'Viper'),		-- jammyz
        ('MR21_UQF_07', '8', 'Sova'),		-- effys
        ('MR21_UQF_07', '9', 'Killjoy'),	-- Zellsis
        ('MR21_UQF_07', '10', 'Astra'),		-- vanity
        
        -- Match 8
        -- TL vs V1
        -- Team Liquid (TL)
        ('MR21_UQF_08', '11', 'Sage'),		-- ScreaM
        ('MR21_UQF_08', '12', 'Viper'),		-- Kryptix
        ('MR21_UQF_08', '13', 'Brimstone'),	-- L1NK
        ('MR21_UQF_08', '14', 'Skye'),		-- soulcas
        ('MR21_UQF_08', '15', 'Killjoy'),	-- Jamppi
        -- Version1 (V1)
		('MR21_UQF_08', '6', 'Jett'),		-- penny
        ('MR21_UQF_08', '7', 'Viper'),		-- jammyz
        ('MR21_UQF_08', '8', 'Sova'),		-- effys
        ('MR21_UQF_08', '9', 'Killjoy'),	-- Zellsis
        ('MR21_UQF_08', '10', 'Astra'),		-- vanity
        
        -- SEN vs FNC
        -- Match 9
		-- Sentinels (SEN)
        ('MR21_UQF_09', '1', 'Jett'),		-- ShahZam
        ('MR21_UQF_09', '2', 'Sova'),		-- SicK
        ('MR21_UQF_09', '3', 'Reyna'),		-- TenZ
        ('MR21_UQF_09', '4', 'Viper'),		-- zombs
        ('MR21_UQF_09', '5', 'Sage'),		-- dapr
        -- FNATIC (FNC)
        ('MR21_UR1_09', '16', 'Sova'),		-- Boaster
        ('MR21_UR1_09', '17', 'Sage'),		-- doma
        ('MR21_UR1_09', '18', 'Viper'),		-- Mistic
        ('MR21_UR1_09', '19', 'Killjoy'),	-- MAGNUM
        ('MR21_UR1_09', '20', 'Jett'),		-- Derke
        
        -- Match 10
		-- Sentinels (SEN)
        ('MR21_UQF_10', '1', 'Sova'),		-- ShahZam
        ('MR21_UQF_10', '2', 'Phoenix'),	-- SicK
        ('MR21_UQF_10', '3', 'Jett'),		-- TenZ
        ('MR21_UQF_10', '4', 'Astra'),		-- zombs
        ('MR21_UQF_10', '5', 'Cypher'),		-- dapr
        -- FNATIC (FNC)
        ('MR21_UR1_10', '16', 'Astra'),		-- Boaster
        ('MR21_UR1_10', '17', 'Sage'),		-- doma
        ('MR21_UR1_10', '18', 'Skye'),		-- Mistic
        ('MR21_UR1_10', '19', 'Killjoy'),	-- MAGNUM
        ('MR21_UR1_10', '20', 'Jett'),		-- Derke
        
        -- Lower Round 1 --
		-- X10 vs CR
        -- Match 1
        -- X10 Esports (X10)
        ('MR21_LR1_01', '46', 'Jett'),		-- foxz
        ('MR21_LR1_01', '47', 'Viper'),		-- Patiphan
        ('MR21_LR1_01', '48', 'Killjoy'),	-- Sushiboys
        ('MR21_LR1_01', '49', 'Skye'),		-- Crws
        ('MR21_LR1_01', '50', 'Astra'),		-- sScary
        -- Crazy Raccoon (CR)
		('MR21_LR1_01', '41', 'Phoenix'),	-- Munchkin
        ('MR21_LR1_01', '42', 'Jett'),		-- zepher
        ('MR21_LR1_01', '43', 'Astra'),		-- rion
        ('MR21_LR1_01', '44', 'Sova'),		-- Medusa
        ('MR21_LR1_01', '45', 'Killjoy'),	-- neth
        
        -- Match 2
		-- X10 Esports (X10)
        ('MR21_LR1_02', '46', 'Sova'),		-- foxz
        ('MR21_LR1_02', '47', 'Jett'),		-- Patiphan
        ('MR21_LR1_02', '48', 'Cypher'),	-- Sushiboys
        ('MR21_LR1_02', '49', 'Breach'),	-- Crws
        ('MR21_LR1_02', '50', 'Viper'),		-- sScary
        -- Crazy Raccoon (CR)
		('MR21_LR1_02', '41', 'Sage'),		-- Munchkin
        ('MR21_LR1_02', '42', 'Jett'),		-- zepher
        ('MR21_LR1_02', '43', 'Viper'),		-- rion
        ('MR21_LR1_02', '44', 'Sova'),		-- Medusa
        ('MR21_LR1_02', '45', 'Killjoy'),	-- neth
        
        -- SHK vs KRU
        -- Match 3
        -- Sharks Esports (SHK)
        ('MR21_LR1_03', '31', 'Sage'),		-- fra
        ('MR21_LR1_03', '32', 'Omen'),		-- light
        ('MR21_LR1_03', '33', 'Raze'),		-- prozin
        ('MR21_LR1_03', '34', 'Sova'),		-- deNaro
        ('MR21_LR1_03', '35', 'Jett'),		-- gaabxx
        -- KRU Esports (KRU)
		('MR21_UR1_03', '36', 'Jett'),		-- NagZ
        ('MR21_UR1_03', '37', 'Sova'),		-- bnj
        ('MR21_UR1_03', '38', 'Sage'),		-- delz1k
        ('MR21_UR1_03', '39', 'Killjoy'),	-- Klaus
        ('MR21_UR1_03', '40', 'Viper'),		-- Mazino
        
        -- Match 4
        -- Sharks Esports (SHK)
        ('MR21_LR1_04', '31', 'Skye'),		-- fra
        ('MR21_LR1_04', '32', 'Brimstone'),	-- light
        ('MR21_LR1_04', '33', 'Raze'),		-- prozin
        ('MR21_LR1_04', '34', 'Sova'),		-- deNaro
        ('MR21_LR1_04', '35', 'Viper'),		-- gaabxx
        -- KRU Esports (KRU)
		('MR21_LR1_04', '36', 'Sage'),		-- NagZ
        ('MR21_LR1_04', '37', 'Raze'),		-- bnj
        ('MR21_LR1_04', '38', 'Brimstone'),	-- delz1k
        ('MR21_LR1_04', '39', 'Skye'),		-- Klaus
        ('MR21_LR1_04', '40', 'Viper'),		-- Mazino
        
        -- Upper SemiFinals -- 
        -- SEN vs VKS1
        -- Match 1
		-- Sentinels (SEN)
        ('MR21_USF_01', '1', 'Jett'),		-- ShahZam
        ('MR21_USF_01', '2', 'Sova'),		-- SicK
        ('MR21_USF_01', '3', 'Reyna'),		-- TenZ
        ('MR21_USF_01', '4', 'Viper'),		-- zombs
        ('MR21_USF_01', '5', 'Sage'),		-- dapr
		-- Team Vikings (VKS1)
        ('MR21_USF_01', '21', 'Jett'),		-- frz
        ('MR21_USF_01', '22', 'Sova'),		-- Sacy
        ('MR21_USF_01', '23', 'Killjoy'),	-- saadhak
        ('MR21_USF_01', '24', 'Raze'),		-- gtn
        ('MR21_USF_01', '25', 'Omen'),		-- sutecas
        
		-- Match 2
		-- Sentinels (SEN)
        ('MR21_USF_02', '1', 'Sova'),		-- ShahZam
        ('MR21_USF_02', '2', 'Phoenix'),	-- SicK
        ('MR21_USF_02', '3', 'Jett'),		-- TenZ
        ('MR21_USF_02', '4', 'Astra'),		-- zombs
        ('MR21_USF_02', '5', 'Cypher'),		-- dapr
		-- Team Vikings (VKS1)
        ('MR21_USF_02', '21', 'Phoenix'),	-- frz
        ('MR21_USF_02', '22', 'Sova'),		-- Sacy
        ('MR21_USF_02', '23', 'Cypher'),	-- saadhak
        ('MR21_USF_02', '24', 'Raze'),		-- gtn
        ('MR21_USF_02', '25', 'Astra'),		-- sutecas
        
        -- V1 vs NU
        -- Match 3
        -- Version1 (V1)
		('MR21_USF_03', '6', 'Jett'),		-- penny
        ('MR21_USF_03', '7', 'Viper'),		-- jammyz
        ('MR21_USF_03', '8', 'Sova'),		-- effys
        ('MR21_USF_03', '9', 'Killjoy'),	-- Zellsis
        ('MR21_USF_03', '10', 'Astra'),		-- vanity
        -- NUTURN (NU)
        ('MR21_USF_03', '26', 'Astra'),		-- peri
        ('MR21_USF_03', '27', 'Sova'),		-- Lakia
        ('MR21_USF_03', '28', 'Jett'),		-- allow
        ('MR21_USF_03', '29', 'Raze'),		-- Suggest
        ('MR21_USF_03', '30', 'Breach'),	-- solo
        
        -- Match 4
        -- Version1 (V1)
		('MR21_USF_04', '6', 'Jett'),		-- penny
        ('MR21_USF_04', '7', 'Viper'),		-- jammyz
        ('MR21_USF_04', '8', 'Sova'),		-- effys
        ('MR21_USF_04', '9', 'Killjoy'),	-- Zellsis
        ('MR21_USF_04', '10', 'Astra'),		-- vanity
        -- NUTURN (NU)
        ('MR21_USF_04', '26', 'Astra'),		-- peri
        ('MR21_USF_04', '27', 'Sova'),		-- Lakia
        ('MR21_USF_04', '28', 'Jett'),		-- allow
        ('MR21_USF_04', '29', 'Skye'),		-- Suggest
        ('MR21_USF_04', '30', 'Killjoy'),	-- solo
        
        -- Match 5
        -- Version1 (V1)
		('MR21_USF_05', '6', 'Jett'),		-- penny
        ('MR21_USF_05', '7', 'Viper'),		-- jammyz
        ('MR21_USF_05', '8', 'Sage'),		-- effys
        ('MR21_USF_05', '9', 'Killjoy'),	-- Zellsis
        ('MR21_USF_05', '10', 'Astra'),		-- vanity
        -- NUTURN (NU)
        ('MR21_USF_05', '26', 'Omen'),		-- peri
        ('MR21_USF_05', '27', 'Raze'),		-- Lakia
        ('MR21_USF_05', '28', 'Jett'),		-- allow
        ('MR21_USF_05', '29', 'Breach'),	-- Suggest
        ('MR21_USF_05', '30', 'Killjoy'),	-- solo
        
        -- Lower Round 2 --
        -- FNC vs X10
        -- Match 1
		-- FNATIC (FNC)
        ('MR21_LR2_01', '16', 'Sova'),		-- Boaster
        ('MR21_LR2_01', '17', 'Sage'),		-- doma
        ('MR21_LR2_01', '18', 'Viper'),		-- Mistic
        ('MR21_LR2_01', '19', 'Killjoy'),	-- MAGNUM
        ('MR21_LR2_01', '20', 'Jett'),		-- Derke
        -- X10 Esports (X10)
        ('MR21_LR2_01', '46', 'Sova'),		-- foxz
        ('MR21_LR2_01', '47', 'Jett'),		-- Patiphan
        ('MR21_LR2_01', '48', 'Killjoy'),	-- Sushiboys
        ('MR21_LR2_01', '49', 'Breach'),	-- Crws
        ('MR21_LR2_01', '50', 'Viper'),		-- sScary
        
		-- Match 2
		-- FNATIC (FNC)
        ('MR21_LR2_02', '16', 'Astra'),		-- Boaster
        ('MR21_LR2_02', '17', 'Sage'),		-- doma
        ('MR21_LR2_02', '18', 'Skye'),		-- Mistic
        ('MR21_LR2_02', '19', 'Killjoy'),	-- MAGNUM
        ('MR21_LR2_02', '20', 'Jett'),		-- Derke
        -- X10 Esports (X10)
        ('MR21_LR2_02', '46', 'Jett'),		-- foxz
        ('MR21_LR2_02', '47', 'Viper'),		-- Patiphan
        ('MR21_LR2_02', '48', 'Killjoy'),	-- Sushiboys
        ('MR21_LR2_02', '49', 'Skye'),		-- Crws
        ('MR21_LR2_02', '50', 'Astra'),		-- sScary
        
        -- TL vs KRU
		-- Match 3
        -- Team Liquid (TL)
        ('MR21_LR2_03', '11', 'Sage'),		-- ScreaM
        ('MR21_LR2_03', '12', 'Viper'),		-- Kryptix
        ('MR21_LR2_03', '13', 'Brimstone'),	-- L1NK
        ('MR21_LR2_03', '14', 'Skye'),		-- soulcas
        ('MR21_LR2_03', '15', 'Jett'),		-- Jamppi
        -- KRU Esports (KRU)
		('MR21_LR2_03', '36', 'Jett'),		-- NagZ
        ('MR21_LR2_03', '37', 'Raze'),		-- bnj
        ('MR21_LR2_03', '38', 'Omen'),		-- delz1k
        ('MR21_LR2_03', '39', 'Killjoy'),	-- Klaus
        ('MR21_LR2_03', '40', 'Sage'),		-- Mazino
        
        -- Match 4
		-- Team Liquid (TL)
        ('MR21_LR2_04', '11', 'Phoenix'),	-- ScreaM
        ('MR21_LR2_04', '12', 'Killjoy'),	-- Kryptix
        ('MR21_LR2_04', '13', 'Omen'),		-- L1NK
        ('MR21_LR2_04', '14', 'Sova'),		-- soulcas
        ('MR21_LR2_04', '15', 'Jett'),		-- Jamppi
        -- KRU Esports (KRU)
		('MR21_LR2_04', '36', 'Jett'),		-- NagZ
        ('MR21_LR2_04', '37', 'Sova'),		-- bnj
        ('MR21_LR2_04', '38', 'Omen'),		-- delz1k
        ('MR21_LR2_04', '39', 'Killjoy'),	-- Klaus
        ('MR21_LR2_04', '40', 'Sage'),		-- Mazino
        
        -- Lower Round 3 --
        -- V1 vs FNC
        -- Match 1
        -- Version1 (V1)
		('MR21_LR3_01', '6', 'Jett'),		-- penny
        ('MR21_LR3_01', '7', 'Viper'),		-- jammyz
        ('MR21_LR3_01', '8', 'Sova'),		-- effys
        ('MR21_LR3_01', '9', 'Killjoy'),	-- Zellsis
        ('MR21_LR3_01', '10', 'Omen'),		-- vanity
		-- FNATIC (FNC)
        ('MR21_LR3_01', '16', 'Sova'),		-- Boaster
        ('MR21_LR3_01', '17', 'Sage'),		-- doma
        ('MR21_LR3_01', '18', 'Viper'),		-- Mistic
        ('MR21_LR3_01', '19', 'Killjoy'),	-- MAGNUM
        ('MR21_LR3_01', '20', 'Jett'),		-- Derke        
        
        -- Match 2
        -- Version1 (V1)
		('MR21_LR3_02', '6', 'Jett'),		-- penny
        ('MR21_LR3_02', '7', 'Killjoy'),	-- jammyz
        ('MR21_LR3_02', '8', 'Sova'),		-- effys
        ('MR21_LR3_02', '9', 'Phoenix'),	-- Zellsis
        ('MR21_LR3_02', '10', 'Astra'),		-- vanity
		-- FNATIC (FNC)
        ('MR21_LR3_02', '16', 'Skye'),		-- Boaster
        ('MR21_LR3_02', '17', 'Omen'),		-- doma
        ('MR21_LR3_02', '18', 'Skye'),		-- Mistic
        ('MR21_LR3_02', '19', 'Cypher'),	-- MAGNUM
        ('MR21_LR3_02', '20', 'Jett'),		-- Derke
        
        -- VKS1 vs TL
        -- Match 3
		-- Team Vikings (VKS1)
        ('MR21_LR3_03', '21', 'Jett'),		-- frz
        ('MR21_LR3_03', '22', 'Sova'),		-- Sacy
        ('MR21_LR3_03', '23', 'Killjoy'),	-- saadhak
        ('MR21_LR3_03', '24', 'Yoru'),		-- gtn
        ('MR21_LR3_03', '25', 'Astra'),		-- sutecas
        -- Team Liquid (TL)
        ('MR21_LR3_03', '11', 'Sage'),		-- ScreaM
        ('MR21_LR3_03', '12', 'Killjoy'),	-- Kryptix
        ('MR21_LR3_03', '13', 'Omen'),		-- L1NK
        ('MR21_LR3_03', '14', 'Sova'),		-- soulcas
        ('MR21_LR3_03', '15', 'Jett'),		-- Jamppi        
        
        -- Match 4
		-- Team Vikings (VKS1)
        ('MR21_LR3_04', '21', 'Jett'),		-- frz
        ('MR21_LR3_04', '22', 'Sova'),		-- Sacy
        ('MR21_LR3_04', '23', 'Cypher'),	-- saadhak
        ('MR21_LR3_04', '24', 'Yoru'),		-- gtn
        ('MR21_LR3_04', '25', 'Astra'),		-- sutecas
        -- Team Liquid (TL)
        ('MR21_LR3_04', '11', 'Sage'),		-- ScreaM
        ('MR21_LR3_04', '12', 'Viper'),		-- Kryptix
        ('MR21_LR3_04', '13', 'Brimstone'),	-- L1NK
        ('MR21_LR3_04', '14', 'Skye'),		-- soulcas
        ('MR21_LR3_04', '15', 'Killjoy'),	-- Jamppi
        
        -- Upper Final --
        -- SEN vs NU
        -- Match 1
		-- Sentinels (SEN)
        ('MR21_UF_01', '1', 'Sova'),		-- ShahZam
        ('MR21_UF_01', '2', 'Raze'),		-- SicK
        ('MR21_UF_01', '3', 'Reyna'),		-- TenZ
        ('MR21_UF_01', '4', 'Astra'),		-- zombs
        ('MR21_UF_01', '5', 'Viper'),		-- dapr
        -- NUTURN (NU)
        ('MR21_UF_01', '26', 'Omen'),		-- peri
        ('MR21_UF_01', '27', 'Sova'),		-- Lakia
        ('MR21_UF_01', '28', 'Jett'),		-- allow
        ('MR21_UF_01', '29', 'Raze'),		-- Suggest
        ('MR21_UF_01', '30', 'Breach'),		-- solo
        
		-- Match 2
		-- Sentinels (SEN)
        ('MR21_UF_02', '1', 'Sova'),		-- ShahZam
        ('MR21_UF_02', '2', 'Phoenix'),		-- SicK
        ('MR21_UF_02', '3', 'Jett'),		-- TenZ
        ('MR21_UF_02', '4', 'Astra'),		-- zombs
        ('MR21_UF_02', '5', 'Cypher'),		-- dapr
        -- NUTURN (NU)
        ('MR21_UF_02', '26', 'Omen'),		-- peri
        ('MR21_UF_02', '27', 'Sova'),		-- Lakia
        ('MR21_UF_02', '28', 'Jett'),		-- allow
        ('MR21_UF_02', '29', 'Raze'),		-- Suggest
        ('MR21_UF_02', '30', 'Breach'),		-- solo
        
        -- Lower Round 4 --
        -- FNC vs TL
        -- Match 1
		-- FNATIC (FNC)
        ('MR21_LR4_01', '16', 'Brimstone'),	-- Boaster
        ('MR21_LR4_01', '17', 'Raze'),		-- doma
        ('MR21_LR4_01', '18', 'Viper'),		-- Mistic
        ('MR21_LR4_01', '19', 'Skye'),		-- MAGNUM
        ('MR21_LR4_01', '20', 'Sova'),		-- Derke
        -- Team Liquid (TL)
        ('MR21_LR4_01', '11', 'Sage'),		-- ScreaM
        ('MR21_LR4_01', '12', 'Killjoy'),	-- Kryptix
        ('MR21_LR4_01', '13', 'Omen'),		-- L1NK
        ('MR21_LR4_01', '14', 'Sova'),		-- soulcas
        ('MR21_LR4_01', '15', 'Jett'),	-- Jamppi        
        
        -- Match 2
		-- FNATIC (FNC)
        ('MR21_LR4_02', '16', 'Skye'),		-- Boaster
        ('MR21_LR4_02', '17', 'Omen'),		-- doma
        ('MR21_LR4_02', '18', 'Viper'),		-- Mistic
        ('MR21_LR4_02', '19', 'Cypher'),	-- MAGNUM
        ('MR21_LR4_02', '20', 'Jett'),		-- Derke
        -- Team Liquid (TL)
        ('MR21_LR4_02', '11', 'Sage'),		-- ScreaM
        ('MR21_LR4_02', '12', 'Killjoy'),	-- Kryptix
        ('MR21_LR4_02', '13', 'Omen'),		-- L1NK
        ('MR21_LR4_02', '14', 'Sova'),		-- soulcas
        ('MR21_LR4_02', '15', 'Jett'),		-- Jamppi
        
        -- Lower Final --
        -- NU vs FNC
        -- Match 1
        -- NUTURN (NU)
        ('MR21_LF_01', '26', 'Omen'),		-- peri
        ('MR21_LF_01', '27', 'Sova'),		-- Lakia
        ('MR21_LF_01', '28', 'Jett'),		-- allow
        ('MR21_LF_01', '29', 'Raze'),		-- Suggest
        ('MR21_LF_01', '30', 'Breach'),		-- solo
        -- FNATIC (FNC)
        ('MR21_LF_01', '16', 'Brimstone'),	-- Boaster
        ('MR21_LF_01', '17', 'Raze'),		-- doma
        ('MR21_LF_01', '18', 'Viper'),		-- Mistic
        ('MR21_LF_01', '19', 'Skye'),		-- MAGNUM
        ('MR21_LF_01', '20', 'Sova'),		-- Derke        
        
        -- Match 2
        -- NUTURN (NU)
        ('MR21_LF_02', '26', 'Astra'),		-- peri
        ('MR21_LF_02', '27', 'Sova'),		-- Lakia
        ('MR21_LF_02', '28', 'Jett'),		-- allow
        ('MR21_LF_02', '29', 'Skye'),		-- Suggest
        ('MR21_LF_02', '30', 'Killjoy'),	-- solo
        -- FNATIC (FNC)
        ('MR21_LF_02', '16', 'Skye'),		-- Boaster
        ('MR21_LF_02', '17', 'Omen'),		-- doma
        ('MR21_LF_02', '18', 'Viper'),		-- Mistic
        ('MR21_LF_02', '19', 'Cypher'),		-- MAGNUM
        ('MR21_LF_02', '20', 'Jett'),		-- Derke
        
        -- Match 3
        -- NUTURN (NU)
        ('MR21_LF_03', '26', 'Omen'),		-- peri
        ('MR21_LF_03', '27', 'Sova'),		-- Lakia
        ('MR21_LF_03', '28', 'Jett'),		-- allow
        ('MR21_LF_03', '29', 'Phoenix'),	-- Suggest
        ('MR21_LF_03', '30', 'Cypher'),		-- solo
        -- FNATIC (FNC)
        ('MR21_LF_03', '16', 'Astra'),		-- Boaster
        ('MR21_LF_03', '17', 'Sage'),		-- doma
        ('MR21_LF_03', '18', 'Skye'),		-- Mistic
        ('MR21_LF_03', '19', 'Killjoy'),	-- MAGNUM
        ('MR21_LF_03', '20', 'Jett'),		-- Derke
        
        -- Grand Final --
        -- SEN vs FNC
        -- Match 1
		-- Sentinels (SEN)
        ('MR21_GF_01', '1', 'Jett'),		-- ShahZam
        ('MR21_GF_01', '2', 'Sage'),		-- SicK
        ('MR21_GF_01', '3', 'Raze'),		-- TenZ
        ('MR21_GF_01', '4', 'Astra'),		-- zombs
        ('MR21_GF_01', '5', 'Cypher'),		-- dapr
        -- FNATIC (FNC)
        ('MR21_GF_01', '16', 'Astra'),		-- Boaster
        ('MR21_GF_01', '17', 'Skye'),		-- doma
        ('MR21_GF_01', '18', 'Viper'),		-- Mistic
        ('MR21_GF_01', '19', 'Cypher'),		-- MAGNUM
        ('MR21_GF_01', '20', 'Jett'),		-- Derke
        
        -- Match 2
		-- Sentinels (SEN)
        ('MR21_GF_02', '1', 'Sova'),		-- ShahZam
        ('MR21_GF_02', '2', 'Raze'),		-- SicK
        ('MR21_GF_02', '3', 'Reyna'),		-- TenZ
        ('MR21_GF_02', '4', 'Astra'),		-- zombs
        ('MR21_GF_02', '5', 'Viper'),		-- dapr
        -- FNATIC (FNC)
        ('MR21_GF_02', '16', 'Brimstone'),	-- Boaster
        ('MR21_GF_02', '17', 'Raze'),		-- doma
        ('MR21_GF_02', '18', 'Viper'),		-- Mistic
        ('MR21_GF_02', '19', 'Skye'),		-- MAGNUM
        ('MR21_GF_02', '20', 'Sova'),		-- Derke
        
        -- Match 3
		-- Sentinels (SEN)
        ('MR21_GF_03', '1', 'Sova'),		-- ShahZam
        ('MR21_GF_03', '2', 'Phoenix'),		-- SicK
        ('MR21_GF_03', '3', 'Jett'),		-- TenZ
        ('MR21_GF_03', '4', 'Astra'),		-- zombs
        ('MR21_GF_03', '5', 'Cypher'),		-- dapr
        -- FNATIC (FNC)
        ('MR21_GF_03', '16', 'Astra'),		-- Boaster
        ('MR21_GF_03', '17', 'Sage'),		-- doma
        ('MR21_GF_03', '18', 'Skye'),		-- Mistic
        ('MR21_GF_03', '19', 'Killjoy'),	-- MAGNUM
        ('MR21_GF_03', '20', 'Jett'),		-- Derke
        
        -- ===============================================
		--    TOURNAMENT: Masters Berlin 2021 (2021_M2) 
		-- ===============================================
        -- == GROUP STAGE ==
        -- Group A --
        -- Opening (A)
        -- SUP vs ACE
        -- Match 1
		-- Papara SuperMassive (SUP)
        ('MB21_OA_01', '82', 'Skye'),     	-- Turko
        ('MB21_OA_01', '83', 'Viper'),    	-- pAura
        ('MB21_OA_01', '84', 'Sova'),     	-- russ
        ('MB21_OA_01', '85', 'Astra'),    	-- Brave
        ('MB21_OA_01', '86', 'Jett'),     	-- Izzy
        -- Acend (ACE)
        ('MB21_OA_01', '72', 'Raze'),     	-- zeek
        ('MB21_OA_01', '73', 'Skye'),     	-- starxo
        ('MB21_OA_01', '74', 'Sage'),     	-- cNed
        ('MB21_OA_01', '75', 'Viper'),    	-- Kiles
        ('MB21_OA_01', '76', 'Brimstone'),	-- BONECOLD
        
        -- Match 2
		-- Papara SuperMassive (SUP)
        ('MB21_OA_02', '82', 'Sage'),     	-- Turko
        ('MB21_OA_02', '83', 'Killjoy'),  	-- pAura
        ('MB21_OA_02', '84', 'Sova'),     	-- russ
        ('MB21_OA_02', '85', 'Omen'),     	-- Brave
        ('MB21_OA_02', '86', 'Jett'),     	-- Izzy
        -- Acend (ACE)
        ('MB21_OA_02', '72', 'Sova'),     	-- zeek
        ('MB21_OA_02', '73', 'Sage'),     	-- starxo
        ('MB21_OA_02', '74', 'Jett'),     	-- cNed
        ('MB21_OA_02', '75', 'Killjoy'),  	-- Kiles
        ('MB21_OA_02', '76', 'Astra'),    	-- BONECOLD
        
		-- VS vs PRX
        -- Match 3
        -- Vision Strikers (VS)
        ('MB21_OA_03', '61', 'Breach'),   	-- stax
        ('MB21_OA_03', '62', 'Skye'),     	-- Rb
        ('MB21_OA_03', '63', 'Killjoy'),  	-- k1Ng
        ('MB21_OA_03', '64', 'Jett'),     	-- BuZz
        ('MB21_OA_03', '65', 'Astra'),    	-- MaKo
        -- Paper Rex (PRX)
        ('MB21_OA_03', '107', 'Astra'),   	-- mindfreak
        ('MB21_OA_03', '108', 'Jett'),    	-- f0rsakeN
        ('MB21_OA_03', '109', 'Cypher'),   	-- Benkai
        ('MB21_OA_03', '110', 'Skye'),    	-- d4v41
        ('MB21_OA_03', '111', 'Sova'),    	-- shiba
        
		-- Match 4
        -- Vision Strikers (VS)
        ('MB21_OA_04', '61', 'Sage'),     	-- stax
        ('MB21_OA_04', '62', 'Sova'),     	-- Rb
        ('MB21_OA_04', '63', 'Killjoy'),  	-- k1Ng
        ('MB21_OA_04', '64', 'Jett'),     	-- BuZz
        ('MB21_OA_04', '65', 'Viper'),    	-- MaKo
        -- Paper Rex (PRX)
        ('MB21_OA_04', '107', 'Viper'),   	-- mindfreak
        ('MB21_OA_04', '108', 'Jett'),    	-- f0rsakeN
        ('MB21_OA_04', '109', 'Killjoy'),  	-- Benkai
        ('MB21_OA_04', '110', 'Sage'),    	-- d4v41
        ('MB21_OA_04', '111', 'Sova'),    	-- shiba
        
        -- Winners A
        -- VS vs ACE
        -- Match 1
        -- Vision Strikers (VS)
        ('MB21_WA_01', '61', 'Breach'),   	-- stax
        ('MB21_WA_01', '62', 'Skye'),     	-- Rb
        ('MB21_WA_01', '63', 'Killjoy'),  	-- k1Ng
        ('MB21_WA_01', '64', 'Jett'),     	-- BuZz
        ('MB21_WA_01', '65', 'Astra'),    	-- MaKo
        -- Acend (ACE)
        ('MB21_WA_01', '72', 'Phoenix'),  	-- zeek
        ('MB21_WA_01', '73', 'Skye'),     	-- starxo
        ('MB21_WA_01', '74', 'Jett'),     	-- cNed
        ('MB21_WA_01', '75', 'Killjoy'),  	-- Kiles
        ('MB21_WA_01', '76', 'Omen'),     	-- BONECOLD
        
        -- Match 2
        -- Vision Strikers (VS)
        ('MB21_WA_02', '61', 'Sage'),     	-- stax
        ('MB21_WA_02', '62', 'Sova'),     	-- Rb
        ('MB21_WA_02', '63', 'Killjoy'),  	-- k1Ng
        ('MB21_WA_02', '64', 'Jett'),     	-- BuZz
        ('MB21_WA_02', '65', 'Viper'),    	-- MaKo
        -- Acend (ACE)
        ('MB21_WA_02', '72', 'Reyna'),    	-- zeek
        ('MB21_WA_02', '73', 'Sage'),     	-- starxo
        ('MB21_WA_02', '74', 'Jett'),     	-- cNed
        ('MB21_WA_02', '75', 'Sova'),     	-- Kiles
        ('MB21_WA_02', '76', 'Viper'),    	-- BONECOLD
        
		-- Elimination (A)
        -- PRX vs SUP
        -- Match 1
        -- Paper Rex (PRX)
        ('MB21_EA_01', '107', 'Astra'),   	-- mindfreak
        ('MB21_EA_01', '108', 'Jett'),    	-- f0rsakeN
        ('MB21_EA_01', '109', 'Cypher'),   	-- Benkai
        ('MB21_EA_01', '110', 'Skye'),    	-- d4v41
        ('MB21_EA_01', '111', 'Sova'),    	-- shiba
        -- Papara SuperMassive (SUP)
        ('MB21_EA_01', '82', 'Sage'),     	-- Turko
        ('MB21_EA_01', '83', 'Killjoy'),  	-- pAura
        ('MB21_EA_01', '84', 'Sova'),     	-- russ
        ('MB21_EA_01', '85', 'Omen'),     	-- Brave
        ('MB21_EA_01', '86', 'Jett'),     	-- Izzy
        
        -- Match 2
        -- Paper Rex (PRX)
        ('MB21_EA_02', '107', 'Viper'),   	-- mindfreak
        ('MB21_EA_02', '108', 'Jett'),    	-- f0rsakeN
        ('MB21_EA_02', '109', 'Killjoy'),  	-- Benkai
        ('MB21_EA_02', '110', 'Skye'),    	-- d4v41
        ('MB21_EA_02', '111', 'Sova'),    	-- shiba
        -- Papara SuperMassive (SUP)
        ('MB21_EA_02', '82', 'Skye'),     	-- Turko
        ('MB21_EA_02', '83', 'Cypher'),   	-- pAura
        ('MB21_EA_02', '84', 'Sova'),     	-- russ
        ('MB21_EA_02', '85', 'Viper'),    	-- Brave
        ('MB21_EA_02', '86', 'Jett'),     	-- Izzy
        
        -- Match 3
        -- Paper Rex (PRX)
        ('MB21_EA_03', '107', 'Astra'),   	-- mindfreak
        ('MB21_EA_03', '108', 'Reyna'),   	-- f0rsakeN
        ('MB21_EA_03', '109', 'Killjoy'),  	-- Benkai
        ('MB21_EA_03', '110', 'Jett'),    	-- d4v41
        ('MB21_EA_03', '111', 'Sage'),    	-- shiba
        -- Papara SuperMassive (SUP)
        ('MB21_EA_03', '82', 'Sage'),     	-- Turko
        ('MB21_EA_03', '83', 'Cypher'),   	-- pAura
        ('MB21_EA_03', '84', 'Skye'),     	-- russ
        ('MB21_EA_03', '85', 'Astra'),    	-- Brave
        ('MB21_EA_03', '86', 'Raze'),     	-- Izzy
        
        -- Decider (A)
        -- ACE vs SUP
        -- Match 1
        -- Acend (ACE)
        ('MB21_DA_01', '72', 'Sova'),     	-- zeek
        ('MB21_DA_01', '73', 'Sage'),     	-- starxo
        ('MB21_DA_01', '74', 'Jett'),     	-- cNed
        ('MB21_DA_01', '75', 'Killjoy'),  	-- Kiles
        ('MB21_DA_01', '76', 'Astra'),    	-- BONECOLD
        -- Papara SuperMassive (SUP)
        ('MB21_DA_01', '82', 'Sage'),     	-- Turko
        ('MB21_DA_01', '83', 'Killjoy'),  	-- pAura
        ('MB21_DA_01', '84', 'Sova'),     	-- russ
        ('MB21_DA_01', '85', 'Omen'),     	-- Brave
        ('MB21_DA_01', '86', 'Jett'),     	-- Izzy

        -- Match 2
        -- Acend (ACE)
        ('MB21_DA_02', '72', 'Raze'),     	-- zeek
        ('MB21_DA_02', '73', 'Skye'),     	-- starxo
        ('MB21_DA_02', '74', 'Sage'),     	-- cNed
        ('MB21_DA_02', '75', 'Viper'),    	-- Kiles
        ('MB21_DA_02', '76', 'Brimstone'),	-- BONECOLD
        -- Papara SuperMassive (SUP)
        ('MB21_DA_02', '82', 'Skye'),     	-- Turko
        ('MB21_DA_02', '83', 'Viper'),    	-- pAura
        ('MB21_DA_02', '84', 'Sova'),     	-- russ
        ('MB21_DA_02', '85', 'Astra'),    	-- Brave
        ('MB21_DA_02', '86', 'Jett'),     	-- Izzy

        -- Match 3
        -- Acend (ACE)
        ('MB21_DA_03', '72', 'Raze'),     	-- zeek
        ('MB21_DA_03', '73', 'Sage'),     	-- starxo
        ('MB21_DA_03', '74', 'Jett'),     	-- cNed
        ('MB21_DA_03', '75', 'Cypher'),   	-- Kiles
        ('MB21_DA_03', '76', 'Omen'),     	-- BONECOLD
        -- Papara SuperMassive (SUP)
        ('MB21_DA_03', '82', 'Sage'),     	-- Turko
        ('MB21_DA_03', '83', 'Cypher'),   	-- pAura
        ('MB21_DA_03', '84', 'Skye'),     	-- russ
        ('MB21_DA_03', '85', 'Astra'),    	-- Brave
        ('MB21_DA_03', '86', 'Raze'),     	-- Izzy
        
        -- Group B --
        -- Opening (B)
        -- VKS2 vs NV
		-- Match 1
        -- Keyd Stars (VKS2)
        ('MB21_OB_01', 92, 'Reyna'),    	-- murizzz
        ('MB21_OB_01', 93, 'Sage'),     	-- JhoW
        ('MB21_OB_01', 94, 'Viper'),    	-- v1xen
        ('MB21_OB_01', 95, 'Sova'),     	-- ntk
        ('MB21_OB_01', 96, 'Jett'),     	-- heat
        -- ENVY (NV)
        ('MB21_OB_01', 56, 'Sova'),     	-- crashies
        ('MB21_OB_01', 57, 'Raze'),     	-- Victor
        ('MB21_OB_01', 58, 'Viper'),    	-- Marved
        ('MB21_OB_01', 59, 'Killjoy'),  	-- FiNESSE
        ('MB21_OB_01', 60, 'Jett'),     	-- yay

        -- Match 2
        -- Keyd Stars (VKS2)
        ('MB21_OB_02', 92, 'Raze'),     	-- murizzz
        ('MB21_OB_02', 93, 'Sage'),     	-- JhoW
        ('MB21_OB_02', 94, 'Astra'),    	-- v1xen
        ('MB21_OB_02', 95, 'Sova'),     	-- ntk
        ('MB21_OB_02', 96, 'Jett'),     	-- heat
        -- ENVY (NV)
        ('MB21_OB_02', 56, 'Sova'),     	-- crashies
        ('MB21_OB_02', 57, 'Raze'),     	-- Victor
        ('MB21_OB_02', 58, 'Astra'),    	-- Marved
        ('MB21_OB_02', 59, 'Viper'),    	-- FiNESSE
        ('MB21_OB_02', 60, 'Jett'),     	-- yay
        
        -- KRU vs ZETA
        -- Match 3
        -- KRU Esports (KRU)
        ('MB21_OB_03', 36, 'Jett'),     	-- NagZ
        ('MB21_OB_03', 38, 'Astra'),    	-- delz1k
        ('MB21_OB_03', 39, 'Sova'),     	-- Klaus
        ('MB21_OB_03', 40, 'Killjoy'),  	-- Mazino
        ('MB21_OB_03', 71, 'Skye'),     	-- keznit
        -- ZETA DIVISION (ZETA)
        ('MB21_OB_03', 116, 'Sova'),    	-- Laz
        ('MB21_OB_03', 117, 'Breach'),  	-- crow
        ('MB21_OB_03', 119, 'Reyna'),   	-- takej
        ('MB21_OB_03', 120, 'Jett'),    	-- Reita
        ('MB21_OB_03', 121, 'Astra'),   	-- makiba

        -- Match 4
        -- KRU Esports (KRU)
        ('MB21_OB_04', 36, 'Jett'),     	-- NagZ
        ('MB21_OB_04', 38, 'Astra'),    	-- delz1k
        ('MB21_OB_04', 39, 'Killjoy'),  	-- Klaus
        ('MB21_OB_04', 40, 'Sage'),     	-- Mazino
        ('MB21_OB_04', 71, 'Raze'),     	-- keznit
        -- ZETA DIVISION (ZETA)
        ('MB21_OB_04', 116, 'Skye'),    	-- Laz
        ('MB21_OB_04', 117, 'Viper'),   	-- crow
        ('MB21_OB_04', 118, 'Brimstone'),	-- barce
        ('MB21_OB_04', 119, 'Sage'),    	-- takej
        ('MB21_OB_04', 120, 'Jett'),    	-- Reita

        -- Match 5
        -- KRU Esports (KRU)
        ('MB21_OB_05', 36, 'Sage'),     	-- NagZ
        ('MB21_OB_05', 38, 'Brimstone'),	-- delz1k
        ('MB21_OB_05', 39, 'Skye'),     	-- Klaus
        ('MB21_OB_05', 40, 'Viper'),    	-- Mazino
        ('MB21_OB_05', 71, 'Raze'),     	-- keznit
        -- ZETA DIVISION (ZETA)
        ('MB21_OB_05', 116, 'Skye'),    	-- Laz
        ('MB21_OB_05', 117, 'Breach'),  	-- crow
        ('MB21_OB_05', 119, 'Reyna'),   	-- takej
        ('MB21_OB_05', 120, 'Jett'),    	-- Reita
        ('MB21_OB_05', 121, 'Astra'),   	-- makiba
        
		-- Winners B
        -- NV vs KRU
		-- Match 1
        -- ENVY (NV)
        ('MB21_WB_01', 56, 'Sova'),     	-- crashies
        ('MB21_WB_01', 57, 'Raze'),     	-- Victor
        ('MB21_WB_01', 58, 'Viper'),    	-- Marved
        ('MB21_WB_01', 59, 'Killjoy'),  	-- FiNESSE
        ('MB21_WB_01', 60, 'Jett'),     	-- yay
        -- KRU Esports (KRU)
        ('MB21_WB_01', 36, 'Jett'),     	-- NagZ
        ('MB21_WB_01', 38, 'Sage'),     	-- delz1k
        ('MB21_WB_01', 39, 'Sova'),     	-- Klaus
        ('MB21_WB_01', 40, 'Viper'),    	-- Mazino
        ('MB21_WB_01', 71, 'Reyna'),    	-- keznit

        -- Match 2
        -- ENVY (NV)
        ('MB21_WB_02', 56, 'Sova'),     	-- crashies
        ('MB21_WB_02', 57, 'Skye'),     	-- Victor
        ('MB21_WB_02', 58, 'Astra'),    	-- Marved
        ('MB21_WB_02', 59, 'Killjoy'),  	-- FiNESSE
        ('MB21_WB_02', 60, 'Jett'),     	-- yay
        -- KRU Esports (KRU)
        ('MB21_WB_02', 36, 'Jett'),     	-- NagZ
        ('MB21_WB_02', 38, 'Astra'),    	-- delz1k
        ('MB21_WB_02', 39, 'Sova'),     	-- Klaus
        ('MB21_WB_02', 40, 'Killjoy'),  	-- Mazino
        ('MB21_WB_02', 71, 'Skye'),     	-- keznit
        
        -- Elimination (B)
        -- VKS2 vs ZETA
		-- Match 1
        -- Keyd Stars (VKS2)
        ('MB21_EB_01', 92, 'Reyna'),    	-- murizzz
        ('MB21_EB_01', 93, 'Killjoy'),  	-- JhoW
        ('MB21_EB_01', 94, 'Viper'),    	-- v1xen
        ('MB21_EB_01', 95, 'Sova'),     	-- ntk
        ('MB21_EB_01', 96, 'Jett'),     	-- heat
        -- ZETA DIVISION (ZETA)
        ('MB21_EB_01', 116, 'Cypher'),   	-- Laz
        ('MB21_EB_01', 117, 'Sova'),     	-- crow
        ('MB21_EB_01', 119, 'Skye'),     	-- takej
        ('MB21_EB_01', 120, 'Jett'),     	-- Reita
        ('MB21_EB_01', 121, 'Viper'),    	-- makiba

        -- Match 2
        -- Keyd Stars (VKS2)
        ('MB21_EB_02', 92, 'Raze'),     	-- murizzz
        ('MB21_EB_02', 93, 'Killjoy'),  	-- JhoW
        ('MB21_EB_02', 94, 'Astra'),    	-- v1xen
        ('MB21_EB_02', 95, 'Sage'),     	-- ntk
        ('MB21_EB_02', 96, 'Jett'),     	-- heat
        -- ZETA DIVISION (ZETA)
        ('MB21_EB_02', 116, 'Skye'),     	-- Laz
        ('MB21_EB_02', 117, 'Viper'),    	-- crow
        ('MB21_EB_02', 118, 'Brimstone'),	-- barce
        ('MB21_EB_02', 119, 'Sage'),     	-- takej
        ('MB21_EB_02', 120, 'Jett'),     	-- Reita
        
        -- Decider (B)
        -- KRU vs VKS2
        -- Match 1
        -- KRU Esports (KRU)
        ('MB21_DB_01', 36, 'Jett'),     	-- NagZ
        ('MB21_DB_01', 38, 'Astra'),    	-- delz1k
        ('MB21_DB_01', 39, 'Killjoy'),  	-- Klaus
        ('MB21_DB_01', 40, 'Sage'),     	-- Mazino
        ('MB21_DB_01', 71, 'Raze'),     	-- keznit
        -- Keyd Stars (VKS2)
        ('MB21_DB_01', 92, 'Raze'),     	-- murizzz
        ('MB21_DB_01', 93, 'Killjoy'),  	-- JhoW
        ('MB21_DB_01', 94, 'Astra'),    	-- v1xen
        ('MB21_DB_01', 95, 'Sage'),     	-- ntk
        ('MB21_DB_01', 96, 'Jett'),     	-- heat

        -- Match 2
        -- KRU Esports (KRU)
        ('MB21_DB_02', 36, 'Jett'),     	-- NagZ
        ('MB21_DB_02', 38, 'Astra'),    	-- delz1k
        ('MB21_DB_02', 39, 'Killjoy'),  	-- Klaus
        ('MB21_DB_02', 40, 'Sage'),     	-- Mazino
        ('MB21_DB_02', 71, 'Skye'),     	-- keznit
        -- Keyd Stars (VKS2)
        ('MB21_DB_02', 92, 'Phoenix'),  	-- murizzz
        ('MB21_DB_02', 93, 'Killjoy'),  	-- JhoW
        ('MB21_DB_02', 94, 'Astra'),    	-- v1xen
        ('MB21_DB_02', 95, 'Sova'),     	-- ntk
        ('MB21_DB_02', 96, 'Jett'),     	-- heat
        
        -- Group C --
        -- Opening (C)
        -- 100T vs LBR
		-- Match 1
        -- 100 Thieves (100T)
        ('MB21_OC_01', 51, 'Sova'),     	-- Hiko
        ('MB21_OC_01', 52, 'Jett'),     	-- Asuna
        ('MB21_OC_01', 53, 'Omen'),     	-- nitr0
        ('MB21_OC_01', 54, 'KAY/O'),    	-- steel
        ('MB21_OC_01', 55, 'Skye'),     	-- Ethan
        -- Liberty (LBR)
        ('MB21_OC_01', 87, 'Sova'),     	-- krain
        ('MB21_OC_01', 88, 'Astra'),    	-- pleets
        ('MB21_OC_01', 89, 'Breach'),   	-- shion
        ('MB21_OC_01', 90, 'Skye'),     	-- Myssen
        ('MB21_OC_01', 91, 'Jett'),     	-- liazzi

        -- Match 2
        -- 100 Thieves (100T)
        ('MB21_OC_02', 51, 'Sova'),     	-- Hiko
        ('MB21_OC_02', 52, 'Reyna'),    	-- Asuna
        ('MB21_OC_02', 53, 'Viper'),    	-- nitr0
        ('MB21_OC_02', 54, 'Killjoy'),  	-- steel
        ('MB21_OC_02', 55, 'Omen'),     	-- Ethan
        -- Liberty (LBR)
        ('MB21_OC_02', 87, 'Sova'),     	-- krain
        ('MB21_OC_02', 88, 'Sage'),     	-- pleets
        ('MB21_OC_02', 89, 'Reyna'),    	-- shion
        ('MB21_OC_02', 90, 'Viper'),    	-- Myssen
        ('MB21_OC_02', 91, 'Jett'),     	-- liazzi
        
        -- GMB vs CR        
		-- Match 3
        -- Gambit Esports (GMB)
        ('MB21_OC_03', 77, 'Jett'),			-- d3ffo
        ('MB21_OC_03', 78, 'Viper'),		-- nAts
        ('MB21_OC_03', 79, 'Sova'),			-- Chronicle
        ('MB21_OC_03', 80, 'Astra'),		-- Redgar
        ('MB21_OC_03', 81, 'Skye'),			-- sheydos
        -- Crazy Raccoon (CR)
        ('MB21_OC_03', 41, 'Jett'),			-- Munchkin
        ('MB21_OC_03', 45, 'Raze'),			-- neth
        ('MB21_OC_03', 112, 'Breach'),		-- Bazzi
        ('MB21_OC_03', 113, 'Astra'),		-- ade
        ('MB21_OC_03', 114, 'Skye'),		-- Fisker

        -- Match 4
        -- Gambit Esports (GMB)
        ('MB21_OC_04', 77, 'Jett'),			-- d3ffo
        ('MB21_OC_04', 78, 'Viper'),		-- nAts
        ('MB21_OC_04', 79, 'Sova'),			-- Chronicle
        ('MB21_OC_04', 80, 'Sage'),			-- Redgar
        ('MB21_OC_04', 81, 'Reyna'),		-- sheydos
        -- Crazy Raccoon (CR)
        ('MB21_OC_04', 41, 'Jett'),			-- Munchkin
        ('MB21_OC_04', 45, 'Sage'),			-- neth
        ('MB21_OC_04', 112, 'Sova'),		-- Bazzi
        ('MB21_OC_04', 113, 'Viper'),		-- ade
        ('MB21_OC_04', 114, 'Skye'),		-- Fisker
        
        -- Winners C
        -- GMB vs 100T
		-- Match 1
        -- Gambit Esports (GMB)
        ('MB21_WC_01', 77, 'Jett'),			-- d3ffo
        ('MB21_WC_01', 78, 'Cypher'),		-- nAts
        ('MB21_WC_01', 79, 'Sova'),			-- Chronicle
        ('MB21_WC_01', 80, 'Astra'),		-- Redgar
        ('MB21_WC_01', 81, 'Skye'),			-- sheydos
        -- 100 Thieves (100T)
        ('MB21_WC_01', 51, 'Sova'),			-- Hiko
        ('MB21_WC_01', 52, 'Jett'),			-- Asuna
        ('MB21_WC_01', 53, 'Omen'),			-- nitr0
        ('MB21_WC_01', 54, 'KAY/O'),		-- steel
        ('MB21_WC_01', 55, 'Skye'),			-- Ethan

        -- Match 2
        -- Gambit Esports (GMB)
        ('MB21_WC_02', 77, 'Jett'),			-- d3ffo
        ('MB21_WC_02', 78, 'Viper'),		-- nAts
        ('MB21_WC_02', 79, 'Sova'),			-- Chronicle
        ('MB21_WC_02', 80, 'Sage'),			-- Redgar
        ('MB21_WC_02', 81, 'Reyna'),		-- sheydos
        -- 100 Thieves (100T)
        ('MB21_WC_02', 51, 'Sova'),			-- Hiko
        ('MB21_WC_02', 52, 'Reyna'),		-- Asuna
        ('MB21_WC_02', 53, 'Viper'),		-- nitr0
        ('MB21_WC_02', 54, 'Killjoy'),		-- steel
        ('MB21_WC_02', 55, 'Omen'),			-- Ethan
        
        -- Match 3
        -- Gambit Esports (GMB)
        ('MB21_WC_03', 77, 'Jett'),			-- d3ffo
        ('MB21_WC_03', 78, 'Cypher'),		-- nAts
        ('MB21_WC_03', 79, 'Viper'),		-- Chronicle
        ('MB21_WC_03', 80, 'Astra'),		-- Redgar
        ('MB21_WC_03', 81, 'Skye'),			-- sheydos
        -- 100 Thieves (100T)
        ('MB21_WC_03', 51, 'Viper'),		-- Hiko
        ('MB21_WC_03', 52, 'Jett'),			-- Asuna
        ('MB21_WC_03', 53, 'Astra'),		-- nitr0
        ('MB21_WC_03', 54, 'KAY/O'),		-- steel
        ('MB21_WC_03', 55, 'Skye'),			-- Ethan
        
        -- Elimination (C)
        -- CR vs LBR
        -- Match 1
        -- Crazy Raccoon (CR) 
        ('MB21_EC_01', 41, 'Jett'),		    -- Munchkin
        ('MB21_EC_01', 44, 'Cypher'),	    -- Medusa
        ('MB21_EC_01', 45, 'Raze'),		    -- neth
        ('MB21_EC_01', 113, 'Brimstone'),	-- ade
        ('MB21_EC_01', 114, 'Skye'),	    -- Fisker
        -- Liberty (LBR)
        ('MB21_EC_01', 87, 'Breach'),		-- krain
        ('MB21_EC_01', 88, 'Astra'),		-- pleets
        ('MB21_EC_01', 89, 'Skye'),			-- shion
        ('MB21_EC_01', 90, 'Cypher'),		-- Myssen
        ('MB21_EC_01', 91, 'Jett'),			-- liazzi

        -- Match 2
        -- Crazy Raccoon (CR) 
        ('MB21_EC_02', 41, 'Jett'),		    -- Munchkin
        ('MB21_EC_02', 44, 'Cypher'),	    -- Medusa
        ('MB21_EC_02', 45, 'Astra'),	    -- neth
        ('MB21_EC_02', 113, 'Viper'),	    -- ade
        ('MB21_EC_02', 114, 'Skye'),	    -- Fisker
        -- Liberty (LBR)
        ('MB21_EC_02', 87, 'Skye'),			-- krain
        ('MB21_EC_02', 88, 'Astra'),		-- pleets
        ('MB21_EC_02', 89, 'Raze'),			-- shion
        ('MB21_EC_02', 90, 'Viper'),		-- Myssen
        ('MB21_EC_02', 91, 'Killjoy'),		-- liazzi
        
        -- Decider (C)
        -- GMB vs CR
        -- Match 1
        -- Gambit Esports (GMB)
        ('MB21_DC_01', 77, 'Jett'),			-- d3ffo
        ('MB21_DC_01', 78, 'Cypher'),		-- nAts
        ('MB21_DC_01', 79, 'Sova'),			-- Chronicle
        ('MB21_DC_01', 80, 'Astra'),		-- Redgar
        ('MB21_DC_01', 81, 'Skye'),			-- sheydos
        -- Crazy Raccoon (CR)
        ('MB21_DC_01', 41, 'Raze'),			-- Munchkin
        ('MB21_DC_01', 44, 'Cypher'),		-- Medusa
        ('MB21_DC_01', 45, 'Astra'),		-- neth
        ('MB21_DC_01', 113, 'Viper'),		-- ade
        ('MB21_DC_01', 114, 'Skye'),		-- Fisker

        -- Match 2
        -- Gambit Esports (GMB)
        ('MB21_DC_02', 77, 'Jett'),			-- d3ffo
        ('MB21_DC_02', 78, 'Viper'),		-- nAts
        ('MB21_DC_02', 79, 'Sova'),			-- Chronicle
        ('MB21_DC_02', 80, 'Sage'),			-- Redgar
        ('MB21_DC_02', 81, 'Reyna'),		-- sheydos
        -- Crazy Raccoon (CR) 
        ('MB21_DC_02', 41, 'Reyna'),		-- Munchkin
        ('MB21_DC_02', 45, 'Sage'),			-- neth
        ('MB21_DC_02', 112, 'Sova'),		-- Bazzi
        ('MB21_DC_02', 113, 'Viper'),		-- ade
        ('MB21_DC_02', 114, 'Jett'),		-- Fisker
        
        -- Group D --
        -- G2 vs F4Q
        -- Match 1
        -- G2 Esports (G2)
        ('MB21_GD_01', 66, 'Skye'),     	-- Mixwell
        ('MB21_GD_01', 67, 'Sova'),     	-- koldamenta
        ('MB21_GD_01', 68, 'Astra'),    	-- AvovA
        ('MB21_GD_01', 69, 'Sage'),     	-- nukkye
        ('MB21_GD_01', 70, 'Jett'),     	-- keloqz
        -- F4Q (F4Q)
        ('MB21_GD_01', 97, 'Reyna'),    	-- fiveK
        ('MB21_GD_01', 98, 'Astra'),    	-- zunba
        ('MB21_GD_01', 99, 'Killjoy'),  	-- Efina
        ('MB21_GD_01', 100, 'Sova'),    	-- Esperanza
        ('MB21_GD_01', 101, 'Raze'),    	-- Bunny

        -- Match 2
        -- G2 Esports (G2)
        ('MB21_GD_02', 66, 'Skye'),     	-- Mixwell
        ('MB21_GD_02', 67, 'Sova'),     	-- koldamenta
        ('MB21_GD_02', 68, 'Astra'),    	-- AvovA
        ('MB21_GD_02', 69, 'Raze'),     	-- nukkye
        ('MB21_GD_02', 70, 'Sage'),     	-- keloqz
        -- F4Q (F4Q)
        ('MB21_GD_02', 97, 'Skye'),     	-- fiveK
        ('MB21_GD_02', 98, 'Astra'),    	-- zunba
        ('MB21_GD_02', 99, 'Killjoy'),  	-- Efina
        ('MB21_GD_02', 100, 'Sova'),    	-- Esperanza
        ('MB21_GD_02', 101, 'Raze'),    	-- Bunny

        -- Match 3
        -- G2 Esports (G2)
        ('MB21_GD_03', 66, 'Killjoy'),  	-- Mixwell
        ('MB21_GD_03', 67, 'Skye'),     	-- koldamenta
        ('MB21_GD_03', 68, 'Astra'),    	-- AvovA
        ('MB21_GD_03', 69, 'Sage'),     	-- nukkye
        ('MB21_GD_03', 70, 'Jett'),     	-- keloqz
        -- F4Q (F4Q)
        ('MB21_GD_03', 97, 'Skye'),     	-- fiveK
        ('MB21_GD_03', 98, 'Astra'),    	-- zunba
        ('MB21_GD_03', 99, 'Killjoy'),  	-- Efina
        ('MB21_GD_03', 100, 'Sova'),    	-- Esperanza
        ('MB21_GD_03', 101, 'Raze'),    	-- Bunny
        
        -- SEN vs G2
        -- Match 4
        -- Sentinels (SEN)
        ('MB21_GD_04', 1, 'Jett'),      	-- ShahZaM
        ('MB21_GD_04', 2, 'Sage'),      	-- SicK
        ('MB21_GD_04', 3, 'Reyna'),     	-- TenZ
        ('MB21_GD_04', 4, 'Astra'),     	-- zombs
        ('MB21_GD_04', 5, 'Viper'),     	-- dapr
        -- G2 Esports (G2)
        ('MB21_GD_04', 66, 'Sage'),     	-- Mixwell
        ('MB21_GD_04', 67, 'Killjoy'),  	-- koldamenta
        ('MB21_GD_04', 68, 'Astra'),    	-- AvovA
        ('MB21_GD_04', 69, 'Raze'),     	-- nukkye
        ('MB21_GD_04', 70, 'Jett'),     	-- keloqz

        -- Match 5
        -- Sentinels (SEN)
        ('MB21_GD_05', 1, 'Jett'),      	-- ShahZaM
        ('MB21_GD_05', 2, 'Sage'),      	-- SicK
        ('MB21_GD_05', 3, 'Reyna'),     	-- TenZ
        ('MB21_GD_05', 4, 'Viper'),     	-- zombs
        ('MB21_GD_05', 5, 'Sova'),      	-- dapr
        -- G2 Esports (G2)
        ('MB21_GD_05', 66, 'Viper'),    	-- Mixwell
        ('MB21_GD_05', 67, 'Sova'),     	-- koldamenta
        ('MB21_GD_05', 68, 'Sage'),     	-- AvovA
        ('MB21_GD_05', 69, 'Raze'),     	-- nukkye
        ('MB21_GD_05', 70, 'Jett'),     	-- keloqz

        -- Match 6
        -- Sentinels (SEN)
        ('MB21_GD_06', 1, 'Sova'),      	-- ShahZaM
        ('MB21_GD_06', 2, 'Phoenix'),   	-- SicK
        ('MB21_GD_06', 3, 'Jett'),      	-- TenZ
        ('MB21_GD_06', 4, 'Astra'),     	-- zombs
        ('MB21_GD_06', 5, 'Cypher'),    	-- dapr
        -- G2 Esports (G2)
        ('MB21_GD_06', 66, 'Killjoy'),  	-- Mixwell
        ('MB21_GD_06', 67, 'Skye'),     	-- koldamenta
        ('MB21_GD_06', 68, 'Astra'),    	-- AvovA
        ('MB21_GD_06', 69, 'Sage'),     	-- nukkye
        ('MB21_GD_06', 70, 'Jett'),     	-- keloqz
        
        -- F4Q vs SEN 
		-- Match 7
        -- F4Q (F4Q)
        ('MB21_GD_07', 97, 'Skye'),     	-- fiveK
        ('MB21_GD_07', 98, 'Astra'),    	-- zunba
        ('MB21_GD_07', 99, 'Killjoy'),  	-- Efina
        ('MB21_GD_07', 100, 'Sage'),    	-- Esperanza
        ('MB21_GD_07', 101, 'Raze'),    	-- Bunny
        -- Sentinels (SEN)
        ('MB21_GD_07', 1, 'Jett'),      	-- ShahZaM
        ('MB21_GD_07', 2, 'Sage'),      	-- SicK
        ('MB21_GD_07', 3, 'Reyna'),     	-- TenZ
        ('MB21_GD_07', 4, 'Astra'),     	-- zombs
        ('MB21_GD_07', 5, 'Cypher'),    	-- dapr

        -- Match 8
        -- F4Q (F4Q)
        ('MB21_GD_08', 97, 'Viper'),    	-- fiveK
        ('MB21_GD_08', 98, 'Skye'),     	-- zunba
        ('MB21_GD_08', 99, 'Killjoy'),  	-- Efina
        ('MB21_GD_08', 100, 'Viper'),   	-- Esperanza
        ('MB21_GD_08', 101, 'Jett'),    	-- Bunny
        -- Sentinels (SEN)
        ('MB21_GD_08', 1, 'Sova'),      	-- ShahZaM
        ('MB21_GD_08', 2, 'Skye'),      	-- SicK
        ('MB21_GD_08', 3, 'Jett'),      	-- TenZ
        ('MB21_GD_08', 4, 'Viper'),     	-- zombs
        ('MB21_GD_08', 5, 'Killjoy'),   	-- dapr
        
        -- F4Q vs G2
		-- Match 9
        -- F4Q (F4Q)
        ('MB21_GD_09', 97, 'Skye'),     	-- fiveK
        ('MB21_GD_09', 98, 'Astra'),    	-- zunba
        ('MB21_GD_09', 99, 'Killjoy'),  	-- Efina
        ('MB21_GD_09', 100, 'Sova'),    	-- Esperanza
        ('MB21_GD_09', 101, 'Raze'),    	-- Bunny
        -- G2 Esports (G2)
        ('MB21_GD_09', 66, 'Viper'),    	-- Mixwell
        ('MB21_GD_09', 67, 'Sova'),     	-- koldamenta
        ('MB21_GD_09', 68, 'Astra'),    	-- AvovA
        ('MB21_GD_09', 69, 'Raze'),     	-- nukkye
        ('MB21_GD_09', 70, 'Skye'),     	-- keloqz

        -- Match 10
        -- F4Q (F4Q)
        ('MB21_GD_10', 97, 'Skye'),     	-- fiveK
        ('MB21_GD_10', 98, 'Astra'),    	-- zunba
        ('MB21_GD_10', 99, 'Killjoy'),  	-- Efina
        ('MB21_GD_10', 100, 'Sova'),    	-- Esperanza
        ('MB21_GD_10', 101, 'Raze'),    	-- Bunny
        -- G2 Esports (G2)
        ('MB21_GD_10', 66, 'Skye'),     	-- Mixwell
        ('MB21_GD_10', 67, 'Sova'),     	-- koldamenta
        ('MB21_GD_10', 68, 'Astra'),    	-- AvovA
        ('MB21_GD_10', 69, 'Sage'),     	-- nukkye
        ('MB21_GD_10', 70, 'Jett'),     	-- keloqz
        
        -- G2 vs SEN
		-- Match 11
        -- G2 Esports (G2)
        ('MB21_GD_11', 66, 'Viper'),    	-- Mixwell
        ('MB21_GD_11', 67, 'Sova'),     	-- koldamenta
        ('MB21_GD_11', 68, 'Sage'),     	-- AvovA
        ('MB21_GD_11', 69, 'Raze'),     	-- nukkye
        ('MB21_GD_11', 70, 'Jett'),     	-- keloqz
        -- Sentinels (SEN)
        ('MB21_GD_11', 1, 'Jett'),      	-- ShahZaM
        ('MB21_GD_11', 2, 'Sage'),      	-- SicK
        ('MB21_GD_11', 3, 'Reyna'),     	-- TenZ
        ('MB21_GD_11', 4, 'Viper'),     	-- zombs
        ('MB21_GD_11', 5, 'Sova'),      	-- dapr

        -- Match 12
        -- G2 Esports (G2)
        ('MB21_GD_12', 66, 'Raze'),     	-- Mixwell
        ('MB21_GD_12', 67, 'Killjoy'),  	-- koldamenta
        ('MB21_GD_12', 68, 'Astra'),    	-- AvovA
        ('MB21_GD_12', 69, 'Reyna'),    	-- nukkye
        ('MB21_GD_12', 70, 'Sage'),     	-- keloqz
        -- Sentinels (SEN)
        ('MB21_GD_12', 1, 'Jett'),      	-- ShahZaM
        ('MB21_GD_12', 2, 'Sage'),      	-- SicK
        ('MB21_GD_12', 3, 'Reyna'),     	-- TenZ
        ('MB21_GD_12', 4, 'Astra'),     	-- zombs
        ('MB21_GD_12', 5, 'Viper'),     	-- dapr
        
        -- SEN vs F4Q
        -- Match 13
        -- Sentinels (SEN)
        ('MB21_GD_13', 1, 'Sova'),      	-- ShahZaM
        ('MB21_GD_13', 2, 'Skye'),      	-- SicK
        ('MB21_GD_13', 3, 'Jett'),      	-- TenZ
        ('MB21_GD_13', 4, 'Viper'),     	-- zombs
        ('MB21_GD_13', 5, 'Killjoy'),   	-- dapr
        -- F4Q (F4Q)
        ('MB21_GD_13', 97, 'Skye'),     	-- fiveK
        ('MB21_GD_13', 98, 'Yoru'),     	-- zunba
        ('MB21_GD_13', 99, 'Killjoy'),  	-- Efina
        ('MB21_GD_13', 100, 'Viper'),   	-- Esperanza
        ('MB21_GD_13', 101, 'Jett'),    	-- Bunny

        -- Match 14
        -- Sentinels (SEN)
        ('MB21_GD_14', 1, 'Jett'),      	-- ShahZaM
        ('MB21_GD_14', 2, 'Sage'),      	-- SicK
        ('MB21_GD_14', 3, 'Reyna'),     	-- TenZ
        ('MB21_GD_14', 4, 'Astra'),     	-- zombs
        ('MB21_GD_14', 5, 'Cypher'),    	-- dapr
        -- F4Q (F4Q)
        ('MB21_GD_14', 97, 'Reyna'),    	-- fiveK
        ('MB21_GD_14', 98, 'Astra'),    	-- zunba
        ('MB21_GD_14', 99, 'Killjoy'),  	-- Efina
        ('MB21_GD_14', 100, 'Sage'),    	-- Esperanza
        ('MB21_GD_14', 101, 'Raze'),    	-- Bunny

        -- Match 15
        -- Sentinels (SEN)
        ('MB21_GD_15', 1, 'Sova'),      	-- ShahZaM
        ('MB21_GD_15', 2, 'Phoenix'),   	-- SicK
        ('MB21_GD_15', 3, 'Jett'),      	-- TenZ
        ('MB21_GD_15', 4, 'Astra'),     	-- zombs
        ('MB21_GD_15', 5, 'Cypher'),    	-- dapr
        -- F4Q (F4Q)
        ('MB21_GD_15', 97, 'Reyna'),    	-- fiveK
        ('MB21_GD_15', 98, 'Astra'),    	-- zunba
        ('MB21_GD_15', 99, 'Killjoy'),  	-- Efina
        ('MB21_GD_15', 100, 'Sova'),    	-- Esperanza
        ('MB21_GD_15', 101, 'Raze'),    	-- Bunny
        
        -- == PLAYOFFS ==
        -- Quarterfinals --
        -- VS vs GMB
        -- Match 1
        -- Vision Strikers (VS)
        ('MB21_QF_01', 27, 'Skye'),     	-- Lakia
        ('MB21_QF_01', 61, 'Breach'),   	-- stax
        ('MB21_QF_01', 62, 'Raze'),     	-- Rb
        ('MB21_QF_01', 64, 'Jett'),     	-- BuZz
        ('MB21_QF_01', 65, 'Astra'),    	-- MaKo
        -- Gambit Esports (GMB)
        ('MB21_QF_01', 77, 'Jett'),     	-- d3ffo
        ('MB21_QF_01', 78, 'Viper'),    	-- nAts
        ('MB21_QF_01', 79, 'Sova'),     	-- Chronicle
        ('MB21_QF_01', 80, 'Astra'),    	-- Redgar
        ('MB21_QF_01', 81, 'Skye'),     	-- sheydos

        -- Match 2
        -- Vision Strikers (VS)
        ('MB21_QF_02', 61, 'Skye'),     	-- stax
        ('MB21_QF_02', 62, 'Sage'),     	-- Rb
        ('MB21_QF_02', 63, 'Killjoy'),  	-- k1Ng
        ('MB21_QF_02', 64, 'Jett'),     	-- BuZz
        ('MB21_QF_02', 65, 'Astra'),    	-- MaKo
        -- Gambit Esports (GMB)
        ('MB21_QF_02', 77, 'Jett'),     	-- d3ffo
        ('MB21_QF_02', 78, 'Cypher'),   	-- nAts
        ('MB21_QF_02', 79, 'Viper'),    	-- Chronicle
        ('MB21_QF_02', 80, 'Astra'),    	-- Redgar
        ('MB21_QF_02', 81, 'Skye'),     	-- sheydos

        -- Match 3
        -- Vision Strikers (VS)
        ('MB21_QF_03', 61, 'Sage'),     	-- stax
        ('MB21_QF_03', 62, 'Sova'),     	-- Rb
        ('MB21_QF_03', 63, 'Killjoy'),  	-- k1Ng
        ('MB21_QF_03', 64, 'Jett'),     	-- BuZz
        ('MB21_QF_03', 65, 'Viper'),    	-- MaKo
        -- Gambit Esports (GMB)
        ('MB21_QF_03', 77, 'Jett'),     	-- d3ffo
        ('MB21_QF_03', 78, 'Viper'),    	-- nAts
        ('MB21_QF_03', 79, 'Sova'),     	-- Chronicle
        ('MB21_QF_03', 80, 'Sage'),     	-- Redgar
        ('MB21_QF_03', 81, 'Reyna'),    	-- sheydos
        
        -- G2 vs KRU
        -- Match 4
        -- G2 Esports (G2)
        ('MB21_QF_04', 66, 'Viper'),    	-- Mixwell
        ('MB21_QF_04', 67, 'Sova'),     	-- koldamenta
        ('MB21_QF_04', 68, 'Sage'),     	-- AvovA
        ('MB21_QF_04', 69, 'Raze'),     	-- nukkye
        ('MB21_QF_04', 70, 'Jett'),     	-- keloqz
        -- KRU Esports (KRU)
        ('MB21_QF_04', 36, 'Jett'),     	-- Nagz
        ('MB21_QF_04', 38, 'Sage'),     	-- delz1k
        ('MB21_QF_04', 39, 'Sova'),     	-- Klaus
        ('MB21_QF_04', 40, 'Viper'),    	-- Mazino
        ('MB21_QF_04', 71, 'Reyna'),    	-- keznit

        -- Match 5
        -- G2 Esports (G2)
        ('MB21_QF_05', 66, 'Killjoy'),  	-- Mixwell
        ('MB21_QF_05', 67, 'Sova'),     	-- koldamenta
        ('MB21_QF_05', 68, 'Omen'),     	-- AvovA
        ('MB21_QF_05', 69, 'Phoenix'),  	-- nukkye
        ('MB21_QF_05', 70, 'Jett'),     	-- keloqz
        -- KRU Esports (KRU)
        ('MB21_QF_05', 36, 'Jett'),     	-- Nagz
        ('MB21_QF_05', 38, 'Astra'),    	-- delz1k
        ('MB21_QF_05', 39, 'Killjoy'),  	-- Klaus
        ('MB21_QF_05', 40, 'Sage'),     	-- Mazino
        ('MB21_QF_05', 71, 'Skye'),     	-- keznit
                
        -- 100T vs ACE
        -- Match 6
        -- 100 Thieves (100T)
        ('MB21_QF_06', 51, 'Sova'),     	-- Hiko
        ('MB21_QF_06', 52, 'Jett'),     	-- Asuna
        ('MB21_QF_06', 53, 'Astra'),    	-- nitr0
        ('MB21_QF_06', 54, 'Killjoy'),  	-- steel
        ('MB21_QF_06', 55, 'Skye'),     	-- Ethan
        -- Acend (ACE)
        ('MB21_QF_06', 72, 'Sova'),     	-- zeek
        ('MB21_QF_06', 73, 'Sage'),     	-- starxo
        ('MB21_QF_06', 74, 'Jett'),     	-- cNed
        ('MB21_QF_06', 75, 'Killjoy'),  	-- Kiles
        ('MB21_QF_06', 76, 'Astra'),    	-- BONECOLD

        -- Match 7
        -- 100 Thieves (100T)
        ('MB21_QF_07', 51, 'Sova'),     	-- Hiko
        ('MB21_QF_07', 52, 'Jett'),     	-- Asuna
        ('MB21_QF_07', 53, 'Astra'),    	-- nitr0
        ('MB21_QF_07', 54, 'Killjoy'),  	-- steel
        ('MB21_QF_07', 55, 'Skye'),     	-- Ethan
        -- Acend (ACE)
        ('MB21_QF_07', 72, 'Phoenix'),  	-- zeek
        ('MB21_QF_07', 73, 'Skye'),     	-- starxo
        ('MB21_QF_07', 74, 'Jett'),     	-- cNed
        ('MB21_QF_07', 75, 'Cypher'),   	-- Kiles
        ('MB21_QF_07', 76, 'Astra'),    	-- BONECOLD

        -- Match 8
        -- 100 Thieves (100T)
        ('MB21_QF_08', 51, 'Sova'),     	-- Hiko
        ('MB21_QF_08', 52, 'Reyna'),    	-- Asuna
        ('MB21_QF_08', 53, 'Jett'),     	-- nitr0
        ('MB21_QF_08', 54, 'Viper'),    	-- steel
        ('MB21_QF_08', 55, 'Skye'),     	-- Ethan
        -- Acend (ACE)
        ('MB21_QF_08', 72, 'Sova'),     	-- zeek
        ('MB21_QF_08', 73, 'Skye'),     	-- starxo
        ('MB21_QF_08', 74, 'Jett'),     	-- cNed
        ('MB21_QF_08', 75, 'Cypher'),   	-- Kiles
        ('MB21_QF_08', 76, 'Viper'),    	-- BONECOLD
        
        -- NV vs SEN
        -- Match 9
        -- Team ENVY (NV)
        ('MB21_QF_09', 56, 'Sova'),     	-- crashies
        ('MB21_QF_09', 57, 'Skye'),     	-- Victor
        ('MB21_QF_09', 58, 'Astra'),    	-- Marved
        ('MB21_QF_09', 59, 'Killjoy'),  	-- FiNESSE
        ('MB21_QF_09', 60, 'Jett'),     	-- yay
        -- Sentinels (SEN)
        ('MB21_QF_09', 1, 'Sova'),      	-- ShahZaM
        ('MB21_QF_09', 2, 'Phoenix'),   	-- SicK
        ('MB21_QF_09', 3, 'Jett'),      	-- TenZ
        ('MB21_QF_09', 4, 'Astra'),     	-- zombs
        ('MB21_QF_09', 5, 'Cypher'),    	-- dapr

        -- Match 10
        -- Team ENVY (NV)
        ('MB21_QF_10', 56, 'Viper'),    	-- crashies
        ('MB21_QF_10', 57, 'Skye'),     	-- Victor
        ('MB21_QF_10', 58, 'Astra'),    	-- Marved
        ('MB21_QF_10', 59, 'Cypher'),   	-- FiNESSE
        ('MB21_QF_10', 60, 'Jett'),     	-- yay
        -- Sentinels (SEN)
        ('MB21_QF_10', 1, 'Jett'),      	-- ShahZaM
        ('MB21_QF_10', 2, 'Skye'),      	-- SicK
        ('MB21_QF_10', 3, 'Raze'),      	-- TenZ
        ('MB21_QF_10', 4, 'Astra'),     	-- zombs
        ('MB21_QF_10', 5, 'Viper'),     	-- dapr
                
        -- Semifinals --
        -- GMB vs G2
        -- Match 1
        -- Gambit Esports (GMB)
        ('MB21_SF_01', 77, 'Jett'),     	-- d3ffo
        ('MB21_SF_01', 78, 'Cypher'),   	-- nAts
        ('MB21_SF_01', 79, 'Viper'),    	-- Chronicle
        ('MB21_SF_01', 80, 'Sova'),     	-- Redgar
        ('MB21_SF_01', 81, 'Skye'),     	-- sheydos
        -- G2 Esports (G2)
        ('MB21_SF_01', 66, 'Skye'),     	-- Mixwell
        ('MB21_SF_01', 67, 'Sova'),     	-- koldamenta
        ('MB21_SF_01', 68, 'Viper'),    	-- AvovA
        ('MB21_SF_01', 69, 'Reyna'),    	-- nukkye
        ('MB21_SF_01', 70, 'Jett'),     	-- keloqz

        -- Match 2
        -- Gambit Esports (GMB)
        ('MB21_SF_02', 77, 'Jett'),     	-- d3ffo
        ('MB21_SF_02', 78, 'Viper'),    	-- nAts
        ('MB21_SF_02', 79, 'Sova'),     	-- Chronicle
        ('MB21_SF_02', 80, 'Sage'),     	-- Redgar
        ('MB21_SF_02', 81, 'Reyna'),    	-- sheydos
        -- G2 Esports (G2)
        ('MB21_SF_02', 66, 'Viper'),    	-- Mixwell
        ('MB21_SF_02', 67, 'Sova'),     	-- koldamenta
        ('MB21_SF_02', 68, 'Sage'),     	-- AvovA
        ('MB21_SF_02', 69, 'Reyna'),    	-- nukkye
        ('MB21_SF_02', 70, 'Jett'),     	-- keloqz

		-- 100T vs NV
        -- Match 3
        -- 100 Thieves (100T)
        ('MB21_SF_03', 51, 'Sova'),     	-- Hiko
        ('MB21_SF_03', 52, 'Jett'),     	-- Asuna
        ('MB21_SF_03', 53, 'Astra'),    	-- nitr0
        ('MB21_SF_03', 54, 'Killjoy'),  	-- steel
        ('MB21_SF_03', 55, 'Skye'),     	-- Ethan
        -- Team ENVY (NV)
        ('MB21_SF_03', 56, 'Sova'),     	-- crashies
        ('MB21_SF_03', 57, 'Skye'),     	-- Victor
        ('MB21_SF_03', 58, 'Astra'),    	-- Marved
        ('MB21_SF_03', 59, 'Killjoy'),  	-- FiNESSE
        ('MB21_SF_03', 60, 'Jett'),     	-- yay

        -- Match 4
        -- 100 Thieves (100T)
        ('MB21_SF_04', 51, 'Sova'),     	-- Hiko
        ('MB21_SF_04', 52, 'Jett'),     	-- Asuna
        ('MB21_SF_04', 53, 'Astra'),    	-- nitr0
        ('MB21_SF_04', 54, 'Killjoy'),  	-- steel
        ('MB21_SF_04', 55, 'Skye'),     	-- Ethan
        -- Team ENVY (NV)
        ('MB21_SF_04', 56, 'Sova'),     	-- crashies
        ('MB21_SF_04', 57, 'Skye'),     	-- Victor
        ('MB21_SF_04', 58, 'Astra'),    	-- Marved
        ('MB21_SF_04', 59, 'Killjoy'),  	-- FiNESSE
        ('MB21_SF_04', 60, 'Jett'),     	-- yay
                     
        -- Grand Final --
        -- NV vs GMB
        -- Match 1
        -- Team ENVY (NV)
        ('MB21_GF_01', 56, 'Sova'),     	-- crashies
        ('MB21_GF_01', 57, 'Skye'),     	-- Victor
        ('MB21_GF_01', 58, 'Astra'),    	-- Marved
        ('MB21_GF_01', 59, 'Viper'),    	-- FiNESSE
        ('MB21_GF_01', 60, 'Jett'),     	-- yay
        -- Gambit Esports (GMB)
        ('MB21_GF_01', 77, 'Jett'),     	-- d3ffo
        ('MB21_GF_01', 78, 'Viper'),    	-- nAts
        ('MB21_GF_01', 79, 'Sova'),     	-- Chronicle
        ('MB21_GF_01', 80, 'Astra'),    	-- Redgar
        ('MB21_GF_01', 81, 'Skye'),     	-- sheydos

        -- Match 2
        -- Team ENVY (NV)
        ('MB21_GF_02', 56, 'Sova'),     	-- crashies
        ('MB21_GF_02', 57, 'Skye'),     	-- Victor
        ('MB21_GF_02', 58, 'Astra'),    	-- Marved
        ('MB21_GF_02', 59, 'Killjoy'),  	-- FiNESSE
        ('MB21_GF_02', 60, 'Jett'),     	-- yay
        -- Gambit Esports (GMB)
        ('MB21_GF_02', 77, 'Jett'),     	-- d3ffo
        ('MB21_GF_02', 78, 'Cypher'),   	-- nAts
        ('MB21_GF_02', 79, 'Brimstone'),	-- Chronicle
        ('MB21_GF_02', 80, 'Reyna'),    	-- Redgar
        ('MB21_GF_02', 81, 'Skye'),     	-- sheydos

        -- Match 3 
        -- Team ENVY (NV)
        ('MB21_GF_03', 56, 'Viper'),    	-- crashies
        ('MB21_GF_03', 57, 'Skye'),     	-- Victor
        ('MB21_GF_03', 58, 'Astra'),    	-- Marved
        ('MB21_GF_03', 59, 'Cypher'),   	-- FiNESSE
        ('MB21_GF_03', 60, 'Jett'),     	-- yay
        -- Gambit Esports (GMB)
        ('MB21_GF_03', 77, 'Jett'),     	-- d3ffo
        ('MB21_GF_03', 78, 'Cypher'),   	-- nAts
        ('MB21_GF_03', 79, 'Viper'),    	-- Chronicle
        ('MB21_GF_03', 80, 'Astra'),    	-- Redgar
        ('MB21_GF_03', 81, 'Skye'),     	-- sheydos        
        
        -- ===================================================
		--    TOURNAMENT: Valorant Champions 2021 (2021_C1) 
		-- ===================================================
		-- == GROUP STAGE ==
        -- Group A --
        -- Opening (A)
        -- NV vs X10
        -- Match 1
        -- ENVY (NV)
        ('VC21_OA_01', '56', 'Sova'),			-- crashies
        ('VC21_OA_01', '57', 'KAY/O'),			-- Victor
        ('VC21_OA_01', '58', 'Viper'),			-- Marved
        ('VC21_OA_01', '59', 'Killjoy'),		-- FiNESSE
        ('VC21_OA_01', '60', 'Jett'),			-- yay
        -- X10 Esports (X10)
        ('VC21_OA_01', '46', 'Sova'),			-- foxz
        ('VC21_OA_01', '47', 'Jett'),			-- Patiphan
        ('VC21_OA_01', '48', 'Cypher'),			-- Sushiboys
        ('VC21_OA_01', '49', 'KAY/O'),			-- Crws
        ('VC21_OA_01', '50', 'Viper'),			-- sScary
        
        -- Match 2
        -- ENVY (NV)
        ('VC21_OA_02', '56', 'Sova'),			-- crashies
        ('VC21_OA_02', '57', 'Skye'),			-- Victor
        ('VC21_OA_02', '58', 'Astra'),			-- Marved
        ('VC21_OA_02', '59', 'Killjoy'),		-- FiNESSE
        ('VC21_OA_02', '60', 'Jett'),			-- yay
        -- X10 Esports (X10)
        ('VC21_OA_02', '46', 'Sova'),			-- foxz
        ('VC21_OA_02', '47', 'Jett'),			-- Patiphan
        ('VC21_OA_02', '48', 'Cypher'),			-- Sushiboys
        ('VC21_OA_02', '49', 'KAY/O'),			-- Crws
        ('VC21_OA_02', '50', 'Astra'),			-- sScary
        
        -- ACE vs VKS2
        -- Match 3
        -- Acend (ACE)
        ('VC21_OA_03', '72', 'Reyna'),			-- zeek
        ('VC21_OA_03', '73', 'Sage'),			-- starxo
        ('VC21_OA_03', '74', 'Jett'),			-- cNed
        ('VC21_OA_03', '75', 'Viper'),			-- Kiles
        ('VC21_OA_03', '76', 'Sova'),			-- BONECOLD
        -- Keyd Stars (VKS2)
        ('VC21_OA_03', '92', 'Killjoy'),		-- murizzz
        ('VC21_OA_03', '93', 'Sage'),			-- JhoW
        ('VC21_OA_03', '94', 'Viper'),			-- v1xen
        ('VC21_OA_03', '96', 'Jett'),			-- heat
        ('VC21_OA_03', '122', 'Sova'),			-- mwzera
        
        -- Match 4
        -- Acend (ACE)
        ('VC21_OA_04', '72', 'Raze'),			-- zeek
        ('VC21_OA_04', '73', 'Skye'),			-- starxo
        ('VC21_OA_04', '74', 'Sage'),			-- cNed
        ('VC21_OA_04', '75', 'Viper'),			-- Kiles
        ('VC21_OA_04', '76', 'Brimstone'),		-- BONECOLD
        -- Keyd Stars (VKS2)
        ('VC21_OA_04', '92', 'Sage'),			-- murizzz
        ('VC21_OA_04', '93', 'Viper'),			-- JhoW
        ('VC21_OA_04', '94', 'Astra'),			-- v1xen
        ('VC21_OA_04', '96', 'Jett'),			-- heat
        ('VC21_OA_04', '122', 'Skye'),			-- mwzera
        
        -- Match 5
        -- Acend (ACE)
        ('VC21_OA_05', '72', 'KAY/O'),			-- zeek
        ('VC21_OA_05', '73', 'Viper'),			-- starxo
        ('VC21_OA_05', '74', 'Jett'),			-- cNed
        ('VC21_OA_05', '75', 'Cypher'),			-- Kiles
        ('VC21_OA_05', '76', 'Sova'),			-- BONECOLD
        -- Keyd Stars (VKS2)
        ('VC21_OA_05', '92', 'Reyna'),			-- murizzz
        ('VC21_OA_05', '93', 'Cypher'),			-- JhoW
        ('VC21_OA_05', '94', 'Viper'),			-- v1xen
        ('VC21_OA_05', '96', 'Jett'),			-- heat
        ('VC21_OA_05', '122', 'Sova'),			-- mwzera
        
        -- Winners (A)
        -- ACE vs ENVY
        -- Match 1
        -- Acend (ACE)
        ('VC21_WA_01', '72', 'KAY/O'),			-- zeek
        ('VC21_WA_01', '73', 'Astra'),			-- starxo
        ('VC21_WA_01', '74', 'Jett'),			-- cNed
        ('VC21_WA_01', '75', 'Killjoy'),		-- Kiles
        ('VC21_WA_01', '76', 'Sova'),			-- BONECOLD
        -- ENVY (NV)
        ('VC21_WA_01', '56', 'Sova'),			-- crashies
        ('VC21_WA_01', '57', 'Skye'),			-- Victor
        ('VC21_WA_01', '58', 'Astra'),			-- Marved
        ('VC21_WA_01', '59', 'Killjoy'),		-- FiNESSE
        ('VC21_WA_01', '60', 'Jett'),			-- yay
        
        -- Match 2
        -- Acend (ACE)
        ('VC21_WA_02', '72', 'Raze'),			-- zeek
        ('VC21_WA_02', '73', 'Skye'),			-- starxo
        ('VC21_WA_02', '74', 'Sage'),			-- cNed
        ('VC21_WA_02', '75', 'Viper'),			-- Kiles
        ('VC21_WA_02', '76', 'Brimstone'),		-- BONECOLD
        -- ENVY (NV)
        ('VC21_WA_02', '56', 'Sova'),			-- crashies
        ('VC21_WA_02', '57', 'Skye'),			-- Victor
        ('VC21_WA_02', '58', 'Astra'),			-- Marved
        ('VC21_WA_02', '59', 'Viper'),			-- FiNESSE
        ('VC21_WA_02', '60', 'Jett'),			-- yay

        -- Elimination (A)
        -- X10 vs VKS2
        -- Match 1
        -- X10 Esports (X10)
        ('VC21_EA_01', '46', 'Sova'),			-- foxz
        ('VC21_EA_01', '47', 'Reyna'),			-- Patiphan
        ('VC21_EA_01', '48', 'Jett'),			-- Sushiboys
        ('VC21_EA_01', '49', 'Sage'),			-- Crws
        ('VC21_EA_01', '50', 'Viper'),			-- sScary
        -- Keyd Stars (VKS2)
        ('VC21_EA_01', '92', 'Killjoy'),		-- murizzz
        ('VC21_EA_01', '93', 'Sage'),			-- JhoW
        ('VC21_EA_01', '94', 'Viper'),			-- v1xen
        ('VC21_EA_01', '96', 'Jett'),			-- heat
        ('VC21_EA_01', '122', 'Sova'),			-- mwzera
        
        -- Match 2
        -- X10 Esports (X10)
        ('VC21_EA_02', '46', 'Skye'),			-- foxz
        ('VC21_EA_02', '47', 'Jett'),			-- Patiphan
        ('VC21_EA_02', '48', 'Killjoy'),		-- Sushiboys
        ('VC21_EA_02', '49', 'Breach'),			-- Crws
        ('VC21_EA_02', '50', 'Astra'),			-- sScary
        -- Keyd Stars (VKS2)
        ('VC21_EA_02', '92', 'Breach'),			-- murizzz
        ('VC21_EA_02', '93', 'Killjoy'),		-- JhoW
        ('VC21_EA_02', '94', 'Astra'),			-- v1xen
        ('VC21_EA_02', '96', 'Jett'),			-- heat
        ('VC21_EA_02', '122', 'Sova'),			-- mwzera
        
        -- Decider (A)
        -- ENVY vs X10
        -- Match 1
        -- ENVY (NV)
        ('VC21_DA_01', '56', 'Sova'),			-- crashies
        ('VC21_DA_01', '57', 'Reyna'),			-- Victor
        ('VC21_DA_01', '58', 'Viper'),			-- Marved
        ('VC21_DA_01', '59', 'Killjoy'),		-- FiNESSE
        ('VC21_DA_01', '60', 'Jett'),			-- yay
        -- X10 Esports (X10)
        ('VC21_DA_01', '46', 'Sova'),			-- foxz
        ('VC21_DA_01', '47', 'Reyna'),			-- Patiphan
        ('VC21_DA_01', '48', 'Jett'),			-- Sushiboys
        ('VC21_DA_01', '49', 'Sage'),			-- Crws
        ('VC21_DA_01', '50', 'Viper'),			-- sScary
        
        -- Match 2
        -- ENVY (NV)
        ('VC21_DA_02', '56', 'Viper'),			-- crashies
        ('VC21_DA_02', '57', 'Skye'),			-- Victor
        ('VC21_DA_02', '58', 'Astra'),			-- Marved
        ('VC21_DA_02', '59', 'Killjoy'),		-- FiNESSE
        ('VC21_DA_02', '60', 'Jett'),			-- yay
        -- X10 Esports (X10)
        ('VC21_DA_02', '46', 'Skye'),			-- foxz
        ('VC21_DA_02', '47', 'Raze'),			-- Patiphan
        ('VC21_DA_02', '48', 'Killjoy'),		-- Sushiboys
        ('VC21_DA_02', '49', 'Breach'),			-- Crws
        ('VC21_DA_02', '50', 'Astra'),			-- sScary
        
        -- Match 3
        -- ENVY (NV)
        ('VC21_DA_03', '56', 'Sova'),			-- crashies
        ('VC21_DA_03', '57', 'Skye'),			-- Victor
        ('VC21_DA_03', '58', 'Astra'),			-- Marved
        ('VC21_DA_03', '59', 'Killjoy'),		-- FiNESSE
        ('VC21_DA_03', '60', 'Jett'),			-- yay
        -- X10 Esports (X10)
        ('VC21_DA_03', '46', 'Skye'),			-- foxz
        ('VC21_DA_03', '47', 'Jett'),			-- Patiphan
        ('VC21_DA_03', '48', 'Killjoy'),		-- Sushiboys
        ('VC21_DA_03', '49', 'Breach'),			-- Crws
        ('VC21_DA_03', '50', 'Astra'),			-- sScary
        
        -- Group B --
        -- Opening (B)
        -- SEN vs FUR
        -- Match 1
        -- Sentinels (SEN)
        ('VC21_OB_01', '1', 'Sova'),			-- ShahZaM
        ('VC21_OB_01', '2', 'Skye'),			-- SicK
        ('VC21_OB_01', '3', 'Jett'),			-- TenZ
        ('VC21_OB_01', '4', 'Astra'),			-- zombs
        ('VC21_OB_01', '5', 'Cypher'),			-- dapr
        -- FURIA (FUR)
        ('VC21_OB_01', '128', 'Jett'),			-- xand
        ('VC21_OB_01', '129', 'Sova'),			-- nzr
        ('VC21_OB_01', '130', 'Sage'),			-- Quick
        ('VC21_OB_01', '131', 'Killjoy'),		-- Khalil
        ('VC21_OB_01', '132', 'Astra'),			-- mazin
        
        -- Match 2
        -- Sentinels (SEN)
        ('VC21_OB_02', '1', 'Sova'),			-- ShahZaM
        ('VC21_OB_02', '2', 'Skye'),			-- SicK
        ('VC21_OB_02', '3', 'Jett'),			-- TenZ
        ('VC21_OB_02', '4', 'Viper'),			-- zombs
        ('VC21_OB_02', '5', 'Cypher'),			-- dapr
        -- FURIA (FUR)
        ('VC21_OB_02', '128', 'Jett'),			-- xand
        ('VC21_OB_02', '129', 'Sova'),			-- nzr
        ('VC21_OB_02', '130', 'Viper'),			-- Quick
        ('VC21_OB_02', '131', 'Killjoy'),		-- Khalil
        ('VC21_OB_02', '132', 'Skye'),			-- mazin
        
        -- Match 3
        -- Sentinels (SEN)
        ('VC21_OB_03', '1', 'Sova'),			-- ShahZaM
        ('VC21_OB_03', '2', 'Skye'),			-- SicK
        ('VC21_OB_03', '3', 'Jett'),			-- TenZ
        ('VC21_OB_03', '4', 'Astra'),			-- zombs
        ('VC21_OB_03', '5', 'Cypher'),			-- dapr
        -- FURIA (FUR)
        ('VC21_OB_03', '128', 'Jett'),			-- xand
        ('VC21_OB_03', '129', 'Sova'),			-- nzr
        ('VC21_OB_03', '130', 'Skye'),			-- Quick
        ('VC21_OB_03', '131', 'Killjoy'),		-- Khalil
        ('VC21_OB_03', '132', 'Astra'),			-- mazin


        -- KRU vs TL
        -- Match 4
        -- KRU Esports (KRU)
        ('VC21_OB_04', '36', 'Jett'),			-- NagZ
        ('VC21_OB_04', '38', 'Astra'),			-- delz1k
        ('VC21_OB_04', '39', 'Killjoy'),		-- Klaus
        ('VC21_OB_04', '40', 'Sova'),			-- Mazino
        ('VC21_OB_04', '71', 'Reyna'),			-- keznit
        -- Team Liquid (TL)
        ('VC21_OB_04', '11', 'Jett'),			-- ScreaM
        ('VC21_OB_04', '13', 'Astra'),			-- L1NK
        ('VC21_OB_04', '14', 'KAY/O'),			-- soulcas
        ('VC21_OB_04', '15', 'Killjoy'),		-- Jamppi
        ('VC21_OB_04', '123', 'Sova'),			-- Nivera
        
        -- Match 5
        -- KRU Esports (KRU)
        ('VC21_OB_05', '36', 'Jett'),			-- NagZ
        ('VC21_OB_05', '38', 'Astra'),			-- delz1k
        ('VC21_OB_05', '39', 'Killjoy'),		-- Klaus
        ('VC21_OB_05', '40', 'Sova'),			-- Mazino
        ('VC21_OB_05', '71', 'Reyna'),			-- keznit
        -- Team Liquid (TL)
        ('VC21_OB_05', '11', 'Reyna'),			-- ScreaM
        ('VC21_OB_05', '13', 'Astra'),			-- L1NK
        ('VC21_OB_05', '14', 'Sova'),			-- soulcas
        ('VC21_OB_05', '15', 'Jett'),			-- Jamppi
        ('VC21_OB_05', '123', 'Killjoy'),		-- Nivera
        
        -- Winners (B)
        -- TL vs SEN
        -- Match 1
        -- Team Liquid (TL)
        ('VC21_WB_01', '11', 'Cypher'),			-- ScreaM
        ('VC21_WB_01', '13', 'Jett'),			-- L1NK
        ('VC21_WB_01', '14', 'KAY/O'),			-- soulcas
        ('VC21_WB_01', '15', 'Sova'),			-- Jamppi
        ('VC21_WB_01', '123', 'Viper'),			-- Nivera
        -- Sentinels (SEN)
        ('VC21_WB_01', '1', 'Sova'),			-- ShahZaM
        ('VC21_WB_01', '2', 'Skye'),			-- SicK
        ('VC21_WB_01', '3', 'Jett'),			-- TenZ
        ('VC21_WB_01', '4', 'Viper'),			-- zombs
        ('VC21_WB_01', '5', 'Killjoy'),			-- dapr
        
        -- Match 2
        -- Team Liquid (TL)
        ('VC21_WB_02', '11', 'Jett'),			-- ScreaM
        ('VC21_WB_02', '13', 'Astra'),			-- L1NK
        ('VC21_WB_02', '14', 'KAY/O'),			-- soulcas
        ('VC21_WB_02', '15', 'Sova'),			-- Jamppi
        ('VC21_WB_02', '123', 'Viper'),			-- Nivera
        -- Sentinels (SEN)
        ('VC21_WB_02', '1', 'Sova'),			-- ShahZaM
        ('VC21_WB_02', '2', 'Skye'),			-- SicK
        ('VC21_WB_02', '3', 'Jett'),			-- TenZ
        ('VC21_WB_02', '4', 'Astra'),			-- zombs
        ('VC21_WB_02', '5', 'Viper'),			-- dapr
        
        -- Match 3
        -- Team Liquid (TL)
        ('VC21_WB_03', '11', 'Reyna'),			-- ScreaM
        ('VC21_WB_03', '13', 'Breach'),			-- L1NK
        ('VC21_WB_03', '14', 'Raze'),			-- soulcas
        ('VC21_WB_03', '15', 'Astra'),			-- Jamppi
        ('VC21_WB_03', '123', 'Viper'),			-- Nivera
        -- Sentinels (SEN)
        ('VC21_WB_03', '1', 'Skye'),			-- ShahZaM
        ('VC21_WB_03', '2', 'Sage'),			-- SicK
        ('VC21_WB_03', '3', 'Jett'),			-- TenZ
        ('VC21_WB_03', '4', 'Astra'),			-- zombs
        ('VC21_WB_03', '5', 'Viper'),			-- dapr


        -- Elimination (B)
        -- KRU vs FUR
        -- Match 1
        -- KRU Esports (KRU)
        ('VC21_EB_01', '36', 'Jett'),			-- NagZ
        ('VC21_EB_01', '38', 'Astra'),			-- delz1k
        ('VC21_EB_01', '39', 'Viper'),			-- Klaus
        ('VC21_EB_01', '40', 'Cypher'),			-- Mazino
        ('VC21_EB_01', '71', 'Breach'),			-- keznit
        -- FURIA (FUR)
        ('VC21_EB_01', '128', 'Jett'),			-- xand
        ('VC21_EB_01', '129', 'Viper'),			-- nzr
        ('VC21_EB_01', '130', 'Cypher'),			-- Quick
        ('VC21_EB_01', '131', 'Astra'),			-- Khalil
        ('VC21_EB_01', '132', 'Breach'),			-- mazin
        
        -- Match 2
        -- KRU Esports (KRU)
        ('VC21_EB_02', '36', 'Jett'),			-- NagZ
        ('VC21_EB_02', '38', 'Astra'),			-- delz1k
        ('VC21_EB_02', '39', 'Killjoy'),		-- Klaus
        ('VC21_EB_02', '40', 'Sova'),			-- Mazino
        ('VC21_EB_02', '71', 'Reyna'),			-- keznit
        -- FURIA (FUR)
        ('VC21_EB_02', '128', 'Jett'),			-- xand
        ('VC21_EB_02', '129', 'Sova'),			-- nzr
        ('VC21_EB_02', '130', 'Sage'),			-- Quick
        ('VC21_EB_02', '131', 'Killjoy'),		-- Khalil
        ('VC21_EB_02', '132', 'Astra'),			-- mazin

        -- Match 3
        -- KRU Esports (KRU)
        ('VC21_EB_03', '36', 'Jett'),			-- NagZ
        ('VC21_EB_03', '38', 'Astra'),			-- delz1k
        ('VC21_EB_03', '39', 'Killjoy'),		-- Klaus
        ('VC21_EB_03', '40', 'Sova'),			-- Mazino
        ('VC21_EB_03', '71', 'Reyna'),			-- keznit
        -- FURIA (FUR)
        ('VC21_EB_03', '128', 'Jett'),			-- xand
        ('VC21_EB_03', '129', 'Sova'),			-- nzr
        ('VC21_EB_03', '130', 'Skye'),			-- Quick
        ('VC21_EB_03', '131', 'Killjoy'),		-- Khalil
        ('VC21_EB_03', '132', 'Astra')	,		-- mazin


        -- Decider (B)
        -- SEN vs KRU
        -- Match 1
        -- Sentinels (SEN)
        ('VC21_DB_01', '1', 'Breach'),			-- ShahZaM
        ('VC21_DB_01', '2', 'Skye'),			-- SicK
        ('VC21_DB_01', '3', 'Jett'),			-- TenZ
        ('VC21_DB_01', '4', 'Viper'),			-- zombs
        ('VC21_DB_01', '5', 'Killjoy'),			-- dapr
        -- KRU Esports (KRU)
        ('VC21_DB_01', '36', 'Jett'),			-- NagZ
        ('VC21_DB_01', '38', 'Astra'),			-- delz1k
        ('VC21_DB_01', '39', 'Viper'),			-- Klaus
        ('VC21_DB_01', '40', 'Cypher'),			-- Mazino
        ('VC21_DB_01', '71', 'Breach'),			-- keznit
        
        -- Match 2
        -- Sentinels (SEN)
        ('VC21_DB_02', '1', 'Sova'),			-- ShahZaM
        ('VC21_DB_02', '2', 'Skye'),			-- SicK
        ('VC21_DB_02', '3', 'Jett'),			-- TenZ
        ('VC21_DB_02', '4', 'Astra'),			-- zombs
        ('VC21_DB_02', '5', 'Cypher'),			-- dapr
        -- KRU Esports (KRU)
        ('VC21_DB_02', '36', 'Jett'),			-- NagZ
        ('VC21_DB_02', '38', 'Astra'),			-- delz1k
        ('VC21_DB_02', '39', 'Killjoy'),		-- Klaus
        ('VC21_DB_02', '40', 'Sova'),			-- Mazino
        ('VC21_DB_02', '71', 'Reyna'),			-- keznit
        
        -- Match 3
        -- Sentinels (SEN)
        ('VC21_DB_03', '1', 'Skye'),			-- ShahZaM
        ('VC21_DB_03', '2', 'Sage'),			-- SicK
        ('VC21_DB_03', '3', 'Jett'),			-- TenZ
        ('VC21_DB_03', '4', 'Astra'),			-- zombs
        ('VC21_DB_03', '5', 'Viper'),			-- dapr
        -- KRU Esports (KRU)
        ('VC21_DB_03', '36', 'Jett'),			-- NagZ
        ('VC21_DB_03', '38', 'Astra'),			-- delz1k
        ('VC21_DB_03', '39', 'Viper'),			-- Klaus
        ('VC21_DB_03', '40', 'Skye'),			-- Mazino
        ('VC21_DB_03', '71', 'Raze'),			-- keznit
        
        -- Group C --
        -- Opening (C)
        -- VKS1 vs CR
        -- Match 1
        -- Team Vikings (VKS1)
        ('VC21_OC_01', '21', 'Reyna'),			-- frz
        ('VC21_OC_01', '22', 'Sova'),			-- Sacy
        ('VC21_OC_01', '23', 'Sage'),			-- saadhak
        ('VC21_OC_01', '24', 'Jett'),			-- gtn
        ('VC21_OC_01', '25', 'Viper'),			-- sutecas
        -- Crazy Raccoon (CR)
        ('VC21_OC_01', '41', 'KAY/O'),			-- Munchkin
        ('VC21_OC_01', '45', 'Sage'),			-- neth
        ('VC21_OC_01', '112', 'Sova'),			-- Bazzi
        ('VC21_OC_01', '113', 'Viper'),			-- ade
        ('VC21_OC_01', '114', 'Jett'),			-- Fisker
        
        -- Match 2
        -- Team Vikings (VKS1)
        ('VC21_OC_02', '21', 'Skye'),			-- frz
        ('VC21_OC_02', '22', 'Breach'),			-- Sacy
        ('VC21_OC_02', '23', 'Killjoy'),		-- saadhak
        ('VC21_OC_02', '24', 'Jett'),			-- gtn
        ('VC21_OC_02', '25', 'Astra'),			-- sutecas
        -- Crazy Raccoon (CR)
        ('VC21_OC_02', '41', 'Sova'),			-- Munchkin
        ('VC21_OC_02', '44', 'Killjoy'),		-- Medusa
        ('VC21_OC_02', '45', 'Breach'),			-- neth
        ('VC21_OC_02', '113', 'Astra'),			-- ade
        ('VC21_OC_02', '114', 'Jett'),			-- Fisker


        -- GMB vs TS
        -- Match 3
        -- Gambit Esports (GMB)
        ('VC21_OC_03', '77', 'Jett'),			-- d3ffo
        ('VC21_OC_03', '78', 'Viper'),			-- nAts
        ('VC21_OC_03', '79', 'Sova'),			-- Chronicle
        ('VC21_OC_03', '80', 'Sage'),			-- Redgar
        ('VC21_OC_03', '81', 'Reyna'),			-- sheydos
        -- Team Secret (TS)
        ('VC21_OC_03', '102', 'Viper'),			-- BORKUM
        ('VC21_OC_03', '103', 'Sova'),			-- JessieVash
        ('VC21_OC_03', '104', 'Sage'),			-- dispenser
        ('VC21_OC_03', '105', 'Jett'),			-- DubsteP
        ('VC21_OC_03', '106', 'Reyna'),			-- Witz
        
        -- Match 4
        -- Gambit Esports (GMB)
        ('VC21_OC_04', '77', 'Jett'),			-- d3ffo
        ('VC21_OC_04', '78', 'Viper'),			-- nAts
        ('VC21_OC_04', '79', 'Killjoy'),		-- Chronicle
        ('VC21_OC_04', '80', 'Sova'),			-- Redgar
        ('VC21_OC_04', '81', 'Skye'),			-- sheydos
        -- Team Secret (TS)
        ('VC21_OC_04', '102', 'Viper'),			-- BORKUM
        ('VC21_OC_04', '103', 'Sova'),			-- JessieVash
        ('VC21_OC_04', '104', 'Cypher'),			-- dispenser
        ('VC21_OC_04', '105', 'Jett'),			-- DubsteP
        ('VC21_OC_04', '106', 'Skye'),			-- Witz
        
        -- Match 5
        -- Gambit Esports (GMB)
        ('VC21_OC_05', '77', 'Jett'),			-- d3ffo
        ('VC21_OC_05', '78', 'Viper'),			-- nAts
        ('VC21_OC_05', '79', 'Sova'),			-- Chronicle
        ('VC21_OC_05', '80', 'Astra'),			-- Redgar
        ('VC21_OC_05', '81', 'Skye'),			-- sheydos
        -- Team Secret (TS)
        ('VC21_OC_05', '102', 'Astra'),			-- BORKUM
        ('VC21_OC_05', '103', 'Sova'),			-- JessieVash
        ('VC21_OC_05', '104', 'Killjoy'),		-- dispenser
        ('VC21_OC_05', '105', 'Jett'),			-- DubsteP
        ('VC21_OC_05', '106', 'Skye'),			-- Witz


        -- Winners (C)
        -- GMB vs VKS1
        -- Match 1
        -- Gambit Esports (GMB)
        ('VC21_WC_01', '77', 'Jett'),			-- d3ffo
        ('VC21_WC_01', '78', 'Viper'),			-- nAts
        ('VC21_WC_01', '79', 'Killjoy'),		-- Chronicle
        ('VC21_WC_01', '80', 'Astra'),			-- Redgar
        ('VC21_WC_01', '81', 'Skye'),			-- sheydos
        -- Team Vikings (VKS1)
        ('VC21_WC_01', '21', 'Sage'),			-- frz
        ('VC21_WC_01', '22', 'Breach'),			-- Sacy
        ('VC21_WC_01', '23', 'Killjoy'),		-- saadhak
        ('VC21_WC_01', '24', 'Raze'),			-- gtn
        ('VC21_WC_01', '25', 'Astra'),			-- sutecas
        
        -- Match 2
        -- Gambit Esports (GMB)
        ('VC21_WC_02', '77', 'Jett'),			-- d3ffo
        ('VC21_WC_02', '78', 'Viper'),			-- nAts
        ('VC21_WC_02', '79', 'Sova'),			-- Chronicle
        ('VC21_WC_02', '80', 'Astra'),			-- Redgar
        ('VC21_WC_02', '81', 'Skye'),			-- sheydos
        -- Team Vikings (VKS1)
        ('VC21_WC_02', '21', 'Skye'),			-- frz
        ('VC21_WC_02', '22', 'Sova'),			-- Sacy
        ('VC21_WC_02', '23', 'Viper'),			-- saadhak
        ('VC21_WC_02', '24', 'Raze'),			-- gtn
        ('VC21_WC_02', '25', 'Astra'),			-- sutecas
        
        -- Match 3
        -- Gambit Esports (GMB)
        ('VC21_WC_03', '77', 'Jett'),			-- d3ffo
        ('VC21_WC_03', '78', 'Viper'),			-- nAts
        ('VC21_WC_03', '79', 'Sova'),			-- Chronicle
        ('VC21_WC_03', '80', 'Sage'),			-- Redgar
        ('VC21_WC_03', '81', 'Reyna'),			-- sheydos
        -- Team Vikings (VKS1)
        ('VC21_WC_03', '21', 'Reyna'),			-- frz
        ('VC21_WC_03', '22', 'Sova'),			-- Sacy
        ('VC21_WC_03', '23', 'Sage'),			-- saadhak
        ('VC21_WC_03', '24', 'Jett'),			-- gtn
        ('VC21_WC_03', '25', 'Viper'),			-- sutecas


        -- Elimination (C)
        -- TS vs CR
        -- Match 1
        -- Team Secret (TS)
        ('VC21_EC_01', '102', 'Omen'),			-- BORKUM
        ('VC21_EC_01', '103', 'Sage'),			-- JessieVash
        ('VC21_EC_01', '104', 'Cypher'),			-- dispenser
        ('VC21_EC_01', '105', 'Jett'),			-- DubsteP
        ('VC21_EC_01', '106', 'Raze'),			-- Witz
        -- Crazy Raccoon (CR)
        ('VC21_EC_01', '41', 'Cypher'),			-- Munchkin
        ('VC21_EC_01', '45', 'Breach'),			-- neth
        ('VC21_EC_01', '112', 'Sova'),			-- Bazzi
        ('VC21_EC_01', '113', 'Astra'),			-- ade
        ('VC21_EC_01', '114', 'Jett'),			-- Fisker
        
        -- Match 2
        -- Team Secret (TS)
        ('VC21_EC_02', '102', 'Astra'),			-- BORKUM
        ('VC21_EC_02', '103', 'Sova'),			-- JessieVash
        ('VC21_EC_02', '104', 'Killjoy'),		-- dispenser
        ('VC21_EC_02', '105', 'Jett'),			-- DubsteP
        ('VC21_EC_02', '106', 'Breach'),			-- Witz
        -- Crazy Raccoon (CR)
        ('VC21_EC_02', '41', 'Sova'),			-- Munchkin
        ('VC21_EC_02', '44', 'Killjoy'),		-- Medusa
        ('VC21_EC_02', '45', 'Breach'),			-- neth
        ('VC21_EC_02', '113', 'Astra'),			-- ade
        ('VC21_EC_02', '114', 'Jett'),			-- Fisker


        -- Decider (C)
        -- VKS1 vs TS
        -- Match 1
        -- Team Vikings (VKS1)
        ('VC21_DC_01', '21', 'Skye'),			-- frz
        ('VC21_DC_01', '22', 'Breach'),			-- Sacy
        ('VC21_DC_01', '23', 'Killjoy'),		-- saadhak
        ('VC21_DC_01', '24', 'Jett'),			-- gtn
        ('VC21_DC_01', '25', 'Astra'),			-- sutecas
        -- Team Secret (TS)
        ('VC21_DC_01', '102', 'Astra'),			-- BORKUM
        ('VC21_DC_01', '103', 'Sova'),			-- JessieVash
        ('VC21_DC_01', '104', 'Killjoy'),		-- dispenser
        ('VC21_DC_01', '105', 'Jett'),			-- DubsteP
        ('VC21_DC_01', '106', 'Breach'),			-- Witz
        
        -- Match 2
        -- Team Vikings (VKS1)
        ('VC21_DC_02', '21', 'Reyna'),			-- frz
        ('VC21_DC_02', '22', 'Sova'),			-- Sacy
        ('VC21_DC_02', '23', 'Sage'),			-- saadhak
        ('VC21_DC_02', '24', 'Jett'),			-- gtn
        ('VC21_DC_02', '25', 'Viper'),			-- sutecas
        -- Team Secret (TS)
        ('VC21_DC_02', '102', 'Viper'),			-- BORKUM
        ('VC21_DC_02', '103', 'Sova'),			-- JessieVash
        ('VC21_DC_02', '104', 'Sage'),			-- dispenser
        ('VC21_DC_02', '105', 'Jett'),			-- DubsteP
        ('VC21_DC_02', '106', 'Reyna'),			-- Witz
        
        -- Group D --
        -- Opening (D)
        -- VS vs FS
        -- Match 1
        -- Vision Strikers (VS)
        ('VC21_OD_01', '61', 'Breach'),			-- stax
        ('VC21_OD_01', '62', 'Skye'),			-- Rb
        ('VC21_OD_01', '63', 'Killjoy'),		-- k1Ng
        ('VC21_OD_01', '64', 'Jett'),			-- BuZz
        ('VC21_OD_01', '65', 'Astra'),			-- MaKo
        -- FULL SENSE (FS)
        ('VC21_OD_01', '133', 'Breach'),		-- PTC
        ('VC21_OD_01', '134', 'Astra'),			-- SuperBusS
        ('VC21_OD_01', '135', 'Cypher'),		-- SantaGolf
        ('VC21_OD_01', '136', 'Jett'),			-- JohnOlsen
        ('VC21_OD_01', '137', 'Skye'),			-- LAMMYSNAX
        
        -- Match 2
        -- Vision Strikers (VS)
        ('VC21_OD_02', '61', 'Skye'),			-- stax
        ('VC21_OD_02', '62', 'Sova'),			-- Rb
        ('VC21_OD_02', '63', 'Cypher'),			-- k1Ng
        ('VC21_OD_02', '64', 'Jett'),			-- BuZz
        ('VC21_OD_02', '65', 'Viper'),			-- MaKo
        -- FULL SENSE (FS)
        ('VC21_OD_02', '133', 'Skye'),			-- PTC
        ('VC21_OD_02', '134', 'Viper'),			-- SuperBusS
        ('VC21_OD_02', '135', 'Cypher'),		-- SantaGolf
        ('VC21_OD_02', '136', 'Jett'),			-- JohnOlsen
        ('VC21_OD_02', '137', 'Sova'),			-- LAMMYSNAX


        -- FNC vs C9
        -- Match 3
        -- FNATIC (FNC)
        ('VC21_OD_03', '16', 'Sova'),			-- Boaster
        ('VC21_OD_03', '17', 'Sage'),			-- doma
        ('VC21_OD_03', '18', 'Viper'),			-- Mistic
        ('VC21_OD_03', '19', 'Killjoy'),		-- MAGNUM
        ('VC21_OD_03', '20', 'Jett'),			-- Derke
        -- Cloud9 (C9)
        ('VC21_OD_03', '10', 'Viper'),			-- vanity
        ('VC21_OD_03', '124', 'Sova'),			-- xeta
        ('VC21_OD_03', '125', 'Sage'),			-- mitch
        ('VC21_OD_03', '126', 'Raze'),			-- Xeppaa
        ('VC21_OD_03', '127', 'Jett'),			-- leaf
        
        -- Match 4
        -- FNATIC (FNC)
        ('VC21_OD_04', '16', 'Astra'),			-- Boaster
        ('VC21_OD_04', '17', 'KAY/O'),			-- doma
        ('VC21_OD_04', '18', 'Viper'),			-- Mistic
        ('VC21_OD_04', '19', 'Killjoy'),		-- MAGNUM
        ('VC21_OD_04', '20', 'Raze'),			-- Derke
        -- Cloud9 (C9)
        ('VC21_OD_04', '10', 'Astra'),			-- vanity
        ('VC21_OD_04', '124', 'Breach'),		-- xeta
        ('VC21_OD_04', '125', 'Killjoy'),		-- mitch
        ('VC21_OD_04', '126', 'Raze'),			-- Xeppaa
        ('VC21_OD_04', '127', 'Skye'),			-- leaf
        
        -- Match 5
        -- FNATIC (FNC)
        ('VC21_OD_05', '16', 'Viper'),			-- Boaster
        ('VC21_OD_05', '17', 'Breach'),			-- doma
        ('VC21_OD_05', '18', 'Astra'),			-- Mistic
        ('VC21_OD_05', '19', 'Cypher'),			-- MAGNUM
        ('VC21_OD_05', '20', 'Raze'),			-- Derke
        -- Cloud9 (C9)
        ('VC21_OD_05', '10', 'Astra'),			-- vanity
        ('VC21_OD_05', '124', 'Breach'),		-- xeta
        ('VC21_OD_05', '125', 'Killjoy'),		-- mitch
        ('VC21_OD_05', '126', 'Raze'),			-- Xeppaa
        ('VC21_OD_05', '127', 'Skye'),			-- leaf


        -- Winners (D)
        -- VS vs FNC
        -- Match 1
        -- Vision Strikers (VS)
        ('VC21_WD_01', '27', 'Sova'),			-- Lakia 
        ('VC21_WD_01', '61', 'KAY/O'),			-- stax
        ('VC21_WD_01', '62', 'Sage'),			-- Rb
        ('VC21_WD_01', '64', 'Jett'),			-- BuZz
        ('VC21_WD_01', '65', 'Viper'),			-- MaKo
        -- FNATIC (FNC)
        ('VC21_WD_01', '16', 'Sova'),			-- Boaster
        ('VC21_WD_01', '17', 'Skye'),			-- doma
        ('VC21_WD_01', '18', 'Viper'),			-- Mistic
        ('VC21_WD_01', '19', 'Killjoy'),		-- MAGNUM
        ('VC21_WD_01', '20', 'Jett'),			-- Derke
        
        -- Match 2
        -- Vision Strikers (VS)
        ('VC21_WD_02', '61', 'Breach'),			-- stax
        ('VC21_WD_02', '62', 'Skye'),			-- Rb
        ('VC21_WD_02', '63', 'Killjoy'),		-- k1Ng
        ('VC21_WD_02', '64', 'Jett'),			-- BuZz
        ('VC21_WD_02', '65', 'Astra'),			-- MaKo
        -- FNATIC (FNC)
        ('VC21_WD_02', '16', 'Sova'),			-- Boaster
        ('VC21_WD_02', '17', 'Skye'),			-- doma
        ('VC21_WD_02', '18', 'Astra'),			-- Mistic
        ('VC21_WD_02', '19', 'Killjoy'),		-- MAGNUM
        ('VC21_WD_02', '20', 'Raze'),			-- Derke
        
        -- Match 3
        -- Vision Strikers (VS)
        ('VC21_WD_03', '61', 'Breach'),			-- stax
        ('VC21_WD_03', '62', 'Skye'),			-- Rb
        ('VC21_WD_03', '63', 'Killjoy'),		-- k1Ng
        ('VC21_WD_03', '64', 'Jett'),			-- BuZz
        ('VC21_WD_03', '65', 'Astra'),			-- MaKo
        -- FNATIC (FNC)
        ('VC21_WD_03', '16', 'Viper'),			-- Boaster
        ('VC21_WD_03', '17', 'Breach'),			-- doma
        ('VC21_WD_03', '18', 'Astra'),			-- Mistic
        ('VC21_WD_03', '19', 'Cypher'),			-- MAGNUM
        ('VC21_WD_03', '20', 'Raze'),			-- Derke


        -- Elimination (D)
        -- FS vs C9
        -- Match 1
        -- FULL SENSE (FS)
        ('VC21_ED_01', '133', 'Breach'),		-- PTC
        ('VC21_ED_01', '134', 'Astra'),			-- SuperBusS
        ('VC21_ED_01', '135', 'Cypher'),		-- SantaGolf
        ('VC21_ED_01', '136', 'Jett'),			-- JohnOlsen
        ('VC21_ED_01', '137', 'Viper'),			-- LAMMYSNAX
        -- Cloud9 (C9)
        ('VC21_ED_01', '10', 'Astra'),			-- vanity
        ('VC21_ED_01', '124', 'Breach'),		-- xeta
        ('VC21_ED_01', '125', 'Killjoy'),		-- mitch
        ('VC21_ED_01', '126', 'Raze'),			-- Xeppaa
        ('VC21_ED_01', '127', 'Skye'),			-- leaf
        
        -- Match 2
        -- FULL SENSE (FS)
        ('VC21_ED_02', '133', 'Jett'),			-- PTC
        ('VC21_ED_02', '134', 'Viper'),			-- SuperBusS
        ('VC21_ED_02', '135', 'Cypher'),		-- SantaGolf
        ('VC21_ED_02', '136', 'Skye'),			-- JohnOlsen
        ('VC21_ED_02', '137', 'Sova'),			-- LAMMYSNAX
        -- Cloud9 (C9)
        ('VC21_ED_02', '10', 'Viper'),			-- vanity
        ('VC21_ED_02', '124', 'Sova'),			-- xeta
        ('VC21_ED_02', '125', 'Cypher'),		-- mitch
        ('VC21_ED_02', '126', 'KAY/O'),			-- Xeppaa
        ('VC21_ED_02', '127', 'Jett'),			-- leaf


        -- Decider (D)
        -- VS vs C9
        -- Match 1
        -- Vision Strikers (VS)
        ('VC21_DD_01', '61', 'KAY/O'),			-- stax
        ('VC21_DD_01', '62', 'Sova'),			-- Rb
        ('VC21_DD_01', '63', 'Killjoy'),		-- k1Ng
        ('VC21_DD_01', '64', 'Jett'),			-- BuZz
        ('VC21_DD_01', '65', 'Astra'),			-- MaKo
        -- Cloud9 (C9)
        ('VC21_DD_01', '10', 'Astra'),			-- vanity
        ('VC21_DD_01', '124', 'Sova'),			-- xeta
        ('VC21_DD_01', '125', 'Killjoy'),		-- mitch
        ('VC21_DD_01', '126', 'KAY/O'),			-- Xeppaa
        ('VC21_DD_01', '127', 'Jett'),			-- leaf
        
        -- Match 2
        -- Vision Strikers (VS)
        ('VC21_DD_02', '61', 'Skye'),			-- stax
        ('VC21_DD_02', '62', 'Sage'),			-- Rb
        ('VC21_DD_02', '63', 'Astra'),			-- k1Ng
        ('VC21_DD_02', '64', 'Raze'),			-- BuZz
        ('VC21_DD_02', '65', 'Viper'),			-- MaKo
        -- Cloud9 (C9)
        ('VC21_DD_02', '10', 'Astra'),			-- vanity
        ('VC21_DD_02', '124', 'Breach'),		-- xeta
        ('VC21_DD_02', '125', 'Killjoy'),		-- mitch
        ('VC21_DD_02', '126', 'Raze'),			-- Xeppaa
        ('VC21_DD_02', '127', 'Skye'),			-- leaf
        
        -- Match 3
        -- Vision Strikers (VS)
        ('VC21_DD_03', '61', 'Skye'),			-- stax
        ('VC21_DD_03', '62', 'Sova'),			-- Rb
        ('VC21_DD_03', '63', 'Cypher'),			-- k1Ng
        ('VC21_DD_03', '64', 'Jett'),			-- BuZz
        ('VC21_DD_03', '65', 'Viper'),			-- MaKo
        -- Cloud9 (C9)
        ('VC21_DD_03', '10', 'Viper'),			-- vanity
        ('VC21_DD_03', '124', 'Sova'),			-- xeta
        ('VC21_DD_03', '125', 'Cypher'),		-- mitch
        ('VC21_DD_03', '126', 'KAY/O'),			-- Xeppaa
        ('VC21_DD_03', '127', 'Jett');			-- leaf
        
SELECT * FROM matches
ORDER BY match_date, match_time;

SELECT * FROM agent_pick;