#!/bin/env python3

import mysql.connector
import random
import sys

from faker import Faker
from tqdm import tqdm

fake = Faker()
Records = 1000

AdvancedDB = mysql.connector.connect(
    host="localhost",
    user="root",
    password="admin",
    database="ADB"
)

ProjectID = 0
CompetitionID = 0
cursor = AdvancedDB.cursor()

DevInsertQuery = "INSERT INTO DEVELOPER (DEV_User_Name, DEV_ID, DEV_Email, DEV_Hash, DEV_Address, DEV_Job_Title, DEV_Projects_Count, DEV_Age) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
WorkInsertQuery = "INSERT INTO DEV_WORKING_EXPERINCE (DEV_WOR_Developer_Id, DEV_WOR_Title, DEV_WOR_Descreption, DEV_WOR_Start_Date, DEV_WOR_End_Date) VALUES (%s,%s,%s,%s,%s)"
ProjectInsertQuery = "INSERT INTO PROJECT (PRO_ID, PRO_Name, PRO_Description, PRO_Rate) VALUES (%s,%s,%s,%s)"
WorkONInsertQuery = "INSERT INTO DEVELOPER_WORKS_ON (DEV_Id, PRO_Id, Dev_Role) VALUES (%s,%s,%s)"
MULInsertQuery = "INSERT INTO PRO_MULTIMEDIA (PRO_MUL_ID, PRO_MUL_Link, PRO_MUL_Link_Name) VALUES (%s,%s,%s)"
ComInsertQuery = "INSERT INTO COMPETITION (COM_ID, COM_Name, COM_Status, COM_Start_Date, COM_End_Date, COM_Description) VALUES (%s,%s,%s,%s,%s,%s)"
DevParInsertQuery = "INSERT INTO DEVELOPER_PARTICIPATE (DEV_Id, COM_Id) VALUES (%s,%s)"
CliInsertQuery = "INSERT INTO CLIENT (CLI_ID, CLI_Name, CLI_Email, CLI_Phone, CLI_Creation_Date, CLI_Last_Login) VALUES (%s,%s,%s,%s,%s,%s)"
CliFieldInsertQuery = "INSERT INTO CLI_Field (CLI_CAT_Field, CAT_Client_Id) VALUES (%s,%s)"
HireInsertQuery = "INSERT INTO CLIENT_HIRES (CLI_Id, DEV_Id) VALUES (%s,%s)"

devs            = []
work            = []
projects        = []
works_on        = []
multimedia      = []
competitions    = []
dev_participate = []
clients         = []
cli_fields      = []
cli_hires       = set()

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

    WorkEntry = (ID, Title, Description, StartDate, EndDate)
    work.append(WorkEntry)

    #Projects

    for i in range(0, 3):
        ProjectName = "dsfngsfg"
        ProjectDesc = "nsdjhsfgldf"
        ProjectRate = 4

        #Project
        ProjectEntry = (ProjectID, ProjectName, ProjectDesc, ProjectRate)
        projects.append(ProjectEntry)

        #Works on
        DevRole = "sfdlfdf"
        WorkOnEntry = (ID, ProjectID, DevRole)
        works_on.append(WorkOnEntry)

        #Multimedia
        for j in range(0, 3):
            MulLink = fake.url() + str(sys.maxsize + j)
            MulName = "fbdfk"
            MULEntry = (ProjectID, MulLink, MulName)
            multimedia.append(MULEntry)

        ProjectID += 1
    
    #Competitions
    for i in range(0, 3):
        CompetitionName = "sdfgdfg"
        CompetitionStatus = "sdfgdfg"
        CompetitionStartDate = fake.date()
        CompetitionEndDate = fake.date()
        CompetitionDescription = fake.text()[0:100]

        CompetitionEntry = (CompetitionID, CompetitionName, CompetitionStatus, CompetitionStartDate, CompetitionEndDate, CompetitionDescription)
        competitions.append(CompetitionEntry)

        DevParticipateEntry = (ID, CompetitionID)
        dev_participate.append(DevParticipateEntry)

        CompetitionID += 1

for index in tqdm(range(Records)):
    #Client
    ID = index
    Name = fake.name() + str(ID)
    Email = fake.email() + str(ID)
    Phone = fake.phone_number()
    CreationDate = fake.date()
    LastLogin = fake.date()

    ClientEntry = (ID, Name, Email, Phone, CreationDate, LastLogin)
    clients.append(ClientEntry)

    #Client Fields
    for i in range(0, 3):
        Field = fake.text()[0:10]

        FieldEntry = (Field, ID)
        cli_fields.append(FieldEntry)

    #Client Hires
    for i in range(0, 3):
        DevID = random.randint(0, Records - 1)

        HireEntry = (ID, DevID)
        cli_hires.add(HireEntry)

cli_hires = list(cli_hires)



cursor.executemany(DevInsertQuery, devs)
cursor.executemany(WorkInsertQuery, work)
cursor.executemany(ProjectInsertQuery, projects)
cursor.executemany(WorkONInsertQuery, works_on)
cursor.executemany(MULInsertQuery, multimedia)
cursor.executemany(ComInsertQuery, competitions)
cursor.executemany(DevParInsertQuery, dev_participate)
cursor.executemany(CliInsertQuery, clients)
cursor.executemany(CliFieldInsertQuery, cli_fields)
cursor.executemany(HireInsertQuery, cli_hires)

AdvancedDB.commit()
