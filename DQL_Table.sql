


DROP TABLE IF EXISTS `emp`;

CREATE TABLE `emp` (
  `id` int(11) DEFAULT NULL COMMENT '编号',
  `workno` varchar(10) DEFAULT NULL COMMENT '工号',
  `name` varchar(10) DEFAULT NULL COMMENT '姓名',
  `gender` char(1) DEFAULT NULL COMMENT '性别',
  `age` tinyint(3) unsigned DEFAULT NULL COMMENT '年龄',
  `idcard` char(18) DEFAULT NULL COMMENT '身份证号',
  `workaddress` varchar(50) DEFAULT NULL COMMENT '工作地址',
  `entrydate` date DEFAULT NULL COMMENT '入职时间'
) COMMENT='员工表';



insert  into `emp`(`id`,`workno`,`name`,`gender`,`age`,`idcard`,`workaddress`,`entrydate`) values (1,'00001','柳岩666','女',20,'123456789012345678','北京','2000-01-01'),(2,'00002','张无忌','男',18,'123456789012345670','北京','2005-09-01'),(3,'00003','韦一笑','男',38,'123456789712345670','上海','2005-08-01'),(4,'00004','赵敏','女',18,'123456757123845670','北京','2009-12-01'),(5,'00005','小昭','女',16,'123456769012345678','上海','2007-07-01'),(6,'00006','杨逍','男',28,'12345678931234567X','北京','2006-01-01'),(7,'00007','范瑶','男',40,'123456789212345670','北京','2005-05-01'),(8,'00008','黛绮丝','女',38,'123456157123645670','天津','2015-05-01'),(9,'00009','范凉凉','女',45,'123156789012345678','北京','2010-04-01'),(10,'00010','陈友谅','男',53,'123456789012345670','上海','2011-01-01'),(11,'00011','张士诚','男',55,'123567897123465670','江苏','2015-05-01'),(12,'00012','常遇春','男',32,'123446757152345670','北京','2004-02-01'),(13,'00013','张三丰','男',88,'123656789012345678','江苏','2020-11-01'),(14,'00014','灭绝','女',65,'123456719012345670','西安','2019-05-01'),(15,'00015','胡青牛','男',70,'12345674971234567X','西安','2018-04-01'),(16,'00016','周芷若','女',18,NULL,'北京','2012-06-01');



DROP TABLE IF EXISTS `score`;

CREATE TABLE `score` (
  `id` int(11) DEFAULT NULL COMMENT 'ID',
  `name` varchar(20) DEFAULT NULL COMMENT '姓名',
  `math` int(11) DEFAULT NULL COMMENT '数学',
  `english` int(11) DEFAULT NULL COMMENT '英语',
  `chinese` int(11) DEFAULT NULL COMMENT '语文'
) COMMENT='学员成绩表';



insert  into `score`(`id`,`name`,`math`,`english`,`chinese`) values (1,'Tom',67,88,95),(2,'Rose',23,66,90),(3,'Jack',56,98,76);


