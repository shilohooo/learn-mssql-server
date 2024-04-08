-- SQL Server 数据操作之 transaction - 事务
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-transaction/
-- 事务是包含多个 T-SQL 语句的单个工作单元
-- 事务具有 ACID 特性：
-- 原子性（Atomicity）：事务中的所有操作要么全部执行，要么全部不执行
-- 一致性（Consistency）：事务执行之前和执行之后，数据库的状态必须保持一致
-- 隔离性（Isolation）：事务执行期间，不能被其他事务干扰
-- 持久性（Durability）：事务一旦提交，结果就会永久保存到数据库中
-- 执行单个语句，如：insert、delete、update，SQL Server 会自动提交事务
-- 如果想显示的启动事务，可以使用 begin transaction 或 begin tran 语句来启动事务，语法如下：
-- begin transaction;
-- begin tran;
-- 然后在事务中执行一个或多个语句，如：insert、delete、update
-- insert_statements;
-- delete_statements;
-- update_statements;
-- 最后，使用 commit 语句提交事务
-- commit;
-- 或者使用 rollback 语句回滚事务
-- rollback;
-- 完整语法如下：
-- begin transaction;
-- other_statements;
-- commit; / rollback;

use BikeStores;
-- 创建用于测试的表
create table sales.invoices
(
    id          int identity primary key,
    customer_id int            not null,
    total       decimal(10, 2) not null default 0 check (total >= 0)
);

create table sales.invoice_items
(
    id         int primary key,
    invoice_id int            not null,
    item_name  nvarchar(100)  not null,
    amount     decimal(10, 2) not null check (amount >= 0),
    tax        decimal(4, 2)  not null check (tax >= 0),
    foreign key (invoice_id) references sales.invoices (id)
        on update cascade
        on delete cascade
);

-- 开启事务
begin transaction;

-- 插入测试数据
insert into sales.invoices(customer_id, total)
values (100, 0);

insert into sales.invoice_items(id, invoice_id, item_name, amount, tax)
values (10, 1, 'Keyboard', 70, 0.08),
       (20, 1, 'Mouse', 50, 0.08);

-- 更新数据
update sales.invoices
set total = (select sum(amount * (1 + tax)) from sales.invoice_items where invoice_id = 1);

-- 提交事务
commit;

select *
from sales.invoices;