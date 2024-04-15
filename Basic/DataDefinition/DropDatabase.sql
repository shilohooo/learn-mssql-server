-- SQL Server 数据定义之删除数据库：drop database
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-drop-database/
-- 语法如下：
-- drop database [ if exists ] database_name [, database_name2, ...];
-- 上述语法中，在 drop database 语句后面指定要删除的数据库名称，如果要删除多个数据库，可以使用逗号分隔数据库名称
-- 可选的 if exists 选项用于仅删除存在的数据库，从 SQL Server 2016（13.x）开始支持，如果没有使用该选项，删除不存在的数据库时会报错
-- 删除数据库之前的注意事项：
-- 1.删除数据库的同时会删除磁盘文件，如果后续还需要使用到这些数据，务必做好备份再进行删除
-- 2.当前正在使用中的数据库无法删除

-- 删除数据库 TestDb01
drop database if exists TestDb01;