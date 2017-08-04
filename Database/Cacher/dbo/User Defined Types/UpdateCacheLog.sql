CREATE TYPE [dbo].[UpdateCacheLog] AS TABLE (
    [CachedOn] DATETIME2 (7) NULL,
    [Id]       INT           NULL,
    [OnServer] VARCHAR (100) NULL);

