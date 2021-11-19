Create PROCEDURE [dbo].[Search_Product_ByAttributes] 
	@keyword nvarchar(50),
	@categoryId int,
	@pageIndex int,
	@pageSize int,
	@language varchar(5),
	@size varchar(10),
	@totalRow int output

AS
BEGIN
	SET NOCOUNT ON;
	declare @tblProductIds  table(Id int)

	insert into @tblProductIds
	select avv.ProductId from Attributes a inner join AttributeValueVarchars avv
	on a.Id = avv.AttributeId and a.Code ='kich-thuoc'
	where avv.Value = @size
 
	
	select @totalRow = count(*) from Products p 
	inner join ProductTranslations pt on p.Id = pt.ProductId 
	inner join @tblProductIds tpi on p.Id = tpi.Id
	left join ProductInCategories pic on p.Id = pic.ProductId
	left join Categories c on c.Id = pic.CategoryId
	where (@keyword is null or p.Sku like @keyword +'%')
	and pt.LanguageId = @language
	and p.IsActive = 1
	and (@categoryId is null or @categoryId = 0 or pic.CategoryId = @categoryId)

	select p.Id,
		p.Sku,
		p.Price,
		p.DiscountPrice,
		p.ImageUrl,
		p.CreatedAt,
		p.IsActive,
		p.ViewCount,
		pt.Name,
		pt.Content,
		pt.Description,
		pt.SeoAlias,
		pt.SeoDescription,
		pt.SeoKeyword,
		pt.SeoTitle,
		pt.LanguageId,
		c.Name as CategoryName
	from Products p 
	inner join ProductTranslations pt on p.Id = pt.ProductId 
	inner join @tblProductIds tpi on p.Id = tpi.Id
	left join ProductInCategories pic on p.Id = pic.ProductId
	left join Categories c on c.Id = pic.CategoryId
	where (@keyword is null or p.Sku like @keyword +'%')
	and pt.LanguageId = @language
	and p.IsActive = 1
	and (@categoryId is null or @categoryId = 0 or pic.CategoryId = @categoryId)
	order by p.CreatedAt desc
	offset (@pageIndex - 1) * @pageSize rows
	fetch next @pageSize row only
	
	
END