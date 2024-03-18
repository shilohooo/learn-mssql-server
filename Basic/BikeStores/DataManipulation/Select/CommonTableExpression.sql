-- SQL Server 数据操作之 Common Table Expression - 公共表表达式
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-cte/
-- 在 SQL Server 中，公共表表达式（Common Table Expression，简称 CTE）是一种临时结果集，用于存储查询中的中间结果。
-- CTE 可以将复杂的查询分解为多个简单的步骤，从而提高代码的可读性和可维护性。

-- 语法：
-- with expression_name [(column_name [,...])]
-- as
-- (CET definition)
-- SQL statement;

-- 上述语法中，首先需要指定表达式的名称，用于后续引用
-- 然后在表达式名称后面指定以逗号分隔的查询列的列表，该列表的列数量必须与 (CET definition) 中定义的列数量相同
-- 接着定义一个 SELECT 语句，它的结果集将填充到 (CET definition)
-- 最好，在SQL 语句中引用 CTE，如：SELECT、INSERT、UPDATE、DELETE、MERGE

use BikeStores;

-- 查询2018年销售人员的销售额
-- 定义 CTE 名称和返回的列
with cte_sales_amounts (staff, sales, year)
         as (
        -- 定义查询，获取员工每年的销售额
        select first_name + ' ' + last_name,
               sum(quantity * list_price * (1 - discount)),
               year(order_date)
        from sales.orders o
                 inner join sales.order_items i on o.order_id = i.order_id
                 inner join sales.staffs s on o.staff_id = s.staff_id
        group by first_name + ' ' + last_name, year(o.order_date))
select staff,
       sales
-- 引用 CTE
from cte_sales_amounts
where year = 2018;

-- 使用 CTP 基于 count 聚合函数生成平均数据报告
-- 查询所有销售人员在 2018 年的平均销售订单数量
-- 此处没有定义 CTE 的返回列表，那么它的返回列表数则为 as 中的查询定义的
with cte_sales as (select staff_id,
                          count(*) order_count
                   from sales.orders
                   where year(order_date) = 2018
                   group by staff_id)
select avg(order_count) avg_orders_by_staff
from cte_sales;

-- 在单个查询中使用多个 CTE
-- 使用两个 CTE 查询每个产品类别的产品编号和销售额
WITH
    --     统计每个产品类别的产品数量
    cte_category_counts (
                         category_id,
                         category_name,
                         product_count
        )
        AS (SELECT c.category_id,
                   c.category_name,
                   COUNT(p.product_id)
            FROM production.products p
                     INNER JOIN production.categories c
                                ON c.category_id = p.category_id
            GROUP BY c.category_id,
                     c.category_name),
    --     统计每个产品类别的销售额
    cte_category_sales(category_id, sales) AS (SELECT p.category_id,
                                                      SUM(i.quantity * i.list_price * (1 - i.discount))
                                               FROM sales.order_items i
                                                        INNER JOIN production.products p
                                                                   ON p.product_id = i.product_id
                                                        INNER JOIN sales.orders o
                                                                   ON o.order_id = i.order_id
                                               WHERE order_status = 4 -- completed
                                               GROUP BY p.category_id)

SELECT c.category_id,
       c.category_name,
       c.product_count,
       s.sales
FROM cte_category_counts c
         INNER JOIN cte_category_sales s
    -- 使用 category_id 联接两个 CTE
                    ON s.category_id = c.category_id
ORDER BY c.category_name;
