USE SLD;	--�׽�Ʈ �� �ش� DB�� �Է� �� ���



--���� ���ϴ� �Լ�
CREATE FUNCTION [dbo].[FC_SUDEL_SUM]( @firstVal INT, @secondVal INT )
RETURNS INT
BEGIN
	DECLARE @retVal INT;
	SET @retVal = @firstVal + @secondVal;
	RETURN @retVal;
END
GO

SELECT dbo.FC_SUDEL_SUM(10,5) AS �հ�

-- �⵵ ������ ���� ���ϴ� �Լ�
CREATE FUNCTION [dbo].[FC_FIND_AGE]( @inputVal INT )
RETURNS INT
BEGIN
	DECLARE @retVal INT;
	SET @retVal = YEAR(GETDATE()) - @inputVal + 1;
	RETURN @retVal;
END
GO

SELECT dbo.FC_SUDEL(2002) AS ������