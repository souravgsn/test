CREATE DATABASE mca_22;
USE mca_22;
show tables;
desc book;
drop table book;
drop table author;
CREATE TABLE book (
    book_code VARCHAR(5) PRIMARY KEY,
    isbn_no VARCHAR(8) NOT NULL,
    book_name VARCHAR(8) UNIQUE,
    publisher VARCHAR(6),
    price FLOAT(5,2) CHECK (price >= 100),
    author_name VARCHAR(8),
    date_of_launch DATE
);
desc book;



INSERT INTO book VALUES 
("A", "001", "OS", "TMH", 930.5, "sourav", '2000-04-19'),
("B", "002", "CN", "BPB", 175.5, "sathak", "2000-07-21"),
("C", "003", "PN", "PHI", 150.1, "bablu", "2001-08-22"),
("D", "004", "DBMS", "JKS", 120.2, "Diana", "2005-06-30"),
("E", "005", "HTML", "TMH", 800.9, "Cindy", "1995-04-11"),
("F", "006", "DSA", "TMH", 230.0, "Aman", "1956-04-01"),
("G", "007", "Python", "PHI", 999.0, "Bablu", "2011-03-07"),
("H", "008", "JAVA", "BPB", 666.5, "Bablu", "2014-02-14"),
("I", "009", "GRAPHICS", "TMH", 920.69, "sourav", "2014-07-01"),
("J", "010", "Keeper", "BPB", 100.0, "Aman", "1970-12-07");
SELECT * from BOOK;

update BOOK set publisher = 'TMH' where book_code = "I"; 


ALTER TABLE BOOK MODIFY COLUMN BOOK_NAME VARCHAR(10);



SELECT SUM(price) AS 'total_price' FROM book WHERE publisher = 'TMH';



SELECT * FROM book WHERE author_name = 'sourav' OR author_name = 'Aman';



DELETE FROM book WHERE publisher = 'PHI';



UPDATE book SET price = price * 1.05 WHERE publisher = 'BPB';



CREATE TABLE author (
    author_id VARCHAR(5) PRIMARY KEY,
    author_name VARCHAR(8) NOT NULL,
    subject VARCHAR(10) NOT NULL,
    contact VARCHAR(10),
    research VARCHAR(10)
);
desc author;



INSERT INTO author VALUES
("10001", "Zinetsu", "DSA", "8171420112", "Queue"),
("10002", "Cindy", "WebDev", "4391576881", "Web Mining"),
("10003", "Diana", "Database", "9273595112", "Er Diagram"),
("10004", "Sourav", "OS", "9111021006", "Scheduling"),
("10005", "AMAN", "DSA", "7102811110", "Trees"),
("10006", "Lee", "CG", "7138699420", "RayTracing"),
("10007", "Bablu", "CN", "7056792211", "Web Mining"),
("10008", "goJo", "Fiction", "7182810281", "SciFi"),
("10009", "Ichigo", "Spritual", "5829191015", NULL),
("10010", "Kira", "Psychology", "1029811121", NULL);
SELECT * FROM author;
SELECT * FROM author WHERE research = "Web Mining";



ALTER TABLE book 
    ADD COLUMN author_id VARCHAR(10),
    ADD FOREIGN KEY(author_id) REFERENCES author(author_id);
DESC book;



UPDATE book
    INNER JOIN author ON (book.author_name = author.author_name)
    SET book.author_id = author.author_id;
SELECT * FROM book;



SELECT * FROM book WHERE 
    book_name LIKE "C%" OR
    book_name LIKE "G%" OR
    book_name LIKE "K%";



CREATE VIEW PHI_books AS
    SELECT book_code, book_name, price FROM book
    WHERE book.publisher = "TMH";
SELECT * FROM PHI_books;