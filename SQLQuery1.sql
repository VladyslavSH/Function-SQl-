insert into Shops values 
	('Rembooks', 2),
	('Venumber', 4)
go

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

select dbo.CountShopsLosers()
go

select Shops.NameShop from Shops 
where Shops.ID_SHOP != all(select Shops.ID_SHOP from Shops, Sales
where Sales.ID_SHOP = Shops.ID_SHOP)
go

create function MinimumParameter(@param int, @pum int, @pum2 int)
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

select dbo.MinimumParameter(3,5,4)
go