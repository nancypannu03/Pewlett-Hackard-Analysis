# Pewlett-Hackard-Analysis
## Overview of the analysis:
## Purpose 
This analysis will help future-proof Pewlett Hackard by generating a list of all employees eligible for the retirement package and we will be assisting Bobby in performing employee search on the basis of the two questions:

    - Who will be retiring in the next few years? 
    - And how many positions will Pewlett Hackard need to fill?
   
- Furthermore, we will be building an employee database with SQL by applying your data modeling, engineering, and analysis skills.
- To help Bobby prepare for his analysis, he'll need to download his tools: 
     - PostgreSQL - to create a database.
     - pgAdmin - to work with the data he'll be importing.

## Results

### Code

[Employee_Database_challenge sql file](Queries/Employee_Database_challenge.sql)

[Retirement_titles csv](Data/retirement_titles.csv)

[Unique_titles csv](Data/unique_titles.csv)

[Retiring_titles csv](Data/retiring_titles.csv)

[Mentorship_eligibilty csv](Data/mentorship_eligibilty.csv)

#### Deliverable 1: The Number of Retiring Employees by Title
-- Creating employees and titles tables and imporitng the csv files 

      CREATE TABLE employees 
      (
      emp_no INT NOT NULL,
      birth_date DATE NOT NULL,
      first_name VARCHAR NOT NULL,
      last_name VARCHAR NOT NULL,
      gender VARCHAR NOT NULL,
      hire_date DATE NOT NULL,
      PRIMARY KEY (emp_no)
      );
      select * from employees;
	 
      CREATE TABLE titles
      (
      emp_no INT NOT NULL,
      title VARCHAR NOT NULL,
      from_date DATE NOT NULL,
      to_date DATE NOT NULL
      );
      Select * from titles;

-- The Number of Retiring Employees by Title

       SELECT e.emp_no,
         e.first_name,
         e.last_name,
         t.title,
         t.from_date,
         t.to_date
      INTO retirement_titles
      FROM employees as e
      INNER JOIN titles as t
      ON (e.emp_no = t.emp_no)
      WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
      order by e.emp_no;
      SELECT * from retirement_titles;

      SELECT COUNT(title), title
      INTO retiring_titles
      FROM unique_titles
      GROUP BY title
      ORDER BY COUNT(title) DESC;

      SELECT * from retiring_titles;
      

![Test Image](/Resources/unique_titles.png)


![Test Image](/Resources/retiring_titles.png)

#### Deliverable 2: The Employees Eligible for the Mentorship Program

-- Create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program

      SELECT DISTINCT ON(e.emp_no) e.emp_no,
      e.first_name,
      e.last_name, 
      e.birth_date,
      de.from_date,
      de.to_date,
      t.title
	   
      INTO mentorship_eligibilty
      FROM employees AS e
      LEFT JOIN department_employee as de
      ON e.emp_no = de.emp_no
      LEFT JOIN titles AS t
      ON e.emp_no = t.emp_no
      WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
      AND (de.to_date = '9999-01-01')
      ORDER BY e.emp_no;

      Select * from mentorship_eligibilty;

![Test Image](/Resources/mentorship_eligibilty.png)

- Four major points from the two analysis deliverables. 
     - From the Image [Retiring_titles](Resources/retiring_titles.png), it can be concluded that total of 72,458 employees are eligible for retirement.
     - And out of which 50,842 are the Senior Engineers and Senior Staff, which covers 70% of the total retired employees.
     - Manager position holds the lowest share of employees who are eligible for the retirement.
     - [Mentorship_eligibilty](Resources/mentorship_eligibilty.png) Image represesnts all the details including emp_no, first_name, last_name, birth_date,                  from_date, to_date, title of the respective employees who are eligible to participate in a mentorship program.
     


## Summary:

- How many roles will need to be filled as the "silver tsunami" begins to make an impact?

     Based on the findings, around 72,458 roles will need to be filled by Pewlett Hackard as the "silver tsunami" begins to amke an impact.
   
- Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?

     No, According to the Analysis, we just have 1549 employees who are eligible for mentorship. This number is way more lower than the amount of retiring                employees. 

![Test Image](/Resources/mentor_employees.png)
