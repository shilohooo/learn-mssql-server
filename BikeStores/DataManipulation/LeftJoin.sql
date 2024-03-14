-- SQL Server 数据操作之连表操作 left Join - 左联接
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-left-join/
-- left join 是查询语句的一个子句，它可以从多个表中获取数据
-- left join 返回左表的所有行和右表的匹配行，对于右表中未匹配的行，它所对应的列的值是 NULL
-- 语法：select select_list from table1 left join table2 on join_predicate
-- 上述语法中，左表是 table1，右表是 table2
-- left join（左联接）和 left outer join（左外联接）是一样的，outer 关键字是可选的

use BikeStores;
-- 以下查询将使用 products、order_items 表的数据作为示例

-- 查询订单项和关联的产品信息
-- 查询结果中，order_id 为 NULL 的列代表该产品还没有出售给任何客户
select p.product_name,
       o.order_id
from production.products p
         left join sales.order_items o
                   on p.product_id = o.product_id
order by o.order_id;

-- 通过添加查询条件 where o.order_id is null，可以只查询没有出售过的产品信息
-- Sql Server 首先会处理 left join 子句，然后再处理 where 子句
select p.product_name,
       o.order_id
from production.products p
         left join sales.order_items o
                   on p.product_id = o.product_id
where o.order_id is null
order by o.order_id;

-- 使用 left join 关联查询三张表的数据
select p.product_name,
       o.order_id,
       i.item_id,
       o.order_date
from production.products p
         left join sales.order_items i
                   on p.product_id = i.product_id
         left join sales.orders o
                   on i.order_id = o.order_id
order by o.order_id;

-- left join 中，在 on 子句使用条件和在 where 使用条件
-- 查询 order_id 等于 100 的数据
select p.product_name,
       o.order_id
from production.products p
         left join sales.order_items o
                   on p.product_id = o.product_id
where o.order_id = 100
order by o.order_id;
-- 将查询条件移至 on 子句，该查询会把 order_id 为 NULL 的数据也查出来
-- 请注意，对于 inner join，把查询条件放在 on 子句和放在 where 子句效果是一样的
select p.product_name,
       o.order_id
from production.products p
         left join sales.order_items o
                   on p.product_id = o.product_id
                       and o.order_id = 100
order by o.order_id desc;
