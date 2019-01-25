CREATE PROCEDURE [dbo].[PA_bsc_Idioma]
	@Idioma	TINYINT
AS
	SELECT	i.Idioma, it.Descripcion, i.Imagen
	  FROM	Idioma i INNER JOIN IdiomaTraduccion it ON i.Idioma = it.Idioma
	 WHERE	it.IdiomaTraduccion = @Idioma;