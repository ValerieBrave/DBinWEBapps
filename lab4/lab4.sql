go
use execution_control
--WKT=well-known text
--stsrid идентификатор пространственной ссылки
select top 500 geom, geom.ToString() as WKT, geom.STSrid as SRID from World_Lakes

--вернуть полигон из мультиполигончика
DECLARE @g geometry;  
SET @g = geometry::Parse('MULTIPOLYGON(((0 0, 0 3, 3 3, 3 0, 0 0), (1 1, 1 2, 2 1, 1 1)), ((9 9, 9 10, 10 9, 9 9)))');  
SELECT @g.STGeometryN(1).STAsText(); 

DECLARE @g1 geometry = 'MULTIPOLYGON EMPTY';  
--DECLARE @g2 geometry = 'MULTIPOLYGON(((1 1, 1 -1, -1 -1, -1 1, 1 1)),((1 1, 3 1, 3 3, 1 3, 1 1)))'; 
insert into World_Cities values(@g1, 'NEW CITY', 'NEW COUNTRY', 'Y')
select * from World_Cities where capital = 'Y';
delete World_Cities where name like 'NEW CITY';

--3. 
select * from World_Hydrography where qgs_fid = 29;
select * from World_Hydrography where qgs_fid = 83;
select * from World_Hydrography where qgs_fid = 52;

declare @g1 geometry; 
select @g1 = geom from World_Hydrography where qgs_fid = 29;
declare @g2 geometry; 
select @g2 = geom from World_Hydrography where qgs_fid = 83;
declare @g3 geometry; 
select @g3 = geom from World_Countries where qgs_fid = 189;
declare @g4 geometry; 
select @g4 = geom from World_Hydrography where qgs_fid = 52;
select @g1.STIntersects(@g2) as [Пересеклось], @g4.STContains(@g3) as [Содержит];

--3. расстояние
select * from World_Cities where qgs_fid = 1;
select * from World_Cities where qgs_fid = 2;

go
declare @g3 geometry; 
select @g3 = geom from World_Cities where qgs_fid = 1;
declare @g4 geometry; 
select @g4 = geom from World_Cities where qgs_fid = 2;
Select @g3.STDistance(@g4) as D;


--6. 
-- аппроксимация - приближение

DECLARE @g geometry;  
SET @g = geometry::STGeomFromText('LINESTRING(0 0, 0 1, 1 0, 2 1, 3 0, 4 1)', 0);  
SELECT  @g.Reduce(.75).ToString();  

-------------
select * from World_Cities where name like 'Minsk';
select * from World_Cities where name like 'New York';
select * from World_Cities where name like 'Dresden';
select * from World_Cities where name like 'Vilnius';
select * from World_Cities where name like 'Boston';

alter table team
add city geometry;
select * from team;

update team 
set city = (select geom from World_Cities where name like 'Minsk')
where team_id = 4;
update team 
set city = (select geom from World_Cities where name like 'Boston')
where team_id = 3;

update team 
set city = (select geom from World_Cities where name like 'New York')
where team_id = 2;
update team 
set city = (select geom from World_Cities where name like 'New York')
where team_id = 1;

select * from World_Countries where qgs_fid = 230;

declare @usa geometry;
declare @loc geometry;
declare cur cursor for select city from team;
set @usa = (select geom from World_Countries where qgs_fid = 230);
open cur;
fetch cur into @loc;
while @@FETCH_STATUS =0
begin
	if @usa.STContains(@loc) = 1 print 'team in USA'
	fetch next from cur into @loc
end
close cur
deallocate cur