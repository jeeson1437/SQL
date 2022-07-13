use superstores;

-- 1.	Find the total and the average sale price (Revenue/Units) for each brand

select brand,(revenue/units) as sales_price_per_unit,
sum(revenue/units) as Total_sales_price, avg(revenue/units) as Average_sales_price
from offline_mobile_sales
group by brand;

-- 2.	Find the total revenue and units sold for each product

select product, units, sum(revenue) as Total_revenue
from offline_mobile_sales
group by product;

-- 3.	Write a query to find the state wise revenue and its overall share (Revenue of that state/Total revenue) including all mobile brands

select IP.state as STATE,OM.revenue AS REVENUE,om.revenue/sum(revenue)*100 as '%SHARE'
FROM indian_pincodes_mapping as IP
JOIN offline_mobile_sales AS OM
ON IP.pincode = om.pincode
GROUP BY STATE;

-- 4.	Find the top product with most sales in Metro region

SELECT OM.PRODUCT, (OM.REVENUE/OM.UNITS) AS P,AVG(OM.UNITS*OM.REVENUE/OM.UNITS) AS R, IP.city_tier
FROM offline_mobile_sales AS OM
JOIN indian_pincodes_mapping AS IP
ON OM.PINCODE = IP.PINCODE
GROUP BY PRODUCT
ORDER BY AVG(OM.UNITS*REVENUE/OM.UNITS) DESC;

-- 6.	Display the top contributing cities in North region in descending order of units sold for Vicky Smart Phone

SELECT I.CITY, O.BRAND,SUM(O.REVENUE) AS SALES, I.ZONE
FROM INDIAN_PINCODES_MAPPING I
LEFT JOIN OFFLINE_MOBILE_SALES O ON I.PINCODE = O.PINCODE
WHERE I.ZONE = 'NORTH' AND O.BRAND = 'VICKY SMART PHONE'
GROUP BY I.CITY
ORDER BY sum(o.REVENUE) DESC
LIMIT 10;

-- 7.	What is the pincode coverage of the offline retailer in each state?

select i.state, sum(o.revenue) as sales, count(distinct o.pincode), count(distinct o.pincode)/count(i.pincode)*100 as '% pincode coverage'
from INDIAN_PINCODES_MAPPING as I
left join OFFLINE_MOBILE_SALES as o on i.pincode = o. pincode
group by i.state
order by i.state desc;

-- Write a query to find sales details of all pincodes ordered by revenue in descending order

select * from OFFLINE_MOBILE_SALES
order by revenue desc;

-- 8.	Write a query to get the average selling price (Revenue/Units) across city tier individually for both the brands. After getting the output, check if Metro's average selling price for each brand is higher than Tier 3 and other? This will verify whether metro customer buys a high end mobile phone compared to a tier 1 or tier 3 customer

select sum(o.revenue/o.units) as selling_price, o.brand, p.city_tier
from offline_mobile_sales o
inner join indian_pincodes_mapping p
on o.pincode = p.pincode
group by o.brand,p.city_tier
order by selling_price desc;
