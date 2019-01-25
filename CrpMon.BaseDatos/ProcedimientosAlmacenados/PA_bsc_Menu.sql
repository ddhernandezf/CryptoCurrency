CREATE PROCEDURE [dbo].[PA_bsc_Menu]
	@Idioma	TINYINT
AS
	SELECT	m.Menu, mt.Descripcion, m.Accion, m.Controlador, m.imagen[imageUrl]
	  FROM	Menu m INNER JOIN MenuTraduccion mt ON m.Menu = mt.Menu
	 WHERE	mt.Idioma = @Idioma;