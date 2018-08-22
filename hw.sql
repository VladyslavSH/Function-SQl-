insert into Sales values
	(14, 'Супер Программирование', getdate(),650, 2, 5)
go

-----Security------------
alter login sa with password = 'sa'
go 

create login userdb with password = 'User_17'
go

select * from sys.sql_logins where name = 'userdb'
go

exec sp_helplogins
go
-----------------------------------

-----------LEsson 1----------------
create function AvgBooks(@Data date)
returns decimal
as
begin
	declare @average decimal
	select @average = avg(Sales.Price)
	from Sales
	where @Data > Sales.DateOfSale
	return @average
end
go

select dbo.AvgBooks('2018-07-20') as 'Average price'
go

-----------LEsson 2----------------

alter function TheMostExpensiveBook(@Theme int)
returns table
as
	return (
			select max(Books.Price) as 'The Most Expensive Book', 
			from Themes, Books
			where Books.ID_THEME = Themes.ID_THEME
			and
			Themes.ID_THEME = @Theme
			group by Themes.NameTheme
			)
go

select * from dbo.TheMostExpensiveBook(6)
go

-----------LEsson 3----------------
/*Функцию, которая по ID магазина возвращает ин-
формацию о нем (ID, название, местоположение,
средняя стоимость продаж за последний год книг
вашего издательства) в табличном виде.*/

alter function InfoAboutShop(@Id_Shop int)
returns table
as
	return (
			select s.ID_SHOP, s.NameShop, s.ID_COUNTRY, avg(sal.Price) as 'Average price books'
			from Shops s, Country c, Authors a, Sales sal
			where @Id_Shop = s.ID_SHOP
			and
			s.ID_COUNTRY = c.ID_COUNTRY
			and
			s.ID_SHOP = sal.ID_SHOP
			group by s.ID_SHOP, s.NameShop, s.ID_COUNTRY
			) 
go

select * from dbo.InfoAboutShop(3)
go

