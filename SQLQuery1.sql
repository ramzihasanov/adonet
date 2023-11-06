create database sqladonet
use sqladonet

create table Academies(
Id int  PRIMARY KEY IDENTITY,
Name nvarchar(30) not null ,
)


create table Groups(
Id int  PRIMARY KEY IDENTITY,
Name nvarchar(30) not null ,
academiId int foreign key REFERENCES Academies(Id)
)

create table Students(
Id int  PRIMARY KEY IDENTITY,
Name nvarchar(30) not null ,
SurName nvarchar(30) not null ,
age int,
Adulthood  as case when age<18 then 0 else 1 end,
groupId int foreign key REFERENCES Groups(Id)
)


create table DeletedStudents(
Id int  PRIMARY KEY IDENTITY,
Name nvarchar(30) not null ,
SurName nvarchar(30) not null ,
groupId int foreign key REFERENCES Groups(Id)
)


create table DeletedGroups(
Id int  PRIMARY KEY IDENTITY,
Name nvarchar(30) not null ,
academiId int foreign key REFERENCES Academies(Id)
)



insert into Academies  values
('code acad'),
('bridge acad')



insert into Groups  values
('ba210',1),
('bb206',1),
('gr123',2),
('gr231',2)




insert into Students  values
('Remzi','Hesenov',19,1),
('maqa','maqayev',19,2),
('tunay','Huseynli',21,1),
('ekber','ekberli',15,3),
('seymur','Hesenov',20,4)

create view viev1
as
select * from Academies



create view viev2
as
select * from Groups



create view viev3
as
select * from Students


create procedure USR_GetGroup @name nvarchar(30)
as
select g.Id, g.Name 
from Groups g
where @name=g.Name


select * from Academies

create procedure USR_Getstudent @age nvarchar(30)
as
select s.Id, s.Name,s.SurName,s.age
from Students s
where @age<s.age



create procedure USR_Getstudentt @age nvarchar(30)
as
select s.Id, s.Name,s.SurName,s.age
from Students s
where @age>s.age


create trigger trgr_AddDeletedstudent
on Students
After delete
as 
select Name,SurName,age,adulthood,groupId from deleted



create trigger trgr_AddDeletedGrop
on Groups
After delete
as 
select Name,academiId from deleted




create trigger trgr_update_adulthood
on Students
After update
as 
update Student set Adulthood=1
from deleted
where Students.Id=deleted.id and deleted.age>17



