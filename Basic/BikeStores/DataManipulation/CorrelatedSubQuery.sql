-- SQL Server 数据操作之 Correlated SubQuery - 相关子查询
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-correlated-subquery/
-- 相关子查询是依赖于外部查询的子查询，它不能作为简单的子查询独立执行
-- 相关子查询会针对外部查询的每一行都执行一次，因此它也被称为重复子查询

use BikeStores;
-- 以下查询将使用 products 表中的数据作为示例

-- 查询价格等于同类产品最高价格的产品数据
select p1.product_name,
       p1.list_price,
       p1.category_id
from production.products p1
-- 如果产品的价格等于它所属类别的产品最高价，那么它的信息将被包含在查询结果集中
where list_price in (
    -- 该子查询将针对外部查询中的每种类别的产品信息都执行一次查询该产品类别中最高价格的产品信息
    -- 相关子查询在大数据集下性能不好，建议慎用
    select max(p2.list_price)
    from production.products p2
    where p1.category_id = p2.category_id
    group by p2.category_id)
order by p1.category_id,
         p1.product_name
