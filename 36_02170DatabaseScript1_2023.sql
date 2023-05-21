DROP DATABASE IF EXISTS VetClinic2;
CREATE DATABASE VetClinic2;
USE VetClinic2;

DROP TABLE IF EXISTS Veterinarian;
DROP TABLE IF EXISTS proprietor;
DROP TABLE IF EXISTS Ownership;
DROP TABLE IF EXISTS pet;
DROP TABLE IF EXISTS diagnosis;
DROP TABLE IF EXISTS animal_disease_diagnosis;


CREATE TABLE Veterinarian (
    doc_id BIGINT UNIQUE AUTO_INCREMENT,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    email VARCHAR(40),
    phone_number INT,
    appointment_fee INT,
    PRIMARY KEY(doc_id)
);

SELECT 
    CONCAT(Veterinarian.First_Name,' ', Veterinarian.Last_Name) 
    AS FullName
from Veterinarian;

CREATE TABLE Proprietor (
    proprietor_id INT UNIQUE AUTO_INCREMENT,
    proprietor_first_name VARCHAR(40),
    proprietor_last_name VARCHAR(40),
    proprietor_address VARCHAR(40),
    PRIMARY KEY(proprietor_id)
);

SELECT 
    CONCAT(proprietor.proprietor_First_Name,' ', proprietor.proprietor_Last_Name) 
    AS FullName
from proprietor;

CREATE TABLE Pet (
    animal_id BIGINT UNIQUE AUTO_INCREMENT NOT NULL,
    animal_name VARCHAR(40),
    animal_species VARCHAR(40),
    animal_gender ENUM ('male', 'female'),
    proprietor_id INT,
    diagnosis_id INT,
    animal_age INT,
    responsible_doc_id BIGINT,
    PRIMARY KEY(animal_id),
    FOREIGN KEY (responsible_doc_id) REFERENCES Veterinarian(doc_id),
    FOREIGN KEY (proprietor_id) REFERENCES Proprietor(proprietor_id) 
);

CREATE TABLE Ownership (
animal_id BIGINT,
proprietor_id INT,
PRIMARY KEY (animal_id, proprietor_id),
FOREIGN KEY (proprietor_id) REFERENCES Proprietor (proprietor_id),
FOREIGN KEY (animal_id) REFERENCES Pet (animal_id)
);

CREATE TABLE Diagnosis (
    diagnosis_id BIGINT,
    diagnosis_name VARCHAR (40),
    Cost_before_fees DECIMAL(10,2),
    Required_appointments INT,
    PRIMARY KEY(diagnosis_id)
);
           
CREATE TABLE Animal_disease_diagnosis (
    animal_diagnosis_id BIGINT,
    time_validation TIME,
    animal_id BIGINT,
    diagnosis_date DATE,
    diagnosis_month int,
    PRIMARY KEY(animal_diagnosis_id, animal_id),
    FOREIGN KEY (animal_id) REFERENCES pet (animal_id),
    FOREIGN KEY (animal_diagnosis_id) REFERENCES Diagnosis (diagnosis_id)
);
 
    
INSERT INTO Veterinarian (doc_id, first_name, last_name, email, phone_number, appointment_fee) VALUES
    (1,'Tammy','McKenna','tmckenna0@epa.gov','60258164',25),
    (2,'Claybourne','Cooney','ccooney1@quantcast.com','55596988',30),
    (3,'Nannette','Iskov','niskov2@toplist.cz','18215063',20),
    (4,'Dinah','Oppy','doppy3@deliciousdays.com','81678073',40),
    (5,'Deloria','Cockle','dcockle4@mapquest.com','63083333',35),
    (6,'Laura','Maasze','lmaasze5@jugem.jp','55862596',28),
    (7,'Bernardina','Wyper','bwyper6@stumbleupon.com','93863442',32),
    (8,'Glenden','Rance','grance7@samsung.com','18456913',27),
    (9,'Sofia','Petrovic','sofia.petrovic@fakemail.com','331762106',39),
    (10,'Miroslav','Horvat','miroslav.horvat@fakemail.com','396238244',34),
    (11,'Luka','Novak','luka.novak@fakemail.com','93534921',39),
    (12,'Anja','Jankovic','anja.jankovic@fakemail.com','31264527',39),
    (13,'Alexander','Müller','alexander.müller@fakemail.com','61460242',35),
    (14,'Ingrid','Andersen','ingrid.andersen@fakemail.com','533105305',38),
    (15,'Stefan','Weber','stefan.weber@fakemail.com','12531434',33),
    (16,'Ana','Popescu','ana.popescu@fakemail.com','30481589',37),
    (17,'Lars','Berg','lars.berg@fakemail.com','91864283',33),
    (18,'Tatiana','Ivanova','tatiana.ivanova@fakemail.com','89369532',27),
    (19,'Marco','Rossi','marco.rossi@fakemail.com','37449861',33),
    (20,'Magdalena','Nowak','magdalena.nowak@fakemail.com','11732413',40)
