CREATE TABLE [dbo].[ProductType] (
    [Id]      INT           IDENTITY (1, 1) NOT NULL,
    [Name]    VARCHAR (50)  NOT NULL,
    [AddedOn] DATETIME2 (7) CONSTRAINT [DF_ProductType_AddedOn] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ProductType] PRIMARY KEY CLUSTERED ([Id] ASC)
);

