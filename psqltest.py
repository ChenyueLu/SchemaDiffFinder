from utils import *

fd = open('./schemas/psqlSchema.sql', 'r')
sqlFile = fd.read()
fd.close()

sqlCommands = fileCleaner(sqlFile)

tables = getTableInfo(sqlCommands, 'psql')

print tables