;


INSERT INTO Proprietor VALUES 
    (1, 'Crichton', 'Jessen', '96571 Kingsford Drive'),
    (2, 'Koren', 'Oakland', '68 Thompson Court'),
    (3, 'Zachary', 'Peachman', '2 Magdeline Court'),
    (4, 'Andrew', 'Glaubermann', '86 Florence Avenue'),
    (5, 'Mallorie', 'Culcheth', '2248 Derek Plaza'),
    (6, 'Brandy', 'Vallentine', '6381 Ruskin Circle St.'),
    (7, 'Jesse', 'Pinkman', '127 Nebraska St.'),
    (8, 'Pam', 'Beesly', '524 Scrantoncity St.'),
    (9, 'Michael', 'Scott', '4381 Di Loreto Terrace'),
    (10, 'Hugo', 'Stiglitz', '9 Inglorious St.'),
    (11, 'Byrle', 'Glenton', '22 Steensland Plaza'),
    (12, 'Alvaro', 'Vaya', 'Plaza de Pepe Mena 2'),
    (13, 'Phoebe', 'Buffay', 'Central Perk 178'),
    (14, 'Britta', 'Perry', 'Amazon St 91'),
    (15, 'Annie', 'Edison', 'Doodle St 4'),
    (16, 'Annie', 'Kim', 'Dan Harmon St. 1'),
    (17, 'Marshall', 'Kane', '4th September St 51'),
    (18, 'Shirley', 'Bennett', 'Magnitude St. 6'),
    (19, 'Jim', 'Morrison', '37 The Doors St.'),
    (20, 'Hermione', 'Granger', 'Kings Cross St 9'),
    (21, 'Harry', 'Potter', 'Hogwarts St 47'),
    (22, 'Kristjan', 'Toevali', 'Lundtoftevej 27'),
    (23, 'Stephanie', 'Dosen', 'Massive Attack 37')
;



