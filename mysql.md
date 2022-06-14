# Mysql

## 1.MySQL概述

在这一章节，我们主要介绍两个部分，数据库相关概念及MySQL数据库的介绍、下载、安装、启动及连接。

### 1.1 数据库相关概念

在这一部分，我们先来讲解三个概念：数据库、数据库管理系统、SQL

| 名称           | 全称                                                         | 简称                              |
| :------------- | ------------------------------------------------------------ | :-------------------------------- |
| 数据库         | 存储数据的仓库，数据是有组织的进行存储                       | DataBase（DB）                    |
| 数据库管理系统 | 操纵和管理数据库的大型软件                                   | DataBase Management System (DBMS) |
| SQL            | 操作关系型数据库的编程语言，定义了一套操作关系型数据库统一**标准** | Structured QueryLanguage (SQL)    |



## 2.SQL

### 2.1 SQL通用语法

在学习具体的SQL语句之前，先来了解一下SQL语言的通用语法

1) SQL语句可以单行或多行书写，以分号结尾。
2) SQL语句可以使用空格/缩进来增强语句的可读性。
3) MySQL数据库的SQL语句不区分大小写，关键字建议使用大写。
4) 注释：
单行注释：-- 注释内容 或 # 注释内容
多行注释：/* 注释内容 */

### 2.2 SQL分类

SQL语句，根据其功能，主要分为四类：DDL、DML、DQL、DCL。

| 分类 |            全称            | 说明                                                   |
| ---- | :------------------------: | ------------------------------------------------------ |
| DDL  |  Data Definition Language  | 数据定义语言，用来定义数据库对象(数据库，表，字段)     |
| DML  | Data Manipulation Language | 数据操作语言，用来对数据库表中的数据进行增删改         |
| DQL  |    Data Query Language     | 数据查询语言，用来查询数据库中表的记录                 |
| DCL  |   Data Control Language    | 数据控制语言，用来创建数据库用户、控制数据库的访问权限 |

### 2.3 DDL

Data Definition Language，数据定义语言，用来定义数据库对象(数据库，表，字段) 。

#### 2.3.1 数据库操作

##### 1) 查询所有数据库

```mysql
show databases;
```

##### 2) 创建数据库

语法规则

```mysql
create database [ if not exists ] 数据库名 [ default charset 字符集 ] [ collate 排序规则 ];
```

**案例：**

A.创建一个mydb数据库, 使用数据库默认的字符集

```mysql
create database mydb;
```

在同一个数据库服务器中，不能创建两个名称相同的数据库，否则将会报错

可以通过if not exists 参数来解决这个问题，数据库不存在, 则创建该数据库，如果存在，则不创建。

```mysql
create database if not exists mydb;
```

B. 创建一个mydatabase数据库，并且指定字符集

```mysql
create database mydatabase default charset utf8;
```

##### 3) 删除数据库

```mysql
drop database [ if exists ] 数据库名;
drop database if exists mydatabase;
```

如果删除一个不存在的数据库，将会报错。此时，可以加上参数 if exists ，如果数据库存在，再执行删除，否则不执行删除。

##### 4) 切换数据库

```mysql
use 数据库名;
```

我们要操作某一个数据库下的表时，就需要通过该指令，切换到对应的数据库下，否则是不能操作的。

比如，切换到mydb数据，执行如下SQL：

```mysql
use mydb;
```

##### 5) 查询当前使用的数据库

```mysql
select database();
```

#### 2.3.2 表操作

##### 2.3.2.1 表操作-查询创建

**1) 查询当前数据库所有表**

```mysql
show tables;
```

比如,我们可以切换到sys这个系统数据库,并查看系统数据库中的所有表结构。

```mysql
1 use sys;
2 show tables;
```

**2) 查看指定表结构**

```mysql
desc 表名;
```

通过这条指令，我们可以查看到指定表的字段，字段的类型、是否可以为NULL，是否存在默认值等信息

```mysql
desc user;
```

**3) 查询指定表的建表语句**

```mysql
show create table 表名;
```

通过这条指令，主要是用来查看建表语句的，而有部分参数我们在创建表的时候，并未指定也会查询到，因为这部分是数据库的默认值，如：存储引擎、字符集等。

```mysql
show create table user;
```

**4) 创建表结构**

```mysql
CREATE TABLE 表名(
字段1 字段1类型 [ COMMENT 字段1注释 ],
字段2 字段2类型 [COMMENT 字段2注释 ],
字段3 字段3类型 [COMMENT 字段3注释 ],
......
字段n 字段n类型 [COMMENT 字段n注释 ]
) [ COMMENT 表注释 ] ;

```

> 注意: [...] 内为可选参数，最后一个字段后面没有逗号

比如，我们创建一张表 tb_user ，对应的结构如下，那么建表语句为：

|  id  |   name   | age  | gender |
| :--: | :------: | :--: | :----: |
|  1   |  令狐冲  |  28  |   男   |
|  2   |  风晴扬  |  68  |   男   |
|  3   | 东方不败 |  32  |   男   |

```mysql
CREATE TABLE tb_user(
    id INT COMMENT '编号',
    NAME VARCHAR(50) COMMENT '姓名',
    age INT COMMENT '年龄',
    gender VARCHAR(1) COMMENT '性别'
) COMMENT '用户表';

```

##### 2.3.2.2 表操作-数据类型

在上述的建表语句中，我们在指定字段的数据类型时，用到了int ，varchar，那么在MySQL中除了以上的数据类型，还有哪些常见的数据类型呢？ 接下来,我们就来详细介绍一下MySQL的数据类型。

MySQL中的数据类型有很多，主要分为三类：数值类型、字符串类型、日期时间类型。

**1) 数值类型**

| 类型        | 大小   | 有符号(SIGNED)范围                                  | 无符号(UNSIGNED)范围                                   | 描述               |
| ----------- | ------ | --------------------------------------------------- | ------------------------------------------------------ | ------------------ |
| TINYINT     | 1byte  | (-128，127)                                         | (0，255)                                               | 小整数值           |
| SMALLINT    | 2bytes | (-32768，32767)                                     | (0，65535)                                             | 大整数值           |
| MEDIUMINT   | 3bytes | (-8388608，8388607)                                 | (0，16777215)                                          | 大整数值           |
| INT/INTEGER | 4bytes | (-2147483648，2147483647)                           | (0，4294967295)                                        | 大整数值           |
| BIGINT      | 8bytes | (-2^63，2^63-1)                                     | (0，2^64-1)                                            | 极大整数值         |
| FLOAT       | 4bytes | (-3.402823466E+38，3.402823466351E+38)            | 0 和 (1.175494351E38，3.402823466E+38)               | 单精度浮点数值     |
| DOUBLE      | 8bytes | (-1.7976931348623157E+308，1.7976931348623157E+308) | 0 和(2.2250738585072014E+308，1.7976931348623157E+308) | 双精度浮点数值     |
| DECIMAL     |        | 依赖于M(精度)和D(标度)的值                          | 依赖于M(精度)和D(标度)的值                             | 小数值(精确定点数) |

```mysql
如:
1). 年龄字段 -- 不会出现负数, 而且人的年龄不会太大
age tinyint unsigned -- 无符号
2). 分数 -- 总分100分, 最多出现一位小数
score double(4,1) -- 333.3

```

