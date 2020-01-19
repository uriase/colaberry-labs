-- 1. Create SP that returns all single female employees.
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `proc_FemaleEmployees`()
BEGIN
select *
-- or select creditcard.maritalstatus, creditcard.gender
from employee;
END$$
DELIMITER ;

CALL `adventureworks`.`proc_FemaleEmployees`();

-- 2. Create SP that returns all credit card information.
select *
from information_schema.columns
where column_name
like 'creditcard%';

select * from creditcard;

DELIMITER $$
CREATE DEFINER='root'@'localhost'
Procedure Proc_CCNumbersExpMonthYear()
begin
select *
from creditcard;
END$$
Delimiter ;

Call Proc_CCNumbersExpMonthYear();

-- 3. Create SP that returns the total revenue for Bike and Accessories Product Category.
select *
from information_schema.columns
where column_name
like 'productsubcategoryid%';

select*
from productcategory;
-- productcategoryid

select *
from productsubcategory;
-- productsubcategoryid, productcategoryid

select * from salesorderdetail;
-- round(sum(salesorderdetail.linetotal),2) , productid

select * from product;
-- productsubcategoryid, productid

select round(sum(salesorderdetail.linetotal),2) as Revenue
from salesorderdetail
inner join product 
on salesorderdetail.productid = product.productid
inner join productsubcategory
on product.productsubcategoryid = productsubcategory.productsubcategoryid
inner join productcategory
on productsubcategory.productcategoryid = productcategory.productcategoryid
group by productcategory.name = 'Bike' and 'Accessories';


delimiter $$
create definer= 'root'@'localhost'
procedure proc_BikesandAccessRevenues()
begin
select round(sum(salesorderdetail.linetotal),2) as Revenue
from salesorderdetail
inner join product 
on salesorderdetail.productid = product.productid
inner join productsubcategory
on product.productsubcategoryid = productsubcategory.productsubcategoryid
inner join productcategory
on productsubcategory.productcategoryid = productcategory.productcategoryid
group by productcategory.name = 'Bike' and 'Accessories';
end$$
delimiter ;

call proc_BikesandAccessRevenues;

-- 4. Create a Stored Procedure that returns a count of married employees based on the Gender as an input.
select *
from information_schema.columns
where column_name
like 'Gender%';

select * from employee;

delimiter $$
create definer='root'@'localhost'
procedure	proc_MarriedEmployeeCnt_ByGender( in Gender_Input Varchar(50))
begin
	select count(employee.MaritalStatus)
    from adventureworks.employee
    where Gender = Gender_Input and MaritalStatus = 'M';
end $$
delimiter ; 
    
call proc_MarriedEmployeeCnt_ByGender('M');

-- 5. Create a Stored Procedure that returns the number of credit cards that expire based on the input expiration month and year.
select *
from creditcard;

delimiter $$
create definer='root'@'localhost'
procedure	proc_CCexpCntByMonthYear(in ExpMonth_input Varchar(50), in ExpYear_input INT)
begin
	select count(creditcard.creditcardid)
    from creditcard
    where ExpMonth = ExpMonth_Input 
    and
	ExpYear = ExpYear_input;
end $$
delimiter ;

call proc_CCexpCntByMonthYear(11,2006);

-- 6. Create a Stored Procedure that returns Total sales by Territory based on the Input parameter Territory Group.
select *
from information_schema.columns
where column_name
like 'salesorderid%';

select *
from salesorderdetail;
-- round(sum(salesorderdetail.linetotal), 2) , .salesorderid

select *
from salesorderheader; 
-- .salesorderid, .territoryid

select * 
from salesterritory;
-- .territoryid, .group

select round(sum(salesorderdetail.linetotal), 2) as TotalSales,
	salesterritory.group as TerGroup
from salesorderheader
inner join salesterritory
on salesorderheader.territoryid = salesterritory.territoryid
inner join salesorderdetail
on salesorderheader.salesorderid = salesorderdetail.salesorderid
where TerGroup = TerritoryGroup_input;

delimiter $$
create definer='root'@'localhost'
procedure proc_SalesByTerritory_InputTerritoryGroup(IN TerritoryGroup_input Varchar(50))
begin
	select round(sum(salesorderdetail.linetotal), 2) as TotalSales,
	salesterritory.group as TerGroup
from salesorderheader
inner join salesterritory
on salesorderheader.territoryid = salesterritory.territoryid
inner join salesorderdetail
on salesorderheader.salesorderid = salesorderdetail.salesorderid
where salesterritory.group = TerritoryGroup_input;
end $$
delimiter ;

drop procedure proc_SalesByTerritory_InputTerritoryGroup;

call proc_SalesByTerritory_InputTerritoryGroup('Europe');

/* 7. Create a Stored Procedure that returns a count of employees in the Department Group input parameter.  
The user will also have an option to supply the Gender and Marital Status. */
count(employee.employeeid);

select * 
from information_schema.columns
where column_name
like 'employeeid%';

select *
from department;
-- .departmentid, .groupname

