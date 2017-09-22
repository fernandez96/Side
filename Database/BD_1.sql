
USE Base
GO
--ELIMINAR SP

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Base].[RolGetAllActives]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Base].[RolGetAllActives]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Base].[UsuarioUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Base].[UsuarioUpdate]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Base].[UsuarioDelete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Base].[UsuarioDelete]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Base].[UsuarioInsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Base].[UsuarioInsert]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Base].[UsuarioGetById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Base].[UsuarioGetById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Base].[UsuarioGetAllFilter]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Base].[UsuarioGetAllFilter]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Base].[RolGetById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Base].[RolGetById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Base].[RolGetAllFilter]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Base].[RolGetAllFilter]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Base].[UsuarioGetByUsername]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Base].[UsuarioGetByUsername]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Base].[LogInsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Base].[LogInsert]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Base].[CargoGetById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Base].[CargoGetById]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Base].[CargoGetAllFilter]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Base].[CargoGetAllFilter]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Base].[ClienteCorreoInsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Base].[ClienteCorreoInsert]
GO
--ELIMINAR TABLAS
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Base].[Usuario]') AND type in (N'U'))
DROP TABLE [Base].[Usuario]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Base].[Rol]') AND type in (N'U'))
DROP TABLE [Base].[Rol]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Base].[Log]') AND type in (N'U'))
DROP TABLE [Base].[Log]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Base].[LogError]') AND type in (N'U'))
DROP TABLE [Base].[LogError]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Base].[Cargo]') AND type in (N'U'))
DROP TABLE [Base].[Cargo]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Base].[ClienteCorreo]') AND type in (N'P', N'PC'))
DROP TABLE [Base].[ClienteCorreo]
GO
IF  EXISTS (SELECT * FROM sys.schemas WHERE name = N'Base')
DROP SCHEMA [Base]
GO
--CREAR ESQUEMA
CREATE SCHEMA Base
GO
--CREAR TABLAS

CREATE TABLE [Base].[Log](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Usuario] [varchar](100) NOT NULL,
	[Mensaje] [varchar](4000) NOT NULL,
	[Controlador] [varchar](200) NOT NULL,
	[Accion] [varchar](100) NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[Objeto] [varchar](4000) NOT NULL,
	[Identificador] [int] NULL,
 CONSTRAINT [PK_}GiftCard_Log] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [Base].[LogError](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ErrorNumber] [int] NOT NULL,
	[ErrorSeverity] [int] NOT NULL,
	[ErrorState] [int] NOT NULL,
	[ErrorProcedure] [varchar](100) NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[ErrorMessage] [varchar](4000) NOT NULL,
	[ErrorLine] [int] NULL,
 CONSTRAINT [PK_CicloVida_LogError] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

CREATE TABLE [Base].[Usuario](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](100) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Apellido] [varchar](100) NOT NULL,
	[Correo] [varchar](100) NOT NULL,
	[CargoId] [int] NOT NULL,
	[RolId] [int] NOT NULL,
	[Estado] [int] NOT NULL,
	[UsuarioCreacion] [varchar](100) NOT NULL,
	[UsuarioModificacion] [varchar](100) NULL,
	[FechaHoraCreacion] [datetime] NOT NULL,
	[FechaHoraModificacion] [datetime] NULL,
 CONSTRAINT [PK_GiftCard_Usuario] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [Base].[Rol](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Descripcion] [varchar](200) NULL,
	[Estado] [int] NOT NULL,
 CONSTRAINT [PK_GiftCard_Rol] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [Base].[Cargo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Descripcion] [varchar](200) NULL,
	[Estado] [int] NOT NULL,
 CONSTRAINT [PK_GiftCard_Cargo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

create table Base.ClienteCorreo
(
Id BIGINT identity(1,1),
Correo varchar(200) ,
UsuarioCreacion varchar(50),
Estado int
)
go


ALTER TABLE [Base].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Cargo] FOREIGN KEY([CargoId])
REFERENCES [Base].[Cargo] ([Id])
GO

ALTER TABLE [Base].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Rol] FOREIGN KEY([RolId])
REFERENCES [Base].[Rol] ([Id])
GO

ALTER TABLE [Base].[Usuario] CHECK CONSTRAINT [FK_Usuario_Cargo]
GO

ALTER TABLE [Base].[Usuario] CHECK CONSTRAINT [FK_Usuario_Rol]
GO
-----------------------------------------------------------------------------------