**2) 字符串类型**

| 类型       | 大小                  | 描述                            |
| ---------- | --------------------- | ------------------------------- |
| CHAR       | 0-255 bytes           | 定长字符串(需要指定长度)        |
| VARCHAR    | 0-65535 bytes         | 变长字符串(需要指定长度)        |
| TINYBLOB   | 0-255 bytes           | 不超过255个字符的二进制文本数据 |
| TINYTEXT   | 0-255 bytes           | 短文本字符串                    |
| BLOB       | 0-65 535 bytes        | 二进制形式的长文本数据          |
| TEXT       | 0-65 535 bytes        | 长文本数据                      |
| MEDIUMBLOB | 0-16 777 215 bytes    | 二进制形式的中等长度文本数据    |
| MEDIUMTEXT | 0-16 777 215 bytes    | 中等长度文本数据                |
| LONGBLOB   | 0-4 294 967 295 bytes | 二进制形式的极大文本数据        |
| LONGTEXT   | 0-4 294 967 295 bytes | 极大文本数据                    |

char **与** varchar **都可以描述字符串**，char**是定长字符串，指定长度多长，就占用多少个字符，和**
**字段值的长度无关 。而**varchar**是变长字符串，指定的长度为最大占用长度 。相对来说，**char**的性**
**能会更高些。**

```mysql
如：
1). 用户名 username ------> 长度不定, 最长不会超过50
username varchar(50)
2). 性别 gender ---------> 存储值, 不是男,就是女
gender char(1)
3). 手机号 phone --------> 固定长度为11
phone char(11)

```

**3) 日期时间类型**

| 类型      | 大小 | 范围                                            | 格式                | 描述                     |
| --------- | ---- | ----------------------------------------------- | ------------------- | ------------------------ |
| DATE      | 3    | 1000-01-01 至 9999-12-31                        | YYYY-MM-DD          | 日期值                   |
| TIME      | 3    | -838:59:59 至 838:59:59                         | HH:MM:SS            | 时间值或持续时间         |
| YEAR      | 1    | 1901 至 2155                                    | YYYY                | 年份值                   |
| DATETIME  | 8    | 1000-01-01 00:00:00 至<br />9999-12-31 23:59:59 | YYYY-MM-DD HH:MM:SS | 混合日期和时间值         |
| TIMESTAMP | 4    | 1970-01-01 00:00:01 至<br />2038-01-19 03:14:07 | YYYY-MM-DD HH:MM:SS | 混合日期和时间值，时间戳 |

```mysql
如:
1). 生日字段 birthday
birthday date
2). 创建时间 createtime
createtime datetime

```



##### 2.3.2.3 表操作-案例

设计一张员工信息表，要求如下：
1. 编号（纯数字）
2. 员工工号 (字符串类型，长度不超过10位)
3. 员工姓名（字符串类型，长度不超过10位）
4. 性别（男/女，存储一个汉字）
5. 年龄（正常人年龄，不可能存储负数）
6. 身份证号（二代身份证号均为18位，身份证中有X这样的字符）
7. 入职时间（取值年月日即可）

对应的建表语句如下:

```mysql
CREATE TABLE emp(
	id INT COMMENT '编号',
	workno VARCHAR(10) COMMENT '工号',
	NAME VARCHAR(10) COMMENT '姓名',
	gender CHAR(1) COMMENT '性别',
	age TINYINT UNSIGNED COMMENT '年龄',
	idcard CHAR(18) COMMENT '身份证号',
	entrydate DATE COMMENT '入职时间'

) COMMENT '员工表';
```

SQL语句编写完毕之后，就可以在MySQL的命令行中执行SQL，然后也可以通过 desc 指令查询表结构
信息：
![1647939883781](E:\study\mysql\assets\1647939883781.png)

表结构创建好了，里面的name字段是varchar类型，最大长度为10，也就意味着如果超过10将会报
错，如果我们想修改这个字段的类型 或 修改字段的长度该如何操作呢？接下来再来讲解DDL语句中，
如何操作表字段。

##### 2.3.2.4 表操作-修改

**1) 添加字段**

```mysql
ALTER TABLE 表名 ADD 字段名 类型 (长度) [ COMMENT 注释 ] [ 约束 ];
```

案例:

为emp表增加一个新的字段”昵称”为nickname，类型为varchar(20)

```mysql
ALTER TABLE emp ADD nickname VARCHAR(20) COMMENT '昵称';
```

**2) 修改数据类型**

```mysql
ALTER TABLE 表名 MODIFY 字段名 新数据类型 (长度);
```

案例:

将emp表的nickname字段的数据类型改为char(10)

```mysql
ALTER TABLE emp MODIFY nickname char(10);
```

**3) 修改字段名和字段类型**

```mysql
ALTER TABLE 表名 CHANGE 旧字段名 新字段名 类型 (长度) [ COMMENT 注释 ] [ 约束 ];
```

案例:

将emp表的nickname字段修改为username，类型为varchar(30)

```mysql
ALTER TABLE emp CHANGE nickname username VARCHAR(30);
```

**4) 删除字段**

```mysql
ALTER TABLE 表名 DROP 字段名;
```

案例:

将emp表的字段username删除

```mysql
ALTER TABLE emp drop username;
```

**5) 修改表名**

```mysql
ALTER TABLE 表名 RENAME TO 新表名;
```

案例:

将emp表的表名修改为 employee

```mysql
ALTER TABLE emp RENAME TO employee;
```

##### 2.3.2.5 表操作-删除

**1) 删除表**

```mysql
DROP TALBE [IF EXISTS] 表名;
```

可选项 IF EXISTS 代表，只有表名存在时才会删除该表，表名不存在，则不执行删除操作(如果不加该参数项，删除

一张不存在的表，执行将会报错)。

案例:

如果tb_user表存在，则删除tb_user表

```mysql
DROP TABLE IF EXISTS tb_user;
```

**2) 删除指定表，并重新创建表**

删除速度比delete快, TRUNCATE TABLE 则一次性地从表中删除所有的数据,ELETE语句执行删除的过程是每次从表中删除一行.

```mysql
TRUNCATE TABLE 表名;
```



> 注意: 在删除表的时候，表中的全部数据也都会被删除。



### 2.4 mysql客户端-图形化界面工具

### 2.5 DML

DML英文全称是Data Manipulation Language(数据操作语言)，用来对数据库中表的数据记录进行增、删、改操作。

- 添加数据（INSERT）
- 修改数据（UPDATE）
- 删除数据（DELETE）

#### 2.5.1 添加数据

**1) 给指定字段添加数据**

```mysql
INSERT INTO 表名 (字段名1, 字段名2, ...) VALUES (值1, 值2, ...);
```

**案例**:  给employee表所有的字段添加数据

```mysql
INSERT INTO employee (id,workno,name,gender,age,idcard,entrydate) VALUES (1,'1','李小奔','男',10,'123456789012345678','2000-01-01');
```

插入数据完成之后,可以直接一条查询数据的SQL语句,查询数据库的数据，语句如下:

```mysql
select * from employee;
```

**案例**: 给employee表所有的字段添加数据

执行如下SQL，添加的年龄字段值为-1。

```mysql
INSERT INTO employee(id,workno,name,gender,age,idcard,entrydate)VALUES (1,'1','李小奔','男',-1,'123456789012345678','2000-01-01');
```

