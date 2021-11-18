USE [RestAPIDapper2]
GO

/****** Object:  StoredProcedure [dbo].[Update_Product]    Script Date: 17/11/2021 1:57:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		NNTAN
-- Create date: 16-11-21
-- Description:	select all records
-- =============================================
ALTER PROCEDURE [dbo].[Update_Product]
	-- Add the parameters for the stored procedure here	
	@id int,
	@name nvarchar(255),
	@description nvarchar(255),
	@content ntext,
	@seoDescription nvarchar(255),
	@seoAlias nvarchar(255),
	@seoTitle nvarchar(255),
	@seoKeyword nvarchar(255),
	@sku varchar(50),
	@price float,
	@isActive bit,
	@imageUrl nvarchar(255),
	@language varchar(5),
	@categoryIds varchar(50)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set xact_abort on;

    -- Insert statements for procedure here
	begin tran
		begin try
			update Products set Sku=@sku, Price=@price, IsActive = @isActive,ImageUrl=@imageUrl
			where Id=@id
			update ProductTranslations set Content=@content, Name=@name, Description=@description, SeoDescription=@seoDescription,
			SeoAlias=@seoAlias, SeoTitle=@seoTitle, SeoKeyword=@seoKeyword
			where ProductId=@id and LanguageId=@language
			insert into ProductInCategories
				select @id as ProductId , cast(String as int) as CategoryId from ufn_CSVToTable(@categoryIds,',')
	commit
	end try
	begin catch
		rollback
		Declare @ErrorMessage varchar(2000)
		Select @ErrorMessage = 'Lỗi' + ERROR_MESSAGE()
		Raiserror(@ErrorMessage,16,1)
	end catch
	
END
GO


