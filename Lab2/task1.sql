CREATE TABLE player (
    player_id NUMBER PRIMARY KEY,
    player_name VARCHAR2(100)
);

CREATE TABLE car (
    car_id NUMBER PRIMARY KEY,
    player_id NUMBER REFERENCES player(player_id),
    car_name VARCHAR2(100)
);

CREATE TABLE part (
    part_id NUMBER PRIMARY KEY,
    part_name VARCHAR2(100),
    part_type VARCHAR2(50)
);

CREATE TABLE car_part (
    car_id NUMBER REFERENCES car(car_id),
    part_id NUMBER REFERENCES part(part_id),
    PRIMARY KEY(car_id, part_id)
);

CREATE TABLE race (
    race_id NUMBER PRIMARY KEY,
    race_name VARCHAR2(100),
    city VARCHAR2(50)
);

CREATE TABLE race_participation (
    car_id NUMBER REFERENCES car(car_id),
    race_id NUMBER REFERENCES race(race_id),
    completed_at TIMESTAMP,
    is_up_vote NUMBER(1), 
    PRIMARY KEY(car_id, race_id)
);

CREATE TABLE race_rewards (
    race_id NUMBER REFERENCES race(race_id),
    part_id NUMBER REFERENCES part(part_id),
    PRIMARY KEY(race_id, part_id)
);



