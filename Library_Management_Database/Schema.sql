CREATE DATABASE Library_db;
USE Library_db;

CREATE TABLE authors(
 author_id INT PRIMARY KEY ,
 author_name VARCHAR(50)
 );
 
 CREATE TABLE books(
 book_no INT PRIMARY KEY,
 book_name VARCHAR(50),
 author_id INT,
 FOREIGN KEY (author_id) REFERENCES authors(author_id)
 );
 
 CREATE TABLE members(
 member_id INT PRIMARY KEY AUTO_INCREMENT,
 member_name VARCHAR(50)
 );
 
 CREATE TABLE book_issue(
 days INT ,
 member_id INT,
 book_no INT,
 PRIMARY KEY  (book_no , member_id),
 FOREIGN KEY (member_id) REFERENCES members(member_id), 
 FOREIGN KEY (book_no) REFERENCES books(book_no)
 );
 
 CREATE TABLE fine(
 member_id INT, 
 fine_money INT ,
 book_no INT,
 Primary Key (member_id , book_no),
 FOREIGN KEY (member_id) REFERENCES members(member_id),
 FOREIGN KEY (book_no) REFERENCES books(book_no)
 );


