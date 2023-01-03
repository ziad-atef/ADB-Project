-- Before Optimization --
-- run the query twice to show that time doesn't change --

SET SESSION query_cache_type = OFF;

SET @@profiling = 0;
SET @@profiling_history_size = 0;
SET @@profiling_history_size = 100; 
SET @@profiling = 1;

DO SLEEP(1);

SELECT DEV_User_Name, DEV_Email, PRO_Name, PRO_MUL_Link
FROM developer
JOIN developer_participate ON developer.DEV_ID = developer_participate.DEV_Id
JOIN competition ON developer_participate.COM_Id = competition.COM_ID
JOIN developer_works_on ON developer.DEV_ID = developer_works_on.DEV_Id
JOIN project ON developer_works_on.PRO_Id = project.PRO_ID
JOIN pro_multimedia ON project.PRO_ID = pro_multimedia.PRO_MUL_ID
WHERE COM_Name = 'Competition 1';

show profiles;

---------------------------------------------------

SET SESSION query_cache_type = OFF;

SET @@profiling = 0;
SET @@profiling_history_size = 0;
SET @@profiling_history_size = 100; 
SET @@profiling = 1;

DO SLEEP(1);

SELECT DEV_User_Name, DEV_Email, PRO_Name, PRO_MUL_Link
FROM developer
JOIN developer_participate ON developer.DEV_ID = developer_participate.DEV_Id
JOIN competition ON developer_participate.COM_Id = competition.COM_ID
JOIN developer_works_on ON developer.DEV_ID = developer_works_on.DEV_Id
JOIN project ON developer_works_on.PRO_Id = project.PRO_ID
JOIN pro_multimedia ON project.PRO_ID = pro_multimedia.PRO_MUL_ID
WHERE COM_Name = 'Competition 1';

show profiles;

-- After Optimization --
-- run the query twice to show that the time changes --

SET SESSION query_cache_type = ON;

SET @@profiling = 0;
SET @@profiling_history_size = 0;
SET @@profiling_history_size = 100; 
SET @@profiling = 1;

DO SLEEP(1);

SELECT DEV_User_Name, DEV_Email, PRO_Name, PRO_MUL_Link
FROM developer
JOIN developer_participate ON developer.DEV_ID = developer_participate.DEV_Id
JOIN competition ON developer_participate.COM_Id = competition.COM_ID
JOIN developer_works_on ON developer.DEV_ID = developer_works_on.DEV_Id
JOIN project ON developer_works_on.PRO_Id = project.PRO_ID
JOIN pro_multimedia ON project.PRO_ID = pro_multimedia.PRO_MUL_ID
WHERE COM_Name = 'Competition 1';

show profiles;

---------------------------------------------------

SET SESSION query_cache_type = ON;

SET @@profiling = 0;
SET @@profiling_history_size = 0;
SET @@profiling_history_size = 100; 
SET @@profiling = 1;

DO SLEEP(1);

SELECT DEV_User_Name, DEV_Email, PRO_Name, PRO_MUL_Link
FROM developer
JOIN developer_participate ON developer.DEV_ID = developer_participate.DEV_Id
JOIN competition ON developer_participate.COM_Id = competition.COM_ID
JOIN developer_works_on ON developer.DEV_ID = developer_works_on.DEV_Id
JOIN project ON developer_works_on.PRO_Id = project.PRO_ID
JOIN pro_multimedia ON project.PRO_ID = pro_multimedia.PRO_MUL_ID
WHERE COM_Name = 'Competition 1';

show profiles;