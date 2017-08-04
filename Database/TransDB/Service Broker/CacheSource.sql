CREATE SERVICE [CacheSource]
    AUTHORIZATION [dbo]
    ON QUEUE [dbo].[CacheQueue]
    ([CacheIntegartion]);


GO
GRANT SEND
    ON SERVICE::[CacheSource] TO PUBLIC;


GO
GRANT SEND
    ON SERVICE::[CacheSource] TO [abc\CacherAgent_SVC];

