-- Before Optimization --

SET @@profiling = 0;
SET @@profiling_history_size = 0;
SET @@profiling_history_size = 100; 
SET @@profiling = 1;

SELECT DEV_User_Name, DEV_Email, CLI_Name, DEV_Projects_Count
FROM developer
JOIN client_hires ON developer.DEV_ID = client_hires.DEV_Id
JOIN client ON client_hires.CLI_Id = client.CLI_ID
WHERE DEV_Projects_Count < 5;

show profiles;

-- After Optimization --

create index index_project_count using BTREE  ON developer(dev_projects_count);

SET @@profiling = 0;
SET @@profiling_history_size = 0;
SET @@profiling_history_size = 100; 
SET @@profiling = 1;

SELECT DEV_User_Name, DEV_Email, CLI_Name, DEV_Projects_Count
FROM developer
JOIN client_hires ON developer.DEV_ID = client_hires.DEV_Id
JOIN client ON client_hires.CLI_Id = client.CLI_ID
WHERE DEV_Projects_Count < 5;

show profiles;

DROP INDEX index_project_count ON developer;



