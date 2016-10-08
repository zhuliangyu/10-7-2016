-- students
-- id first_name  last_name email phone_number  age registration_date created_at  updated_at
--projects
-- id title student_id  created_at  updated_at
--course
-- id title description
-- enrolments
--id  course_id student_id
-- products
-- id name  description price sale_price  remaining_quantity
--line_items
--id  product_id  order_id  price quantity
--orders
-- id completed_on

-------------------------------------------------------------------------------------------------------------
--Write the following SQL Query: Select the average order total price for the `Lightweight Marble Gloves` product



-------------------------------------------------------------------------------------------------------------
-- Assignment: [lab] Queries 3 Next Module
-- 1- Select all the products that have been purchased in the last year

SELECT products.name
FROM products
RIGHT JOIN line_items ON products.id=line_items.product_id
INNER JOIN orders ON orders.id=line_items.order_id
WHERE orders.completed_on >= ('2015-10-10 00:00:00')
  AND completed_on <= ('2016-10-10 00:00:00')
GROUP BY products.id;

SELECT
  products.name,
  products.remaining_quantity,
  SUM(line_items.quantity) as sold,
  SUM(line_items.quantity) + products.remaining_quantity as historical_total
  FROM products
  LEFT JOIN line_items ON line_items.product_id = products.id
  GROUP BY products.id

 -- 2- Select the top 10 products in terms of gross sales last year

SELECT products.name ,
       sum(line_items.price*line_items.quantity) AS a
FROM products
RIGHT JOIN line_items ON products.id=line_items.product_id
INNER JOIN orders ON orders.id=line_items.order_id
WHERE orders.completed_on >= ('2015-10-10 00:00:00')
GROUP BY products.id
ORDER BY a DESC LIMIT 10;



 -- 3 - Select all the products that weren't purchased during the last year

SELECT *
FROM products
LEFT JOIN
  (SELECT products.id
   FROM products
   LEFT JOIN line_items ON products.id=line_items.product_id
   LEFT JOIN orders ON orders.id=line_items.order_id
   WHERE orders.completed_on >= ('2015-10-10 00:00:00')
     AND line_items.order_id IS NOT NULL)t ON products.id=t.id
WHERE t.id IS NULL;

 -------------------------------------------------------------------------------------------------------------
 -- Assignment: [lab] Queries 2 Next Module
 -- 1- Calculate how many items in stock we've ever had for products (remaining or sold) in the database.

SELECT products.remaining_quantity+sum(line_items.quantity)
FROM products
INNER JOIN line_items ON products.id=line_items.product_id
GROUP BY products.id;

 -- 2- Find the average order total price for all the orders in the system

SELECT avg(price*quantity)
FROM line_items 

SELECT AVG(order_total) FROM (
  SELECT orders.id, SUM(line_items.price * line_items.quantity) as order_total FROM orders
  INNER JOIN line_items ON line_items.order_id = orders.id
  GROUP BY orders.id
) as order_totals


---------------------------------------------------------------------------------------------------------
 -- Assignment: [lab] Queries 1 Next Module
 -- 1- Find the average line item total price for orders that were completed last month

SELECT line_items.order_id,
       avg(line_items.price*line_items.quantity)
FROM line_items
INNER JOIN orders ON orders.id=line_items.order_id
WHERE orders.completed_on >= ('2016-09-10 00:00:00')
  AND completed_on <= ('2016-10-10 00:00:00')
GROUP BY line_items.order_id;

SELECT products.name, products.price, AVG(line_items.price * line_items.quantity) as avg_line_item_total_price
  FROM products
  INNER JOIN line_items ON line_items.product_id = products.id
  INNER JOIN orders ON line_items.order_id = orders.id
  WHERE orders.completed_on > CURRENT_DATE - INTERVAL '1 month'
  GROUP BY products.id

 --154.686647727273
 -- 2- Select product titles and prices that sold last month and the lowest they were sold at.
 -- [Note] the price in the line_items table is price per unit and not total price

SELECT products.name,
       min(line_items.price)
FROM products
INNER JOIN line_items ON products.id=line_items.product_id
INNER JOIN orders ON line_items.order_id=orders.id
GROUP BY products.id
ORDER BY products.name;

-- Select product titles and prices that sold last month
SELECT products.name, products.price, MIN(line_items.price) as lowest_sale_price
  FROM products
  INNER JOIN line_items ON line_items.product_id = products.id
  GROUP BY products.id

 -------------------------------------------------------------------------------------------------------------
 -- Assignment: [demo] Line Items for products Next Module
-- 1- Select all the products that have orders and their orders

SELECT products.name
FROM products
LEFT JOIN line_items ON products.id=line_items.product_id
LEFT JOIN orders ON line_items.order_id=orders.id;

 -- 2- Select all the products and their orders
 -- [Note] the price in the line_items table is price per unit and not total price

SELECT count(*),
       first_name
FROM students
GROUP BY first_name
ORDER BY COUNT;


SELECT *
FROM students
INNER JOIN projects ON projects.student_id=students.id LIMIT 10;


SELECT students.id ,
       COUNT(projects.id)
FROM students
INNER JOIN projects ON projects.student_id=students.id
GROUP BY projects.id
ORDER BY student_id;


SELECT COUNT(*),students.first_name,
                students.last_name
FROM students
INNER JOIN projects ON projects.student_id=students.id
GROUP BY students.id;


SELECT students.first_name,
       courses.title
FROM courses
INNER JOIN enrolments ON courses.id=enrolments.course_id
INNER JOIN students ON students.id=enrolments.student_id
WHERE courses.title='Persistent neutral core';


SELECT *
FROM students
LEFT JOIN projects ON students.id=projects.student_id
WHERE projects.id IS NULL;

