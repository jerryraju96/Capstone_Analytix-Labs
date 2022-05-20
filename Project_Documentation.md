### Documentation

## Objective
The objective of this project is to create a data engineering solution to the HR Employee data. And to create a data model that helps with extraction,
transformation and loading of data from one tool to another for fundamental data analysis using Big Data tools. Data is  clustered into six CSV files. In this project
a table is designed tto hold data in the CSVs, import the CSVs into a SQL database, import to HDFS/Hive using Sqoop, and perform analysis using Hive/Impala/Spark/SparkML
using the data and create piplines.

## Data Used
Dataset consist of information from a major company in the 1980's and 1990's. It has 6 Columns and information of all the Employees

```
a. Titles (It has job title and title id
b. Employees ( Basic details of employees - like Name, Employye no, DOB, Joining and Leaving Date)
c. Salaries (Salary Details)
d. Departments (Details of each department like Name)
e. Department Managers (Details of each Department Manager)
f. Department Employees (Details of Employees at Department level)
```

## Tech Stack used

```
- MySQL (to create database and tables)
- Linux Commands (to move data)
- Sqoop (transfer data from MySQL Server to HDFS/Hive)
- HDFS (to store the data)
- Hive (to create database)
- Impala (to perform the EDA)
- SparkSQL (to perform the EDA)
- SparkML (to perform model building)

```

