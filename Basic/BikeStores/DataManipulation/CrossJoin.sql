-- SQL Server 数据操作之连表操作 cross join - 交叉联接
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-full-outer-join/
-- 语法：select select_list from table1 cross join table2;
-- cross join 将 table1 表中的每一行与 table2 表中的每一行连接起来，即：笛卡尔乘积
-- 假设 table1 总共有 n 行，table2 总共有 m 行，那么 cross join 的查询结果集总行数则为 n * m

use BikeStores;

-- 查询所有产品数据和商店数据的组合
select p.product_id,
       p.product_name,
       s.store_id,
       0 as quantity
from production.products p
         cross join sales.stores s
order by p.product_name, s.store_id

-- 查询商店中没有出售的产品
select s.store_id,
       p.product_id,
       isnull(c.sales, 0) as sales
from sales.stores s
         cross join production.products p
         left join (
    --          利用子查询查出产品的销售额
    select s.store_id,
           p.product_id,
           sum(i.quantity * i.list_price) sales
    from sales.orders o
             inner join sales.order_items i on o.order_id = i.order_id
             inner join sales.stores s on o.store_id = s.store_id
             inner join production.products p on i.product_id = p.product_id
    group by s.store_id,
             p.product_id) c on c.store_id = s.store_id
    and c.product_id = p.product_id
-- 过滤掉有销售额的产品信息
where c.sales is null
order by p.product_id,
         s.store_id;