select*
from employeedepartmenthistory;
-- .employeeid, .departmentid

select *
from employee;
-- .employeeid, .maritalstatus, .gender

select count(employee.employeeid) as CountEmp,
	department.groupname as DeptGroup,
    employee.gender as Gender,
    employee.MaritalStatus as MS
from employeedepartmenthistory
inner join employee
on employeedepartmenthistory.employeeid = employee.employeeid
inner join department
on employeedepartmenthistory.departmentid = department.departmentid
group by DeptGroup;

delimiter $$
create definer='root'@'localhost'
procedure proc_EmpCntByDeptGroup( IN DeptGroup_input Varchar(50), IN Gender_input Varchar(50), IN MaritalStatus_input Varchar(50))
begin
	select count(employee.employeeid) as CountEmp,
	department.groupname as DeptGroup,
    employee.gender as Gender,
    employee.MaritalStatus as MS
from employeedepartmenthistory
inner join employee
on employeedepartmenthistory.employeeid = employee.employeeid
inner join department
on employeedepartmenthistory.departmentid = department.departmentid
where department.groupname = DeptGroup_input
and employee.gender = Gender_input
and employee.MaritalStatus = MaritalStatus_input;
End $$
delimiter ;

call proc_EmpCntByDeptGroup('Sales and Marketing', 'F', 'M');

/* 8. Create a Stored Procedure that returns the Total Sales by the Credit Card Type Input Parameter.  
The user will also have Input parameters for Territory and Ship Method. */
select *
from information_schema.columns
where column_name
like 'linetotal%';

select *
from creditcard;
-- creditcardid, cardtype

select * 
from salesorderheader;
-- .shipmethodid, .creditcardid, .territoryid, salesorderid

select * 
from shipmethod;
-- .shipmethodid, .name

select *
from salesterritory;
-- .territoryid, .name 

select *
from salesorderdetail;
-- .linetotal, salesorderid

select creditcard.cardtype as CardType,
	round(sum(salesorderdetail.linetotal), 2) as TotalSales,
	shipmethod.name ShipMethod,
    salesterritory.name as Territory
from	salesorderheader
inner join	creditcard
on	salesorderheader.creditcardid = creditcard.creditcardid
inner join	shipmethod
on	salesorderheader.shipmethodid = shipmethod.shipmethodid
inner join	salesterritory
on	salesorderheader.territoryid = salesterritory.territoryid
inner join	salesorderdetail
on	salesorderheader.salesorderid = salesorderdetail.salesorderid
group by creditcard.cardtype;

delimiter $$
create definer='root'@'localhost'
procedure proc_TotalSalesByCcTypeTerritoryShipMethod(IN CreditCardType_input Varchar(50), in Territory_input Varchar(50), in ShipMethod_input Varchar(50))
begin
	select creditcard.cardtype as CardType,
	round(sum(salesorderdetail.linetotal), 2) as TotalSales,
	shipmethod.name ShipMethod,
    salesterritory.name as Territory
from	salesorderheader
inner join	creditcard
on	salesorderheader.creditcardid = creditcard.creditcardid
inner join	shipmethod
on	salesorderheader.shipmethodid = shipmethod.shipmethodid
inner join	salesterritory
on	salesorderheader.territoryid = salesterritory.territoryid
inner join	salesorderdetail
on	salesorderheader.salesorderid = salesorderdetail.salesorderid
	where creditcard.cardtype = CreditCardType_input
    and	salesterritory.name = Territory_input
    and shipmethod.name = ShipMethod_input;
end $$
delimiter ; 

call proc_TotalSalesByCcTypeTerritoryShipMethod('Vista', 'Central', 'CARGO TRANSPORT 5');

/* 9. Create a Stored Procedure that returns Total sales for Input Parameter State.  
Total sales will be displayed for orders shipped or billed to the Input State.*/
select *
from information_schema.columns
where column_name
like 'state%';

select *
from salesorderdetail;
-- .linetotal, salesorderid

select *
from stateprovince;
--  .stateprovinceid, .name, territoryid(?)

select *
from salesorderheader;
-- .territoryid, .salesorderid

select round(sum(salesorderdetail.linetotal), 2) as TotalSales,
	stateprovince.name as State
from	salesorderheader
inner join	salesorderdetail
on salesorderheader.salesorderid = salesorderdetail.salesorderid
inner join stateprovince
on salesorderheader.territoryid = stateprovince.territoryid
group by stateprovince.name
order by stateprovince.name asc;

delimiter $$
create definer='root'@'localhost'
procedure	proc_SalesByShipOrBillState(IN State_input Varchar(50))
begin
	select round(sum(salesorderdetail.linetotal), 2) as TotalSales,
	stateprovince.name as State
from	salesorderheader
inner join	salesorderdetail
on salesorderheader.salesorderid = salesorderdetail.salesorderid
inner join stateprovince
on salesorderheader.territoryid = stateprovince.territoryid
where stateprovince.name = State_input;
end $$
delimiter ;

call proc_SalesByShipOrBillState('Alabama');

	
