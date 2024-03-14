-- SQL Server 数据操作之连表操作 full outer join - 完全外联接
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-right-join/
-- full outer join 是查询语句的一个子句，它可以从多个表中获取数据
-- 对于左表中的数据行，如果在右表中没有匹配的行，那么列的值将为 NULL，同样地，
-- 对于右表中的数据行，如果在左表中没有匹配的行，那么列的值也将为 NULL
-- 语法：select select_list from table1 full outer join table2 on join_predicate;
-- 上述语法中：首先在 from 子句指定左表为 table1，然后在指定右表和 join 条件
-- outer 关键字是可选的，可以省略：select select_list from table1 full join table2 on join_predicate;效果是一样的

use BikeStores;
-- 创建 schema，名为：pm，代表项目管理
create schema pm;
-- 创建 projects、members 表
create table pm.projects
(
    id    int primary key identity,
    title nvarchar(255) not null
);

create table pm.members
(
    id         int primary key identity,
    name       nvarchar(255) not null,
    project_id int,
    foreign key (project_id) references pm.projects (id)
);

-- 假设每个成员只能参与一个项目，每个项目又有零或多个成员（如果项目处于初始阶段，则不会分配成员）
-- 插入一些测试数据
INSERT INTO pm.projects(title)
VALUES ('New CRM for Project Sales'),
       ('ERP Implementation'),
       ('Develop Mobile Sales Platform');

INSERT INTO pm.members(name, project_id)
VALUES ('John Doe', 1),
       ('Lily Bush', 1),
       ('Jane Doe', 2),
       ('Jack Daniel', null);

-- 查询测试数据是否插入成功
select *
from pm.projects;
select *
from pm.members;

-- 使用 full outer join 查询项目和成员数据
-- 该查询的结果集将包含哪个成员参与了项目，哪个成员没有参与项目，哪个项目没有成员
select m.name  member,
       p.title project
from pm.members m
         full outer join pm.projects p
                         on m.project_id = p.id;

-- 查询哪个成员没有参与项目，哪个项目没有成员
select m.name  member,
       p.title project
from pm.members m
         full outer join pm.projects p
                         on m.project_id = p.id
where m.id is null
   or p.id is null;
