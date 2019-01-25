CREATE TABLE [dbo].[MenuTraduccion]
(
	[Traduccion]	TINYINT NOT NULL IDENTITY,
	[Menu]			TINYINT NOT NULL,
	[Idioma]		TINYINT NOT NULL,
	[Descripcion]	VARCHAR(50) NOT NULL,
	CONSTRAINT pkMenuTraduccion PRIMARY KEY([Traduccion]),
	CONSTRAINT uqMenuTraduccion UNIQUE([Menu], [Idioma]),
	CONSTRAINT fkMenuTraduccionMenu FOREIGN KEY ([Menu]) REFERENCES [Menu]([Menu]),
	CONSTRAINT fkMenuTraduccionIdioma FOREIGN KEY ([Idioma]) REFERENCES [Idioma]([Idioma])
)
