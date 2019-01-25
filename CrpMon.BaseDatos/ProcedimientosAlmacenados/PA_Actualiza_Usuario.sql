CREATE PROCEDURE [dbo].[PA_Actualiza_Usuario]
	@pUsuario				VARCHAR(50),
	@pClave					VARCHAR(100),
	@Nombres				VARCHAR(50),
	@Apellidos				VARCHAR(50),
	@Correo_Electronico		VARCHAR(50),
	@Cartera_Criptomoneda	VARCHAR(400)
AS
	IF EXISTS (	SELECT	*
				  FROM	Usuario
				 WHERE	Usuario = @pUsuario
				   AND	CONVERT(VARCHAR(50),DECRYPTBYPASSPHRASE('Pa55K3y',Clave)) = @pClave)
		BEGIN
			UPDATE	Usuario
			   SET	Nombres = @Nombres,
					Apellidos = @Apellidos,
					Correo_Electronico = @Correo_Electronico,
					Cartera_Criptomoneda = @Cartera_Criptomoneda
			 WHERE	Usuario = @pUsuario
				   AND	CONVERT(VARCHAR(50),DECRYPTBYPASSPHRASE('Pa55K3y',Clave)) = @pClave;
		END
	ELSE
		BEGIN
			RAISERROR ('Credenciales incorrectas', 16, 1);
		END