ALTER TABLE race ADD average_rating NUMBER(3,2);

INSERT INTO change_log (created_by, script_name, script_details) 
VALUES ('Faiza', '004_add_average_rating.sql', 'Added average_rating column to race table.');

COMMIT;