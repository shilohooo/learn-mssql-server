-- SQL Server 数据操作之 UNION 运算符 - 将两个或多个查询的结果集组合到一个结果集中
-- 语法：query_1 union query_2
-- 上述语法中，两个查询的列数量和顺序必须相同，列的数据类型必须相同或可以兼容
-- union 对比 union all
-- 默认情况下，union 会删除查询结果中重复的行，如果需要保留，则可以使用 union all 运算符
-- 语法：query_1 union all query_2
-- union 对比 join 关联查询
-- 关联查询组合（水平）两个表的数据，而 union 运算符组合（垂直）两个查询的数据

use BikeStores;
-- 以下查询使用 staffs、customers 表中的数据作为示例

-- 合并员工和客户的姓名，共查出 1454 条数据
select first_name,
       last_name
from sales.staffs
union
select first_name,
       last_name
from sales.customers;

-- => 10
select count(*)
from sales.staffs;
-- => 1445
select count(*)
from sales.customers;
-- 10 + 1445 = 1455，说明上述 union 查询仅删除了一条重复数据

-- 如果想把重复的数据也查出来，可以使用 union all
-- 共查出 1455 条数据
select first_name,
       last_name
from sales.staffs
union all
select first_name,
       last_name
from sales.customers;

-- union 和 order by 一起使用
-- 如果想对 union 运算符的查询结果进行排序，则需要将 order by 子句放在最后一个查询中
-- 语法：select select_list from table1 union select select_list from table2 order by order_list;
-- 示例：按客户和员工的名字和姓氏排序
select first_name,
       last_name
from sales.staffs
union all
select first_name,
       last_name
from sales.customers
order by first_name,
         last_name;
