-- SQL Server 数据操作之 group by - 分组
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-group-by/
-- group by 子句可以在查询中对数据行进行分组，如何分组取决于 group by 指定的列，语法如下：
-- select select_list from table_name group by column_name1, column_name2, ...;

use BikeStores;

-- 假设有如下查询
select customer_id,
       year(order_date) order_year
from sales.orders
where customer_id in (1, 2)
order by customer_id;

-- 添加 group by 子句
select customer_id,
       year(order_date) order_year
from sales.orders
where customer_id in (1, 2)
group by customer_id, year(order_date)
order by customer_id;

-- 在实际使用中，group by 子句通常和聚合函数（aggregate functions）一起用于生成报表
-- 聚合函数在分组中执行计算并返回每个分组的唯一值，举例：
-- COUNT() 函数返回每个分组的数据行数，其他常用的聚合函数有：SUM() - 求和、AVG() - 求平均值、MIN() - 求最小值、MAX() - 求最大值
-- 示例：查询客户每年的下单量
select customer_id,
       year(order_date) order_year,
       count(order_id)  order_placed
from sales.orders
where customer_id in (1, 2)
group by customer_id, year(order_date)
order by customer_id;

-- 注意：不在 group by 中的列，必须作为聚合函数的输入使用，否则将会报如下错误：
-- Column 'order_id' is invalid in the select list because it is not contained in either an aggregate function or the GROUP BY clause
-- SELECT customer_id,
--        YEAR(order_date) order_year,
--        order_id
-- FROM sales.orders
-- WHERE customer_id IN (1, 2)
-- GROUP BY customer_id,
--          YEAR(order_date)
-- ORDER BY customer_id;

-- 结合 count() 聚合函数使用 group by 子句查询数据
-- 查询每个城市的客户数据量
select city, count(customer_id) coustomer_count
from sales.customers
group by city
order by city;

-- 查询每个城市、每个州的客户数量
select city,
       state,
       count(customer_id) coustomer_count
from sales.customers
group by city,
         state
order by city,
         state;
-- 结合 min() 和 max() 聚合函数使用 group by 子句查询数据
-- 根据品牌分组，查询 model_year 为 2018 的最低价和最高价产品的品牌
-- where 子句的处理总是在 group by 子句之前
select brand_name,
       min(list_price) min_price,
       max(list_price) max_price
from production.products p
         inner join production.brands b
                    on p.brand_id = b.brand_id
where p.model_year = 2018
group by b.brand_name
order by b.brand_name;

-- 结合 avg() 聚合函数使用 group by 子句查询数据
-- 根据品牌分组，查询 model_year 为 2018 的产品品牌的均价
select brand_name,
       avg(p.list_price) avg_price
from production.products p
         inner join production.brands b
                    on p.brand_id = b.brand_id
where p.model_year = 2018
group by b.brand_name
order by brand_name;

-- 结合 sum() 聚合函数使用 group by 子句查询数据
-- 统计每个订单的净利润
select order_id,
       sum(
               quantity * list_price * (1 - discount)
       ) net_value
from sales.order_items
group by order_id;
