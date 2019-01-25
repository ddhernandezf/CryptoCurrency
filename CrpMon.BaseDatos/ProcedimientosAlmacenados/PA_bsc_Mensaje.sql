CREATE PROCEDURE [dbo].[PA_bsc_Mensaje]
	@pEstado	TINYINT,
	@pUsuario	TINYINT
AS
	SELECT	*
	  FROM	Mensaje m INNER JOIN Estado_Objeto e ON m.Estado = e.Estado_Objeto
	 WHERE	m.Usuario = @pUsuario
	   AND	m.Estado LIKE CONCAT('%', @pUsuario, '%')