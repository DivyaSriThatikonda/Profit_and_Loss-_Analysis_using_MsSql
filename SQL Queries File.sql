create database case_study_14;

select * from product;

select * from fact;
select * from location;
/*
1. Display the number of states present in the LocationTable.
2. How many products are of regular type?
3. How much spending has been done on marketing of product ID 1?
4. What is the minimum sales of a product?
5. Display the max Cost of Good Sold (COGS). 
. */
--1. Display the number of states present in the LocationTable.

select count(distinct state) as no_of_states from location;

--2. How many products are of regular type?

select * from product;

select count(product) as product_of_regular  from product where type='Regular';

--3. How much spending has been done on marketing of product ID 1?

select sum(marketing) as total_marketing from fact
where productid=1;

--4. What is the minimum sales of a product?

select min(sales) as min_sales from fact;

--5. Display the max Cost of Good Sold (COGS).

select max(COGS) as max_cost from fact;

--6. Display the details of the product where product type is coffee.

select * from product 
where product_type='coffee'

--7. Display the details where total expenses are greater than 40. 

select * from fact
where Total_Expenses>40 order by Total_Expenses;

--8. What is the average sales in area code 719?

select avg(sales) as avg_sales from fact
where Area_Code=719;

--9. Find out the total profit generated by Colorado state

select sum(f.profit) as colorado_profit from fact f
inner join  location l on f.area_code= l.area_code 
where state='colorado';

--10. Display the average inventory for each product ID

select ProductId,avg(inventory) as avg_inventory from fact
group by ProductId
order by ProductId ;

--11. Display state in a sequential order in a Location Table. 

select distinct state from location 
order by state ;


---12. Display the average budget of the Product where the average budgetmargin should be greater than 100.

select productId,avg(budget_margin) as avg_margin from fact
group by productid 
having avg(budget_margin)>100;

--13. What is the total sales done on date 2010-01-01?

select sum(sales) as total_sales  from fact 
where date='2010-01-01';

--14. Display the average total expense of each product ID on an individual date.

select productid, date, avg(total_expenses) as avg_expenses from fact 
group by productid,date
order by productid  desc;

--15. Display the table with the following attributes such as date, productID, product_type, product, sales, profit, state, area_code.

select date, fact.productID, product_type, product, sales, profit, state, location.area_code
from fact
inner join location on fact.area_code=location.area_code
inner join product on product.productid=fact.productid;


--16. Display the rank without any gap to show the sales wise rank.

select * ,
dense_rank() over(order by sales desc) as sales_rnk
from fact 


--17. Find the state wise profit and sales.

select state, sum(profit) as sum_of_profit, sum(sales) as sum_of_sales
from fact f
inner join location l on f.Area_Code=l.Area_Code
group by state
order by state;


--18. Find the state wise profit and sales along with the productname. 

select state,product, sum(profit) as sum_of_profit, sum(sales) as sum_of_sales
from fact f
inner join location l on f.Area_Code=l.Area_Code
inner join product p on p.productid=f.productid
group by state,Product;


----19. If there is an increase in sales of 5%, calculate the increasedsales. 

select sales,(sales*1.05) as increased_sales from fact;


---20. Find the maximum profit along with the product ID and producttype.

select max(profit f) ,productid p,product_type p from fact 

select * from fact;
--21. Create a stored procedure to fetch the result according to the product t

create procedure product_type @prod_type varchar(30)
as
select *  from product where product_type= @prod_type

exec product_type @prod_type='tea';

--22. Write a query by creating a condition in which if the total expenses is lessthan60 then it is a profit or else loss.

select total_expenses, IIF(total_expenses<60,'profit','loss') as status from fact;

---23. Give the total weekly(total sales) sales value with the date and product IDdetails.
--Useroll-up to pull the data in hierarchical order.

select date ,productid,
sum(sales) as total_sales from fact 
group by date ,productid 
with rollup
--24. Apply union and intersection operator on the tables which consist of attribute area code
--union
select Area_Code from fact
UNION
select  Area_Code from location;
--Intersection
select  t1.Area_Code from fact t1
inner join
location t2 on  t1.Area_Code = t2.Area_Code;

--25. Create a user-defined function for the product table to fetch a particular
--product type based upon the user�s preference.
-- Create the function
create function dbo.GetProductsByType
(
    @userProductType nvarchar(255) 
)
returns table
as
return (
    select productid, product_type, product
    from product
    where product_type = @userProductType
);


declare @desiredProductType nvarchar(255) = 'Tea';

select productid, product_type, product
from dbo.GetProductsByType(@desiredProductType);

---26. Change the product type from coffee to tea where product IDis 1 and undoit.
select * from product

begin transaction; 

update product
set Product_Type = 'Tea'
where Productid = 1;

commit;

begin trasaction; 

update product
set Product_Type = 'Coffee'
where Productid = 1;

rollback; 


---27. Display the date, product ID and sales where total expenses are
--between 100 to 200
select * from fact;
select * from product;
select * from location;

select f.date,p.productid,f.total_expenses
from fact f
join product p on f.productid=p.productid
where total_expenses between 100 and 200;

--28. Delete the records in the Product Table for regular type.

delete from product
where Type = 'Regular';


--29. Display the ASCII value of the fifth character from the column Product.

select  ascii(substring(Product, 5, 1)) as ASCII_Value
from product;
