CREATE OR REPLACE PROCEDURE recalculate_race_ratings
AS
BEGIN
    UPDATE race 
    SET average_rating = (
        SELECT ROUND(AVG(rating), 2)
        FROM race_participation 
        WHERE race_participation.race_id = race.race_id 
        AND rating IS NOT NULL
    );
    COMMIT;
END recalculate_race_ratings;
/

BEGIN
    recalculate_race_ratings;
END;
/

INSERT INTO change_log (created_by, script_name, script_details) 
VALUES ('Labib', '005_recalculate_race_ratings.sql', 
'Created recalculate_race_ratings() procedure to update average ratings.');

COMMIT;