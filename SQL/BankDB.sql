create database Bank

CREATE TABLE [Address] (
  AddressID INT PRIMARY KEY,
  City VARCHAR(50) NOT NULL,
  State VARCHAR(50) NOT NULL,
  ZipCode VARCHAR(20) NOT NULL,
  Country VARCHAR(50) NOT NULL,
  AddressType VARCHAR(20) NOT NULL
);

CREATE TABLE Branch (
  BranchID INT PRIMARY KEY,
  BranchName VARCHAR(50) NOT NULL,
  PhoneNumber VARCHAR(15),
  EmailID INT,
  ManagerID INT,
  BankID INT,
  AddressID INT,
  FOREIGN KEY (BankID) REFERENCES Bank(BankID),
  FOREIGN KEY (AddressID) REFERENCES Address(AddressID),
  FOREIGN KEY (EmailID) REFERENCES Email(EmailID),
);

Alter table Branch
add constraint FK_Branch_Manager
FOREIGN KEY (ManagerID) REFERENCES Employee(EmployeeID);

CREATE TABLE Email (
  EmailID INT PRIMARY KEY,
  EmailAddress VARCHAR(100) NOT NULL,
  EmailType VARCHAR(20) NOT NULL -->> "Personal", "Work", "Secondary", "Backup" <<--
);

CREATE TABLE Bank (
  BankID INT PRIMARY KEY,
  BankName VARCHAR(50) NOT NULL,
  PhoneNumber VARCHAR(15),
  EmailID INT,
  AddressID INT,
  FOREIGN KEY (AddressID) REFERENCES Address(AddressID),
  FOREIGN KEY (EmailID) REFERENCES Email(EmailID)
);

CREATE TABLE Customer (
  CustomerID INT PRIMARY KEY,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  PhoneNumber VARCHAR(15),
  AddressID INT,
  BranchID INT,
  EmailID INT,
  FOREIGN KEY (AddressID) REFERENCES Address(AddressID),
  FOREIGN KEY (BranchID) REFERENCES Branch(BranchID),
  FOREIGN KEY (EmailID) REFERENCES Email(EmailID)
);

CREATE TABLE Account (
  AccountID INT PRIMARY KEY,
  Balance DECIMAL(15, 2) NOT NULL,
  AccountType VARCHAR(20) NOT NULL, -->> "Checking", "Savings", "Money Market", "Certificate of Deposit (CD)" <<--
  CustomerID INT,
  BranchID INT,
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
  FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);

