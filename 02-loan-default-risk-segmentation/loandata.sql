------------SELECT TOP 10 * FROM Loan_Data;
----SELECT COUNT(*) FROM Loan_Data;

----SELECT 
----  SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Null_Gender,
----  SUM(CASE WHEN Married IS NULL THEN 1 ELSE 0 END) AS Null_Married,
----  SUM(CASE WHEN Dependents IS NULL THEN 1 ELSE 0 END) AS Null_Dependents,
----  SUM(CASE WHEN Self_Employed IS NULL THEN 1 ELSE 0 END) AS Null_SelfEmployed,
----  SUM(CASE WHEN LoanAmount IS NULL THEN 1 ELSE 0 END) AS Null_LoanAmount,
----  SUM(CASE WHEN Loan_Amount_Term IS NULL THEN 1 ELSE 0 END) AS Null_Term,
----  SUM(CASE WHEN Credit_History IS NULL THEN 1 ELSE 0 END) AS Null_CreditHistory
----FROM Loan_Data	;

--SELECT DISTINCT Gender FROM Loan_Data;
--SELECT DISTINCT Married FROM Loan_Data;
--SELECT DISTINCT Education FROM Loan_Data;


--UPDATE Loan_Data
--SET Gender = 'Male'
--WHERE Gender IS NULL;
--UPDATE Loan_Data
--SET Married = 1
--WHERE Married IS NULL;
--UPDATE Loan_Data
--SET Dependents = '0'
--WHERE Dependents IS NULL;
--UPDATE Loan_Data
--SET Self_Employed = 0
--WHERE Self_Employed IS NULL;
--UPDATE Loan_Data
--SET LoanAmount = (
--    SELECT AVG(LoanAmount * 1.0)
--    FROM Loan_Data
--    WHERE LoanAmount IS NOT NULL
--)
--WHERE LoanAmount IS NULL;
--UPDATE Loan_Data
--SET Loan_Amount_Term = 360
--WHERE Loan_Amount_Term IS NULL;

--ALTER TABLE Loan_Data
--ADD Risk_Flag VARCHAR(10);

--SELECT DISTINCT Credit_History FROM Loan_Data;

--UPDATE Loan_Data
--SET Risk_Flag = CASE
--    WHEN Credit_History = 1 THEN 'Low'
--    WHEN Credit_History = 0 THEN 'High'
--    ELSE 'Unknown'
--END;


--WITH DuplicateRows AS (
--    SELECT *,
--           ROW_NUMBER() OVER (PARTITION BY Loan_ID ORDER BY Loan_ID) AS rn
--    FROM loan_data
--)
--DELETE FROM DuplicateRows
--WHERE rn > 1;

--SELECT Credit_History,
--       COUNT(*) AS TotalApplicants
--FROM Loan_Data
--GROUP BY Credit_History;

--SELECT Credit_History, Loan_Status, COUNT(*) AS Total
--FROM Loan_Data
--GROUP BY Credit_History, Loan_Status;



--SELECT Loan_ID, Credit_History, Risk_Flag FROM Loan_Data;

--SELECT Risk_Flag, COUNT(*) AS TotalApplicants
--FROM Loan_Data
--GROUP BY Risk_Flag;

--SELECT 
--  Risk_Flag,
--  AVG(ApplicantIncome) AS Avg_Income,
--  --AVG(LoanAmount) AS Avg_LoanAmount,
--  COUNT(*) AS Total_Applicants
--FROM Loan_Data
--GROUP BY Risk_Flag;

--SELECT 
--    Loan_Status,
--    COUNT(*) AS Total
--FROM Loan_Data
--GROUP BY Loan_Status;

--SELECT 
--    Risk_Flag,
--    COUNT(*) AS Total_Applications
--FROM Loan_Data
--GROUP BY Risk_Flag;

--SELECT 
--    Risk_Flag,
--    AVG(LoanAmount) AS Avg_LoanAmount
--FROM Loan_Data
--GROUP BY Risk_Flag;

--SELECT 
--    Risk_Flag,
--    AVG(ApplicantIncome) AS Avg_ApplicantIncome
--FROM Loan_Data
--GROUP BY Risk_Flag;

--SELECT 
--    Property_Area,
--    AVG(LoanAmount) AS Avg_LoanAmount
--FROM Loan_Data
--GROUP BY Property_Area;

--SELECT COUNT(*) AS Total_Applications FROM Loan_Data;

--SELECT Education, COUNT(*) AS Total_Applicants
--FROM Loan_Data
--GROUP BY Education;

--SELECT AVG(LoanAmount) AS Avg_LoanAmount FROM Loan_Data;
