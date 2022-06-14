
# DDL
CREATE TABLE tb_user(
    id INT COMMENT '编号',
    NAME VARCHAR(50) COMMENT '姓名',
    age INT COMMENT '年龄',
    gender VARCHAR(1) COMMENT '性别'
) COMMENT '用户表';


DESC tb_user;

CREATE TABLE emp(
	id INT COMMENT '编号',
	workno VARCHAR(10) COMMENT '工号',
	NAME VARCHAR(10) COMMENT '姓名',
	gender CHAR(1) COMMENT '性别',
	age TINYINT UNSIGNED COMMENT '年龄',
	idcard CHAR(18) COMMENT '身份证号',
	entrydate DATE COMMENT '入职时间'

) COMMENT '员工表';

DESC emp;

ALTER TABLE emp ADD nickname VARCHAR(20) COMMENT '昵称';

ALTER TABLE emp MODIFY nickname CHAR(10);

ALTER TABLE emp CHANGE nickname username VARCHAR(30);

ALTER TABLE emp DROP username;

ALTER TABLE emp RENAME TO employee;

DESC employee;

DROP TABLE IF EXISTS tb_user;

TRUNCATE TABLE emp;

DROP TABLE IF EXISTS emp;

# DML
INSERT INTO employee (id,workno,NAME,gender,age,idcard,entrydate)
	VALUES (1,'1','李小奔','男',10,'123456789012345678','2000-01-01');
	
SELECT * FROM employee;

INSERT INTO employee(id,workno,NAME,gender,age,idcard,entrydate)
VALUES (1,'1','李小奔','男',-1,'123456789012345678','2000-01-01');



INSERT INTO employee VALUES(2,'2','张三','男',18,'123456789110252541','2005-01-10');




INSERT INTO employee VALUES
	(3,'3','卢本伟','男',22,'157854132652587822','2012-12-30'),
		(4,'4','罗翔','男',40,'154785236985412369','1988-8-8');


UPDATE employee SET NAME='李大奔' WHERE id = 1;

UPDATE employee SET NAME='小昭',gender='女' WHERE id = 1;

UPDATE employee SET entrydate='2008-01-01';

DELETE FROM employee WHERE gender='女';

DELETE FROM employee;

UPDATE employee SET entrydate=NULL WHERE id=4;

#*DQL