执行上述的SQL语句时，报错了，具体的错误信息如下：

 ![1647945057015](E:\study\mysql\assets\1647945057015.png)

因为 employee 表的age字段类型为 tinyint，而且还是无符号的 unsigned ，所以取值只能在
0-255 之间。

**2) 给全部字段添加数据**

```mysql
INSERT INTO 表名 VALUES (值1, 值2, ...);
```

案例：插入数据到employee表，具体的SQL如下：

```mysql
INSERT INTO employee VALUES(2,'2','张三','男',18,'123456789110252541','2005-01-10');
```

**3) 批量添加数据**

指定字段批量插入数据

```mysql
INSERT INTO 表名(字段1,字段2,...)VALUES(值1,值2,...),(值1,值2,...),(值1,值2,...);
```

全部字段批量插入数据

```mysql
INSERT INTO 表名 VALUES (值1, 值2, ...), (值1, 值2, ...), (值1, 值2,...) ;
```

案例：批量插入数据到employee表，具体的SQL如下：

```mysql
INSERT INTO employee VALUES(3,'3','卢本伟','男',22,'157854132652587822','2012-12-30'),(4,'4','罗翔','男',40,'154785236985412369','1988-08-08');
```

> 注意事项:
>
> - 插入数据时，指定的字段顺序需要与值的顺序是一一对应的
> - 字符串和日期型数据应该包含在引号中
> - 插入的数据大小，应该在字段的规定范围内

#### 2.5.2 修改数据

修改数据的具体语法为:

```mysql
UPDATE 表名 SET 字段名1 = 值1,字段名2 = 值2, .... [WHERE 条件];
```

案例：

A.修改id为1的数据，将name修改为李大奔

```mysql
UPDATE employee SET name='李大奔' WHERE id = 1;
```

B. 修改id为1的数据, 将name修改为小昭, gender修改为 女

```mysql
UPDATE employee SET name='小昭',gender='女' where id = 1;
```

C. 将所有的员工入职日期修改为 2008-01-01

```mysql
UPDATE employee SET entrydate='2008-01-01';
```

> 注意事项:
>
> - 修改语句的条件可以有，也可以没有，如果没有条件，则会修改整张表的所有数据

#### 2.5.3 删除数据

删除数据的具体语法为：

```mysql
DELETE FROM 表名 [WHERE 条件];
```

案例：

A. 删除gender为女的员工

```mysql
DELETE FROM employee WHERE gender='女';
```

B. 删除所有员工

```mysql
DELETE FROM employee;
```

> 注意事项：
>
> -  DELETE 语句的条件可以有，也可以没有，如果没有条件，则会删除整张表的所有数据
> - DELETE 语句不能删除某一个字段的值(可以使用UPDATE，将该字段值置为NULL即可)
> - 当进行删除全部数据操作时，datagrip会提示我们，询问是否确认删除，我们直接点击Execute即可

### 2.6 DQL

DQL英文全称是Data Query Language(数据查询语言)，数据查询语言，用来查询数据库中表的记录

查询关键字: SELECT

在一个正常的业务系统中，查询操作的频次是要远高于增删改的，当我们去访问企业官网、电商网站，
在这些网站中我们所看到的数据，实际都是需要从数据库中查询并展示的。而且在查询的过程中，可能
还会涉及到条件、排序、分页等操作

 ![1647950278571](E:\study\mysql\assets\1647950278571.png)

那么，本小节我们主要学习的就是如何进行数据的查询操作。 我们先来完成如下数据准备工作:

```mysql
DROP TABLE IF EXISTS employee;

CREATE TABLE emp(
    id INT COMMENT '编号',
    workno VARCHAR(10) COMMENT '工号',
    NAME VARCHAR(10) COMMENT '姓名',
    gender CHAR(1) COMMENT '性别',
    age TINYINT UNSIGNED COMMENT '年龄',
    idcard CHAR(18) COMMENT '身份证号',
    workaddress VARCHAR(50) COMMENT '工作地址',
    entrydate DATE COMMENT '入职时间'
)COMMENT '员工表';


INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (1, '00001', '柳岩666', '女', 20, '123456789012345678', '北京', '2000-01-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (2, '00002', '张无忌', '男', 18, '123456789012345670', '北京', '2005-09-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (3, '00003', '韦一笑', '男', 38, '123456789712345670', '上海', '2005-08-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (4, '00004', '赵敏', '女', 18, '123456757123845670', '北京', '2009-12-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (5, '00005', '小昭', '女', 16, '123456769012345678', '上海', '2007-07-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (6, '00006', '杨逍', '男', 28, '12345678931234567X', '北京', '2006-01-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (7, '00007', '范瑶', '男', 40, '123456789212345670', '北京', '2005-05-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (8, '00008', '黛绮丝', '女', 38, '123456157123645670', '天津', '2015-05-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (9, '00009', '范凉凉', '女', 45, '123156789012345678', '北京', '2010-04-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (10, '00010', '陈友谅', '男', 53, '123456789012345670', '上海', '2011-01-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (11, '00011', '张士诚', '男', 55, '123567897123465670', '江苏', '2015-05-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (12, '00012', '常遇春', '男', 32, '123446757152345670', '北京', '2004-02-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (13, '00013', '张三丰', '男', 88, '123656789012345678', '江苏', '2020-11-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (14, '00014', '灭绝', '女', 65, '123456719012345670', '西安', '2019-05-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (15, '00015', '胡青牛', '男', 70, '12345674971234567X', '西安', '2018-04-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (16, '00016', '周芷若', '女', 18, NULL, '北京', '2012-06-01');

```

准备完毕后，我们就可以看到emp表中准备的16条数据。接下来，我们再来完成DQL语法的学习。

#### 2.6.1 基本语法

DQL 查询语句，语法结构如下：

```mysql
SELECT
	字段列表
FROM
	表名列表
WHERE
	条件列表
GROUP BY
	分组字段列表
HAVING
	分组后条件列表
ORDER BY
	排序字段列表
LIMIT
	分页参数
```

我们在讲解这部分内容的时候，会将上面的完整语法进行拆分，分为以下几个部分

- 基本查询 (不带任何条件)
- 条件查询 (WHERE)
- 聚合函数 (count、max、min、avg、sum)
- 分组查询 (group by)
- 排序查询 (order by)
- 分页查询 (limit)

#### 2.6.2 基础查询

在基本查询的SQL语句中，不带任何条件的查询，查询语法如下：

**1) 查询多个字段**

```mysql
SELECT 字段1,字段2,字段3 ... FROM 表名;

SELECT * FROM 表名;
```

> 注意：* 号代表查询所有字段，在实际开发中尽量少用(不直观,影响效率)

**2) 字段设置别名**

```mysql
SELECT 字段1 [AS 别名1],字段2 [AS 别名2],字段3 [AS 别名3] ... FROM 表名;

SELECT 字段1 [别名1],字段2 [别名2] ... FROM 表名;
```

**2) 去除重复记录**

```mysql
SELECT DISTINCT 字段列表 FROM 表名;
```

案例：

A. 查询指定字段 name, workno, age并返回

```mysql
SELECT name,workno,age FROM emp;
```

B. 查询返回所有字段

