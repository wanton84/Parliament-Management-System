CREATE TABLE Member_of_Parliament (
    MP_ID INT PRIMARY KEY,
    FName VARCHAR(50),
    LName VARCHAR(50),
    DOB DATE,
    PhNo VARCHAR(15),
    Age INT
);

CREATE TABLE Constituency (
    C_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Region VARCHAR(100)
);

CREATE TABLE Party (
    P_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Leader VARCHAR(100)
);

CREATE TABLE Bill (
    Bill_ID INT PRIMARY KEY,
    Title VARCHAR(200),
    Date_intro DATE,
    MP_ID INT,
    FOREIGN KEY (MP_ID) REFERENCES Member_of_Parliament(MP_ID)
);

CREATE TABLE Committee (
    Committee_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Chairperson_ID INT,
    FOREIGN KEY (Chairperson_ID) REFERENCES Member_of_Parliament(MP_ID)
);

CREATE TABLE Session (
    Session_ID INT PRIMARY KEY,
    Start_date DATE,
    End_date DATE
);

CREATE TABLE Vote (
    Vote_ID INT PRIMARY KEY,
    Bill_ID INT,
    MP_ID INT,
    Vote VARCHAR(10),
    FOREIGN KEY (Bill_ID) REFERENCES Bill(Bill_ID),
    FOREIGN KEY (MP_ID) REFERENCES Member_of_Parliament(MP_ID)
);


-- Inserting Members of Parliament
INSERT INTO Member_of_Parliament (MP_ID, FName, LName, DOB, PhNo, Age) VALUES
(1, 'Rajesh', 'Sharma', '1965-05-20', '+911234567890', 59),
(2, 'Aditi', 'Patel', '1975-11-15', '+911234567891', 48),
(3, 'Vikram', 'Reddy', '1980-07-25', '+911234567892', 43),
(4, 'Neeta', 'Gupta', '1987-03-10', '+911234567893', 37),
(5, 'Suresh', 'Kumar', '1992-09-30', '+911234567894', 31),
(6, 'Anjali', 'Singh', '1980-12-12', '+911234567895', 43),
(7, 'Ravi', 'Mehta', '1978-04-20', '+911234567896', 46),
(8, 'Priya', 'Chopra', '1990-01-05', '+911234567897', 34),
(9, 'Arun', 'Verma', '1968-08-18', '+911234567898', 55),
(10, 'Kavita', 'Joshi', '1995-06-25', '+911234567899', 29);

-- Inserting Constituencies
INSERT INTO Constituency (C_ID, Name, Region) VALUES
(1, 'Delhi East', 'Delhi'),
(2, 'Mumbai South', 'Maharashtra'),
(3, 'Kolkata North', 'West Bengal'),
(4, 'Chennai Central', 'Tamil Nadu'),
(5, 'Bangalore South', 'Karnataka'),
(6, 'Hyderabad West', 'Telangana'),
(7, 'Pune North', 'Maharashtra'),
(8, 'Jaipur South', 'Rajasthan'),
(9, 'Lucknow East', 'Uttar Pradesh'),
(10, 'Ahmedabad West', 'Gujarat');

-- Inserting Parties
INSERT INTO Party (P_ID, Name, Leader) VALUES
(1, 'Bharatiya Janata Party', 'Narendra Modi'),
(2, 'Indian National Congress', 'Sonia Gandhi'),
(3, 'Aam Aadmi Party', 'Arvind Kejriwal'),
(4, 'Communist Party of India (Marxist)', 'Sitaram Yechury'),
(5, 'Nationalist Congress Party', 'Sharad Pawar'),
(6, 'Bahujan Samaj Party', 'Mayawati'),
(7, 'Trinamool Congress', 'Mamata Banerjee'),
(8, 'Yuvajana Sramika Rythu Congress', 'Y. S. Jagan Mohan Reddy'),
(9, 'Rashtriya Janata Dal', 'Lalu Prasad Yadav'),
(10, 'Janata Dal (United)', 'Nitish Kumar');

-- Inserting Bills
INSERT INTO Bill (Bill_ID, Title, Date_intro, MP_ID) VALUES
(1, 'National Health Protection Scheme', '2023-02-15', 1),
(2, 'Affordable Education Bill', '2023-03-10', 2),
(3, 'Infrastructure Development Plan', '2023-04-22', 3),
(4, 'Clean Energy Promotion Act', '2023-05-05', 4),
(5, 'Economic Reforms Act', '2023-06-30', 5),
(6, 'Public Housing Initiative', '2023-07-12', 6),
(7, 'National Security Enhancement Act', '2023-08-20', 7),
(8, 'Employment Generation Bill', '2023-09-15', 8),
(9, 'Universal Healthcare Access Bill', '2023-10-10', 9),
(10, 'Green Technology Investment', '2023-11-25', 10);

-- Inserting Committees
INSERT INTO Committee (Committee_ID, Name, Chairperson_ID) VALUES
(1, 'Health and Family Welfare Committee', 1),
(2, 'Education and Social Welfare Committee', 2),
(3, 'Infrastructure and Urban Development Committee', 3),
(4, 'Environment and Forests Committee', 4),
(5, 'Finance and Economic Affairs Committee', 5),
(6, 'Housing and Urban Affairs Committee', 6),
(7, 'Home Affairs Committee', 7),
(8, 'Labour and Employment Committee', 8),
(9, 'Health and Medical Services Committee', 9),
(10, 'Science and Technology Committee', 10);

-- Inserting Sessions
INSERT INTO Session (Session_ID, Start_date, End_date) VALUES
(1, '2023-01-01', '2023-03-31'),
(2, '2023-04-01', '2023-06-30'),
(3, '2023-07-01', '2023-09-30'),
(4, '2023-10-01', '2023-12-31'),
(5, '2024-01-01', '2024-03-31'),
(6, '2024-04-01', '2024-06-30'),
(7, '2024-07-01', '2024-09-30'),
(8, '2024-10-01', '2024-12-31'),
(9, '2025-01-01', '2025-03-31'),
(10, '2025-04-01', '2025-06-30');

-- Inserting Votes
INSERT INTO Vote (Vote_ID, Bill_ID, MP_ID, Vote) VALUES
(1, 1, 1, 'Yes'),
(2, 2, 2, 'No'),
(3, 3, 3, 'Yes'),
(4, 4, 4, 'No'),
(5, 5, 5, 'Yes'),
(6, 6, 6, 'No'),
(7, 7, 7, 'Yes'),
(8, 8, 8, 'No'),
(9, 9, 9, 'Yes'),
(10, 10, 10, 'No');

DELETE FROM Session
WHERE Session_ID = 1;