GO
INSERT INTO [Base].[Cargo] VALUES('Ejecutivo de Multiservicio Retail','',1)
INSERT INTO [Base].[Cargo] VALUES('Supervisor BT','',1)
INSERT INTO [Base].[Cargo] VALUES('Analista Fidelización','',1)
INSERT INTO [Base].[Cargo] VALUES('Gerente de Compras','',1)
INSERT INTO [Base].[Cargo] VALUES('Coordinadora de Fidelización','',1)
INSERT INTO [Base].[Cargo] VALUES('Jefe de Fidelización','',1)
GO
INSERT INTO [Base].[Rol] VALUES('Administrador','',1)
INSERT INTO [Base].[Rol] VALUES('Mantenedor','',1)
INSERT INTO [Base].[Rol] VALUES('Operador','',1)
GO
INSERT INTO [Base].[Usuario] VALUES('RLEONM', 'RIEMANN PERCY', 'LEON MAMANI', 'rleonm@bancofalabella.com.pe',1,3,1,'ADMIN',NULL,GETDATE(),NULL)
INSERT INTO [Base].[Usuario] VALUES('RLEONR', 'LEON ROJAS', 'ROXANA SHIRLEY', 'rleonr@bancofalabella.com.pe',1,3,1,'ADMIN',NULL,GETDATE(),NULL)
INSERT INTO [Base].[Usuario] VALUES('CMENDOZAP', 'MENDOZA PINILLOS', 'CARLOS', 'cmendozap@bancofalabella.com.pe',1,3,1,'ADMIN',NULL,GETDATE(),NULL)
INSERT INTO [Base].[Usuario] VALUES('GPALOMIN', 'PALOMINO PALACIOS', 'GISSELLA AMPARO', 'gpalomin@bancofalabella.com.pe',1,3,1,'ADMIN',NULL,GETDATE(),NULL)

GO
-------------------------------CREACIÓN DE SP-------------------------------
GO

-- =====================================================
-- Author:  JFS
-- Create date: 02/11/2016
-- Description: Listar Usuario por username
-- Test: exec [Base].[UsuarioGetByUsername] @Username = ''
-- =====================================================
CREATE PROCEDURE [Base].[UsuarioGetByUsername]
@Username VARCHAR(100)
AS
BEGIN
SET NOCOUNT ON;
	SELECT 
	U.Id,
	U.Username,
	U.CargoId,
	U.RolId,
	U.Estado,
	R.Nombre as RolNombre
	FROM
	[Base].Usuario U 
	inner join[Base].Rol R on U.RolId= R.Id 
	WHERE
	U.Username = @Username
	AND U.Estado = 1

END
GO


-- =============================================      
-- Author:  JFS      
-- Create date: 02/11/2016     
-- Description: Insertar log
-- Test : [Base].[LogInsert] '','','','','',0
-- =============================================  

CREATE PROCEDURE [Base].[LogInsert]
@Usuario VARCHAR(100),
@Mensaje VARCHAR(4000),
@Controlador VARCHAR(200),
@Accion VARCHAR(100),
@Objeto VARCHAR(4000),
@Identificador INT,
@Response INT OUT
AS
BEGIN
BEGIN TRAN 
BEGIN TRY

INSERT INTO GiftCard.Log(Usuario,Mensaje,Controlador,Accion,FechaRegistro,Objeto,Identificador)
values(@Usuario,@Mensaje,@Controlador,@Accion,GETDATE(),@Objeto,@Identificador)
COMMIT TRAN
SET @Response=(SELECT @@IDENTITY)
select @Response
END TRY 
BEGIN CATCH
  SET @Response = 0;
		INSERT INTO [Base].[LogError]([ErrorNumber], [ErrorSeverity], [ErrorState], [ErrorProcedure], [FechaRegistro], [ErrorMessage], [ErrorLine])
		SELECT ISNULL(ERROR_NUMBER(),0) AS ErrorNumber
		,ISNULL(ERROR_SEVERITY(),0) AS ErrorSeverity
		,ISNULL(ERROR_STATE(),0) AS ErrorState
		,ISNULL(ERROR_PROCEDURE(),0) AS ErrorProcedure
		,GETDATE()		
		,ISNULL(ERROR_MESSAGE(),0) AS ErrorMessage
		,ISNULL(ERROR_LINE(),0) AS ErrorLine;
END CATCH
END
GO


