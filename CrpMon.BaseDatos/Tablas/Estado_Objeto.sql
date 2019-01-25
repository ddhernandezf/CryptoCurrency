CREATE TABLE [dbo].[Estado_Objeto]
(
	[Estado_Objeto]	TINYINT NOT NULL,
	[Descripcion]	VARCHAR(50) NOT NULL,
	CONSTRAINT pkEstadoObjeto PRIMARY KEY([Estado_Objeto]),
	CONSTRAINT uqEstadoObjeto UNIQUE([Descripcion])
)
