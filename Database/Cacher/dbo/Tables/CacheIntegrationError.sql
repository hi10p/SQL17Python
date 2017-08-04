CREATE TABLE [dbo].[CacheIntegrationError] (
    [Handle]      UNIQUEIDENTIFIER NULL,
    [message]     XML              NULL,
    [LoggedOn]    DATETIME2 (7)    NULL,
    [MessageType] VARCHAR (150)    NULL
);

