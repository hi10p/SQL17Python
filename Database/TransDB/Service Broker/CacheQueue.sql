CREATE QUEUE [dbo].[CacheQueue]
    WITH POISON_MESSAGE_HANDLING(STATUS = OFF), ACTIVATION (STATUS = ON, PROCEDURE_NAME = [dbo].[AcknowledgeProductTypeCache], MAX_QUEUE_READERS = 1, EXECUTE AS N'dbo');


GO
GRANT RECEIVE
    ON OBJECT::[dbo].[CacheQueue] TO [abc\CacherAgent_SVC]
    AS [dbo];

