#1 ORDER BY
SELECT 
    *
FROM
    horizon_bank.customer_accounts
WHERE
    Balance >= 5200
ORDER BY Balance DESC;




#The balance distribution of the bank's customers range between $5,291 and $26,306 when filtered for those with monthly balance greater than or equal to $5,291

--------------------------------------------------------------------------------------------------------
#2. DISTINCT
SELECT DISTINCT
    MaritalStatus, COUNT(MaritalStatus) AS Count
FROM
    horizon_bank.customers
GROUP BY MaritalStatus;





## From the output, there are 3 distinct marital segmentations in the bank's customers marital distribution, most of which are married men and women.

---------------------------------------------------------------------------------------------------------------
#3 AND
SELECT 
    CA.*, Age
FROM
    horizon_bank.customer_accounts CA
        LEFT JOIN
    horizon_bank.customers C USING (Customer_ID) 
WHERE
    Balance >= 5200
        AND Age BETWEEN 18 AND 65
ORDER BY Age DESC;

---------------------------------------------------------------------------------------------------------
#4 AVERAGE
WITH Loan as
(
SELECT * FROM horizon_bank.loans
WHERE (Housing_Loan = "yes" OR Personal_Loan =  "yes")
 )
 , Age as
 (SELECT Customer_ID, Age FROM horizon_bank.customers)
, Both_tables AS
( 
SELECT L.Customer_ID as Cust_ID, Housing_Loan, Personal_Loan, Age FROM Loan AS L
LEFT JOIN Age AS A
ON L.Customer_ID = A.Customer_ID
)
SELECT AVG(Age) FROM Both_tables; 
--------------------------------------------------------------------------------------------------------
#5 BETWEEN
SELECT 
    CA.*, Age
FROM
    horizon_bank.customer_accounts CA
        LEFT JOIN
    horizon_bank.customers C USING (Customer_ID)
WHERE
    Age BETWEEN 18 AND 65
ORDER BY Balance DESC;

--------------------------------------------------------------------------------------------------------

#6 CASE
SELECT 
    Customer_ID,
    Balance,
    CASE
        WHEN Balance > 20000 THEN 'High_Priority'
        WHEN Balance BETWEEN 5200 AND 20000 THEN 'Low_Priority'
        ELSE 'Disqualified'
    END Priority_Status
FROM
    horizon_bank.customer_accounts;
 ------------------------------------------------------------------------------------------------------------
 #7 COUNT
 WITH P_status AS
 (
 SELECT Customer_ID, Balance, CASE WHEN Balance > 20000 THEN "High_Priority"
 WHEN Balance BETWEEN 5200 AND 20000 THEN "Low_Priority"
 ELSE "Disqualified"
 END Priority_Status
 FROM horizon_bank.customer_accounts
 )
 SELECT Priority_Status, COUNT(Priority_Status) AS Status_Count FROM P_status
 GROUP BY Priority_Status;
---------------------------------------------------------------------------------------------------------
 #8 GROUP BY
SELECT 
    Housing_Loan, Personal_Loan, COUNT(*) AS Count_of_Loans
FROM
    Horizon_Bank.loans
GROUP BY Housing_Loan , Personal_Loan;

-------------------------------------------------------------------------------------------------------------
 #9 HAVING
 SELECT 
    Customer_ID,
    Personal_Loan,
    Housing_Loan,
    CASE
        WHEN Personal_Loan = 'yes' THEN 1
        WHEN Housing_Loan = 'Yes' THEN 1
        ELSE 0
    END Loan_Dummy
FROM
    Horizon_Bank.loans
GROUP BY Customer_ID
HAVING COUNT(Personal_Loan) > 0
    AND COUNT(Housing_Loan) > 0
ORDER BY Customer_ID;

SELECT 
    Customer_ID,
    CASE
        WHEN
            SUM(CASE
                WHEN Personal_Loan = 'yes' THEN 1
                ELSE 0
            END) > 0
                AND SUM(CASE
                WHEN Housing_Loan = 'yes' THEN 1
                ELSE 0
            END) > 0
        THEN
            1
        ELSE 0
    END AS Loan_Dummy
FROM
    Horizon_Bank.loans
GROUP BY Customer_ID
HAVING SUM(CASE
    WHEN Personal_Loan = 'yes' THEN 1
    ELSE 0
END) > 0
    AND SUM(CASE
    WHEN Housing_Loan = 'yes' THEN 1
    ELSE 0
END) > 0
ORDER BY Customer_ID;
 ---------------------------------------------------------------------------------------------------------------
 #10 IF
 SELECT 
    *,
    IF(Subscribe_Result = 'YES',
        'Can_Call',
        'Do_Not_Call') AS Call_Option
FROM
    horizon_bank.subscriptions;
 
 ----------------------------------------------------------------------------------------------------------------
 #11 IN
 WITH P_status AS
 (
 SELECT Customer_ID, Balance, CASE WHEN Balance > 20000 THEN "High_Priority"
 WHEN Balance BETWEEN 5200 AND 20000 THEN "Low_Priority"
 ELSE "Disqualified"
 END Priority_Status
 FROM horizon_bank.customer_accounts
 )
 SELECT Customer_ID, First_Name, Last_Name, Priority_Status FROM P_status
 LEFT JOIN horizon_bank.Customers USING(Customer_ID);
