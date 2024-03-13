-- SQL Server 数据操作 - like 运算符 - 用于判断值是否与指定的模式（pattern）匹配
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-like/
-- 一个模式（pattern）可能会包含普通字符和通配符
-- like 运算符可以在查询（select）、更新（update）、删除（delete）语句的 where 子句中基于模板匹配筛选行
-- 语法：column | expression like pattern [ESCAPE escape_character]
-- 模式（pattern）是一个用于在列或表达式进行搜索的字符序列，它可以包含以下有效的通配符：
-- 1. 百分号通配符：%，匹配零个或多个任意字符
-- 2. 下划线通配符：_，匹配任意单个字符
-- 3. 字符列表通配符：[abcdefg]，匹配在字符列表中的任意单个字符
-- 4. 字符范围通配符：[a-zA-Z0-9]，匹配在指定范围内的任意单个字符
-- 5. 字符列表取反通配符：[^abcdefg]，匹配不在字符列表中的任意单个字符
-- 通配符使 like 运算符比 = 运算符 和 != 运算符更灵活~
-- ESCAPE 转义符：可以让 like 运算符将通配符当成是一个普通字符
-- 如果列或表达式的计算结果与 like 运算符指定的模式相匹配，那么 like 运算符的结果就为 TRUE
-- 如果想进行与 like 运算符相反的判断，可以使用 not like 运算符，语法如下所示：
-- column | expression not like pattern [ESCAPE escape_character]

use BikeStores;
-- 以下查询使用 customers 表的数据作为示例

-- 使用百分号通配符进行查询：查询名字以字母 z 开头的客户数据，不区分大小写
select customer_id, first_name, last_name
from sales.customers
where last_name like 'z%'
order by first_name;

-- 使用百分号通配符进行查询：查询名字以字母 er 结尾的客户数据，不区分大小写
select customer_id, first_name, last_name
from sales.customers
where last_name like '%er'
order by first_name;

-- 使用百分号通配符进行查询：查询名字以字母 t 开头、以字母 s 结尾的客户数据，不区分大小写
select customer_id, first_name, last_name
from sales.customers
where last_name like 't%s'
order by first_name;

-- 使用下划线通配符进行查询：查询名字第二个字母是 u 的客户数据
-- 模式（pattern）：_u% 解析：
-- 第一个下划线通配符字符匹配任意单个字符
-- 第二个字符 u 精确匹配字母 u
-- 第三个百分号通配符匹配零个或多个任意字符
select customer_id, first_name, last_name
from sales.customers
where last_name like '_u%'
order by first_name;

-- 使用字符列表通配符进行查询：查询名字以字母 Y 或 Z 开头的客户数据
select customer_id, first_name, last_name
from sales.customers
where last_name like '[YZ]%'
order by last_name;

-- 使用字符范围通配符进行查询：查询名字以字母 A 或 B 或 C 开头的客户数据
select customer_id, first_name, last_name
from sales.customers
where last_name like '[A-C]%'
order by first_name;

-- 使用字符列表取反通配符进行查询：查询名字不是以字母 A 到 X 中的任意一个字母开头的客户数据
select customer_id, first_name, last_name
from sales.customers
where last_name like '[^A-X]%'
order by last_name;

-- 使用 NOT LIKE 运算符进行查询：查询姓氏不是以字母 A 开头的客户数据
select customer_id, first_name, last_name
from sales.customers
where customers.first_name not like 'A%'
order by first_name;

-- 使用 ESCAPE 关键字结合 LIKE 运算符进行查询
-- 首先，创建一个用于查询示例的表
create table sales.feedbacks
(
    feedback_id int identity (1, 1) primary key,
    comment     varchar(255) not null
);
-- 接着插入一些测试数据
insert into sales.feedbacks(comment)
values ('Can you give me 30% discount?'),
       ('May I get me 30USD off?'),
       ('Is this having 20% discount today?');
-- 查询所有数据
select *
from sales.feedbacks;
-- 查询反馈内容包含字符串 '30%' 的数据
-- 注意，这里如果不使用 ESCAPE 转义符将百分号转义为普通字符，查询将会把第二条数据 'May I get me 30USD off?' 也查出来
-- 需要使用 like '%30!%%' escape '!' 的形式，将百分号转义为普通字符，才能查询出正确的数据
-- 在该查询中，escape 指定了 '!' 字符为转义字符，它告诉 like 运算符，将 '!' 后面的百分号视为普通字符进行匹配
select feedback_id, comment
from sales.feedbacks
where comment like '%30!%%' escape '!';
