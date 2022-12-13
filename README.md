# ADB-Project
Database optimization and comparison!

# How convert data between MySQL and MongoDB
This will export data from MySQL as a json and will import it into MongoDB as is.
This of course will not be optimized for Mongo since the structure of the data will be the same as SQL databases, but it should do for this project.

## Export from MySQL workbench as json
1. Open MySQL workbench.
2. Select the `Schemas` tab on the left.
3. Find the collection you want to export in your databse.
4. Right click, select `Table Data Export Wizard` and press next.
5. Change the file format to `json` if it's set to csv.
6. Change the file output location to wherever you want and press next/finish until the wizard completes.

## Import data to MongoDB
1. Check if you have `mongoimport` as a command. If not, follow [this guide](https://www.mongodb.com/compatibility/json-to-mongodb) to install it.
2. Run this command `mongoimport --db dbName --collection collectionName --file fileName.json --jsonArray`


