CREATE TABLE [dbo].[ProductoTraduccion]
(
	[Traduccion]		TINYINT NOT NULL IDENTITY,
	[Producto]			INT NOT NULL,
	[Idioma]			TINYINT NOT NULL,
	[Descripcion]		VARCHAR(50) NOT NULL,
	[Mensaje_Monto]		VARCHAR(100) NULL,
	[Mensaje_Binario]	VARCHAR(100) NULL,
	[Mensaje_Alerta]	VARCHAR(100) NULL,
	[Mensaje_Dia]		VARCHAR(100) NULL,
	[Mensaje_OutMax]	VARCHAR(100) NULL,
	CONSTRAINT pkProductoTraduccion PRIMARY KEY([Traduccion]),
	CONSTRAINT uqProductoTraduccion UNIQUE([Producto], [Idioma]),
	CONSTRAINT fkProductoTraduccionProducto FOREIGN KEY ([Producto]) REFERENCES [Producto]([Producto]),
	CONSTRAINT fkProductoTraduccionIdioma FOREIGN KEY ([Idioma]) REFERENCES [Menu]([Menu])
)
