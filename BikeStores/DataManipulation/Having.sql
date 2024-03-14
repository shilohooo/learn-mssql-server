-- SQL Server 数据操作之 having - 在分组中筛选数据
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-having/
-- having 子句通常和 group by 子句一起用于根据指定的条件列表筛选分组中的数据，语法如下：
-- select select_list from table_name group by group_list having conditions;
-- 上述语法中，group by 子句讲数据行汇总为分组，并且 having 子句将一个或多个查询条件应用于这些分组
-- 查询结果集只会包含 having 子句的条件计算结果为 TRUE 的数据行，换言之，条件计算结果为 FALSE 或 UNKNOWN 的将被过滤掉
-- sql server 首先处理 group by 子句，再处理 having 子句，因此不能在 having 子句中使用列别名引用查询字段列表中指定的聚合函数
-- 必须在 having 子句中显示地使用聚合函数表达式！

use BikeStores;
-- 以下查询将使用 orders 表的数据作为示例

-- 查询每年至少下了两单的客户数据
-- 在该查询中，group by 子句首先根据客户 ID 和下单日期进行分组，count() 聚合函数返回客户每年的下单数量
-- 其次，having 子句过滤掉了下单数量小于2的客户
select customer_id,
       year(order_date) order_year,
       count(order_id)  order_count
from sales.orders
group by customer_id,
         year(order_date)
having count(order_id) >= 2
order by customer_id;

-- 结合 sum() 聚合函数使用 group by + having 子句查询数据
-- 以下查询将使用 order_items 表的数据作为示例
-- 查询净利润大于两万的订单
select order_id,
       sum(
               quantity * list_price * (1 - discount)
       ) as net_value
from sales.order_items
group by order_id
having sum(
               quantity * list_price * (1 - discount)
       ) > 20000
order by net_value;

-- 结合 min() 和 max() 聚合函数使用 group by + having 子句查询数据
-- 以下查询将使用 products 表的数据作为示例
-- 根据产品类别进行分组，查询产品分类的最低价和最高价，并过滤掉最高价大于四千或最低价小于五百的数据
select category_id,
       max(list_price) max_price,
       min(list_price) min_price
from production.products
group by category_id
having max(list_price) > 4000
    or min(list_price) < 500;

-- 结合 avg() 聚合函数使用 group by + having 子句查询数据
-- 查询均价在 500 到 1000 之间之间的产品类别
select category_id,
       avg(list_price) avg_price
from production.products
group by category_id
having avg(list_price) between 500 and 1000;
