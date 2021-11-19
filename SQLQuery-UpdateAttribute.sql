Create PROCEDURE [dbo].[Update_Attribute]
	@id int,
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
	  --Insert attribute
		update Attributes set 
			Name = @name,
			SortOrder = @sortOrder,
			BackendType = BackendType,
			@isActive = @isActive
		where Id = @id
		--Insert options
		if @hasOption = 1
			begin
				declare @optionId int
				if not exists (select 1 from AttributeOptions where AttributeId=@id)
					begin
						insert into AttributeOptions(AttributeId,SortOrder) values(@id,1)
						select @optionId = SCOPE_IDENTITY()
					end
				else
					begin
						select @optionId = Id from AttributeOptions where AttributeId = @id
					end
				--delete old option values
				delete from AttributeOptionValues where OptionId = @optionId
				--Insert option values
				declare @valueTbl table(Data nvarchar(255))
				insert into @valueTbl(Data)
				select * from dbo.ufn_CSVToTable(@values,',')

				insert into AttributeOptionValues(OptionId,Value,LanguageId)
				select @optionId,*,@language from @valueTbl
			end
		else
			begin
				delete from AttributeOptionValues where OptionId 
							in (select Id from AttributeOptions where AttributeId = @id) 
				delete from AttributeOptions where AttributeId = @id

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