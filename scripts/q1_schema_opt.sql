-- Before Optimization --

SET @@profiling = 0;
SET @@profiling_history_size = 0;
SET @@profiling_history_size = 100; 
SET @@profiling = 1;

SELECT DEV_User_Name, DEV_Email
FROM developer
WHERE DEV_ID IN
(
    SELECT DEV_Id
    FROM client_hires
    WHERE CLI_Id IN
    (
        SELECT CAT_Client_Id
        FROM cli_field
        WHERE CLI_CAT_Field = 'Katie Schmidt'
    )
);

show profiles;

-- After Optimization --

CREATE VIEW dev_cli_software AS 
SELECT DEV_User_Name, DEV_Email, CLI_CAT_Field
FROM developer 
JOIN client_hires ON developer.DEV_ID = client_hires.DEV_Id 
JOIN cli_field ON client_hires.CLI_Id = cli_field.CAT_Client_Id;

SET @@profiling = 0;
SET @@profiling_history_size = 0;
SET @@profiling_history_size = 100; 
SET @@profiling = 1;

select DEV_User_Name, DEV_Email 
FROM dev_cli_software 
WHERE CLI_CAT_Field = 'Katie Schmidt';

show profiles;

DROP VIEW dev_cli_software;
