-- SQL Server 数据操作 - 查询
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-select/

-- 切换数据库
use BikeStores;
-- 查询语句的语法：select select_list from schema.table_name;
-- 在 select 子句后面指定要查询的列名，多个使用英文逗号分隔，在 from 子句后面指定要查询的表名和 schema
-- 当处理查询语句时，首先会处理 from 子句，然后是 select 子句
-- 下面以查询 sales.customers 表作为示例

-- 查询所有客户的姓名，包含姓氏和名字，查询语句的结果被称为：result set，即：结果集
select first_name, last_name
from sales.customers;

-- 查询所有客户的姓名和邮箱
select first_name, last_name, email
from sales.customers;

-- 查询客户所有数据，可以使用 * 号或者指定所有列名来查询所有列
select *
from sales.customers;

-- 使用 where 子句过滤数据
-- 当指定了 where 子句时，查询语句的处理顺序为：from 子句 => where 子句 => select 子句
-- 查询 state 为 CA 的客户数据
select *
from sales.customers
where state = 'CA';

-- 使用 order by 子句对数据进行排序
-- 当指定了 order by 子句 时，查询语句的处理顺序为：from 子句 => where 子句 => select 子句 => order by 子句
-- 查询 state 为 CA 的客户数据，并按名字排序，默认为升序
select *
from sales.customers
where state = 'CA'
order by first_name;

-- 使用 group by 子句对查询结果进行分组
-- 当指定了 group by 子句时，查询语句的处理顺序为：from 子句 => where 子句 => group by 子句 => select 子句 => order by 子句
-- 查询 state 为 CA 的客户数据，并按 city 进行分组，统计每个城市的客户数量，最后按 city 进行排序
select city, count(*)
from sales.customers
where state = 'CA'
group by city
order by city;

-- 使用 having 子句对已分组的查询结果进行过滤
-- 查询 state 为 CA 的客户数据，并按 city 进行分组，统计每个城市的客户数量，并筛选分组中客户数量大于 10 的数据，最后按 city 进行排序
-- 请注意：where 子句过滤数据行，having 子句过滤分组
select city, count(*)
from sales.customers
where state = 'CA'
group by city
having count(*) > 10
order by city;
