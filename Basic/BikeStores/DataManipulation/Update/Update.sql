-- SQL Server 数据操作之 update - 修改表中已存在的数据
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-update/
-- 要修改表中已存在的数据，可以使用如下 update 语句：
-- update table_name
-- set column1 = value1, column2 = value2, ...columnN = valueN
-- [where condition];
-- 上述语法中，首先指定要修改数据的表名称
-- 然后指定要修改的列和新的值
-- 最后指定条件，条件是可选的，用于筛选要修改的数据
-- 如果不指定条件，则默认修改表中的所有数据

use BikeStores;
-- 创建作为示例的表 taxes
create table sales.taxes
(
    tax_id             int primary key identity (1, 1),
    state              varchar(50) not null unique,
    state_tax_rate     dec(3, 2),
    avg_local_tax_rate dec(3, 2),
    combined_tax_rate  as state_tax_rate + avg_local_tax_rate,
    max_local_tax_rate dec(3, 2),
    updated_at         datetime default getdate()
);
-- 插入测试数据
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Alabama',0.04,0.05,0.07);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Alaska',0,0.01,0.07);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Arizona',0.05,0.02,0.05);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Arkansas',0.06,0.02,0.05);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('California',0.07,0.01,0.02);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Colorado',0.02,0.04,0.08);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Connecticut',0.06,0,0);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Delaware',0,0,0);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Florida',0.06,0,0.02);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Georgia',0.04,0.03,0.04);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Hawaii',0.04,0,0);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Idaho',0.06,0,0.03);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Illinois',0.06,0.02,0.04);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Indiana',0.07,0,0);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Iowa',0.06,0,0.01);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Kansas',0.06,0.02,0.04);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Kentucky',0.06,0,0);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Louisiana',0.05,0.04,0.07);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Maine',0.05,0,0);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Maryland',0.06,0,0);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Massachusetts',0.06,0,0);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Michigan',0.06,0,0);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Minnesota',0.06,0,0.01);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Mississippi',0.07,0,0.01);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Missouri',0.04,0.03,0.05);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Montana',0,0,0);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Nebraska',0.05,0.01,0.02);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Nevada',0.06,0.01,0.01);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('New Hampshire',0,0,0);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('New Jersey',0.06,0,0);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('New Mexico',0.05,0.02,0.03);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('New York',0.04,0.04,0.04);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('North Carolina',0.04,0.02,0.02);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('North Dakota',0.05,0.01,0.03);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Ohio',0.05,0.01,0.02);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Oklahoma',0.04,0.04,0.06);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Oregon',0,0,0);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Pennsylvania',0.06,0,0.02);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Rhode Island',0.07,0,0);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('South Carolina',0.06,0.01,0.02);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('South Dakota',0.04,0.01,0.04);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Tennessee',0.07,0.02,0.02);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Texas',0.06,0.01,0.02);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Utah',0.05,0,0.02);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Vermont',0.06,0,0.01);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Virginia',0.05,0,0);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Washington',0.06,0.02,0.03);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('West Virginia',0.06,0,0.01);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Wisconsin',0.05,0,0.01);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('Wyoming',0.04,0.01,0.02);
-- INSERT INTO sales.taxes(state,state_tax_rate,avg_local_tax_rate,max_local_tax_rate) VALUES('D.C.',0.05,0,0);

-- 更新单列数据：更新 taxes 表中每一行的 updated_at 列的值为当前时间
-- 更新后的返回结果：n rows affected in 14 ms，受影响的行数为 n，即有 n 行数据被更新
update sales.taxes set updated_at = getdate();

select * from sales.taxes;

-- 更新多列数据：更新 taxes 表中 max_local_tax_rate 为 0.01 的行
update sales.taxes
set max_local_tax_rate += 0.02,
    avg_local_tax_rate += 0.01
where max_local_tax_rate = 0.01;
