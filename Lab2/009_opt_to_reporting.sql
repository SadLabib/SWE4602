INSERT INTO dim_player (player_id, player_name)
SELECT player_id, player_name FROM player;

INSERT INTO dim_race (race_id, race_name, city, average_rating)
SELECT race_id, race_name, city, average_rating FROM race;

INSERT INTO dim_car (car_id, car_name, player_id)
SELECT car_id, car_name, player_id FROM car;

INSERT INTO dim_part (part_id, part_name, part_type)
SELECT part_id, part_name, part_type FROM part;

INSERT INTO dim_time (
    time_id, date_value, day_of_month, month_num, quarter, year, weekday
)
SELECT 
    seq_time_id.NEXTVAL,
    date_value,
    day_of_month,
    month_num,
    quarter,
    year,
    weekday
FROM (
    SELECT DISTINCT 
        TRUNC(completed_at) AS date_value,
        EXTRACT(DAY FROM completed_at) AS day_of_month,
        EXTRACT(MONTH FROM completed_at) AS month_num,
        CEIL(EXTRACT(MONTH FROM completed_at)/3) AS quarter,
        EXTRACT(YEAR FROM completed_at) AS year,
        TO_CHAR(completed_at, 'DAY') AS weekday
    FROM race_participation 
    WHERE completed_at IS NOT NULL
);


INSERT INTO dim_ratings (rating_id, player_id, race_id, rating)
SELECT 
    seq_rating_id.NEXTVAL,
    c.player_id,
    rp.race_id,
    rp.rating
FROM race_participation rp
JOIN car c ON rp.car_id = c.car_id
WHERE rp.rating IS NOT NULL;

INSERT INTO fact_race_participation (
    participation_id, player_id, race_id, car_id, time_id, rating_id,
    completed_at, rating_timestamp, rating_value, reward_points, duration_minutes
)
SELECT 
    seq_participation_id.NEXTVAL,
    c.player_id,
    rp.race_id,
    rp.car_id,
    t.time_id,
    r.rating_id,
    rp.completed_at,
    rp.rating_timestamp,
    rp.rating,
    CASE 
        WHEN rp.rating >= 4 THEN 150
        WHEN rp.rating >= 3 THEN 100
        ELSE 50
    END as reward_points,
    CASE 
        WHEN dr.city = 'NeoTokyo' THEN 25
        WHEN dr.city = 'Skyline Bay' THEN 35
        WHEN dr.city = 'Mecha Hills' THEN 40
        ELSE 30
    END as duration_minutes
FROM race_participation rp
JOIN car c ON rp.car_id = c.car_id
JOIN dim_race dr ON rp.race_id = dr.race_id
LEFT JOIN dim_time t ON TRUNC(rp.completed_at) = t.date_value
LEFT JOIN dim_ratings r ON (c.player_id = r.player_id AND rp.race_id = r.race_id AND rp.rating = r.rating);

INSERT INTO fact_race_rewards (reward_id, race_id, part_id, reward_points)
SELECT 
    seq_reward_id.NEXTVAL,
    rr.race_id,
    rr.part_id,
    CASE 
        WHEN dp.part_type = 'Engine' THEN 200
        WHEN dp.part_type = 'Turbo' THEN 150
        WHEN dp.part_type = 'Tire' THEN 100
        WHEN dp.part_type = 'Suspension' THEN 120
        ELSE 80
    END as reward_points
FROM race_rewards rr
JOIN dim_part dp ON rr.part_id = dp.part_id;

INSERT INTO change_log (created_by, script_name, script_details) 
VALUES ('Sakib', '009_opt_to_reporting.sql', 
'Copy and transform data.');

COMMIT;

SELECT 'Completed successfully!' AS status FROM dual;