-- SQL Server 数据操作 - between and 运算符 - 用于判断值是否在给定的范围内
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-basics-sql-server-between/
-- between 运算符是一个逻辑运算符，允许指定一个范围用于测试，语法如下：
-- column | expression between start_expression and end_expression
-- 首先指定要用于测试的列或表达式，然后指定 start_expression 和 end_expression，三者数据类型必须一致！
-- 如果列的值或表达式的计算结果大于等于 start_expression 且小于等于 end_expression，那么 between 运算符的结果为 TRUE
-- 可以使用大于等于运算符 >= 和小于等于运算符 <= 来代替 between 运算符，如下所示：
-- column | expression >= start_expression and column | expression <= end_expression
-- 使用 between 运算符比使用 >= and <= 的可读性要好很多
-- 要判断值不在给定范围内，可以使用 not between 运算符，如下所示：
-- column | expression not between start_expression and end_expression
-- 如果列的值或表达式的计算结果小于 start_expression 且大于 end_expression，那么 not between 运算符的结果为 TRUE
-- 需要注意的是：如果 between 或 not between 的任意输入为 NULL，则它们的结果为 UNKNOWN

use BikeStores;
-- 以下查询将使用 products 表中的数据作为示例

-- 结合数字使用 between 运算符进行查询：查询价格在149.99 到 199.99之间的产品数据
select product_id, product_name, list_price
from production.products
where list_price between 149.99 and 199.99
order by list_price;

-- 结合数字使用 between 运算符进行查询：查询价格不在在149.99 到 199.99之间的产品数据
select product_id, product_name, list_price
from production.products
where list_price not between 149.99 and 199.99
order by list_price;

-- 结合日期时间使用 between 运算符查询数据
-- 以下查询将使用 orders 表中的数据作为示例
-- 查询下单日志在 2017-01-15 到 2017-01-17 之间的订单数据，日期格式可以是：YYYYMMDD，也可以是：YYYY-MM-DD
select order_id, customer_id, order_date, order_status
from sales.orders
where order_date between '2017-01-15' and '2017-01-17'
order by order_date;
