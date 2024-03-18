-- SQL Server 数据操作之 SubQuery - 子查询
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-subquery/
-- 子查询是嵌套在其他语句中的查询，如：SELECT、INSERT、UPDATE、DELETE

use BikeStores;
-- 以下查询将使用 orders、customers 表中的数据作为示例

-- 在 where 子句中使用子查询，用于查询位于纽约的客户数据和订单数据
select order_id,
       order_date,
       customer_id
-- 外部查询
from sales.orders
where customer_id in (
    -- 这里使用了子查询，把在纽约的客户的ID都查出来，并作为查询条件的值
    -- 注意：子查询必须使用 () 括号括起来！！！
    -- 子查询也成为内部查询，而包含子查询的语句称为外部查询
    -- SQL Server 首先执行子查询获取位于纽约的客户 ID 列表
    -- 然后在 IN 运算符中替换子查询返回的客户 ID 列表，并执行外部查询获取最终的查询结果
    select customer_id
    from sales.customers
    where city = 'New York')
order by order_date desc;

-- 嵌套子查询：一个子查询可以嵌套在另一个子查询中，最多支持32个嵌套级别，示例：
select product_name,
       list_price
-- 最后再执行外部查询获取最终的查询结果
from production.products
where list_price > (
    -- 子查询
    -- 然后再执行这里的子查询，以获取指定品牌的产品均价
    select avg(list_price)
    from production.products
    where brand_id in (
        -- 嵌套在另一个子查询中的子查询
        -- 该子查询会先执行，以获取品牌 ID 列表
        select brand_id
        from production.brands
        where brand_name = 'Strider'
           or brand_name = 'Trek'))
order by list_price;

-- 可以使用子查询的地方有:
-- 1.代替表达式
-- 2.与 IN 或 NOT IN 运算符一起使用
-- 3.与 ANY 或 ALL 运算符一起使用
-- 4.与 EXISTS 或 NOT EXISTS 运算符一起使用
-- 5.在 INSERT、DELETE、UPDATE 语句中使用
-- 6.在 FROM 子句中使用

-- 使用子查询代替表达式：如果子查询的返回结果为单个值，则可以在使用表达式的任何位置使用该子查询
-- 示例：使用子查询替换要查询的列
select o.order_id,
       o.order_date,
       (select max(list_price)
        from sales.order_items i
        where i.order_id = o.order_id) as max_list_price
from sales.orders o
order by order_date desc;

-- 子查询与 IN 运算符一起使用：与 IN 运算符一起使用的子查询返回一组零或多个值的结果集，外部查询将使用这些值作为 IN 运算符的查询条件
-- 示例：查询已出售的山地自行车和公路自行车产品的名称
select product_id,
       product_name
-- 然后再执行外部查询，获取类型 ID 在子查询结果集中的产品信息
from production.products
where category_id in (
    -- 首先执行该子查询获取类型 ID 列表
    select category_id
    from production.categories
    where category_name = 'Mountain Bikes'
       or category_name = 'Road Bikes')
order by product_name;

-- 子查询与 ANY 运算符一起使用，语法：scalar_expression comparison_operator ANY (sub query);
-- 假设子查询的结果集返回(v1, v2, v3, ...)，comparison_operator 为 >=，那么只要 scalar_expression 大于等于
-- (v1, v2, v3, ...) 列表中任意一个值，ANY 运算符的结果就为 TRUE
-- 示例：查询价格大于等于任意品牌的产品均价的产品数据
select product_name,
       list_price
-- 外部查询使用子查询的返回结果作为 ANY 运算符的查询条件
from production.products
where list_price >= any (
    -- 子查询将返回每个品牌的产品均价
    select avg(list_price)
    from production.products
    group by brand_id)
order by list_price;

-- 子查询与 ALL 运算符一起使用，语法：scalar_expression comparison_operator ALL (sub query);
-- 假设子查询的结果集返回(v1, v2, v3, ...)，comparison_operator 为 >=，那么 scalar_expression 必须大于等于
-- (v1, v2, v3, ...) 列表中全部值，，ALL 运算符的结果才会为 TRUE
-- 示例：查询价格大于等于所有品牌的产品均价的产品数据
select product_name,
       list_price
-- 外部查询使用子查询的返回结果作为 ANY 运算符的查询条件
from production.products
where list_price >= all (
    -- 子查询将返回每个品牌的产品均价
    select avg(list_price)
    from production.products
    group by brand_id)
order by list_price;

-- 子查询与 EXISTS 或 NOT EXISTS 运算符一起使用
-- 语法：where [not] exists (sub query);
-- 当与 exists 运算符一起使用时，如果子查询返回了数据，则 exists 运算符的结果为 TRUE，否则为 FALSE
-- not exists 运算符则相反，如果子查询没有返回数据，not exists 运算符的结果就为 TRUE
-- 示例：查询在 2017 年购买过产品的客户信息，使用 not exists 则可以查询在 2017 年没有购买过任何产品的客户信息
select c.customer_id,
       c.first_name,
       c.last_name,
       c.city
from sales.customers c
where exists (select customer_id
              from sales.orders o
              where o.customer_id = c.customer_id
                and YEAR(o.order_date) = 2017)
order by c.first_name,
         c.last_name;

-- 在 from 子句中使用子查询
-- 假设现在需要查询所有销售人员的订单总和的平均值，首先按员工查询订单数量
select staff_id,
       count(order_id) order_count
from sales.orders
group by staff_id;
-- 然后将 avg() 聚合函数应用于此结果集
select avg(t.order_count) avg_order_count_by_staff
from (select count(order_id) order_count
      from sales.orders
      -- from 子句中的子查询相当于一张虚拟表，必须指定表别名！！！
      group by staff_id) t;
