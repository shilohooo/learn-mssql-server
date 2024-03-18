-- SQL Server 数据操作之 recursive CTE - 递归公共表表达式
-- 在 SQL Server 中，递归公共表表达式（Recursive Common Table Expression，简称 Recursive CTE）是一种特殊类型的 CTE，
-- 用于处理具有层次结构或递归关系的数据。递归 CTE 可以帮助您遍历树形结构，例如组织结构、文件系统或评论嵌套等。
-- 语法如下：
-- WITH cte_name (column1, column2, ...)
-- AS
-- (
--     -- 基本查询（锚部分）
--     SELECT ...
--     FROM ...
--     WHERE ...
--
--     UNION ALL
--
--     -- 递归查询（递归部分）
--     SELECT ...
--     FROM ...
--     JOIN cte_name ON ...
--     WHERE ...
-- )
-- 表达式引用部分
-- SELECT column1, column2, ...
-- FROM cte_name;

-- 递归公共表表达式的执行顺序如下：
-- 首先会执行基本的查询，以获取基本的查询结果集，该查询结果集将用于下一次迭代
-- 然后使用上一次迭代的输入结果集执行递归查询，并返回子结果集，直到满足终止条件
-- 最后，合并所有哦查询结果集，使用 union all 运算符生成最终的查询结果集

use BikeStores;

-- 简单的示例：使用递归公共表表达式查询一周的周名称，从周一到周日
with cte_numbers(n, weekday)
         as (select 0,
                    datename(dw, 0)
             union all
             select n + 1,
                    datename(dw, n + 1)
             from cte_numbers
             -- 此处定义了结束递归查询的条件
             where n < 6)
select weekday
from cte_numbers;

-- 查询分层数据：查询没有上级领导的员工的所有下属员工的信息
WITH cte_org AS (
    -- 基本查询获取没有上级领导的员工信息
    SELECT staff_id,
           first_name,
           manager_id

    FROM sales.staffs
    WHERE manager_id IS NULL
    UNION ALL
    -- 递归查询获取经理的所有下属员工信息
    SELECT e.staff_id,
           e.first_name,
           e.manager_id
    FROM sales.staffs e
             INNER JOIN cte_org o
                        ON o.staff_id = e.manager_id)
SELECT *
FROM cte_org;