#数据准备
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
VALUES (1, '1', '柳岩666', '女', 20, '123456789012345678', '北京', '2000-01-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (2, '2', '张无忌', '男', 18, '123456789012345670', '北京', '2005-09-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (3, '3', '韦一笑', '男', 38, '123456789712345670', '上海', '2005-08-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (4, '4', '赵敏', '女', 18, '123456757123845670', '北京', '2009-12-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (5, '5', '小昭', '女', 16, '123456769012345678', '上海', '2007-07-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (6, '6', '杨逍', '男', 28, '12345678931234567X', '北京', '2006-01-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (7, '7', '范瑶', '男', 40, '123456789212345670', '北京', '2005-05-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (8, '8', '黛绮丝', '女', 38, '123456157123645670', '天津', '2015-05-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (9, '9', '范凉凉', '女', 45, '123156789012345678', '北京', '2010-04-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (10, '10', '陈友谅', '男', 53, '123456789012345670', '上海', '2011-01-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (11, '11', '张士诚', '男', 55, '123567897123465670', '江苏', '2015-05-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (12, '12', '常遇春', '男', 32, '123446757152345670', '北京', '2004-02-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (13, '13', '张三丰', '男', 88, '123656789012345678', '江苏', '2020-11-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (14, '14', '灭绝', '女', 65, '123456719012345670', '西安', '2019-05-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (15, '15', '胡青牛', '男', 70, '12345674971234567X', '西安', '2018-04-01');

INSERT INTO emp (id, workno, NAME, gender, age, idcard, workaddress, entrydate)
VALUES (16, '16', '周芷若', '女', 18, NULL, '北京', '2012-06-01');


SELECT * FROM emp;

#查询指定字段 name, workno, age并返回

SELECT NAME,workno,age FROM emp;

SELECT id,workno,NAME,gender,age,idcard,workaddress,entrydate FROM emp;

SELECT * FROM emp;

# 查询所有员工的工作地址,起别名

SELECT workaddress AS '工作地址' FROM emp;

-- AS可以省略
SELECT workaddress '工作地址' FROM emp;

#查询公司员工的上班地址有哪些(不要重复)
SELECT DISTINCT workaddress '工作地址' FROM emp;

# 查询年龄等于 88 的员工
SELECT * FROM emp WHERE age=88;

# 查询年龄小于 20 的员工信息
SELECT * FROM emp WHERE age<20;

# 查询年龄小于等于 20 的员工信息
SELECT * FROM emp WHERE age<=20;

# 查询没有身份证号的员工信息
SELECT * FROM emp WHERE idcard IS NULL;

#查询有身份证号的员工信息
SELECT * FROM emp WHERE idcard IS NOT NULL;

#查询年龄不等于 88 的员工信息

SELECT * FROM emp WHERE age != 88;

SELECT * FROM emp WHERE age <> 88;

# 查询年龄在15岁(包含) 到 20岁(包含)之间的员工信息
SELECT * FROM emp WHERE age >= 15 && age <= 20;

SELECT * FROM emp WHERE age >=15 AND age<=20;

SELECT * FROM emp WHERE age BETWEEN 15 AND 20;

# 查询性别为 女 且年龄小于 25岁的员工信息

SELECT * FROM emp WHERE gender='女' AND age < 25;

#  查询年龄等于18 或 20 或 40 的员工信息

SELECT * FROM emp WHERE age=18 OR age=20 OR age=40;

SELECT * FROM emp WHERE age IN(18,20,40);

# 查询姓名为两个字的员工信息 _ %
SELECT * FROM emp WHERE NAME LIKE '__';

#  查询身份证号最后一位是X的员工信息
SELECT * FROM emp WHERE idcard LIKE '%X';

SELECT * FROM emp WHERE idcard LIKE '_________________X';

#统计该企业员工数量
SELECT COUNT(*) FROM emp; -- 统计的是总记录数
SELECT COUNT("1") FROM emp;
SELECT COUNT(id) FROM emp;

SELECT COUNT(idcard) FROM emp; -- 统计的是idcard字段不为null的记录数




#统计该企业员工平均年龄
SELECT AVG(age) FROM emp;

#统计该企业员工的最大年龄

SELECT MAX(age) FROM emp;

#统计该企业员工的最小年龄

SELECT MIN(age) FROM emp;

#统计西安地区员工的年龄之和
SELECT SUM(age) FROM emp WHERE workaddress='西安';

# 根据性别分组 , 统计男性员工和女性员工的数量

SELECT gender,COUNT(*) FROM emp GROUP BY gender;

# 根据性别分组 , 统计男性员工 和 女性员工的平均年龄

SELECT gender,AVG(age) FROM emp GROUP BY gender;

# 查询年龄小于45的员工 , 并根据工作地址分组 , 获取员工数量大于等于3的工作地址

SELECT workaddress,COUNT(*) FROM emp WHERE age<45 GROUP BY workaddress HAVING COUNT(*)>=3;



# 统计各个工作地址上班的男性及女性员工的数量


SELECT workaddress,gender,COUNT(*) FROM emp GROUP BY gender,workaddress;

SELECT workaddress, gender, COUNT(*) '数量' FROM emp GROUP BY gender,workaddress;



# 根据年龄对公司的员工进行升序排序

SELECT * FROM emp ORDER BY age ASC;

SELECT * FROM emp ORDER BY age;

# 根据入职时间, 对员工进行降序排序

SELECT * FROM emp ORDER BY entrydate DESC;

#根据年龄对公司的员工进行升序排序 , 年龄相同 , 再按照入职时间进行降序排序

SELECT * FROM emp ORDER BY age ASC , entrydate DESC;  


# SELECT 字段列表 FROM  表名 LIMIT 起始索引, 查询记录数; 

#分页查询：起始索引从0开始，起始索引 = （查询页码 - 1）* 每页显示记录数。 


# 查询第1页员工数据, 每页展示10条记录

SELECT * FROM emp LIMIT 0,10;

SELECT * FROM emp LIMIT 10;

#  查询第2页员工数据, 每页展示10条记录 --------> (页码-1)*页展示记录数

SELECT * FROM emp LIMIT 10,10;

SELECT * FROM emp LIMIT 10,10;


# 查询第1页员工数据, 每页展示6条记录 --------> (页码-1)*页展示记录数

SELECT * FROM emp LIMIT 0,6;


#  查询第2页员工数据, 每页展示6条记录 --------> (页码-1)*页展示记录数

SELECT * FROM emp LIMIT 6,6;

#  查询第3页员工数据, 每页展示6条记录 --------> (页码-1)*页展示记录数

SELECT * FROM emp LIMIT 12,6;

# 案例

# 1) 查询年龄为16,18,20,22岁的女员工信息

SELECT * FROM emp WHERE age IN(16,18,20,22) AND gender='女';


# 2) 查询性别为男，并且年龄在20-40岁(含)以内的姓名为三个字的员工

SELECT * FROM emp WHERE gender='男' AND (age BETWEEN 20 AND 40 ) AND NAME LIKE '___';

SELECT * FROM emp WHERE gender = '男' AND ( age BETWEEN 20 AND 40 ) AND NAME LIKE '___'; 

# 3) 统计员工表中, 年龄小于60岁的 , 男性员工和女性员工的人数

SELECT gender,COUNT(*) FROM emp WHERE age<60 GROUP BY gender;

SELECT gender,COUNT(*) FROM emp WHERE age<60 GROUP BY gender; 

# 4) 查询所有年龄小于等于35岁员工的姓名和年龄和入职时间，并对查询结果按年龄升序排序，如果年龄相同按 入职时间降序排序

SELECT NAME,age,entrydate FROM emp WHERE age<=35 ORDER BY age ASC,entrydate DESC;



# 5) 查询性别为男，且年龄在20-40 岁(含)以内的前3个员工信息，对查询的结果按年龄升序排序， 年龄相同按入职时间升序排序

SELECT * FROM emp WHERE gender='男' AND age BETWEEN 20 AND 40 ORDER BY age ASC,entrydate ASC LIMIT 0,3


# 执行顺序

SELECT e.name ename , e.age eage FROM emp e WHERE e.age > 15 ORDER BY eage ASC; 


USE mysql;

SELECT * FROM USER;
 
 
A. 创建用户xiaoben, 只能够在当前主机localhost访问, 密码123456; 


CREATE USER 'xiaoben'@'localhost' IDENTIFIED BY '123456'; 

B. 创建用户enzhe, 可以在任意主机访问该数据库, 密码123456; 

CREATE USER 'enzhe'@'%' IDENTIFIED BY '123456';

C. 修改用户enzhe的访问密码为1234; 

ALTER USER 'enzhe'@'%'IDENTIFIED WITH mysql_native_password BY '1234';


D. 删除xiaoben@localhost 用户 

DROP USER 'xiaoben'@'localhost';


A. 查询 'enzhe'@'%' 用户的权限


SHOW GRANTS FOR 'enzhe'@'%';


B. 授予 'enzhe'@'%' 用户mycourse数据库所有表的所有操作权限


GRANT ALL ON mycourse.* TO 'enzhe'@'%';


C. 撤销 'enzhe'@'%' 用户的mycourse数据库的所有权限


REVOKE ALL ON mycourse.* FROM 'enzhe'@'%';




A. CONCAT : 字符串拼接

SELECT CONCAT('hello','mysql');


B. LOWER : 全部转小写

SELECT LOWER('HELLOW world');


C. UPPER : 全部转大写

SELECT UPPER('HELLOW world');

D. LPAD : 左填充

SELECT LPAD('01', 5, '-');

E. RPAD : 右填充

SELECT RPAD('01', 5, '-');

F. TRIM : 去掉字符串头部和尾部的空格

SELECT TRIM('   Hello MySQL   ');

G. SUBSTRING : 截取子字符串 返回从字符串str从start位置起的len个长度的字符串

SELECT SUBSTRING('Hello MySQL',1,5);

SELECT * FROM emp;


UPDATE emp SET workno = LPAD(workno,5,'0');



DESC emp;


A. ceil：向上取整

SELECT CEIL (1.1);

B. floor：向下取整

SELECT FLOOR (1.9);

C. mod：取模

SELECT MOD(7,4);

D. rand：获取随机数

SELECT RAND();

E. round：四舍五入 求参数x的四舍五入的值，保留y位小数

SELECT ROUND(2.344,2);

SELECT ROUND(2.345,2);

SELECT RAND()*1000000;

SELECT ROUND(RAND()*1000000,0);

SELECT RPAD(ROUND(RAND()*1000000,0),6,'0');




A. curdate：当前日期


SELECT CURDATE();


B. curtime：当前时间

SELECT CURTIME();

C. now：当前日期和时间

SELECT NOW();


D. YEAR , MONTH , DAY：当前年、月、日

SELECT YEAR(NOW());
SELECT MONTH(NOW());
SELECT DAY(NOW());


E. date_add：增加指定的时间间隔

SELECT DATE_ADD(NOW(), INTERVAL 3 DAY );

SELECT DATE_ADD(NOW(), INTERVAL 3 YEAR );

SELECT DATE_ADD(NOW(), INTERVAL 3 MONTH );

SELECT DATE_ADD(CURTIME(),INTERVAL 60 MINUTE)

SELECT DATE_ADD(CURTIME(),INTERVAL 60 SECOND)

F. datediff：获取两个日期相差的天数

SELECT DATEDIFF('2022-10-10','2022-5-10');

SELECT NAME,DATEDIFF(NOW(),entrydate) AS '入职天数' FROM emp ORDER BY entrydate DESC;

SELECT IF(FALSE,'OK','Error');


SELECT IFNULL('ok','default');

SELECT IFNULL('','Default');

SELECT IFNULL(NULL,'Default');

需求: 查询emp表的员工姓名和工作地址 (北京/上海 ----> 一线城市 , 其他 ----> 二线城市)

SELECT NAME,workaddress,
(CASE workaddress WHEN '北京' THEN '一线城市' WHEN '上海' THEN '一线城市' ELSE '二线城市' END) AS '城市等级' FROM emp;




CREATE TABLE score(
    id INT COMMENT 'ID',
    NAME VARCHAR(20) COMMENT '姓名',
    math INT COMMENT '数学',
    english INT COMMENT '英语',
    chinese INT COMMENT '语文'
)COMMENT '学员成绩表';

INSERT INTO score(id, NAME, math, english, chinese) VALUES (1, 'Tom', 67, 88, 95), (2, 'Rose' , 23, 66, 90),(3, 'Jack', 56, 98, 76);


SELECT * FROM score;



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





CREATE TABLE tb_user(
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID唯一标识',
    NAME VARCHAR(10) NOT NULL UNIQUE COMMENT '姓名',
    age INT CHECK(age > 0 && age <= 120) COMMENT '年龄',
    STATUS CHAR(1) DEFAULT '1' COMMENT '状态',
    gender CHAR(1)
 )

INSERT INTO tb_user(NAME,age,STATUS,gender) VALUES ('Tom1',19,'1','男'),('Tom2',25,'0','男');
INSERT INTO tb_user(NAME,age,STATUS,gender) VALUES ('Tom3',19,'1','男');
INSERT INTO tb_user(NAME,age,STATUS,gender) VALUES (NULL,19,'1','男');
INSERT INTO tb_user(NAME,age,STATUS,gender) VALUES ('Tom3',19,'1','男');
INSERT INTO tb_user(NAME,age,STATUS,gender) VALUES ('Tom4',80,'1','男');
INSERT INTO tb_user(NAME,age,STATUS,gender) VALUES ('Tom5',-1,'1','男');
INSERT INTO tb_user(NAME,age,STATUS,gender) VALUES ('Tom5',121,'1','男');
INSERT INTO tb_user(NAME,age,gender) VALUES ('Tom5',120,'男');

USE mydb;
SELECT * FROM tb_user;

DESC tb_user;

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

DELETE FROM dept WHERE id=1;

DELETE FROM emp WHERE dept_id=1;

SELECT * FROM dept;

SELECT * FROM emp;

ALTER TABLE emp ADD CONSTRAINT fk_emp_dept_id FOREIGN KEY (dept_id) REFERENCES dept (id);

DELETE FROM dept WHERE id=1;

DELETE FROM emp;

ALTER TABLE emp DROP FOREIGN KEY fk_emp_dept_id;

ALTER TABLE emp ADD CONSTRAINT fk_emp_dept_id FOREIGN KEY (dept_id) REFERENCES dept(id) ON UPDATE CASCADE ON DELETE CASCADE;


UPDATE dept SET id=6 WHERE id=1;

DELETE FROM dept WHERE id=6;



ALTER TABLE emp ADD CONSTRAINT fk_emp_dept_id FOREIGN KEY (dept_id) REFERENCES dept(id) ON UPDATE SET NULL ON DELETE SET NULL;



DELETE FROM dept WHERE id=1;