```mysql
SELECT id,workno,name,gender,age,idcard,workaddress,entrydate FROM emp;

SELECT * FROM emp;
```

C. 查询所有员工的工作地址,起别名

```mysql
SELECT workaddress AS '工作地址' FROM emp;

-- AS可以省略
SELECT workaddress '工作地址' FROM emp;
```

D. 查询公司员工的上班地址有哪些(不要重复)

```mysql
SELECT DISTINCT workaddress '工作地址' FROM emp;
```

#### 2.6.3 条件查询

**1) 语法**

```mysql
SELECT 字段列表 FROM 表名 WHERE 条件列表;
```

**2) 条件**

常用的比较运算符如下：

| 比较运算符         | 功能                                               |
| :----------------- | -------------------------------------------------- |
| >                  | 大于                                               |
| >=                 | 大于等于                                           |
| <                  | 小于                                               |
| <=                 | 小于等于                                           |
| =                  | 等于                                               |
| <> 或 !=           | 不等于                                             |
| BETWEEN ... AND... | 在某个范围之内(含最小值、最大值)                   |
| IN(...)            | 在IN之后的列表中的值，多选一(满足其中一个条件即可) |
| LIKE 占位符        | 模糊匹配(_匹配单个字符,%匹配任意个字符)            |
| IS NULL            | 是NULL                                             |

常用的逻辑运算符如下:

| 逻辑运算符 | 功能                       |
| ---------- | -------------------------- |
| AND 或 &&  | 并且 (多个条件同时成立)    |
| OR 或 \|\| | 或者(多个条件任意一个成立) |
| NOT 或 !   | 非，不是                   |

案例:

A. 查询年龄等于 88 的员工

```mysql
SELECT * FROM emp WHERE age=88;
```

B. 查询年龄小于 20 的员工信息

```mysql
SELECT * FROM emp WHERE age<20;
```

C. 查询年龄小于等于 20 的员工信息

```mysql
SELECT * FROM emp WHERE age<=20;
```

D. 查询没有身份证号的员工信息

```mysql
SELECT * FROM emp WHERE idcard IS NULL;
```

E. 查询有身份证号的员工信息

```mysql
SELECT * FROM emp WHERE idcard IS NOT NULL;
```

F. 查询年龄不等于 88 的员工信息

```mysql
SELECT * FROM emp WHERE age != 88;

SELECT * FROM emp WHERE age <> 88;
```

G. 查询年龄在15岁(包含) 到 20岁(包含)之间的员工信息

```mysql
SELECT * FROM emp WHERE age >= 15 && age <= 20;

SELECT * FROM emp WHERE age >=15 and age<=20;

SELECT * FROM emp WHERE age BETWEEN 15 AND 20;
```

H. 查询性别为 女 且年龄小于 25岁的员工信息

```mysql
SELECT * FROM emp WHERE gender='女' AND age < 25;
```

I. 查询年龄等于18 或 20 或 40 的员工信息

```mysql
SELECT * FROM emp WHERE age=18 or age=20 or age=40;

SELECT * FROM emp WHERE age IN(18,20,40);
```

J. 查询姓名为两个字的员工信息 __ %

```mysql
SELECT * FROM emp WHERE name LIKE '__';
```

K. 查询身份证号最后一位是X的员工信息

```mysql
SELECT * FROM emp WHERE idcard LIKE '%X';

SELECT * FROM emp WHERE idcard LIKE '_________________X';
```



#### 2.6.4 聚合函数

**1) 介绍**

将一列数据作为一个整体，进行纵向计算
**2) 常见的聚合函数**

| 函数  | 功能     |
| ----- | -------- |
| count | 统计数量 |
| max   | 最大值   |
| min   | 最小值   |
| avg   | 平均值   |
| sum   | 求和     |

**3) 语法**

```mysql
SELECT 聚合函数(字段列表) FROM 表名;
```

> 注意 : NULL值是不参与所有聚合函数运算的

案例：

A. 统计该企业员工数量

```mysql
SELECT COUNT(*) FROM emp; -- 统计的是总记录数

SELECT COUNT(idcard) FROM emp; -- 统计的是idcard字段不为null的记录数
```

对于count聚合函数，统计符合条件的总记录数，还可以通过count(数字/字符串)的形式进行统计查询，比如：

```mysql
SELECT COUNT(1) FROM emp;

SELECT COUNT("1") FROM emp;
```

> 对于count(*)、count(字段)、count(1)的具体原理，我们在进阶篇中SQL优化部分会详细讲解，此处大家只需要知道如何使用即可。

B. 统计该企业员工平均年龄

```mysql
SELECT AVG(age) FROM emp;
```

C. 统计该企业员工的最大年龄

```mysql
SELECT MAX(age) FROM emp;
```

D. 统计该企业员工的最小年龄

```mysql
SELECT MIN(age) FROM emp;
```

E.统计西安地区员工的年龄之和

```mysql
SELECT SUM(age) FROM emp WHERE workaddress='西安';
```

#### 2.6.5 分组查询

**1) 语法**

```mysql
SELECT 字段列表 FROM 表名 [WHERE 条件] GROUP BY 分组字段名 [HAVING 分组后过滤条件];
```

**2）where与having区别**

- 执行时机不同：where是分组之前进行过滤，不满足where条件，不参与分组；而having是分组之后对结果进行过滤。
- **判断条件不同：**where不能对聚合数据进行判断，而having可以。

> 注意事项：
>
> - 分组之后，查询的字段一般为聚合函数和分组字段，查询其他字段无任何意义。
> - 执行顺序：where>聚合函数>having
> - 支持多字段分组，具体语法为：group by columnA,columnB

案例:

A. 根据性别分组 , 统计男性员工 和 女性员工的数量

```mysql
select gender, count(*) from emp group by gender ;
```

B. 根据性别分组 , 统计男性员工 和 女性员工的平均年龄

```mysql
select gender, avg(age) from emp group by gender ;
```

C. 查询年龄小于45的员工 , 并根据工作地址分组 , 获取员工数量大于等于3的工作地址

```mysql
SELECT workaddress, COUNT(*) address_count FROM emp WHERE age < 45 GROUP BY workaddress HAVING address_count >= 3;
```

D. 统计各个工作地址上班的男性及女性员工的数量

```mysql
select address,gender,count(*) from emp group by gender,address;
```

#### 2.6.6 排序查询

排序在日常开发中是非常常见的一个操作，有升序排序，也有降序排序。

![1655103095081](E:\study\mysql\assets\1655103095081.png)

**1) 语法**

```mysql
SELECT 字段列表 FROM 表名 ORDER BY 字段1 排序方式1,字段2 排序方式2; 
```

**2）排序方式**

- ASC：升序（默认值）
- DESC：降序

> 注意：如果是升序, 可以不指定排序方式ASC；
>
> 如果是多字段排序，当第一个字段值相同时，才会根据第二个字段进行排序；

**案例：**

A. 根据年龄对公司的员工进行升序排序 

```mysql
SELECT * FROM emp ORDER BY age ASC;
SELECT * FROM emp ORDER BY age;
```

B. 根据入职时间, 对员工进行降序排序 

```mysql
select * from emp order by entrydate desc; 
```

C. 根据年龄对公司的员工进行升序排序  , 年龄相同 , 再按照入职时间进行降序排序 

