CREATE PROCEDURE [dbo].[PA_bsc_Porcentajes]
	@pUsuario	VARCHAR(50),
	@pIdioma	TINYINT
AS
	DECLARE @TempResult TABLE(
		[Activo] BIT,
		[Titulo] VARCHAR(30),
		[Porcentaje] DECIMAL
	)
	
	INSERT INTO @TempResult(Activo, Titulo, Porcentaje) VALUES(1, 'Moneda Física', 50);
	INSERT INTO @TempResult(Activo, Titulo, Porcentaje) VALUES(1, 'Criptomoneda', 60);
	INSERT INTO @TempResult(Activo, Titulo, Porcentaje) VALUES(1, 'Margen arancelario', 70);

	SELECT	Activo, Titulo, Porcentaje
	  FROM	@TempResult;