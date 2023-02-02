USE SLD;



-- DDL(이력 쌓을 테이블 생성)
CREATE TABLE [dbo].[TB_HIST_USER](
   [USER_NUMBER] [varchar](128) NOT NULL,
   [USER_ID] [varchar](128) NOT NULL,
   [USER_NM] [varchar](20) NOT NULL,
   [STATUSE] [varchar](3) NOT NULL,
   [REG_ID] [varchar](20) NOT NULL,
   [REG_DATE] [datetime] NOT NULL,
   [HIST_DATE] [datetime] NOT NULL,
) ON [PRIMARY]

--테이블 확인
SELECT * FROM TB_HIST_USER



--삽입시 발생하는 트리거 생성
CREATE TRIGGER USER_HIST_I
ON TB_USER
FOR INSERT
AS

BEGIN

   -- 변수 선언
   DECLARE
      @USER_NUMBER   varchar(128)
      , @USER_ID      VARCHAR(30)
        , @USER_NM      VARCHAR(50)
      , @REG_ID      VARCHAR(50)
      , @REG_DATE      DATETIME
        , @HIST_DATE   DATETIME

   -- 생성된 데이터 변수에 저장
   SELECT
      @USER_NUMBER   = USER_NUMBER
      , @USER_ID      = [USER_ID]
        , @USER_NM      = USER_NM
      , @REG_ID      = REG_ID
      , @REG_DATE      = REG_DATE
        , @HIST_DATE   = GETDATE()
   FROM TB_USER

   -- 로그 테이블에 저장
   INSERT INTO TB_HIST_USER(USER_NUMBER, [USER_ID], USER_NM, REG_ID, REG_DATE, HIST_DATE, STATUSE )
   VALUES (@USER_NUMBER, @USER_ID, @USER_NM, @REG_ID, @REG_DATE, @HIST_DATE, 'I')
END
--삽입시 발생하는 트리거 생성


--수정시 발생하는 트리거 생성
CREATE TRIGGER USER_HIST_U
ON TB_USER
FOR UPDATE
AS

BEGIN

   -- 변수 선언
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
		-- 생성된 데이터 변수에 저장
		SELECT
			@USER_NUMBER   = USER_NUMBER
			, @USER_ID     = [USER_ID]
			, @USER_NM     = USER_NM
			, @REG_ID      = REG_ID
			, @REG_DATE    = REG_DATE
			, @HIST_DATE   = GETDATE()
	   FROM TB_USER

	  PRINT @USER_NUMBER

	   -- 로그 테이블에 저장
	   INSERT INTO TB_HIST_USER(USER_NUMBER, [USER_ID], USER_NM, REG_ID, REG_DATE, HIST_DATE, STATUSE )
	   VALUES (@USER_NUMBER, @USER_ID, @USER_NM, @REG_ID, @REG_DATE, @HIST_DATE, 'U')
   END
END
--수정시 발생하는 트리거 생성


--삭제시 발생하는 트리거 생성
CREATE TRIGGER USER_HIST_D
ON TB_USER
FOR DELETE
AS

BEGIN

   -- 변수 선언
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
		-- 생성된 데이터 변수에 저장
		SELECT
			@USER_NUMBER   = USER_NUMBER
			, @USER_ID     = [USER_ID]
			, @USER_NM     = USER_NM
			, @REG_ID      = REG_ID
			, @REG_DATE    = REG_DATE
			, @HIST_DATE   = GETDATE()
	   FROM TB_USER

	  PRINT @USER_NUMBER

	   -- 로그 테이블에 저장
	   INSERT INTO TB_HIST_USER(USER_NUMBER, [USER_ID], USER_NM, REG_ID, REG_DATE, HIST_DATE, STATUSE )
	   VALUES (@USER_NUMBER, @USER_ID, @USER_NM, @REG_ID, @REG_DATE, @HIST_DATE, 'D')
   END
END

--테이블 확인
SELECT * FROM TB_HIST_USER

--기존 테이블에 데이터 삽입
INSERT INTO TB_USER(USER_NUMBER, [USER_ID], USER_PW, USER_NM, DEPARTMENT_CD, TEAM_CD, REG_ID, REG_DATE)
VALUES ('1111', 'idqwer', '123', '김수완', '001', '001', '김수완', GETDATE())

INSERT INTO TB_USER(USER_NUMBER, [USER_ID], USER_PW, USER_NM, DEPARTMENT_CD, TEAM_CD, REG_ID, REG_DATE)
VALUES ('2222', 'idqwer', '123', '완두콩', '001', '001', '완두콩', GETDATE())

--테이블 확인
SELECT * FROM TB_HIST_USER

--기존 테이블에 데이터 이력 변경(수정)
UPDATE TB_USER
SET
   [USER_ID] = 'test123'
   , USER_NM = '홍길동'
WHERE USER_NUMBER = '1111'

--테이블 확인
SELECT * FROM TB_HIST_USER

--기존 테이블에서 삭제시 발생하는 트리거 생성
DELETE FROM TB_USER WHERE USER_NUMBER = '1111'
DELETE FROM TB_USER WHERE USER_NUMBER = '2222'

--테이블 확인
SELECT * FROM TB_HIST_USER