```mysql
SELECT * FROM emp ORDER BY age ASC , entrydate DESC;  
```

#### 2.6.7 分页查询

分页操作在业务系统开发时，也是非常常见的一个功能，我们在网站中看到的各种各样的分页条，后台 都需要借助于数据库的分页操作。
![1655103817823](E:\study\mysql\assets\1655103817823.png)

**1)语法**

```mysql
SELECT 字段列表 FROM  表名 LIMIT 起始索引,查询记录数 ; 
```

> 注意事项: 
> • 起始索引从0开始，起始索引  = （查询页码 - 1）* 每页显示记录数。 
> • 分页查询是数据库的方言，不同的数据库有不同的实现，MySQL中是LIMIT。 
> • 如果查询的是第一页数据，起始索引可以省略，直接简写为  limit 10。 

**案例：**

A. 查询第1页员工数据, 每页展示10条记录

```mysql
SELECT * FROM emp LIMIT 0,10;
SELECT * FROM emp LIMIT 10;
```

B. 查询第2页员工数据, 每页展示10条记录  --------> (页码-1)*页展示记录数 

```mysql
SELECT * FROM emp LIMIT 10,10;
```

#### 2.6.8 案例

1) 查询年龄为16,18,20,22岁的女员工信息

```mysql
SELECT * FROM emp WHERE age IN(16,18,20,22) AND gender='女';
```

2) 查询性别为男，并且年龄在20-40 岁(含)以内的姓名为三个字的员工

```mysql
SELECT * FROM emp WHERE gender='男' AND (age BETWEEN 20 AND 40 ) AND NAME LIKE '___';
```

3) 统计员工表中, 年龄小于60岁的     , 男性员工和女性员工的人数

```mysql
SELECT gender,COUNT(*) FROM emp WHERE age<60 GROUP BY gender;
```

4) 查询所有年龄小于等于35岁员工的姓名和年龄和入职时间，并对查询结果按年龄升序排序，如果年龄相同按 入职时间降序排序

```mysql
SELECT NAME,age,entrydate FROM emp WHERE age<=35 ORDER BY age ASC,entrydate DESC;
```

5) 查询性别为男，且年龄在20-40 岁(含)以内的前3个员工信息，对查询的结果按年龄升序排序， 年龄相同按入职时间升序排序

```mysql
SELECT * FROM emp WHERE gender='男' AND age BETWEEN 20 AND 40 ORDER BY age ASC,entrydate ASC LIMIT 0,3
```

#### 2.6.9 执行顺序

在讲解DQL语句的执行顺序之前，我们已经讲解了DQL语句的完整语法，及编写顺序，接下来，我们要来说明的是DQL语句在执行时的执行顺序，也就是先执行那一部分，后执行那一部分。

![1655106442018](E:\study\mysql\assets\1655106442018.png)

**验证：**

1) 查询年龄大于15的员工姓名、年龄，并根据年龄进行升序排序

```mysql
SELECT NAME , age FROM emp WHERE age > 15 ORDER BY age ASC; 
```

在查询时，我们给emp表起一个别名 e，然后在select 及where中使用该别名

```mysql
SELECT e.name , e.age FROM emp e WHERE e.age > 15 ORDER BY age ASC; 
```

执行上述SQL语句后，我们看到依然可以正常的查询到结果，此时就说明：from 先执行, 然后 where 和 select 执行。那where 和select 到底哪个先执行呢? 
此时，此时我们可以给select后面的字段起别名，然后在 where 中使用这个别名，然后看看是否可 以执行成功。 

```mysql
SELECT e.name ename,e.age eage FROM emp e WHERE eage > 15 ORDER BY age ASC; 
```

执行上述SQL报错了：

![1655110058309](E:\study\mysql\assets\1655110058309.png)

由此我们可以得出结论: from 先执行，然后执行 where ，再执行select 。 

接下来，我们再执行如下SQL语句，查看执行效果：

```mysql
SELECT e.name ename, e.age eage FROM emp e WHERE e.age > 15 ORDER BY eage ASC; 
```

结果执行成功。那么也就验证了: order by 是在select 语句之后执行的。 

综上所述，我们可以看到DQL语句的执行顺序为：

 from ... where ... group by ... having ... select ... order by ... limit ... 

### 2.7 DCL

DCL英文全称是 Data Control Language(数据控制语言)，用来管理数据库用户、控制数据库的访问权限。
![1655110589579](E:\study\mysql\assets\1655110589579.png)

#### 2.7.1 管理用户

1) 查询用户

```mysql
USE mysql;

SELECT * FROM USER;
```

查询的部分结果如下: 

![1655121857429](E:\study\mysql\assets\1655121857429.png)

其中 Host代表当前用户访问的主机, 如果为localhost, 仅代表只能够在当前本机访问，是不可以远程访问的。

User代表的是访问该数据库的用户名。在MySQL中需要通过Host和User来唯一标识一 个用户。 

2）创建用户

```mysql
CREATE USER '用户名'@'主机名' IDENTIFIED BY '密码'; 
```

3）修改用户密码

```mysql
ALTER USER '用户名'@'主机名' IDENTIFIED WITH mysql_native_password BY '新密码'; 
```

4) 删除用户

```mysql
DROP USER '用户名'@'主机名'; 
```

> 注意事项:
>
> - 在MySQL中需要通过用户名@主机名的方式，来唯一标识一个用户
> - 主机名可以使用%通配
> - 这类SQL开发人员操作的比较少，主要是DBA（Database Administrator 数据库管理员）使用

案例： 
A.创建用户xiaoben, 只能够在当前主机localhost访问, 密码123456; 

```mysql
CREATE USER 'xiaoben'@'localhost' IDENTIFIED BY '123456'; 
```

B. 创建用户enzhe, 可以在任意主机访问该数据库, 密码123456; 

```mysql
CREATE USER 'enzhe'@'%' IDENTIFIED BY '123456';
```

C. 修改用户enzhe的访问密码为1234; 

```mysql
ALTER USER 'enzhe'@'%'IDENTIFIED WITH mysql_native_password BY '1234';
```

D. 删除xiaoben@localhost 用户 

```mysql
DROP USER 'xiaoben'@'localhost';
```

#### 2.7.2 权限控制

MySQL中定义了很多种权限，但是常用的就以下几种：

| 权限                | 说明               |
| :------------------ | ------------------ |
| ALL, ALL PRIVILEGES | 所有权限           |
| SELECT              | 查询数据           |
| INSERT              | 插入数据           |
| UPDATE              | 修改数据           |
| DELETE              | 删除数据           |
| ALTER               | 修改表             |
| DROP                | 删除数据库/表/视图 |
| CREATE              | 创建数据库/表      |

上述只是简单罗列了常见的几种权限描述，其他权限描述及含义，可以直接参考[官网文档](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html)。 

1) 查询权限

```mysql
SHOW GRANTS FOR '用户名'@'主机名';
```

2) 授予权限

```mysql
GRANT 权限列表 ON 数据库名.表名 '用户名'@'主机名';
```

3) 撤销权限

```mysql
REVOKE 权限列表 ON 数据库名.表名 FROM '用户名'@'主机名';
```

> 注意事项：
>
> - 多个权限之间，使用逗号分隔
> -  授权时， 数据库名和表名可以使用 * 进行通配，代表所有。

