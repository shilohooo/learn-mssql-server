-- SQL Server 数据定义之创建表：create table
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-create-table/
-- 表在数据库中是用来存储数据的，在数据库的一个 schema 中，表名称是唯一的
-- 每张表都包含一个或多个列，每列都定义了一个它可以存储的数据类型，如：数字、字符串或临时数据
-- 可以使用 create table 语句来创建表，语法如下：
-- create table [database_name].[schema_name].table_name (
-- pk_column data_type primary key,
-- column1 data_type not null,
-- column2 data_type,
-- ...,
-- table_constraints
-- );
-- 上述语法中，首先要指定在哪个数据库创建表，database_name 必须是一个已存在的数据库，如果没有指定，则默认为当前数据库
-- 然后指定表所属的 schema，如果没有指定，则使用默认的 schema：dbo，
-- 接着指定新创建的表的名称
-- 每张表都应该有一个主键，主键可以由一或多列组成。通常会先声明主键列，再声明其他列
-- 每列都需要指定它的数据类型，一个列可以有多个约束，如：not null, unique
-- 最后指定表级别的约束，如：primary key, unique, foreign key

-- 创建表 visits
use BikeStores;
-- 创建表的时候没有指定 database_name，那么默认会在当前数据库 BikeStores 创建
create table sales.visits
(
--     主键列，identity (1,1) 用于指定该列自动生成从 1 开始的整数，每插入一条数据，值加 1
    visit_id   int primary key identity (1,1),
--     字符串列使用 varchar / nvarchar 类型标识，其中 nvarchar 是支持 Unicode 的字符串类型
--     nvarchar(50) 中的 (50) 指定该列最多可以存储50个字符
    first_name nvarchar(50) not null,
    last_name  nvarchar(50) not null,
--     日期时间类型
    visited_at datetime,
--     可空的列，即没有设置 not null 约束
    phone      varchar(20),
    store_id   int          not null,
--     表约束定义：外键定义，外键约束要求被引用的列必须存在，否则会报错
    foreign key (store_id) references sales.stores (store_id)
);
