-- SQL Server 数据操作之 update join - 关联表更新
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-update-join/
-- SQL Server 中，可以在 update 语句使用 join 子句来进行关联表更新，语法如下：
-- update t1
-- set t1.column1 = t2.column2,
-- t1.column2 = expression
-- from t1
-- [ inner | left ]join t2 on join_predicate
-- where where_predicate;
-- 上述语法中，首先指定了要更新数据的表名称 t1
-- 然后指定了要更新的列
-- 接着在 from 子句再次指定了要更新数据的表名称 t1
-- 然后使用 inner join 或 left join 关联表 t2
-- 最后指定 where 条件筛选要更新数据的行
-- where 条件是可选的，用于筛选要更新的行
-- 如果不指定 where 条件，则默认更新表中的所有行

use BikeStores;
-- 创建用于测试的表 sales.targets，存储销售指标
drop table if exists sales.targets;

create table sales.targets
(
    target_id  int primary key,
    percentage decimal(4, 2) not null default 0
);

-- 插入测试数据
insert into sales.targets(target_id, percentage)
values (1, 0.2),
       (2, 0.3),
       (3, 0.5),
       (4, 0.6),
       (5, 0.8);

select *
from sales.targets;

-- 创建用于测试的表 sales.commissions，存储销售佣金
drop table if exists sales.commissions;

create table sales.commissions
(
    staff_id    int primary key,
    target_id   int,
    base_amount decimal(10, 2) not null default 0,
    commission  decimal(10, 2) not null default 0,
    foreign key (target_id) references sales.targets (target_id),
    foreign key (staff_id) references sales.staffs (staff_id)
);

-- 插入测试数据
insert into sales.commissions(staff_id, base_amount, target_id)
values (1, 100000, 2),
       (2, 120000, 1),
       (3, 80000, 3),
       (4, 900000, 4),
       (5, 950000, 5);

select *
from sales.commissions;

-- 根据销售人员的销售指标计算他们的佣金
update sales.commissions
set sales.commissions.commission = c.base_amount * t.percentage
from sales.commissions c
         inner join sales.targets t
                    on c.target_id = t.target_id;

-- 插入新数据
insert into sales.commissions(staff_id, base_amount, target_id)
values (6, 100000, null),
       (7, 120000, null);

-- 更新佣金
update sales.commissions
-- coalesce(t.percentage, 0.1)，如果 t.percentage 为 null，则使用 0.1
set sales.commissions.commission = c.base_amount * coalesce(t.percentage, 0.1)
from sales.commissions c
         left join sales.targets t
                   on c.target_id = t.target_id;

select *
from sales.commissions;