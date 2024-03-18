-- SQL Server 数据操作 - Select Top - Top N 行查询
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-select-top/
-- select top 子句可以用来限制查询结果集返回的行数（可以限制返回多少行或限制返回百分之多少行）
-- 表查询默认是没有指定排序的，因此，select top 子句必须和 order by 子句一起使用，因此，查询结果集是已排序的行的前 N 条
-- select top 子句的语法为：select top (expression) [PERCENT] [WITH TIES] from table_name order by column_name;
-- 在上述语法中，expression 用于指定需要返回的行数，如果使用了百分比，则 expression 的计算结果类型 float，否则为 bigint
-- [PERCENT] 关键字用于指定查询返回前百分之 N 行，N 是 expression 的计算结果，如 top 5 PERCENT，代表前百分之5行（行数向上取整）
-- [WITH TIES] 关键字允许返回匹配前 N 行的最后一行的数据，举例：使用 top 1 查询价格最高的产品，假设有不止一个产品的价格都为最高价，
-- 当不使用 WITH TIES 查询时，top 1 只会返回一行数据，当使用 top 1 with ties 查询时，则会返回所有价格与最高价相等的产品数据

-- 下面使用 products 表的数据作为查询示例
use BikeStores;

-- 使用 select top + 常量值的方式进行查询，要求查询价格最高的10条产品数据
select top 10 product_name, list_price
from production.products
order by list_price desc;

-- 使用 select top + 百分比的方式进行查询，要求查询价格最高的前百分之一条产品数据
-- 产品表中共有 321 条数据，而 321 的 百分之一 为 3.21，SQL Server 会对其进行向上取整，在该示例中，查询行数为 4
select top 1 percent product_name, list_price
from production.products
order by list_price desc;

-- 使用 select top with ties 进行查询，要求查询出价格最高的前3行数据，并以最后一行数据进行匹配
-- 匹配的规则是：使用最后一行数据中的 list_price 列进行匹配，找出与最后一行数据价格相同的前 3 条数据，以下是查询结果：
-- product_name - list_price
-- Trek Domane SLR 9 Disc - 2018,11999.99
-- Trek Domane SLR 8 Disc - 2018,7499.99
-- Trek Domane SL Frameset - 2018,6499.99
-- 上面三行是 top 3 查出来的，下面 3 行是 with ties 匹配查询出来的
-- 可以看到，第三行作为最后一行，它的产品价格是 6499.99，而下面查询出来的 3 行数据，价格也是 6499.99
-- 从该查询结果中可以了解到 with ties 的用法
-- Trek Domane SL Frameset Women's - 2018,6499.99
-- Trek Emonda SLR 8 - 2018,6499.99
-- Trek Silque SLR 8 Women's - 2017,6499.99
select top 3 with ties product_name, list_price
from production.products
order by list_price desc;
