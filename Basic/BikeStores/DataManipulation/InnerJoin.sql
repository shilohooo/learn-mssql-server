-- SQL Server 数据操作之连表操作 Inner Join - 内联接
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-inner-join/
-- inner join 是最常用的联接查询之一，它可以从两个或多个表中获取数据，且只获取匹配的数据
-- 语法如下：select select_list from table1 inner join table2 on join_predicate
-- 上述语法中，查询从表1和表2获取数据，首先在 from 子句中指定主表为 table1
-- 然后在 inner join 子句中指定第二个表和一个连接谓词（predicate），即达成连接的条件
-- inner join 查询结果集只会包含连接谓词计算结果为 TRUE 的数据行

use BikeStores;
-- 以下查询使用 products、categories 表的数据作为示例

-- 查询产品信息和分类信息
-- 该查询为表指定了别名，因此在指定查询列的时候可以使用表别名.列表的方式，举例:
-- 不使用表别名：production.products.product_name，使用别名：p.product_name，少打了很多字~
-- 查询使用产品表的 category_id 与分类表的 category_id 列表进行匹配，只有匹配的列才会包含在查询结果集中
-- 未匹配的列会被忽略
select p.product_name,
       c.category_name,
       p.list_price
from production.products p
         inner join production.categories c
                    on p.category_id = c.category_id
order by p.product_name desc;

-- inner 关键字是可选的，如果不指定 inner，sql server 默认使用的就是内联接
select p.product_name,
       c.category_name,
       p.list_price
from production.products p
         join production.categories c
              on p.category_id = c.category_id
order by p.product_name desc;

-- 以下查询将使用 products、categories、brands 表的数据作为示例

-- 从上述三张表查询产品的名称、分类、品牌、价格
select p.product_name,
       c.category_name,
       b.brand_name,
       p.list_price
from production.products p
         inner join production.categories c
                    on p.category_id = c.category_id
         inner join production.brands b
                    on p.brand_id = b.brand_id
order by product_name desc;

