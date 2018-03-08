from utils import *

fd = open('./schemas/mysqlSchema.sql', 'r')
sqlFile = fd.read()
fd.close()

sqlCommands = fileCleaner(sqlFile)

tables = getTableInfo(sqlCommands, 'mysql')

print tables