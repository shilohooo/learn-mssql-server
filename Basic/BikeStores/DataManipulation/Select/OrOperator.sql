-- SQL Server 数据操作 - Or 逻辑或运算符 - 用于组合多个逻辑表达式
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-or/
-- OR 是一个逻辑运算符，它可以用来组合两个布尔表达式，只要两个表达式任意一个的计算结果为 TRUE，它就为 TRUE
-- 语法：boolean_expression or boolean_expression
-- boolean_expression 是任意计算结果为 TRUE、FALSE、UNKNOWN的有效布尔表达式
-- 当在一个表达式中使用多个逻辑运算符时， SQL Server 总是先计算 AND 运算符，然后再计算 OR 运算符。
-- 但可以通过将表达式放在 () 中来改变它的计算顺序

use BikeStores;
-- 以下查询将使用 products 表的数据作为示例

-- 查询价格小于200或大于6000的产品数据
select product_name, list_price
from production.products
where list_price < 200
   or list_price > 6000
order by list_price;

-- 查询 brand_id 等于1或2或4的产品数据
select product_name, brand_id
from production.products
where brand_id = 1
   or brand_id = 2
   or brand_id = 4
order by brand_id desc;

-- 上面的查询可以用 in 运算符实现同样的查询效果
select product_name, brand_id
from production.products
where brand_id in (1, 2, 4)
order by brand_id desc;

-- 结合 AND 运算符 和 OR 运算符查询
-- 下面的查询示例将返回 brand_id 为1或 (brand_id 为2且价格大于500) 的产品数据
select product_name, brand_id, list_price
from production.products
where brand_id = 1
   or brand_id = 2 and list_price > 500
order by brand_id desc, list_price;

-- 如果想查询 (brand_id 为1或2) 且价格大于500的产品数据，可以将表达式放到括号()中
select product_name, brand_id, list_price
from production.products
where (brand_id = 1 or brand_id = 2)
  and list_price > 500
order by brand_id desc, list_price;
