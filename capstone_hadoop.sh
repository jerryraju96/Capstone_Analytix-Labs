
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