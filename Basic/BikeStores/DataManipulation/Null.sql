-- SQL Server 数据操作 - NULL 空值
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-null/
-- 在数据库中，NULL 表示没有任何数据值，比如：客户的邮箱可能是未知的，此时 customers 表中的记录为 NULL
-- 当逻辑表达式在求值中包含了 NULL 时，它的结果将是 UNKNOWN，也就是说，逻辑表达式的结果不仅为 TRUE、FALSE、还可以是 UNKNOWN
-- 下列的比较结果皆为 UNKNOWN：
-- NULL = 0
-- NULL <> 0
-- NULL > 0
-- NULL = NULL

-- NULL 不等于任何值，包括它自己，这意味着 NULL 不等于 NULL，因为每一个 NULL 都可能是不一样的

use BikeStores;
-- 使用 customers 表的数据作为查询示例

-- IS NULL 运算符：查询没有手机号码的客户数据
-- 下面这个查询不会返回任何数据，因为 where 子句后面的逻辑表达式计算结果为 UNKNOWN
select customer_id, first_name, last_name, phone
from sales.customers
where phone = null
order by first_name, last_name;

-- 要判断值是否为空，应使用 is null 运算符
select customer_id, first_name, last_name, phone
from sales.customers
where phone is null
order by first_name, last_name;

-- 要判断值是否不为空，应使用 is not null 运算符
-- 举例：查询手机号码不为空的客户数据
select customer_id, first_name, last_name, phone
from sales.customers
where phone is not null
order by first_name, last_name;

