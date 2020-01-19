/* 1. Create a Stored Procedure that Total Sales by Input parameter ProductSubCategory */
select *
from information_schema.columns
where column_name
like 'productsubcategory%';

select * 
from product;
-- .productsubcategoryid, .productid

select *
from productsubcategory;
-- .productsubcategoryid, .name

select *
from salesorderdetail;
-- .productid, .linetotal

select round(sum(salesorderdetail.linetotal), 2) as TotalSales,
	productsubcategory.name as ProductSubName
from product
inner join salesorderdetail
on product.productid = salesorderdetail.productid
inner join productsubcategory
on product.productsubcategoryid = productsubcategory.productsubcategoryid
group by productsubcategory.name;

delimiter $$
create definer='root'@'localhost'
procedure	proc_TotalSalesByProductSubCategory( IN ProductSubCategory_input Varchar(50))
begin
	select round(sum(salesorderdetail.linetotal), 2) as TotalSales,
	productsubcategory.name as ProductSubName
from product
inner join salesorderdetail
on product.productid = salesorderdetail.productid
inner join productsubcategory
on product.productsubcategoryid = productsubcategory.productsubcategoryid
where productsubcategory.name = ProductSubCategory_input;
end $$
delimiter ;

call proc_TotalSalesByProductSubCategory('Road Bikes');

/* 2. Create a Stored Procedure that returns Total Sales by Input Parameter Product Color.  
Data set will be filtered by Product Category Bikes and will only report on products shipped by Ground. */
select *
from information_schema.columns
where column_name
like 'productsubcategoryid%';

select *
from salesorderdetail;
-- .linetotal, .salesorderid, .productid

select *
from product;
-- .color, .productid, .productsubcategoryid

select *
from shipmethod;
-- .shipmethodid=1, 

select * 
from salesorderheader;
-- .shipmethodid, .salesorderid

select *
from productsubcategory;
-- .productsubcategoryid, .name

select round(sum(salesorderdetail.linetotal), 2),
	product.color as Color
from	salesorderdetail
inner join product
on salesorderdetail.productid = product.productid
inner join productsubcategory
on product.productsubcategoryid = productsubcategory.productsubcategoryid
inner join salesorderheader
on salesorderdetail.salesorderid = salesorderheader.salesorderid
inner join shipmethod
on salesorderheader.shipmethodid = shipmethod.shipmethodid
group by product.color;

delimiter $$
create definer='root'@'localhost'
procedure proc_TotalSalesBikesShippedGroundByProductColor(IN Color_input Varchar(50))
begin
	select round(sum(salesorderdetail.linetotal), 2) as TotalSales,
	product.color as Color
from	salesorderdetail
inner join product
on salesorderdetail.productid = product.productid
inner join productsubcategory
on product.productsubcategoryid = productsubcategory.productsubcategoryid
inner join salesorderheader
on salesorderdetail.salesorderid = salesorderheader.salesorderid
inner join shipmethod
on salesorderheader.shipmethodid = shipmethod.shipmethodid
where product.color = Color_input
group by productsubcategory.name = 'Bike';
end $$
delimiter ;

 call proc_TotalSalesBikesShippedGroundByProductColor('Black');
 
 /* Create a Stored Procedure returns a list of SalesOrderIDs that were shipped and billed to different States */
 select * 
 from information_schema.columns
 where column_name 
 like 'vendorid%';
 
select *
 from salesorderheader;
 -- .salesorderid, .bill, .ship, .shipmethodid
 
 select *
from purchaseorderheader;
-- .shipmethodid, .vendorid
 
 select *
from vendoraddress;
-- .vendorid, .addressid

select *
 from address;
 -- addressid, .stateprovinceid
 
 select *
 from stateprovince;
-- .stateprovinceid, .name

select count(salesorderheader.salesorderid) as SalesOrderId,
	count(salesorderheader.BillToAddressID and salesorderheader.ShipToAddressID) as BillandShipto,
    stateprovince.name as State
from	salesorderheader
inner join	purchaseorderheader
on salesorderheader.shipmethodid = purchaseorderheader.shipmethodid
inner join	vendoraddress
on	purchaseorderheader.vendorid = vendoraddress.vendorid
inner join address
on vendoraddress.addressid = address.addressid
inner join stateprovince
on address.stateprovinceid = stateprovince.stateprovinceid
group by stateprovince.name;

delimiter $$
create definer='root'@'localhost'
procedure proc_OrdersShippedAndBilledToDifferentStates()
begin
	select count(salesorderheader.salesorderid) as SalesOrderId,
    count(salesorderheader.BillToAddressID and salesorderheader.ShipToAddressID) as BillandShipto,
    stateprovince.name as State
from	salesorderheader
inner join	purchaseorderheader
on salesorderheader.shipmethodid = purchaseorderheader.shipmethodid
inner join	vendoraddress
on	purchaseorderheader.vendorid = vendoraddress.vendorid
inner join address
on vendoraddress.addressid = address.addressid
inner join stateprovince
on address.stateprovinceid = stateprovince.stateprovinceid
group by stateprovince.name;
end $$
delimiter ;

drop procedure proc_OrdersShippedAndBilledToDifferentStates;

call proc_OrdersShippedAndBilledToDifferentStates;

-- 4. Create a Stored Procedure that returns a count of married employees as an output parameter based on the Gender as an input. 
delimiter $$
create definer='root'@'localhost'
procedure proc_MarriedEmployeeCntOutput_ByGender(in Gender_input varchar(45), out countMarried_output int)
begin
	select count(employee.MaritalStatus) 
    into countMarried_output 
    from employee
    where Gender=Gender_input;
end$$
delimiter ;

drop procedure proc_MarriedEmployeeCntOutput_ByGender;

set @gender = 'f';
call proc_MarriedEmployeeCntOutput_ByGender(@gender, @MarriedCount);
select @marriedcount;
use adventureworks;

-- 5. Create a Stored Procedure that returns the number of credit cards as an output parameter based on the input expiration month and year.
select *
from creditcard;

delimiter $$
create definer='root'@'localhost'
procedure proc_CCexpCntOutputByMonthYear( IN ExpMonth_input INT, IN ExpYear_input INT, OUT CCcount_output int)
begin
	select count(creditcard.creditcardid)
    into CCcount_output
    from creditcard
    where ExpMonth=ExpMonth_input
    and ExpYear=ExpYear_input;
end $$
delimiter ; 

drop procedure proc_CCexpCntOutputByMonthYear;

set @ExpMonth = 1;
set @ExpYear = 2006;
call proc_CCexpCntOutputByMonthYear(@ExpMonth, @ExpYear, @CCcount);
select @CCcount;
