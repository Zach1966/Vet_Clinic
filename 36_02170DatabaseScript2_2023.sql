USE VETCLINIC2;

-- -- = = = QUERIES = = =  --

-- -- What are the top 3 most common diagnosed diseases?
SELECT d.diagnosis_id, d.diagnosis_name, COUNT(ad.animal_diagnosis_id) AS Frequency 
FROM diagnosis d LEFT JOIN animal_disease_diagnosis ad
ON d.diagnosis_id = ad.animal_diagnosis_id
GROUP BY d.diagnosis_id, d.diagnosis_name
ORDER BY Frequency DESC
LIMIT 3
;

-- -- What is the total cost of treating every of the diseases with Dr. Alexander Müller?
SELECT d.*, 
d.Required_appointments * v.Appointment_fee AS Total_Fees,
((d.Required_appointments * v.Appointment_fee) + Cost_before_fees) AS Total_Cost
FROM diagnosis d JOIN veterinarian v
WHERE v.first_name LIKE '%Alexander%' AND v.last_name LIKE '%Mûller%'
;

-- -- What is the average age of animals diagnosed with Avian Influenza?
--  
SELECT d.diagnosis_id, d.diagnosis_name, COUNT(p.diagnosis_id) AS No_of_animals, ROUND(avg(p.animal_age),1) AS Average_age
FROM pet p LEFT JOIN diagnosis AS d
ON p.diagnosis_id = d.diagnosis_id
WHERE d.diagnosis_name LIKE '%Avian influenza%'
GROUP BY d.diagnosis_id, d.diagnosis_name
;

-- -- What is the month when more animals get sick (are diagnosed)?

Select monthname(diagnosis_date) as Month, 
count(month(diagnosis_date)) as No_of_diagnosis
from animal_disease_diagnosis
group by month(diagnosis_date)
order by No_of_diagnosis desc
limit 1
;

-- -- What are the top 10 more expensive combinations of desease-doctor, considering the general cost of the treatment and the fees for the number of necessary appointments?

Select d.diagnosis_name, concat(v.first_name,v.last_name), v.Appointment_fee, d.Cost_before_fees, d.Required_appointments,
d.Required_appointments * v.Appointment_fee as Total_Fees,
((d.Required_appointments * v.Appointment_fee) + Cost_before_fees) as Total_Cost
from diagnosis d join veterinarian v
order by Total_Cost desc
limit 10
;

-- = = = SQL PROGRAMMING = = =  --

-- FUNCTION
DROP FUNCTION IF EXISTS diagnosis_final_price;

DELIMITER //
CREATE FUNCTION diagnosis_final_price(input_diagnosis_id BIGINT, VAT DECIMAL(5,2)) RETURNS DECIMAL(10,2)
BEGIN
    DECLARE v_Final_price DECIMAL(10,2);
    
    SELECT (Cost_before_fees + (Cost_before_fees) * VAT) * Required_appointments INTO v_Final_price
    FROM Diagnosis
    WHERE diagnosis_id = input_diagnosis_id;
--
    RETURN v_Final_price;
END//
DELIMITER ;

-- let's try if it works, for input_diagnosis_id = 1 and VAT = 25%
SELECT diagnosis_final_price (1, 0.25);


-- PROCEDURE
DROP PROCEDURE IF EXISTS Number_Of_Pets;

-- With this procedure, we are able to find the number of pets belonging to a single customer
DELIMITER &&
CREATE PROCEDURE Number_Of_Pets (IN vproprietor INT, OUT vpet BIGINT)
BEGIN
  SELECT COUNT(animal_id) INTO vpet
  FROM pet
  WHERE proprietor_id = vproprietor;
END &&
DELIMITER ;

-- Let's check if it works properly. We'll try for animal_id = 1
CALL Number_Of_Pets(1, @result);
SELECT @result AS number_of_pets;


-- = = = SQL table modifications = = =  --

-- UPDATE Doctor's email given first name and last name
UPDATE Veterinarian SET email = "glenden.rance@gmail.com"
WHERE first_name = "Glenden" AND last_name = "Rance";

-- TRIGGER
/* DO NOT PERMIT TO DELETE ENTRIES THAT ARE NOT OLDER THAN 2 YEARS */

DROP TRIGGER IF EXISTS delete_old_diagnoses;

DELIMITER //

CREATE TRIGGER delete_old_diagnoses
BEFORE DELETE ON Animal_disease_diagnosis
FOR EACH ROW
BEGIN
  IF OLD.diagnosis_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 2 YEAR) THEN
      signal sqlstate 'HY000'
      SET mysql_errno = 6666,
      message_text = 'You can delete only entries older than 2 year';
  END IF;
END//

DELIMITER ;

-- Test the trigger
delete from animal_disease_diagnosis
where animal_id = 16;


-- DELETE STATEMENT
delete from animal_disease_diagnosis
where animal_id = 9;

select * from animal_disease_diagnosis

