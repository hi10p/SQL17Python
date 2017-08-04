CREATE SERVICE [CacheTarget]
    AUTHORIZATION [dbo]
    ON QUEUE [dbo].[CacheQueue]
    ([CacheIntegartion]);


GO
GRANT SEND
    ON SERVICE::[CacheTarget] TO [abc\TransDB_SVC];

