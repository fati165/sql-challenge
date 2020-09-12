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