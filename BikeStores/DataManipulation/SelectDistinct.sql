-- SQL Server 数据操作 - Select Distinct - 去重
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-select-distinct/
-- 可以使用 select distinct 子句查询某列不重复的值，语法如下：
-- select distinct column_name from table_name;
-- 查询结果将返回指定列不重复的值，即：去掉重复的值
-- 如果 select distinct 子句后面跟着的列不止一个，那么查询结果将根据这些列的组合来去重
-- 如果 select distinct 子句后面跟着的列允许 NULL 值，那么查询结果将只会包含一个 NULL 值

use BikeStores;
-- 使用 customers 表的数据作为查询示例

-- 使用 select distinct 查询单列：查询客户所属的城市信息
select distinct city
from sales.customers
order by city;

-- 使用 select distinct 查询多列：查询客户所属的城市和州信息
-- 该查询示例中，使用 city 和 state 组合成唯一值来去重
select distinct city, state
from sales.customers
order by city, state;

-- 使用 select distinct 查询可以为 NULL 的列：查询客户的手机号码
-- 该查询示例中，distinct 子句只会保留一个 NULL 值
select distinct phone
from sales.customers
order by phone;

-- group by
select city, state, zip_code
from sales.customers
group by city, state, zip_code
order by city, state, zip_code;

-- 上面的 group by 查询与下面的 distinct 查询相同
select distinct city, state, zip_code
from sales.customers
order by city, state, zip_code;

-- 当需要在一个或多个列中使用聚合函数时，应该使用 group by ，而不是 distinct
