USE [RestAPIDapper2]
GO

/****** Object:  StoredProcedure [dbo].[Get_Roll_AllPaging]    Script Date: 18/11/2021 10:06:36 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_User_AllPaging] 
	-- Add the parameters for the stored procedure here
	@keyword nvarchar(50),
	@pageIndex int,
	@pageSize int,
	@totalRow int output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--offset bỏ qua bao nhieu rows ko lấy
	-- fetch next --chỉ lấy số lượng dòng @pageSize tiếp theo 
	select @totalRow = count(*) from AspNetUsers r 
	where (@keyword is null or r.FullName like @keyword +'%' or r.UserName like @keyword +'%')

	select 
		Id,
		UserName,
		Email,
		PhoneNumber,
		FullName,
		Address
	from AspNetUsers r 
	where (@keyword is null or r.FullName like @keyword +'%' or r.UserName like @keyword +'%')
	order by r.FullName
	OFFSET (@pageIndex - 1) * @pageSize rows 
	fetch next @pageSize row only 
END
GO


