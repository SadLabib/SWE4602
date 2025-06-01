SET SERVEROUTPUT ON;

EXEC city_wise_popular_races;
EXEC top_rewarded_players_by_city;
EXEC race_ratings_rewards_monthly;
EXEC player_activity_summary;
EXEC monthly_city_engagement;
EXEC frequent_high_reward_races;

INSERT INTO change_log (created_by, script_name, script_details) 
VALUES ('Labib', '011_call_procedures.sql', 'Executed all reporting procedures.');
COMMIT;