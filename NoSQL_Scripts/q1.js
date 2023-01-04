use ADB;

var now = new Date();

db.developer.aggregate([
    {
        $lookup:
        {
            from: "client_hires",
            localField: "DEV_ID",
            foreignField: "DEV_Id",
            as: "Hired"
        }
    },
    {
        $lookup:
        {
            from: "cli_field",
            localField: "Hired.CLI_Id",
            foreignField: "CAT_Client_Id",
            as: "Field"
        }
    },
    {
        $match: {
            "Field.CLI_CAT_Field": "Katie Schmidt"
        }
    },
    {
        $project: {
            _id: 0,
            DEV_User_Name: 1,
            DEV_Email: 1
        }
    }
]);
// What does this query do
// This query finds all developers who have worked for Dr. Jo Bean

var elapsed = new Date() - now;

print("Time taken: " + elapsed + "ms");