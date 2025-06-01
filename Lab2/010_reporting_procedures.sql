CREATE OR REPLACE PROCEDURE city_wise_popular_races
AS
    CURSOR race_cursor IS
        SELECT 
            dr.city,
            dr.race_name,
            AVG(frp.rating_value) as avg_rating,
            COUNT(frp.participation_id) as participation_count,
            ROW_NUMBER() OVER (PARTITION BY dr.city ORDER BY AVG(frp.rating_value) DESC, COUNT(frp.participation_id) DESC) as rn
        FROM fact_race_participation frp
        JOIN dim_race dr ON frp.race_id = dr.race_id
        WHERE frp.rating_value IS NOT NULL
        GROUP BY dr.city, dr.race_name;
BEGIN
    DBMS_OUTPUT.PUT_LINE('4.(a) City-Wise Popular Race');
    
    FOR rec IN race_cursor LOOP
        IF rec.rn = 1 THEN
            DBMS_OUTPUT.PUT_LINE('City: ' || rec.city || 
                               ' | Race: ' || rec.race_name || 
                               ' | Avg Rating: ' || ROUND(rec.avg_rating, 2) ||
                               ' | Participants: ' || rec.participation_count);
        END IF;
    END LOOP;
END city_wise_popular_races;
/

CREATE OR REPLACE PROCEDURE top_rewarded_players_by_city
AS
    CURSOR player_cursor IS
        SELECT 
            dr.city,
            dp.player_name,
            SUM(frp.reward_points) as total_rewards,
            ROW_NUMBER() OVER (PARTITION BY dr.city ORDER BY SUM(frp.reward_points) DESC) as rn
        FROM fact_race_participation frp
        JOIN dim_player dp ON frp.player_id = dp.player_id
        JOIN dim_race dr ON frp.race_id = dr.race_id
        GROUP BY dr.city, dp.player_name;
BEGIN
    DBMS_OUTPUT.PUT_LINE('4.(b) Top 5 Most Rewarded Players: ');
    
    FOR rec IN player_cursor LOOP
        IF rec.rn <= 5 THEN
            DBMS_OUTPUT.PUT_LINE('City: ' || rec.city || 
                               ' | Player: ' || rec.player_name || 
                               ' | Total Rewards: ' || rec.total_rewards ||
                               ' | Rank: ' || rec.rn);
        END IF;
    END LOOP;
END top_rewarded_players_by_city;
/

CREATE OR REPLACE PROCEDURE race_ratings_rewards_monthly
AS
    CURSOR monthly_cursor IS
        SELECT 
            t.year,
            t.month_num,
            dr.race_name,
            AVG(frp.rating_value) as avg_rating,
            SUM(frp.reward_points) as total_rewards,
            COUNT(frp.participation_id) as total_participations
        FROM fact_race_participation frp
        JOIN dim_race dr ON frp.race_id = dr.race_id
        JOIN dim_time t ON frp.time_id = t.time_id
        WHERE frp.rating_value IS NOT NULL
        GROUP BY t.year, t.month_num, dr.race_name
        ORDER BY t.year, t.month_num, dr.race_name;
BEGIN
    DBMS_OUTPUT.PUT_LINE('4.(c) Race Ratings and Rewards Across Months:');
    
    FOR rec IN monthly_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('Year: ' || rec.year || 
                           ' | Month: ' || rec.month_num ||
                           ' | Race: ' || rec.race_name ||
                           ' | Avg Rating: ' || ROUND(rec.avg_rating, 2) ||
                           ' | Total Rewards: ' || rec.total_rewards ||
                           ' | Participations: ' || rec.total_participations);
    END LOOP;
END race_ratings_rewards_monthly;
/

CREATE OR REPLACE PROCEDURE player_activity_summary
AS
    CURSOR activity_cursor IS
        SELECT 
            dp.player_name,
            COUNT(frp.participation_id) as races_completed,
            SUM(frp.duration_minutes) as total_time_minutes,
            SUM(frp.reward_points) as total_reward_points,
            AVG(frp.rating_value) as avg_rating_given
        FROM fact_race_participation frp
        JOIN dim_player dp ON frp.player_id = dp.player_id
        GROUP BY dp.player_name
        ORDER BY total_reward_points DESC;
BEGIN
    DBMS_OUTPUT.PUT_LINE('4.(d) Player Activity Summary:');
    
    FOR rec IN activity_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('Player: ' || rec.player_name ||
                           ' | Races: ' || rec.races_completed ||
                           ' | Total Time: ' || rec.total_time_minutes || ' mins' ||
                           ' | Rewards: ' || rec.total_reward_points ||
                           ' | Avg Rating: ' || ROUND(rec.avg_rating_given, 2));
    END LOOP;
END player_activity_summary;
/

CREATE OR REPLACE PROCEDURE monthly_city_engagement
AS
    CURSOR engagement_cursor IS
        SELECT 
            t.year,
            t.month_num,
            dr.city,
            COUNT(DISTINCT dp.player_id) as unique_players,
            COUNT(frp.participation_id) as total_participations,
            AVG(frp.rating_value) as avg_city_rating
        FROM fact_race_participation frp
        JOIN dim_player dp ON frp.player_id = dp.player_id
        JOIN dim_race dr ON frp.race_id = dr.race_id
        JOIN dim_time t ON frp.time_id = t.time_id
        GROUP BY t.year, t.month_num, dr.city
        ORDER BY t.year, t.month_num, dr.city;
BEGIN
    DBMS_OUTPUT.PUT_LINE('4.(e) Monthly City-Based Player Engagement:');
    
    FOR rec IN engagement_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('Year: ' || rec.year ||
                           ' | Month: ' || rec.month_num ||
                           ' | City: ' || rec.city ||
                           ' | Unique Players: ' || rec.unique_players ||
                           ' | Total Races: ' || rec.total_participations ||
                           ' | Avg Rating: ' || ROUND(rec.avg_city_rating, 2));
    END LOOP;
END monthly_city_engagement;
/

CREATE OR REPLACE PROCEDURE frequent_high_reward_races
AS
    CURSOR race_cursor IS
        SELECT 
            dr.race_name,
            dr.city,
            COUNT(frp.participation_id) as play_frequency,
            AVG(frp.reward_points) as avg_reward_points,
            AVG(frp.duration_minutes) as avg_duration_minutes,
            AVG(frp.rating_value) as avg_rating
        FROM fact_race_participation frp
        JOIN dim_race dr ON frp.race_id = dr.race_id
        GROUP BY dr.race_name, dr.city
        HAVING AVG(frp.reward_points) > 100 AND AVG(frp.duration_minutes) > 30
        ORDER BY COUNT(frp.participation_id) DESC;
BEGIN
    DBMS_OUTPUT.PUT_LINE('4.(f) Most Frequently Played Races :');
    
    FOR rec IN race_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('Race: ' || rec.race_name ||
                           ' | City: ' || rec.city ||
                           ' | Frequency: ' || rec.play_frequency ||
                           ' | Avg Rewards: ' || ROUND(rec.avg_reward_points, 2) ||
                           ' | Avg Duration: ' || ROUND(rec.avg_duration_minutes, 2) || ' mins' ||
                           ' | Avg Rating: ' || ROUND(rec.avg_rating, 2));
    END LOOP;
END frequent_high_reward_races;
/

INSERT INTO change_log (created_by, script_name, script_details) 
VALUES ('Faiza', '010_reporting_procedures.sql', 
'Created all six reporting procedures using simplified star schema for analytics.');

COMMIT;

SELECT 'All reporting procedures created successfully!' AS status FROM dual;