CREATE PROCEDURE [dbo].[UpdateWebCache] 
@message XML
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE	@Name varchar(50),@Id Int
	SELECT @Id = P.C.value('Id[1]','INT'),@Name = P.C.value('Name[1]','Varchar(50)')
	FROM @message.nodes('ProductType') as P(C)

DECLARE @UpdateCache NVARCHAR(MAX) = N'
import pandas as PND #data structure package
def UpdateCache(name,id):
    import requests as HTTP #http request package
    #Perfom HTTP POST to update cache
    httpRequest = HTTP.post("http://localhost/RESTful.Cache/ProductType/UpdateCache",{"Name":name,"Id":id}) 
    cacheLog = httpRequest.json()
    return cacheLog

#Update cache and build log element
log = [UpdateCache("'+ @Name+'",'+ CAST(@Id as VARCHAR(10)) +')]
#Return data frame i.e. table structure from SQL
OutputDataSet = PND.DataFrame(data=log)
'
;

	EXECUTE SP_EXECUTE_EXTERNAL_SCRIPT 
		@language = N'python'
		,@script = @UpdateCache
		WITH RESULT SETS (AS TYPE dbo.UpdateCacheLog);
END
