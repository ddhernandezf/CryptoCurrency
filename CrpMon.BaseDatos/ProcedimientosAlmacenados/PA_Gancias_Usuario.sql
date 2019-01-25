CREATE PROCEDURE [dbo].[PA_Gancias_Usuario]
	@pUsuario varchar(50)
AS
	DECLARE @TempResult TABLE(
		[GananciaIzquierda] VARCHAR(20),
		[GananciaDerecha] VARCHAR(20),
		[GananciaTotal] VARCHAR(20)
	)

	insert into @TempResult
	select
		Cast(Cast([dbo].[fMonedero_Amount](ID_Usuario,0,2) as numeric(18,4)) as varchar(max)) + ' ETH'
		,Cast(Cast([dbo].[fMonedero_Amount](ID_Usuario,1,2) as numeric(18,4)) as varchar(max)) + ' ETH'
		,Cast(Cast([dbo].[fMonedero_Amount](ID_Usuario,0,2)
		+[dbo].[fMonedero_Amount](ID_Usuario,1,2) as numeric(18,4)) as varchar(max)) + ' ETH'
	from
		Usuario
	where
		Usuario = @pUsuario

	SELECT
		GananciaIzquierda
		,GananciaDerecha
		,GananciaTotal
	FROM
		@TempResult
