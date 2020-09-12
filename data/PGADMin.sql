DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;

--create database 
--good practice to add not null, otherwise it woul've ok since there are no empty values
-- a. department
CREATE TABLE Departments (
    dept_no VARCHAR,
    dept_name VARCHAR(30) NOT NULL,
    PRIMARY KEY (dept_no)
);


SELECT * FROM Departments;
--b.dept_emp
CREATE TABLE dept_emp (
	emp_no VARCHAR NOT NULL,
    dept_no VARCHAR NOT NULL,
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);

SELECT * FROM dept_emp;
--c. manager
CREATE TABLE dept_manager (
	dept_no VARCHAR NOT NULL,
    emp_no VARCHAR NOT NULL,
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no),
	PRIMARY KEY (emp_no)
);
--d. employee
CREATE TABLE employees (
	emp_no VARCHAR NOT NULL,
    emp_title_id VARCHAR NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);

SELECT * FROM employees;
-- e. salary
CREATE TABLE salaries (
	emp_no VARCHAR NOT NULL,
    salary INTEGER NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
SELECT * FROM titles;
--f. title
CREATE TABLE titles (
	title_id VARCHAR NOT NULL,
    title VARCHAR NOT NULL,
	PRIMARY KEY (title_id)
);

--1 List the following details of each employee: employee number, last name, first name, sex, and salary.
--join 2 tables
SELECT employees.emp_no, last_name, first_name, sex, salary 
FROM employees JOIN salaries
on employees.emp_no= salaries.emp_no

--2 List first name, last name, and hire date for employees who were hired in 1986.
--hire dates between the beginning and end of year
SELECT last_name, first_name, hire_date FROM employees 
WHERE hire_date >= '1986-01-01'
AND hire_date <= '1986-12-31';

--3 List the manager of each department with the following information: department number, department name, 
--the manager's employee number, last name, first name.
--use department, dept_manager, and employees
--multiple tables need inner joins

SELECT dept_manager.dept_no, 
		Departments.dept_name,
		dept_manager.emp_no,
		employees.last_name,  
		employees.first_name
--first, do dept manager to inner join departments then inner join employees then match
FROM dept_manager 
INNER JOIN Departments 
ON dept_manager.dept_no = Departments.dept_no
INNER JOIN Employees 
ON dept_manager.emp_no = employees.emp_no;

--4. List the department of each employee with the following information: employee number, 
--last name, first name, and department name.

SELECT employees.emp_no,
		employees.last_name,
		employees.first_name,
		Departments.dept_name
--first, join together employees and then dept manager then departments to connect to departments to match
FROM employees 
INNER JOIN dept_manager
on employees.emp_no= dept_manager.emp_no
INNER JOIN Departments
on Departments.dept_no = dept_manager.dept_no

--5.List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name, sex FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';	--add place holder

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT  Departments.dept_name,
		employees.emp_no,
		employees.last_name,  
		employees.first_name
--first, do dept manager to inner join departments then inner join employees then match
FROM dept_manager 
INNER JOIN Departments 
ON dept_manager.dept_no = Departments.dept_no
INNER JOIN Employees 
ON dept_manager.emp_no = employees.emp_no

WHERE dept_name= 'Sales';

--7.List all employees in the Sales and Development departments, including their employee number, 
--last name, first name, and department name.
SELECT  Departments.dept_name,
		employees.emp_no,
		employees.last_name,  
		employees.first_name
--first, do dept manager to inner join departments then inner join employees then match
FROM dept_manager 
INNER JOIN Departments 
ON dept_manager.dept_no = Departments.dept_no
INNER JOIN Employees 
ON dept_manager.emp_no = employees.emp_no

WHERE dept_name = 'Sales' 
OR dept_name = 'Development';



