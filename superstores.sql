                                        # Superstores Database #

/*                                Task 1:- Understanding the Data

 1.	 Describe the data in hand in your own words.

	This database contains Sales details of transaction of a superstore. 
	The structure has 5 tables

I.	Cust_dimen (containing details about customer and their respective locations)

Customer_Name (TEXT): Name of the customer
        	Province (TEXT): Province of the customer
        	Region (TEXT): Region of the customer
        	Customer_Segment (TEXT): Segment of the customer
        	Cust_id (TEXT): Unique Customer ID

II.	Prod_dimen (containing product category and their subcategories)

Product_Category (TEXT): Product Category
        	Product_Sub_Category (TEXT): Product Sub Category
Prod_id (TEXT): Unique Product ID

III.	Orders_dimen (with order no, date, and priority)

Order_ID (INT): Order ID
Order_Date (TEXT): Order Date
Order_Priority (TEXT): Priority of the Order
        	Ord_id (TEXT): Unique Order ID

IV.	Shipping_dimen (with ship date, order and shipping mode)

        	Order_ID (INT): Order ID
      	Ship_Mode (TEXT): Shipping Mode
        	Ship_Date (TEXT): Shipping Date
        	Ship_id (TEXT): Unique Shipment ID


V.	market_fact (orderwise customerwise marketwise orderquantity, sales value, discount profit and shipping cost details).

Ord_id (TEXT): Order ID
        	Prod_id (TEXT): Prod ID
        	Ship_id (TEXT): Shipment ID
        	Cust_id (TEXT): Customer ID
        	Sales (DOUBLE): Sales from the Item sold
        	Discount (DOUBLE): Discount on the Item sold
        	Order_Quantity (INT): Order Quantity of the Item sold
        	Profit (DOUBLE): Profit from the Item sold
        	Shipping_Cost (DOUBLE): Shipping Cost of the Item sold
        	Product_Base_Margin (DOUBLE): Product Base Margin on the Item sold


2.	Identify and list the Primary Keys and Foreign Keys for this dataset provided to 
you(In case you don’t find either primary or foreign key, then specially mention 
this in your answer)


i.	Cust_dimen

Primary Key: Cust_id
Foreign Key: NA


ii.	Prod_dimen

Primary Key: Prod_id
Foreign Key: NA


iii.	Orders_dimen

Primary Key: Ord_id
Foreign Key: NA

iv.	Shipping_dimen

Primary Key: Ship_id
Foreign Key: NA

v.	Market_fact

Primary Key: NA
Foreign Key: Ord_id, Prod_id, Ship_id, Cust_id */

                                # Task 2:- Basic & Advanced Analysis (Queries) #

# 1 Write a query to display the Customer_Name and Customer Segment using alias name “Customer Name", "Customer Segment" from table Cust_dimen

select customer_name as 'Customer Name' , customer_segment as 'Customer Segment'  from cust_dimen;

# 2 Write a query to find all the details of the customer from the table cust_dimen order by desc

select * from cust_dimen order by cust_id desc;

# 3 Write a query to get the Order ID, Order date from table orders_dimen where ‘Order Priority’ is high

select order_id, order_date from orders_dimen where Order_Priority='High';

# 4 Find the total and the average sales (display total_sales and avg_sales)

select avg(sales) as 'Avg_sales' , sum(sales) as 'total_sales' from market_fact;

# 5 Write a query to get the maximum and minimum sales from maket_fact table

select max(sales), min(sales) from market_fact;

# 6 Display the number of customers in each region in decreasing order of no_of_customers. The result should contain columns Region, no_of_customers

select region, count(*) as 'No_of_customers'  from cust_dimen group by region order by count(*) desc;

# 7 Find the region having maximum customers (display the region name and max(no_of_customers)

select region, count(*) as 'Max(No_of_customers' from cust_dimen group by region order by count(*) desc limit 1;

