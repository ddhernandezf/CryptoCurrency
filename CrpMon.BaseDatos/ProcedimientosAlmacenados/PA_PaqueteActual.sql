CREATE PROCEDURE [dbo].[PA_PaqueteActual]
	@pUsuario	VARCHAR(50),
	@Idioma		TINYINT
AS
	SELECT	TOP 1 p.Producto, pt.[Descripcion], CAST([Monto] AS numeric(18,2))[Monto],
				CONCAT(Replace(convert(varchar(max),CAST([Monto] AS numeric(18,2)),0),'.00',''),' ', pt.Mensaje_Monto) [Mensaje_Monto],
				CAST([Cantidad_Binario] AS INT)[Cantidad_Binario] ,CONCAT(CAST([Cantidad_Binario] AS INT),' ', pt.Mensaje_Binario)[Mensaje_Binario],
				CAST([Cantidad_Alerta] AS INT)[Cantidad_Alerta], CONCAT(CAST([Cantidad_Alerta] AS INT),' ', pt.Mensaje_Alerta)[Mensaje_Alerta],
				Periodo_Dia, CONCAT(CAST([Periodo_Dia] AS INT),' ', pt.Mensaje_Dia)[Mensaje_Dia], Img_Url, CAST([Out_Max] AS numeric(18,0))[Out_Max],
				CONCAT(CAST([Out_Max] AS INT),' ', pt.Mensaje_OutMax)[Mensaje_OutMax]
	  FROM	Transaccion t INNER JOIN Usuario u ON t.ID_Usuario = u.ID_Usuario
						  INNER JOIN Producto p ON p.Producto = t.Producto
						  INNER JOIN ProductoTraduccion pt ON p.Producto = pt.Producto
	 WHERE	u.Usuario = @pUsuario
	   AND	t.Estado = 1
	   AND	pt.Idioma= @Idioma
	 ORDER	BY t.Fecha_Hora DESC