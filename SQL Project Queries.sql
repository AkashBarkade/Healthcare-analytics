Use healthcare;

-- 1. Count total no of patients admitted to hospital
select count(Name) from safety_data ;


--- 2 Calculate the average age of patients by gender
SELECT Gender, AVG(Age) AS AvgAge
FROM safety_data 
GROUP BY Gender;


ALTER TABLE patient_safety1
RENAME COLUMN `Medical history` TO Medical_history;


ALTER TABLE patient_safety1
RENAME COLUMN `Adverse event` TO Adverse_event;


-- 3 Which suspect drug caused max adverse events
SELECT Suspect_drug, COUNT(Adverse_event) AS Suspect_drug_count
FROM safety_data 
GROUP BY Suspect_drug;


--- 4 Calculate age group of patients as Adult, Elderly, Child.


SELECT
Age,
CASE
        WHEN age> 65 then 'elderly'
        WHEN age between 18 and 64 THEN 'adult'
        ELSE 'child'
    END AS 'age group'
FROM
    safety_data ;
    
    CREATE VIEW patient_age_groups AS
SELECT
    Age,
    CASE
        WHEN Age > 65 THEN 'elderly'
        WHEN Age BETWEEN 18 AND 64 THEN 'adult'
        ELSE 'child'
    END AS age_group
FROM
    safety_data ;
    
    
    select* from patient_age_groups;
    
    select age_group ,count(Age) from patient_age_groups group by age_group;
    
    
    --- 5. Count no_of_patients who are having particular medical history
    select Medical_history, count(Name) as no_of_patients from safety_data  group by Medical_history;
    
    
    --- 6. Calculate Male and Female patients.
    
    select Gender,count(Name) 
          from safety_data  
              group by Gender;
    
    ALTER TABLE patient_safety1
RENAME COLUMN `Billing Amount` TO Billing_Amount;
    
    
    --- 7 Show those patient name whose billing amount is greater than average billing amount.


select avg(Billing_Amount) from safety_data ;


SELECT Name, Billing_Amount 
      FROM patient_safety1  
          WHERE billing_amount > (SELECT AVG(Billing_Amount)FROM safety_data );


--- -8 Severity wise patients
Select Severity, count(Adverse_event) as No_of_patients from safety_data  group by severity;


SELECT * from safety_data;

----- -9. Identify patients who had a specific lab test with abnormal results

SELECT Lab_test, Test_Results 
      FROM Safety_data 
          WHERE Test_Results = 'Abnormal' 
               GROUP BY Lab_test;

------ - 10. Elder Patient and Youngest Patient age.

SELECT  Max(Age), MIn( Age), name 
      FROM Safety_data 
          GROUP BY Name ;

----- -11. FInd patients with O+ Bood groups.

SELECT Name, Blood_Type 
      FROM Safety_data 
          WHERE Blood_Type = 'O+'

------ -12. Return Patient names, event and outcome.

SELECT * FROM safety_data;

SELECT * from ae_outcomes;

SELECT Name, Adverse_Event, ae_outcomes.Outcome 
     FROM Safety_data 
         RIGHT JOIN ae_outcomes 
                   ON Safety_data.Patient_Id = ae_outcomes. Patient_Id;

---- --13. Return Name and Ethnicity.

SELECT Name, ae_outcomes.Ethnicity 
       FROM Safety_data 
           LEFT JOIN ae_outcomes 
                   ON Safety_data.Patient_Id = ae_outcomes. Patient_Id;

---- -14. select the count of each adverse event

SELECT  Adverse_event, Count(Name) 
      FROM Safety_data 
           GROUP BY Adverse_event 
                  ORDER BY Count(Name) 
                           DESC LIMIT 3;


---- --15. Return Name, AE, and outcome containing Not recovered. 

SELECT Name, Adverse_event, ae_outcomes.Outcome 
          FROM Safety_data 
              LEFT JOIN ae_outcomes ON  Safety_data.Patient_ID = ae_outcomes.Patient_ID 
                       WHERE Outcome= 'Not Recovered';