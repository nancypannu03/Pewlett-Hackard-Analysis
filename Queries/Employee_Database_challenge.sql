--The Number of Retiring Employees by Title
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


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles as r
WHERE (r.to_date ='9999-01-01')
ORDER BY emp_no ASC, title DESC;
Select * from unique_titles;

-- retrieve the number of employees by their most recent job title  who are about to retire.
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

SELECT * from retiring_titles;

--create a Mentorship Eligibility table that holds the employees who are eligible to participate in a mentorship program
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

