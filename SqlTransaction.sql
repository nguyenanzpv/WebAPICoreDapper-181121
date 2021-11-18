USE [RestAPIDapper2]
GO

/****** Object:  StoredProcedure [dbo].[Delete_Product_ById]    Script Date: 17/11/2021 10:19:23 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		NNTAN
-- Create date: 16-11-21
-- Description:	select all records
-- =============================================
ALTER PROCEDURE [dbo].[Delete_Product_ById]
	-- Add the parameters for the stored procedure here	
	@id int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set xact_abort on; --mặc định là off, lỗi vẫn chạy tiếp -> on để đảm bảo tất cả phải thành công
    -- Insert statements for procedure here
	-- Add them Begin tran va commit de tao transaction dam bao neu xoa loi se rollback
	Begin tran
		begin try
			delete from Products
			where Id=@id
			delete from ProductTranslations
			where ProductId=@id
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


