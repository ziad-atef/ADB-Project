-- Before Optimization --

SET @@profiling = 0;
SET @@profiling_history_size = 0;
SET @@profiling_history_size = 100; 
SET @@profiling = 1;

SELECT DEV_User_Name, DEV_Email, PRO_MUL_Link
FROM developer
JOIN developer_works_on ON developer.DEV_ID = developer_works_on.DEV_Id
JOIN pro_multimedia ON developer_works_on.PRO_Id = pro_multimedia.PRO_MUL_ID
JOIN project ON pro_multimedia.PRO_MUL_ID = project.PRO_ID
WHERE PRO_Name = 'Mr. Kevin Stone';

show profiles;

-- After Optimization --

create index index_project_name using HASH ON project(pro_name);

SET @@profiling = 0;
SET @@profiling_history_size = 0;
SET @@profiling_history_size = 100; 
SET @@profiling = 1;

SELECT DEV_User_Name, DEV_Email, PRO_MUL_Link
FROM developer
JOIN developer_works_on ON developer.DEV_ID = developer_works_on.DEV_Id
JOIN pro_multimedia ON developer_works_on.PRO_Id = pro_multimedia.PRO_MUL_ID
JOIN project ON pro_multimedia.PRO_MUL_ID = project.PRO_ID
WHERE PRO_Name = 'Mr. Kevin Stone';

show profiles;

drop index index_project_name on project
