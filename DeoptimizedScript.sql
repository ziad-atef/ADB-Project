CREATE SCHEMA ADB;

use ADB;

-- deoptimization: merge developer and work experience into one table
create table DEVELOPER
(
    -- these fields won't be unique, as a developer may have multiple work experiences
    DEV_User_Name varchar(50) not null ,
    DEV_ID int not null,
    DEV_Email varchar(50) not null,

    DEV_Hash varchar(255) not null,
    DEV_Address varchar(200),
    DEV_Job_Title varchar(50),

    -- deoptimized attributes
    -- primary and foreign keys will be discarded

    -- this field should uniquely identify a work experience, 
    -- as well as causing a developer record to be duplicated with multiple work experiences
    DEV_WOR_ID int not null unique, 

    -- no probable need for this field to be unique, a developer may have multiple jobs with the same title
    DEV_WOR_Title varchar(50) not null, 

    DEV_WOR_Descreption varchar(100),
    DEV_WOR_Start_Date date not null,
    DEV_WOR_End_Date date not null,

    /*Derived Attributes*/
    DEV_Projects_Count int default 0 not null,
    DEV_Age int not null

    -- since the developer's id won't be unique, should the primary key be the work experience id?
    -- or perhaps no key at all?
    -- primary key (DEV_WOR_ID)
);


/* Multivalued Attributes*/

-- deoptimization: merge project and project multimedia into one table
-- deoptimization: add developer id to project table, thus discarding the developer_works_on table
create table PROJECT
(
    -- similar to developer, these fields won't be unique, as a project may have multiple multimedia links
    PRO_ID int not null,
    PRO_Name varchar(50) not null,
    PRO_Description varchar(5000),
    PRO_Rate float,
    check(PRO_Rate >0 and PRO_Rate <=5),

    -- deoptimized attributes

    -- using this key to link the project to the developer, 
    -- will cause a project record to be duplicated with multiple developers
    -- and will also allow us to drop the developer_works_on table 
    DEV_Id int not null,
    Dev_Role varchar(50),

    -- this field should uniquely identify a multimedia link,
    -- as well as causing a project record to be duplicated with multiple multimedia links
    PRO_MUL_ID int not null unique,
    PRO_MUL_Link varchar(500) not null,
    PRO_MUL_Link_Name varchar(50)

    -- again, should the primary key be the multimedia link id? or perhaps no key at all?
    -- PRIMARY KEY (PRO_MUL_ID)
);

-- deoptimization: add developer id to competition table, thus discarding the developer_participate table
CREATE TABLE COMPETITION
(
    -- this field won't be unique, as a competition may have multiple developers
    COM_ID int not null,
    COM_Name varchar(50) not null,
    COM_Status varchar(10),
    COM_Start_Date date,
    COM_End_Date date,
    COM_Description varchar(500),

    -- deoptimized attributes

    -- using this key to link the competition to the developer,
    -- will cause a competition record to be duplicated with multiple developers
    -- and will also allow us to drop the developer_participate table
    DEV_Id int not null

    -- remove or modify the key?
    -- primary key(DEV_Id)
);

-- deoptimization: merge client, client field, and client hires into one table
create table CLIENT
(
    -- this field won't be unique
    CLI_ID int not null,
    CLI_Name varchar(50) not null,
    -- this field won't be unique 
    CLI_Email varchar(50) not null,
    CLI_Phone varchar(50),
    CLI_Creation_Date date not null,
    CLI_Last_Login date not null,

    -- deoptimized attributes
    -- any of these 2 could be used as a primary key, but not both
    DEV_Id int not null,
    CLI_CAT_Field varchar(50) not null

    -- remove or modify the key?
    -- primary key (DEV_Id)
);
