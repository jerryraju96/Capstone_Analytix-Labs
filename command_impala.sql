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
