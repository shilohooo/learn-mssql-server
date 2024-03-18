-- SQL Server 数据操作之 intersect - 交集，合并两个或多个查询的结果集，并返回不同的数据行
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-intersect/
-- 语法：query_1 intersect query_2
-- 上述语法中，两个查询的列数量和顺序必须相同
-- 查询列的数据类型必须相同或兼容
-- 假设有两个查询结果集：T1、T2
-- T1 结果集包括：1、2、3
-- T2 结果集包括：2、3、4
-- T1 和 T2 结果集的交集返回不同的行，即 2 和 3

use BikeStores;
-- 假设有如下查询：
select city
from sales.customers
intersect
select city
from sales.stores
order by city;

-- 上面的查询中，第一个查询获取 customers 表的所有城市，第二个查询获取 stores 表的所有城市
-- 然后使用 intersect 关键字取两个查询的交集，然后输出它们之间不同的行
-- 排序子句添加到最后一个查询中，以便对最终的查询结果集进行排序
