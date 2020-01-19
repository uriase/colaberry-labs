select * from creditcard
select * from salesorderheader

-- 1. How many sales orders used vista credit cards in october 2002.
select 		count(CreditCard.CreditCardID), creditcard.CardType
FROM 		creditcard
inner join 	salesorderheader
on 			salesorderheader.CreditCardID = creditcard.CreditCardID
where 		cardtype like 'Vista'
and 		salesorderheader.OrderDate between '2002-10-01' and '2002-10-31';

select 		count(creditcard.CreditCardID), CreditCard.CardType
from 		salesorderheader
inner join 	creditcard
on			salesorderheader.CreditCardID = creditcard.CreditCardID
where 		creditcard.CardType like 'Vista'
and			salesorderheader.OrderDate between '2002-10-01' and '2002-10-31';

-- 2. Set 1. as a variable

select @CardTypeCount := count(CreditCard.CreditCardID), salesorderheader.SalesOrderID, salesorderheader.CreditCardID, creditcard.CardType, creditcard.CreditCardID, salesorderheader.Orderdate
FROM creditcard
inner join salesorderheader
on salesorderheader.CreditCardID = creditcard.CreditCardID
where cardtype like 'Vista'
and salesorderheader.OrderDate between '2002-10-01' and '2002-10-31';

select @CardTypeCount;

-- 3. 
set @StartDate = 20010101;
set @EndDate = 20011231;

select count(CreditCard.CreditCardID), salesorderheader.SalesOrderID, salesorderheader.CreditCardID, creditcard.CardType, creditcard.CreditCardID, salesorderheader.Orderdate
FROM creditcard
inner join salesorderheader
on salesorderheader.CreditCardID = creditcard.CreditCardID
where cardtype like 'Vista'
and salesorderheader.OrderDate between @startdate and @enddate;

select @CardTypeCount between @startdate and @enddate;
-- query above @CardTypeCount would have to delete the last line of code where it's locating time, because it would be searching it in other variables(@sd @ed)

-- 4.  
select * from salesorderheader; territory id, total due 

select * from salesterritory where salesterritory.Group = 'North America'; territoryid, group 
select Group = 'North America' from salesterritory;
select * from salesterritory where CostYTD = 0;

select * from salesterritoryhistory; territoryid, startdate, and enddate

select salesorderheader.territoryid, sum(salesorderheader.Totaldue), salesterritory.Group,
salesterritoryhistory.ModifiedDate
from salesterritory
left outer join salesterritoryhistory
on salesterritory.territoryid = salesterritoryhistory.territoryid
left outer join salesorderheader
on salesterritory.territoryid = salesorderheader.territoryid
where salesterritory.group = 'North America' and (salesterritoryhistory.ModifiedDate between '2002-01-01' and '2004-12-31');

-- 5.what is sales tax rate, stateprovincecode, and countryregionode for texas?
select * from salestaxrate ; stateprovinceID, Tax Rate
select * from stateprovince ; stateprovinceID, countryregioncode, Name

select stateprovince.name, stateprovince.stateprovinceid, salestaxrate.TaxRate, stateprovince.countryregioncode
from stateprovince
left outer join salestaxrate
on stateprovince.stateprovinceid = salestaxrate.stateprovinceid
where stateprovince.name = 'Texas';

-- 6. store 5. in a variable
select @Texas := stateprovince.name, stateprovince.stateprovinceid, salestaxrate.TaxRate, stateprovince.countryregioncode
from stateprovince
left outer join salestaxrate
on stateprovince.stateprovinceid = salestaxrate.stateprovinceid
where stateprovince.name = 'Texas';

-- 7. 
select * from product; color
select * from salesorderdetail; SalesDetails = count(salesorderdetailid), TotalSalesAmount = (unitprice * orderqty), show colors > 50000 and limit color = not null

select product.color, count(salesorderdetail.salesorderdetailid) as SalesDetails, 
					sum(salesorderdetail.unitprice * salesorderdetail.orderqty) as TotalSalesAmount
from product 
inner join  salesorderdetail
on product.productid = salesorderdetail.productid
where 'TotalSalesAmount' < 50000 and 'TotalSalesAmount' is not null
group by product.color;

delete
from product
where color is null;


-- is there a limit on null

