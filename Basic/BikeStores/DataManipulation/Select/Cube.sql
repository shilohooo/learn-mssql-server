-- SQL Server 数据操作之 Cube - 按给定字段列表生成多个（包含所有可能的）的分组集
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-cube/
-- cube 是 group by 子句的子句，可以用于生成多个分组集（grouping sets）
-- 语法：select d1, d2, d3, aggregate_function (d4) from table_name group by cube(d1, d2, d3)
-- 上述语法将根据在 cube  指定的字段列表生成所有可能的分组集：
-- (d1, d2, d3)
-- (d1, d2)
-- (d1, d3)
-- (d2, d3)
-- (d1)
-- (d2)
-- (d3)
-- () - 这是默认会添加的分组集
-- 假设 cube 子句指定了 N 个字段，那么就会生成2的 N 次幂个分组集
-- 上述语法指定了 3 个字段，所以会生成 2 * 2 * 2 = 8 个分组集

use BikeStores;
-- 以下查询使用 sales_summary 表中的数据作为示例
select brand, category, sum(sales) as sales
from sales.sales_summary
-- 以下 cube 子句将生成4个分组集：(brand, category)、(brand)、(category)、()
group by cube (brand, category);

-- 使用 cube 子句减少查询生成的分组集数量
select brand, category, sum(sales) as sales
from sales.sales_summary
-- 以下将生成3个分组集：(brand)、(category)、()
group by brand, cube (category);
