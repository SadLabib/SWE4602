CREATE OR REPLACE PROCEDURE add_race_rating(
    p_car_id IN NUMBER,
    p_race_id IN NUMBER,
    p_rating_value IN NUMBER
)
AS
BEGIN
    IF p_rating_value NOT BETWEEN 1 AND 5 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Rating must be between 1 and 5 stars');
    END IF;
    
    UPDATE race_participation 
    SET rating = p_rating_value, 
        rating_timestamp = CURRENT_TIMESTAMP
    WHERE car_id = p_car_id AND race_id = p_race_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'No participation record found for this car and race combination');
    END IF;
    
    COMMIT;
END add_race_rating;
/

INSERT INTO change_log (created_by, script_name, script_details) 
VALUES ('Sakib',
    '006_add_race_rating.sql', 
'Created add_race_rating() procedure to add or update individual race ratings.');

COMMIT;