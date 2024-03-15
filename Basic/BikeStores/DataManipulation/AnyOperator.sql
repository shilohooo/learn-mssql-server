-- SQL Server 数据操作之 ANY 运算符
-- ANY 运算符是一个逻辑运算符，用于将单个列与子查询返回的由单列值组成的结果集进行比较
-- 语法：scalar_expression comparison_operator any (sub query);
-- 在上述语法中：
-- scalar_expression 可以是任何有效的表达式
-- comparison_operator 可以是任何比较运算符：大于、等于、小于、大于等于、小于等于
-- (sub query) 是一个查询语句，它返回单个列的结果集，列的数据类型与 scalar_expression 相同
-- 举例：
-- scalar_expression 为 column1
-- comparison_operator 为 > (大于)
-- 子查询返回的结果集为：(v1, v2, v3, ...)
-- 那么当 column1 大于 (v1, v2, v3, ...) 列表中的任意一个值时，any 运算符的计算结果就为 TRUE，否则为 FALSE

use BikeStores;
-- 以下查询使用 products 表中的数据作为示例

-- 查询销售超过两件的产品数据
select product_name,
       list_price
from production.products
where product_id = any (select product_id
                        from sales.order_items
                        where quantity >= 2)
order by product_name;
