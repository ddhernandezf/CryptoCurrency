CREATE TABLE [dbo].[Mensaje]
(
	[Mensaje]		BIGINT NOT NULL IDENTITY,
	[Estado]		TINYINT NOT NULL,
	[Usuario]		BIGINT NOT NULL,
	[Asunto]		VARCHAR(100) NOT NULL,
	[Contenido]		VARCHAR(MAX) NOT NULL,
	[FechaEmision]	DATETIME NOT NULL,
	[FechaLectura]	DATETIME NULL,
	CONSTRAINT pkMensaje PRIMARY KEY([Mensaje]),
	CONSTRAINT fkMensajeEstado FOREIGN KEY ([Estado]) REFERENCES [Estado_Objeto]([Estado_Objeto]),
	CONSTRAINT fkMensajeUsuario FOREIGN KEY ([Usuario]) REFERENCES [Usuario]([ID_Usuario])
)
