-- SQL Server 数据定义之自增列：identity column
-- 参考资料：https://www.sqlservertutorial.net/sql-server-basics/sql-server-identity/
-- identity column 是 SQL Server 中的一个特殊列，它可以自动生成递增的数值，从指定值开始，每次递增指定的量，语法如下：
-- identity[(seed, increment)]
-- seed 代表表中第一行的值，increment 代表每次递增的值
-- seed 和 increment 的默认值均为1：(1, 1)
-- 这表示表中第一行的值是1，第二行为2，以此类推
-- 假设想指定初始值为10，每次递增为10，可以使用下面的语法：
-- identity(10, 10)
-- 需要注意的是，每张表只能有一个 identity column

use BikeStores;
-- 创建测试的 schema
create schema hr;

-- 创建表，使用 identity 属性创建自增列
create table hr.persons
(
    person_id  int identity (1, 1) primary key,
    first_name nvarchar(50) not null,
    last_name  nvarchar(50) not null,
    gender     char(1)      not null
);
-- 插入测试数据，输出：1
-- output inserted.column：可以用来指定插入成功后返回插入的列的值
-- 比如一个很常见的场景：插入数据后返回新插入数据的主键
insert into hr.persons(first_name, last_name, gender)
output inserted.person_id
values ('shiloh', 'lee', 'M');
-- 再插入一条测试数据，输出：2
insert into hr.persons(first_name, last_name, gender)
output inserted.person_id
values ('bruce', 'lee', 'M');

-- 重用自增列的值
-- SQL Server 不会重用自增列的值，如果插入数据失败或回滚了，则自增列的值将会丢失
-- 并且不会再次生成，这会导致自增的顺序出现断层，比如从1到3，而不是2

-- 创建两张表：position 和 person_position
create table hr.position
(
    position_id   int identity (1, 1) primary key,
    position_name nvarchar(255) not null
);

create table hr.person_position
(
    person_id   int,
    position_id int,
    primary key (person_id, position_id),
    foreign key (person_id) references hr.persons (person_id),
    foreign key (position_id) references hr.position (position_id)
);

-- 接着开启事务进行测试
begin transaction
begin try
    -- 插入一条人员信息
    insert into hr.persons(first_name, last_name, gender)
    values ('Jack', 'Smith', 'F');
    -- 给人员指定一个职位
    insert into hr.person_position(person_id, position_id)
    values (@@identity, 1);
end try
begin catch
    if @@trancount > 0
        rollback transaction ;
end catch
if @@trancount > 0
    commit transaction ;
go

-- 上述示例中，第一个插入将成功执行，但是第二个插入将会失败，因为 hr.position 表还没有 position_id 为1的数据
-- 由于出现了错误，整个事务都将回滚
-- 而第一条插入语句将生成自增值3，且因为事务回滚，该值将会丢失，下一条插入的数据，它的自增值将为4：
insert into hr.persons(first_name, last_name, gender)
output inserted.person_id
values ('Jane', 'Doe', 'F');
