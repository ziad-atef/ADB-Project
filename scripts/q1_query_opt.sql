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
        WHERE CLI_CAT_Field = 'Software Development'
    )
);

show profiles;

-- After Optimization --

SET @@profiling = 0;
SET @@profiling_history_size = 0;
SET @@profiling_history_size = 100; 
SET @@profiling = 1;

SELECT DEV_User_Name, DEV_Email
FROM developer as dev, client_hires as ch, cli_field as cf
WHERE dev.DEV_ID = ch.DEV_Id and cf.CLI_CAT_Field = 'Software Development';

show profiles;

