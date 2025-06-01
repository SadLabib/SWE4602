CREATE OR REPLACE FUNCTION get_race_average_rating(p_race_id IN NUMBER)
RETURN NUMBER
AS
    v_avg_rating NUMBER(3,2);
BEGIN
    SELECT ROUND(AVG(rating), 2) 
    INTO v_avg_rating
    FROM race_participation 
    WHERE race_id = p_race_id AND rating IS NOT NULL;
    
    RETURN v_avg_rating;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    WHEN OTHERS THEN
        RETURN NULL;
END get_race_average_rating;
/

INSERT INTO change_log (created_by, script_name, script_details) 
VALUES ('Faiza', '007_get_race_average_rating.sql', 
'Created get_race_average_rating() function to retrieve average rating for a specific race.');

COMMIT;