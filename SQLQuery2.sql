/*Функцию, которая возвращает список книг, которые
соответствуют набору критериев (имя и фамилия ав-
тора, тематика), и отсортированы по фамилии автора
в указанном в 4-м параметре направлении.*/ 

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