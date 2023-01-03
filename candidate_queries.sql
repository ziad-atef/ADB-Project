CREATE SCHEMA ADB;

use ADB;

create table DEVELOPER
(
    DEV_User_Name varchar(50) not null unique,
    DEV_ID int unique not null,
    DEV_Email varchar(50) unique not null,
    DEV_Hash varchar(255) not null,
    DEV_Address varchar(200),
    DEV_Job_Title varchar(50),

    /*Derived Attributes*/
    DEV_Projects_Count int default 0 not null,
    DEV_Age int not null,
    primary key (DEV_ID)
);


/* Multivalued Attributes*/

create table PROJECT
(
    PRO_ID int unique not null,
    PRO_Name varchar(50) not null,
    PRO_Description varchar(5000),
    PRO_Rate float,
    check(PRO_Rate >0 and PRO_Rate <=5),
    PRIMARY KEY (PRO_ID)
);

create table PRO_MULTIMEDIA
(
    PRO_MUL_ID int not null,
    PRO_MUL_Link varchar(500) not null,
    PRO_MUL_Link_Name varchar(50),
    Foreign KEY (PRO_MUL_ID) references PROJECT(PRO_ID),
    PRIMARY KEY (PRO_MUL_ID, PRO_MUL_Link)
);

CREATE TABLE DEVELOPER_WORKS_ON
(
    DEV_Id int not null,
    PRO_Id int not null,
    Dev_Role varchar(50),
    Primary key (DEV_Id, PRO_Id),
    Foreign key (DEV_Id) references DEVELOPER(DEV_ID),
    Foreign key (PRO_Id) references PROJECT(PRO_ID)
);

CREATE TABLE COMPETITION
(
    COM_ID int unique not null,
    COM_Name varchar(50) not null,
    COM_Status varchar(10),
    COM_Start_Date date,
    COM_End_Date date,
    COM_Description varchar(500),
    primary key(COM_ID)
);

CREATE TABLE DEVELOPER_PARTICIPATE
(
    DEV_Id int not null,
    COM_Id int not null,
    Primary key (DEV_Id, COM_Id),
    Foreign key (DEV_Id) references DEVELOPER(DEV_Id),
    Foreign key (COM_Id) references COMPETITION(COM_Id)
);

create table CLIENT
(
    CLI_ID int unique not null,
    CLI_Name varchar(50) not null, 
    CLI_Email varchar(50) unique not null,
    CLI_Phone varchar(50),
    CLI_Creation_Date date not null,
    CLI_Last_Login date not null,

    primary key (CLI_ID)
);

CREATE TABLE CLI_Field
(
    CLI_CAT_Field varchar(50) not null,
    CAT_Client_Id int not null,
    Primary key (CLI_CAT_Field, CAT_Client_Id),
    Foreign key (CAT_Client_Id) references CLIENT(CLI_ID)
);

CREATE TABLE CLIENT_HIRES
(
    CLI_Id int not null,
    DEV_Id int not null,
    Primary key (CLI_Id, DEV_Id),
    Foreign key (CLI_Id) references CLIENT(CLI_ID),
    Foreign key (DEV_Id) references DEVELOPER(DEV_ID)
);


-- 1
-- Select developer names and emails who have been hired by a client working in the field of "Software Development"
-- try to run this query with and without a cache
SELECT DEV_User_Name, DEV_Email
FROM DEVELOPER
WHERE DEV_ID IN
(
    SELECT DEV_Id
    FROM CLIENT_HIRES
    WHERE CLI_Id IN
    (
        SELECT CAT_Client_Id
        FROM CLI_Field
        WHERE CLI_CAT_Field = 'Software Development'
    )
);

-- 2
-- Select developer name and email and client names with project count less than a certain number
-- try to run this using a b+ tree index
SELECT DEV_User_Name, DEV_Email, CLI_Name, DEV_Projects_Count
FROM DEVELOPER
JOIN CLIENT_HIRES ON DEVELOPER.DEV_ID = CLIENT_HIRES.DEV_Id
JOIN CLIENT ON CLIENT_HIRES.CLI_Id = CLIENT.CLI_ID
WHERE DEV_Projects_Count < 5;

-- 3
-- Select developer names and emails and project multimedia link for developers who worked on a project with a certain name 
-- try to run this using a hash index
SELECT DEV_User_Name, DEV_Email, PRO_MUL_Link
FROM DEVELOPER
JOIN DEVELOPER_WORKS_ON ON DEVELOPER.DEV_ID = DEVELOPER_WORKS_ON.DEV_Id
JOIN PRO_MULTIMEDIA ON DEVELOPER_WORKS_ON.PRO_Id = PRO_MULTIMEDIA.PRO_MUL_ID
WHERE PRO_Name = 'Project 1';

-- 4
-- Select developer names and emails who have been hired by a certain client and have project count < 100
-- try to run this using a mixed index
SELECT DEV_User_Name, DEV_Email
FROM DEVELOPER
JOIN CLIENT_HIRES ON DEVELOPER.DEV_ID = CLIENT_HIRES.DEV_Id
JOIN CLIENT ON CLIENT_HIRES.CLI_Id = CLIENT.CLI_ID
WHERE CLI_Name = 'Client 1' AND DEV_Projects_Count < 100;

-- 5 
-- Select developer name and email, project name and multimedia link for developers who participated in a competiton with a certain name
-- use an optimized query that uses cross product and subqueries
SELECT DEV_User_Name, DEV_Email, PRO_Name, PRO_MUL_Link
FROM DEVELOPER
JOIN DEVELOPER_PARTICIPATE ON DEVELOPER.DEV_ID = DEVELOPER_PARTICIPATE.DEV_Id
JOIN COMPETITION ON DEVELOPER_PARTICIPATE.COM_Id = COMPETITION.COM_ID
JOIN DEVELOPER_WORKS_ON ON DEVELOPER.DEV_ID = DEVELOPER_WORKS_ON.DEV_Id
JOIN PROJECT ON DEVELOPER_WORKS_ON.PRO_Id = PROJECT.PRO_ID
JOIN PRO_MULTIMEDIA ON PROJECT.PRO_ID = PRO_MULTIMEDIA.PRO_MUL_ID
WHERE COM_Name = 'Competition 1';

-- 6
-- Similar to the previous query but use a date range to select developers who participated in a competition between a certain date range
-- use an optimized query that uses cross product and subqueries
SELECT DEV_User_Name, DEV_Email, PRO_Name, PRO_MUL_Link
FROM DEVELOPER
JOIN DEVELOPER_PARTICIPATE ON DEVELOPER.DEV_ID = DEVELOPER_PARTICIPATE.DEV_Id
JOIN COMPETITION ON DEVELOPER_PARTICIPATE.COM_Id = COMPETITION.COM_ID
JOIN DEVELOPER_WORKS_ON ON DEVELOPER.DEV_ID = DEVELOPER_WORKS_ON.DEV_Id
JOIN PROJECT ON DEVELOPER_WORKS_ON.PRO_Id = PROJECT.PRO_ID
JOIN PRO_MULTIMEDIA ON PROJECT.PRO_ID = PRO_MULTIMEDIA.PRO_MUL_ID
WHERE COM_Start_Date BETWEEN '2019-01-01' AND '2019-12-31';



