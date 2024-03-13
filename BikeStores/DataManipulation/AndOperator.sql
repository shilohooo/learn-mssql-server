-- SQL Server 数据操作 - AND 逻辑与运算符 - 用于组合多个逻辑表达式
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-and/
-- AND 是一个逻辑运算符，它可以用来组合两个布尔表达式，只有在两个表达式的计算结果都为 TRUE 时它才为 TRUE
-- 语法：boolean_expression and boolean_expression
-- boolean_expression 是任意计算结果为 TRUE、FALSE、UNKNOWN的有效布尔表达式
-- 当在一个表达式中使用多个逻辑运算符时， SQL Server 总是先计算 AND 运算符
-- 可以通过将表达式放在 () 中来改变它的计算顺序

use BikeStores;
-- 以下查询将使用 products 表的数据作为示例

-- 查询 category_id 为1且价格大于400的产品数据
select *
from production.products
where category_id = 1
  and list_price > 400
order by list_price desc;

-- 查询 category_id 为1且价格大于400且 brand_id 为1的产品数据
select *
from production.products
where category_id = 1
  and list_price > 400
  and brand_id = 1
order by list_price desc;

-- 结合其他逻辑运算符使用 AND 逻辑运算符
-- 下面这个查询示例将返回 brand_id = 1 或者 (brand_id = 2且价格大于1000) 的产品数据
select *
from production.products
where brand_id = 1
   or brand_id = 2 and list_price > 1000
order by list_price desc;

-- 要查询 brand_id 为1或者2，且价格大于1000的产品数据，可以将表达式放到括号()中
select *
from production.products
where (brand_id = 1 or brand_id = 2)
  and list_price > 1000
order by list_price desc;
