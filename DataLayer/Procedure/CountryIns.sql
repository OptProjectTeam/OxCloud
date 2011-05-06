/****** Object:  StoredProcedure [dbo].[CountryIns]    Script Date: 04/08/2011 17:05:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


Create procedure [dbo].[CountryIns] (
@pCountryName Varchar(50),
@pCurrentUserId int)

AS

SET NOCOUNT ON

DECLARE @SQLErr int,
        @Exitcode int,
        @ProcedureName sysname,
        @RowsAffected int,
        @ErrorNumber int,
        @ErrorString nvarchar(255),
        @CurrentDateTime datetime,
        @CurrentUser nvarchar(100)            


SELECT @ExitCode=1,
       @ProcedureName=object_name(@@procid),
       @CurrentDateTime = getdate()
       
if(@pCountryName is NULL)
BEGIN
	EXEC dbo.ErrMsgBuild @ErrorNumber output, @ErrorString output, @ProcedureName, 50301, 'Country Name'
	GOTO ErrorHandler
END

select @CurrentUser = Userid from UserAccount  -- how to get the current user id ? pls check this line and update the correct one

BEGIN TRY
    BEGIN TRANSACTION 
    
	insert into Country(
		CountryName,
		CreatedBy,
		ModifiedBy)
	values (
	@pCountryName,
	@CurrentUser,
	@CurrentUser)
	
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


