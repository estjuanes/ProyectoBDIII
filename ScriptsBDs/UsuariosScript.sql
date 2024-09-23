
CREATE DATABASE [InfoToolsSV]
GO
USE [InfoToolsSV]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
    [id] [int] IDENTITY(1000,1) NOT NULL,
      NULL,
      NULL,
      NULL -- Columna para el rol del usuario
) ON [PRIMARY]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AgregarUsuario]
    @Usuario varchar(50),
    @Contrasenia varchar(50),
    @Patron varchar(50),
    @Rol varchar(50) -- Parámetro para el rol
AS
BEGIN
    INSERT INTO Usuarios(Usuario, Contrasenia, Rol) 
    VALUES (@Usuario, ENCRYPTBYPASSPHRASE(@Patron, @Contrasenia), @Rol)
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ValidarUsuarioConRol]
    @Usuario varchar(50),
    @Contrasenia varchar(50),
    @Patron varchar(50)
AS
BEGIN
    SELECT Usuario, Rol 
    FROM Usuarios 
    WHERE Usuario = @Usuario 
    AND CONVERT(varchar(50), DECRYPTBYPASSPHRASE(@Patron, Contrasenia)) = @Contrasenia;
END
GO

USE [master]
GO
ALTER DATABASE [InfoToolsSV] SET READ_WRITE 
GO

EXEC SP_AgregarUsuario 'admin', 'contrasenia1234', 'patron', 'admin';
EXEC SP_AgregarUsuario 'gerente', 'contrasenia1234', 'patron', 'gerente';
EXEC SP_AgregarUsuario 'analista', 'contrasenia1234', 'patron', 'analista';