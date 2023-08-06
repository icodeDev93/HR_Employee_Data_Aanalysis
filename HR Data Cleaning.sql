#create database
create database projects;

#make the databse a default database
use projects;

#query data in the database
select * from hr;

#change the id column name to emp_id
alter table hr
change column ï»¿id emp_id varchar(20) null;

#query table to know see all the data
select * from hr;

#check the details of the columns in the table
describe hr;

#query the birthdate in the table
select birthdate from hr;

set sql_safe_updates = 0;

#change the birthdate format from string to date
update hr
set birthdate = case
	when birthdate like '%/%' then date_format(str_to_date(birthdate,'%m/%d/%Y'), '%Y-%m-%d') 
    when birthdate like '%-%' then date_format(str_to_date(birthdate,'%m-%d-%Y'), '%Y-%m-%d') 
    else null
end;


#change the data type of the birthdate column to date
alter table hr
modify column birthdate date;

select birthdate from hr;

#change the hire_date format from text to date
update hr
set hire_date = case
	when hire_date like '%/%' then date_format(str_to_date(hire_date,'%m/%d/%Y'), '%Y-%m-%d')
    when hire_date like '%-%' then date_format(str_to_date(hire_date, '%m-%d-%Y'),'%Y-%m-%d')
    else null
end;

select hire_date from hr;

#change the data type of hire_date from text to date
alter table hr
modify column hire_date date;

#manually set the empty termdate rows to 0000-00-00
update hr
set termdate = '0000-00-00' where termdate = '';

#above command worked but got some errors
#updated the command
update hr
set termdate = null where termdate = '0000-00-00';


#change the data type of term_date from time date to date
update hr
set termdate = date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
where termdate is not null and termdate != '' and termdate is null;

#now I need to change the value of the termdate from null to not null
update hr
set termdate = not null where termdate is null;
select termdate from hr;

set global sql_mode = '';

#make the data type of termdate date
alter table hr
modify column termdate date;

#add a column called age
alter table hr
add column age int;

#update the table to make way for the age calculation suing the timestampdiff and CURDATE functions
update hr
set age = timestampdiff(year,birthdate,CURDATE());

#query to check successful evaluation of previous command
select birthdate,age from hr;

#check the minimum and maximum age
select
	min(age) as youngest,
    max(age) as oldest
from hr;

#check the number of employees with age less than 18
select count(*) from hr where age < 18;





