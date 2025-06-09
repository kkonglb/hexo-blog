--创建Departments表
CREATE TABLE Departments(
Dno CHAR(4) PRIMARY KEY,
Dname VARCHAR(20),
Dheadno CHAR(7)
);

--创建Teachers表
CREATE TABLE Teachers(
Tno CHAR(7) PRIMARY KEY,
Tname CHAR(10) NOT NULL,
Sex CHAR(3) CHECK (Sex='男' OR Sex='女'),
Birthday DATE,
Title VARCHAR(15),
Dno CHAR(4),
FOREIGN KEY(Dno) REFERENCES Departments(Dno)
);

--给Departments表添加外键
ALTER TABLE Departments ADD FOREIGN KEY(Dheadno)
REFERENCES Teachers(Tno);

--创建student表--
CREATE TABLE Students(
    Sno CHAR(9) PRIMARY KEY,
    Sname VARCHAR(10) NOT NULL,
    Sex CHAR(3) CHECK (Sex='男'OR Sex='女'),
    Birthday DATE,
    Specialit VARCHAR(20),
    Dno CHAR(4),
    FOREIGN KEY (Dno)REFERENCES Departments(Dno)
);

--创建Courses表
CREATE TABLE Courses(
Cno CHAR(5) PRIMARY KEY,
Cname VARCHAR(40) NOT NULL,
Period SMALLINT,
Credit SMALLINT
);

--创建SC表--
CREATE TABLE SC(
Sno CHAR(9),
Cno CHAR(5),
Grade SMALLINT CHECK(Grade>=0 AND Grade<=100),
PRIMARY KEY(Sno,Cno),
FOREIGN KEY(Sno)REFERENCES Students(Sno),
FOREIGN KEY(Cno)REFERENCES Courses(Cno)
);

--创建Teaches表
CREATE TABLE Teaches(
Tno CHAR(7),
Cno CHAR(5),
TCscore SMALLINT,
PRIMARY KEY(Tno,Cno),
FOREIGN KEY(Tno)REFERENCES Teachers(Tno),
FOREIGN KEY(Cno)REFERENCES Courses(Cno)
);


--填充Departments表
INSERT INTO Departments(Dno,Dname)
VALUES ('CS','计算机系'),
('MA','数学系'),
('PH','物理系'),
('CH','化学系');

--填充Teachers表
INSERT INTO Teachers(Tno,Tname,Sex,Birthday,Title,Dno)
VALUES('05001','张海峰','男','1969-02-21','教授','CS'),
('05002','刘晓明','男','1978-10-06','副教授','CS'),
('05003','王梅','女','1972-02-25','副教授','CS'),
('05004','赵青山','男','1981-05-18','讲师','CS'),
('06001','朱杰','男','1963-01-30','教授','MA'),
('06002','欧阳梅','女','1970-08-11','副教授','MA');

--修改Departments表
UPDATE Departments SET Dheadno='05001' WHERE Dno='CS';
UPDATE Departments SET Dheadno='06001' WHERE Dno='MA';


--填充Students表
INSERT INTO Students(Sno,Sname,Sex,Birthday,Speciality,Dno)
VALUES('202405001','张华','男','2006-12-16','计算机','CS'),
('202405002','李阳','女','2005-10-17','计算机','CS'),
('202405003','欧阳山','男','2006-05-14','计算机','CS'),
('202406001','林艳','女','2005-09-20','数学','MA'),
('202406002','高山','男','2004-08-16','数学','MA'),
('202406003','王海洋','男','2004-01-30','数学','MA');

--填充Courses表
INSERT INTO Courses(Cno,Cname,Period,Credit)
VALUES('CS101','计算机科学导论',2,1),
('CS102','C语言',4,3),
('CS201','数据结构',4,3),
('CS202','离散数学',4,3),
('CS301','数据库系统原理',4,3);

--填充SC表
INSERT INTO SC(Sno,Cno,Grade)
VALUES('202405001','CS101',89),
('202405002','CS101',91),
('202405003','CS101',80),
('202405001','CS102',90),
('202405002','CS102',87),
('202405003','CS102',82),
('202405001','CS201',88),
('202405002','CS201',89),
('202405003','CS201',90),
('202405001','CS202',86),
('202405002','CS202',85),
('202405001','CS301',92);

--填充Teaches表
INSERT INTO Teaches(Tno,Cno,TCscore)
VALUES('05001','CS101',95),
('05002','CS101',92),
('05003','CS101',90),
('05004','CS102',95);