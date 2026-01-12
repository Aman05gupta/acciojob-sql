# Data Types
Data types in SQL define the kind of data that a column can store in a database table.
## 1. Numeric Data Types
| Data Type         | Size    | Range (Minimum → Maximum)                                  | Use                  | Example                             |
| ----------------- | ------- | ---------------------------------------------------------- | -------------------- | ----------------------------------- |
| `SMALLINT`        | 2 bytes  | **-32,768 → 32,767**                                       | small numbers        | `age SMALLINT`, `rating SMALLINT`   |
| `INT` / `INTEGER` | 4 bytes  | **-2,147,483,648 → 2,147,483,647**                         | normal numbers       | `marks INT`, `salary INT`                   |
| `BIGINT`          | 8 bytes  | **-9,223,372,036,854,775,808 → 9,223,372,036,854,775,807** | large numbers        | `phone BIGINT`, `population BIGINT`   |
| `SERIAL`          | 4 bytes  | **1 → 2,147,483,647** *(auto increment)*                   | auto increment ID    | `id SERIAL PRIMARY KEY`             |
| `BIGSERIAL`       | 8 bytes  | **1 → 9,223,372,036,854,775,807** *(auto increment)*       | large auto increment | `id BIGSERIAL PRIMARY KEY`          |

## 2. Decimal / Floating
| Type                            | Size     | Range / Precision                               | Use                       | Example                        |
| ------------------------------- | -------- | ----------------------------------------------- | ------------------------- | ------------------------------ |
| `NUMERIC(p,s)` / `DECIMAL(p,s)` | variable | **Exact** (precision `p` max ≈ **1000 digits**) | Money, finance (accurate) | `salary NUMERIC(10,2)`         |
| `REAL`                          | 4 bytes  | approx **6 decimal digits precision**           | small float values        | `temp REAL`                    |
| `DOUBLE PRECISION`              | 8 bytes  | approx **15 decimal digits precision**          | high precision float      | `model_score DOUBLE PRECISION` |

**NUMERIC(p, s)**
```bash

p = total digits (precision)

s = digits after the decimal (scale)
```

**Example: NUMERIC(10,2)**
```bash
Total 10 digits, with 2 digits after the decimal point

Maximum value: 99999999.99
Minimum value: -99999999.99
```
## 3. Character / String Types
| Type         | Size / Limit (Range)                                     | Use                          | Example             |
| ------------ | -------------------------------------------------------- | ---------------------------- | ------------------- |
| `CHAR(n)`    | **Fixed length = n characters** (space padding hoti hai) | fixed length data (rare use) | `gender CHAR(1)`    |
| `VARCHAR(n)` | **0 to n characters** (max n)                            | normal text with limit       | `name VARCHAR(100)` |
| `TEXT`       | **Unlimited length** *(practically very large)*          | long text / description      | `address TEXT`      |




## 4. Date & Time Types
| Type          | Use                     | Range                                              | Format (Input/Output)            | Example Column              |
| ------------- | ----------------------- | -------------------------------------------------- | -------------------------------- | --------------------------- |
| `DATE`        | only date               | **4713 BC → 5874897 AD**                           | `YYYY-MM-DD`                     | `dob DATE`                  |
| `TIME`        | only time               | **00:00:00 → 24:00:00**                            | `HH:MI:SS`                       | `login_time TIME`           |
| `TIMESTAMP`   | date + time             | **4713 BC → 5874897 AD**                           | `YYYY-MM-DD HH:MI:SS`            | `created_at TIMESTAMP`      |
| `TIMESTAMPTZ` | timestamp with timezone | **4713 BC → 5874897 AD**                           | `YYYY-MM-DD HH:MI:SS+TZ`         | `event_time TIMESTAMPTZ`    |
| `INTERVAL`    | time duration           | approx **-178,000,000 years → +178,000,000 years** | `n years n mons n days HH:MI:SS` | `session_duration INTERVAL` |


## 5. Boolean
| Type      | Allowed Values (Range)                                              | Use            | Example Column      |
| --------- | ------------------------------------------------------------------- | -------------- | ------------------- |
| `BOOLEAN` | `TRUE` / `FALSE` *(also accepts: `t/f`, `yes/no`, `1/0`, `on/off`)* | status / flags | `is_active BOOLEAN` |


## 6. Advanced Types
### 6.1 UUID
UUID (Unique ID) means Universally Unique Identifier.

It is a special 128-bit ID used to uniquely identify something(like a user, order, record, etc.) and it is designed so that the chance of two UUIDs being the same is extremely low.

| Type   | Size     | Use                        |
| ------ | -------- | -------------------------- |
| `UUID` | 16 bytes | globally unique identifier |

**Why UUID is used**
<ul>
<li>Unique across systems and servers</li>
<li>Good for distributed applications (multiple machines creating IDs)</li>
<li>More secure than auto-increment IDs (harder to guess)</li>
</ul>


Example: - Column as UUID
```bash
CREATE TABLE users (
  user_id UUID PRIMARY KEY,
  name TEXT
);
```
### 6.2 JSON Types
| Type    | Use                   | Key Point                                           |
| ------- | --------------------- | --------------------------------------------------- |
| `JSON`  | Store JSON data       | Stores JSON **as text** (keeps formatting)          |
| `JSONB` | Faster + indexed JSON | Stores JSON in **binary format**, faster for search |


**JSON**
<ul>
<li>Stores JSON exactly as input (spaces, order preserved)</li>
<li>Slower for searching/filtering</li>
<li>No efficient indexing like JSONB</li>
</ul>

