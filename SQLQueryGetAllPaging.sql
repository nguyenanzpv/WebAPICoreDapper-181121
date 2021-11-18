USE [RestAPIDapper2]
GO

/****** Object:  StoredProcedure [dbo].[Get_Product_AllPaging]    Script Date: 17/11/2021 1:48:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Get_Product_AllPaging] 
	-- Add the parameters for the stored procedure here
	@keyword nvarchar(50),
	@categoryId int,
	@pageIndex int,
	@pageSize int,
	@language varchar(5),
	@totalRow int output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--offset bỏ qua bao nhieu rows ko lấy
	-- fetch next --chỉ lấy số lượng dòng @pageSize tiếp theo 
	select @totalRow = count(*) from Products p 
	inner join ProductTranslations pt on p.Id = pt.ProductId
	left join ProductInCategories pic on p.Id = pic.ProductId
	left join Categories c on pic.CategoryId = c.Id
	where (@keyword is null or p.Sku like @keyword +'%') and p.IsActive = 1 and pt.LanguageId=@language and pic.CategoryId=@categoryId

	select 
		p.Id,
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
		pt.SeoDescription,
		pt.SeoAlias,
		pt.SeoKeyword,
		pt.SeoTitle,
		pt.LanguageId,
		c.Name as CategoryName --de cung ten voi CategoryName tren model Product
	from Products p inner join ProductTranslations pt on p.Id = pt.ProductId
	left join ProductInCategories pic on p.Id = pic.ProductId
	left join Categories c on pic.CategoryId = c.Id
	where (@keyword is null or p.Sku like @keyword +'%')
	and p.IsActive = 1 and pt.LanguageId=@language and pic.CategoryId=@categoryId
	order by p.CreatedAt desc
	OFFSET (@pageIndex - 1) * @pageSize rows 
	fetch next @pageSize row only 
END
GO


