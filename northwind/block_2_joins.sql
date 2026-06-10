-- Задача 1. Все заказы + компания + страна --
SELECT order_id, company_name, country
FROM orders INNER JOIN customers
USING (customer_id);

-- Задача 2. Имя клиента + кол-во заказов --
SELECT customer_id, contact_name, count(order_id) AS count_orders
FROM customers LEFT JOIN orders
USING (customer_id)
GROUP BY customer_id
ORDER BY count_orders;

-- Задача 3. Имя сотрудника и его менеджера --

SELECT e.first_name AS employee, m.first_name AS manager
FROM employees e
LEFT JOIN employees m ON e.reports_to = m.employee_id; 

-- Задача 4. Топ 5 компаний с самой большой выручкой за 1997 год --

SELECT company_name, SUM(quantity * unit_price) AS revenue
FROM customers
INNER JOIN orders USING (customer_id)
INNER JOIN order_details ON orders.order_id = order_details.order_id
WHERE EXTRACT(YEAR FROM order_date) = 1997
GROUP BY customer_id, company_name
ORDER BY revenue DESC
LIMIT 5;

