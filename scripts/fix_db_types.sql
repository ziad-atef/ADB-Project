-- USE ADB

USE ADB_1_000_00;

ALTER TABLE developer MODIFY COLUMN DEV_ID int;
ALTER TABLE developer MODIFY COLUMN DEV_User_Name varchar(50);
ALTER TABLE developer MODIFY COLUMN DEV_Email varchar(50);
ALTER TABLE developer MODIFY COLUMN DEV_Hash varchar(255);
ALTER TABLE developer MODIFY COLUMN DEV_Address varchar(150);
ALTER TABLE developer MODIFY COLUMN DEV_Job_Title varchar(50);
ALTER TABLE developer MODIFY COLUMN DEV_Projects_Count int;
ALTER TABLE developer MODIFY COLUMN DEV_Age int;

ALTER TABLE project MODIFY COLUMN PRO_ID int;
ALTER TABLE project MODIFY COLUMN PRO_Name varchar(100);
ALTER TABLE project MODIFY COLUMN PRO_Description varchar(1000);
ALTER TABLE project MODIFY COLUMN  PRO_Rate float;

ALTER TABLE pro_multimedia MODIFY COLUMN PRO_MUL_ID int;
ALTER TABLE pro_multimedia MODIFY COLUMN PRO_MUL_Link varchar(200);
ALTER TABLE pro_multimedia MODIFY COLUMN PRO_MUL_Link_Name varchar(50);

ALTER TABLE developer_works_on MODIFY COLUMN DEV_Id int;
ALTER TABLE developer_works_on MODIFY COLUMN PRO_Id int;
ALTER TABLE developer_works_on MODIFY COLUMN Dev_Role varchar(50);

ALTER TABLE competition MODIFY COLUMN COM_ID int;
ALTER TABLE competition MODIFY COLUMN COM_Name varchar(50);
ALTER TABLE competition MODIFY COLUMN COM_Status varchar(10);
ALTER TABLE competition MODIFY COLUMN COM_Status varchar(10);
ALTER TABLE competition MODIFY COLUMN COM_Start_Date date;
ALTER TABLE competition MODIFY COLUMN COM_End_Date date;
ALTER TABLE competition MODIFY COLUMN COM_Description varchar(500);

ALTER TABLE developer_participate MODIFY COLUMN DEV_Id int;
ALTER TABLE developer_participate MODIFY COLUMN COM_Id int;

ALTER TABLE cli_field MODIFY COLUMN CLI_CAT_Field varchar(100);
ALTER TABLE cli_field MODIFY COLUMN CAT_Client_Id int;

ALTER TABLE client MODIFY COLUMN CLI_ID int;
ALTER TABLE client MODIFY COLUMN CLI_Name varchar(100);
ALTER TABLE client MODIFY COLUMN CLI_EMAIL varchar(100);
ALTER TABLE client MODIFY COLUMN CLI_Phone varchar(100);
ALTER TABLE client MODIFY COLUMN CLI_Creation_Date date;
ALTER TABLE client MODIFY COLUMN CLI_Last_Login date;

ALTER TABLE client_hires MODIFY COLUMN CLI_Id int;
ALTER TABLE client_hires MODIFY COLUMN DEV_Id int;