-- Initiate drop table
DROP TABLE IF EXISTS title


-- Creating schemas and importing values for the tables

CREATE TABLE departments (
  dept_no VARCHAR PRIMARY KEY,
  dept_name VARCHAR NOT NULL
  );

SELECT * FROM departments

CREATE TABLE titles (
  title_id VARCHAR PRIMARY KEY,
  title VARCHAR NOT NULL 
);

SELECT * FROM titles

CREATE TABLE employees (
	emp_no INT PRIMARY KEY,
	emp_title_id VARCHAR NOT NULL,
  	birth_date DATE NOT NULL,
  	first_name VARCHAR NOT NULL,
  	last_name VARCHAR NOT NULL,
  	sex VARCHAR NOT NULL,
  	hire_date DATE NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles (title_id)
);

SELECT * FROM employees

CREATE TABLE dept_emp (
	id VARCHAR PRIMARY KEY,
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);

SELECT * FROM dept_emp

CREATE TABLE dept_manager (
	id VARCHAR PRIMARY KEY,
	dept_no VARCHAR NOT NULL,
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
 );
 
SELECT * FROM dept_manager

CREATE TABLE salaries (
	emp_no INT PRIMARY KEY,
	salary INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

SELECT * FROM salaries



-- 1. List employee number, last name, first name, sex, and salary of each employee.
SELECT 
e.emp_no,
e.first_name,
e.last_name,
e.sex,
s.salary
FROM
employees as e
INNER JOIN salaries as s
ON s.emp_no = e.emp_no;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT 
 first_name,
 last_name,
 hire_date
 FROM employees 
 WHERE EXTRACT(YEAR FROM hire_date) = 1986;
-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT 
d.dept_no,
d.dept_name,
e.emp_no,
e.first_name, 
e.last_name
FROM employees AS e
JOIN dept_manager AS dm
ON (dm.emp_no = e.emp_no)
	JOIN departments AS d
	ON (dm.dept_no = d.dept_no);

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT 
d.dept_no,
e.emp_no,
e.first_name, 
e.last_name,
d.dept_name
FROM employees AS e
JOIN dept_emp AS de
ON (de.emp_no = e.emp_no)
	JOIN departments AS d
	ON (de.dept_no = d.dept_no);

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT
first_name,
last_name,
sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.

SELECT 
e.emp_no, 
e.first_name, 
e.last_name
FROM employees AS e
JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
	JOIN departments AS d
	ON (de.dept_no = d.dept_no)
	WHERE dept_name IN ('Sales');

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT 
e.emp_no, 
e.first_name, 
e.last_name,
d.dept_name
FROM employees AS e
JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
	JOIN departments AS d
	ON (de.dept_no = d.dept_no)
	WHERE dept_name IN ('Sales', 'Development');

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT
last_name, COUNT (last_name) AS "Frequency of last names"
FROM employees
GROUP BY last_name
ORDER BY "Frequency of last names" DESC;