案例:

A. 查询 'enzhe'@'%' 用户的权限

```mysql
SHOW GRANTS FOR 'enzhe'@'%';
```

B. 授予 'enzhe'@'%' 用户mydb数据库所有表的所有操作权限

```mysql
GRANT ALL ON mydb.* TO 'enzhe'@'%';
```

C. 撤销 'enzhe'@'%' 用户的mydb数据库的所有权限

```mysql
REVOKE ALL ON mydb.* FROM 'enzhe'@'%';
```

## 3.函数

函数是指一段可以直接被另一段程序调用的程序或代码。 也就意味着，这一段程序或代码在MySQL中
已经给我们提供了，我们要做的就是在合适的业务场景调用对应的函数完成对应的业务需求即可。 那
么，函数到底在哪儿使用呢？

我们先来看两个场景：

 ![1655126193428](E:\study\mysql\assets\1655126193428.png)![1655126199283](E:\study\mysql\assets\1655126199283.png)    

1) 在企业的OA或其他的人力系统中，经常会提供的有这样一个功能，每一个员工登录上来之后都能够看到当前员工入职的天数。 而在数据库中，存储的都是入职日期，如 2000-11-12，那如何快速计算出天数呢？

2) 在做报表这类的业务需求中,我们要展示出学员的分数等级分布。而在数据库中，存储的是学生的分数值，如98/75，如何快速判定分数的等级呢？

其实，上述的这一类的需求呢，我们通过MySQL中的函数都可以很方便的实现 。

MySQL中的函数主要分为以下四类： 字符串函数、数值函数、日期函数、流程函数

### 3.1 字符串函数

MySQL中内置了很多字符串函数，常用的几个如下：

| 函数                     | 功能                                                      |
| ------------------------ | --------------------------------------------------------- |
| CONCAT(S1,S2,...Sn)      | 字符串拼接，将S1，S2，... Sn拼接成一个字符串              |
| LOWER(str)               | 将字符串str全部转为小写                                   |
| UPPER(str)               | 将字符串str全部转为大写                                   |
| LPAD(str,n,pad)          | 左填充，用字符串pad对str的左边进行填充，达到n个字符串长度 |
| RPAD(str,n,pad)          | 右填充，用字符串pad对str的右边进行填充，达到n个字符串长度 |
| TRIM(str)                | 去掉字符串头部和尾部的空格                                |
| SUBSTRING(str,start,len) | 返回从字符串str从start位置起的len个长度的字符串           |

演示如下：

A. concat : 字符串拼接

```mysql
SELECT CONCAT('hello','mysql');
```

B. lower : 全部转小写

```mysql
SELECT LOWER('HELLOW world');
```

C. upper : 全部转大写

```mysql
SELECT UPPER('HELLOW world');
```

D. lpad : 左填充

```mysql
SELECT LPAD('01', 5, '-');
```

E. rpad : 右填充

```mysql
SELECT RPAD('01', 5, '-');
```

F. trim : 去除空格

```mysql
SELECT TRIM('   Hello MySQL   ');
```

G. substring : 截取子字符串

```mysql
SELECT SUBSTRING('Hello MySQL',1,5);
```

案例:

![1655127575686](E:\study\mysql\assets\1655127575686.png)

由于业务需求变更，企业员工的工号，统一为5位数，目前不足5位数的全部在前面补0。比如：1号员工的工号应该为00001。

```mysql
UPDATE emp SET workno = LPAD(workno,5,'0');
```

处理完毕后, 具体的数据为:

 ![1655127896885](E:\study\mysql\assets\1655127896885.png)

### 3.2 数值函数

常见的数值函数如下：

| 函数       | 功能                               |
| ---------- | ---------------------------------- |
| CEIL(x)    | 向上取整                           |
| FLOOR(x)   | 向下取整                           |
| MOD(x,y)   | 返回x/y的模                        |
| RAND()     | 返回0~1内的随机数                  |
| ROUND(x,y) | 求参数x的四舍五入的值，保留y位小数 |

A. CEIL(x): 向上取整

```mysql
SELECT CEIL (1.1);
```

B. FLOOR(x): 向下取整

```mysql
SELECT FLOOR (1.9);
```

C. MOD(x,y): 返回x/y的模

```mysql
SELECT MOD(7,4);
```

D. rand: 返回0~1内的随机数

```mysql
SELECT RAND();
```

E. ROUND(x,y): 求参数x的四舍五入的值，保留y位小数

```mysql
SELECT ROUND(2.344,2);
```

案例：

通过数据库的函数，生成一个六位数的随机验证码

思路： 获取随机数可以通过rand()函数，但是获取出来的随机数是在0-1之间的，所以可以在其基础上乘以1000000，然后舍弃小数部分，如果长度不足6位，补0

```mysql
SELECT RPAD(ROUND(RAND()*1000000,0),6,'0');
```

### 3.3 日期函数

常见的日期函数如下：

| 函数                              | 功能                                              |
| --------------------------------- | ------------------------------------------------- |
| CURDATE()                         | 返回当前日期                                      |
| CURTIME()                         | 返回当前时间                                      |
| NOW()                             | 返回当前日期和时间                                |
| YEAR(date)                        | 获取指定date的年份                                |
| MONTH(date)                       | 获取指定date的月份                                |
| DAY(date)                         | 获取指定date的日期                                |
| DATE_ADD(date, INTERVAL exprtype) | 返回一个日期/时间值加上一个时间间隔expr后的时间值 |
| DATEDIFF(date1,date2)             | 返回起始时间date1和结束时间date2之间的天数        |

演示如下：

A. curdate：当前日期

```mysql
SELECT CURDATE();
```

B. curtime：当前时间

```mysql
SELECT CURTIME();
```

C. now：当前日期和时间

```mysql
SELECT NOW();
```

D. YEAR , MONTH , DAY：当前年、月、日

```mysql
SELECT YEAR(NOW());
SELECT MONTH(NOW());
SELECT DAY(NOW());
```

E. date_add：增加指定的时间间隔

```mysql
SELECT DATE_ADD(NOW(), INTERVAL 3 DAY );

SELECT DATE_ADD(NOW(), INTERVAL 3 YEAR );

SELECT DATE_ADD(NOW(), INTERVAL 3 MONTH );

SELECT DATE_ADD(CURTIME(),INTERVAL 60 MINUTE)

SELECT DATE_ADD(CURTIME(),INTERVAL 60 SECOND)
```

F. datediff：获取两个日期相差的天数

```mysql
SELECT DATEDIFF('2022-10-10','2022-5-10');
```

案例：

查询所有员工的入职天数，并根据入职天数从少到多排序。

思路：入职天数，就是通过当前日期 - 入职日期，所以需要使用datediff函数来完成。

```mysql
SELECT NAME,DATEDIFF(NOW(),entrydate) AS '入职天数' FROM emp ORDER BY entrydate DESC;
```



### 3.4 流程函数

流程函数也是很常用的一类函数，可以在SQL语句中实现条件筛选，从而提高语句的效率。

