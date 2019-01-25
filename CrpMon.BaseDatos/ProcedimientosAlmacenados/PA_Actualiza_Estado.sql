CREATE PROCEDURE [dbo].[PA_Actualiza_Estado]
	@pUsuario					VARCHAR(50),
	@pID_Transaccion_Monedero	VARCHAR(400)
AS
	DECLARE @vID_Usuario bigint

	select 
		@vID_Usuario = ID_Usuario
	from Usuario 
	where Usuario = @pUsuario

	UPDATE T2
	set T2.Estado = 1
	from	Transaccion T1
		join
			Usuario		T2
		ON T1.ID_Usuario = T2.ID_Usuario	
	where T1.ID_Usuario			= @vID_Usuario
	and T1.Estado				= 1
	and Transaccion_Monedero	= @pID_Transaccion_Monedero

	UPDATE Transaccion
	SET Estado = 1
	where ID_Usuario			= @vID_Usuario
	and Transaccion_Monedero	= @pID_Transaccion_Monedero

	EXEC [dbo].[PA_Ins_Usuario_Arbol] @pUsuario