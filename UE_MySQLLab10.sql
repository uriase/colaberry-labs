-- 1. Find Total Sales by Credit Card Type
find sales, creditcardtype 
-- salesorderheader & salesorderdetail multiple links, CreditCardID 

select creditcard.cardtype, SUM(salesorderheader.totaldue) as TotalSales
from creditcard
inner join salesorderheader
on creditcard.creditcardid = salesorderheader.creditcardid
group by creditcard.cardtype;

-- 2. Find Total Sales by Product
select * 
from information_schema.columns
where column_name 
like 'sale%';
-- salesorderheader.salesorderid, product.productid, salesorderdetail.productid, product.name 

select * 
from product;

select * 
from information_schema.columns
where column_name 
like 'productcategoryid%';

select product.name as Product, SUM(salesorderheader.totaldue)as TotalSales
from salesorderdetail
left outer join product
on salesorderdetail.productid = product.productid
left outer join salesorderheader 
on salesorderdetail.salesorderid = salesorderheader.salesorderid
group by product.name;

-- 3. Find total sales by Ship State
select *
from information_schema.columns
where column_name
like 'ship%';

select *
from shipmethod;

select *
from salesorderheader;

select *
from information_schema.columns
where column_name
like 'state%';

select *
from stateprovince;

-- salesorderheader.totaldue + .territoryid +.shipmethodid, 
-- stateprovince.territoryid + .stateprovincecode, shipmethod.shipmethodid +.name

select 
	SUM(salesorderheader.totaldue) TotalSales,
    stateprovince.stateprovincecode as State,
    shipmethod.name as Method
from salesorderheader
left outer join stateprovince
on salesorderheader.territoryid = stateprovince.TerritoryID
left outer join shipmethod
on salesorderheader.shipmethodid = shipmethod.shipmethodid
group by stateprovince.StateProvinceCode;

-- 4 Find total sales by Territory Group
select *
from information_schema.columns
where column_name
like 'Territory%';

select *
from salesterritory;

-- salesorderheader.totaldue + .territoryid, salesterritory.territoryid +.name
select 
	(salesorderheader.totaldue) as TotalSales,
    salesterritory.name as TerritoryGroup
from salesorderheader
left outer join salesterritory
on salesorderheader.territoryid = salesterritory.territoryid
group by salesterritory.name;

-- 5 Find Total Sales by Ship Method
select 
	SUM(salesorderheader.totaldue) as TotalSales,
    shipmethod.name as Method
from salesorderheader
inner join shipmethod
on salesorderheader.shipmethodid = shipmethod.shipmethodid
group by shipmethod.name;

select *
from shipmethod;
select * 
from salesorderheader;

-- 6. Find total sales by product subcategory.
select sum(salesorderdetail.linetotal) as TotalSales,
    productsubcategory.name as SubCategoryName
from salesorderdetail
inner join product
on salesorderdetail.productid = product.productid
inner join productsubcategory
on product.productsubcategoryid = productsubcategory.ProductSubcategoryID
group by productsubcategory.name;

-- 7. How many emp are in the Research and Development Department
select *
from information_schema.columns
where column_name
like 'emp%';

-- employee.employeeid, employeeddepartmenthistory.departmentid + .employeeid, department.groupname + departmentid
select *
from employeedepartmenthistory;

select *
from department;

select
	count(employee.employeeID)TotalEmployees,
    employeedepartmenthistory.departmentid as DeptID,
    department.groupname as Name
from employeedepartmenthistory
left outer join employee
on employeedepartmenthistory.employeeid = employee.employeeID
left outer join department
on employeedepartmenthistory.departmentid = department.departmentid
group by department.groupname
order by employeedepartmenthistory.departmentid asc
limit 1;

-- 8. How many employees are in each Department and Department Group
select
	count(employee.employeeID)TotalEmployees,
    employeedepartmenthistory.departmentid as DeptID,
    department.name as DeptName,
    department.groupname as DeptGroup