| 函数                                                         | 功能                                                      |
| ------------------------------------------------------------ | --------------------------------------------------------- |
| IF(value , t , f)                                            | 如果value为true，则返回t，否则返回f                       |
| IFNULL(value1 , value2)                                      | 如果value1不为空，返回value1，否则返回value2              |
| CASE WHEN [ val1 ] THEN  [res1] ... ELSE  [ default ] END    | 如果val1为true，返回res1，... 否则返回default默认值       |
| CASE [ expr ] WHEN [ val1 ] THEN [res1] ... ELSE [ default ] END | 如果expr的值等于val1，返回res1，... 否则返回default默认值 |

演示如下：

A. if

```mysql
SELECT IF(FALSE,'OK','Error');
```

B. ifnull

```mysql
SELECT IFNULL('ok','default');

SELECT IFNULL('','Default');

SELECT IFNULL(NULL,'Default');
```

C. case when then else end

需求: 查询emp表的员工姓名和工作地址 (北京/上海 ----> 一线城市 , 其他 ----> 二线城市)

```mysql
SELECT 
	NAME,
	workaddress,
	(CASE workaddress WHEN '北京' THEN '一线城市' WHEN '上海' THEN '一线城市' ELSE '二线城       市' END) AS '城市等级'
FROM emp;
```

案例:

```mysql
CREATE TABLE score(
    id INT COMMENT 'ID',
    NAME VARCHAR(20) COMMENT '姓名',
    math INT COMMENT '数学',
    english INT COMMENT '英语',
    chinese INT COMMENT '语文'
)COMMENT '学员成绩表';

INSERT INTO score(id, NAME, math, english, chinese) VALUES (1, 'Tom', 67, 88, 95), (2, 'Rose' , 23, 66, 90),(3, 'Jack', 56, 98, 76);
```

需求: 

- 成绩大于等于85分，成绩显示优秀
- 成绩大于等于60小于85，成绩显示及格
- 成绩低于60，成绩显示不及格

具体的SQL语句如下:

```mysql
SELECT 
    id,
    NAME,
    math,
    (CASE WHEN math>=85 THEN '优秀' WHEN math>=60 THEN '及格' ELSE '不及格' END) AS '数学',
    english,
    (CASE WHEN english>=85 THEN '优秀' WHEN english>=60 THEN '及格' ELSE '不及格' END) AS '英语',
    chinese,
    (CASE WHEN chinese>=85 THEN '优秀' WHEN chinese>=60 THEN '及格' ELSE '不及格' END) AS '语文'
FROM score;
```

MySQL的常见函数我们学习完了，那接下来，我们就来分析一下，在前面讲到的两个函数的案例场景，
思考一下需要用到什么样的函数来实现?

1) 数据库中，存储的是入职日期，如 2000-01-01，如何快速计算出入职天数呢？

答案: datediff

2) 数据库中，存储的是学生的分数值，如98、75，如何快速判定分数的等级呢？

答案: case ... when ...

## 4.约束

### 4.1 概述

概念：约束是作用于表中字段上的规则，用于限制存储在表中的数据。

目的：保证数据库中数据的正确、有效性和完整性。

分类:

| 约束                     | 描述                                                     | 关键字      |
| ------------------------ | -------------------------------------------------------- | ----------- |
| 非空约束                 | 限制该字段的数据不能为null                               | NOT NULL    |
| 唯一约束                 | 保证该字段的所有数据都是唯一、不重复的                   | UNIQUE      |
| 主键约束                 | 主键是一行数据的唯一标识，要求非空且唯一                 | PRIMARY KEY |
| 默认约束                 | 保存数据时，如果未指定该字段的值，则采用默认值           | DEFAULT     |
| 检查约束(8.0.16版本之后) | 保证字段值满足某一个条件                                 | CHECK       |
| 外键约束                 | 用来让两张表的数据之间建立连接，保证数据的一致性和完整性 | FOREIGN KEY |

> 注意：约束是作用于表中字段上的，可以在创建表/修改表的时候添加约束

### 4.2 约束演示

上面我们介绍了数据库中常见的约束，以及约束涉及到的关键字，那这些约束我们到底如何在创建表、修改表的时候来指定呢，接下来我们就通过一个案例，来演示一下。

案例需求： 根据需求，完成表结构的创建。需求如下：

| 字段名 | 字段含义   | 字段类型    | 约束条件                  | 约束关键字 |
| ------ | ---------- | ----------- | ------------------------- | ---------- |
| id     | ID唯一标识 | int         | 主键，并且自动增长        |            |
| name   | 姓名       | varchar(10) | 不为空，并且唯一          |            |
| age    | 年龄       | int         | 大于0，并且小于等于120    |            |
| status | 状态       | char(1)     | 如果没有指定该值，默认为1 |            |
| gender | 性别       | char(1)     | 无                        |            |

对应的建表语句为：

```mysql
CREATE TABLE tb_user(
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID唯一标识',
    NAME VARCHAR(10) NOT NULL UNIQUE COMMENT '姓名',
    age INT CHECK(age > 0 && age <= 120) COMMENT '年龄',
    STATUS CHAR(1) DEFAULT '1' COMMENT '状态',
    gender CHAR(1)
 );
```

在为字段添加约束时，我们只需要在字段之后加上约束的关键字即可，需要关注其语法。我们执行上面的SQL把表结构创建完成，然后接下来，就可以通过一组数据进行测试，从而验证一下，约束是否可以生效。

```mysql
INSERT INTO tb_user(NAME,age,STATUS,gender) VALUES ('Tom1',19,'1','男'),('Tom2',25,'0','男');
INSERT INTO tb_user(NAME,age,STATUS,gender) VALUES ('Tom3',19,'1','男');
INSERT INTO tb_user(NAME,age,STATUS,gender) VALUES (NULL,19,'1','男');
INSERT INTO tb_user(NAME,age,STATUS,gender) VALUES ('Tom3',19,'1','男');
INSERT INTO tb_user(NAME,age,STATUS,gender) VALUES ('Tom4',80,'1','男');
INSERT INTO tb_user(NAME,age,STATUS,gender) VALUES ('Tom5',-1,'1','男');
INSERT INTO tb_user(NAME,age,STATUS,gender) VALUES ('Tom5',121,'1','男');
INSERT INTO tb_user(NAME,age,gender) VALUES ('Tom5',120,'男');
```

上面，我们是通过编写SQL语句的形式来完成约束的指定，那加入我们是通过图形化界面来创建表结构时，又该如何来指定约束呢？ 只需要在创建表的时候，根据我们的需要选择对应的约束即可。
![1655194368457](E:\study\mysql\assets\1655194368457.png)

### 4.3 外键约束

#### 4.3.1 介绍

外键：用来让两张表的数据之间建立连接，从而保证数据的一致性和完整性。

我们来看一个例子：
![1655194917185](E:\study\mysql\assets\1655194917185.png)

左侧的emp表是员工表，里面存储员工的基本信息，包含员工的ID、姓名、年龄、职位、薪资、入职日期、上级主管ID、部门ID，在员工的信息中存储的是部门的ID dept_id，而这个部门的ID是关联的部门表dept的主键id，那emp表的dept_id就是外键,关联的是另一张表的主键。

> 注意：目前上述两张表，只是在逻辑上存在这样一层关系；在数据库层面，并未建立外键关联，所以是无法保证数据的一致性和完整性的。

没有数据库外键关联的情况下，是否能够保证一致性和完整性呢，我们来测试一下

**准备数据**

