CREATE DATABASE mumdab;
GO
USE mumdab_new;
GO
CREATE SCHEMA employee;
GO
CREATE SCHEMA salandser;
GO
CREATE SCHEMA customer;
GO

CREATE TABLE employee.empgrade
(GRD_ID NVARCHAR(2),
 GRD_NAME NVARCHAR(50),

 CONSTRAINT PK_grade PRIMARY KEY(GRD_ID)
)
GO

CREATE TABLE employee.emptype
(TYP_ID NVARCHAR(1),
 TYP_NAME NVARCHAR(50),

 CONSTRAINT PK_emptype PRIMARY KEY(TYP_ID)
)
GO

CREATE TABLE salandser.area
(AREA_CODE NVARCHAR(5),
 AREA_NAME NVARCHAR(50),

 CONSTRAINT PK_area PRIMARY KEY(AREA_CODE)
 )
 GO

 CREATE TABLE employee.empdetails
(EMP_ID INT IDENTITY(1,1),
 EMP_NAME NVARCHAR(50) NOT NULL,
 EMP_CONTACT NVARCHAR(10),
 PERM_ADDR NVARCHAR(200) NOT NULL,
 CURR_ADDR NVARCHAR(200) NOT NULL,
 AREA_CODE NVARCHAR(5) NOT NULL,
 GRD_ID NVARCHAR(2) NOT NULL,
 TYP_ID NVARCHAR(1) NOT NULL,
 EMP_MGR INT,
 ST_DTE DATE NOT NULL,
 END_DTE DATE,
 INF_COUNT INT NOT NULL DEFAULT 0,
 REASON NVARCHAR(100),

 CONSTRAINT PK_empdetails PRIMARY KEY(EMP_ID),
 CONSTRAINT FK_areacode FOREIGN KEY(AREA_CODE) REFERENCES salandser.area(AREA_CODE),
 CONSTRAINT FK_grdid FOREIGN KEY(GRD_ID) REFERENCES employee.empgrade(GRD_ID),
 CONSTRAINT FK_typid FOREIGN KEY(TYP_ID) REFERENCES employee.emptype(TYP_ID)
 )
 GO

 CREATE TABLE employee.empinfr
(EMP_ID INT NOT NULL,
 INF_DATE DATE NOT NULL,
 INF_REASON NVARCHAR(100) NOT NULL,

 CONSTRAINT FK_empid FOREIGN KEY(EMP_ID) REFERENCES employee.empdetails(EMP_ID)
)
GO

CREATE TABLE customer.custdetails
(CUST_ID INT IDENTITY(1,1),
 CUST_NAME NVARCHAR(50) NOT NULL,
 CUST_CONTACT NVARCHAR(10) NOT NULL,
 ST_DTE DATE NOT NULL,
 END_DTE DATE,
 INF_COUNT INT NOT NULL DEFAULT 0,
 REASON NVARCHAR(100),

 CONSTRAINT PK_custdetails PRIMARY KEY(CUST_ID)
)
GO

CREATE TABLE customer.pickup
(CUST_ID INT NOT NULL,
 P_ADDR NVARCHAR(200) NOT NULL,
 AREA_CODE NVARCHAR(5) NOT NULL,

 CONSTRAINT FK_custidp FOREIGN KEY(CUST_ID) REFERENCES customer.custdetails(CUST_ID),
 CONSTRAINT FK_areacodep FOREIGN KEY(AREA_CODE) REFERENCES salandser.area(AREA_CODE)
)
GO

CREATE TABLE customer.dropoff
(CUST_ID INT NOT NULL,
 D_ADDR NVARCHAR(200) NOT NULL,
 AREA_CODE NVARCHAR(5) NOT NULL,

 CONSTRAINT FK_custidd FOREIGN KEY(CUST_ID) REFERENCES customer.custdetails(CUST_ID),
 CONSTRAINT FK_areacoded FOREIGN KEY(AREA_CODE) REFERENCES salandser.area(AREA_CODE)
)
GO

 CREATE TABLE customer.custinfr
(CUST_ID INT NOT NULL,
 INF_DATE DATE NOT NULL,
 INF_REASON NVARCHAR(100) NOT NULL,

 CONSTRAINT FK_custidinf FOREIGN KEY(CUST_ID) REFERENCES customer.custdetails(CUST_ID)
)
GO

