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
  FOREIGN KEY (EmailID) REFERENCES Email(EmailID) 
);

ALTER TABLE Branch
ADD CONSTRAINT FK_BranchManager
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
  FOREIGN KEY (AddressID)REFERENCES Address(AddressID),
  FOREIGN KEY (EmailID) REFERENCES Email(EmailID)
);

CREATE TABLE Loan_Collateral (
  LoanID INT,
  CollateralType VARCHAR(50) NOT NULL,
  CollateralValue DECIMAL(15, 2) NOT NULL,
  PRIMARY KEY (LoanID, CollateralType),
  FOREIGN KEY (LoanID) REFERENCES Loan(LoanID)
);

CREATE TABLE Account_Transaction (
  AccountID INT,
  TransactionID INT,
  PRIMARY KEY (AccountID, TransactionID),
  FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
  FOREIGN KEY (TransactionID) REFERENCES [Transaction](TransactionID)
);

-- Insert into Address table
INSERT INTO Address (AddressID, AddressLine1, City, State, ZipCode, Country, AddressType)
VALUES (1, '2100 Main Street', 'Seattle', 'WA', '98101', 'USA', 'Home'),
(2, '123 1st Avenue', 'New York', 'NY', '10010', 'USA', 'Work'),
(3, '50 Airport Road', 'London', 'England', 'W2 6ND', 'UK', 'Other');

-- Insert into Email table
INSERT INTO Email (EmailID, EmailAddress, EmailType)
VALUES (1, 'john@example.com', 'Personal'),
(2, 'jane@company.com', 'Work');

-- Insert into Bank table
INSERT INTO Bank (BankID, BankName, PhoneNumber, EmailID, AddressID)
VALUES (1, 'ABC Bank', '123-456-7890', 1, 1),
(2, 'XYZ Bank', '098-765-4321', 2, 2);

-- Insert into Customer table
INSERT INTO Customer (CustomerID, FirstName, LastName, PhoneNumber, AddressID, BranchID, EmailID)
VALUES (1, 'John', 'Smith', '123-123-1234', 1, 1, 1),
(2, 'Jane', 'Doe', '098-098-0987', 2, 2, 2);

-- Insert into Account table
INSERT INTO Account (AccountID, Balance, AccountType, CustomerID, BranchID)
VALUES (1, 5000, 'Checking', 1, 1),
(2, 20000, 'Savings', 2, 2);

-- Query to get customer and account details
SELECT * FROM Customer C
JOIN Account A ON C.CustomerID = A.CustomerID;

-- Query to get transactions for a customer
SELECT * FROM [Transaction] T
JOIN Account_Transaction AT ON T.TransactionID = AT.TransactionID
JOIN Account A ON A.AccountID = AT.AccountID
JOIN Customer C ON C.CustomerID = A.CustomerID
WHERE C.CustomerID = 1;

-- Insert sample transactions
INSERT INTO [Transaction] (TransactionID, TransactionType, Amount, TransactionDate, AccountID)
VALUES (1, 'Deposit', 1000, '2020-01-15', 1),
(2, 'Withdrawal', 500, '2020-01-20', 1),
(3, 'Deposit', 750, '2020-02-10', 2);

-- Insert into Account_Transaction table
INSERT INTO Account_Transaction (AccountID, TransactionID)
VALUES (1, 1),
(1, 2),
(2, 3);

-- Query to get transaction details for an account
SELECT * FROM [Transaction] T
JOIN Account_Transaction AT ON T.TransactionID = AT.TransactionID
WHERE AT.AccountID = 1;