CREATE TABLE [Transaction] (
  TransactionID INT PRIMARY KEY,
  TransactionType VARCHAR(20) NOT NULL, -->> "Deposit", "Withdrawal", "Transfer", "Payment" <<--
  Amount DECIMAL(15, 2) NOT NULL,
  TransactionDate DATE NOT NULL,
  AccountID INT,
  FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

CREATE TABLE [Date](
  DateID INT PRIMARY KEY IDENTITY(1,1),
  StartDate DATE NOT NULL,
  EndDate DATE NOT NULL,
)

CREATE TABLE Loan (
  LoanID INT PRIMARY KEY,
  LoanType VARCHAR(50) NOT NULL, -->> "Mortgage", "Auto", "Personal", "Student" <<--
  LoanAmount DECIMAL(15, 2) NOT NULL,
  InterestRate DECIMAL(5, 2) NOT NULL,
  LoanTerm INT NOT NULL,
  DateID INT,
  AccountID INT,
  FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
  FOREIGN KEY (DateID) REFERENCES [Date](DateID)
);

CREATE TABLE Employee (
  EmployeeID INT PRIMARY KEY,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  PhoneNumber VARCHAR(15),
  HireDate DATE NOT NULL,
  JobTitle VARCHAR(50) NOT NULL,
  Salary DECIMAL(15, 2) NOT NULL,
  ManagerID INT,
  BranchID INT,
  BankID INT,
  AddressID INT,
  EmailID INT,
  FOREIGN KEY (ManagerID) REFERENCES Employee(EmployeeID),
  FOREIGN KEY (BranchID) REFERENCES Branch(BranchID),
  FOREIGN KEY (BankID) REFERENCES Bank(BankID),
  FOREIGN KEY (AddressID)REFERENCES [Address](AddressID),
  FOREIGN KEY (EmailID) REFERENCES Email(EmailID)
);

--CREATE TABLE Loan_Collateral (
--  LoanID INT,
--  CollateralType VARCHAR(50) NOT NULL,
--  CollateralValue DECIMAL(15, 2) NOT NULL,
--  PRIMARY KEY (LoanID, CollateralType),
--  FOREIGN KEY (LoanID) REFERENCES Loan(LoanID)
--);

--------->> Populate the data base with Data <<--------- 

-- Insert data into Address table
INSERT INTO Address (AddressID, City, State, ZipCode, Country, AddressType)
VALUES
(1, 'New York', 'NY', '10001', 'USA', 'Bank'),
(2, 'Los Angeles', 'CA', '90001', 'USA', 'Bank'),
(3, 'Chicago', 'IL', '60601', 'USA', 'Bank'),
(4, 'Houston', 'TX', '77001', 'USA', 'Bank'),
(5, 'Philadelphia', 'PA', '19019', 'USA', 'Bank'),
(6, 'San Francisco', 'CA', '94101', 'USA', 'Bank'),
(7, 'Miami', 'FL', '33101', 'USA', 'Bank'),
(8, 'Seattle', 'WA', '98101', 'USA', 'Bank');

-- Insert data into Email table
INSERT INTO Email (EmailID, EmailAddress, EmailType)
VALUES
(1, 'bank@example.com', 'Work'),
(2, 'branch1@example.com', 'Work'),
(3, 'branch2@example.com', 'Work'),
(4, 'branch3@example.com', 'Work'),
(5, 'branch4@example.com', 'Work'),
(6, 'branch5@example.com', 'Work'),
(7, 'customer1@example.com', 'Work'),
(8, 'customer2@example.com', 'Work'),
(9, 'customer3@example.com', 'Work'),
(10, 'customer4@example.com', 'Work'),
(11, 'customer5@example.com', 'Work'),
(12, 'employee1@example.com', 'Work'),
(13, 'employee2@example.com', 'Work'),
(14, 'employee3@example.com', 'Work'),
(15, 'employee4@example.com', 'Work'),
(16, 'employee5@example.com', 'Work');

-- Insert data into Bank table
INSERT INTO Bank (BankID, BankName, PhoneNumber, EmailID, AddressID)
VALUES
(1, 'First National Bank', '555-123-1234', 1, 1);

-- Insert data into Branch table
INSERT INTO Branch (BranchID, BranchName, PhoneNumber, EmailID, BankID, AddressID)
VALUES
(1, 'First National Bank - New York', '555-123-2345', 2, 1, 1),
(2, 'First National Bank - Los Angeles', '555-123-3456', 3, 1, 2),
(3, 'First National Bank - Chicago', '555-123-4567', 4, 1, 3),
(4, 'First National Bank - Houston', '555-123-5678', 5, 1, 4),
(5, 'First National Bank - Philadelphia', '555-123-6789', 6, 1, 5);

-- Insert data into Customer table
INSERT INTO Customer (CustomerID, FirstName, LastName, PhoneNumber, AddressID, BranchID, EmailID)
VALUES
(1, 'John', 'Doe', '555-123-7890', 6, 1, 7),
(2, 'Jane', 'Smith', '555-123-8901', 7, 2, 8),
(3, 'Jim', 'Brown', '555-123-9012', 8, 3, 9),
(4, 'Jill', 'Johnson', '555-123-0123', 3, 4, 10),
(5, 'Jack', 'Jones', '555-123-6789', 1, 5, 11);

-- Insert data into Account table
INSERT INTO Account (AccountID, Balance, AccountType, CustomerID, BranchID)
VALUES
(1, 5000.00, 'Checking', 1, 1),
(2, 10000.00, 'Savings', 2, 2),
(3, 15000.00, 'Money Market', 3, 3),
(4, 20000.00, 'Savings', 4, 4),
(5, 25000.00, 'Checking', 5, 5);

-- Insert data into Transaction table
INSERT INTO [Transaction] (TransactionID, TransactionType, Amount, TransactionDate, AccountID)
VALUES
(1, 'Deposit', 500.00, '2023-01-01', 1),
(2, 'Withdrawal', 1000.00, '2023-01-02', 2),
(3, 'Transfer', 1500.00, '2023-01-03', 3),
(4, 'Payment', 2000.00, '2023-01-04', 4),
(5, 'Deposit', 2500.00, '2023-01-05', 5);

-- Insert data into Date table
INSERT INTO [Date] (StartDate, EndDate)
VALUES
('2023-01-01', '2023-12-31');

-- Insert data into Loan table
INSERT INTO Loan (LoanID, LoanType, LoanAmount, InterestRate, LoanTerm, DateID, AccountID)
VALUES
(1, 'Mortgage', 200000.00, 3.50, 360, 1, 1),
(2, 'Auto', 30000.00, 4.00, 60, 1, 2),
(3, 'Personal', 10000.00, 6.00, 36, 1, 3),
(4, 'Student', 50000.00, 5.00, 120, 1, 4);

-- Insert data into Employee table
INSERT INTO Employee (EmployeeID, FirstName, LastName, PhoneNumber, HireDate, JobTitle, Salary, ManagerID, BranchID, BankID, AddressID, EmailID)
VALUES
(1, 'Emma', 'Johnson', '555-123-9876', '2020-01-01', 'Branch Manager', 75000.00, NULL, 1, 1, 8, 12),
(2, 'Olivia', 'Davis', '555-123-8765', '2020-02-01', 'Branch Manager', 75000.00, NULL, 2, 1, 4, 13),
(3, 'Ava', 'Williams', '555-123-7654', '2020-03-01', 'Branch Manager', 75000.00, NULL, 3, 1, 3, 14),
(4, 'Isabella', 'Jones', '555-123-6543', '2020-04-01', 'Branch Manager', 75000.00, NULL, 4, 1, 1, 15),
(5, 'Sophia', 'Brown', '555-123-5432', '2020-05-01', 'Branch Manager', 75000.00, NULL, 5, 1, 5, 16);

-- Update data into Branch table

UPDATE Branch
SET ManagerID = 3
WHERE BranchID = 1;

UPDATE Branch
SET ManagerID = 5
WHERE BranchID = 2;

UPDATE Branch
SET ManagerID = 2
WHERE BranchID = 3;

UPDATE Branch
SET ManagerID = 1
WHERE BranchID = 4;

UPDATE Branch
SET ManagerID = 4
WHERE BranchID = 5;

--------->> Queries <<--------- 

-- Select all customers with their account balances and branch names.

SELECT c.FirstName + ' ' + c.LastName as [CustomerName], a.Balance, b.BranchName
FROM Customer c
JOIN Account a ON c.CustomerID = a.CustomerID
JOIN Branch b ON c.BranchID = b.BranchID;

-- Find the total loan amount for each loan type.

SELECT LoanType, SUM(LoanAmount) AS TotalLoanAmount
FROM Loan
GROUP BY LoanType;

-- List all employees who are branch managers along with their branch and bank info.

SELECT e.FirstName + ' ' + e.LastName as [ManagerName], b.BranchName, bk.BankName
FROM Employee e
JOIN Branch b ON e.BranchID = b.BranchID
JOIN Bank bk ON b.BankID = bk.BankID
WHERE e.JobTitle = 'Branch Manager';

-- Find the total number of accounts for each account type.

SELECT AccountType, COUNT(AccountID) AS TotalAccounts
FROM Account
GROUP BY AccountType;

-- Calculate the total amount of transactions for each transaction type.

SELECT TransactionType, SUM(Amount) as TotalAmount
FROM [Transaction]
GROUP BY TransactionType;

-- Get the list of customers who have a loan, along with their loan details.

SELECT c.FirstName, c.LastName, l.LoanType, l.LoanAmount, l.InterestRate, l.LoanTerm
FROM Customer c
JOIN Account a ON c.CustomerID = a.CustomerID
JOIN Loan l ON a.AccountID = l.AccountID;

------------> not completed the queries <------------