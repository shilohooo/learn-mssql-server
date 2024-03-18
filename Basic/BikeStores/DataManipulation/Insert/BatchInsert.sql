-- SQL Server 数据操作之批量插入
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-insert-multiple-rows/
-- 使用单个 insert 语句插入多行数据到表中，语法如下：
-- INSERT INTO table_name (column_list)
-- VALUES
--     (value_list_1),
--     (value_list_2),
--     ...
--     (value_list_n);

-- 上述语法中，多个值列表使用逗号分隔，该语法只在 sql server 2008以及之后的版本才支持
-- 该语句一次性可以插入 1000 行数据，如果需要插入比这更多的数据，可以考虑使用多个这种语句，或者 BULK INSERT
-- 又或者使用派生表：derived table
-- 如果要将 SELECT 语句的查询结果插入到表中，可以使用 INSERT INTO SELECT 语句

use BikeStores;

-- 插入多行数据
insert into sales.promotions(promotion_name, discount, start_date, expired_date)
values ('2019 Summer Promotion', 0.15, '2019-06-01', '2019-09-01'),
       ('2019 Fall Promotion', 0.20, '2019-10-01', '2019-11-01'),
       ('2019 Winter Promotion', 0.25, '2019-12-01', '2020-01-01');

select *
from sales.promotions;

-- 插入多行并返回自增 ID 的值列表
insert into sales.promotions(promotion_name, discount, start_date, expired_date)
output inserted.promotion_id
values ('2020 Summer Promotion', 0.15, '2020-06-01', '2020-09-01'),
       ('2020 Fall Promotion', 0.20, '2020-10-01', '2020-11-01'),
       ('2020 Winter Promotion', 0.25, '2020-12-01', '2021-01-01');
