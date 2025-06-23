CREATE TABLE departments (
	dept_no VARCHAR, -- >- dept_emp.dept_no
	dept_name VARCHAR
);

ALTER TABLE dept_manager
ADD CONSTRAINT primary_key3
PRIMARY KEY(emp_no);

ALTER TABLE employees
ADD CONSTRAINT primary_key4
PRIMARY KEY(emp_no);

ALTER TABLE salaries
ADD CONSTRAINT primary_key5
PRIMARY KEY(emp_no);

ALTER TABLE titles
ADD CONSTRAINT primary_key6
PRIMARY KEY(title_id);

SELECT * FROM dept_manager

CREATE TABLE dept_emp (
	emp_no INT, -- >- salaries.emp_no
	dept_no VARCHAR
);

CREATE TABLE dept_manager (
	dept_no VARCHAR, -- >- departments.dept_no
	emp_no INT
);

CREATE TABLE employees (
	emp_no INT, -- >- dept_emp.emp_no
	emp_title_id VARCHAR, -- >- titles.title_id
	birth_date VARCHAR,
	first_name VARCHAR,
	last_name VARCHAR,
	sex VARCHAR,
	hire_date VARCHAR
);

CREATE TABLE salaries (
	emp_no INT,
	salary INT
);

CREATE TABLE titles (
	title_id VARCHAR,
	title VARCHAR
);

-- EE #, last, first, sex, salary
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries ON
employees.emp_no=salaries.emp_no

-- first name, last name, hire date for 1986
SELECT first_name, last_name, hire_date FROM employees
WHERE EXTRACT(YEAR FROM (CAST(hire_date AS DATE))) = 1986

-- managers: department number, department name, employee number, last name, first name
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM dept_manager
INNER JOIN departments ON dept_manager.dept_no = departments.dept_no
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no

-- department number for each employee, EE number, last name, first name, department name
SELECT dept_emp.dept_no, dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
INNER JOIN employees ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no

-- first name, last name, sex of Hercules B.
SELECT first_name, last_name, sex FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'

-- each employee in the sales department: employee number, last name, first name
SELECT dept_emp.dept_no, dept_emp.emp_no, employees.last_name, employees.first_name
FROM dept_emp
INNER JOIN employees ON dept_emp.emp_no = employees.emp_no
WHERE dept_emp.dept_no = 'd007'

-- employees in sales and development
SELECT dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_emp
INNER JOIN employees ON dept_emp.emp_no = employees.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development'

-- employee last name frequency counts in descending order
SELECT last_name, COUNT(*) AS count
FROM employees
GROUP BY last_name
ORDER BY last_name DESC
