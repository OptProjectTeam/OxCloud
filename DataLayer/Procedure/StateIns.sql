/****** Object:  StoredProcedure [dbo].[StateIns]    Script Date: 04/08/2011 17:06:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



Create procedure [dbo].[StateIns] (

@pCountryId int ,
@pStateName varchar(50),
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
        @CurrentUser nvarchar(100),
        @SystemAdminRoleId int


SELECT @ExitCode=1,
       @ProcedureName=object_name(@@procid),
       @CurrentDateTime = getdate()


if(@pStateName is NULL)
BEGIN
EXEC dbo.ErrMsgBuild @ErrorNumber output, @ErrorString output, @ProcedureName, 50301, 'State Name'
GOTO ErrorHandler
END

IF EXISTS (SELECT 1 FROM dbo.State WHERE StateName = @pStateName)
BEGIN
	EXEC dbo.ErrMsgBuild @ErrorNumber output, @ErrorString output, @ProcedureName, 50307, 'State Name'
	GOTO ErrorHandler
	END
	
	select @pCountryId =CountryId from Country     -- these two lines are same as countryins proc. update it.
	select @CurrentUser=Userid from UserAccount
	
BEGIN TRY
    BEGIN TRANSACTION 
insert into State 
( 
CountryId ,
StateName ,
CreatedBy ,
ModifiedBy)
values
(
@pCountryId,
@pStateName ,
@CurrentUser,
@CurrentUser )
COMMIT          
END TRY
BEGIN CATCH
  IF @@TRANCOUNT > 0
     ROLLBACK 
  EXEC dbo.ErrMsgBuild @ErrorNumber output, @ErrorString output, @ProcedureName, 50305, 'State'
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


