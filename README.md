# Blood Donation Management System
### Database Project — MySQL
**Mamuna Shahid (70155141) | Ayesha Ramzan (70127471)**

---

## Project Overview

The Blood Donation Management System is a digital system designed to store blood donor records and help patients find suitable donors quickly during emergencies. This project applies database management concepts to a real-world problem using MySQL.

---

## Technologies Used

- **Language:** SQL (MySQL 8.0)
- **Tool:** MySQL Workbench
- **Project Type:** Database Management System

---

## Database Structure

### Database Name
```
blood_donation_db
```

### Table 1 — `donors`
Stores information about blood donors.

| Column | Type | Description |
|--------|------|-------------|
| donor_id | INT AUTO_INCREMENT PRIMARY KEY | Unique donor ID |
| full_name | VARCHAR(100) NOT NULL | Full name of donor |
| blood_group | VARCHAR(5) NOT NULL | Blood group (A+, B+, O+ etc.) |
| city | VARCHAR(50) NOT NULL | City of donor |
| contact_no | VARCHAR(15) NOT NULL | Phone number |
| is_available | TINYINT(1) DEFAULT 1 | 1 = Available, 0 = Unavailable |
| registered_at | DATETIME | Registration timestamp |

### Table 2 — `blood_requests`
Stores blood requests submitted by patients.

| Column | Type | Description |
|--------|------|-------------|
| request_id | INT AUTO_INCREMENT PRIMARY KEY | Unique request ID |
| patient_name | VARCHAR(100) NOT NULL | Full name of patient |
| blood_group | VARCHAR(5) NOT NULL | Required blood group |
| city | VARCHAR(50) NOT NULL | City of patient |
| contact_no | VARCHAR(15) NOT NULL | Phone number |
| urgency | ENUM('Low','Medium','High') | Level of urgency |
| status | ENUM('Pending','Fulfilled','Cancelled') | Current request status |
| request_date | DATETIME | Date and time of request |

---

## How to Run

### Step 1 — Fresh Start
```sql
DROP DATABASE IF EXISTS blood_donation_db;
CREATE DATABASE blood_donation_db;
USE blood_donation_db;
```

### Step 2 — Create Tables
```sql
CREATE TABLE IF NOT EXISTS donors (
    donor_id      INT AUTO_INCREMENT PRIMARY KEY,
    full_name     VARCHAR(100) NOT NULL,
    blood_group   VARCHAR(5)   NOT NULL,
    city          VARCHAR(50)  NOT NULL,
    contact_no    VARCHAR(15)  NOT NULL,
    is_available  TINYINT(1)   DEFAULT 1,
    registered_at DATETIME     DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS blood_requests (
    request_id   INT AUTO_INCREMENT PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,
    blood_group  VARCHAR(5)   NOT NULL,
    city         VARCHAR(50)  NOT NULL,
    contact_no   VARCHAR(15)  NOT NULL,
    urgency      ENUM('Low','Medium','High')             DEFAULT 'Medium',
    status       ENUM('Pending','Fulfilled','Cancelled') DEFAULT 'Pending',
    request_date DATETIME                                DEFAULT CURRENT_TIMESTAMP
);
```

### Step 3 — Insert Sample Data
```sql
INSERT INTO donors (full_name, blood_group, city, contact_no)
VALUES
  ('Ali Hassan',   'A+',  'Lahore',    '03001234567'),
  ('Sara Malik',   'B+',  'Karachi',   '03111234567'),
  ('Usman Khan',   'O+',  'Lahore',    '03211234567'),
  ('Fatima Noor',  'AB+', 'Islamabad', '03311234567'),
  ('Zain Butt',    'O-',  'Lahore',    '03411234567'),
  ('Hina Raza',    'A-',  'Karachi',   '03511234567'),
  ('Bilal Ahmed',  'B-',  'Islamabad', '03611234567'),
  ('Amna Sheikh',  'A+',  'Lahore',    '03711234567');

INSERT INTO blood_requests (patient_name, blood_group, city, contact_no, urgency)
VALUES
  ('Raza Hussain',  'A+',  'Lahore',    '03001112233', 'High'),
  ('Nadia Parveen', 'O+',  'Karachi',   '03111112233', 'Medium'),
  ('Tariq Mehmood', 'B+',  'Islamabad', '03211112233', 'Low'),
  ('Sana Iqbal',    'AB+', 'Lahore',    '03311112233', 'High');
```

