-- SQL Server 数据定义之创建新的数据库：create database
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-create-database/
-- 语法如下
-- create database database_name;
-- 上述语法中，需要在 create database 语句后面指定要创建的数据库名称，
-- 数据库名称在同一个 SQL Server 服务器实例中必须是唯一的，且名称必须符合 SQL Server 的命名规则
-- 数据库名称最多128 个字符

-- 创建一个名称为 TestDb01 的数据库
create database TestDb01;

-- 查询 SQL Server 中的所有数据库名称
select name from master.sys.databases;

-- 或者执行存储过程：sp_databases;
-- 执行后将输出数据库名称、数据库大小、备注
execute sp_databases;