CREATE TABLE salandser.revenue
(CUST_ID INT NOT NULL,
 NUM_DABBAS INT NOT NULL DEFAULT 1,
 REVENUE INT

 CONSTRAINT FK_custidrev FOREIGN KEY(CUST_ID) REFERENCES customer.custdetails(CUST_ID)
 )
 GO

 CREATE TABLE salandser.empfunc
 (EMP_ID INT NOT NULL,
  P_AREA_ID NVARCHAR(5) NOT NULL,
  D_AREA_ID NVARCHAR(5) NOT NULL,
  
  CONSTRAINT FK_empID FOREIGN KEY(EMP_ID) REFERENCES employee.empdetails(EMP_ID),
  CONSTRAINT FK_areacodeP FOREIGN KEY(P_AREA_ID) REFERENCES salandser.area(AREA_CODE),
  CONSTRAINT FK_areacodeD FOREIGN KEY(D_AREA_ID) REFERENCES salandser.area(AREA_CODE)
  )

GO

CREATE TRIGGER [employee].[updempinfr]
   ON  [employee].[empinfr]
   AFTER INSERT, DELETE
AS 
BEGIN

    SET NOCOUNT ON;

    DECLARE @id int;

    DECLARE idcurs CURSOR FOR SELECT DISTINCT EMP_ID FROM [employee].[empdetails]

    OPEN idcurs

    FETCH NEXT FROM idcurs INTO @id

    WHILE @@FETCH_STATUS = 0
    BEGIN

        UPDATE  [employee].[empdetails]
        SET     INF_COUNT = (
                    SELECT  COUNT(*) 
                    FROM    [employee].[empinfr]
                    WHERE   EMP_ID = @id
                    )
        WHERE   EMP_ID = @id

    FETCH NEXT FROM idcurs INTO @id
    END

    CLOSE idcurs
    DEALLOCATE idcurs

END
GO

ALTER TABLE [employee].[empinfr] ENABLE TRIGGER [updempinfr]
GO

CREATE TRIGGER [customer].[updcustinfr]
   ON  [customer].[custinfr]
   AFTER INSERT, DELETE
AS 
BEGIN

    SET NOCOUNT ON;

    DECLARE @id int;

    DECLARE idcurs CURSOR FOR SELECT DISTINCT CUST_ID FROM [customer].[custdetails]

    OPEN idcurs

    FETCH NEXT FROM idcurs INTO @id

    WHILE @@FETCH_STATUS = 0
    BEGIN

        UPDATE  [customer].[custdetails]
        SET     INF_COUNT = (
                    SELECT  COUNT(*) 
                    FROM    [customer].[custinfr]
                    WHERE   CUST_ID = @id
                    )
        WHERE   CUST_ID = @id

    FETCH NEXT FROM idcurs INTO @id
    END

    CLOSE idcurs
    DEALLOCATE idcurs

END
GO

ALTER TABLE [customer].[custinfr] ENABLE TRIGGER [updcustinfr]
GO

CREATE TRIGGER [employee].[updemprsn]
   ON  [employee].[empdetails]
   AFTER UPDATE
AS 
BEGIN

    SET NOCOUNT ON;

    DECLARE @id int;

    DECLARE idcurs CURSOR FOR SELECT DISTINCT EMP_ID FROM [employee].[empdetails]

    OPEN idcurs

    FETCH NEXT FROM idcurs INTO @id

    WHILE @@FETCH_STATUS = 0
    BEGIN

        UPDATE  [employee].[empdetails]
        SET     REASON = '3 Infractions by employee.',
				END_DTE = (SELECT CAST(MAX(INF_DATE) AS DATE) FROM [employee].[empinfr] WHERE EMP_ID = @id)
        WHERE   EMP_ID = @id AND
				((SELECT  COUNT(*) FROM [employee].[empinfr] WHERE EMP_ID = @id)>2)

    FETCH NEXT FROM idcurs INTO @id
    END

    CLOSE idcurs
    DEALLOCATE idcurs

END
GO

ALTER TABLE [employee].[empdetails] ENABLE TRIGGER [updemprsn]
GO

CREATE TRIGGER [customer].[updcustrsn]
   ON  [customer].[custdetails]
   AFTER UPDATE
AS 
BEGIN

    SET NOCOUNT ON;

    DECLARE @id int;

    DECLARE idcurs CURSOR FOR SELECT DISTINCT CUST_ID FROM [customer].[custdetails]

    OPEN idcurs

    FETCH NEXT FROM idcurs INTO @id

    WHILE @@FETCH_STATUS = 0
    BEGIN

        UPDATE  [customer].[custdetails]
        SET     REASON = '3 Infractions by customer.',
				END_DTE = (SELECT CAST(MAX(INF_DATE) AS DATE) FROM [customer].[custinfr] WHERE CUST_ID = @id)
        WHERE   CUST_ID = @id AND
				((SELECT  COUNT(*) FROM [customer].[custinfr] WHERE CUST_ID = @id)>2)

    FETCH NEXT FROM idcurs INTO @id
    END

    CLOSE idcurs
    DEALLOCATE idcurs

END
GO

ALTER TABLE [customer].[custdetails] ENABLE TRIGGER [updcustrsn]
GO



