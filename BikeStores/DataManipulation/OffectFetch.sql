-- SQL Server 数据操作 - Offset Fetch - 限制查询行数
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-offset-fetch/
-- offset fetch 子句是 order by 子句的选项，它可以用来限制查询返回的行数
-- 语法：select select_list from table_name order by column_list [ASC | DESC]
-- offset offset_row_count {ROW | ROWS} fetch {FIRST | NEXT} fetch_row_count {ROW | ROWS} ONLY
-- 在上述语法中，offset 子句用于指定在查询返回前要跳过的行数，offset_row_count 可以是常量、变量或大于等于0的参数
-- fetch 子句用于指定在处理 offset 子句后，要返回的行数，fetch_row_count 可以是常量、变量或大于等于0的参数
-- offset 子句是必须的，而 fetch 子句则是可选的。FIRST 和 NEXT 可以互相交换使用
-- 必须与 order by 子句一起使用 offset fetch 子句，否则会报错
-- offset fetch 子句比 top 子句更适合用来实现分页查询
-- offset fetch 子句从 SQL Server 2012（11.x）开始可以使用

-- offset fetch 子句查询示例
use BikeStores;
-- 使用 products 表的数据作为演示数据
-- 查询产品名称和价格，并按照价格、产品名称排序
select product_name, list_price
from production.products
order by list_price, product_name;

-- 使用 offset 子句跳过前10行
select product_name, list_price
from production.products
order by list_price, product_name
offset 10 rows;

-- 使用 offset 子句跳过前10行，以及使用 fetch 子句获取后面10行
select product_name, list_price
from production.products
order by list_price, product_name
offset 10 rows fetch next 10 rows only;

-- 使用 offset fetch 子句获取 top N 行
select product_name, list_price
from production.products
order by list_price desc, product_name
offset 0 rows fetch first 10 rows only;
