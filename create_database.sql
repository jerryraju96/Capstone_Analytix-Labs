mysql -u anabig114239 -pBigdata123

 
use anabig114239
drop table departments_J;
drop table titles_j
drop table employees_j
drop table dept_managers_j
drop table salaries_j



CREATE TABLE departments_j(
	dept_no varchar(15) NOT NULL ,
	dept_name varchar(30) NOT NULL
);

CREATE TABLE titles_j(
	title_id varchar(10),
	title varchar(35) NOT NULL
);

CREATE TABLE employees_j(
	emp_no INT NOT NULL,
	emp_title_id VARCHAR(10) NOT NULL,
	birth_date VARCHAR (23) NOT NULL,
	first_name VARCHAR(22) NOT NULL,
	last_name VARCHAR(22) NOT NULL,
	sex VARCHAR(2) NOT NULL,
	hire_date VARCHAR(23) NOT NULL,
	no_of_projects int NOT NULL,
	last_performance_rating varchar(10) NOT NULL,
	leftA int NOT NULL,
	last_date varchar(10)
);


CREATE TABLE dept_managers_j(
	dept_no varchar(10) NOT NULL,
	emp_no int NOT NULL
); 







CREATE TABLE dept_emp_j(
	emp_no int NOT NULL,
	dept_no varchar(20) NOT NULL
); 




CREATE TABLE salaries_j(
	emp_no int NOT NULL,
	Salary bigint NOT NULL
);



load data local infile '/home/anabig114239/departments.csv' into table departments_j fields terminated by ',' ignore 1 rows;

load data local infile '/home/anabig114239/titles.csv' into table titles_j fields terminated by ',' ignore 1 rows;

load data local infile '/home/anabig114239/employees.csv' into table employees_j fields terminated by ',' ignore 1 rows;

load data local infile '/home/anabig114239/dept_manager.csv' into table dept_managers_j fields terminated by ',' ignore 1 rows;

load data local infile '/home/anabig114239/dept_emp.csv' into table dept_emp_j fields terminated by ',' ignore 1 rows;

load data local infile '/home/anabig114239/salaries.csv' into table salaries_j fields terminated by ',' ignore 1 rows;