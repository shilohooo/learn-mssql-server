-- SQL Server 数据操作 - 排序
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-order-by/
-- 当使用查询语句从表中查询数据时，结果集中的行默认是没有进行排序的，这意味着 SQL Server 可以使用未指定的顺序返回结果集
-- 对结果集中的数据行进行排序的唯一方式是使用 order by 子句
-- 语法为：select select_list from table_name order by column_name | expression [ ASC | DESC ];
-- column_name | expression 指定用于对结果集的行进行排序的列名或表达式，如果指定了多个列名，则先按第一个列排序，然后再按第二个，以此类推
-- order by 子句中指定的列必须在 select_list 中，或在 from 子句指定的表中定义好了
-- ASC | DESC 使用 ASC 或 DESC 指定按升序还是倒叙进行排序，默认为 ASC，即升序，注意：SQL Server 将 NULL 视为最低值
-- 当需要处理的查询语句包含 order by 子句时，它将被放到最后处理

-- 切换数据库
use BikeStores;

-- 下面以 sales.customers 表进行排序示例
-- 使用单个列对查询结果集进行升序排序
select first_name, last_name
from sales.customers
order by first_name;

-- 使用单个列对查询结果集进行倒序排序
select first_name, last_name
from sales.customers
order by first_name desc;

-- 使用多个列对查询结果集进行升序排序
select city, first_name, last_name
from sales.customers
order by city, first_name;

-- 使用多个列对查询结果集进行排序，每个列排序方式不一样
select city, first_name, last_name
from sales.customers
order by city desc, first_name;

-- 使用不在 select 子句中的列对查询结果集进行排序
select city, first_name, last_name
from sales.customers
order by state;

-- 使用表达式对查询结果集进行排序：按名字长度倒序排序
select first_name, last_name
from sales.customers
order by len(first_name) desc;

-- 按照查询子句中列的顺序进行排序
-- 以下查询没有指定排序的列名，而是通过它们在 select 子句中的声明顺序来替代列名，这在 SQL Server 中是允许的
-- 1 表示 first_name 列，2 表示 last_name 列
-- 但该方式不推荐使用，因为可读性太差，且当修改了 select 子句中的列的声明顺序时，容易忘记改 order by 子句中的列的顺序
-- 建议始终使用指定列名的方式
select first_name, last_name
from sales.customers
order by 1, 2;
