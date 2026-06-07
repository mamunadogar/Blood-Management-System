CREATE DATABASE BloodDonationSystem;

CREATE TABLE Donor(
    DonorID SERIAL PRIMARY KEY,
    Name VARCHAR(50),
    BloodGroup VARCHAR(5),
    City VARCHAR(50),
    ContactNo VARCHAR(15)
);

CREATE TABLE Patient(
    PatientID SERIAL PRIMARY KEY,
    Name VARCHAR(50),
    BloodGroup VARCHAR(5),
    City VARCHAR(50),
    ContactNo VARCHAR(15)
);

CREATE TABLE BloodRequest(
    RequestID SERIAL PRIMARY KEY,
    PatientID INT,
    BloodGroup VARCHAR(5),
    RequestDate DATE,
    Status VARCHAR(20),

    FOREIGN KEY(PatientID)
    REFERENCES Patient(PatientID)
);

CREATE TABLE Donation(
    DonationID SERIAL PRIMARY KEY,
    DonorID INT,
    RequestID INT,
    DonationDate DATE,
    Status VARCHAR(20),

    FOREIGN KEY(DonorID)
    REFERENCES Donor(DonorID),

    FOREIGN KEY(RequestID)
    REFERENCES BloodRequest(RequestID)
);

CREATE TABLE Admin(
    AdminID SERIAL PRIMARY KEY,
    Name VARCHAR(50),
    Username VARCHAR(30),
    Password VARCHAR(30)
);

INSERT INTO Donor(Name,BloodGroup,City,ContactNo)
VALUES
('Ali Khan','A+','Lahore','03001111111'),
('Ahmed Raza','B+','Islamabad','03002222222'),
('Usman Tariq','O+','Faisalabad','03003333333');

INSERT INTO Patient(Name,BloodGroup,City,ContactNo)
VALUES
('Bilal Ahmed','A+','Lahore','03111111111'),
('Hamza Khan','O+','Karachi','03222222222');

INSERT INTO BloodRequest(PatientID,BloodGroup,RequestDate,Status)
VALUES
(1,'A+',CURRENT_DATE,'Pending'),
(2,'O+',CURRENT_DATE,'Pending');

INSERT INTO Donation(DonorID,RequestID,DonationDate,Status)
VALUES
(1,1,CURRENT_DATE,'Completed');

INSERT INTO Admin(Name,Username,Password)
VALUES
('Admin','admin','admin123');

UPDATE BloodRequest
SET Status='Completed'
WHERE RequestID=1;

SELECT * FROM Donor;

SELECT * FROM Patient;

SELECT * FROM BloodRequest;

SELECT
D.Name,
D.BloodGroup,
D.City,
P.Name AS PatientName,
BR.Status
FROM Donation DN
JOIN Donor D ON DN.DonorID=D.DonorID
JOIN BloodRequest BR ON DN.RequestID=BR.RequestID
JOIN Patient P ON BR.PatientID=P.PatientID;

SELECT COUNT(*) AS TotalDonors
FROM Donor;

SELECT COUNT(*) AS TotalPatients
FROM Patient;

SELECT COUNT(*) AS TotalRequests
FROM BloodRequest;

SELECT *
FROM Donor
WHERE BloodGroup='A+';

SELECT *
FROM Donor
WHERE City='Lahore';
