import mysql.connector as connector

connection = connector.connect(user = "root", password = "xxx")

connection = connector.connect(user = "root", password = "xxx", db = "LittleLemonDM") 

cursor = connection.cursor()

cursor.execute("USE littleLemonDM")

results = cursor.fetchall()
columns = cursor.column_names
# Print column names
print(columns)
# Print query results
for result in results:
    print(result)


query = """
SELECT C.CustomeName, C.Email, O.TotalCost
FROM Orders O
JOIN Customer C ON O.CustomerID = C.CustomerID
WHERE O.TotalCost > 60;
"""

# Execute the query
cursor.execute(query)

# Fetch all results
results = cursor.fetchall()

# Print the results
for row in results:
    print(f"Full Name: {row[0]}, Contact Details: {row[1]}")