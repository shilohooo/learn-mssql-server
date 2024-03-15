-- SQL Server 数据操作之 grouping sets - 多维度分组
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-grouping-sets/

use BikeStores;
-- 创建用于测试的 sales_summary 表
-- 该表包含产品的品牌和类型每年的销售额
SELECT b.brand_name    AS brand,
       c.category_name AS category,
       p.model_year,
       round(
               SUM(
                       quantity * i.list_price * (1 - discount)
               ),
               0
       )                  sales
INTO sales.sales_summary
FROM sales.order_items i
         INNER JOIN production.products p ON p.product_id = i.product_id
         INNER JOIN production.brands b ON b.brand_id = p.brand_id
         INNER JOIN production.categories c ON c.category_id = p.category_id
GROUP BY b.brand_name,
         c.category_name,
         p.model_year
ORDER BY b.brand_name,
         c.category_name,
         p.model_year;

-- 查询数据
select brand, category, model_year, sales
from sales.sales_summary
group by brand, category, model_year, sales

-- grouping sets 是一组用于分组的列，通常来说，使用了聚合函数的单个查询定义了单个分组集
-- 例如：以下的查询定义了一个分组集，该分组集表示为 (brand, category) 的品牌和类别，该查询返回按品牌和类别分组的销售额
select brand,
       category,
       sum(sales) as sales
from sales.sales_summary
group by brand, category
order by brand, category;

-- 以下查询按品牌分组查询销售额，它定义了一个分组集 (brand)
select brand,
       sum(sales) as sales
from sales.sales_summary
group by brand
order by brand;

-- 以下查询按类别分组查询销售额，它定义了一个分组集 (category)
select category,
       sum(sales) as sales
from sales.sales_summary
group by category
order by category;

-- 以下查询定义了一个空的分组集 ()，它返回所有品牌和类别的销售额
select sum(sales) as sales
from sales.sales_summary;

-- 上面四个查询返回四个结果集和四个分组集
-- (brand, category)
-- (brand)
-- (category)
-- ()

-- 如果需要获取包含所有分组集的聚合数据的统一结果集，可以使用 UNION ALL 运算符
-- 由于 UNION ALL 运算符要求所有结果集具有相同数量的列，因此 UNION ALL 需要将查询添加到 NULL 选择列表中，如下所示：
select brand,
       category,
       sum(sales) as sales
from sales.sales_summary
group by brand, category
union all
select brand,
       null,
       sum(sales) as sales
from sales.sales_summary
group by brand
union all
select null,
       category,
       sum(sales) as sales
from sales.sales_summary
group by category
union all
select null, null, sum(sales) as sales
from sales.sales_summary
order by brand, category;

-- 以上查询包含了所有分组集的聚合，但该查询过于复杂，且查询速度很慢，因为 sql server 需要执行四个子查询，并将结果集合并为一个子查询
-- 为了解决这些问题，sql server 提供了名为 grouping sets 的 group by 子句的子句（sub clause）
-- 在同一个 grouping sets 查询中定义多个分组集，语法如下：
-- select column1,
--        column2,
--        aggregate_function (column3)
-- from table_name
-- group by
--       grouping sets (
--            (column1, column2),
--            (column1),
--            (column2),
--            ()
--       );
-- 上述语法创建了四个分组集：
-- (column1, column2),
-- (column1),
-- (column2),
-- ()

-- 使用 grouping sets 重写上面的复杂查询
-- 查询结果与上面使用 union all 运算符是一样的，但提高了可读性和性能
select brand,
       category,
       sum(sales) as sales
from sales.sales_summary
group by grouping sets ( (brand, category),
                         (brand),
                         (category),
    ()
    )
order by brand,
         category;

-- grouping 函数：用于指定 group by 子句中的列是否聚合，返回 1 表示聚合，0 表示未聚合的结果集
-- 查询示例：
-- 查询结果集中，grouping_brand 为 1 表示销售额按品牌聚合计算，grouping_category 为 1 表示销售额按类别聚合计算
select grouping(brand)    grouping_brand,
       grouping(category) grouping_category,
       brand,
       category,
       sum(sales) as      sales
from sales.sales_summary
group by grouping sets ( (brand, category),
                         (brand),
                         (category),
    ()
    )
order by brand, category;