-----------------------------------------------------------------------------------------------------
 #12 INNER JOIN
 SELECT 
    *
FROM
    horizon_bank.subscriptions
        INNER JOIN
    horizon_bank.Customers USING (Customer_ID)
WHERE
    Subscribe_Result = 'YES';
 
 -------------------------------------------------------------------------------------------------------------
  #13 LEFT JOIN
  SELECT 
    Housing_Loan, Personal_Loan, C.*
FROM
    horizon_bank.loans
        LEFT JOIN
    horizon_bank.Customers AS C USING (Customer_ID)
WHERE
    (Housing_Loan = 'YES'
        OR Personal_Loan = 'YES');

-----------------------------------------------------------------------------------------
 #14 LIKE
 SELECT 
    *
FROM
    horizon_bank.contacts
WHERE
    Previous_Outcome LIKE '%Success%';
 
 -----------------------------------------------------------------------------------------------------
 #15 MATH FUNCTION (SUM)
 SELECT 
    SUM(Duration_Second) / 60 Duration_Minutes
FROM
    horizon_bank.contacts;
 
 ----------------------------------------------------------------------------------------------
 #16 MAX
 SELECT 
    MAX(Age) AS Oldest
FROM
    horizon_bank.customers;
 
 ------------------------------------------------------------------------------------------------
 #17 MIN
 SELECT 
    MIN(Age) AS Youngest
FROM
    horizon_bank.customers;
 
 ------------------------------------------------------------------------------------------------
  #18
  SELECT 
    *
FROM
    horizon_bank.customers
WHERE
    Job IS NULL;
  
  ------------------------------------------------------------------------------------------------
  #19 OR
  SELECT 
    Housing_Loan, Personal_Loan, C.*
FROM
    horizon_bank.loans
        LEFT JOIN
    horizon_bank.Customers AS C USING (Customer_ID)
WHERE
    (Housing_Loan = 'NO'
        OR Personal_Loan = 'No');
---------------------------------------------------------------------------------------------------------
#20 RIGHT JOIN
SELECT * FROM horizon_bank.customers
RIGHT JOIN horizon_bank.subscriptions USING(Customer_ID)
WHERE Subscribe_Result = "NO";

---------------------------------------------------------------------------------------------------------
#21 String Function(UPPER)
SELECT 
    CONCAT(UPPER(First_Name), ' ', UPPER(Last_Name)) AS Full_Name
FROM
    horizon_bank.customers;
    
-------------------------------------------------------------------------------------------------
#22 UNION
WITH P_loans AS
(SELECT * FROM horizon_bank.loans
WHERE Personal_Loan = "YES")
 , H_loans AS
(SELECT * FROM horizon_bank.loans
WHERE Housing_Loan = "YES")
SELECT * FROM P_loans
UNION
SELECT * FROM H_loans
ORDER BY Customer_ID;

------------------------------------------------------------------------------------------------
#23 USING
SELECT CA.*, Age FROM horizon_bank.customer_accounts CA
LEFT JOIN horizon_bank.customers C  USING (Customer_ID)
WHERE Age BETWEEN 18 AND 65
order by Balance desc;

-----------------------------------------------------------------------------------------------------
#24 WHERE
SELECT * FROM horizon_bank.customer_accounts
WHERE Balance >= 5200;

---------------------------------------------------------------------------------------------------
#25 Subquery in the FROM clause
SELECT SUM(Duration_Second)/ 60 AS Duration_Minute FROM (SELECT * FROM horizon_bank.contacts) AS Cust_contacts;

---------------------------------------------------------------------------------------------------------------
#26 Subquery in the WHERE clause
SELECT * FROM horizon_bank.loans AS L
WHERE L.Customer_ID IN (SELECT Customer_ID FROM horizon_bank.customers WHERE (Education = "Secondary" OR Education = "Tertiary"));
--------------------------------------------------------------------------------------------------------------------------------------------
#27 WITH (CTE)
WITH Customers AS
(SELECT * FROM horizon_bank.customers)
,Customer_Accounts AS
(SELECT * FROM horizon_bank.customer_accounts)
,Contacts AS
(SELECT * FROM horizon_bank.contacts)
,Loans AS 
(SELECT * FROM horizon_bank.loans)
,Subscriptions AS
(SELECT * FROM horizon_bank.subscriptions)
SELECT * FROM Customers
LEFT JOIN Customer_Accounts USING(Customer_ID)
LEFT JOIN Contacts USING(Customer_ID)
LEFT JOIN Loans USING(Customer_ID)
LEFT JOIN Subscriptions USING(Customer_ID);

-----------------------------------------------------------------------------------------------------------
#28 Window Function 
WITH P_status AS
 (
 SELECT Customer_ID, Balance, CASE WHEN Balance > 20000 THEN "High_Priority"
 WHEN Balance BETWEEN 5200 AND 20000 THEN "Low_Priority"
 ELSE "Disqualified"
 END Priority_Status
 FROM horizon_bank.customer_accounts
 )
 SELECT ROW_NUMBER() OVER (PARTITION BY Priority_Status ORDER BY Priority_Status, Balance ) AS RowNumber, Customer_ID, First_Name, Last_Name, Balance, Priority_Status FROM P_status
LEFT JOIN horizon_bank.Customers USING(Customer_ID);