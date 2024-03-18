-- SQL Server 数据操作之连表操作 right Join - 右联接
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-right-join/
-- right join 是查询语句的一个子句，它可以从多个表中获取数据
-- right join 返回右表的所有行和左表的匹配行，对于左表中未匹配的行，它所对应的列的值是 NULL
-- 语法：select select_list from table1 right join table2 on join_predicate
-- 上述语法中，左表是 table1，右表是 table2
-- right join（右联接）和 right outer join（右外联接）是一样的，outer 关键字是可选的

use BikeStores;
-- 以下查询将使用 order_items、products 表中的数据作为示例

-- 查询所有产品名称和匹配的订单 ID，如果没有匹配的订单 ID，则为 NULL
select p.product_name,
       o.order_id
from sales.order_items o
         right join production.products p
                    on o.product_id = p.product_id
order by o.order_id;

-- 添加查询条件，只查询没有出售的产品信息
select p.product_name,
       o.order_id
from sales.order_items o
         right join production.products p
                    on o.product_id = p.product_id
where o.order_id is null
order by o.order_id;
