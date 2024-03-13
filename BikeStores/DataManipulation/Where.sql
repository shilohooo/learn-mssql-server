-- SQL Server 数据操作 - Where - 条件查询
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-where/
-- 在 Select 查询中可以使用 Where 子句来指定一个或多个条件，用于过滤数据，语法如下：
-- select select_list from table_name where search_condition;
-- search_condition 是一个或多个逻辑表达式的组合，一个逻辑表达式通常又称为 predicate
-- 在 where 子句中，当指定了一个查询条件后，查询结果集只会返回逻辑表达式计算为 TRUE 的行
-- 逻辑表达式的计算结果可以是：TRUE、FALSE、UNKNOWN，where 子句不会返回计算结果为 FALSE 或 UNKNOWN 的行

use BikeStores;
-- 使用 products 表的数据作为查询示例

-- 查询 category_id 等于1的产品信息
select product_id, product_name, category_id, model_year, list_price
from production.products
where category_id = 1
order by list_price desc;

-- 结合 AND 运算符使用 where 子句查询数据，AND 用于拼接多个查询条件
-- 且匹配满足每个逻辑表达式的计算结果都为 TRUE 的行，即逻辑与的关系

select product_id, product_name, category_id, model_year, list_price
from production.products
where category_id = 1
  and model_year = 2018
order by list_price desc;

-- 结合比较运算符和 where 子句查询数据：查询价格大于 300 且年份等于2018的产品数据
select product_id, product_name, category_id, model_year, list_price
from production.products
where list_price > 300
  and model_year = 2018
order by list_price desc;

-- 结合 OR 运算符和 where 子句查询数据，OR 也可以用于拼接查询条件
-- 与 AND 不同的是，OR 匹配满足任意一个逻辑表达式的计算结果为 TRUE 的行
-- 示例：查询价格大于3000或 model_year 为2018的产品数据
select product_id, product_name, category_id, model_year, list_price
from production.products
where list_price > 3000
   or model_year = 2018
order by list_price desc;

-- 结合 between and 和 where 子句查询数据：查询价格在 1899 到 1999.99 之间的产品数据
select product_id, product_name, category_id, model_year, list_price
from production.products
where list_price between 1899 and 1999.99
order by list_price desc;

-- 结合 in 和 where 子句查询数据：查询价格在 299.99、369.99、489.99 之中的产品数据
select product_id, product_name, category_id, model_year, list_price
from production.products
where list_price in (299.99, 369.99, 489.99)
order by list_price desc;

-- 结合 like 和 where 子句进行模糊查询：查询产品名称包含 Cruiser 字符串的产品数据
select product_id, product_name, category_id, model_year, list_price
from production.products
where product_name like '%Cruiser%'
order by list_price;

-- 查询产品名称以 E 开头的产品数据
select product_id, product_name, category_id, model_year, list_price
from production.products
where product_name like 'E%'
order by list_price desc;

-- 查询产品名称以 2017 结尾的产品数据
select product_id, product_name, category_id, model_year, list_price
from production.products
where product_name like '%2017'
order by list_price desc;
