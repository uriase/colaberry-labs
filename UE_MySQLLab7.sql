select length('Urias')
select length('Amy')

select left('Urias', 1)
select left ('Amy', 1)

select right('Urias', 5)
select right('Amy', 3)

select substring('Urias', 1,3)
select substring('Amy', 1,2)

select locate ('-','urias-escudero')
select locate ('-','amy-rocha')

select ltrim ('     urias')
select ltrim ('     amy')

select rtrim ('urias       ')
select rtrim ('amy         ')

select Datediff ('2016-10-05', '2016-06-05')
select datediff ('2001-11-06', '2001-02-22')

select date_add('2001-02-22', interval 1 day)
select date_add('1995-11-06', interval 1935 day)

select isnull('ItemID')
select isnull('CostToMake')

-- 2. find the 3rd -5th letters in 'MySQL Learning'
select substring('MySQL Learning', 3,5)

-- 3. find the last 4 characters in 'MySQL Learning'
select right('MySQL Learning', 4)

-- 4. What statement would you use to remove all rows from a table?
delete from where 

-- 5. Find number of days between jan 1st and june 5th in current year?
select datediff('2019-06-05', '2019-01-01')

-- 6. add 2 monmths to todays date.
select date_add('2019-11-14', interval 60 day)

-- 7. Find position of 1st occurance of the letter E in string 'Not Offered'
select locate('e', 'Not Offered')