-- =====================================================
-- Author:  JFS
-- Create date: 02/11/2016
-- Description: Listar Cargo
-- Test: EXEC [Base].[CargoGetAllFilter] @WhereFilters = ''
-- =====================================================
CREATE PROCEDURE [Base].[CargoGetAllFilter]
@WhereFilters VARCHAR(MAX) = ''
AS
BEGIN
SET NOCOUNT ON;
    DECLARE @SentenciaSQL nvarchar(MAX)
	SET @SentenciaSQL =  '

	;WITH Consulta AS (
	SELECT
		Id
		,Nombre
		,Descripcion
		,Estado
	FROM GiftCard.Cargo ' + 
	@WhereFilters + 
	') SELECT *
	FROM Consulta '	
	PRINT (@SentenciaSQL);
    EXECUTE sp_executesql  @stmt = @SentenciaSQL

END
GO

-- =============================================      
-- Author:  JFS      
-- Create date: 02/11/2016     
-- Description: Obtener Cargo por Id
-- Test : [Base].[CargoGetById] 1
-- =============================================  
CREATE PROCEDURE [Base].[CargoGetById]
@Id INT
AS
BEGIN

	SET NOCOUNT ON;
	SELECT 
	Id,
	Nombre,
	Descripcion,
	Estado
	FROM [Base].[Cargo]
	WHERE Id = @Id;	
END
GO

-- =====================================================
-- Author:  JFS
-- Create date: 02/11/2016
-- Description: Listar Rol
-- Test: EXEC [Base].[RolGetAllFilter] @WhereFilters = ''
-- =====================================================
CREATE PROCEDURE [Base].[RolGetAllFilter]
@WhereFilters VARCHAR(MAX) = ''
AS
BEGIN
SET NOCOUNT ON;
    DECLARE @SentenciaSQL nvarchar(MAX)
	SET @SentenciaSQL =  '

	;WITH Consulta AS (
	SELECT
		Id
		,Nombre
		,Descripcion
		,Estado
	FROM GiftCard.Rol ' + 
	@WhereFilters + 
	') SELECT *
	FROM Consulta '	
	PRINT (@SentenciaSQL);
    EXECUTE sp_executesql  @stmt = @SentenciaSQL

END
GO

-- =============================================      
-- Author:  JFS      
-- Create date: 02/11/2016     
-- Description: Obtener Rol por Id
-- Test : [Base].[RolGetById] 1
-- =============================================  
CREATE PROCEDURE [Base].[RolGetById]
@Id INT
AS
BEGIN

	SET NOCOUNT ON;
	SELECT 
	Id,
	Nombre,
	Descripcion,
	Estado
	FROM [Base].[Rol]
	WHERE Id = @Id;	
END
GO

-- =====================================================
-- Author:  JFS
-- Create date: 02/11/2016
-- Description: Listar Usuario
-- Test: EXEC [Base].[UsuarioGetAllFilter] @WhereFilters = '', @OrderBy = '', @Rows = 10
-- =====================================================
CREATE PROCEDURE [Base].[UsuarioGetAllFilter]
@WhereFilters VARCHAR(MAX) = '',
@OrderBy VARCHAR (100) = '', 
@Start INT = 0,
@Rows INT = 0
AS
BEGIN
SET NOCOUNT ON;
    DECLARE @SentenciaSQL nvarchar(MAX)
	SET @SentenciaSQL =  '

	;WITH Consulta AS (
	SELECT
		U.Id
		,U.Username
		,U.Nombre
		,U.Apellido
		,U.Correo
		,R.Id RolId
		,R.Nombre RolNombre
		,U.Estado
	FROM GiftCard.Usuario U
	INNER JOIN GiftCard.Rol R ON U.RolId = R.Id ' + 
	@WhereFilters + 
	') SELECT *
	FROM Consulta
	CROSS JOIN (SELECT Count(*) AS Cantidad FROM Consulta) AS CC
	ORDER BY ' +
	CASE WHEN ISNULL(@OrderBy,'') != '' THEN (@OrderBy) 
	ELSE ' ID ASC ' END
	    + ' ' +
	' OFFSET ' + CONVERT(VARCHAR, (@Start)) + 
	' ROWS FETCH NEXT ' + CONVERT(VARCHAR, @Rows) + ' ROWS ONLY'
	PRINT (@SentenciaSQL);
    EXECUTE sp_executesql  @stmt = @SentenciaSQL

END
GO

-- =============================================      
-- Author:  JFS      
-- Create date: 02/11/2016     
-- Description: Obtener Usuario por Id
-- Test : [Base].[UsuarioGetById] 1
-- =============================================  
CREATE PROCEDURE [Base].[UsuarioGetById]
@Id INT
AS
BEGIN

	SET NOCOUNT ON;
	SELECT 
	Id,
	Username,
	Nombre,
	Apellido,
	Correo,
	CargoId,
	RolId,
	Estado
	FROM [Base].[Usuario]
	WHERE Id = @Id;	
END
GO

-- =============================================      
-- Author:  JFS      
-- Create date: 02/11/2016     
-- Description: Insertar Usuario
-- Test : [Base].[UsuarioInsert] 'JFSastillo','Mijail','Castillo','JFSastillo@sigcomt.com',1,1,'ADMIN'
-- =============================================  
create PROCEDURE [Base].[UsuarioInsert]
@Username VARCHAR(100),
@Nombre VARCHAR(100),
@Apellido VARCHAR(100),
@Correo VARCHAR(100),
@CargoId INT,
@RolId INT,
@Estado INT,
@UsuarioCreacion VARCHAR(100),
@Response int out
AS
BEGIN
BEGIN TRAN 
BEGIN TRY
	SET NOCOUNT ON;
	INSERT INTO [Base].[Usuario](Username, Nombre, Apellido, Correo, CargoId,RolId, Estado, UsuarioCreacion, UsuarioModificacion, FechaHoraCreacion, FechaHoraModificacion)
    VALUES(@Username, @Nombre, @Apellido, @Correo,@CargoId, @RolId, @Estado, @UsuarioCreacion, NULL, GETDATE(), NULL);
	--	SELECT @@IDENTITY as Id;
	COMMIT TRAN

	 SET @Response = (SELECT @@IDENTITY);	
	 SELECT @Response
END TRY
BEGIN CATCH 
		SET @Response = 0;

		INSERT INTO [Base].[LogError]([ErrorNumber], [ErrorSeverity], [ErrorState], [ErrorProcedure], [FechaRegistro], [ErrorMessage], [ErrorLine])
		SELECT ISNULL(ERROR_NUMBER(),0) AS ErrorNumber
		,ISNULL(ERROR_SEVERITY(),0) AS ErrorSeverity
		,ISNULL(ERROR_STATE(),0) AS ErrorState
		,ISNULL(ERROR_PROCEDURE(),0) AS ErrorProcedure
		,GETDATE()		
		,ISNULL(ERROR_MESSAGE(),0) AS ErrorMessage
		,ISNULL(ERROR_LINE(),0) AS ErrorLine;
END CATCH
END
GO

-- =============================================      
-- Author:  JFS      
-- Create date: 02/11/2016     
-- Description: Eliminar Usuario
-- Test : [Base].[UsuarioDelete] 1
-- =============================================  
CREATE PROCEDURE [Base].[UsuarioDelete]
@Id INT,
@Response INT OUT
AS
BEGIN
  BEGIN TRAN
  BEGIN TRY


	SET NOCOUNT ON;
	DECLARE @FILASAFECTADA INT = 0;
	IF EXISTS (SELECT Id FROM [Base].[Usuario] WHERE Id = @Id)
	BEGIN
		UPDATE [Base].[Usuario] 
		SET Estado = 0
		WHERE Id = @Id;
	
		SET @FILASAFECTADA = @Id;
	END
	COMMIT TRAN
	SELECT @FILASAFECTADA AS Id;
	set @Response=@FILASAFECTADA
	END TRY
BEGIN CATCH
	ROLLBACK TRAN
	SET @Response=0
	INSERT INTO [Base].[LogError]([ErrorNumber], [ErrorSeverity], [ErrorState], [ErrorProcedure], [FechaRegistro], [ErrorMessage], [ErrorLine])
		SELECT ISNULL(ERROR_NUMBER(),0) AS ErrorNumber
		,ISNULL(ERROR_SEVERITY(),0) AS ErrorSeverity
		,ISNULL(ERROR_STATE(),0) AS ErrorState
		,ISNULL(ERROR_PROCEDURE(),0) AS ErrorProcedure
		,GETDATE()		
		,ISNULL(ERROR_MESSAGE(),0) AS ErrorMessage
		,ISNULL(ERROR_LINE(),0) AS ErrorLine;
	END CATCH
END
GO

-- =============================================      
-- Author:  JFS      
-- Create date: 02/11/2016     
-- Description: Actualizar Usuario
-- Test : [Base].[UsuarioUpdate] 'JFSastillo','Mijail','Castillo','JFSastillo@sigcomt.com',1,1, 1,'ADMIN',3
-- =============================================  
CREATE PROCEDURE [Base].[UsuarioUpdate]
@Username VARCHAR(100),
@Nombre VARCHAR(100),
@Apellido VARCHAR(100),
@Correo VARCHAR(100),
@CargoId INT,
@RolId INT,
@Estado INT,
@UsuarioModificacion VARCHAR(100),
@Id INT,
@Response int out
AS
BEGIN
BEGIN TRAN 
BEGIN TRY
	SET NOCOUNT ON;
	DECLARE @FILASAFECTADA INT = 0;
	IF EXISTS (SELECT Id FROM [Base].[Usuario] WHERE Id = @Id)
	BEGIN
		UPDATE [Base].[Usuario] 
		SET Username = @Username,
		Nombre = @Nombre,
		Apellido = @Apellido,
		Correo = @Correo,
		CargoId =  @CargoId,
		RolId =  @RolId,
		Estado = @Estado,
		UsuarioModificacion = @UsuarioModificacion,
		FechaHoraModificacion = GETDATE()
		WHERE Id = @Id;
		COMMIT TRAN
		SET @FILASAFECTADA = @Id;
	END
	
	SELECT @FILASAFECTADA AS Id;
	SET @Response=@FILASAFECTADA;
	SELECT @Response

	END TRY	

BEGIN CATCH
	SET @Response = 0;

		INSERT INTO [Base].[LogError]([ErrorNumber], [ErrorSeverity], [ErrorState], [ErrorProcedure], [FechaRegistro], [ErrorMessage], [ErrorLine])
		SELECT ISNULL(ERROR_NUMBER(),0) AS ErrorNumber
		,ISNULL(ERROR_SEVERITY(),0) AS ErrorSeverity
		,ISNULL(ERROR_STATE(),0) AS ErrorState
		,ISNULL(ERROR_PROCEDURE(),0) AS ErrorProcedure
		,GETDATE()		
		,ISNULL(ERROR_MESSAGE(),0) AS ErrorMessage
		,ISNULL(ERROR_LINE(),0) AS ErrorLine;
END CATCH

END
GO


-- =============================================      
-- Author:  JFS      
-- Create date: 20/02/2017     
-- Description: Obtener Roles activos
-- Test : [Base].[RolGetAllActives]
-- =============================================  
CREATE PROCEDURE [Base].[RolGetAllActives]
AS
BEGIN

	SET NOCOUNT ON;
	SELECT 
	Id,
	Nombre
	FROM [Base].[Rol]
	WHERE Estado = 1;	
END
GO

-- =====================================================
-- Author:  JFS
-- Create date: 02/11/2016
-- Description: Insertar Envio
-- Test: EXEC [GiftCard].[EnvioInsert]
-- =====================================================
CREATE PROCEDURE [Base].[EnvioEmailInsert]
@Correo varchar(200) ,
@UsuarioCreacion varchar(50),
@Response BIGINT OUT
AS
BEGIN
BEGIN TRAN 
 BEGIN TRY
SET NOCOUNT ON;
DECLARE @FILASAFECTADA BIGINT = 0;
	INSERT INTO [Base].[ClienteCorreo](Correo,UsuarioCreacion,Estado)
	VALUES(@Correo, @UsuarioCreacion, 1);



	COMMIT TRAN 
	SET @FILASAFECTADA=(select @@IDENTITY)
	SET @Response=@FILASAFECTADA
	select @Response
END TRY 
BEGIN CATCH
ROLLBACK TRAN
SET @Response=0;
		INSERT INTO [GiftCard].[LogError]([ErrorNumber], [ErrorSeverity], [ErrorState], [ErrorProcedure], [FechaRegistro], [ErrorMessage], [ErrorLine])
		SELECT ISNULL(ERROR_NUMBER(),0) AS ErrorNumber
		,ISNULL(ERROR_SEVERITY(),0) AS ErrorSeverity
		,ISNULL(ERROR_STATE(),0) AS ErrorState
		,ISNULL(ERROR_PROCEDURE(),0) AS ErrorProcedure
		,GETDATE()		
		,ISNULL(ERROR_MESSAGE(),0) AS ErrorMessage
		,ISNULL(ERROR_LINE(),0) AS ErrorLine;
END CATCH
 
END
GO