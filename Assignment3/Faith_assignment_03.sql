use assignment_no3;

-- NAME: Kyle Faith
-- TIME TAKEN: ~5 hours


-- Problems on Joins

-- 1.   Write a query to count number of customers with a balance of more than $500.
select customer.CUS_CODE, customer.CUS_BALANCE
from customer
where customer.CUS_BALANCE > 500;


-- 2.   Create a query to produce the total purchase per invoice, sorted by invoice number.
-- 	    The invoice total is the sum of the products purchases in the line that corresponds to the INVOICE.
SELECT line.INV_NUMBER, (Sum( line.LINE_UNITS*line.LINE_PRICE)) 
FROM line 
GROUP BY line.INV_NUMBER;

-- 3.   Provide a summary of customer balance characteristics for customers who made purchases. Include minimum balance, maximum balance, and average balance.
SELECT MIN(customer.CUS_BALANCE), MAX(customer.CUS_BALANCE) , ROUND(AVG(customer.CUS_BALANCE),2) from customer, invoice
WHERE customer.CUS_CODE = invoice.CUS_CODE;


-- 4.   Write a query to produce the number of invoices and the total purchase amounts by customer. Results are sorted by customer code.

SELECT  invoice.CUS_CODE, COUNT(invoice.INV_NUMBER), SUM(LINE_PRICE*LINE_UNITS) 
FROM customer, invoice, line
WHERE (customer.CUS_CODE = invoice.CUS_CODE) AND (invoice.INV_NUMBER = line.INV_NUMBER)
GROUP BY invoice.CUS_CODE
ORDER BY invoice.CUS_CODE asc;

-- 5.   Generate a listing of all purchases made by the customers, using the output shown in given table. Sort the results by customer code, invoice number and product description.

select customer.CUS_CODE, invoice.INV_NUMBER, product.P_DESCRIPT 
FROM customer, invoice, product, line
WHERE (customer.CUS_CODE = invoice.CUS_CODE) AND (line.P_CODE = product.P_CODE)
GROUP BY invoice.CUS_CODE 
ORDER BY invoice.CUS_CODE, invoice.INV_NUMBER, product.P_DESCRIPT asc;

-- 6.   Generate a list of customer purchases, including the subtotals for each of the invoice line numbers. 
-- 	    The subtotal is derived attribute calculated by multiplying LINE_UNITS, LINE_PRICE. Sort the output by customer code, invoice number and product description. Use column alias.

SELECT invoice.CUS_CODE, invoice.INV_NUMBER, product.P_DESCRIPT, line.LINE_UNITS, line.LINE_PRICE , (line.LINE_UNITS * line.LINE_PRICE) AS "Subtotal" 
FROM customer, invoice, line, product
WHERE (customer.CUS_CODE = invoice.CUS_CODE) AND  (product.P_CODE = line.P_CODE) AND (invoice.INV_NUMBER = line.INV_NUMBER) 
ORDER BY invoice.CUS_CODE, invoice.INV_NUMBER, product.P_DESCRIPT asc;

-- 7.   Write a query to display the customer code, balance, and total purchases for each customer.
-- 	    Total purchase is calculated by summing the line subtotals for each customer. Sort the result by customer code. Use alias.

SELECT invoice.CUS_CODE, customer.CUS_BALANCE, Sum(line.LINE_UNITS*line.LINE_PRICE)  AS 'Total Purchases'
FROM customer, invoice, line 
WHERE (customer.CUS_CODE = invoice.CUS_CODE) AND (invoice.INV_NUMBER = line.INV_NUMBER)
GROUP BY invoice.CUS_CODE, customer.CUS_BALANCE;

-- 8.   Write a query to compute the total of all purchases, the number of purchases, and the average purchase amount paid by each customer.

-- Can't get the final select to work, it keeps saying invalid use of group function, so im leaving the table as just the customer code, total of all purchases, and number of the purchases.
SELECT invoice.CUS_CODE,  SUM(line.LINE_UNITS*line.LINE_PRICE) AS "Total of All Purchases", COUNT(invoice.INV_NUMBER) AS "Number Of Purchases"-- , AVG(SUM(line.LINE_UNITS*line.LINE_PRICE)) AS "Average Purchase"
FROM invoice, line
GROUP BY invoice.CUS_CODE;

-- Problems on Subquery

-- 9.   Find customer balance summary for all customers who have not made purchases during current invoicing period.

SELECT customer.CUS_CODE, customer.CUS_BALANCE
FROM customer
WHERE customer.CUS_CODE NOT IN(SELECT invoice.CUS_CODE FROM invoice)
GROUP BY customer.CUS_CODE;

-- 10. Find the listing of customers who did not make purchases during the invoicing period. Sort the result by customer code. 

SELECT customer.CUS_CODE, customer.CUS_FNAME
FROM customer
WHERE customer.CUS_CODE NOT IN (SELECT invoice.CUS_CODE FROM invoice)
ORDER  BY customer.CUS_CODE asc;

-- 11. List product cost which is more than all individual products provided by vendors from Florida.
SELECT product.P_CODE, product.P_PRICE
FROM product
WHERE product.P_PRICE > product.P_PRICE IN (SELECT vendor.V_STATE FROM vendor WHERE vendor.V_STATE = "Florida")
ORDER BY product.P_CODE asc;
-- Not really too sure about this one... it works but i dont think it works in the way the question is asking, I'm not entirely too sure what the question is asking. 