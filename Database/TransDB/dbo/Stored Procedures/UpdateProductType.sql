CREATE PROCEDURE [dbo].[UpdateProductType]
	@Name VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @CacheLog TABLE(Id INT, CachedOn DateTime,OnServer VARCHAR(100));
	DECLARE @Id int;
	DECLARE @cacheHandle UNIQUEIDENTIFIER;
	DECLARE @message XML
	INSERT INTO [dbo].[ProductType]
           ([Name])
     VALUES
           (@Name);
	
	SET @Id= SCOPE_IDENTITY();

	SET @message = (Select Id=@Id,[Name]=@Name 
	FOR XML PATH('ProductType'));
	----Update web cache
	--INSERT INTO @CacheLog(CachedOn, Id, OnServer)
	--EXEC [dbo].[UpdateWebCache] @Name,@Id;

	----Update log
	--INSERT INTO CacheLog(Id,CachedOn,OnServer)
	--SELECT Id, CachedOn,OnServer FROM @CacheLog

	BEGIN DIALOG CONVERSATION @cacheHandle
	FROM SERVICE CacheSource
	TO SERVICE 'CacheTarget' 
	ON CONTRACT CacheIntegartion
	WITH ENCRYPTION = OFF;
	SEND ON CONVERSATION @cacheHandle MESSAGE TYPE UpdateMessage(@message)

END