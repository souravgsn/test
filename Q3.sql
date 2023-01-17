-- Q1

CREATE DATABASE MCA_22_A3;
USE MCA_22_A3;

CREATE TABLE Employee (
    Eid INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    EName VARCHAR(50) NOT NULL,
    Address VARCHAR(200) NOT NULL,
    DateOfJoining DATE NOT NULL,
    Department VARCHAR(50) NOT NULL 
);
DESC Employee;

CREATE TABLE Project (
    Pid INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    PName VARCHAR(50) NOT NULL,
    StartDate DATE NOT NULL,
    TerminationDate DATE
);
DESC Project;

CREATE TABLE AssignedTo (
    Eid INT UNSIGNED NOT NULL,
    Pid INT UNSIGNED NOT NULL,
    PRIMARY KEY (Eid, Pid),
    FOREIGN KEY (Eid) REFERENCES Employee(Eid),
    FOREIGN KEY (Pid) REFERENCES Project(Pid)
);
DESC AssignedTo;

INSERT INTO Employee (Ename, Address, DateOfJoining, Department)
    VALUES
    ("Austin", "United States", "1999-04-07", "D01"),
    ("John", "United States", "1998-07-09", "D02"),
    ("Washington", "United States", "1989-07-01", "D01"),
    ("Marry", "Italy", "1999-01-01", "D03"),
    ("Mukul", "Delhi", "1999-12-01", "D02"),
    ("Jai Parkash", "Haryana", "2000-02-07", "D03"),
    ("Kamal", "Delhi", "2000-09-11", "D04"),
    ("Sanchit", "Delhi", "1998-04-01", "D05");
SELECT * FROM Employee;

INSERT INTO Project (PName, StartDate, TerminationDate)
    VALUES
    ("Banking", "1999-01-02", "2000-07-07"),
    ("Bank", "2000-01-01", NULL),
    ("University", "1998-07-06", NULL),
    ("ShareMarket", "1997-05-06", "1999-12-01"),
    ("Crypto", "2001-12-12", NULL);
SELECT * FROM Project;

INSERT INTO AssignedTo VALUES
    (6, 1), (6, 5), (1, 2), (1, 4),
    (2, 4), (3, 3), (3, 1), (4, 4),
    (7, 1), (7, 2), (7, 3), (7, 4),
    (7, 5), (8, 3), (8, 2);
SELECT * FROM AssignedTo;


SELECT E.* FROM Employee as E
    JOIN AssignedTo as Ast ON Ast.Eid = E.Eid
    JOIN Project as P ON P.Pid = Ast.Pid 
    WHERE P.PName = "Banking";


SELECT P.* FROM Project as P
    JOIN AssignedTo as Ast ON Ast.Pid = P.Pid
    JOIN Employee as E ON E.Eid = Ast.Eid 
    WHERE E.Department IN ("D01", "D02")
    GROUP BY P.Pid ORDER BY P.Pid;


SELECT E.* FROM Employee as E
    JOIN AssignedTo as Ast ON Ast.Eid = E.Eid
    JOIN Project as P ON P.Pid = Ast.Pid 
    WHERE P.PName IN ("University", "ShareMarket") AND
    E.Address = "Delhi";


SELECT E.* FROM Employee as E
    JOIN AssignedTo as Ast ON Ast.Eid = E.Eid
    JOIN Project as P ON P.Pid = Ast.Pid 
    WHERE P.PName <> "University";


SELECT E.* FROM Employee as E
    JOIN AssignedTo as Ast ON Ast.Eid = E.Eid
    GROUP BY E.Eid
    HAVING Count(*) = (
        SELECT Count(*) FROM Project
    );


SELECT E1.* FROM Employee as E1
    LEFT JOIN (
        SELECT E2.Eid as id FROM Employee as E2
        JOIN AssignedTo as Ast ON Ast.Eid = E2.Eid
        GROUP BY E2.Eid
    ) as X ON X.id = E1.Eid
    WHERE X.id IS NULL;


SELECT E.* FROM Employee as E
    JOIN AssignedTo as Ast ON Ast.Eid = E.Eid
    JOIN Project as P ON P.Pid = Ast.Pid 
    WHERE E.DateOfJoining > (
        SELECT StartDate FROM Project
        WHERE PName = "Bank"
    ) GROUP BY E.Eid;


