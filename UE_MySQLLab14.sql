-- 1. Create the following tables in your own database. (Show create table statement)
	create table urias_escudero.Cars(
	CarID	INT primary key,
    CarMake	Varchar(50),
    CarModel	Varchar(50),
    CarYear	INT,
    CarPrice INT
);

-- Create the following tables in your own database. (Show create table statement)
create table urias_escudero.CarSales(
	SalesID	INT Primary Key,
    CarID	INT,
    SalesDate	Datetime,
    SalesAmount	INT,
    Tax	INT,
    Discount INT
);

-- 2. Create a PK on both tables with Auto Increment.
ALTER TABLE `urias_escudero`.`Cars` 
CHANGE COLUMN `CarID` `CarID` INT(11) NOT NULL AUTO_INCREMENT ;

ALTER TABLE `urias_escudero`.`CarSales` 
CHANGE COLUMN `SalesID` `SalesID` INT(11) NOT NULL AUTO_INCREMENT ;

-- 3. Create a FK relationship between the 2 tables.
ALTER TABLE `urias_escudero`.`CarSales` 
ADD INDEX `CarID_idx` (`CarID` ASC) VISIBLE;
;
ALTER TABLE `urias_escudero`.`CarSales` 
ADD CONSTRAINT `CarID`
  FOREIGN KEY (`CarID`)
  REFERENCES `urias_escudero`.`Cars` (`CarID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- 4. Default SalesDate to Current Date and time when no Sales Date is given.
ALTER TABLE `urias_escudero`.`CarSales` 
CHANGE COLUMN `SalesDate` `SalesDate` DATETIME NULL DEFAULT NOW() ;

-- 5. Create an unique index on the CarYear column.
ALTER TABLE `urias_escudero`.`Cars` 
ADD UNIQUE INDEX `CarYear_UNIQUE` (`CarYear` ASC) VISIBLE;
;

-- 6. Add 10 records to both tables (Show Insert Statement)
insert urias_escudero.Cars(CarMake, CarModel, CarYear, CarPrice)
values	('Toyota', 'Supra', 2020, 90000),
	('Ford', 'FocusRS', 2016, 33000),
    ('Subaru', 'WRX', 2006, 40000),
    ('Honda', 'TypeR', 2019, 34000),
    ('Honda', 'CivicSI', 2018, 30000),
    ('Pontiac', 'Firebird', 1967, 15000),
    ('Lambhorghini', 'Murcielago', 2017, 80000),
    ('Jeep', 'Cherokee', 2004, 24000),
    ('Ford', 'Bronco', 1996, 27000),
    ('Toyota', 'Corolla', 1995, 2000);

insert urias_escudero.CarSales(CarID, SalesDate, SalesAmount, Tax, Discount)
values	(1, '2019-11-06', 100000, 8000, 4000),
	(2, '2017-01-16', 35000, 3000, 5000),
    (3, '2016-06-29', 37000, 2000, 5000),
    (4, '2020-03-15', 40000, 5000, 3500),
    (5, '2019-06-07', 27000, 4000, 2000),
    (6, '2018-07-26', 5000, 500, 500),
    (7, '2019-09-02', 77000, 10000, 15000),
    (8, '2017-04-16', 15000, 1500, 1000),
    (9, '2016-12-31', 25000, 4000, 6000),
    (10, '2019-05-22', 1500, 150, 0);
    
select * 
from urias_escudero.Cars;

select *
from urias_escudero.CarSales;

-- 7. Create a DELETE statement that produces logic to delete 2 rows from one of the tables. (show syntax)
delete from urias_escudero.CarSales
where CarID = 1;

delete from urias_escudero.CarSales
where CarID = 6;

-- 8. Create an UPDATE statement that updates at least 3 records from one of the tables.  (show syntax)
update urias_escudero.CarSales
set Tax = 3500, SalesAmount = 40000
where CarID = 2;

update urias_escudero.CarSales
set SalesAmount = 80000
where CarID = 7;

update urias_escudero.CarSales
set SalesAmount = 2000
where CarID = 10;

-- 9. Create a SELECT statement that utilizes a WHERE clause  (show syntax)
select *
from urias_escudero.Cars
where  CarMake= 'Toyota';

-- 10. Create a SELECT statement that utilizes a GROUP BY & HAVING CLAUSE  (show syntax)
select CarMake
from urias_escudero.Cars
group by CarMake
having COUNT(CarMake) > 1;

-- 11. Create a SLEECT statement that utilizes the IN Operator and has an ORDER BY.   (show syntax)
select * 
from urias_escudero.Cars
where CarMake IN ('Ford', 'Honda')
order by CarMake asc;

-- 12. Create a SELECT statement that utilizes the Like Operator and WHERE clause. (show syntax)
select *
from urias_escudero.Cars
where CarMake like 'F%';

-- 13. Create a SELECT statement that utilizes a System function in the WHERE clause. (show syntax)
select CarMake
from urias_escudero.Cars
where CarMake is not null;

-- 14. Create a Backup of the Cars table and name it Cars2
	create table urias_escudero.Cars2(
	CarID	INT primary key,
    CarMake	Varchar(50),
    CarModel	Varchar(50),
    CarYear	INT,
    CarPrice INT
);

-- 15. TRUNCATE the Cars2 table (show syntax)
truncate table urias_escudero.Cars2;

select * from urias_escudero.Cars2;

-- 16. DELETE the Cars2 table (show syntax)
drop table urias_escudero.Cars2;

select * from urias_escudero.Cars2;

-- 17. Find total Sales by Car Make (show syntax)
select round(sum(CarSales.SalesAmount), 2) as TotalSales,
	Cars.CarMake as CarMake
from Cars
inner join CarSales
on Cars.CarID = CarSales.CarID
group by CarMake;

-- 18. What are the Top 5 Car Models based on highest revenue. (show syntax)
select round(sum(CarSales.SalesAmount), 2) as Revenue,
	Cars.CarModel
from Cars
inner join CarSales
on Cars.CarID = CarSales.CarID
group by CarModel
order by Revenue desc
limit 5;

/* 19. Create a Stored Procedure that Displays the Car Make, Model and Sales Amount 
	For cars purchased lower than the Input Parameter MaxSalesAmount
   (show sp syntax and call syntax)*/

delimiter $$
create definer='root'@'localhost'
procedure proc_CarMakeModelSalesLowerThan(in MaxSalesAmount_input INT)
begin
	select Cars.CarMake as CarMake,
	Cars.CarModel as CarModel,
    sum(CarSales.SalesAmount) as Sales
from Cars
inner join CarSales
on Cars.CarID = CarSales.CarID
where Cars.CarPrice < MaxSalesAmount_input;
end $$
delimiter ;

drop procedure proc_CarMakeModelSalesLowerThan;

call proc_CarMakeModelSalesLowerThan(5000);

