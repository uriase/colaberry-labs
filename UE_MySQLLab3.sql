-- write two SELECT statements for the following operators =, <>, >, <, IN, NOT IN, LIKE, NOT LIKE, BETWEEN, NOT BETWEEN.
select *
from employee
where employeeID = 1
or employeeID = 2

select *
from employee
where employeeID = 3
or employeeID = 4

select *
from transactionhistory
where Quantity <> 1
and Quantity <> 2

select *
from transactionhistory
where Quantity <> 3
and Quantity <> 4

select *
from currencyrate
where AverageRate > 2
and AverageRate > 2.1

select *
from currencyrate
where AverageRate > 500
and AverageRate > 500.5

select *
from customeraddress
where AddressTypeID < 4
or AddressTypeID < 2

select *
from customeraddress
where AddressID < 900
and AddressID < 800

select *
from creditcard
where ExpMonth in (3, 5)
or ExpMonth in (6, 7)

select *
from creditcard
where ExpYear in (2005, 2006)
or ExpYear in (2007, 2008)

select *
from customer
where TerritoryID not in (1, 4)
and TerritoryID not in (2, 3)

select *
from customer
where TerritoryID not in (4, 5)
and TerritoryID not in (9, 10)

select *
from employee
where Title like 'M%'
and Title like '%T'

select *
from employee 
where Gender like 'M%'
and MaritalStatus like 'S%'

select *
from employeepayhistory
where PayFrequency not like '2%'
and EmployeeID not like '1%'

select *
from productmodel 
where Name not like 'LL%'
and Name not like 'HL%'

select *
from vendor
where CreditRating between 1 and 2 
or CreditRating between 4 and 5

select *
from transactionhistory
where Quantity between 2 and 3
or Quantity between 4 and 6

select *
from store
where SalesPersonID not between 289 and 290
and SalesPersonID not between 275 and 277

select *
from stateprovince
where TerritoryID not between 1 and 2
and TerritoryID not between 6 and 7

-- Insert 10 more records into tables

insert into players
values (1, 'Running Back', 22, '2016/01/01')

insert into coaches
values (1, 'John Starks', 'Running Back Coach', '2016/01/01')

insert into players
values (2, 'Lineback', 39, '2019/02/01'),
		(3, 'Quarterback', 27, '2019/02/01'),
        (4, 'Safeties', 41, '2018/06/01'),
        (5, 'DefensiveLine', 29, '2017/02/25'),
        (6, 'WideReceiver', 07, '2019/02/25'),
        (7, 'Quarterback', 01, '2016/06/01'),
        (8, 'Safetie', 66, '2018/04/01'),
        (9, 'Linebacker', 21, '2016/06/01'),
        (10, 'Runningback', 80, '2018/02/01');
        
insert into coaches
values (2, 'Fallon Kern', 'Lineback Coach', '2018/06/01'),
		(3, 'Karl Marx', 'Safeties Coach', '2017/02/01'),
        (4, 'Jacobs Willianson', 'WideReceiver Coach', '2017/06/01'),
        (5, 'Steph Curry', 'Quarterback Coach', '2019/02/01'),
        (6, 'Samuel Grant', 'DefensiveLine Coach', '2018/06/01'),
        (7, 'Jesus Gardner', 'RunningBack Coach', '2016/02/01'),
        (8, 'Fernando Chon', 'Safeties Coach', '2016/06/01'),
        (9, 'Javier Hernandez', 'WideReceiver Coach', '2019/06/01'),
        (10, 'Messi Arpego', 'Quarterback Coach', '2017/07/01');
        
select *
from players
where JerseyNumber between 20 and 29 ;

select *
from coaches
where CoachID < 5;

select *
from players
where StartDate	> '2019/01/01';

select *
from coaches 
where StartDate like '2018%';

select *
from players
where PlayerID > 5;

select *
from players
where Position = 'RunningBack';

select *
from coaches
where CoachType = 'Quarterback Coach';



