-- Before Optimization --

SET @@profiling = 0;
SET @@profiling_history_size = 0;
SET @@profiling_history_size = 100; 
SET @@profiling = 1;

SELECT DEV_User_Name, DEV_Email, PRO_MUL_Link
FROM DEVELOPER
JOIN DEVELOPER_WORKS_ON ON DEVELOPER.DEV_ID = DEVELOPER_WORKS_ON.DEV_Id
JOIN PRO_MULTIMEDIA ON DEVELOPER_WORKS_ON.PRO_Id = PRO_MULTIMEDIA.PRO_MUL_ID
WHERE PRO_Name = 'Project 1';

show profiles;

-- After Optimization --

create index index_project_name using HASH ON project(pro_name);

SET @@profiling = 0;
SET @@profiling_history_size = 0;
SET @@profiling_history_size = 100; 
SET @@profiling = 1;

SELECT DEV_User_Name, DEV_Email, PRO_MUL_Link
FROM DEVELOPER
JOIN DEVELOPER_WORKS_ON ON DEVELOPER.DEV_ID = DEVELOPER_WORKS_ON.DEV_Id
JOIN PRO_MULTIMEDIA ON DEVELOPER_WORKS_ON.PRO_Id = PRO_MULTIMEDIA.PRO_MUL_ID
WHERE PRO_Name = 'Project 1';

show profiles;

drop index index_project_count on developer
