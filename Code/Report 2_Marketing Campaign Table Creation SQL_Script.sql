SELECT * FROM Horizon_Bank.`bank campaign`;
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    MaritalStatus VARCHAR(50),
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Nationality VARCHAR(50),
    Age INT,
    Job VARCHAR(50),
    Education VARCHAR(50)
);
    
    CREATE TABLE Customer_Account(
    Customer_ID INT,
    Balance DECIMAL(10, 2),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

CREATE TABLE Loan (
    Customer_ID INT,
    Housing_Loan VARCHAR(10),
    Personal_Loan VARCHAR(10),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

CREATE TABLE Contact (
    Customer_ID INT,
    Contact VARCHAR(50),
    Day_of_Month INT,
    Last_Contact_Month VARCHAR(50),
    Duration_Second INT,
    Campaign_Times INT,
    Past_Days INT,
    Previous_Contact VARCHAR(50),
    Previous_Outcome VARCHAR(50),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

CREATE TABLE Subscription (
    Customer_ID INT,
    Subscribe_Result VARCHAR(50),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

INSERT INTO Customer (customer_ID, MaritalStatus, First_Name, Last_Name, Nationality, Age, Job, Education)
SELECT Customer_ID, MaritalStatus, First_Name, Last_Name, Nationality, Age, Job, Education FROM `bank campaign`;

INSERT INTO Customer_Account (Customer_ID, Balance)
SELECT Customer_ID, Balance FROM `bank campaign`;

INSERT INTO Loan (Customer_ID, Housing_Loan, Personal_Loan)
SELECT Customer_ID, Housing_Loan, Personal_Loan FROM `bank campaign`;

INSERT INTO Contact(Customer_ID, Contact, Day_of_Month,Last_Contact_Month, Duration_Second, Campaign_Times, Past_Days, Previous_Contact, Previous_Outcome)
SELECT Customer_ID, Contact, Day_of_Month,Last_Contact_Month, Duration_Second, Campaign_Times, Past_Days, Previous_Contact, Previous_Outcome FROM `bank campaign`;

INSERT INTO Subscription (Customer_ID, Subscribe_Result)
SELECT Customer_ID, Subscribe_Result FROM `bank campaign`;