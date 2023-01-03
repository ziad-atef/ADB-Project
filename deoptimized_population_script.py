#!/bin/env python3

import mysql.connector
import random
import sys

from faker import Faker
from tqdm import tqdm

fake = Faker()
Records = 1000

ADB_DEOPTIMIZED = mysql.connector.connect(
    host="localhost",
    user="root",
    password="admin",
    database="ADB_DEOPTIMIZED"
)

ProjectID = 0
CompetitionID = 0
cursor = ADB_DEOPTIMIZED.cursor()

DevInsertQuery = "INSERT INTO DEVELOPER (DEV_User_Name, DEV_ID, DEV_Email, DEV_Hash, DEV_Address, DEV_Job_Title, DEV_Projects_Count, DEV_Age) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
ProjectInsertQuery = "INSERT INTO PROJECT (PRO_ID, PRO_Name, PRO_Description, PRO_Rate, PRO_MUL_ID, PRO_MUL_Link, PRO_MUL_Link_Name) VALUES (%s,%s,%s,%s,%s,%s,%s)"
WorkONInsertQuery = "INSERT INTO DEVELOPER_WORKS_ON (DEV_Id, PRO_Id, Dev_Role) VALUES (%s,%s,%s)"
ComInsertQuery = "INSERT INTO COMPETITION (COM_ID, COM_Name, COM_Status, COM_Start_Date, COM_End_Date, COM_Description, DEV_Id) VALUES (%s,%s,%s,%s,%s,%s,%s)"
CliInsertQuery = "INSERT INTO CLIENT (CLI_ID, CLI_Name, CLI_Email, CLI_Phone, CLI_Creation_Date, CLI_Last_Login, DEV_Id, CLI_CAT_Field) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"

devs            = []
projects        = []
works_on        = []
competitions    = []
clients         = []

MulId = 0
for index in tqdm(range(Records)):
    #Developer
    ID = index
    Name = fake.name() + str(ID)
    Email = fake.email() + str(ID)
    Hash = "gfsdfjgsd"
    Address = fake.address()
    JobTitle = "sdfdhfdsgg"
    ProjectCount = 0
    Age = random.randint(10, 69)

    #Work
    Title = "jfhgdjgdf"
    Description = "fjsdkjdsflkjvd"
    StartDate = fake.date()
    EndDate = fake.date()

    DevEntry = (Name, ID, Email, Hash, Address, JobTitle, ProjectCount, Age)
    devs.append(DevEntry)

    #Projects
    for i in range(0, 3):
        ProjectName = "dsfngsfg"
        ProjectDesc = "nsdjhsfgldf"
        ProjectRate = 4

        #Works on
        DevRole = "sfdlfdf"
        WorkOnEntry = (ID, ProjectID, DevRole)
        works_on.append(WorkOnEntry)

        #Multimedia
        for j in range(0, 3):
            MulLink = fake.url() + str(sys.maxsize + j)
            MulName = "fbdfk"

            #Project
            ProjectEntry = (ProjectID, ProjectName, ProjectDesc, ProjectRate, MulId, MulLink, MulName)
            projects.append(ProjectEntry)
            MulId += 1

        ProjectID += 1

    #Competitions
    for i in range(0, 3):
        CompetitionName = "sdfgdfg"
        CompetitionStatus = "sdfgdfg"
        CompetitionStartDate = fake.date()
        CompetitionEndDate = fake.date()
        CompetitionDescription = fake.text()[0:100]

        CompetitionEntry = (
            CompetitionID,
            CompetitionName,
            CompetitionStatus,
            CompetitionStartDate,
            CompetitionEndDate,
            CompetitionDescription,
            ID
        )

        competitions.append(CompetitionEntry)

        CompetitionID += 1

for index in tqdm(range(Records)):
    #Client Fields
    for i in range(0, 3):
        #Client
        ID = index
        Name = fake.name() + str(ID)
        Email = fake.email() + str(ID)
        Phone = fake.phone_number()
        CreationDate = fake.date()
        LastLogin = fake.date()
        DevID = random.randint(0, Records - 1)
        Field = fake.text()[0:10]

        ClientEntry = (ID, Name, Email, Phone, CreationDate, LastLogin, DevID, Field)
        clients.append(ClientEntry)


cursor.executemany(DevInsertQuery, devs)
cursor.executemany(ProjectInsertQuery, projects)
cursor.executemany(WorkONInsertQuery, works_on)
cursor.executemany(ComInsertQuery, competitions)
cursor.executemany(CliInsertQuery, clients)

ADB_DEOPTIMIZED.commit()
