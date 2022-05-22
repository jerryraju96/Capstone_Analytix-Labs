use jerryalab;

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
