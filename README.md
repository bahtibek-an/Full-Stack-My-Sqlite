# Description

Many programming languages have bindings to the SQLite library. It generally follows PostgreSQL syntax, but does not enforce type checking by default.[8][9] This means that one can, for example, insert a string into a column defined as an integer.

D. Richard Hipp designed SQLite in the spring of 2000 while working for General Dynamics on contract with the United States Navy.[10] Hipp was designing software used for a damage-control system aboard guided-missile destroyers, which originally used HP-UX with an IBM Informix database back-end. SQLite began as a Tcl extension.[11]

In August 2000, version 1.0 of SQLite was released, with storage based on gdbm (GNU Database Manager). In September 2001, SQLite 2.0 replaced gdbm with a custom B-tree implementation, adding transaction capability. In June 2004, SQLite 3.0 added internationalization, manifest typing, and other major improvements, partially funded by America Online. In 2011, Hipp announced his plans to add a NoSQL interface to SQLite, as well as announcing UnQL, a functional superset of SQL designed for document-oriented databases.[12] In 2018, SQLite adopted a Code of Conduct based on the Rule of Saint Benedict which caused some controversy and was later renamed as a Code of Ethics.[13]

# Task

Remember to git add && git commit && git push each exercise!

We will execute your function with our test(s), please DO NOT PROVIDE ANY TEST(S) in your file

For each exercise, you will have to create a folder and in this folder, you will have additional files that contain your work. Folder names are provided at the beginning of each exercise under submit directory and specific file names for each exercise are also provided at the beginning of each exercise under submit file(s).

Create a class User, it will be your interface in order to

create user
find user
get all users
update user
destroy user in sqlite.
You will use the gem sqlite3. The sqlite filename will be named db.sql.

Your table will be name users and will have multiple attributes:

firstname as string
lastname as string
age as integer
password as string
email as string
Your class will have the following methods:

def create(user_info) It will create a user. User info will be: firstname, lastname, age, password and email And it will return a unique ID (a positive integer)

def find(user_id) It will retrieve the associated user and return all information contained in the database.

def all It will retrieve all users and return a hash of users.

def update(user_id, attribute, value) It will retrieve the associated user, update the attribute send as parameter with the value and return the user hash.

def destroy(user_id) It will retrieve the associated user and destroy it from your database.

# Usage

GET on /users. This action will return all users (without their passwords).

POST on /users. Receiving firstname, lastname, age, password and email. It will create a user and store in your database and returns the user created (without password).

POST on /sign_in. Receiving email and password. It will add a session containing the user_id in order to be logged in and returns the user created (without password).

PUT on /users. This action require a user to be logged in. It will receive a new password and will update it. It returns the user created (without password).

DELETE on /sign_out. This action require a user to be logged in. It will sign_out the current user. It returns nothing (code 204 in HTTP).

DELETE on /users. This action require a user to be logged in. It will sign_out the current user and it will destroy the current user. It returns nothing (code 204 in HTTP).

For the signed in method, we will be using session & cookies In order to perform a request with curl and save cookies (Be aware it's not the same flags to save & load)



# Installation


