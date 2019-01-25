CREATE PROCEDURE [dbo].[PA_bsc_Vista]
	@pVista		VARCHAR(50),
	@pIdioma	TINYINT
AS
	SELECT	v.Vista, v.Nombre, v.Idioma, i.Descripcion[NombreIdioma], v.ObjetoJson
	  FROM	Vista v INNER JOIN Idioma i ON v.Idioma = i.Idioma
	 WHERE	v.Nombre = @pVista
	   AND	v.Idioma = @pIdioma