from employeedepartmenthistory
left outer join employee
on employeedepartmenthistory.employeeid = employee.employeeID
left outer join department
on employeedepartmenthistory.departmentid = department.departmentid
group by department.name
order by department.name asc;

-- 9. Find Total Sales by each product colour
select *
from information_schema.columns
where column_name
like '%color%';
-- product.color + .productid, salesorderdetail.productid +.linetotal
select *
from salesorderdetail;

select 
	product.color as Color,
	sum(salesorderdetail.linetotal) as TotalSales
from product 
left outer join salesorderdetail
on product.productid = salesorderdetail.productid
group by product.color;

-- 10. find managers loginid for employeeid 8
select *
from information_schema.columns
where column_name
like 'emp%';

select managerid
from employee 
where employeeid = 8;

-- 11. single females in QA department group.
select *
from information_schema.columns
where column_name
like 'department%';
-- employee.gender + .employeeid + .maritalstatus, employeedepartmenthistory.employeeid + .departmentid, department.departmentid + .groupname
select *
from department;
select *
from employeedepartmenthistory;
select *
from employee;

select
	employee.gender as Gender,
    employee.maritalstatus as MStatus,
    count(employeedepartmenthistory.employeeid) as EmpID,
    department.groupname as DeptGroup
from employeedepartmenthistory
left outer join employee
on employeedepartmenthistory.employeeid = employee.employeeid
left outer join department
on employeedepartmenthistory.departmentid = department.departmentid
where department.groupname = 'Quality Assurance' 
and employee.gender = 'F' 
and employee.maritalstatus = 'S';

-- like 'Quality Assurance' order by employee.gender = 'F' desc, employee.maritalstatus = 'S' desc limit 1; was other alternative

-- is there a way to limit by text?

-- 12. How many employees work each work shift?
select *
from information_schema.columns
where column_name
like 'shiftid%';

select *
from employee;
select *
from shift;
select *
from employeedepartmenthistory;

-- employeedepartmenthistory.shiftid +.employeeid, shift.shiftid + .name, employee.employeeid

select 
	count(employee.employeeid) as TotalEmployee, 
	employeedepartmenthistory.shiftid,
    shift.name
from employeedepartmenthistory
left outer join shift
on employeedepartmenthistory.shiftid = shift.shiftid
left outer join employee
on employeedepartmenthistory.employeeid = employee.employeeid
group by shift.name;

-- 13. Find total sales by country region code
select stateprovince.countryregioncode,
	round(salesorderheader.totaldue,2) as TotalSales
from stateprovince 
inner join salesorderheader
on stateprovince.territoryid = salesorderheader.territoryid
group by countryregioncode;

-- 14. find total sales from billed states with an A in the name.
select
	sum(salesorderheader.totaldue),
    stateprovince.name
from salesorderheader
inner join stateprovince
on salesorderheader.territoryid = stateprovince.territoryid
group by stateprovince.name
like '%a%';

-- 15. find all product category and their total rejected qty
select *
from information_schema.columns
where column_name
like 'productid';

select *
from purchaseorderdetail;
select *
from product;
select *
from productsubcategory;
select *
from productcategory;

-- purchaseorderdetail.rejectedqty + .productid, 
-- productcategory.productcategoryid + .name, 
-- product.productid + .productsubcategoryid, 
-- productsubcategory.productcategoryid + .productsubcategoryid

select product.productid,
	productcategory.name,
	sum(purchaseorderdetail.rejectedqty) as TotalRjct,
    productsubcategory.productcategoryid
from product
inner join purchaseorderdetail
on product.productid = purchaseorderdetail.productid
inner join productsubcategory
on product.productsubcategoryid = productsubcategory.productsubcategoryid
inner join productcategory
on productsubcategory.productcategoryid = productcategory.productcategoryid
group by productcategory.name;

	

