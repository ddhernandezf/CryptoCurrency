CREATE PROCEDURE [dbo].[PA_Usuario_Auth]
	@pUsuario	VARCHAR(50),
	@pClave		VARCHAR(100)
AS
	SELECT	u.ID_Usuario, u.Usuario, u.Nombres, u.Apellidos, u.Correo_Electronico, u.Cartera_Criptomoneda,
			u.Nivel, u.Bit_Default, e.Descripcion[Des_Estado],
			u.ID_Usuario_Padre, p.Usuario[Patrocinador]
	  FROM	Usuario u INNER JOIN Estado_Objeto e ON u.Estado = e.Estado_Objeto
					  LEFT OUTER JOIN Usuario p ON u.ID_Usuario_Padre = p.ID_Usuario
	 WHERE	u.Usuario = @pUsuario
	   AND	CONVERT(VARCHAR(50),DECRYPTBYPASSPHRASE('Pa55K3y',u.Clave)) = @pClave;