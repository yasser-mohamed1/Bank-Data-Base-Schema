--create database Bank

CREATE TABLE Address (
  AddressID INT PRIMARY KEY,
  AddressLine1 VARCHAR(100) NOT NULL,
  AddressLine2 VARCHAR(100),
  City VARCHAR(50) NOT NULL,
  State VARCHAR(50) NOT NULL,
  ZipCode VARCHAR(20) NOT NULL,
  Country VARCHAR(50) NOT NULL,
  AddressType VARCHAR(20) NOT NULL
);

CREATE TABLE Bank (
  BankID INT PRIMARY KEY,
  BankName VARCHAR(50) NOT NULL,
  PhoneNumber VARCHAR(15),
  Email VARCHAR(100),
  AddressID INT,
  FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);

CREATE TABLE Customer (
  CustomerID INT PRIMARY KEY,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  PhoneNumber VARCHAR(15),
  AddressID INT,
  BranchID INT,
  FOREIGN KEY (AddressID) REFERENCES Address(AddressID),
  FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);

CREATE TABLE Email (
  EmailID INT PRIMARY KEY,
  EmailAddress VARCHAR(100) NOT NULL,
  EmailType VARCHAR(20) NOT NULL
);

CREATE TABLE Customer_Email (
  CustomerID INT,
  EmailID INT,
  PRIMARY KEY (CustomerID, EmailID),
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
  FOREIGN KEY (EmailID) REFERENCES Email(EmailID)
);

CREATE TABLE Account (
  AccountID INT PRIMARY KEY,
  Balance DECIMAL(15, 2) NOT NULL,
  AccountType VARCHAR(20) NOT NULL,
  CustomerID INT,
  BranchID INT,
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
  FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);

CREATE TABLE [Transaction] (
  TransactionID INT PRIMARY KEY,
  TransactionType VARCHAR(20) NOT NULL,
  Amount DECIMAL(15, 2) NOT NULL,
  TransactionDate DATE NOT NULL,
  AccountID INT,
  FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

CREATE TABLE Loan (
  LoanID INT PRIMARY KEY,
  LoanType VARCHAR(50) NOT NULL,
  LoanAmount DECIMAL(15, 2) NOT NULL,
  InterestRate DECIMAL(5, 2) NOT NULL,
  LoanTerm INT NOT NULL,
  StartDate DATE NOT NULL,
  EndDate DATE NOT NULL,
  AccountID INT,
  FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
);

CREATE TABLE Employee (
  EmployeeID INT PRIMARY KEY,
  FirstName VARCHAR(50) NOT NULL,
  LastName VARCHAR(50) NOT NULL,
  PhoneNumber VARCHAR(15),
  Email VARCHAR(100),
  HireDate DATE NOT NULL,
  JobTitle VARCHAR(50) NOT NULL,
  Salary DECIMAL(15, 2) NOT NULL,
  ManagerID INT,
  BranchID INT,
  BankID INT,
  AddressID INT,
  FOREIGN KEY (ManagerID) REFERENCES Employee(EmployeeID),
  FOREIGN KEY (BranchID) REFERENCES Branch(BranchID),
  FOREIGN KEY (BankID) REFERENCES Bank(BankID),
  FOREIGN KEY (AddressID)REFERENCES Address(AddressID)
);

CREATE TABLE Branch (
  BranchID INT PRIMARY KEY,
  BranchName VARCHAR(50) NOT NULL,
  PhoneNumber VARCHAR(15),
  Email VARCHAR(100),
  ManagerID INT,
  BankID INT,
  AddressID INT,
  FOREIGN KEY (ManagerID) REFERENCES Employee(EmployeeID),
  FOREIGN KEY (BankID) REFERENCES Bank(BankID),
  FOREIGN KEY (AddressID) REFERENCES Address(AddressID)
);

CREATE TABLE Employee_Branch (
  EmployeeID INT,
  BranchID INT,
  PRIMARY KEY (EmployeeID, BranchID),
  FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
  FOREIGN KEY (BranchID) REFERENCES Branch(BranchID)
);

CREATE TABLE Customer_Loan (
  CustomerID INT,
  LoanID INT,
  PRIMARY KEY (CustomerID, LoanID),
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
  FOREIGN KEY (LoanID) REFERENCES Loan(LoanID)
);

CREATE TABLE Account_Owner (
  AccountID INT,
  CustomerID INT,
  PRIMARY KEY (AccountID, CustomerID),
  FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Transaction_Category (
  CategoryID INT PRIMARY KEY,
  CategoryName VARCHAR(50) NOT NULL
);

CREATE TABLE Transaction_Category_Mapping (
  TransactionID INT,
  CategoryID INT,
  PRIMARY KEY (TransactionID, CategoryID),
  FOREIGN KEY (TransactionID) REFERENCES [Transaction](TransactionID),
  FOREIGN KEY (CategoryID) REFERENCES Transaction_Category(CategoryID)
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

CREATE TABLE Account_Permission (
  AccountID INT,
  EmployeeID INT,
  PermissionLevel VARCHAR(20) NOT NULL,
  PRIMARY KEY (AccountID, EmployeeID),
  FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
  FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);