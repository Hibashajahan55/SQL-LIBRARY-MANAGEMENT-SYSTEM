# SQL LIBRARY MANAGEMENT SYSTEM

## INTRODUCTION
The Library Management System is a database-driven application designed to manage and organize library operations efficiently. It tracks information about books, employees, customers, and branch details, as well as the issue and return status of books. This system provides a seamless way to manage library data and offers insightful reports to aid in decision-making.
## FEATURES
* Book Management: Tracks book details, including title, category, availability status, and rental price.
* Employee Management: Maintains employee information such as name, position, salary, and branch assignment.
* Customer Records: Stores customer details, including registration date and transaction history.
* Book Issuing and Returning: Manages the status of issued and returned books with date tracking.
* Branch Management: Tracks branch details and the employees managing them.
* Query-Based Insights: Provides detailed insights into library operations using SQL queries.
## DATABASE STRUCTURE
### TABLES AND ATTRIBUTES
#### 1. Branch Table
* Branch_no (PRIMARY KEY)
* Manager_Id
* Branch_address
* Contact_no
#### 2. Employee Table
* Emp_Id (PRIMARY KEY)
* Emp_name
* Position
* Salary
* Branch_no (FOREIGN KEY referencing Branch.Branch_no)
#### 3.  Books Table
* ISBN (PRIMARY KEY)
* Book_title
* Category
* Rental_Price
* Status (yes if available, no if not available)
* Author
* Publisher
#### 4.  Customer Table
* Customer_Id (PRIMARY KEY)
* Customer_name
* Customer_address
* Reg_date
#### 5. IssueStatus Table
* Issue_Id (PRIMARY KEY)
* Issued_cust (FOREIGN KEY referencing Customer.Customer_Id)
* Issued_book_name
* Issue_date
* Isbn_book (FOREIGN KEY referencing Books.ISBN)
#### 6. ReturnStatus Table
* Return_Id (PRIMARY KEY)
* Return_cust
* Return_book_name
* Return_date
* Isbn_book2 (FOREIGN KEY referencing Books.ISBN)

## SQL QUERIES
#### 1.Retrieve the book title, category, and rental price of all available books.
```sql
SELECT Book_title, Category, Rental_Price 
FROM Books 
WHERE Status = 'Yes';
```
#### 2. List the employee names and their respective salaries in descending order of salary.
```sql
SELECT Emp_name, Salary 
FROM Employee 
ORDER BY Salary DESC;
```
#### 3. Retrieve the book titles and the corresponding customers who have issued those books.
```sql
select I.Issued_book_name as 'book_name',C.customer_name 
from issuestatus I 
left join customer C on I.issued_cust=C.customer_id;
```
#### 4. Display the total count of books in each category.
```sql
SELECT Category, COUNT(*) AS Total_Books 
FROM Books 
GROUP BY Category;
```
#### 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
```sql
select emp_name,position 
from employee
where salary >50000;
```
#### 6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
```sql
select Customer_name 
from customer
where reg_date < '2022-01-01'
and customer_id not in (select issued_cust from issuestatus);
```
#### 7. Display the branch numbers and the total count of employees in each branch.
```sql
select B.branch_no,count(*) as 'TOTAL_EMPLOYEE' 
from branch B
left join  employee E on B.branch_no=E.branch_no
group by B.branch_no;
```
#### 8. Display the names of customers who have issued books in the month of June 2023.
```sql
select customer_name  
from IssueStatus I
inner join customer C on I.Issued_cust =C.customer_id 
where i.issue_date between '2023-06-01' and '2023-06-30';
```
#### 9. Retrieve book_title from book table containing history.
```sql
select book_title 
from books
where category='History';
```
#### 10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
```sql
select B.branch_no,count(*) as 'COUNT_OF_EMPLOYEES'
from branch B
left join employee E
on B.branch_no = E.branch_no
group by B.branch_no
having count(*) > 5;
```
#### 11. Retrieve the names of employees who manage branches and their respective branch addresses.
```sql
select E.emp_name, E.branch_no,B.branch_address 
from employee E
inner join branch B on E.Branch_no =B.Branch_no 
where  E.position ='manager';
```
#### 12. Display the names of customers who have issued books with a rental price higher than Rs. 25.
```sql
SELECT C.Customer_Name, B.Rental_Price 
FROM Customer C
INNER JOIN IssueStatus I ON C.Customer_Id = I.Issued_Cust
INNER JOIN Books B ON I.Isbn_Book = B.ISBN
WHERE B.Rental_Price > 25;
```
## CONCLUSION
The Library Management System is a comprehensive solution for managing library operations efficiently. It supports critical functionalities such as book tracking, employee management, and customer transactions. With the included SQL queries, administrators can gain valuable insights to improve library services and maintain operational efficiency. 





