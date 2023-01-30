USE SLD;	--테스트 시 해당 DB명 입력 후 사용



--덧셈 구하는 함수
CREATE FUNCTION [dbo].[FC_SUDEL_SUM]( @firstVal INT, @secondVal INT )
RETURNS INT
BEGIN
	DECLARE @retVal INT;
	SET @retVal = @firstVal + @secondVal;
	RETURN @retVal;
END
GO

SELECT dbo.FC_SUDEL_SUM(10,5) AS 합계

-- 년도 가지고 나이 구하는 함수
CREATE FUNCTION [dbo].[FC_FIND_AGE]( @inputVal INT )
RETURNS INT
BEGIN
	DECLARE @retVal INT;
	SET @retVal = YEAR(GETDATE()) - @inputVal + 1;
	RETURN @retVal;
END
GO

SELECT dbo.FC_SUDEL(2002) AS 내나이