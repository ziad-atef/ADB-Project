-- Before Optimization --

SET @@profiling = 0;
SET @@profiling_history_size = 0;
SET @@profiling_history_size = 100; 
SET @@profiling = 1;

SELECT DEV_User_Name, DEV_Email
FROM DEVELOPER
JOIN CLIENT_HIRES ON DEVELOPER.DEV_ID = CLIENT_HIRES.DEV_Id
JOIN CLIENT ON CLIENT_HIRES.CLI_Id = CLIENT.CLI_ID
WHERE CLI_Name = 'Client 1' AND DEV_Projects_Count < 100;

show profiles;

-- After Optimization --

create index index_project_count using BTREE  ON developer(dev_projects_count);
create index index_project_name using HASH ON project(pro_name);

SET @@profiling = 0;
SET @@profiling_history_size = 0;
SET @@profiling_history_size = 100; 
SET @@profiling = 1;

SELECT DEV_User_Name, DEV_Email
FROM DEVELOPER
JOIN CLIENT_HIRES ON DEVELOPER.DEV_ID = CLIENT_HIRES.DEV_Id
JOIN CLIENT ON CLIENT_HIRES.CLI_Id = CLIENT.CLI_ID
WHERE CLI_Name = 'Client 1' AND DEV_Projects_Count < 100;

show profiles;

DROP INDEX index_project_count ON DEVELOPER;
drop index index_project_count on developer