SELECT P.StartDate, P.TerminationDate
    FROM Project as P
    JOIN AssignedTo as Ast ON Ast.Pid = P.Pid
    JOIN Employee as E ON E.Eid = Ast.Eid
    WHERE E.Ename = "Jai Parkash";


-- Q2

CREATE DATABASE MCA_22_A3_Q2;
USE MCA_22_A3_Q2;

CREATE TABLE Student (
    Roll INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    SName VARCHAR(30) NOT NULL,
    City VARCHAR(30) NOT NULL,
    Age INT UNSIGNED NOT NULL CHECK(Age > 0),
    Gender ENUM('Male', 'Female') NOT NULL
);
DESC Student;

CREATE TABLE Course (
    Cid INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    CName VARCHAR(30) NOT NULL,
    Semester INT UNSIGNED NOT NULL,
    Credits INT UNSIGNED NOT NULL,
    Fee DECIMAL(7, 2) NOT NULL CHECK (Fee >= 0)
);
DESC Course;

CREATE TABLE Enrollment (
    Roll INT UNSIGNED,
    Cid INT UNSIGNED,
    EnrollmentDate DATE NOT NULL,
    PRIMARY KEY (Roll, Cid),
    FOREIGN KEY (Roll) REFERENCES Student(Roll),
    FOREIGN KEY (Cid) REFERENCES Course(Cid)
);
DESC Enrollment;

INSERT INTO Student(SName, City, Age, Gender) VALUES
    ("Anita", "Delhi", 20, "Female"),
    ("Kunal", "Haryana", 21, "Male"),
    ("Akash", "Goa", 20, "Male"),
    ("Alamat", "Mumbai", 22, "Male"),
    ("Vridhi", "Delhi", 20, "Female"),
    ("Harshita", "Delhi", 21, "Female"),
    ("Mukul", "Chennai", 21, "Male");
SELECT * FROM Student;

INSERT INTO Course(CName, Semester, Credits, Fee) VALUES
    ("MCA", 1, 120, 18600),
    ("MCA", 3, 120, 15000),
    ("MBA", 1, 250, 20000),
    ("MTech", 4, 250, 25000);
SELECT * FROM Course;

INSERT INTO Enrollment VALUES
    (1, 1, "2022-10-01"),
    (2, 3, "2022-09-01"),
    (3, 3, "2022-09-01"),
    (4, 4, "2021-06-01"),
    (5, 4, "2021-06-01"),
    (6, 2, "2021-10-01"),
    (7, 2, "2021-10-01");
SELECT * FROM Enrollment;


SELECT S.* FROM Student AS S
    JOIN Enrollment AS E ON E.Roll = S.Roll
    JOIN Course AS C ON C.Cid = E.Cid
    WHERE C.CName = "MCA";


SELECT COUNT(*) FROM Student AS S
    JOIN Enrollment AS E ON E.Roll = S.Roll
    JOIN Course AS C ON C.Cid = E.Cid
    WHERE C.CName = "MBA";


SELECT S.SName AS Name FROM Student AS S
    JOIN Enrollment AS E ON E.Roll = S.Roll
    JOIN Course AS C ON C.Cid = E.Cid
    WHERE C.CName = (
        SELECT C2.CName FROM Student AS S2
        JOIN Enrollment AS E2 ON E2.Roll = S2.Roll
        JOIN Course AS C2 ON C2.Cid = E2.Cid
        WHERE S2.SName = "Anita"
    );


SELECT S.SName, E.EnrollmentDate
    FROM Student as S
    JOIN Enrollment as E ON E.Roll = S.Roll;


SELECT C.CName FROM Student AS S
    JOIN Enrollment AS E ON E.Roll = S.Roll
    JOIN Course AS C ON C.Cid = E.Cid
    WHERE S.SName = "Kunal";


SELECT S.SName FROM Student as S
    JOIN Enrollment AS E ON E.Roll = S.Roll
    JOIN Course AS C ON C.Cid = E.Cid
    WHERE C.CName = "MCA" and S.Gender = "Male";


SELECT Count(*) FROM Student as S
    JOIN Enrollment AS E ON E.Roll = S.Roll
    JOIN Course AS C ON C.Cid = E.Cid
    WHERE C.CName = "MCA" AND S.City <> "Delhi";