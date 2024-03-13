-- SQL Server 数据操作之连表操作 Joins - 从多个表中组合数据
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-joins/
-- sql server 支持多种联接，包括：内联接（inner join）、左联接（left join）、右联接（right join）、完全外联接（full outer join）、
-- 交叉联接（cross join），每个联接都用于指定 sql server 如何使用一个表的数据从另一个表选择数据行

use BikeStores;
-- 创建新的 schema
create schema hr;
-- 在刚才创建的 schema 中创建新的表：candidates 和 employees
-- 候选人信息表
create table hr.candidates
(
    id        int primary key identity,
    full_name nvarchar(100) not null
);
-- 员工信息表
create table hr.employees
(
    id        int primary key identity,
    full_name nvarchar(100) not null
);
-- 插入测试数据
insert into hr.candidates(full_name)
values ('John Doe'),
       ('Lily Bush'),
       ('Peter Drucker'),
       ('Jane Doe');

insert into hr.employees(full_name)
values ('John Doe'),
       ('Jane Doe'),
       ('Michael Scott'),
       ('Jack Sparrow');

-- 假设 candidates 表为左表，employees 表为右表
-- inner join - 内联接查询：内联接查询的数据包含左表的行和右表中的匹配行
-- 示例：查询 candidates 表中的数据，使用 full_name 关联查询 employees 表中匹配的数据
select c.id        candidate_id,
       c.full_name candidate_name,
       e.id        employee_id,
       e.full_name employee_name
from hr.candidates c
         inner join hr.employees e
                    on c.full_name = e.full_name

-- left join - 左联接查询：左联接查询的数据包含左表中的所有行和右表中的匹配行
-- 如果左表中的某一行在右表中没有匹配的行，则右表的列将为 NULL
-- 左联接也称为左外联接（left outer join），outer 关键字是可选的
-- 查询示例：
select c.id        candidate_id,
       c.full_name candidate_name,
       e.id        employee_id,
       e.full_name employee_name
from hr.candidates c
         left join hr.employees e
                   on c.full_name = e.full_name

-- 如果只想获取在右表中无法匹配的行，可以使用 where e.id is null
select c.id        candidate_id,
       c.full_name candidate_name,
       e.id        employee_id,
       e.full_name employee_name
from hr.candidates c
         left join hr.employees e
                   on c.full_name = e.full_name
where e.id is null;

-- right join - 右联接查询：右联接查询的数据包含在右表中的所有行和左表中的匹配行
-- 如果右表中的某一行在左表中没有匹配的行，则左表的列将为 NULL
-- 查询示例：
select c.id        candidate_id,
       c.full_name candidate_name,
       e.id        employee_id,
       e.full_name employee_name
from hr.candidates c
         right join hr.employees e
                    on c.full_name = e.full_name

-- 如果只想获取在左表中无法匹配的行，可以使用 where c.id is null
select c.id        candidate_id,
       c.full_name candidate_name,
       e.id        employee_id,
       e.full_name employee_name
from hr.candidates c
         right join hr.employees e
                    on c.full_name = e.full_name
where c.id is null;

-- full outer join / full join 完全联接：完全联接查询的数据包含左表和右表的所有行，以及来自两侧的匹配行（如果可用）
-- 如果没有匹配项，则无法匹配的那一则的值为 NULL
-- 查询示例：
select c.id        candidate_id,
       c.full_name candidate_name,
       e.id        employee_id,
       e.full_name employee_name
from hr.candidates c
         full join hr.employees e
                   on c.full_name = e.full_name

-- 上面的完全联接查询的结果为：
-- 可以看到查询结果包含了左表和右表的所有行，且还多出了两行无法匹配的数据
-- candidate_id | candidate_name | employee_id | employee_name
--------------------------------------------------------------
-- 1            | John Doe       | 1           | John Doe
--------------------------------------------------------------
-- 2            | Lily Bush      | NULL        | NULL
--------------------------------------------------------------
-- 3            | Peter Drucker  | NULL        | NULL
--------------------------------------------------------------
-- 4            | Jane Doe       | 2           | Jane Doe
--------------------------------------------------------------
-- NULL         | NULL           | 3           | Michael Scott
--------------------------------------------------------------
-- NULL         | NULL           | 4           | Jack Sparrow

-- 如果把 employees 表作为左表，candidates 表作为右表，则查询结果为：
select c.id        candidate_id,
       c.full_name candidate_name,
       e.id        employee_id,
       e.full_name employee_name
from hr.employees e
         full join hr.candidates c
                   on c.full_name = e.full_name

-- candidate_id | candidate_name | employee_id | employee_name
--------------------------------------------------------------
-- 1            | John Doe       | 1           | John Doe
--------------------------------------------------------------
-- 4            | Jane Doe       | 2           | Jane Doe
--------------------------------------------------------------
-- NULL         | NULL           | 3           | Michael Scott
--------------------------------------------------------------
-- NULL         | NULL           | 4           | Jack Sparrow
--------------------------------------------------------------
-- 2            | Lily Bush      | NULL        | NULL
--------------------------------------------------------------
-- 3            | Peter Drucker  | NULL        | NULL

-- 如果需要选择左表或右表中存在的行，可以通过添加 where 子句来排除两个表共有的行
select c.id        candidate_id,
       c.full_name candidate_name,
       e.id        employee_id,
       e.full_name employee_name
from hr.candidates c
         full join hr.employees e
                   on c.full_name = e.full_name
where c.id is null
   or e.id is null;
