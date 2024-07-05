CREATE DATABASE projects;

USE projects;

SELECT * FROM hr;

ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

DESCRIBE hr;

SELECT birthdate FROM hr;

SET sql_safe_updates = 0;

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

UPDATE hr
SET termdate = CASE 
                  WHEN termdate REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2} UTC$'
                      THEN STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC')
                  ELSE NULL
              END
WHERE termdate IS NOT NULL AND termdate != '';



UPDATE hr
SET termdate = NULL
WHERE termdate = '';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

ALTER TABLE hr ADD COLUMN age INT;

SELECT birthdate, TIMESTAMPDIFF(YEAR, birthdate, CURDATE()) AS age 
FROM hr 
LIMIT 1000;

SELECT MIN(TIMESTAMPDIFF(YEAR, birthdate, CURDATE())) AS youngest,
       MAX(TIMESTAMPDIFF(YEAR, birthdate, CURDATE())) AS oldest
FROM hr;

SELECT COUNT(*) 
FROM hr 
WHERE TIMESTAMPDIFF(YEAR, birthdate, CURDATE()) < 18;


