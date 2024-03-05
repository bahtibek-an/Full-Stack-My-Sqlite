# Welcome to My_sqlite
Create a class called MySqliteRequest in my_sqlite_request.rb. It will have a similar behavior than a request on the real sqlite.

All methods, except run, will return an instance of my_sqlite_request. You will build the request by progressive call and execute the request by calling run.

Each row must have an ID.

We will do only 1 join and 1 where per request.
## Task	
Constructor It will be prototyped:
def initialize

From Implement a from method which must be present on each request. From will take a parameter and it will be the name of the table. (technically a table_name is also a filename (.csv))
It will be prototyped:

def from(table_name)

Select Implement a where method which will take one argument a string OR an array of string. It will continue to build the request. During the run() you will collect on the result only the columns sent as parameters to select :-).
It will be prototyped:

def select(column_name) OR def select([column_name_a, column_name_b])


## Description	
 Create a program which will be a Command Line Interface (CLI) to your MySqlite class. It will use readline and we will run it with ruby my_sqlite_cli.rb.

It will accept request with:

SELECT|INSERT|UPDATE|DELETE
FROM
WHERE (max 1 condition)
JOIN ON (max 1 condition) Note, you can have multiple WHERE. Yes, you should save and load the database from a file.
## Usage

### The Core Team