INSERT INTO pet VALUES
    (1, 'Bella', 'Dog', 'female', 1, 6, 4, 2),
	(2, 'Luna', 'Rabbit', 'female', 19, 5, 10, 3),
    (3, 'Ringo', 'Dog', 'male', 1, 7, 6, 8),
    (4, 'Charlie', 'Cat', 'male', 13, 5, 6, 1),
    (5, 'Lucy', 'Mouse', 'female', 9, 5, 8, 5),
    (6, 'Seven', 'Dog', 'female', 17, 1, 7, 5), 
    (7, 'Yellow', 'Parrot', 'female', 4, 6, 10, 7),
    (8, 'Zoe', 'Guinea pig', 'female', 6, 3, 1, 6),
    (9, 'Milly', 'Horse', 'female', 2, 6, 6, 9),
	(10, 'Lily', 'Dog', 'female', 12, 1, 3, 2),
	(11, 'Ozzy', 'Snake', 'male', 16, 2, 4, 9),
    (12, 'Blue', 'Cat', 'female', 18, 3, 6, 4),
	(13, 'Bailey', 'Turtle', 'male', 10, 1, 1, 6),
    (14, 'Sebastian', 'Rabbit', 'male', 22, 7, 3, 2),
	(15, 'Stella', 'Cat', 'female', 16, 7, 8, 1),
	(16, 'Penelope', 'Dog', 'female', 9, 1, 4, 1),
    (17, 'Jackson', 'Cat', 'male', 3, 2, 4, 9),
    (18,'Dallas', 'Horse', 'male', 13, 4, 10, 6),
    (19, 'Ryan', 'Horse', 'male', 9, 4, 7, 7),
    (20, 'Carlos', 'Dog', 'male', 11, 3, 5, 6),
    (21, 'Fuego', 'Cat', 'male', 7, 5, 10, 10),
    (22, 'Max', 'Dog', 'male', 23, 3, 4,16),
    (23,'Marley', 'Dog', 'male', 3, 3, 1, 4),
    (24, 'Stuart', 'Mouse', 'female', 15, 5, 4, 4),
    (25, 'Dona', 'Parrot', 'female', 6, 3, 3, 9),
    (26, 'Zeta', 'Guinea pig', 'male', 5, 5, 7, 11),
    (27, 'Hera', 'Dog', 'female', 22, 1, 9, 6),
    (28, 'Paco', 'Cat', 'male', 23, 4, 12, 18),
    (29, 'Tina', 'Turtle', 'female', 11, 5, 14, 14),
    (30, 'Pose', 'Rabbit', 'female', 21, 5, 4, 19),
    (31, 'Oil', 'Horse', 'male', 19, 4, 10, 10),
    (32, 'Laurie', 'Snake', 'female', 14, 1, 2, 18), 
    (33, 'Pasta', 'Cat', 'male', 10, 2, 1, 9),
    (34, 'Andrea', 'Dog', 'female', 8, 6, 6, 5),
    (35, 'Porsche', 'Mouse', 'male', 20, 6, 1, 11)
;

INSERT INTO Ownership
SELECT pet.animal_id, proprietor.proprietor_id
from pet
inner join proprietor
on pet.proprietor_id = proprietor.proprietor_id
order by animal_id;

INSERT diagnosis VALUES 
    (1,'Strangles',270,15),
    (2,'Enzootic bovine leucosis',80,12),
    (3,'Rabies due to rabies virus',75,3),
    (4,'Influenza A in pigs',165,7),
    (5,'Avian influenza',325,13),
    (6,'Screw-worm fly',290,12),
    (7,'Botulism in poultry',145,14),
    (8,'Johne disease',405,8)
;

INSERT INTO Animal_disease_diagnosis VALUES
    (2,'07:03:00',7,'2020-03-15','3'),
    (8,'08:11:00',6,'2021-06-08','6'),
    (3,'06:01:00',2,'2022-07-19','7'),
    (3,'05:31:00',16,'2023-01-22','1'),
    (2,'06:47:00',17,'2019-04-11','4'),
    (1,'08:35:00',18,'2020-05-30','5'),
    (8,'05:12:00',15,'2022-08-17','8'),
    (4,'11:16:00',1,'2019-06-25','6'),
    (3,'14:06:00',3,'2020-09-05','9'),
    (7,'16:22:00',4,'2021-10-26','10'),
    (6,'12:02:00',5,'2020-06.12','6'),
    (1,'11:02:00',8,'2019-03-29','3'),
    (2,'13:34:00',9,'2018-07-14','7'),
    (3,'17:10:00',10,'2021-07-18','7'),
    (7,'10:24:00',11,'2020-07-07','7'),
    (6,'22:32:00',12,'2019-05-23','5'),
    (1,'04:12:00',13,'2020-08-09','8'),
    (5,'08:44:00',14,'2022-10-03','10'),
    (1,'00:04:00',19,'2021-06-20','6'),
    (4,'22:04:00',20,'2019-06-27','6')
;


-- SELECT * FROM Veterinarian;
-- SELECT * FROM pet;
-- SELECT * FROM Ownership;
-- SELECT * FROM proprietor;
-- SELECT * FROM animal_disease_diagnosis;
-- SELECT * FROM diagnosis;


CREATE VIEW doctor_info AS
    SELECT doc_id, CONCAT(Veterinarian.First_Name,' ', Veterinarian.Last_Name) AS FullName, phone_number
FROM Veterinarian;