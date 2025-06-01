CREATE TABLE dim_player (
    player_id NUMBER PRIMARY KEY,
    player_name VARCHAR2(100) NOT NULL
);

CREATE TABLE dim_race (
    race_id NUMBER PRIMARY KEY,
    race_name VARCHAR2(100) NOT NULL,
    city VARCHAR2(50) NOT NULL,
    average_rating NUMBER(3,2)
);

CREATE TABLE dim_car (
    car_id NUMBER PRIMARY KEY,
    car_name VARCHAR2(100) NOT NULL,
    player_id NUMBER NOT NULL
);

CREATE TABLE dim_part (
    part_id NUMBER PRIMARY KEY,
    part_name VARCHAR2(100) NOT NULL,
    part_type VARCHAR2(50) NOT NULL
);

CREATE TABLE dim_time (
    time_id NUMBER PRIMARY KEY,
    date_value DATE NOT NULL,
    day_of_month NUMBER NOT NULL,
    month_num NUMBER NOT NULL,
    quarter NUMBER NOT NULL,
    year NUMBER NOT NULL,
    weekday VARCHAR2(10) NOT NULL
);

CREATE TABLE dim_ratings (
    rating_id NUMBER PRIMARY KEY,
    player_id NUMBER NOT NULL,
    race_id NUMBER NOT NULL,
    rating NUMBER(1) CHECK (rating BETWEEN 1 AND 5)
);

CREATE TABLE fact_race_participation (
    participation_id NUMBER PRIMARY KEY,
    player_id NUMBER REFERENCES dim_player(player_id),
    race_id NUMBER REFERENCES dim_race(race_id),
    car_id NUMBER REFERENCES dim_car(car_id),
    time_id NUMBER REFERENCES dim_time(time_id),
    rating_id NUMBER REFERENCES dim_ratings(rating_id),
    completed_at TIMESTAMP,
    rating_timestamp TIMESTAMP,
    rating_value NUMBER(1),
    reward_points NUMBER DEFAULT 100,
    duration_minutes NUMBER DEFAULT 30
);

CREATE TABLE fact_race_rewards (
    reward_id NUMBER PRIMARY KEY,
    race_id NUMBER REFERENCES dim_race(race_id),
    part_id NUMBER REFERENCES dim_part(part_id),
    reward_points NUMBER DEFAULT 50
);

CREATE SEQUENCE seq_participation_id START WITH 1;
CREATE SEQUENCE seq_reward_id START WITH 1;
CREATE SEQUENCE seq_time_id START WITH 1;
CREATE SEQUENCE seq_rating_id START WITH 1;

INSERT INTO change_log (created_by, script_name, script_details) 
VALUES ('Labib', '008_create_star_schema.sql', 
'Created simplified star schema for reporting database with fact and dimension tables.');

COMMIT;

SELECT 'Reporting star schema created successfully!' AS status FROM dual;