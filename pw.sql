insert into Shops values 
	('Rembooks', 2),
	('Venumber', 4)
go

select Shops.NameShop from Shops 
where Shops.ID_SHOP != all(select Shops.ID_SHOP from Shops, Sales
where Sales.ID_SHOP = Shops.ID_SHOP)
go

---------Lesson 1----------------

create function CountShopsLosers()
returns int
as
begin
 declare @count int
 select @count = count(Shops.ID_SHOP)  from Shops
where Shops.ID_SHOP != all(select Shops.ID_SHOP from Shops, Sales
where Sales.ID_SHOP = Shops.ID_SHOP)
return @count
end
go

select dbo.CountShopsLosers() as 'Count Shops where not sold books'
go

---------Lesson 2----------------

create function MinimumParameter (@param int, @pum int, @pum2 int)
returns int 
as
begin
declare
@min int = @param
if (@min>@pum) set @min = @pum
if(@min>@pum2) set @min=@pum2
return @min 
end
go

select dbo.MinimumParameter(3,5,4) as 'Minimum Num'
go

---------Lesson 3----------------

create function BooksParam()
returns table
as
	return (
			select count(Books.ID_BOOK) as 'Count books' , Themes.NameTheme, Shops.NameShop
			from Books, Sales, Themes, Shops
			where Themes.ID_THEME = Books.ID_THEME
			and
			Sales.ID_BOOK = Books.ID_BOOK
			and
			Shops.ID_SHOP = Sales.ID_SHOP
			group by Themes.NameTheme, Shops.NameShop
			)
go

select * from dbo.BooksParam()
go

---------Lesson 4----------------

create function BooksCriterias(@fName varchar(25), @lName varchar(25), @them varchar(25), @sort varchar(5))
returns table 
as		
	
	return (
			
			select Books.NameBook, Authors.LastName from Books, Authors, Themes
			where Themes.ID_THEME = Books.ID_THEME
			and
			Books.ID_AUTHOR = Authors.ID_AUTHOR
			and
			Authors.FirstName = @fName
			and
			Authors.LastName = @lName
			and
			Themes.NameTheme = @them  
			)
go

select * from BooksCriterias('Циммерман','Филипп', 'Hardware', '')
go