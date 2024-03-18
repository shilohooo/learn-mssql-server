-- SQL Server 数据操作之 Rollup - 按给定字段列表生成多个（有层次结构）的分组集
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-rollup/
-- 与 cube 子句不同，rollup 子句不会生成所有可能的分组集，rollup 假定给定字段列表之间存在层次结构，并且仅基于此层次结构生成分组集
-- 举例：cube 子句 cube (d1, d2, d3) 生成了以下八个分组集：
-- (d1, d2, d3)
-- (d1, d2)
-- (d1, d3)
-- (d2, d3)
-- (d1)
-- (d2)
-- (d3)
-- ()
-- 如果使用 rollup 子句 rollup (d1, d2, d3)，则只会生成以下四个分组集：
-- (d1, d2, d3)
-- (d1, d2)
-- (d1)
-- ()
-- rollup 子句通常用于计算分层数据的聚合结果，例如：按年>季度>月的销售额，具体语法如下：
-- select d1, d2, d3, aggregate_function (d4) from table_name group by rollup (d1, d2, d3);
-- 上述语法将按照层次结构 d1 > d2 > d3 计算列 d4 的值，还可以使用如下语法减少生成的计算：
-- select d1, d2, d3, aggregate_function (d4) from table_name group by d1, rollup (d2, d3);

use BikeStores;
-- 以下查询将使用 sales_summary 表中的数据作为示例

-- 使用 rollup 子句按品牌（小计）以及品牌和类别（总计）计算销售额
-- 该查询假定品牌和类别之间存在层级结构：品牌>类别
select brand,
       category,
       sum(sales) as sales
from sales.sales_summary
group by rollup (brand, category);

-- 按层级结构：类别>品牌细分，查询结果是不一样的
select category,
       brand,
       sum(sales) as sales
from sales.sales_summary
group by rollup (category, brand);

-- 仅查询部分汇总
select brand,
       category,
       sum(sales) as sales
from sales.sales_summary
group by brand, rollup (category);
