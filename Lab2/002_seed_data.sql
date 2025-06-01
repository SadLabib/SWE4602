INSERT INTO player (player_id, player_name) VALUES (1, 'Sadman');
INSERT INTO player (player_id, player_name) VALUES (2, 'Sakib');
INSERT INTO player (player_id, player_name) VALUES (3, 'Faiza');
INSERT INTO player (player_id, player_name) VALUES (4, 'Kashshaf');
INSERT INTO player (player_id, player_name) VALUES (5, 'Hamim');
INSERT INTO player (player_id, player_name) VALUES (6, 'Sani');
INSERT INTO player (player_id, player_name) VALUES (7, 'Nafisa');
INSERT INTO player (player_id, player_name) VALUES (8, 'Ishmaam');

INSERT INTO car (car_id, player_id, car_name) VALUES (1, 1, 'Lightning Bolt');
INSERT INTO car (car_id, player_id, car_name) VALUES (2, 1, 'Thunder Strike');
INSERT INTO car (car_id, player_id, car_name) VALUES (3, 2, 'Pink Panther');
INSERT INTO car (car_id, player_id, car_name) VALUES (4, 2, 'Speed Queen');
INSERT INTO car (car_id, player_id, car_name) VALUES (5, 3, 'Desert Storm');
INSERT INTO car (car_id, player_id, car_name) VALUES (6, 4, 'Night Rider');
INSERT INTO car (car_id, player_id, car_name) VALUES (7, 5, 'Golden Eagle');
INSERT INTO car (car_id, player_id, car_name) VALUES (8, 6, 'Silver Arrow');
INSERT INTO car (car_id, player_id, car_name) VALUES (9, 7, 'Fire Dragon');
INSERT INTO car (car_id, player_id, car_name) VALUES (10, 8, 'Ice Storm');

INSERT INTO part (part_id, part_name, part_type) VALUES (1, 'V8 Turbo Engine', 'Engine');
INSERT INTO part (part_id, part_name, part_type) VALUES (2, 'Racing Tires Pro', 'Tire');
INSERT INTO part (part_id, part_name, part_type) VALUES (3, 'Nitrous Boost', 'Turbo');
INSERT INTO part (part_id, part_name, part_type) VALUES (4, 'Sport Suspension', 'Suspension');
INSERT INTO part (part_id, part_name, part_type) VALUES (5, 'Ceramic Brakes', 'Brake');
INSERT INTO part (part_id, part_name, part_type) VALUES (6, 'V6 Hybrid Engine', 'Engine');
INSERT INTO part (part_id, part_name, part_type) VALUES (7, 'All-Weather Tires', 'Tire');
INSERT INTO part (part_id, part_name, part_type) VALUES (8, 'Twin Turbo Kit', 'Turbo');
INSERT INTO part (part_id, part_name, part_type) VALUES (9, 'Carbon Fiber Body', 'Body');
INSERT INTO part (part_id, part_name, part_type) VALUES (10, 'LED Headlights', 'Light');

INSERT INTO race (race_id, race_name, city) VALUES (1, 'Turbo Rally', 'NeoTokyo');
INSERT INTO race (race_id, race_name, city) VALUES (2, 'Skyline Showdown', 'Skyline Bay');
INSERT INTO race (race_id, race_name, city) VALUES (3, 'Mecha Circuit', 'Mecha Hills');
INSERT INTO race (race_id, race_name, city) VALUES (4, 'Solar Sprint', 'Solar Drift');
INSERT INTO race (race_id, race_name, city) VALUES (5, 'Night Run', 'NeoTokyo');
INSERT INTO race (race_id, race_name, city) VALUES (6, 'Bay Bridge Battle', 'Skyline Bay');
INSERT INTO race (race_id, race_name, city) VALUES (7, 'Hill Climb Challenge', 'Mecha Hills');
INSERT INTO race (race_id, race_name, city) VALUES (8, 'Desert Storm Race', 'Solar Drift');

INSERT INTO car_part (car_id, part_id) VALUES (1, 1);
INSERT INTO car_part (car_id, part_id) VALUES (1, 2);
INSERT INTO car_part (car_id, part_id) VALUES (1, 3);
INSERT INTO car_part (car_id, part_id) VALUES (2, 6);
INSERT INTO car_part (car_id, part_id) VALUES (2, 7);
INSERT INTO car_part (car_id, part_id) VALUES (3, 1);
INSERT INTO car_part (car_id, part_id) VALUES (3, 4);
INSERT INTO car_part (car_id, part_id) VALUES (4, 8);
INSERT INTO car_part (car_id, part_id) VALUES (5, 9);
INSERT INTO car_part (car_id, part_id) VALUES (6, 5);

INSERT INTO race_participation (car_id, race_id, completed_at, is_up_vote) VALUES (1, 1, TIMESTAMP '2024-12-01 14:30:00', 1);
INSERT INTO race_participation (car_id, race_id, completed_at, is_up_vote) VALUES (3, 1, TIMESTAMP '2024-12-01 14:32:00', 1);
INSERT INTO race_participation (car_id, race_id, completed_at, is_up_vote) VALUES (5, 2, TIMESTAMP '2024-12-02 16:15:00', 0);
INSERT INTO race_participation (car_id, race_id, completed_at, is_up_vote) VALUES (6, 3, TIMESTAMP '2024-12-03 18:45:00', 1);
INSERT INTO race_participation (car_id, race_id, completed_at, is_up_vote) VALUES (7, 4, TIMESTAMP '2024-12-04 12:20:00', NULL);
INSERT INTO race_participation (car_id, race_id, completed_at, is_up_vote) VALUES (8, 5, TIMESTAMP '2024-12-05 20:10:00', 1);
INSERT INTO race_participation (car_id, race_id, completed_at, is_up_vote) VALUES (9, 6, TIMESTAMP '2024-12-06 15:30:00', 0);
INSERT INTO race_participation (car_id, race_id, completed_at, is_up_vote) VALUES (10, 7, TIMESTAMP '2024-12-07 11:45:00', 1);

INSERT INTO race_rewards (race_id, part_id) VALUES (1, 3);
INSERT INTO race_rewards (race_id, part_id) VALUES (1, 2);
INSERT INTO race_rewards (race_id, part_id) VALUES (2, 4);
INSERT INTO race_rewards (race_id, part_id) VALUES (2, 9);
INSERT INTO race_rewards (race_id, part_id) VALUES (3, 1);
INSERT INTO race_rewards (race_id, part_id) VALUES (4, 8);
INSERT INTO race_rewards (race_id, part_id) VALUES (5, 5);
INSERT INTO race_rewards (race_id, part_id) VALUES (6, 10);
INSERT INTO race_rewards (race_id, part_id) VALUES (7, 6);
INSERT INTO race_rewards (race_id, part_id) VALUES (8, 7);

INSERT INTO change_log (created_by, script_name, script_details) 
VALUES (
    'Labib',
    '002_seed_data.sql', 
'Inserted sample data for SpeedVerse database.');

COMMIT;