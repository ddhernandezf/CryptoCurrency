CREATE PROCEDURE [dbo].[PA_bsc_Transaccion_1_Usuario]
	@pUsuario VARCHAR(50)
AS
	DECLARE @vID_Usuario bigint = (select ID_Usuario from Usuario where Usuario = @pUsuario);

	select	TOP 1 Consecutivo_Interno, Transaccion_Monedero, Monedero, Observacion_1, ID_Usuario,
			Monedero_jsonResult, Fecha_Hora, Producto, Estado, Fecha_Ini, Fecha_Fin, 
			Replace(convert(varchar(max),CAST(Monedero_Amount AS numeric(18,2)),0),'.00','')[Monedero_Amount],
			Monedero_TimeOut, Monedero_Status_Url, Monedero_Qrcode_Url, Monedero_Address
	from Transaccion 
	where ID_Usuario	= @vID_Usuario
	and Estado			= 3
	order by Consecutivo_Interno;