CREATE TABLE [dbo].[Clase_Producto]
(
	[Clase_Producto]	INT NOT NULL,
	[Descripcion]		VARCHAR(50) NOT NULL,
	CONSTRAINT pkClaseProducto PRIMARY KEY([Clase_Producto]),
	CONSTRAINT uqClaseProducto UNIQUE([Descripcion])
)
