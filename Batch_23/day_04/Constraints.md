# Constraints 
Constraints are rules applied to table columns to make sure that the data stored in the database is valid, accurate, and consistent.

"Constraints control what kind of data can be inserted or updated in a table."

 **Why do we use Constraints?**
 <ul>
<li>prevent wrong/invalid data</li>
<li>avoid duplicate values</li>
<li>maintain data integrity</li>
<li>create relationships between tables</li>
</ul>

 
## Types of Constraints
### 1. NOT NULL
Prevents NULL (empty) values in a column.
```bash
CREATE TABLE students (
  id SERIAL,
  name TEXT NOT NULL
);
```
### 2. UNIQUE

Ensures all values in a column are unique (no duplicates).
```bash
CREATE TABLE users (
  id SERIAL,
  email TEXT UNIQUE
);
```
### 3. PRIMARY KEY
A PRIMARY KEY uniquely identifies each row in a table.

✅ Rules:
<ul>
<li>Unique values</li>
<li>NOT NULL</li>
</ul>


**Single Primary Key**

One column is the primary key.

```bash
CREATE TABLE students (
  student_id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

```
**Composite Primary Key**

Two (or more) columns together make a primary key.

Used when one column alone is not unique.

Example: A student can enroll in many courses, but a student cannot enroll in the same course twice.

```bash
CREATE TABLE enrollments (
  student_id INT,
  course_id INT,
  enrollment_date DATE,
  PRIMARY KEY (student_id, course_id)
);
```

### 4. FOREIGN KEY

A FOREIGN KEY creates a relationship between two tables.

It ensures that:
```bash
the value in child table must exist in the parent table.
```
Example (Parent → Child)

Parent table:
```bash
CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  name TEXT
);
```
Child table:
```bash
CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(customer_id),
  order_date DATE
);
```
orders.customer_id must exist inside customers.customer_id

### 5. CHECK

Checks a condition before inserting/updating data.
```bash
CREATE TABLE marks (
  id SERIAL PRIMARY KEY,
  score INT CHECK(score >= 0 AND score <= 100)
);
```
### 6. DEFAULT

Sets a default value if no value is provided.
```bash
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  is_active BOOLEAN DEFAULT TRUE
);
```

##  Cascading Actions
1) CASCADE

Automatically deletes/updates child rows
```bash
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
ON DELETE CASCADE
```

Delete customer → all orders of that customer will also be deleted.

2) RESTRICT

Parent row cannot be deleted if child rows exist.
```bash
ON DELETE RESTRICT
```

If orders exist → cannot delete customer.

Default behavior is mostly similar to RESTRICT.

3) SET NULL

Parent delete/update → child FK becomes NULL
```bash
ON DELETE SET NULL
```

Delete customer → order remains, but customer_id becomes NULL.

FK column must allow NULL.

## Adding/Dropping Constraints
Add constraint (ALTER TABLE)

1) Add PRIMARY KEY
```bash
ALTER TABLE students
ADD CONSTRAINT pk_students PRIMARY KEY(student_id);
```

2) Add UNIQUE
```bash
ALTER TABLE students
ADD CONSTRAINT unique_email UNIQUE(email);
```


3) Add FOREIGN KEY
```bash
ALTER TABLE orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);
```

➖ Drop constraint

First find constraint name:
```bash
SELECT conname
FROM pg_constraint
WHERE conrelid = 'orders'::regclass;
```

Then drop:
```bash
ALTER TABLE orders
DROP CONSTRAINT fk_orders_customer;
```