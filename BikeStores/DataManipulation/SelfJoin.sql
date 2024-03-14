-- SQL Server 数据操作之连表操作 self join - 自联接 - 表关联自己
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-self-join/
-- 自联接使用 inner join 或 left join 子句实现，因为查询中将使用自联接引用相同的表，表别名将用于为同一张表指定不同的名称
-- 注意：在查询中引用相同的表，但没有使用表别名的话会报错
-- 语法：select select_list from t t1 [inner | left] join t t2 on join_predicate;
-- 上述查询语法引用了两次表 t，并使用了不同的别表名 t1 和 t2

use BikeStores;

-- 使用自联接查询层级数据：staff 表记录了员工的基本信息，还有一个代表其直接领导的列 manager_id
-- 查询员工的直接领导
select e.first_name + ' ' + e.last_name employee,
       m.first_name + ' ' + m.last_name manager
from sales.staffs e
         inner join sales.staffs m
                    on m.staff_id = e.manager_id
order by manager;

-- 使用左联接查询没有直接领导的员工
select e.first_name + ' ' + e.last_name employee,
       m.first_name + ' ' + m.last_name manager
from sales.staffs e
         left join sales.staffs m
                   on m.staff_id = e.manager_id
order by manager;

-- 使用自联接对比表中的数据行
-- 查询在同一个城市的客户数据
select c1.customer_id                     customer_id1,
       c1.city,
       c1.first_name + ' ' + c1.last_name customer1,
       c2.customer_id                     customer_id2,
       c2.first_name + ' ' + c2.last_name customer2
from sales.customers c1
         inner join sales.customers c2
                    on c1.customer_id <> c2.customer_id and c1.city = c2.city
where c1.city = 'Albany'
order by c1.city,
         customer1,
         customer2;
