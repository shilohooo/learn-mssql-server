-- SQL Server 数据定义之序列：sequence
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-sequence/
-- sequence 对象可以根据指定的规则来生成数值序列
-- 序列是一个数字列表，它们的顺序很重要，举例：{1, 2, 3} 是一个序列，{3, 2, 1} 又是一个完全不同的序列
-- 在 SQL Server 中，序列是一个用户定义在某个 schema 中的对象，用于根据一定的规则来生成数字序列
-- 它可以是升序的，也可以是倒序的，并且可以按一定的时间间隔来生成，也可以根据要求进行循环。
-- create sequence 语句用于创建新的序列对象，语法如下：
-- 指定序列的名称，该名称在当前数据库中必须是唯一的
-- create sequence [schema_name.] sequence_name
-- 指定序列的整数类型，该类型可以是任何有效的整数类型，如：tinyint、smallint、int、bigint
-- 或精度为0的 decimal 和 numeric，默认的类型为：bigint
--   [as integer_type]
-- 指定序列的起始值，起始值的范围必须在 min_value 到 max_value 之间，默认为：min_value 升序和 max_value 降序，即递增或递减
--   [ start with start_value ]
-- 指定递增或递增的步骤，该值在调用 next value for 函数时使用
-- 如果 increment_value 为负数，则序列为降序，否则为升序，increment_value 不能为0
--   [ increment by increment_value ]
-- 指定序列的最小值，默认为序列数据类型的最小值，比如：tinyint 的最小值为0，其他整数类型则为负数
--   [ { minvalue [ min_value ] } | { no minvalue } ]
-- 指定序列的最大值，默认为序列数据类型的最大值
--   [ { maxvalue [ max_value ] } | { no maxvalue } ]
-- 如果希望在序列达到最大值后重新开始，则需要指定 cycle 选项，否则序列将不再增长，且再调用 next value for 时会报错
-- 默认时：no cycle
--   [ cycle | { no cycle } ]
-- 下面这个选项用于缓存指定数量的数值，用于加快序列生成的速度，默认不开启
--   [ { cache [ cache_size ] } | { no cache } ];

use BikeStores;
-- 创建一个简单的序列
create sequence item_counter
    as int
    start with 10
    increment by 10;
-- 查询序列当前的值，输出：10
select next value for item_counter;
-- 再次执行。输出：20，因为序列的起始值为10，递增值为10，所以下一个值是10+10=20
select next value for item_counter;

-- 在单个表中使用序列对象来生成自增列的值

-- 创建 schema
create schema procurement;

-- 创建表
create table procurement.purchase_orders
(
    order_id   int primary key,
    vendor_id  int  not null,
    order_date date not null
);

-- 创建序列
create sequence procurement.order_number
    as int
    start with 1
    increment by 1;

-- 使用序列来插入数据
insert into procurement.purchase_orders(order_id, vendor_id, order_date)
values (next value for procurement.order_number, 1, '2024-04-18');

insert into procurement.purchase_orders(order_id, vendor_id, order_date)
values (next value for procurement.order_number, 2, '2024-04-18');

insert into procurement.purchase_orders(order_id, vendor_id, order_date)
values (next value for procurement.order_number, 3, '2024-04-18');

select *
from procurement.purchase_orders;

-- 在多个表中使用序列
create sequence procurement.receipt_no
    start with 1
    increment by 1;

create table procurement.goods_receipts
(
    receipt_id   int primary key default (next value for procurement.receipt_no),
    order_id     int  not null,
    full_receipt bit  not null,
    receipt_date date not null,
    note         nvarchar(255)
);

create table procurement.invoice_receipts
(
    receipt_id   int primary key default (next value for procurement.receipt_no),
    order_id     int  not null,
    is_late      bit  not null,
    receipt_date date not null,
    note         nvarchar(255)
);

INSERT INTO procurement.goods_receipts(order_id,
                                       full_receipt,
                                       receipt_date,
                                       note)
VALUES (1,
        1,
        '2019-05-12',
        'Goods receipt completed at warehouse');
INSERT INTO procurement.goods_receipts(order_id,
                                       full_receipt,
                                       receipt_date,
                                       note)
VALUES (1,
        0,
        '2019-05-12',
        'Goods receipt has not completed at warehouse');

INSERT INTO procurement.invoice_receipts(order_id,
                                         is_late,
                                         receipt_date,
                                         note)
VALUES (1,
        0,
        '2019-05-13',
        'Invoice duly received');
INSERT INTO procurement.invoice_receipts(order_id,
                                         is_late,
                                         receipt_date,
                                         note)
VALUES (2,
        0,
        '2019-05-15',
        'Invoice duly received');

SELECT * FROM procurement.goods_receipts;
SELECT * FROM procurement.invoice_receipts;

-- 序列与表没有强关联，它与表之间的关系可以由应用程序控制，它可以在多个表之间共享

-- 查询序列的信息
select * from sys.sequences;
