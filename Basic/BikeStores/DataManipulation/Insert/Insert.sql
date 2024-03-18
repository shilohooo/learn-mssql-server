-- SQL Server 数据操作之 Insert - 插入数据
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-insert/
-- 要将一行或多行数据添加到表中，可以使用 insert 语句，语法如下：
-- insert into table_name (column_list) values (value_list);
-- 首先需要指定要插入数据的表名称，通常，可以使用 schema.table_name 的形式来指定表名称，比如：production.products
-- 然后指定要插入数据的列名称，多个使用逗号分隔，这些列必须放在括号内
-- 对于未指定的列，SQL Server 会自动对表中的列使用以下的值进行插入：
-- 如果列具有 IDENTITY 属性，则它的值为下一个自增值
-- 如果列指定了默认值，则它的值为默认值
-- 如果列的数据类型为 timestamp 类型，则它的值为当前时间戳
-- 如果列可以为空，则它的值为 NULL
-- 如果列的值是需要通过计算的，那么它的值会被自动计算出来
-- 最后要提供需要插入的值（values），(column_list) 中指定的列在 (value_list) 中都要有对应的值
-- 这些值必须放在括号中！！！

use BikeStores;
-- 创建一个新的表用于演示插入数据
create table sales.promotions
(
    promotion_id   int primary key identity (1, 1),
    promotion_name nvarchar(255) not null,
    discount       numeric(3, 2) default 0,
    start_date     date          not null,
    expired_date   date          not null
);

-- 基本的插入数据示例：插入一行数据
-- 这里没有指定 promotion_id，因为它是自增的
insert into sales.promotions(promotion_name, discount, start_date, expired_date)
values ('2018 Summer Promotion', 0.15, '2018-06-01', '2018-09-01');

select *
from sales.promotions;

-- 插入数据并返回自增 ID 的值
-- 可以使用 OUTPUT 子句返回插入数据的某个列的值
insert into sales.promotions(promotion_name, discount, start_date, expired_date)
output inserted.promotion_id
values ('2018 Fall Promotion', 0.15, '2018-01-01', '2018-11-01');

-- 返回插入数据中的多个列的值
insert into sales.promotions(promotion_name, discount, start_date, expired_date)
output inserted.promotion_id,
       inserted.promotion_name,
       inserted.discount,
       inserted.start_date,
       inserted.expired_date
values ('2018 Winter Promotion', 0.2, '2018-12-01', '2019-01-01');

-- 插入数据时显示指定自增列的值
-- 执行下面的 SQL 会报错：Cannot insert explicit value for identity column in table 'promotions' when IDENTITY_INSERT is set to OFF.
-- 如果要为自增列显示指定值，则需要将 SQL 语句包含在 SET IDENTITY_INSERT sales.promotions ON 和 SET IDENTITY_INSERT sales.promotions OFF 之间
SET IDENTITY_INSERT sales.promotions ON;
insert into sales.promotions(promotion_id, promotion_name, discount, start_date, expired_date)
output inserted.promotion_id
values (4, '2019 Spring Promotion', 0.25, '2019-02-01', '2019-03-01');
SET IDENTITY_INSERT sales.promotions OFF;
