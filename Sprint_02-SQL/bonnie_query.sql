/* 1. Find menu items for particular order id */
SELECT menu_ordered.order_id, menu_ordered.menu_id, menu.menu_name, menu.menu_price FROM menu,menu_ordered
WHERE menu.menu_id = menu_ordered.menu_id
	AND menu_ordered.order_id = 1 ;
    
/* 2. Find the total amount of money spent by each order */ 
SELECT orders.order_id, sum(menu.menu_price) As total_amount FROM orders,menu,menu_ordered
WHERE orders.order_id = menu_ordered.order_id
	AND menu_ordered.menu_id = menu.menu_id
GROUP by orders.order_id ;

/* 3. Find the most popular dish on the menu */ 
SELECT menu.menu_name, COUNT(menu.menu_id) AS total_order FROM menu
JOIN menu_ordered ON menu_ordered.menu_id = menu.menu_id
GROUP by menu_ordered.menu_id
order by total_order DESC ;

/* 4. Find the number of orders placed on each platform */
SELECT platforms.platform_name, COUNT(orders.order_id) AS count_order FROM orders
JOIN platforms ON platforms.platform_id = orders.platform_id
GROUP by platforms.platform_id ;

/* 5.Find orders that has amount of payment more than avarage amount payment of all orders */
WITH avg_amount AS (
  SELECT avg(amount) as avg_a
  FROM payment
)
SELECT * FROM payment p, avg_amount av
WHERE p.amount > av.avg_a ;

/* 6. Find platforms that its sales were better than the average sales across all platforms */
WITH total_sales (platform_name, total_amount) AS (SELECT platforms.platform_name, sum(payment.amount) AS total_amount FROM orders
                        JOIN platforms ON platforms.platform_id = orders.platform_id
                        JOIN payment ON orders.order_id = payment.order_id 
                        GROUP by platforms.platform_id),
     avg_sales (avg_total_amount) AS (SELECT CAST(avg(total_amount) as int) as avg_total_amount FROM total_sales )
SELECT *
FROM total_sales ts
JOIN avg_sales av 
ON ts.total_amount > av.avg_total_amount ;