-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/QacJP3
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" varchar(5)   NOT NULL,
    "dept_name" varchar(20)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" varchar(10)   NOT NULL,
    "dept_no" varchar(5)   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar(5)   NOT NULL,
    "emp_no" varchar(10)   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" varchar(10)   NOT NULL,
    "emp_title" varchar(10)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(20)   NOT NULL,
    "last_name" varchar(20)   NOT NULL,
    "sex" char   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" varchar(10)   NOT NULL,
    "salary" varchar(10)   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" varchar(10)   NOT NULL,
    "title" varchar(20)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title" FOREIGN KEY("emp_title")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");


SELECT
	*
FROM
	employees;

-- Question 1
SELECT
	e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM
	employees as e
	JOIN salaries as s on e.emp_no = s.emp_no
ORDER BY 
	e.emp_no ASC;


SELECT *
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

-- Question 2
SELECT
	first_name, last_name, hire_date
FROM 
	employees
WHERE
	EXTRACT(YEAR FROM hire_date) = 1986
ORDER BY 
	hire_date ASC;

-- Question 3
SELECT 
	d.dept_no, d.dept_name,
	dm.emp_no,
	e.last_name, e.first_name
FROM
	departments as d
	JOIN dept_manager as dm on d.dept_no = dm.dept_no
	JOIN employees as e on dm.emp_no = e.emp_no;

-- Question 4
SELECT
	d.dept_no, 
	de.emp_no, 
	e.last_name, e.first_name, 
	d.dept_name
FROM
	departments as d
	JOIN dept_emp as de on d.dept_no = de.dept_no
	JOIN employees as e on de.emp_no = e.emp_no;

-- Question 5
SELECT
	first_name, last_name, sex 
FROM
	employees
WHERE
	first_name like 'Hercules' and last_name like 'B%';

-- Question 6
SELECT
	e.emp_no, e.last_name, e.first_name
FROM
	employees as e
	JOIN dept_emp as de on e.emp_no = de.emp_no
	JOIN departments as d on de.dept_no = d.dept_no
WHERE
	d.dept_name = 'Sales';


-- Question 7
SELECT
	e.emp_no, e.last_name, e.first_name, d.dept_name
FROM
	employees as e
	JOIN dept_emp as de on e.emp_no = de.emp_no
	JOIN departments as d on de.dept_no = d.dept_no
WHERE
	d.dept_name = 'Sales' OR d.dept_name = 'Development';

-- Question 8
SELECT
	last_name, COUNT(last_name)
FROM
	employees
GROUP BY
	last_name
ORDER BY 
	COUNT(last_name) DESC;