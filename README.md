# SchemaDiffFinder

## How to use
1. Put the schema files in the `schemas` folder

2. Modify the `MYSQL_SCHEMA_PATH` and `PSQL_SCHEMA_PATH` in `main.py` to point to schema files.

3. Modify the `OUTPUT_PATH` to the report path you want.

4. Run `main.py`

5. Check the report

## What is in the report?
Reprot follow the format like this:

```json
{
  "TableName":
  {
    "Feature Name That Has Different Schema":
    {
      "PSQL":{"type":"Sometype", "size":"Size"},
      "MySQL":{"type":"Sometype", "size":"Size"}
    },
    
    ...
    
  }

}


```