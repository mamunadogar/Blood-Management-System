CREATE DATABASE  blood_donation_db;
USE blood_donation_db;
CREATE TABLE  donors (
    donor_id     INT AUTO_INCREMENT PRIMARY KEY,
    full_name    VARCHAR(100) NOT NULL,
    blood_group  VARCHAR(5)   NOT NULL,
    city         VARCHAR(50)  NOT NULL,
    contact_no   VARCHAR(15)  NOT NULL,
    is_available TINYINT(1)  DEFAULT 1,
    registered_at DATETIME  DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE  blood_requests (
    request_id   INT AUTO_INCREMENT PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,
    blood_group  VARCHAR(5)   NOT NULL,
    city         VARCHAR(50)  NOT NULL,
    contact_no   VARCHAR(15)  NOT NULL,
    urgency      ENUM('Low','Medium','High') DEFAULT 'Medium',
    status       ENUM('Pending','Fulfilled','Cancelled') DEFAULT 'Pending',
    request_date DATETIME  DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO donors (full_name, blood_group, city, contact_no)
VALUES
  ('Ali Hassan',     'A+',  'Lahore',    '03001234567'),
  ('Sara Malik',     'B+',  'Karachi',   '03111234567'),
  ('Usman Khan',     'O+',  'Lahore',    '03211234567'),
  ('Fatima Noor',    'AB+', 'Islamabad', '03311234567'),
  ('Zain Butt',      'O-',  'Lahore',    '03411234567'),
  ('Hina Raza',      'A-',  'Karachi',   '03511234567'),
  ('Bilal Ahmed',    'B-',  'Islamabad', '03611234567'),
  ('Amna Sheikh',    'A+',  'Lahore',    '03711234567');
  INSERT INTO blood_requests (patient_name, blood_group, city, contact_no, urgency)
VALUES
  ('Raza Hussain',  'A+',  'Lahore',    '03001112233', 'High'),
  ('Nadia Parveen', 'O+',  'Karachi',   '03111112233', 'Medium'),
  ('Tariq Mehmood', 'B+',  'Islamabad', '03211112233', 'Low'),
  ('Sana Iqbal',    'AB+', 'Lahore',    '03311112233', 'High');
  SELECT donor_id, full_name, blood_group, city, contact_no, is_available
FROM donors
ORDER BY full_name ASC;
SELECT full_name, blood_group, city, contact_no
FROM donors
WHERE blood_group = 'A+'
  AND is_available = 1
ORDER BY city ASC;
SELECT full_name, blood_group, city, contact_no
FROM donors
WHERE blood_group = 'O+'
  AND city = 'Lahore'
  AND is_available = 1;
  SELECT full_name, blood_group, city, contact_no
FROM donors
WHERE full_name LIKE '%Ali%';
SELECT blood_group,
       COUNT(*) AS total_donors
FROM donors
WHERE is_available = 1
GROUP BY blood_group
ORDER BY total_donors DESC;
UPDATE donors
SET is_available = 0
WHERE donor_id = 1;
UPDATE donors
SET contact_no = '03009999999'
WHERE donor_id = 2;
DELETE FROM donors
WHERE donor_id = 3;
UPDATE blood_requests
SET status = 'Fulfilled'
WHERE request_id = 1;
SELECT
    r.request_id,
    r.patient_name,
    r.blood_group,
    r.city          AS patient_city,
    r.urgency,
    d.full_name     AS matched_donor,
    d.contact_no    AS donor_contact
FROM blood_requests r
JOIN donors d
    ON  d.blood_group = r.blood_group
    AND d.city        = r.city
    AND d.is_available = 1
WHERE r.status = 'Pending'
ORDER BY r.urgency DESC;
SELECT request_id, patient_name, blood_group, city, contact_no
FROM blood_requests
WHERE status = 'Pending'
  AND urgency = 'High'
ORDER BY request_date ASC;
SELECT city, COUNT(*) AS donor_count
FROM donors
WHERE is_available = 1
GROUP BY city
ORDER BY donor_count DESC;
