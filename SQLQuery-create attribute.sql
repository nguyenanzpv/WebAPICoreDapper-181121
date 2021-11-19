Create PROCEDURE [dbo].[Create_Attribute]
	@code varchar(255),
	@name nvarchar(255),
	@sortOrder int,
	@backendType varchar(50),
	@isActive bit,
	@hasOption bit,
	@language varchar(5),
	@values nvarchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	set xact_abort on;
	begin tran
	begin try
	  if not exists(select 1 from Attributes where Code = @code)
	  begin
		--Insert attribute
		insert into Attributes(Code,Name,SortOrder,BackendType,IsActive)
		values(@code,@name,@sortOrder,@backendType,@isActive)
		--Insert options
		declare @attributeId int
		select @attributeId = SCOPE_IDENTITY()
		if @hasOption = 1
		begin
			insert into AttributeOptions(AttributeId,SortOrder) values(@attributeId,1)
			declare @optionId int
			select @optionId = SCOPE_IDENTITY()
			--Insert option values
			declare @valueTbl table(Data nvarchar(255))
			insert into @valueTbl(Data)
			select * from dbo.ufn_CSVToTable(@values,',')

			insert into AttributeOptionValues(OptionId,Value,LanguageId)
			select @optionId,*,@language from @valueTbl
		end
		
	  end
	commit
	end try
	begin catch
		rollback
		  DECLARE @ErrorMessage VARCHAR(2000)
		  SELECT @ErrorMessage = 'Lỗi: ' + ERROR_MESSAGE()
		  RAISERROR(@ErrorMessage, 16, 1)
	end catch

END