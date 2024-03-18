-- SQL Server 数据操作之 except 运算符 - 从两个查询结果集中返回不同的行
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-except/
-- 语法：query_1 except query_2
-- 上述语法中，两个查询的列和列的顺序必须一致
-- 两个查询的列的数据类型必须相同或兼容

-- 假设有两个查询结果集：T1、T2
-- T1 结果集包括：1、2、3
-- T2 结果集包括：2、3、4
-- T1 except T2 将返回 1，这是 T1 结果集在 T2 中不存在的行

-- except 返回的是第一个查询结果集中存在的行，但在第二个查询结果集中不存在的行。
-- 换句话说，它可以帮助找到两个结果集之间的差异。

use BikeStores;
-- 以下查询将使用 products、order_items 表的数据进行示例

-- 使用 except 运算符查询没有销售的产品 ID
select product_id
from production.products
except
select product_id
from sales.order_items;

-- 上面的查询中，第一个查询返回所有产品的ID，第二个查询返回有下单的产品 ID
-- 然后使用 except 运算符将已销售过的产品 ID 去除掉

-- except 运算符和 order by 子句
-- 如果需要对 except 运算符的查询结果集进行排序，可以在最好一个查询中指定排序条件
select product_id
from production.products
except
select product_id
from sales.order_items
order by product_id;
