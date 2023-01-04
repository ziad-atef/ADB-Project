#!/bin/env python3
import random
from sqlalchemy import create_engine
import pandas as pd
from tqdm import tqdm
from faker import Faker

my_conn = create_engine('mysql://root:@localhost:3306/ADB_1_000_00_test')

Records = 1_000_00
BATCH_SIZE = 1000

batches = Records // BATCH_SIZE

ipsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean non venenatis nulla. Aenean auctor diam tellus, id vehicula sapien egestas vitae. Suspendisse scelerisque orci faucibus ultrices tempor. Nunc semper in orci id volutpat. Nullam consequat tempus lectus, a ullamcorper lectus semper eu. Suspendisse a massa nisl. Quisque non feugiat ipsum. Etiam est ex, interdum pretium ipsum vel, pharetra vulputate eros. Pellentesque interdum sit amet tellus ac iaculis. Sed quis velit viverra, rhoncus ante et, feugiat lacus. Suspendisse blandit molestie laoreet. Aliquam a nulla quam. Maecenas quis accumsan augue. Phasellus rutrum posuere odio, at pretium lorem ultricies volutpat. Donec vehicula congue scelerisque. Maecenas dictum mauris suscipit arcu imperdiet, et lobortis turpis molestie. Nulla vel risus dapibus, efficitur eros eget, aliquet lorem. Nullam quis magna aliquet, sagittis nibh non, gravida."

fake = Faker(use_weighting=False)

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
        ProjectCount = random.randint(0, 20)
        Age = 68

        #Work
        Title = "Professional Farmer"
        Description = "You write code you barely understand for projects you barely care about."
        StartDate = "2019-01-01"
        EndDate = "2020-01-01"

        DevEntry = (Name, ID, Email, Hash, Address, JobTitle, ProjectCount, Age)
        devs.append(DevEntry)

        #Projects
        for k in range(ProjectCount):
            ProjectName = fake.name()
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

        DevEntry = (Name, ID, Email, Hash, Address, JobTitle, ProjectCount, Age)
        devs.append(DevEntry)

        #Competitions
        for k in range(0, 3):
            CompetitionName = fake.name()
            CompetitionStatus = "Ongoing"
            CompetitionStartDate = fake.date()
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
            Field = fake.name()

            FieldEntry = (Field, ID)
            cli_fields.append(FieldEntry)

        #Client Hires
        for k in range(0, 3):
            index = i * BATCH_SIZE + j

            DevID = random.randint(0, index )

            HireEntry = (ID, DevID)
            cli_hires.add(HireEntry)

    cli_hires = list(cli_hires)

    # add the data to a dataframe
    df_devs = pd.DataFrame(devs, columns=['DEV_User_Name', 'DEV_ID', 'DEV_Email', 'DEV_Hash', 'DEV_Address', 'DEV_Job_Title', 'DEV_Projects_Count', 'DEV_Age'])
    df_projects = pd.DataFrame(projects, columns=['PRO_ID', 'PRO_Name', 'PRO_Description', 'PRO_Rate'])
    df_works_on = pd.DataFrame(works_on, columns=['DEV_Id', 'PRO_Id', 'Dev_Role'])
    df_multimedia = pd.DataFrame(multimedia, columns=['PRO_MUL_ID', 'PRO_MUL_Link', 'PRO_MUL_Link_Name'])
    df_competitions = pd.DataFrame(competitions, columns=['COM_ID', 'COM_Name', 'COM_Status', 'COM_Start_Date', 'COM_End_Date', 'COM_Description'])
    df_dev_participate = pd.DataFrame(dev_participate, columns=['DEV_Id', 'COM_Id'])
    df_clients = pd.DataFrame(clients, columns=['CLI_ID', 'CLI_Name', 'CLI_Email', 'CLI_Phone', 'CLI_Creation_Date', 'CLI_Last_Login'])
    df_cli_fields = pd.DataFrame(cli_fields, columns=['CLI_CAT_Field', 'CAT_Client_Id'])
    df_cli_hires = pd.DataFrame(cli_hires, columns=['CLI_Id', 'DEV_Id'])

    # write the dataframes to mysql 
    df_devs.to_sql('developer', con=my_conn, if_exists='append', index=False)
    df_projects.to_sql('project', con=my_conn, if_exists='append', index=False)
    df_works_on.to_sql('developer_works_on', con=my_conn, if_exists='append', index=False)
    df_multimedia.to_sql('pro_multimedia', con=my_conn, if_exists='append', index=False)
    df_competitions.to_sql('competition', con=my_conn, if_exists='append', index=False)
    df_dev_participate.to_sql('developer_participate', con=my_conn, if_exists='append', index=False)
    df_clients.to_sql('client', con=my_conn, if_exists='append', index=False)
    df_cli_fields.to_sql('cli_field', con=my_conn, if_exists='append', index=False)
    df_cli_hires.to_sql('client_hires', con=my_conn, if_exists='append', index=False)
