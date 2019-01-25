CREATE TABLE [dbo].[Idioma]
(
	[Idioma]		TINYINT NOT NULL IDENTITY,
	[Descripcion]	VARCHAR(50) NOT NULL,
	[Imagen]		VARCHAR(50) NOT NULL,
	CONSTRAINT pkIdioma PRIMARY KEY([Idioma]),
	CONSTRAINT uqIdioma UNIQUE([Descripcion])
)
