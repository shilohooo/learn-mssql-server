-- SQL Server 数据操作之 all 运算符
-- all 运算符是一个逻辑运算符，用于将单个列与子查询返回的由单列值组成的结果集进行比较
-- 语法：scalar_expression comparison_operator all (sub query);
-- 在上述语法中：
-- scalar_expression 可以是任何有效的表达式
-- comparison_operator 可以是任何比较运算符：大于(>)、等于(=)、小于(<)、大于等于(>=)、小于等于(<=)、不等于(<>)
-- (sub query) 是一个查询语句，它返回单个列的结果集，列的数据类型与 scalar_expression 相同
-- 举例：
-- scalar_expression 为 column1
-- comparison_operator 为 > (大于)
-- 子查询返回的结果集为：(v1, v2, v3, ...)
-- 那么当 column1 大于 (v1, v2, v3, ...) 列表中的全部值时，all 运算符的计算结果就为 TRUE，否则为 FALSE

use BikeStores;
-- 以下查询将使用 products 表中的数据作为示例

-- 根据品牌分组，查询每个产品的均价
select avg(list_price) avg_list_price
from production.products
group by brand_id
order by avg_list_price;

-- 结合大于运算、子查询使用 all 运算符查询数据
-- 当 scalar_expression 大于子查询返回结果集中的所有值时，all 运算符的计算结果为 TRUE
-- 示例：查询价格高于所有品牌的产品均价的产品数据
select product_name,
       list_price
from production.products
where list_price > all (select avg(list_price) avg_list_price
                        from production.products
                        group by brand_id)
order by list_price;

-- 结合小于运算、子查询使用 all 运算符查询数据
-- 当 scalar_expression 小于子查询返回结果集中的所有值时，all 运算符的计算结果为 TRUE
-- 示例：查询价格小于所有品牌的产品均价的产品数据
select product_name,
       list_price
from production.products
where list_price < all (select avg(list_price) avg_list_price
                        from production.products
                        group by brand_id)
order by list_price desc;
