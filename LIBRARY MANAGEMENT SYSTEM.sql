-- Create the database named library
CREATE DATABASE library;
USE library;

-- Create the Branch table
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);
DESC Branch;

insert into Branch(Branch_no,Manager_Id,Branch_address,Contact_no) values 
(10,101,'Malappuram',9988776655),
(11,102,'Calicut',9911223344),
(12,103,'Alappuzha',9955446633),
(13,104,'Idukki',9900884411);
SELECT * FROM Branch;

-- Create the Employee table
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);
DESC Employee;

insert into Employee values 
(1001,'Aishwarya','Librarian',25000,10),
(1002,'Adil','Assistant_Librarian',45000,11),
(1003,'Ashley','Deputy_Librarian',40000,12),
(1004,'Benny','Technical_Assistant',40000,13),
(1005,'Shreya','Data_Librarian',60000,10),
(1006,'Malti','Archivist',75000,10);
SELECT * FROM Employee;

-- Create the Books table
CREATE TABLE Books (
    ISBN INT PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(50),
    Rental_Price DECIMAL(10, 2),
    Status VARCHAR(3), -- "Yes" or "No"
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);
DESC Books;

insert into books values 
(2567, 'Pride and Prejudice', 'Fiction', 100.00, 'Yes', 'Jane Austen', 'Classic Publishers'),
(2996, 'The Kite Runner', 'Fiction', 40.00, 'Yes', 'Khaled Hosseini', 'Riverhead Books'),
(2937, 'It Ends with Us', 'Romance', 45.00, 'No', 'Colleen Hoover', 'Atria Books'),
(2738, 'Origin', 'Thriller', 50.00, 'Yes', 'Dan Brown', 'Doubleday'),
(2018, 'The Da Vinci Code', 'Thriller', 35.00, 'Yes', 'Dan Brown', 'Doubleday'),
(2333, 'War and Peace', 'Literature', 19.99, 'No', 'Leo Tolstoy', 'The Russian Messenger'),
(2755, 'A Brief History of Time', 'History', 20.00, 'Yes', 'Stephen Hawking', 'Bantam Books');
SELECT * FROM books;

-- Create the Customer table
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);
DESC Customer;

insert into Customer values 
(501,'Anaghaa','Kannur','2015-12-28'),
(502,'Sreya','Palakkad','2023-10-30'),
(503,'Lakshmi','Adoor','2024-01-09'),
(504,'Ashiq','Calicut','2012-12-28'),
(505,'Ijaz','Alappuzha','2022-11-28'),
(506,'Maya','Chennai','2022-02-28'),
(507,'Ravi','Kannur','2019-12-28'),
(508,'Sreeram','Malappuram','2021-12-20');
SELECT * FROM Customer;

-- Create the IssueStatus table
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book INT,
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);
 DESC IssueStatus;
 
insert into IssueStatus values
(5001,501,'Pride and Prejudice','2015-12-28',2567),
(5002,502,'Origin','2023-10-30',2738),
(5003,503,'The Kite Runner','2024-01-09',2996),
(5004,504,'It Ends with Us','2012-12-28',2937);
insert into IssueStatus values
(5005,506,'The Da Vinci Code','2023-06-11',2018);

 select*from  IssueStatus;

-- Create the ReturnStatus table
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 INT,
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
 DESC ReturnStatus;
 
  insert into ReturnStatus values
 (6001,501,'Pride and Prejudice','2016-01-01',2567),
 (6002,502,'The Kite Runner','2024-01-21',2996),
 (6003,503,'It Ends with Us','2024-02-01',2937),
 (6004,504,'Origin','2023-11-11',2738);
 select*from ReturnStatus;
 
 -- 1.Retrieve the book title, category, and rental price of all available books.

SELECT Book_title, Category, Rental_Price 
FROM Books 
WHERE Status = 'Yes';

-- 2. List the employee names and their respective salaries in descending order of salary. 
SELECT Emp_name, Salary 
FROM Employee 
ORDER BY Salary DESC;

-- 3. Retrieve the book titles and the corresponding customers who have issued those books.
select I.Issued_book_name as 'book_name',C.customer_name 
from issuestatus I 
left join customer C on I.issued_cust=C.customer_id;

-- 4. Display the total count of books in each category.
SELECT Category, COUNT(*) AS Total_Books 
FROM Books 
GROUP BY Category;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
select emp_name,position 
from employee
where salary >50000;

-- 6. List the customer names who registered before 2022-01-01 and have not issued any books yet. 
select Customer_name 
from customer
where reg_date < '2022-01-01'
and customer_id not in (select issued_cust from issuestatus);

-- 7. Display the branch numbers and the total count of employees in each branch. 
select B.branch_no,count(*) as 'TOTAL_EMPLOYEE' 
from branch B
left join  employee E on B.branch_no=E.branch_no
group by B.branch_no;

-- 8. Display the names of customers who have issued books in the month of June 2023.
select customer_name  
from IssueStatus I
inner join customer C on I.Issued_cust =C.customer_id 
where i.issue_date between '2023-06-01' and '2023-06-30';

--  9. Retrieve book_title from book table containing history. 
select book_title 
from books
where category='History';

