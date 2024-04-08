-- SQL Server 数据操作之 pivot - 将行转换为列
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-pivot/

use BikeStores;
-- 以下代码将使用 production.products 和 production.categories 表作为示例
-- 查询每个产品类型的产品数数量
select c.category_name, count(p.product_id) as product_count
from production.products p
         inner join production.categories c
                    on p.category_id = c.category_id
group by c.category_name
order by count(p.product_id);

-- 下面我们将产品类别的名称作为列名称，产品数量作为值，然后添加模型年份进行分组
-- pivot 运算符可以将列中的唯一值转换为输出中的多个列，并对剩余的列值执行聚合操作
-- 首先查询产品类型和产品ID
select c.category_name, p.product_id
from production.products p
         inner join production.categories c
                    on p.category_id = c.category_id
-- 根据上面的查询创建临时结果集
select *
from (select c.category_name, p.product_id
      from production.products p
               inner join production.categories c
                          on p.category_id = c.category_id) t;
-- 对查询结果集应用 pivot 运算符
select *
from (select c.category_name, p.product_id
      from production.products p
               inner join production.categories c
                          on p.category_id = c.category_id) t
         pivot (
         count(product_id)
         for category_name in (
        [Children Bicycles],
        [Comfort Bicycles],
        [Cruisers Bicycles],
        [Cyclocross Bicycles],
        [Electric Bikes],
        [Mountain Bikes],
        [Road Bikes]
        )
         ) as pivot_table;
-- 之后，添加其他查询列，这些列会自动形成行组，如：添加模型年份
select *
from (select c.category_name, p.product_id, p.model_year
      from production.products p
               inner join production.categories c
                          on p.category_id = c.category_id) t
         pivot (
         count(product_id)
         for category_name in (
        [Children Bicycles],
        [Comfort Bicycles],
        [Cruisers Bicycles],
        [Cyclocross Bicycles],
        [Electric Bikes],
        [Mountain Bikes],
        [Road Bikes]
        )
         ) as pivot_table;
-- 上面的查询需要手写列名，下面我们来生成列名称列表，并在查询中复用
declare @columns nvarchar(max) = '',
    @sql nvarchar(max) = '';

-- quotename(col_name)，将使用放括号[]将列名括起来
select @columns += quotename(category_name) + ','
from production.categories
order by category_name;

-- left(str, char_length)，从左边截取指定长度的字符串
-- 这里是用来去掉逗号的
set @columns = left(@columns, len(@columns) - 1);

-- print @columns;

-- 生成动态 SQL
set @sql = 'select *
from (select c.category_name, p.product_id, p.model_year
      from production.products p
               inner join production.categories c
                          on p.category_id = c.category_id) t
         pivot (
         count(product_id)
         for category_name in (' + @columns + ')
         ) as pivot_table;'

-- 通过调用存储过程来执行动态 sql
execute sp_executesql @sql;