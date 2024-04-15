-- SQL Server 数据定义之修改架构：alter schema
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-alter-schema/
-- alter schema 语句可以将指定的 schema 对象传输到另一个 schema
-- 只能传输安全对象，如：表
-- 语法如下：
-- alter schema target_schema_name transfer [ entity_type :: ] object_name
-- 上述语法中，target_schema_name 是当前数据库中要将对象传输到其中的 schema 名称，注意：不能是 sys 或 INFORMATION_SCHEMA
-- entity_type 是所有者的实体类型，它的值为 Object、Type 或 XML Schema Collection，默认为 Object
-- object_name 是要移动的对象名称，如：表名称
-- 移动存储过程、函数、视图或者触发器，SQL Server 不会自动更改这些安全对象的所属 schema 名称，建议在新的 schema 中重新创建
-- 移动 table 或者 synonym，SQL Server 不会自动更改这些对象的引用，如：schema_name.table_name
-- 需要手动修改引用处指定的 schema 为新的 schema，比如移动某个存储过程引用的 test.t_user 到 new_test schema 中，
-- 则必须修改该存储过程中的表引用代码为：new_test.t_user

-- 在 dbo schema 中创建测试表
create table dbo.offices
(
    office_id      int primary key identity,
    office_name    nvarchar(40)  not null,
    office_address nvarchar(255) not null,
    phone          varchar(20)
);
-- 插入测试数据
insert into dbo.offices(office_name, office_address, phone)
values ('New York', '123 Main St.', '(123) 456-7890'),
       ('London', '456 High St.', '(456) 789-0123');

select *
from dbo.offices;

-- 创建存储过程，按 office id 查询 office 信息
create proc usp_get_office_by_id(@id int)
as
begin
    select * from dbo.offices where office_id = @id;
end;

-- 调用存储过程进行测试
    execute dbo.usp_get_office_by_id 1;

-- 将 dbo schema 中的 offices 表传输到 sales schema
    alter schema sales transfer object::dbo.offices ;

-- 再次执行存储过程
    execute dbo.usp_get_office_by_id 1;