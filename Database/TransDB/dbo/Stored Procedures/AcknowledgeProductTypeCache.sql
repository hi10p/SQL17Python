
CREATE PROCEDURE [dbo].[AcknowledgeProductTypeCache]
AS
BEGIN
	DECLARE @Handle UNIQUEIDENTIFIER
	DECLARE @messageType NVARCHAR(256)
	DECLARE @message XML
	DECLARE @errorMessageBody XML
	DECLARE @contract Nvarchar(250)
	BEGIN TRY
		WAITFOR (RECEIVE TOP (1)
						@Handle = conversation_handle,
						@messageType = message_type_name,
						@message = CAST(message_body AS XML),
						@contract = service_contract_name
					FROM 
						[dbo].[CacheQueue]
					), TIMEOUT 1000
		IF (@Handle IS NOT NULL) -- Message found with handle
		BEGIN
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
	END TRY
	BEGIN CATCH
		INSERT INTO CacheIntegrationError(Handle,[message],LoggedOn)
			VALUES(NEWID(),'<error>'+ERROR_MESSAGE()+'</error>',GETDATE())
	END CATCH
END