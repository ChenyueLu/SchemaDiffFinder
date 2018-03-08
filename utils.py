import re


def getTableInfo(commands, sqlType):
    """
    Get infomation for every table and put them in one dictionary
    :param commands: cleaned and splitted sql commands file
    :param sqlType: the sql type
    :return: dictionary of table information
    """

    tables = {}

    if sqlType == 'mysql':
        for command in commands:
            if command.startswith("CREATE TABLE"):
                Body = re.search("CREATE TABLE `(.*)` \( (.*)\) .*", command)
                tableName = Body.group(1)
                tableBody = Body.group(2)

                features = [body.lstrip() for body in tableBody.split(',')]
                featuresDict = {}
                for feature in features:
                    if re.match("`.*` .*", feature):
                        featureInfo = feature.split(' ')
                        featureName = featureInfo[0][1: -1]
                        featureType = re.sub(r'[A-Z].*', '', ' '.join(featureInfo[1:]))

                        if re.match("(.*)\((.*)\)", featureType):
                            body = re.search("(.*)\((.*)\)", featureType)
                            type = body.group(1)
                            size = int(body.group(2))
                        else:
                            type = featureType
                            size = None

                        featuresDict[featureName] = {"type": type, "size": size}

                tables[tableName] = featuresDict

    elif sqlType == 'psql':
        for command in commands:
            if command.startswith("CREATE TABLE"):
                Body = re.search("CREATE TABLE (.*) \(    (.*)\)", command)
                tableName = Body.group(1)
                tableBody = Body.group(2)

                features = [body.lstrip() for body in tableBody.split(',')]
                featuresDict = {}

                for feature in features:
                    featureInfo = feature.split(' ')
                    featureName = featureInfo[0]
                    featureType = re.sub(r'[A-Z].*', '', ' '.join(featureInfo[1:]))

                    if re.match("(.*)\((.*)\)", featureType):
                        body = re.search("(.*)\((.*)\)", featureType)
                        type = body.group(1)
                        size = int(body.group(2))
                    else:
                        type = featureType
                        size = None

                    featuresDict[featureName] = {"type": type, "size": size}

                tables[tableName] = featuresDict

    return tables


def fileCleaner(string):
    """
    Remove comments and '\n' from sql command file and split the string by ';'
    :param string: sql comment file in string
    :return: cleaned sql comment file
    """
    string = re.sub(re.compile("/\*.*?\*/;\n", re.DOTALL) ,"" ,string) # remove all comments (\*!COMMENT\n) from string
    string = re.sub(re.compile("--.*?\n" ), "", string) # remove all comments (-- COMMENT \n) from string

    stringList = [s.replace('\n', "") for s in string.split(';')]

    return stringList

def reportGenerator(mysqlTableDict, psqlTableDict):
    """
    Generate a report on the difference between two sql schemas
    :param mysqlTableDict: dictionary of mysql table
    :param psqlTableDict: dictionary of psql table
    :return:
    """

    commonTables = [table for table in mysqlTableDict and psqlTableDict]
    print "Common tables are %s \n" % commonTables

    for table in commonTables:
        print "For table %s..." % table
        mysqlTable = mysqlTableDict[table]
        psqlTable = psqlTableDict[table]

        for feature in mysqlTable:
            if feature in psqlTable:
                if mysqlTable[feature]["type"] != psqlTable[feature]["type"]:
                    if mysqlTable[feature]["size"] != psqlTable[feature]["size"]:
                        print "Feature %s has different schema:" % feature
                        print "MySql: type: %s, size: %s" % (mysqlTable[feature]["type"], mysqlTable[feature]["size"])
                        print "PSql: type: %s, size: %s" % (psqlTable[feature]["type"], psqlTable[feature]["size"])