### Step 4 — Search Queries (Searching & Sorting)
```sql
-- Display all donors sorted alphabetically (DSA: Sorting Algorithm)
SELECT donor_id, full_name, blood_group, city, contact_no, is_available
FROM donors
ORDER BY full_name ASC;

-- Search donors by blood group
SELECT full_name, blood_group, city, contact_no
FROM donors
WHERE blood_group = 'A+' AND is_available = 1;

-- Search donors by blood group AND city (for emergency use)
SELECT full_name, blood_group, city, contact_no
FROM donors
WHERE blood_group = 'O+' AND city = 'Lahore' AND is_available = 1;

-- Search donor by partial name
SELECT full_name, blood_group, city, contact_no
FROM donors
WHERE full_name LIKE '%Ali%';

-- Count donors per blood group
SELECT blood_group, COUNT(*) AS total_donors
FROM donors
WHERE is_available = 1
GROUP BY blood_group
ORDER BY total_donors DESC;
```

### Step 5 — Update & Delete Queries (CRUD Operations)
```sql
-- Mark a donor as unavailable
UPDATE donors SET is_available = 0 WHERE donor_id = 1;

-- Update donor contact number
UPDATE donors SET contact_no = '03009999999' WHERE donor_id = 2;

-- Delete a donor record
DELETE FROM donors WHERE donor_id = 3;

-- Mark a blood request as fulfilled
UPDATE blood_requests SET status = 'Fulfilled' WHERE request_id = 1;
```

### Step 6 — Advanced Queries (JOIN / Matching Algorithm)
```sql
-- Match pending requests with available donors
SELECT
    r.patient_name,
    r.blood_group,
    r.urgency,
    d.full_name  AS matched_donor,
    d.contact_no AS donor_contact
FROM blood_requests r
JOIN donors d
    ON  d.blood_group  = r.blood_group
    AND d.city         = r.city
    AND d.is_available = 1
WHERE r.status = 'Pending'
ORDER BY r.urgency DESC;

-- View all high urgency pending requests
SELECT request_id, patient_name, blood_group, city, contact_no
FROM blood_requests
WHERE status = 'Pending' AND urgency = 'High'
ORDER BY request_date ASC;

-- Count donors available per city
SELECT city, COUNT(*) AS donor_count
FROM donors
WHERE is_available = 1
GROUP BY city
ORDER BY donor_count DESC;
```

---

## Database Concepts Applied

| Database Concept | SQL Implementation |
|-------------|-------------------|
| Sorting Algorithm | `ORDER BY full_name ASC` — alphabetical sorting |
| Searching Algorithm | `WHERE blood_group = 'A+' AND city = 'Lahore'` |
| Arrays and Lists | Table rows represent a list of donor records |
| CRUD Operations | INSERT, SELECT, UPDATE, DELETE |
| Matching Algorithm | JOIN query — matches patient request with donor |
| Aggregation | `COUNT(*) GROUP BY blood_group` |

---

## Key SQL Concepts Explained

| Keyword | Purpose |
|---------|---------|
| `PRIMARY KEY` | Uniquely identifies each row |
| `AUTO_INCREMENT` | Automatically assigns ID values (1, 2, 3...) |
| `NOT NULL` | Field cannot be left empty |
| `DEFAULT` | Sets a default value if none is provided |
| `ENUM` | Restricts a field to specific allowed values only |
| `JOIN` | Combines data from two tables based on a condition |
| `WHERE` | Filters rows based on a condition |
| `ORDER BY` | Sorts the result in ascending or descending order |
| `GROUP BY` | Groups rows with the same value together |
| `COUNT(*)` | Counts the number of rows in a group |
| `LIKE` | Searches for a pattern in a text column |

---

## Common Errors and Fixes

| Error | Cause | Fix |
|-------|-------|-----|
| `Database already exists` | Database was created before | Use `DROP DATABASE IF EXISTS` first |
| `Table already exists` | Table was created before | Use `CREATE TABLE IF NOT EXISTS` |
| `Unknown column` | Column name is misspelled | Double-check column names |
| `No data found` | INSERT not run yet | Run INSERT queries before SELECT |

---

## Project Features

- Donor registration and record management
- Search donors by blood group and city
- Patient blood request submission
- Donor availability tracking
- Emergency donor-patient matching using JOIN
- Alphabetical sorting of donor records
- Urgency-based request prioritization

---

## Expected Output Summary

| Query | Result |
|-------|--------|
| INSERT donors | 8 rows inserted successfully |
| INSERT requests | 4 rows inserted successfully |
| SELECT all donors | 8 donors listed A to Z |
| Search by blood group | Filtered donor list |
| JOIN query | Matched donors shown against patient requests |
| COUNT by blood group | Summary of donors per blood group |
| UPDATE / DELETE | Rows changed or removed successfully |

---

*Blood Donation Management System — Database Project 2024*  
*Department of Computer Science*
