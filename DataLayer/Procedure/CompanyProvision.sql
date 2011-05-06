/****** Object:  StoredProcedure [dbo].[CompanyProvision]    Script Date: 04/08/2011 17:03:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[CompanyProvision](
	@pCompanyName	nvarchar(200),
	@pCurrentLogonName nvarchar(100),
	@pFirstName nvarchar(100),
	@pLastName nvarchar(100),
	@pLoginEmailAddress nvarchar(100),
	@pTelephone nvarchar(50),
	@pPassword nvarchar(50),	
	@pCompanyId int out
)
AS

SET NOCOUNT ON

DECLARE @SQLErr int,
        @Exitcode int,
        @ProcedureName sysname,
        @RowsAffected int,
        @ErrorNumber int,
        @ErrorString nvarchar(255),
        @CurrentDateTime datetime,
        @CurrentUser nvarchar(100),
        @CompanyId int,
        @UserId int

SELECT @ExitCode=1,
       @ProcedureName=object_name(@@procid),
       @CurrentDateTime = getdate()

if(@pCompanyName is NULL)
BEGIN
	EXEC dbo.ErrMsgBuild @ErrorNumber output, @ErrorString output, @ProcedureName, 50301, 'Company Name'
	GOTO ErrorHandler
END

if(@pCurrentLogonName is NULL)
BEGIN
	EXEC dbo.ErrMsgBuild @ErrorNumber output, @ErrorString output, @ProcedureName, 50301, 'Current Logon Name'
	GOTO ErrorHandler
END

IF EXISTS (SELECT 1 FROM dbo.Company WHERE CompanyName = @pCompanyName)
BEGIN
	EXEC dbo.ErrMsgBuild @ErrorNumber output, @ErrorString output, @ProcedureName, 50307, 'Company Name'
	GOTO ErrorHandler
END

if(@pFirstName is NULL)
BEGIN
	EXEC dbo.ErrMsgBuild @ErrorNumber output, @ErrorString output, @ProcedureName, 50301, 'First Name'
	GOTO ErrorHandler
END

if(@pLastName is NULL)
BEGIN
	EXEC dbo.ErrMsgBuild @ErrorNumber output, @ErrorString output, @ProcedureName, 50301, 'Last Name'
	GOTO ErrorHandler
END

if(@pLoginEmailAddress is NULL)
BEGIN
	EXEC dbo.ErrMsgBuild @ErrorNumber output, @ErrorString output, @ProcedureName, 50301, 'Login Email Address'
	GOTO ErrorHandler
END

if(@pPassword is NULL)
BEGIN
	EXEC dbo.ErrMsgBuild @ErrorNumber output, @ErrorString output, @ProcedureName, 50301, 'Password'
	GOTO ErrorHandler
END

BEGIN TRY
    BEGIN TRANSACTION   
	insert into dbo.Company (
		CompanyName,
		CreatedDate,
		ModifiedDate)
	values (
		@pCompanyName,
		@CurrentDateTime,
		@CurrentDateTime)
		
	Select @CompanyId = SCOPE_IDENTITY()
	
    insert into dbo.UserAccount(
        FirstName,
        LastName,
        LoginEmailAddress,
        Telephone,
        Password)
    values (
        @pFirstName,
        @pLastName,
        @pLoginEmailAddress,
        @pTelephone,
        @pPassword )   
        	
	Select @UserId = SCOPE_IDENTITY()
	
	Update dbo.Company 
	Set CreatedBy = @UserId,
	    ModifiedBy = @UserId
	Where CompanyId = @CompanyId
	
	Select @pCompanyId = @CompanyId
COMMIT               
END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
     ROLLBACK 
  EXEC dbo.ErrMsgBuild @ErrorNumber output, @ErrorString output, @ProcedureName, 50305, 'Company'
  GOTO ErrorHandler
END CATCH


SELECT @ExitCode = 0
GOTO ExitProc

ErrorHandler:
       SELECT @ExitCode = 1
       RAISERROR @ErrorNumber @ErrorString


ExitProc:
SET NOCOUNT OFF
RETURN @ExitCode



GO


