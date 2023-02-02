USE SLD;



-- DDL(�̷� ���� ���̺� ����)
CREATE TABLE [dbo].[TB_HIST_USER](
   [USER_NUMBER] [varchar](128) NOT NULL,
   [USER_ID] [varchar](128) NOT NULL,
   [USER_NM] [varchar](20) NOT NULL,
   [STATUSE] [varchar](3) NOT NULL,
   [REG_ID] [varchar](20) NOT NULL,
   [REG_DATE] [datetime] NOT NULL,
   [HIST_DATE] [datetime] NOT NULL,
) ON [PRIMARY]

--���̺� Ȯ��
SELECT * FROM TB_HIST_USER



--���Խ� �߻��ϴ� Ʈ���� ����
CREATE TRIGGER USER_HIST_I
ON TB_USER
FOR INSERT
AS

BEGIN

   -- ���� ����
   DECLARE
      @USER_NUMBER   varchar(128)
      , @USER_ID      VARCHAR(30)
        , @USER_NM      VARCHAR(50)
      , @REG_ID      VARCHAR(50)
      , @REG_DATE      DATETIME
        , @HIST_DATE   DATETIME

   -- ������ ������ ������ ����
   SELECT
      @USER_NUMBER   = USER_NUMBER
      , @USER_ID      = [USER_ID]
        , @USER_NM      = USER_NM
      , @REG_ID      = REG_ID
      , @REG_DATE      = REG_DATE
        , @HIST_DATE   = GETDATE()
   FROM TB_USER

   -- �α� ���̺� ����
   INSERT INTO TB_HIST_USER(USER_NUMBER, [USER_ID], USER_NM, REG_ID, REG_DATE, HIST_DATE, STATUSE )
   VALUES (@USER_NUMBER, @USER_ID, @USER_NM, @REG_ID, @REG_DATE, @HIST_DATE, 'I')
END
--���Խ� �߻��ϴ� Ʈ���� ����


--������ �߻��ϴ� Ʈ���� ����
CREATE TRIGGER USER_HIST_U
ON TB_USER
FOR UPDATE
AS

BEGIN

   -- ���� ����
	DECLARE
		@USER_NUMBER	varchar(128)
		, @USER_ID		VARCHAR(30)
		, @USER_NM		VARCHAR(50)
		, @REG_ID		VARCHAR(50)
		, @REG_DATE		DATETIME
		, @HIST_DATE	DATETIME

	 IF UPDATE([USER_ID]) OR UPDATE(USER_NM)
	 BEGIN

		--PRINT @USER_NUMBER
		-- ������ ������ ������ ����
		SELECT
			@USER_NUMBER   = USER_NUMBER
			, @USER_ID     = [USER_ID]
			, @USER_NM     = USER_NM
			, @REG_ID      = REG_ID
			, @REG_DATE    = REG_DATE
			, @HIST_DATE   = GETDATE()
	   FROM TB_USER

	  PRINT @USER_NUMBER

	   -- �α� ���̺� ����
	   INSERT INTO TB_HIST_USER(USER_NUMBER, [USER_ID], USER_NM, REG_ID, REG_DATE, HIST_DATE, STATUSE )
	   VALUES (@USER_NUMBER, @USER_ID, @USER_NM, @REG_ID, @REG_DATE, @HIST_DATE, 'U')
   END
END
--������ �߻��ϴ� Ʈ���� ����


--������ �߻��ϴ� Ʈ���� ����
CREATE TRIGGER USER_HIST_D
ON TB_USER
FOR DELETE
AS

BEGIN

   -- ���� ����
	DECLARE
		@USER_NUMBER	varchar(128)
		, @USER_ID		VARCHAR(30)
		, @USER_NM		VARCHAR(50)
		, @REG_ID		VARCHAR(50)
		, @REG_DATE		DATETIME
		, @HIST_DATE	DATETIME

	 --IF UPDATE([USER_ID]) OR UPDATE(USER_NM)
	 BEGIN

		--PRINT @USER_NUMBER
		-- ������ ������ ������ ����
		SELECT
			@USER_NUMBER   = USER_NUMBER
			, @USER_ID     = [USER_ID]
			, @USER_NM     = USER_NM
			, @REG_ID      = REG_ID
			, @REG_DATE    = REG_DATE
			, @HIST_DATE   = GETDATE()
	   FROM TB_USER

	  PRINT @USER_NUMBER

	   -- �α� ���̺� ����
	   INSERT INTO TB_HIST_USER(USER_NUMBER, [USER_ID], USER_NM, REG_ID, REG_DATE, HIST_DATE, STATUSE )
	   VALUES (@USER_NUMBER, @USER_ID, @USER_NM, @REG_ID, @REG_DATE, @HIST_DATE, 'D')
   END
END

--���̺� Ȯ��
SELECT * FROM TB_HIST_USER

--���� ���̺� ������ ����
INSERT INTO TB_USER(USER_NUMBER, [USER_ID], USER_PW, USER_NM, DEPARTMENT_CD, TEAM_CD, REG_ID, REG_DATE)
VALUES ('1111', 'idqwer', '123', '�����', '001', '001', '�����', GETDATE())

INSERT INTO TB_USER(USER_NUMBER, [USER_ID], USER_PW, USER_NM, DEPARTMENT_CD, TEAM_CD, REG_ID, REG_DATE)
VALUES ('2222', 'idqwer', '123', '�ϵ���', '001', '001', '�ϵ���', GETDATE())

--���̺� Ȯ��
SELECT * FROM TB_HIST_USER

--���� ���̺� ������ �̷� ����(����)
UPDATE TB_USER
SET
   [USER_ID] = 'test123'
   , USER_NM = 'ȫ�浿'
WHERE USER_NUMBER = '1111'

--���̺� Ȯ��
SELECT * FROM TB_HIST_USER

--���� ���̺��� ������ �߻��ϴ� Ʈ���� ����
DELETE FROM TB_USER WHERE USER_NUMBER = '1111'
DELETE FROM TB_USER WHERE USER_NUMBER = '2222'

--���̺� Ȯ��
SELECT * FROM TB_HIST_USER





