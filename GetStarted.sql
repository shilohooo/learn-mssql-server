select @@version;

-- 创建数据库
create database TestDB;
-- 查看当前所有的数据库
select name from sys.databases;
-- 切换数据库
use TestDB;
-- 创建 schema，schema 是数据库中的一个逻辑分组概念，默认的 schema 为 dbo，可以将表、存储过程等对象进性分组
create schema test1;
-- 创建表
create table test1.Users(
    id int primary key identity ,
    username nvarchar(50),
    email nvarchar(255)
);
-- 插入表数据
insert into test1.Users(username, email) values ('shiloh', 'shiloh595@163.com');
-- 查询数据
select * from test1.Users where username = 'shiloh';
-- 修改数据
update test1.Users set email = 'lixiaolei595@gmail.com' where id = 1;
-- 删除数据
delete from test1.Users where id = 1;
