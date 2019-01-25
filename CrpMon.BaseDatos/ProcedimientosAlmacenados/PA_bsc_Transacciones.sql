CREATE PROCEDURE [dbo].[PA_bsc_Transacciones]
	@Usuario	VARCHAR(50)
AS
	SELECT	t.Consecutivo_Interno, t.Transaccion_Monedero, t.Monedero, t.Observacion_1, t.ID_Usuario,
			t.Monedero_jsonResult, t.Fecha_Hora, t.Producto, t.Estado, t.Fecha_Ini, t.Fecha_Fin, 
			Replace(convert(varchar(max),CAST(t.Monedero_Amount AS numeric(18,2)),0),'.00','')[Monedero_Amount],
			t.Monedero_TimeOut, t.Monedero_Status_Url, t.Monedero_Qrcode_Url, t.Monedero_Address, e.Descripcion[NombreEstado],
			p.Descripcion[NombreProducto], p.Img_Url[ProductoImagen]
	  FROM	Transaccion t INNER JOIN Usuario u ON t.ID_Usuario = u.ID_Usuario
						  INNER JOIN Estado_Objeto e ON e.Estado_Objeto = t.Estado
						  INNER JOIN Producto p ON p.Producto = t.Producto
						  INNER JOIN Clase_Producto cp ON p.Clase_Producto = cp.Clase_Producto
	 WHERE	U.Usuario = @Usuario
	 ORDER	BY T.Fecha_Hora DESC;