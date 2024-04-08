-- SQL Server 数据操作之 delete - 删除表中的一行或多行数据
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-delete/
-- 删除语句语法如下：
-- delete [ TOP (expression) [ percent ] ]
-- from table_name
-- [where search_condition];
-- 首先在 from 子句中指定要删除数据的表名称
-- 接着可以使用 TOP 子句删除随机的行数，如：delete top 10 percent from table_name，将随机删除百分之10的数据行
-- 最后使用 where 子句来筛选要删除的数据，如果不指定条件，将删除表中的所有数据！！！

use BikeStores;
-- 创建用于测试的表，通过 select into 语句复制 production.products 表中的数据到 production.product_history 表中
select *
into production.product_history
from production.products;

select *
from production.product_history;
-- 从 production.product_history 表中随机删除 10 行数据
delete top (10)
from production.product_history;
-- 从 production.product_history 表中随机删除 10% 的数据行（向上取整）
delete top (10) percent
from production.product_history;
-- 从 production.product_history 表中删除 model_year = 2017 的数据行
delete
from production.product_history
where model_year = 2017;
-- 删除表中的所有数据
delete
from production.product_history;
-- 需要注意的是，如果要删除的表数据量非常大，则应用使用更快、更高效的 TRUNCATE TABLE 语句
-- 两者的区别请看本目录下的：DeleteTable与TruncateTable的区别.md