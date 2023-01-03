-- Before Optimization --

SET @@profiling = 0;
SET @@profiling_history_size = 0;
SET @@profiling_history_size = 100; 
SET @@profiling = 1;

SELECT DEV_User_Name, DEV_Email, PRO_Name, PRO_MUL_Link
FROM developer
JOIN developer_participate ON developer.DEV_ID = developer_participate.DEV_Id
JOIN competition ON developer_participate.COM_Id = competition.COM_ID
JOIN developer_works_on ON developer.DEV_ID = developer_works_on.DEV_Id
JOIN project ON developer_works_on.PRO_Id = project.PRO_ID
JOIN pro_multimedia ON project.PRO_ID = pro_multimedia.PRO_MUL_ID
WHERE COM_Start_Date BETWEEN '2019-01-01' AND '2019-12-31';

show profiles;

-- After Optimization --

-- SET GLOBAL innodb_buffer_pool_size = 134217728; 
-- SET GLOBAL innodb_buffer_pool_size = 268435456;

SET @@profiling = 0;
SET @@profiling_history_size = 0;
SET @@profiling_history_size = 100; 
SET @@profiling = 1;

SELECT DEV_User_Name, DEV_Email, PRO_Name, PRO_MUL_Link
FROM developer
JOIN developer_participate ON developer.DEV_ID = developer_participate.DEV_Id
JOIN competition ON developer_participate.COM_Id = competition.COM_ID
JOIN developer_works_on ON developer.DEV_ID = developer_works_on.DEV_Id
JOIN project ON developer_works_on.PRO_Id = project.PRO_ID
JOIN pro_multimedia ON project.PRO_ID = pro_multimedia.PRO_MUL_ID
WHERE COM_Start_Date BETWEEN '2019-01-01' AND '2019-12-31';

show profiles;
