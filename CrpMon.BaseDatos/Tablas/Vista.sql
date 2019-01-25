CREATE TABLE [dbo].[Vista]
(
	[Vista]			TINYINT NOT NULL IDENTITY,
	[Idioma]		TINYINT NOT NULL,
	[Nombre]		VARCHAR(50) NOT NULL,
	[ObjetoJson]	VARCHAR(MAX) NOT NULL,
	CONSTRAINT pkVista PRIMARY KEY([Vista]),
	CONSTRAINT uqVista UNIQUE([Idioma], [Nombre]),
	CONSTRAINT fkVistaIdioma FOREIGN KEY ([Idioma]) REFERENCES [Idioma]([Idioma])
)
