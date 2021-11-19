Create PROCEDURE [dbo].[Delete_Attribute]
	@id int
AS
BEGIN
	SET NOCOUNT ON;
	set xact_abort on;
	begin tran
	begin try
	  delete from AttributeOptionValues where OptionId
	  in (select Id from AttributeOptions where AttributeId = @id)

	  delete from AttributeOptions where AttributeId = @id

	  delete from AttributeValueDateTimes where AttributeId = @id
	  delete from AttributeValueDecimals where AttributeId = @id

	  delete from AttributeValueInts where AttributeId = @id
	  delete from AttributeValueText where AttributeId = @id
	  delete from AttributeValueVarchars where AttributeId = @id

	  delete from Attributes where Id = @id
	commit
	end try
	begin catch
		rollback
		  DECLARE @ErrorMessage VARCHAR(2000)
		  SELECT @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
		  RAISERROR(@ErrorMessage, 16, 1)
	end catch



  
END