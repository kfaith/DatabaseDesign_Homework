use assignment_no1;

-- NAME: Kyle Faith
-- HOURS TAKEN: Around 4-5 hours

CREATE TABLE people_section_01
(
sr_no VARCHAR(30) AUTO_INCREMENT PRIMARY KEY,
student_id VARCHAR(30),
student_fname VARCHAR(30),
student_lname VARCHAR(30),
major VARCHAR(30),
favorite_programming_language VARCHAR(30),
fav_no_1_to_10 VARCHAR(10),
favorite_sport VARCHAR(30)
)AUTO_INCREMENT = 1;


CREATE TABLE pets_section_01
(
pet_id VARCHAR(30),
pet_name VARCHAR(30),
pet_type VARCHAR(30),
has_fur CHAR(1),
owner_name VARCHAR(30)
);

 INSERT INTO people_section_01(sr_no, student_id, student_fname, student_lname, 
 							  major, favorite_programming_language, fav_no_1_to_10, favorite_sport)
 VALUES('333','8974','Logan','Morgan','Computer Science','C++','6','Motocross'),
('953','4828','Cody','Daniels','Software Engineering','Java','2','Fishing'),
('785','4356','Evan','Majerus','Software Engineering','C#','2','Golf'),
('421','2870','Jackson','Hemming','Computer Science','C++','7','Baseball'),
('99','1939','Joseph','Whacheng','Industrial Engineering','Javascript','5','Soccer'),
('125','6421','Bryce','Bierman','Software Engineering','Java','6','Track and Field'),
('211','5062','Matthew','Giannola','Computer Science','C++','9','Baseball'),
('14','2443','Jacob','Downing','Software Engineering','Java','2','Soccer'),
('566','6511','Connor','Woodward','Computer Science','C++','7','None'),
('603','9529','Brandon','Bonebrake','Software Engineering','Java','3','Badminton'),
('473','7972','Elly','Dameki','Software Engineering','whitespace','2','Suffering'),
('744','9730','Nathan','Swartz','Software Engineering','Java','1','Baseball'),
('752','8219','Robert','Border','Software Engineering','Java','3','Football'),
('421','7573','Justin','Penkalski','Software Engineering','C#','1','Golf'),
('260','7548','Robert','Becker','Software Engineering','Java','5','Basketball'),
('440','9183','Brian','Rodenkirch','Software Engineering','Java','7','Volleyball'),
('653','735','Myles','Heinzen','Computer Science','C#','3','None'),
('614','6420','Connor','Robertson','Computer Science','Typescript','3','Soccer'),
('451','3291','Reynaldo','Baez','Software Engineering','Java','7','Swimming'),
('366','6834','Andi','Fuerst','Software Engineering','C#','7','None'); 

select * from people_section_01;

INSERT INTO pets_section_01(pet_id, pet_name, pet_type, has_fur, owner_name)
VALUES('1','Merlin','Cat','Y','Cody Daniels'),
('2','Cooper','Dog','Y','Jackson Hemming'),
('3','Missie','Dog','Y','Evan Majerus'),
('4','Rambo','Dog','Y','Joseph Whacheng'),
('5','Lulu','Dog','Y','Bryce Bierman'),
('6','Buschie','Snake','N','Matthew Giannola'),
('7','Gizmo','Dog','Y','Jacob Downing'),
('8','Elly','Dog','Y','Connor Woodward'),
('9','Bella','Dog','Y','Brandon Bonebrake'),
('10','Iris','Axolotl','N','Elly Dameki'),
('11','Lacey','Cat','Y','Rey Baez'),
('12','Quaris','Cat','Y','Nathan Swartz'),
('13','Tucker','Dog','Y','Justin Penkalski'),
('14','Luna','Dog','Y','Robert Becker'),
('15','Baby Hive','Honey bee hive','Y','Sammy Edwards'),
('17','Bear','Dog','Y','Noah Beilke'),
('18','Pierre' ,'Cat','Y','Trent Lawry'),
('19','Moose','Dog','Y','Connor Robertson'),
('20','Rosie','Dog','Y','Riley Rauls'),
('21','Teddie','Dog','Y','Andi Fuerst');

select * from pets_section_01;


-- add deleted column
ALTER TABLE people_section_01
ADD deleted boolean default false;

ALTER TABLE pets_section_01
ADD deleted boolean default false;

select * from pets_section_01;

-- creation timestamp
ALTER TABLE people_section_01
ADD created_at timestamp DEFAULT current_timestamp ; 

ALTER TABLE pets_section_01
ADD created_at timestamp DEFAULT current_timestamp ;

select * from people_section_01;

-- updating timestamp
ALTER TABLE people_section_01
ADD updated_at timestamp on update current_timestamp;

ALTER TABLE pets_section_01
ADD updated_at timestamp on update current_timestamp;

select * from people_section_01;

-- add constraints to the tables
ALTER TABLE people_section_01
MODIFY student_fname VARCHAR(30) NOT NULL;

ALTER TABLE people_section_01
MODIFY student_lname VARCHAR(30) NOT NULL;

ALTER TABLE pets_section_01
MODIFY pet_name VARCHAR(30) NOT NULL;

ALTER TABLE pets_section_01
MODIFY pet_type VARCHAR(30) NOT NULL;

select * from people_section_01;
select * from pets_section_01;

-- Add a unique constraint
ALTER TABLE pets_section_01
MODIFY pet_name VARCHAR(30) UNIQUE;


-- add magic number column
ALTER TABLE people_section_01
ADD magic_number VARCHAR(5) ;

select * from people_section_01;

SET SQL_SAFE_UPDATES = 0;

UPDATE people_section_01
SET magic_number = (rand() * ((sr_no+5) - (sr_no-5) + 1) + (sr_no-5))
WHERE sr_no > 0;

select * from people_section_01;

UPDATE people_section_01
SET major = REPLACE(major, 'computer science', 'Computer Science');

UPDATE people_section_01
SET major = REPLACE(major, 'software engineering', 'Software Engineering');

UPDATE people_section_01
SET magic_number = (sr_no + 1)
WHERE sr_no % 4 = 0;

SELECT student_fname, student_lname
FROM people_section_01
WHERE major = 'Software Engineering'
ORDER BY student_lname ASC;

SELECT *
FROM pets_section_01
WHERE pet_type = 'cat' OR 'Cat'
ORDER BY owner_name ASC, pet_id ASC;

SELECT *
FROM pets_section_01
WHERE (owner_name LIKE 'a%' AND has_fur = 'Y')