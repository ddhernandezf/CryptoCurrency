CREATE TABLE [dbo].[IdiomaTraduccion]
(
	[Traduccion]		TINYINT NOT NULL IDENTITY,
	[Idioma]			TINYINT NOT NULL,
	[IdiomaTraduccion]	TINYINT NOT NULL,
	[Descripcion]		VARCHAR(50) NOT NULL,
	CONSTRAINT pkIdiomaTraduccion PRIMARY KEY([Traduccion]),
	CONSTRAINT uqIdiomaTraduccion UNIQUE([Idioma], [IdiomaTraduccion]),
	CONSTRAINT fkIdiomaTraduccionIdioma FOREIGN KEY ([Idioma]) REFERENCES [Idioma]([Idioma]),
	CONSTRAINT fkIdiomaTraduccionTraduccion FOREIGN KEY ([IdiomaTraduccion]) REFERENCES [Idioma]([Idioma])
)
