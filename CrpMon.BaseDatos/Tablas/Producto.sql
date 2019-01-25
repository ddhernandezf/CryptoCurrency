CREATE TABLE [dbo].[Producto]
(
	[Producto]			INT NOT NULL,
	[Descripcion]		VARCHAR(50) NOT NULL,
	[Observacion]		VARCHAR(200) NULL,
	[Monto]				NUMERIC(18, 10) NULL,
	[Mensaje_Monto]		VARCHAR(100) NULL,
	[Clase_Producto]	INT NOT NULL,
	[Img_Url]			VARCHAR(100) NULL,
	[Cantidad_Binario]	NUMERIC(18, 9) NULL,
	[Mensaje_Binario]	VARCHAR(100) NULL,
	[Cantidad_Alerta]	NUMERIC(18, 9) NULL,
	[Mensaje_Alerta]	VARCHAR(100) NULL,
	[Periodo_Dia]		INT NULL,
	[Mensaje_Dia]		VARCHAR(100) NULL,
	[Out_Max]			NUMERIC(18, 9) NULL,
	[Mensaje_OutMax]	VARCHAR(100) NULL,
	CONSTRAINT pkProducto PRIMARY KEY([Producto]),
	CONSTRAINT uqProducto UNIQUE([Producto], [Descripcion]),
	CONSTRAINT fkProductoClaseProducto FOREIGN KEY ([Clase_Producto]) REFERENCES [Clase_Producto]([Clase_Producto])
)
