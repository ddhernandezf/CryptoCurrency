CREATE TABLE [dbo].[Transaccion]
(
	[Consecutivo_Interno]	BIGINT IDENTITY(1,1) NOT NULL,
	[Transaccion_Monedero]	VARCHAR(200) NOT NULL,
	[Monedero]				INT NOT NULL,
	[Observacion_1]			VARBINARY(100) NULL,
	[ID_Usuario]			BIGINT NOT NULL,
	[Monedero_jsonResult]	VARCHAR(800) NULL,
	[Fecha_Hora]			DATETIME NOT NULL,
	[Producto]				INT NOT NULL,
	[Estado]				TINYINT NOT NULL,	
	[Fecha_Ini]				DATETIME NULL,
	[Fecha_Fin]				DATETIME NULL,
	[Monedero_Amount]		VARCHAR(200) NULL,
	[Monedero_TimeOut]		INT NULL,
	[Monedero_Status_Url]	VARCHAR(200) NULL,
	[Monedero_Qrcode_Url]	VARCHAR(200) NULL,
	[Monedero_Address]		VARCHAR(400) NULL,
	CONSTRAINT pkTransaccion PRIMARY KEY([Transaccion_Monedero]),
	CONSTRAINT fkTransaccionEstado FOREIGN KEY ([Estado]) REFERENCES [Estado_Objeto]([Estado_Objeto]),
	CONSTRAINT fkTransaccionMonedero FOREIGN KEY ([Monedero]) REFERENCES [Monedero]([Monedero]),
	CONSTRAINT fkTransaccionProducto FOREIGN KEY ([Producto]) REFERENCES [Producto]([Producto]),
	CONSTRAINT fkTransaccionUsuario FOREIGN KEY ([ID_Usuario]) REFERENCES [Usuario]([ID_Usuario])
)
