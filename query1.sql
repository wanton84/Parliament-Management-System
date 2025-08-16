CREATE TABLE Member_of_Parliament (
    MP_ID INT PRIMARY KEY,
    FName VARCHAR(50),
    LName VARCHAR(50),
    DOB DATE,
    PhNo VARCHAR(15),
    Age INT
);

INSERT INTO Member_of_Parliament (MP_ID, FName, LName, DOB, PhNo, Age) VALUES
(1, 'John', 'Doe', '1970-01-01', '1234567890', 54),
(2, 'Jane', 'Smith', '1980-02-02', '1234567891', 44),
(3, 'Alice', 'Johnson', '1990-03-03', '1234567892', 34),
(4, 'Bob', 'Brown', '1985-04-04', '1234567893', 39),
(5, 'Charlie', 'Davis', '1975-05-05', '1234567894', 49),
(6, 'Diana', 'Miller', '1965-06-06', '1234567895', 59),
(7, 'Edward', 'Wilson', '1988-07-07', '1234567896', 36),
(8, 'Fiona', 'Moore', '1995-08-08', '1234567897', 29),
(9, 'George', 'Taylor', '1978-09-09', '1234567898', 46),
(10, 'Helen', 'Anderson', '1983-10-10', '1234567899', 41);

CREATE TABLE Constituency (
    C_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Region VARCHAR(100)
);

INSERT INTO Constituency (C_ID, Name, Region) VALUES
(1, 'Constituency A', 'Region 1'),
(2, 'Constituency B', 'Region 2'),
(3, 'Constituency C', 'Region 3'),
(4, 'Constituency D', 'Region 4'),
(5, 'Constituency E', 'Region 5'),
(6, 'Constituency F', 'Region 6'),
(7, 'Constituency G', 'Region 7'),
(8, 'Constituency H', 'Region 8'),
(9, 'Constituency I', 'Region 9'),
(10, 'Constituency J', 'Region 10');

CREATE TABLE Party (
    P_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Leader VARCHAR(100)
);

INSERT INTO Party (P_ID, Name, Leader) VALUES
(1, 'Party A', 'Leader A'),
(2, 'Party B', 'Leader B'),
(3, 'Party C', 'Leader C'),
(4, 'Party D', 'Leader D'),
(5, 'Party E', 'Leader E'),
(6, 'Party F', 'Leader F'),
(7, 'Party G', 'Leader G'),
(8, 'Party H', 'Leader H'),
(9, 'Party I', 'Leader I'),
(10, 'Party J', 'Leader J');

CREATE TABLE Bill (
    Bill_ID INT PRIMARY KEY,
    Title VARCHAR(200),
    Date_intro DATE,
    MP_ID INT,
    FOREIGN KEY (MP_ID) REFERENCES Member_of_Parliament(MP_ID)
);

INSERT INTO Bill (Bill_ID, Title, Date_intro, MP_ID) VALUES
(1, 'Bill A', '2020-01-01', 1),
(2, 'Bill B', '2020-02-02', 2),
(3, 'Bill C', '2020-03-03', 3),
(4, 'Bill D', '2020-04-04', 4),
(5, 'Bill E', '2020-05-05', 5),
(6, 'Bill F', '2020-06-06', 6),
(7, 'Bill G', '2020-07-07', 7),
(8, 'Bill H', '2020-08-08', 8),
(9, 'Bill I', '2020-09-09', 9),
(10, 'Bill J', '2020-10-10', 10);

CREATE TABLE Committee (
    Committee_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Chairperson_ID INT,
    FOREIGN KEY (Chairperson_ID) REFERENCES Member_of_Parliament(MP_ID)
);

INSERT INTO Committee (Committee_ID, Name, Chairperson_ID) VALUES
(1, 'Committee A', 1),
(2, 'Committee B', 2),
(3, 'Committee C', 3),
(4, 'Committee D', 4),
(5, 'Committee E', 5),
(6, 'Committee F', 6),
(7, 'Committee G', 7),
(8, 'Committee H', 8),
(9, 'Committee I', 9),
(10, 'Committee J', 10);

CREATE TABLE Session (
    Session_ID INT PRIMARY KEY,
    Start_date DATE,
    End_date DATE
);

INSERT INTO Session (Session_ID, Start_date, End_date) VALUES
(1, '2020-01-01', '2020-01-31'),
(2, '2020-02-01', '2020-02-29'),
(3, '2020-03-01', '2020-03-31'),
(4, '2020-04-01', '2020-04-30'),
(5, '2020-05-01', '2020-05-31'),
(6, '2020-06-01', '2020-06-30'),
(7, '2020-07-01', '2020-07-31'),
(8, '2020-08-01', '2020-08-31'),
(9, '2020-09-01', '2020-09-30'),
(10, '2020-10-01', '2020-10-31');

CREATE TABLE Vote (
    Vote_ID INT PRIMARY KEY,
    Bill_ID INT,
    MP_ID INT,
    Vote VARCHAR(10),
    FOREIGN KEY (Bill_ID) REFERENCES Bill(Bill_ID),
    FOREIGN KEY (MP_ID) REFERENCES Member_of_Parliament(MP_ID)
);

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



CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

INSERT INTO Users (username, password) VALUES ('shrajan', 'shrajan123');
INSERT INTO Users (username, password) VALUES ('ganesh', 'ganesh123');
INSERT INTO Users (username, password) VALUES ('shashank', 'shashank123');