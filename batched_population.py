#!/bin/env python3
import mysql.connector
import random
import sys

# from faker import Faker
from tqdm import tqdm

Records = 1_000_00
BATCH_SIZE = 1000

batches = Records // BATCH_SIZE

AdvancedDB = mysql.connector.connect(
    host="localhost",
    user="root",
    password="data6OO6suck5",
    database="ADB"
)

ipsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean non venenatis nulla. Aenean auctor diam tellus, id vehicula sapien egestas vitae. Suspendisse scelerisque orci faucibus ultrices tempor. Nunc semper in orci id volutpat. Nullam consequat tempus lectus, a ullamcorper lectus semper eu. Suspendisse a massa nisl. Quisque non feugiat ipsum. Etiam est ex, interdum pretium ipsum vel, pharetra vulputate eros. Pellentesque interdum sit amet tellus ac iaculis. Sed quis velit viverra, rhoncus ante et, feugiat lacus. Suspendisse blandit molestie laoreet. Aliquam a nulla quam. Maecenas quis accumsan augue. Phasellus rutrum posuere odio, at pretium lorem ultricies volutpat. Donec vehicula congue scelerisque. Maecenas dictum mauris suscipit arcu imperdiet, et lobortis turpis molestie. Nulla vel risus dapibus, efficitur eros eget, aliquet lorem. Nullam quis magna aliquet, sagittis nibh non, gravida."


cursor = AdvancedDB.cursor()

DevInsertQuery = "INSERT INTO DEVELOPER (DEV_User_Name, DEV_ID, DEV_Email, DEV_Hash, DEV_Address, DEV_Job_Title, DEV_Projects_Count, DEV_Age) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"
ProjectInsertQuery = "INSERT INTO PROJECT (PRO_ID, PRO_Name, PRO_Description, PRO_Rate) VALUES (%s,%s,%s,%s)"
WorkONInsertQuery = "INSERT INTO DEVELOPER_WORKS_ON (DEV_Id, PRO_Id, Dev_Role) VALUES (%s,%s,%s)"
MULInsertQuery = "INSERT INTO PRO_MULTIMEDIA (PRO_MUL_ID, PRO_MUL_Link, PRO_MUL_Link_Name) VALUES (%s,%s,%s)"
ComInsertQuery = "INSERT INTO COMPETITION (COM_ID, COM_Name, COM_Status, COM_Start_Date, COM_End_Date, COM_Description) VALUES (%s,%s,%s,%s,%s,%s)"
DevParInsertQuery = "INSERT INTO DEVELOPER_PARTICIPATE (DEV_Id, COM_Id) VALUES (%s,%s)"
CliInsertQuery = "INSERT INTO CLIENT (CLI_ID, CLI_Name, CLI_Email, CLI_Phone, CLI_Creation_Date, CLI_Last_Login) VALUES (%s,%s,%s,%s,%s,%s)"
CliFieldInsertQuery = "INSERT INTO CLI_Field (CLI_CAT_Field, CAT_Client_Id) VALUES (%s,%s)"
HireInsertQuery = "INSERT INTO CLIENT_HIRES (CLI_Id, DEV_Id) VALUES (%s,%s)"

ProjectID = 0
CompetitionID = 0
for i in tqdm(range(batches)):

    devs            = []
    projects        = []
    works_on        = []
    multimedia      = []
    competitions    = []
    dev_participate = []
    clients         = []
    cli_fields      = []
    cli_hires       = set()

    for j in range(BATCH_SIZE):
        index = i * BATCH_SIZE + j

        #Developer
        ID = index
        Name = "name" + str(ID)
        Email = "email@email.kak" + str(ID)
        Hash = "1E2D3C4B5A6"
        Address = "Where the money at Avenue"
        JobTitle = "Professional Kak Maker"
        ProjectCount = 0
        Age = 68

        #Work
        Title = "Professional Farmer"
        Description = "You write code you barely understand for projects you barely care about."
        StartDate = "2019-01-01"
        EndDate = "2020-01-01"

        DevEntry = (Name, ID, Email, Hash, Address, JobTitle, ProjectCount, Age)
        devs.append(DevEntry)

        #Projects
        for k in range(0, 3):
            ProjectName = "Project Kak"
            ProjectDesc = "SCREAM FOR ME"
            ProjectRate = 4

            #Project
            ProjectEntry = (ProjectID, ProjectName, ProjectDesc, ProjectRate)
            projects.append(ProjectEntry)

            #Works on
            DevRole = "Backend Farmer"
            WorkOnEntry = (ID, ProjectID, DevRole)
            works_on.append(WorkOnEntry)

            #Multimedia
            for l in range(0, 3):
                MulLink =  "https://youtu.be/4MNbX4MRIFQ" + str(index + k + l)
                MulName = "KICK BACK"
                MULEntry = (ProjectID, MulLink, MulName)
                multimedia.append(MULEntry)

            ProjectID += 1
        
        #Competitions
        for k in range(0, 3):
            CompetitionName = "Farmer's Competition"
            CompetitionStatus = "Ongoing"
            CompetitionStartDate = "2018-9-23"
            CompetitionEndDate = "2023-7-23"
            CompetitionDescription = "A competition for farmers to show off their KAK skills! Who's the best slave?"

            CompetitionEntry = (CompetitionID, CompetitionName, CompetitionStatus, CompetitionStartDate, CompetitionEndDate, CompetitionDescription)
            competitions.append(CompetitionEntry)

            DevParticipateEntry = (ID, CompetitionID)
            dev_participate.append(DevParticipateEntry)

            CompetitionID += 1

        #Client
        ID = index
        Name = "John Carmack" + str(ID)
        Email = "Doom@idsoftware.kak" + str(ID)
        Phone = "420696969"
        CreationDate = "1993-01-01"
        LastLogin = "2022-06-09"

        ClientEntry = (ID, Name, Email, Phone, CreationDate, LastLogin)
        clients.append(ClientEntry)

        #Client Fields
        for k in range(0, 3):
            Field = "Software"

            FieldEntry = (Field, ID)
            cli_fields.append(FieldEntry)

        #Client Hires
        for k in range(0, 3):
            index = i * BATCH_SIZE + j

            DevID = random.randint(0, index )

            HireEntry = (ID, DevID)
            cli_hires.add(HireEntry)

    cli_hires = list(cli_hires)

    cursor.executemany(DevInsertQuery, devs)
    cursor.executemany(ProjectInsertQuery, projects)
    cursor.executemany(WorkONInsertQuery, works_on)
    cursor.executemany(MULInsertQuery, multimedia)
    cursor.executemany(ComInsertQuery, competitions)
    cursor.executemany(DevParInsertQuery, dev_participate)
    cursor.executemany(CliInsertQuery, clients)
    cursor.executemany(CliFieldInsertQuery, cli_fields)
    cursor.executemany(HireInsertQuery, cli_hires)

    AdvancedDB.commit()
