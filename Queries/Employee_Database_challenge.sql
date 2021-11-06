select e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
	into retirement_titles
	from employees as e 
	left outer join titles as t
	on (e.emp_no=t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	--AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	--AND (de.to_date = '9999-01-01'); really should be including this so it's only current employees
ORDER BY e.emp_no	

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title

INTO unique_titles
FROM retirement_titles
ORDER BY emp_no asc, to_date DESC;

-- retrieve the number of employees by their most recent job title who are about to retire
select count(title), title
INTO retiring_titles
from unique_titles
group by title
order by count(title) desc;

-- Employees eligable to participate in mentorship program
select distinct on (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name, 
	e.birth_date,
	d.from_date,
	d.to_date,
	t.title
into mentorship_eligibility
from ((employees as e
inner join dept_employee as d on e.emp_no = d.emp_no)
inner join titles as t on e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (d.to_date = '9999-01-01')
Order by emp_no asc;

drop table mentorship_eligibility

select * from mentorship_eligibility

