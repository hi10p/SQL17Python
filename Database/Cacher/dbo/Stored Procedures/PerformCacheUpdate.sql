--DECLARE @message XML = '<ProductType><Id>51</Id><Name>HelloWorld</Name></ProductType>'
--DECLARE	@Name varchar(50),@Id Int
--	SELECT @Id = P.C.value('Id[1]','INT'),@Name = P.C.value('Name[1]','Varchar(50)')
--	FROM @message.nodes('ProductType') as P(C)

--select @Id,@Name
  
CREATE PROCEDURE [dbo].[PerformCacheUpdate]
AS
BEGIN
	DECLARE @Handle UNIQUEIDENTIFIER
	IF( @Handle is null)
		sELECT @Handle 
	DECLARE @messageType NVARCHAR(256)
	DECLARE @message XML
	DECLARE @contract Nvarchar(250)
	DECLARE @CacheLog TABLE(Id INT, CachedOn DateTime,OnServer VARCHAR(100));
	BEGIN TRY
		BEGIN TRANSACTION
			WAITFOR (RECEIVE TOP (1)
							@Handle = conversation_handle,
							@messageType = message_type_name,
							@message = CAST(message_body AS XML),
							@contract = service_contract_name
						FROM 
							[dbo].[CacheQueue]
						), TIMEOUT 1000
			Select @Handle, @messageType,@message,@contract		
				
			IF (@Handle is not NULL)-- Message found with handle
			BEGIN
				--If message is to update 
				IF(@messageType = N'UpdateMessage')    
				BEGIN
					--Refresh web cache    
					INSERT INTO @CacheLog(CachedOn, Id, OnServer)
					EXEC [dbo].[UpdateWebCache] @message;

					--log
					INSERT INTO CacheLog(Id,CachedOn,OnServer)
					SELECT Id,CachedOn,OnServer FROM @CacheLog;

					END CONVERSATION @Handle;    
				END

				IF (@messageType = CAST('http://schemas.microsoft.com/SQL/ServiceBroker/EndDialog' AS NVARCHAR(256)))
				BEGIN
				
					END CONVERSATION @Handle;
				END
				ELSE IF (@messageType = CAST('http://schemas.microsoft.com/SQL/ServiceBroker/Error' AS NVARCHAR(256)))
				BEGIN
					INSERT INTO CacheIntegrationError(Handle,[message],LoggedOn)
					VALUES(@Handle,@message,GETDATE())
					END CONVERSATION @Handle WITH CLEANUP;
				END

			END				
		COMMIT TRANSACTION;    
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		INSERT INTO CacheIntegrationError(Handle,[message],LoggedOn)
			VALUES(NEWID(),'<error>'+ERROR_MESSAGE()+'</error>',GETDATE());
	END CATCH
END