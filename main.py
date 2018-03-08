from utils import *

MYSQL_SCHEMA_PATH = "./schemas/mysqlSchema.sql"
PSQL_SCHEMA_PATH = "./schemas/psqlSchema.sql"

# Load Schema sql files
fd = open(MYSQL_SCHEMA_PATH, 'r')
mysqlFile = fd.read()
fd.close()

fd = open(PSQL_SCHEMA_PATH, 'r')
psqlFile = fd.read()
fd.close()

# Create dictionary for every table
mysqlCommands = fileCleaner(mysqlFile)
psqlCommand = fileCleaner(psqlFile)

mysqlTablesDict = getTableInfo(mysqlCommands, 'mysql')
psqlTableDict = getTableInfo(psqlCommand, 'psql')

# Generate report
reportGenerator(mysqlTablesDict, psqlTableDict)