````mysql
CREATE DATABASE mydb2;

USE mydb2;

CREATE TABLE dept(
    id INT AUTO_INCREMENT COMMENT 'ID' PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL COMMENT '部门名称'
)COMMENT '部门表';

INSERT INTO dept (id, NAME) VALUES (1, '研发部'), (2, '市场部'),(3, '财务部'), (4,'销售部'), (5, '总经办');

CREATE TABLE emp(
    id INT AUTO_INCREMENT COMMENT 'ID' PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL COMMENT '姓名',
    age INT COMMENT '年龄',
    job VARCHAR(20) COMMENT '职位',
    salary INT COMMENT '薪资',
    entrydate DATE COMMENT '入职时间',
    managerid INT COMMENT '直属领导ID',
    dept_id INT COMMENT '部门ID'
)COMMENT '员工表';

INSERT INTO emp (id, NAME, age, job,salary, entrydate, managerid, dept_id) VALUES
(1, '金庸', 66, '总裁',20000, '2000-01-01', NULL,5),
(2, '张无忌', 20,'项目经理',12500, '2005-12-05', 1,1),
(3, '杨逍', 33, '开发', 8400,'2000-11-03', 2,1),
(4, '韦一笑', 48, '开发',11000, '2002-02-05', 2,1),
(5, '常遇春', 43, '开发',10500, '2004-09-07', 3,1),
(6, '小昭', 19, '程序员鼓励师',6600, '2004-10-12', 2,1);

````

![1655195786366](E:\study\mysql\assets\1655195786366.png)

接下来，我们可以做一个测试，删除id为1的部门信息![1655196098790](E:\study\mysql\assets\1655196098790.png)

结果，我们看到删除成功，而删除成功之后，部门表不存在id为1的部门，而在emp表中还有很多的员工，关联的为id为1的部门，此时就出现了数据的不完整性。 而要想解决这个问题就得通过数据库的外键约束。

#### 4.3.2 语法

1) 添加外键

```mysql
CREATE TABLE 表名(
字段名 数据类型,
...
[CONSTRAINT] [外键名称] FOREIGN KEY (外键字段名) REFERENCES 主表 (主表列名)
);
```

```mysql
ALTER TABLE 表名 ADD CONSTRAINT 外键名称 FOREIGN KEY (外键字段名) REFERENCES 主表 (主表列名);
```

案例:

为emp表的dept_id字段添加外键约束,关联dept表的主键id

```mysql
ALTER TABLE emp ADD CONSTRAINT fk_emp_dept_id FOREIGN KEY (dept_id) REFERENCES dept (id);
```

添加了外键约束之后，我们再到dept表(父表)删除id为1的记录，然后看一下会发生什么现象。 此时将会报错，不能删除或更新父表记录，因为存在外键约束。

![1655196836596](E:\study\mysql\assets\1655196836596.png)

2) 删除外键

```mysql
ALTER TABLE 表名 DROP FOREIGN KEY 外键名称;
```

案例：

删除emp表的外键fk_emp_dept_id

```mysql
alter table emp drop foreign key fk_emp_dept_id;
```

#### 4.3.3 删除/更新行为

添加了外键之后，再删除父表数据时产生的约束行为，我们就称为删除/更新行为。具体的删除/更新行为有以下几种:

| 行为        | 说明                                                         |
| ----------- | ------------------------------------------------------------ |
| NO ACTION   | 当在父表中删除/更新对应记录时，首先检查该记录是否有对应外键，如果有则不允许删除/更新。 (与 RESTRICT 一致) 默认行为 |
| RESTRICT    | 当在父表中删除/更新对应记录时，首先检查该记录是否有对应外键，如果有则不允许删除/更新。 (与 NO ACTION 一致) 默认行为 |
| CASCADE     | 当在父表中删除/更新对应记录时，首先检查该记录是否有对应外键，如果有，则也删除/更新外键在子表中的记录。 |
| SET NULL    | 当在父表中删除对应记录时，首先检查该记录是否有对应外键，如果有则设置子表中该外键值为null（这就要求该外键允许取null）。 |
| SET DEFAULT | 父表有变更时，子表将外键列设置成一个默认的值 (Innodb不支持)  |

具体语法为:

```mysql
ALTER TABLE 表名 ADD CONSTRAINT 外键名称 FOREIGN KEY (外键字段) REFERENCES 主表名 (主表字段名) ON UPDATE CASCADE ON DELETE CASCADE;
```

演示如下：
由于NO ACTION 是默认行为，我们前面语法演示的时候，已经测试过了，就不再演示了，这里我们再演示其他的两种行为：CASCADE、SET NULL。

1) CASCADE

```mysql
ALTER TABLE emp ADD CONSTRAINT fk_emp_dept_id FOREIGN KEY (dept_id) REFERENCES dept(id) ON UPDATE CASCADE ON DELETE CASCADE;
```

A. 修改父表id为1的记录，将id修改为6

```mysql
UPDATE dept SET id=6 WHERE id=1;
```

![1655204450531](E:\study\mysql\assets\1655204450531.png)

我们发现，原来在子表中dept_id值为1的记录，现在也变为6了，这就是CASCADE级联的效果。

> 在一般的业务系统中，不会修改一张表的主键值。

B. 删除父表id为6的记录

```mysql
DELETE FROM dept WHERE id=6;
```

 ![1655204239566](E:\study\mysql\assets\1655204239566.png)

我们发现，父表的数据删除成功了，但是子表中关联的记录也被级联删除了。

2) SET NULL

在进行测试之前，我们先需要删除上面建立的外键 fk_emp_dept_id。然后再通过数据脚本，将emp、dept表的数据恢复了。

```mysql
ALTER TABLE emp ADD CONSTRAINT fk_emp_dept_id FOREIGN KEY (dept_id) REFERENCES dept(id) ON UPDATE SET NULL ON DELETE SET NULL;
```

接下来，我们删除id为1的数据，看看会发生什么样的现象。

```mysql
DELETE FROM dept WHERE id=1;
```

 ![1655205036194](E:\study\mysql\assets\1655205036194.png)

我们发现父表的记录是可以正常的删除的，父表的数据删除之后，再打开子表 emp，我们发现子表emp的dept_id字段，原来dept_id为1的数据，现在都被置为NULL了。

  ![1655205201205](E:\study\mysql\assets\1655205201205.png)

这就是SET NULL这种删除/更新行为的效果。



## 5.多表查询

我们之前在讲解SQL语句的时候，讲解了DQL语句，也就是数据查询语句，但是之前讲解的查询都是单表查询，而本章节我们要学习的则是多表查询操作，主要从以下几个方面进行讲解。

### 5.1 多表关系

### 5.2 多表查询概述

### 5.3 内连接

### 5.4 外连接

### 5.5 自连接

### 5.6 子查询

#### 5.6.1 概述

#### 5.6.2 标量子查询

#### 5.6.3 列子查询

#### 5.6.4 行子查询

#### 5.6.5 表子查询

### 5.7多表查询案例

## 6.事务

### 6.1 事务简介

### 6.2 事务操作

#### 6.2.1 未控制事务

#### 6.2.2 控制事务一

#### 6.2.3 控制事务二

### 6.3 事务四大特性

### 6.4 并发事务问题

### 6.5 事务隔离级别

