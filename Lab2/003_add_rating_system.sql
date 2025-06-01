ALTER TABLE race_participation ADD rating NUMBER(1) CHECK (rating BETWEEN 1 AND 5);

ALTER TABLE race_participation ADD rating_timestamp TIMESTAMP;

UPDATE race_participation 
SET rating = CASE 
    WHEN is_up_vote = 1 THEN 4
    WHEN is_up_vote = 0 THEN 2
    ELSE NULL
END,
rating_timestamp = CASE 
    WHEN is_up_vote IS NOT NULL THEN completed_at
    ELSE NULL
END;

ALTER TABLE race_participation DROP COLUMN is_up_vote;

INSERT INTO change_log (created_by, script_name, script_details) VALUES (
'Sakib',
'003_add_rating_system.sql', 
'Modified race_participation table: 
Replaced is_up_vote column with rating column (1-5 stars) and added rating_timestamp column.');

COMMIT;