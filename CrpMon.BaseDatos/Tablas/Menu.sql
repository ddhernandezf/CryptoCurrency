CREATE TABLE [dbo].[Menu]
(
	[Menu]			TINYINT NOT NULL IDENTITY,
	[Descripcion]	VARCHAR(50) NOT NULL,
	[Accion]		VARCHAR(50) NOT NULL,
	[Controlador]	VARCHAR(50) NOT NULL,
	[imagen]		VARCHAR(50) NOT NULL,
	CONSTRAINT pkMenu PRIMARY KEY([Menu]),
	CONSTRAINT uqMenu UNIQUE([Descripcion])
)
