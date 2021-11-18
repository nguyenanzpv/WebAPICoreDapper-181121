--create TYPE [dbo].[Permission] AS TABLE(
--    [RoleId] uniqueidentifier,
--    [FunctionId] [varchar](50) NOT NULL,
--    [ActionId] [varchar](50) NOT NULL
--)
--GO

Create PROCEDURE [dbo].[Create_Permission]
	@roleId uniqueidentifier,
	@permissions dbo.Permission readonly
AS
BEGIN
	SET NOCOUNT ON;
	set xact_abort on;
	begin tran
	begin try
	   delete from Permissions where RoleId = @roleId

	   insert into Permissions (RoleId,FunctionId,ActionId)
	   select RoleId,FunctionId,ActionId from @permissions

	commit
	end try
	begin catch
		rollback
		  DECLARE @ErrorMessage VARCHAR(2000)
		  SELECT @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
		  RAISERROR(@ErrorMessage, 16, 1)
	end catch



  
END