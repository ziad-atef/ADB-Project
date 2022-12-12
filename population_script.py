import mysql.connector
import random
from faker import Faker
from tqdm import tqdm

fake = Faker()
Records = 100

AdvancedDB = mysql.connector.connect(
  host="localhost",
  user="root",
  password="admin",
  database="AdvancedDB"
)

ProjectID = 0
cursor = AdvancedDB.cursor()
for index in tqdm(range(Records)):
  #Developer
  ID = index
  Name = fake.name()+str(ID)
  Email = fake.email()+str(ID)
  Hash =  "gfsdfjgsd"
  Address = fake.address()
  JobTitle = "sdfdhfdsgg"
  ProjectCount = 0
  Age = random.randint(10,69)

  #Work
  Title = "jfhgdjgdf"
  Description = "fjsdkjdsflkjvd"
  StartDate = fake.date()
  EndDate = fake.date()

  DevInsertQuery = "INSERT INTO DEVELOPER (DEV_User_Name, DEV_ID, DEV_Email, DEV_Hash, DEV_Address, DEV_Job_Title, DEV_Projects_Count, DEV_Age) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
  DevEntry = (Name, ID, Email, Hash, Address, JobTitle, ProjectCount, Age)
  cursor.execute(DevInsertQuery,DevEntry)

  WorkInsertQuery = "INSERT INTO DEV_WORKING_EXPERINCE (DEV_WOR_Developer_Id, DEV_WOR_Title, DEV_WOR_Descreption, DEV_WOR_Start_Date, DEV_WOR_End_Date) VALUES (%s,%s,%s,%s,%s)"
  WorkEntry = (ID, Title, Description, StartDate, EndDate)
  cursor.execute(WorkInsertQuery,WorkEntry)

  #Projects

  for i in range(0,3):
    ProectName = "dsfngsfg"
    ProjectDesc = "nsdjhsfgldf"
    ProjectRate = 4

    #Project
    ProjectInsertQuery = "INSERT INTO PROJECT (PRO_ID, PRO_Name, PRO_Description, PRO_Rate) VALUES (%s,%s,%s,%s)"
    ProjectEntry = (ProjectID, ProectName, ProjectDesc, ProjectRate)
    cursor.execute(ProjectInsertQuery,ProjectEntry)

    #Wors on
    DevRole = "sfdlfdf"
    WorkONInsertQuery = "INSERT INTO DEVELOPER_WORKS_ON (DEV_Id, PRO_Id, Dev_Role) VALUES (%s,%s,%s)"
    WorkOnEntry = (ID, ProjectID, DevRole)
    cursor.execute(WorkONInsertQuery,WorkOnEntry)

    #Multimedia
    for j in range(0,3):
      MulLink = fake.url()
      MulName = "fbdfk"
      MULInsertQuery = "INSERT INTO PRO_MULTIMEDIA (PRO_MUL_ID, PRO_MUL_Link, PRO_MUL_Link_Name) VALUES (%s,%s,%s)"
      MULEntry = (ProjectID, MulLink, MulName)
      cursor.execute(MULInsertQuery,MULEntry)

    ProjectID+=1
    
    

AdvancedDB.commit()
