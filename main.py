from utils import *
import json

MYSQL_SCHEMA_PATH = "./schemas/mysqlSchema.sql"
PSQL_SCHEMA_PATH = "./schemas/psqlSchema.sql"
OUTPUT_PATH = "./reports/test_report.json"

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
report = reportGenerator(mysqlTablesDict, psqlTableDict)
print report

# Dump report to json
fp = open(OUTPUT_PATH, 'w')
json.dump(report, fp)
fp.close()