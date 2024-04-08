-- SQL Server 数据操作之 merge - 基于另一个表的数据匹配更新指定表的数据
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-merge/
-- 假设有两张表：source 和 target，现在需要根据 source 表匹配的值更新 target 表的数据，有三种情况：
-- 1. source 表中的行在 target 表不存在，此时会新增数据到 target 表中
-- 2. target 表中的行在 source 表中不存在，此时会删除 target 表中的数据
-- 3. source 表中的某些行的 key 与 target 表中的 key 相同，但非 key 字段的值不同，此时会将 source 表的数据更新到 target 表中
-- 如果单独的使用 insert、update、delete 语句，则需要构造三个单独的语句，以使用 source 表的匹配行将数据更新到 target 表
-- SQL Server 提高了 merge 语句允许我们同时执行三个操作：插入、更新和删除，语法如下：
-- 指定目标表名称和数据源表名称
-- merge target_table using source_table
-- 然后指定匹配条件，类型与关联查询的 join 子句，通常使用主键或者唯一键进行匹配
-- on merge_condition
-- when matched then
-- 这里更新的是 source 表中存在，且在 target 表中key 字段匹配的数据
-- update_statement
-- when not matched then
-- 这里新增的是 source 表中存在，但不在 target 表中的数据
-- insert_statement
-- 这里删除的是 target 表中存在，但不在 source 表中的数据
-- when not matched by source then
-- delete_statement;

use BikeStores;
-- 创建测试用的表
create table sales.category
(
    category_id   int primary key,
    category_name varchar(255) not null,
    amount        decimal(10, 2)
);

-- 插入测试数据
INSERT INTO sales.category(category_id, category_name, amount)
VALUES (1, 'Children Bicycles', 15000),
       (2, 'Comfort Bicycles', 25000),
       (3, 'Cruisers Bicycles', 13000),
       (4, 'Cyclocross Bicycles', 10000);

create table sales.category_staging
(
    category_id   int primary key,
    category_name varchar(255) not null,
    amount        decimal(10, 2)
);

INSERT INTO sales.category_staging(category_id, category_name, amount)
VALUES (1, 'Children Bicycles', 15000),
       (3, 'Cruisers Bicycles', 13000),
       (4, 'Cyclocross Bicycles', 20000),
       (5, 'Electric Bikes', 10000),
       (6, 'Mountain Bikes', 10000);

-- 这里我们把 sales.category_staging 表作为数据源，sales.category 表作为目标表
-- 使用 merge 语句将源表中的数据更新到目标表中
merge sales.category c
using sales.category_staging cg
on c.category_id = cg.category_id
when matched
    then
    update
    set c.category_name = cg.category_name,
        c.amount        = cg.amount
when not matched
    then
    insert (category_id, category_name, amount)
    values (cg.category_id, cg.category_name, cg.amount)
when not matched by source
    then
    delete ;

select *
from sales.category;

-- 在 merge 语句执行完成后，源表和目标表的数据就一致了~