## Entity Relation Diagram
![ERD](https://user-images.githubusercontent.com/71822780/169615003-38530081-72a8-478e-bb8d-91f1abe107b2.png)

## Architecture of pipeline

# 1. Database and table creation in MySQL
Database anabig114239 is used and following command is run
a. upload the data to ftp (https://npbdh.cloudloka.com/ftp)
```
source create_database.sql
```

### create_database.sql

```
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
```


## 2 Transfer Data from SQL to HDFS using Sqoop
```
sh capstone_hadoop.sh
```
### capstone_hadoop.sh

```
hdfs dfs -rm -r /user/anabig114239/hive/warehouse/departments_j/*
hdfs dfs -rm -r /user/anabig114239/hive/warehouse/titles_j/*
hdfs dfs -rm -r /user/anabig114239/hive/warehouse/employees_j/*
hdfs dfs -rm -r /user/anabig114239/hive/warehouse/dept_manager_j/*
hdfs dfs -rm -r /user/anabig114239/hive/warehouse/dept_emp_j/*
hdfs dfs -rm -r /user/anabig114239/hive/warehouse/salaries_j/*


hdfs dfs -rm -r /user/anabig114239/hive/warehouse/departments_j/
hdfs dfs -rm -r /user/anabig114239/hive/warehouse/titles_j/
hdfs dfs -rm -r /user/anabig114239/hive/warehouse/employees_j/
hdfs dfs -rm -r /user/anabig114239/hive/warehouse/dept_manager_j/
hdfs dfs -rm -r /user/anabig114239/hive/warehouse/dept_emp_j/
hdfs dfs -rm -r /user/anabig114239/hive/warehouse/salaries_j/

sqoop import-all-tables "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" --connect jdbc:mysql://ip-10-1-1-204.ap-south-1.compute.internal:3306/anabig114239 --username anabig114239 --password Bigdata123 --compression-codec=snappy --as-avrodatafile --warehouse-dir /user/anabig114239/hive/warehouse --m 1 --driver com.mysql.jdbc.Driver
hadoop fs -rm -r /user/anabig114239/capstone1/*
hadoop fs -rm -r /user/anabig114239/capstone1/

hadoop fs -mkdir /user/anabig114239/capstone1
hadoop fs -put /home/anabig114239/departments_j.avsc /user/anabig114239/capstone1/departments_j.avsc
hadoop fs -put /home/anabig114239/titles_j.avsc /user/anabig114239/capstone1/titles_j.avsc
hadoop fs -put /home/anabig114239/employees_j.avsc /user/anabig114239/capstone1/employees_j.avsc
hadoop fs -put /home/anabig114239/dept_managers_j.avsc /user/anabig114239/capstone1/dept_managers_j.avsc
hadoop fs -put /home/anabig114239/dept_emp_j.avsc /user/anabig114239/capstone1/dept_emp_j.avsc
hadoop fs -put /home/anabig114239/salaries_j.avsc /user/anabig114239/capstone1/salaries_j.avsc


```

## 3 Creatig Table in hive

```
hive -f hive_commands.sql
```
### hive_commands.sql

```
drop table if exists departments_j;
CREATE EXTERNAL TABLE departments_j STORED AS AVRO LOCATION '/user/anabig114239/hive/warehouse/departments_j' TBLPROPERTIES ('avro.schema.url'='/user/anabig114239/capstone1/departments_j.avsc');

drop table if exists employees_j;
CREATE EXTERNAL TABLE employees_j STORED AS AVRO LOCATION '/user/anabig114239/hive/warehouse/employees_j' TBLPROPERTIES ('avro.schema.url'='/user/anabig114239/capstone1/employees_j.avsc');

drop table if exists titles_j;
CREATE EXTERNAL TABLE titles_j STORED AS AVRO LOCATION '/user/anabig114239/hive/warehouse/titles_j' TBLPROPERTIES ('avro.schema.url'='/user/anabig114239/capstone1/titles_j.avsc');

drop table if exists dept_managers_j;
CREATE EXTERNAL TABLE dept_managers_j STORED AS AVRO LOCATION '/user/anabig114239/hive/warehouse/dept_managers_j' TBLPROPERTIES ('avro.schema.url'='/user/anabig114239/capstone1/dept_managers_j.avsc');

drop table if exists dept_emp_j;
CREATE EXTERNAL TABLE dept_emp_j STORED AS AVRO LOCATION '/user/anabig114239/hive/warehouse/dept_emp_j' TBLPROPERTIES ('avro.schema.url'='/user/anabig114239/capstone1/dept_emp_j.avsc');

drop table if exists salaries_j;
CREATE EXTERNAL TABLE salaries_j STORED AS AVRO LOCATION '/user/anabig114239/hive/warehouse/salaries_j' TBLPROPERTIES ('avro.schema.url'='/user/anabig114239/capstone1/salaries_j.avsc');

```

## 4 Analysis using Impala

```
impala -shell -f impala_command.sql > outpt.txt
```

### command_impala
```
use jerryalab;

select e.emp_no, e.last_name,e.first_name, e.sex, s.salary FROM employees_j e JOIN salaries_j s ON e.emp_no = s.emp_no 

SELECT first_name, last_name, hire_date FROM employees_j WHERE hire_date BETWEEN '1/1/1986' AND '12/31/1986' ORDER BY hire_date;

SELECT d.dept_no, d.dept_name,dm.emp_no, e.first_name, e.last_name from departments_j d join dept_managers_j dm on d.dept_no =dm.dept_no join employees_j e on dm.emp_no = e.emp_no

select de.emp_no, e.first_name, e.last_name, d.dept_name from dept_emp_j de join employees_j e on de.emp_no = e.emp_no join departments_j d on de.dept_no = d.dept_no 

select first_name, last_name, sex from employees_j where first_name = 'Hercules' and  last_name Like 'B%'

select E.first_name,E.last_name,D.dept_no,D.dept_name from dept_emp_j DE join employees_j E on DE.emp_no = E.emp_no join departments_j D on DE.dept_no =D.dept_no where D.dept_name = '"Sales"' 

select E.first_name,E.last_name,D.dept_no,D.dept_name from dept_emp_j DE join employees_j E on DE.emp_no = E.emp_no join departments_j D on DE.dept_no =D.dept_no where D.dept_name = '"Sales"' or D.dept_name='"devolpment"'

select last_name,count(last_name) as No_of_Names from employees_j group by last_name order by No_of_Names desc

SELECT title, sum(salary) as sum_Salary from titles_j t JOIN employees_j e  on t.title_id = e.emp_title_id JOIN salaries_j s on e.emp_no =  s.emp_no GROUP BY title;

SELECT title, avg(salary) as AVg_Salary from titles_j t JOIN employees_j e  on t.title_id = e.emp_title_id JOIN salaries_j s on e.emp_no =  s.emp_no GROUP BY title;

select d.dept_name, count(e.emp_no) from departments_j d join dept_emp_j de on d.dept_no= de.dept_no join employees_j e on de.emp_no=e.emp_no group by dept_name

select d.dept_name, count(e.emp_no) as No_OF_EMPLOYEEs,sum(s.salary) as Total_Salary from departments_j d join dept_emp_j de on d.dept_no= de.dept_no join employees_j e on de.emp_no=e.emp_no join salaries_j s on s.emp_no=e.emp_no group by dept_name

select max(salary) as Highest_Salary from salaries_j

select sex,sum(salary) as Total_Salary from employees_j e join salaries_j s on s.emp_no=e.emp_no group by sex

select dept_name,title from departments_j d join dept_managers_j jm on jm.dept_no = d.dept_no join employees_j e on e.emp_no=jm.emp_no join titles_j t on t.title_id = e.emp_title_id

select sex,count(no_of_projects) from Data group by sex'
```

## Step 5
```
Load the Data in Pyspark and Do the Ml Analysis and Modeling -
Refer to-

```


# Outputs Of Analysis

A list showing employee number, last name, first name, sex, and salary for each employee1.

![1](https://user-images.githubusercontent.com/71822780/169618942-3993cee4-1ac6-4326-a58c-6133ef02d0a7.png)


A list showing first name, last name, and hire date for employees who were hired in 1986.

![2](https://user-images.githubusercontent.com/71822780/169618971-4aea426c-083d-4c81-8f68-bef7dac9a3a1.png)

A list showing the manager of each department with the following information: department number, department name, 
the manager's employee number, last name, first name.

![3](https://user-images.githubusercontent.com/71822780/169619049-03b4e659-6f11-477c-a7a5-65a2fa9696f2.png)

 
A list showing the department of each employee with the following information: employee number, last name, first 
name, and department name.
![4](https://user-images.githubusercontent.com/71822780/169619070-2f641be2-003d-4398-bf84-6568d5a9390b.png)

A list showing first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B.“

![5](https://user-images.githubusercontent.com/71822780/169619184-d8818d90-b3c1-48ab-bb7d-def1b31f38c2.png)

 
 
A list showing all employees in the Sales department, including their employee number, last name, first name, and 
department name.

![6](https://user-images.githubusercontent.com/71822780/169619218-2925096f-a53b-4f2c-8052-9f3a84f99466.png)

A list showing all employees in the Sales and Development departments, including their employee number, last name, 
first name, and department name.

![7](https://user-images.githubusercontent.com/71822780/169619247-0fab0dfb-28ee-4c8d-bf75-9dcc1e5f977f.png)


A list showing the frequency count of employee last names, in descending order. ( i.e., how many employees share each 
last name

![8](https://user-images.githubusercontent.com/71822780/169619900-0dc9ca1a-57d3-482e-9753-7e2ba07e810a.png)


Histogram to show the salary distribution among the employees

![9 Graph](https://user-images.githubusercontent.com/71822780/169620086-129f724c-059b-45ca-b3ef-bd42bc5ee5e5.png)


Bar graph to show the Average salary per title (designation)

![10 Graph](https://user-images.githubusercontent.com/71822780/169620105-4cd68555-e161-4de8-87fd-8b7cda7f9855.png)



Total Salary By Employee Count and Sex

![EDA 1](https://user-images.githubusercontent.com/71822780/169620242-45c3da98-bc34-4c83-adbf-5c48324d8d32.png)

Total Salary By Sex

![Eda 4](https://user-images.githubusercontent.com/71822780/169620243-866a45bd-3f66-4b5e-9857-720eddf00620.png)

Departments and Titles

![image_2022-05-21_040135463](https://user-images.githubusercontent.com/71822780/169620614-c00a17a7-bb92-48fb-b0b3-c9d29cb1c312.png)



Max Salary Earned
![12](https://user-images.githubusercontent.com/71822780/169620840-6bc27d58-ca52-4863-ad2f-ccd3a0e92dfd.png)

No of projects based on gender

![image_2022-05-21_040611802](https://user-images.githubusercontent.com/71822780/169620921-5cf42800-8b4a-4412-87e1-d13c947cb921.png)


## ML Model Results


## Challenges faced
 
Issue with transfering Data, Server Issues

## Next Steps

Improve the predictive model with Feature Engineering, Outlier Analysis






