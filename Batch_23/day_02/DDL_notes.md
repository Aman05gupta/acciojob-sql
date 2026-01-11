## What is a Database?

A database is a structured storage system where data is saved in an organized way (usually in tables) so we can quickly search, insert, update, and delete information.

## What is a Schema?
A schema is a logical container (namespace) inside a database that stores tables, views, indexes, functions, and other objects.

<ul><li><u>Example</u> - Imagine your database is a house. A schema is a room. Tables are items inside that room</li>
</ul>

**Why do we use Schema?**
**1) Organization**
You can separate objects properly:
<ul>
<li>raw schema → raw data tables</li>
<li>analytics schema → analysis tables</li>
<li>reporting schema → dashboard tables</li>
</ul>

**2) Avoid name conflicts**

You can create same table name in different schemas:
```bash
raw.students
analytics.students
```
Both can exist because they are in different schemas.

**3) Access control / Security**
You can give permissions schema-wise:

<ul>
<li>Users can access only reporting schema</li>
<li>Not allowed to access raw schema</li>
</ul>

---

##  Data Definition Language (DDL) Commands
Used to define and modify the structure of the database.


•	**CREATE** – create database objects (table, view)
•	**ALTER** – modify table structure
•	**DROP** – delete database objects
•	**TRUNCATE** – remove all records quickly

**Purpose:** Structure design of the database.

---



## 1. CREATE
The CREATE command is a DDL statement used to create database objects such as databases, schemas, tables, views, indexes, sequences, functions, and triggers. 

**CREATE DATABASE**
```bash
CREATE DATABASE Database_Name;  
```
**CREATE SCHEMA**
```bash
CREATE SCHEMA schema_name;
```

**CREATE TABLE**
```bash
CREATE TABLE table_name (
    column1 datatype constraints,
    column2 datatype constraints,
    column3 datatype constraints
);  
```
---
## 2. ALTER
ALTER is a DDL (Data Definition Language) command used to modify the structure of an existing database object such as a table, column, constraint, schema, etc.

**We use ALTER to:**
<ul>
<li>Add a new column</li>
<li>Remove (drop) a column</li>
<li>Change a column data type</li>
<li>Rename a column or table</li>
<li>Add or remove constraints (PRIMARY KEY, UNIQUE, CHECK, etc.)</li>
<li>Set default values</li>
<li>Apply NOT NULL / NULL rules</li>
</ul>

**Examples**
1) Add a column
```bash
ALTER TABLE students ADD COLUMN email VARCHAR(100);
```
2) Drop a column
```bash
ALTER TABLE students DROP COLUMN email;
```
3) Rename a column
```bash
ALTER TABLE students RENAME COLUMN name TO student_name;
```
4) Rename a table
```bash
ALTER TABLE students RENAME TO student_info;
```
5) Change data type
```bash
ALTER TABLE students ALTER COLUMN age TYPE BIGINT;
```
6) Add a constraint
```bash
ALTER TABLE students ADD CONSTRAINT unique_email UNIQUE(email);
```

---
