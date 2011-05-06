/****** Object:  StoredProcedure [dbo].[ErrMsgBuild]    Script Date: 04/08/2011 17:10:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

  
CREATE PROCEDURE [dbo].[ErrMsgBuild]  
  @pErrNo int output,  
  @pErrMsg varchar(4000) output,  
  @pCallingProc varchar(200),  
  @pErrorID int,  
  @pArg1 varchar(500) = null,   
  @pArg2 varchar(500) = null,   
  @pArg3 varchar(500) = null,   
  @pArg4 varchar(500) = null,  
  @pArg5 varchar(500) = null,  
  @pArg6 varchar(500) = null  
AS   
SET nocount on  
  
/* Standard declares for error handling */  
DECLARE                                          
     @RowCount       int,                      
       @Debug          tinyint,                 
       @PROCEDURENAME  varchar(30),              
       @TgtTbl         varchar(30),              
       @KeyString      varchar(64),              
       @TransStarted   tinyint,                  
       @TRUE           tinyint,                  
       @FALSE          tinyint                   
  
SET @TRUE = 1  
SET @FALSE = 0  
SET @PROCEDURENAME = object_name(@@procid)  
SET @TgtTbl = ''  
  
/* Declares for this sproc */  
DECLARE  
        @ErrMsg varchar(4000),  
        @Arg1 varchar(500),  
        @Arg2 varchar(500),  
        @Arg3 varchar(500),  
        @Arg4 varchar(500),  
        @Arg5 varchar(500),  
        @Arg6 varchar(500)  
  
SET @pErrNo = @pErrorID  
  
-- If bad Error # passed in  
IF ( @pErrNo < 999 or @pErrNo is NULL )  
BEGIN  
    SET @pErrNo = 13000            
    GOTO ErrorHandler  
END  
  
-- Get associated text for this Error #  
SELECT @ErrMsg = [ErrorDescription]  
FROM ErrorMessages (NOLOCK)  
WHERE ErrorMessageID = @pErrNo  
  
IF ( @@rowcount = 0 )  
BEGIN  
   GOTO ErrorHandler  
END  
  
  
/* Replace placeholders with the args passed in */  
IF (@pArg1 is not null)  
BEGIN  
  SET @Arg1 = ltrim(@pArg1)  
  SET @ErrMsg = REPLACE(@ErrMsg, '%1', @Arg1)  
END  
IF (@pArg2 is not null)  
BEGIN  
  SET @Arg2 = ltrim(@pArg2)  
  SET @ErrMsg = REPLACE(@ErrMsg, '%2', @Arg2)  
END  
IF (@pArg3 is not null)  
BEGIN  
  SET @Arg3 = ltrim(@pArg3)  
  SET @ErrMsg = REPLACE(@ErrMsg, '%3', @Arg3)  
END  
IF (@pArg4 is not null)  
BEGIN  
  SET @Arg4 = ltrim(@pArg4)  
  SET @ErrMsg = REPLACE(@ErrMsg, '%4', @Arg4)  
END  
IF (@pArg5 is not null)  
BEGIN  
  SET @Arg5 = ltrim(@pArg5)  
  SET @ErrMsg = REPLACE(@ErrMsg, '%5', @Arg5)  
END  
IF (@pArg6 is not null)  
BEGIN  
  SET @Arg6 = ltrim(@pArg6)  
  SET @ErrMsg = REPLACE(@ErrMsg, '%6', @Arg6)  
END  
  
SET @pErrMsg = @ErrMsg  
  
GOTO ExitProc     
ErrorHandler:  
  
   -- Set generic msg and get out  
   SELECT @ErrMsg = 'Unidentified error has occurred'  
     
ExitProc:  
   RETURN

GO


