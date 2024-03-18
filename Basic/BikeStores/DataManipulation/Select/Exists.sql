-- SQL Server 数据操作之 exists 运算符 - 是否存在
-- exists 运算符是一个逻辑运算符，当子查询返回一条或多条数据时，它的计算结果为 TRUE，否则为 FALSE
-- 语法：exists (sub query);
-- 上述语法中，子查询只能是一个查询语句，只要子查询返回了数据，exists 运算符就会返回 TRUE，并停止处理
-- 需要注意的是：即使子查询返回一个 NULL 值，exists 运算符的计算结果仍会为 TRUE

use BikeStores;
-- 以下查询将使用 customers 表的数据作为示例

-- 结合返回 NULL 的子查询使用 exists 查询数据
-- 下面这个查询将会返回所有客户数据
select customer_id,
       first_name,
       last_name
from sales.customers
-- 注意：即使子查询返回一个 NULL 值，exists 运算符的计算结果仍会为 TRUE
where exists (select null)
order by first_name,
         last_name

-- 结合相关子查询使用 exists 查询数据
-- 以下查询将使用 customers、orders 表的数据作为示例
-- 查询下单数量大于等于2的客户信息
select c.customer_id,
       c.first_name,
       c.last_name
from sales.customers c
where exists (select count(*)
              from sales.orders o
              where o.customer_id = c.customer_id
              group by o.customer_id
              having count(*) > 2)
order by c.first_name,
         c.last_name;

-- exist 对比 in 运算符
-- 使用 in 运算符查询来自圣何塞的客户订单
select *
from sales.orders
where customer_id in (select customer_id
                      from sales.customers
                      where city = 'San Jose')
order by customer_id,
         order_date;

-- 使用 exists 运算符执行相同的查询
select *
from sales.orders o
where exists (select customer_id
              from sales.customers c
              where o.customer_id = c.customer_id
                and c.city = 'San Jose')
order by customer_id,
         order_date;

-- exists 运算符对比 join 关联查询
-- exists 运算符返回 TRUE 或 FALSE，而关联查询则返回另一张表的数据行
-- 在实际使用中，建议在需要判断相关表中的行是否存在，但又不用返回它们的数据时使用 exists 运算符