**JSONB**
<ul>
<li>Stores JSON in optimized binary format</li>
<li>Fast querying</li>
<li>Supports indexing</li>
</ul>

Example Table
```bash
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name TEXT,
  profile JSONB
);
```
Insert JSON Data
```bash
INSERT INTO users (name, profile)
VALUES (
  'Aman',
  '{"age": 24, "skills": ["Python", "SQL"], "city": "Dehradun"}'
);
```
Query JSON/JSONB Data
1) Get a key value
```bash
   SELECT profile -> 'city' AS city
FROM users;
```
2) Get value as text
```bash
SELECT profile ->> 'city' AS city
FROM users;
```
Filter using JSONB
Find users from city = Dehradun
```bash
SELECT *
FROM users
WHERE profile ->> 'city' = 'Dehradun';
```
### 6.3 Array Types

| Array Type  | Meaning       | Range / Limit                                                                               | Example              |
| ----------- | ------------- | ------------------------------------------------------------------------------------------- | -------------------- |
| `TEXT[]`    | text array    | **Unlimited text per element** + many elements *(practical limit: row size ~ 1.6 GB TOAST)* | `skills TEXT[]`      |
| `INT[]`     | integer array | Each element range: **-2,147,483,648 → 2,147,483,647**                                      | `marks INT[]`        |
| `VARCHAR[]` | varchar array | Each element max length: **VARCHAR(n)** (example: `VARCHAR(50)` → max 50 characters)        | `tags VARCHAR(50)[]` |

<ul>
<li>Array limit = base datatype limit</li>
<li>Example:</li>
<ul>
<li>INT[] → each number must be within INT range</li>
<li>VARCHAR(20)[] → each string max 20 characters</li>
<li>TEXT[] → no length limit per string (very large allowed)</li>
</ul>
</ul>

In PostgreSQL, an array type allows you to store multiple values in a single column.

Example: A student can have multiple skills like:
```bash
["Python", "SQL", "ML"]
```
So instead of creating separate rows, PostgreSQL lets you store them as an array.


**Create Table with Array Column**

```bash
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  skills TEXT[]
);
```
**Insert Data into Array**
Method 1: Using ARRAY[ ]
```bash
INSERT INTO students (name, skills)
VALUES ('Aman', ARRAY['Python','SQL','ML']);
```
Method 2: Using curly braces { }
```bash
INSERT INTO students (name, skills)
VALUES ('Riya', '{"Python","Excel"}');
```
**View Array Data**
```bash
SELECT * FROM students;
```
**Important Array Queries**
1) Check if value exists in array
   
Find students having "SQL"
```bash
SELECT *
FROM students
WHERE 'SQL' = ANY(skills);
```
2) Search using @> (contains)

students jinke skills me Python ho
```bash
SELECT *
FROM students
WHERE skills @> ARRAY['Python'];
```

3) Search students having BOTH Python and SQL
```bash
SELECT *
FROM students
WHERE skills @> ARRAY['Python','SQL'];
```

4) Add new element to array
```bash
UPDATE students
SET skills = array_append(skills, 'Deep Learning')
WHERE name = 'Aman';
```

5) Remove element from array
```bash
UPDATE students
SET skills = array_remove(skills, 'SQL')
WHERE name = 'Aman';
```
6) Array length
```bash
SELECT name, array_length(skills, 1) AS total_skills
FROM students;
```
7) Convert array → rows
```bash
SELECT name, unnest(skills) AS skill
FROM students;
```

### 6.4 BYTEA
BYTEA is used to store binary data (raw bytes), like:

<ul>
<li>images</li>
<li>PDFs</li>
<li>files</li>
<li>encrypted data</li>
</ul>

Size / Limit (Range)
<ul>
<li>Stores binary strings (bytes)</li>
<li>Maximum size can be up to ~1 GB per field (large values are stored using TOAST internally)</li>
</ul>

Example
```bash
CREATE TABLE files (
  id SERIAL PRIMARY KEY,
  file_name TEXT,
  file_data BYTEA
);
```
Insert with hex format
```bash
INSERT INTO files (file_name, file_data)
VALUES ('test.txt', '\x48656c6c6f');   -- "Hello" in hex
```
### 6.5 MONEY
MONEY is used to store currency values.

Range
<ul><li>-92233720368547758.08 → 92233720368547758.07</li></ul>

(Depends on locale formatting, but numeric range is like above.)

Example
```bash
CREATE TABLE payments (
  id SERIAL PRIMARY KEY,
  amount MONEY
);
```
Insert:
```bash
INSERT INTO payments (amount)
VALUES ('$1500.50');
```
### 6.6 INET 
✅ Meaning

INET stores IP addresses:
<ul>
<li>IPv4</li>
<li>IPv6</li>
</ul>

📏 Range / Limit
<ul>
<li>IPv4 examples: 192.168.1.1</li>
<li>IPv6 examples: 2001:db8::1</li>
<li>It can also store subnet masks like: 192.168.1.0/24</li>
</ul>

Example
```bash
CREATE TABLE user_sessions (
  id SERIAL PRIMARY KEY,
  user_name TEXT,
  ip_address INET
);
```
Insert:
```bash
INSERT INTO user_sessions (user_name, ip_address)
VALUES ('Aman', '192.168.1.10');
```
| Type    | Stores       | Range / Size   | Best Use                        |
| ------- | ------------ | -------------- | ------------------------------- |
| `BYTEA` | binary bytes | up to ~1 GB    | files, images                   |
| `MONEY` | currency     | ±9e16 (approx) | amounts (but NUMERIC preferred) |
| `INET`  | IP address   | IPv4 / IPv6    | logs, sessions                  |
























