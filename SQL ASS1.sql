use classicmodels;

-- 1. Find the customers whose “state” code is not filled and display only their full name and contact number

select concat(contactlastname, contactfirstname) as Fullname, phone from customers
where state is null;

-- 2. Find the product names for each of the orders in “Orderdetails” table

select productcode, productname from products
where productcode in 
(
   select productcode from orderdetails
   );
   
-- 3. Using the “Payments” table, find out the total amount spent by each customer ID

select customerNumber as customer_id, sum(amount) as Total_amount
from payments
group by customernumber;   

-- 4. Find out the number of customers from each country

select country, count(customernumber) as 'Number of Customers'
from customers
group by country;

-- 5. Find out the amount of sales driven by each sales representative

select c.salesRepEmployeeNumber as Emp_id,
	   concat(e.firstname,' ',e.lastname) as Sales_Rep,
       sum(p.amount) as Sales
from customers c
join employees e on c.salesRepEmployeeNumber = e.employeeNumber
join payments p on c.customernumber = p. customernumber
group by sales_rep;

-- 6. Find out the total number of quantity ordered per each order

select ordernumber, sum(quantityordered) as Total_quantity
from orderdetails
group by ordernumber;

-- 7. Find out the total number of quantity ordered per each product ID

select productcode, sum(quantityOrdered) as Total_Quantity
from orderdetails
group by productcode;

-- 8. Find out the total number of orders made where the order value is over 7000 INR

select count(ordernumber)
from orderdetails
where (QUANTITYORDERED*PRICEEACH)>7000;

-- 9. List the customer names for those who their names are starting with “A”

SELECT CUSTOMERNAME
FROM CUSTOMERS
WHERE CUSTOMERNAME LIKE 'A%';

-- 10. Find the difference between the order date and the shipped date

SELECT orderdate, shippeddate, datediff(shippeddate,orderdate) as Diffrence
from orders;

-- 11. Find out the profit for each product on the basis on buy price and sell price and find the overall profit for all the inventory in stock

select productname, (MSRP-buyprice) as profit, (quantityinstock*(MSRP-buyprice)) as Overall_Profit
from products;

-- 12. Find the profit for each product line and also see the inventory in stock

select productline, (MSRP-buyprice) as profit, sum(quantityinstock)
from products
group by productline;

-- 14. Check if the overall purchase value has exceeded the credit limit set for them

select c.customernumber, c.customername, c.creditlimit, sum(p.amount),
if (c.creditlimit<sum(p.amount),"Limit exceeded","Not exceeded") as Check_Condition
from customers c
left join payments p on c.customernumber = p. customernumber
group by p.customernumber;

-- 15. Find the top performing sales agent, revenue generated and total number of customers for each of them individually

select c.salesRepEmployeeNumber as Emp_id,
          concat(e.firstname,' ',e.lastname) as Employee,
          sum(p.amount) as Revenue_Generated,
		  count(p.customernumber) as Total_customers
From customers c
Join employees e on c.salesRepEmployeeNumber = e.employeenumber
join payments p on c.customernumber = p. customernumber
group by Employee
order by sum(p.amount) desc;

