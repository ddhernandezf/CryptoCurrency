CREATE PROCEDURE [dbo].[PA_Actualiza_Password]
	@pUsuario		VARCHAR(50),
	@pClave			VARCHAR(100),
	@pClaveNueva	VARCHAR(100)
AS
	IF EXISTS (	SELECT	*
				  FROM	Usuario
				 WHERE	Usuario = @pUsuario
				   AND	CONVERT(VARCHAR(100),DECRYPTBYPASSPHRASE('Pa55K3y',Clave)) = @pClave)
		BEGIN
			UPDATE	Usuario
			   SET	Clave = ENCRYPTBYPASSPHRASE('Pa55K3y',@pClaveNueva)
			 WHERE	Usuario = @pUsuario
				   AND	CONVERT(VARCHAR(100),DECRYPTBYPASSPHRASE('Pa55K3y',Clave)) = @pClave;
		END
	ELSE
		BEGIN
			RAISERROR ('Credenciales incorrectas', 16, 1);
		END