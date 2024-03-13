-- SQL Server 数据操作 - Alias - 列与表的别名
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-alias/
-- 当使用 select 语句查询数据时，sql server 默认使用列的名称作为列的标题用于输出，请看第一个示例

use BikeStores;
-- sql server 将使用列 first_name、last_name 作为列的标题用于输出
select first_name, last_name
from sales.customers
order by first_name;

-- 可以使用 + 运算符拼接姓氏和名字来获取客户的完整姓名
-- 在该查询中，sql server 将使用 <anonymous> 作为列的标题进行输出
select first_name + ' ' + last_name
from sales.customers
order by first_name

-- 可以在查询执行之前使用列别名 column alias 给一个列或一个表达式取一个临时名称，语法如下：
-- column_name | expression as column_alias
-- 在该语法中，使用 as 关键字来分隔列或表达式与别名
-- as 关键字是可选的，也可以用如下的语法形式来给列或表达式取别名：
-- column_name | expression column_alias
-- 使用别名加强上面的查询语句的可读性
select first_name + ' ' + last_name as full_name
from sales.customers
order by first_name
-- 如果别名包含空格，则需要将别名放在引号中
select first_name + ' ' + last_name as 'Full name'
from sales.customers
order by first_name
-- 省略 as 关键字
select first_name + ' ' + last_name 'Full name'
from sales.customers
order by first_name

select category_name 'Product Category'
from production.categories

-- 当给查询列设置了别名后，可以在 order by 子句中使用列的名称或列的别名来进行排序，如下所示：
-- 因为 sql server 将在处理 select 子句之后再去处理 order by 子句，所以可以在 order by 子句中使用列的别名
select category_name 'Product Category'
from production.categories
order by category_name;

select category_name 'Product Category'
from production.categories
order by 'Product Category';

-- sql server table alias 表的别名
-- 表也可以指定别名，和给列指定别名类似，可以使用 as 关键字给表指定别名，语法如下：
-- table_name as table_alias
-- 同样也可以省略 as 关键字
-- table_name table_alias
-- 举例：
select customers.customer_id, first_name, last_name, order_id
from sales.customers
         inner join sales.orders on customers.customer_id = orders.customer_id;
-- 使用表别名加强上述查询语句的可读性
-- 当给表指定别名之后，必须使用表的别名来引用表的列，否则会报错
select c.customer_id, first_name, last_name, order_id
from sales.customers c
         inner join sales.orders o on c.customer_id = o.customer_id;
