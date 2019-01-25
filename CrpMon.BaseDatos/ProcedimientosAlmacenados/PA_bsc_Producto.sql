CREATE PROCEDURE [dbo].[PA_bsc_Producto]
	@Idioma	TINYINT
AS
	SELECT	p.[Producto], pt.[Descripcion], CAST(p.[Monto] AS numeric(18,2))[Monto],
			CONCAT(Replace(convert(varchar(max),CAST(p.[Monto] AS numeric(18,2)),0),'.00',''),' ', pt.Mensaje_Monto) [Mensaje_Monto],
			CAST(p.[Cantidad_Binario] AS INT)[Cantidad_Binario] ,
			CONCAT(CAST(p.[Cantidad_Binario] AS INT),' ', pt.Mensaje_Binario)[Mensaje_Binario],
			CAST(p.[Cantidad_Alerta] AS INT)[Cantidad_Alerta], 
			CONCAT(CAST(p.[Cantidad_Alerta] AS INT),' ', pt.Mensaje_Alerta)[Mensaje_Alerta],
			Periodo_Dia, CONCAT(CAST(p.[Periodo_Dia] AS INT),' ', pt.Mensaje_Dia)[Mensaje_Dia], 
			Img_Url, CAST(p.[Out_Max] AS numeric(18,0))[Out_Max],
			CONCAT(CAST(p.[Out_Max] AS INT),' ', pt.Mensaje_OutMax)[Mensaje_OutMax]														
	 FROM	Producto p INNER JOIN ProductoTraduccion pt ON p.Producto = pt.Producto
	WHERE	Clase_Producto = 2
	  AND	pt.Idioma= @Idioma