# 8 Find all the customers from Atlantic region who have ever purchased ‘TABLES’ and the number of tables purchased (display the customer name, no_of_tables purchased)

select cust_dimen.Customer_Name, count(market_fact.Order_Quantity) as no_of_tables_purchased from market_fact inner join cust_dimen on market_fact.Cust_id=cust_dimen.Cust_id inner join prod_dimen on prod_dimen.Prod_id=market_fact.Prod_id where cust_dimen.region='Atlantic' and prod_dimen.product_sub_category='TABLES' group by Customer_Name order by count(market_fact.Order_Quantity) desc;

# 9 Find all the customers from Ontario province who own Small Business. (display the customer name, no of small business owners)

select customer_name, count(Customer_Segment) as 'No Of Small Business Owners' from cust_dimen where customer_segment='SMALL BUSINESS' and province='Ontario' group by Customer_Name;

# 10 Find the number and id of products sold in decreasing order of products sold (display product id, no_of_products sold)

select prod_id, count(Order_Quantity) from market_fact group by Prod_id order by count(Order_Quantity) desc;

# 11 Display product Id and product sub category whose produt category belongs to Furniture and Technlogy. The result should contain columns product id, product sub category

select prod_id, product_sub_category from prod_dimen where Product_Category in ('FURNITURE' , 'TECHNOLOGY');

# 12 Display the product categories in descending order of profits (display the product category wise profits i.e. product_category, profits)?

select prod_dimen.Product_Category , market_fact.Profit from prod_dimen inner join market_fact on prod_dimen.Prod_id=market_fact.Prod_id order by profit desc; 

# 13 Display the product category, product sub-category and the profit within each subcategory in three columns

select prod_dimen.Product_Category, prod_dimen.Product_Sub_Category, sum(market_fact.Profit) from prod_dimen inner join market_fact on prod_dimen.Prod_id=market_fact.Prod_id group by Product_Sub_Category order by sum(market_fact.Profit) desc;

# 14 Display the order date, order quantity and the sales for the order

select orders_dimen.Order_Date, market_fact.Order_Quantity, market_fact.Sales from orders_dimen inner join market_fact on orders_dimen.Ord_id=market_fact.Ord_id;

# 15 Display the names of the customers whose name contains the
# i) Second letter as ‘R’
# ii) Fourth letter as ‘D’

# i) Second letter as ‘R’

select customer_name from cust_dimen where Customer_Name like '_R%';

# ii) Fourth letter as ‘D’

select customer_name from cust_dimen where Customer_Name like '___D%';

# 16 Write a SQL query to to make a list with Cust_Id, Sales, Customer Name and their region where sales are between 1000 and 5000

select market_fact.Cust_id, market_fact.Sales, cust_dimen.Customer_Name, cust_dimen.Region from market_fact inner join cust_dimen on market_fact.Cust_id=cust_dimen.Cust_id where sales between '1000' and '5000';

# 17 Write a SQL query to find the 3rd highest sales

select sales from market_fact order by sales desc limit 2,1;

# 18 Where is the least profitable product subcategory shipped the most? For the least profitable product sub-category, display the region-wise no_of_shipments and the
# profit made in each region in decreasing order of profits (i.e. region, no_of_shipments, profit_in_each_region)
# → Note: You can hardcode the name of the least profitable product subcategory

select cust_dimen.Region as "Region", count(market_fact.ship_id) as "no_of_shipment",round(sum(market_fact.profit),2) as "profit in each region" from market_fact join cust_dimen on market_fact.cust_id=cust_dimen.cust_id join prod_dimen on market_fact.prod_id=prod_dimen.prod_id where product_sub_category=(select prod_dimen.product_sub_category from market_fact join prod_dimen on market_fact.prod_id=prod_dimen.prod_id group by product_sub_category order by sum(market_fact.profit) limit 1) group by cust_dimen.Region order by sum(market_fact.profit);




