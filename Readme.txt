Solution structure is
1) Applications					->Solution Folder 
	a) RESTful.Cache			->RESTful cache application, a ASP.Net WebAPI2.
	b) WebApplication			->MVC application, a ASP.Net MVC web client. 
2) Databases
	a) Cacher					-> Cache refreshing database with service broker enabled, external script execution enabled.
	b) TransDB					-> Transactional database or OLTP with service broker enabled.
	Note:
	I)	Logins  [abc\TransDB_SVC] and [abc\CacherAgent_SVC] should be replaced with available domain account.
	II)	Endpoint port numbers can be changed as per allowed ports in local network.
	 

