Create PROCEDURE [dbo].[Get_Product_Attributes] 
	@id int,
	@language varchar(5)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   select
		a.Id,
		a.[Name],
		convert(nvarchar(200),case 
			when a.BackendType= 'int' then convert(nvarchar(200),ai.Value)
			when a.BackendType= 'text' then convert(nvarchar(200),ai.Value) 
			when a.BackendType= 'datetime' then convert(nvarchar(200),adt.Value) 
			when a.BackendType= 'decimal' then convert(nvarchar(200),ad.Value) 
			when a.BackendType= 'varchar' then convert(varchar(200),avc.Value) 
		 end) as [Value]
		 from Attributes a
		 left join AttributeValueInts ai on a.Id = ai.AttributeId and ai.LanguageId=@language and ai.ProductId = @id
		 left join AttributeValueText avt on a.Id = avt.AttributeId and avt.LanguageId=@language and avt.ProductId = @id
		 left join AttributeValueDateTimes adt on a.Id = adt.AttributeId and adt.LanguageId=@language and adt.ProductId = @id
		 left join AttributeValueDecimals ad on a.Id = ad.AttributeId and ad.LanguageId=@language and ad.ProductId = @id
		 left join AttributeValueVarchars avc on a.Id = avc.AttributeId and avc.LanguageId=@language and avc.ProductId =@id 

END