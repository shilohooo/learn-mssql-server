-- SQL Server 数据操作之 insert into select - 根据查询结果集插入数据
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-insert-into-select/
-- insert into select 语句可以将一张表的数据插入到另一张表中，语法如下：
-- INSERT  [ TOP ( expression ) [ PERCENT ] ]
-- INTO target_table (column_list)
-- query

-- 上述语法中，query 语句返回的行将插入到 target_table 中
-- query 语句可以是任意有效的查询语句，它必须返回与 (column_list) 指定的列对应的数据
-- [ TOP ( expression ) [ PERCENT ] ] 子句是可选的，它可以限制要插入的数据行数
-- 注意：应该始终将 TOP 子句和 Order by 子句一起使用

use BikeStores;
-- 创建用于演示的 addresses 表
create table sales.addresses
(
    address_id int identity primary key,
    street     nvarchar(255) not null,
    city       nvarchar(50),
    state      nvarchar(50),
    zip_code   nvarchar(50)
);

-- 把客户的地址插入到 addresses 表中
insert into sales.addresses(street, city, state, zip_code)
select street,
       city,
       state,
       zip_code
from sales.customers
order by first_name,
         last_name;

select *
from sales.addresses;

-- 使用 where 子句筛选要插入的数据
insert into sales.addresses(street, city, state, zip_code)
select street,
       city,
       state,
       zip_code
from sales.stores
where city in ('Santa Cruz', 'Baldwin');

-- 使用 Top 子句限制插入的行数
-- 先清空 addresses 表中的数据
truncate table sales.addresses;
-- 按名字和姓氏排序，插入前10个客户的地址
insert top (10) into sales.addresses(street, city, state, zip_code)
select street,
       city,
       state,
       zip_code
from sales.customers
order by first_name,
         last_name;

-- 使用 Top 子句插入前百分之几行数据
insert top (10) percent into sales.addresses(street, city, state, zip_code)
select street,
       city,
       state,
       zip_code
from sales.customers
order by first_name,
         last_name;
