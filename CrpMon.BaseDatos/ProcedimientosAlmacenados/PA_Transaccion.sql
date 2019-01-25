CREATE PROCEDURE [dbo].[PA_Transaccion]
	@pTransaccion_Monedero	VARCHAR(200),
	@pMonedero				INT,
	@pObservacion_1			VARBINARY(100),
	@pUsuario				VARCHAR(50),
	@pjsonResult			VARCHAR(800),
	@pProducto				INT,
	@pAmount				VARCHAR(200),
	@pTimeOut				INT,
	@pStatus_Url			VARCHAR(200),
	@pQrcode_Url			VARCHAR(200),
	@pAddress				VARCHAR(400)
AS
	DECLARE @vID_Usuario	BIGINT = (SELECT ID_Usuario FROM Usuario WHERE Usuario = @pUsuario),
			@Counter		BIGINT,
			@Now			DATETIME = (GETDATE());

	INSERT INTO [dbo].[Transaccion] ([Transaccion_Monedero], [Monedero], [Observacion_1], [ID_Usuario], [Monedero_jsonResult], [Fecha_Hora], [Producto], 
									 [Estado], [Fecha_Ini], [Fecha_Fin], [Monedero_Amount], [Monedero_TimeOut], [Monedero_Status_Url], [Monedero_Qrcode_Url],
									 [Monedero_Address])
	VALUES (@pTransaccion_Monedero ,@pMonedero, @pObservacion_1, @vID_Usuario, @pjsonResult, @Now, @pProducto, 3, @Now, 
			DATEADD(ss, @pTimeOut, @Now), @pAmount, @pTimeOut,
			@pStatus_Url,@pQrcode_Url,@pAddress);

	DECLARE @ConsecutivoInterno	BIGINT = @@IDENTITY;

	SELECT	@Counter = COUNT(*)
	  FROM	Transaccion
	 WHERE	ID_Usuario = @vID_Usuario;

	IF(@Counter = 1)
		BEGIN
			UPDATE	Usuario
			   SET	Estado = 3
			 WHERE	ID_Usuario = @vID_Usuario;
		END

	SELECT	Consecutivo_Interno, Transaccion_Monedero, Monedero, Observacion_1, ID_Usuario, Monedero_jsonResult, Fecha_Hora, Producto, Estado, Fecha_Ini, 
			Fecha_Fin, 
			Replace(convert(varchar(max),CAST(Monedero_Amount AS numeric(18,2)),0),'.00','')[Monedero_Amount], 
			Monedero_TimeOut, Monedero_Status_Url, Monedero_Qrcode_Url, Monedero_Address
	  FROM	Transaccion
	 WHERE	Consecutivo_Interno = @ConsecutivoInterno;

