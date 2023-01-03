-- Before Optimization --

SET @@profiling = 0;
SET @@profiling_history_size = 0;
SET @@profiling_history_size = 100; 
SET @@profiling = 1;

SELECT DEV_User_Name, DEV_Email
FROM developer
JOIN client_hires ON developer.DEV_ID = client_hires.DEV_Id
JOIN client ON client_hires.CLI_Id = client.CLI_ID
WHERE CLI_Name = 'John Carmack645' AND DEV_Projects_Count < 100;

show profiles;

-- After Optimization --

create index index_project_count using BTREE  ON developer(dev_projects_count);
create index index_project_name using HASH ON project(pro_name);

SET @@profiling = 0;
SET @@profiling_history_size = 0;
SET @@profiling_history_size = 100; 
SET @@profiling = 1;

SELECT DEV_User_Name, DEV_Email
FROM developer
JOIN client_hires ON developer.DEV_ID = client_hires.DEV_Id
JOIN client ON client_hires.CLI_Id = client.CLI_ID
WHERE CLI_Name = 'John Carmack645' AND DEV_Projects_Count < 100;

show profiles;

DROP INDEX index_project_count ON developer;
drop index index_project_name on project

