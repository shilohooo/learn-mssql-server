-- SQL Server 数据定义之删除架构：drop schema
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-drop-schema/
-- drop schema 语句用于删除数据库中的 schema，语法如下：
-- drop schema [ if exists ] schema_name;
-- 首先指定要删除的 schema 名称，如果 schema 下有任意的对象，则不能删除
-- 因此，必须先将 schema 下的所有对象删除，然后才能删除 schema
-- 然后可以加上可选的 if exists，防止在删除不存在的 schema 时报错

-- 创建测试用的 schema
use BikeStores;

create schema logistics;

-- 创建表
create table logistics.deliveries
(
    order_id        int primary key,
    delivery_date   date    not null,
    delivery_status tinyint not null
);

-- 删除 schema
-- 报错：Cannot drop schema 'logistics' because it is being referenced by object 'deliveries'.
drop schema logistics;
-- 删除表
drop table logistics.deliveries;
-- 再次删除 schema
drop schema if exists logistics;