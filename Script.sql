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
