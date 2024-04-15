-- SQL Server 数据定义之创建架构：create schema
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-create-schema/
-- schema 是什么？
-- schema 是 SQL Server 中的一个概念，用于将数据库中的对象分组，方便管理，提高代码的可读性和可维护性
-- schema 可以理解为命名空间，每个 schema 下可以包含多个对象，如表、视图、存储过程、函数、触发器、索引等
-- schema 始终属于一个数据库，每个数据库可以创建多个 schema，schema 中的对象使用完全限定名来引用，如：[schema_name].[object_name]
-- 不同 schema 中的对象名称可以相同，如：Hr.Employees 和 Sales.Employees
-- SQL Server 内置了很多 schema，如：dbo、guest、sys 和 INFORMATION_SCHEMA
-- 需要注意的是：sys 和 INFORMATION_SCHEMA 是 SQL Server 为系统对象保留的 schema，不能在这些 schema 中创建或删除任何对象
-- 对于新创建的数据库，默认的 schema 是 dbo，它属于 dbo 用户账户
-- 默认情况下，当使用 create user 命令新建用户时，该用户将使用 dbo 作为他的默认 schema
-- 创建 schema 的语法如下所示：
-- create schema schema_name [ AUTHORIZATION owner_name ];
-- 在上述语法中，需要指定要创建的 schema 名称
-- 然后可以在 schema 名称后面使用 AUTHORIZATION 关键字指定 schema 的所有者

-- 创建 schema
use BikeStores;

create schema customer_services;

-- 查询当前数据库下的所有 schema 和它们的所有者
select s.name as schema_name,
       u.name as schema_owner
from sys.schemas s
         inner join sys.sysusers u on u.uid = s.principal_id
order by s.name;

-- 在刚才创建的 schema 中新建对象，如：表
create table customer_services.jobs
(
    job_id      int primary key identity,
    customer_id int       not null,
    description nvarchar(255),
    created_at  datetime2 not null
);

select * from customer_services.jobs;