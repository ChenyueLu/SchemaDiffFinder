"""

This Is The Type Map Between MySQL and PostgreSQL

key: MySQL type and size
value: PostgreSQL type, size and whether match size

"""

TYPE_MAP = {
    "int": {"type": "integer", "mysqlsize": 11, "psqlsize": None, "matchsize?": True},
    "tinyint": {"type": "boolean", "mysqlsize": 1, "psqlsize": None, "matchsize?": True},
    "varchar": {"type": "character varying", "matchsize?": False},
    "timestamp": {"type": "timestamp without time zone", "matchsize?": False}
}