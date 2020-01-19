insert into urias_escudero.menu_backuptable(ItemName, ItemType, CostToMake, Price, WeeklySales, MonthlySales, YearlySales)

select	'Big Mac','Hamburger',1.25,3.24,1015,5000,15853
union
select	'Quarter Pounder / Cheese','Hamburger',1.15,3.24,1000,4589,16095
union
select	'Half Pounder / Cheese','Hamburger',1.35,3.50,500,3500,12589
union
select	'Whopper','Hamburger',1.55,3.99,989,4253,13000
union
select	'Kobe Cheeseburger','Hamburger',2.25,5.25,350,1500,5000
union
select	'Grilled Stuffed Burrito','Burrito',.75,5.00,2000,7528,17896
union
select	'Bean Burrito','Burrito',.50,1.00,1750,7000,18853
union
select	'7 Layer Burrito','Burrito', .78,2.50,350,100,2563
union
select	'Dorrito Burrito','Burrito',.85,1.50,600,2052,9857
union
select	'Turkey and Cheese Sub','Sub Sandwich',1.75,5.50,1115,7878,16853
union
select 'Philly Cheese Steak Sub', 'Sub Sandwich',2.50,6.00,726,2785,8000
union
select	'Tuna Sub','Sub Sandwich',1.25,4.50,825,3214,13523
union
select 'Meatball Sub','Sub Sandwich',1.95,6.50,987,4023,15287
union
select	'Italian Sub','Sub Sandwich',2.25,7.00,625,1253,11111
union
select	'4 Cheese Sub','Sub Sandwich',.25,6.00,815,3000,11853

select *
from menu_backuptable

update menu_backuptable
set ItemName = '4 Cheese Sub'
where ItemName = '3 Cheese Sub';

-- 5.Change Italian Sub Monthly Sales to 1353

update menu_backuptable
set MonthlySales = 1353
where MonthlySales = 1253;

-- 6.Change Whopper price to 4.25

update menu_backuptable
set Price = 4.25
where Price = 3.99;

-- 7.Change 7 Layer Burrito price to 2.75

update menu_backuptable
SET CostToMake = 2.75
where CostToMake = .78;

-- 8. Increase Burrito prices by 10%

Update menu_backuptable
set Price = 5.50
where Price = 5.00;

update menu_backuptable
set Price = 1.10
where Price = 1.00;

update menu_backuptable
set Price = 2.75
where Price = 2.50;

update menu_backuptable
set Price = 1.65
where Price = 1.50;
-- Find better solution for this, what statement would increase entire column by given %?

-- 9. All products that bring in < 1.00 profit per purchase needs to be deleted
-- to find profit, you must subtract C2M from Price, is there a formula to enter to determine this?
select ItemName,
	abs(Price)-abs(CostToMake) as Profit
from menu_backuptable
group by ItemName
Having SUM(Profit) < 1.00;

delete
from menu_backuptable
where ItemName = '7 Layer Burrito';

delete 
from menu_backuptable
where ItemName = 'Bean Burrito';

delete
from menu_backuptable
where ItemName = 'Dorrito Burrito';

delete
from menu_backuptable
where Price - CostToMake < 1.00;

-- 10. Delete any items that didn't make more than 10k in yearlysales profit.
select *
from menu_backuptable
where	YearlySales < 10000
order by	ItemName Desc;

delete 
from menu_backuptable
where ItemName = 'Philly Cheese Steak Sub';

delete 
from menu_backuptable
where ItemName = 'Kobe Cheeseburger';

-- 11. truncate the menu.
truncate table menu_backuptable;

-- 12. Retrieve all burritos & sort by Price.
select *
from menu_backuptable
where ItemType = 'Burrito'
order by Price Desc;

-- 13. Retrieve all items that cost more than 1.00 to make and sort by WeeklySales
select *
from menu_backuptable
where CostToMake > 1.00
order by WeeklySales Desc;

-- 14. Sum of total profit by ItemType
select ItemType,
	SUM(abs(Price)-abs(CostToMake)) as Profit
from menu_backuptable
group by ItemType;

select ItemType,
SUM(Price) - SUM(CostToMake)
from menu_backuptable
group by ItemType;

-- 15. Retrieve Total Weekly Sales by ItemType of items >3000 weekly sales. Sort by Total Weekly Sales desc
select ItemType,
SUM(WeeklySales)
from menu_backuptable
group by ItemType
having SUM(WeeklySales) > 3000
order by WeeklySales desc;

-- 16. Find profit made from Weekly, Monthly, and Yearly on Big Mac. ?
select ItemType = 'Big Mac',
	SUM(abs(Price)-abs(CostToMake)) as Profit,
    SUM(Profit*WeeklySales) as TotalWeeklyProfit
from menu_backuptable
Order by WeeklySales desc; -- this didn't work but I tried to finished 

select ItemName, WeeklySales, MonthlySales, YearlySales
from menu_backuptable
group by ItemName
having ItemName = 'Big Mac'

-- 17. Retrieve the ItemType has more than 20k in monthly sales.
select ItemType
from menu_backuptable
where MonthlySales > 20000;

-- 18. Retrieve the ItemType that has the best Profit from monthly sales. ?
select *
from menu_backuptable
where MonthlySales
order by MonthlySales Desc
limit 0,1;



