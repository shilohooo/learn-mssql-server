-- SQL Server 数据操作 - IN 运算符 - 用于判断值是否为给定列表中的任意一个
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-in/
-- in 运算符是一个逻辑运算符，允许检查一个值是否匹配给定列表中的任意一个值
-- 语法：column | expression in (value1, value2, value3, ...);
-- 首先需要指定一个列或表达式用于判断，然后需要指定一个列表用于匹配
-- 列表中的值的数据类型必须和指定的列或表达式的计算结果一致
-- 如果指定的列或表达式与给定列表中的任意一个值匹配，in 运算符的结果则为 TRUE
-- in 运算符和 多个 or 运算符是等效的，比如以下的 predicates 就是等效的：
-- column in (v1, v2, v3)
-- column = v1 or column = v2 or column = v3
-- 要执行与 in 运算符相反的操作，可以使用 not in 运算符，语法如下：
-- column | expression not in (v1, v2, v3, ...)
-- 当列的值或表达式的计算结果与给定列表中的所有值都不匹配时，not in 运算符的结果才为 TRUE
-- 给定列表除了可以使用多个值组成的 list 外，还可以使用子查询，该子查询需要返回包含单个列的多个值组成的 list，语法如下：
-- column | expression in (sub query)
-- 需要注意的是，如果给定列表中的值包含 NULL，那么 in 或 not in 运算符的结果将为 UNKNOWN

use BikeStores;
-- 以下查询将使用 products 表中的数据作为示例

-- 查询价格是 89.99,109.99,159.99 中的任意一个的产品数据
select product_name, list_price
from production.products
where list_price in (89.99, 109.99, 159.99)
order by list_price;

-- 上面的查询等价于下面使用 or 运算符的查询
select product_name, list_price
from production.products
where list_price = 89.99
   or list_price = 109.99
   or list_price = 159.99
order by list_price;

-- 查询价格不是 89.99,109.99,159.99 的产品数据
select product_name, list_price
from production.products
where list_price not in (89.99, 109.99, 159.99)
order by list_price;

-- 结合子查询和 in 运算符查询数据：查询 store_id 为1且 quantity 大于等于30的产品数据
-- 该查询示例中，子查询首先返回一个 product_id 列表
-- 接着外层查询将查询 product_id 在子查询返回结果中的产品数据
select product_id, product_name, list_price
from production.products
where product_id in (select product_id from production.stocks where store_id = 1 and quantity >= 30)
order by product_name;
