CREATE TABLE [dbo].[Notificacion]
(
	[IdNotificacion] INT IDENTITY(1,1) NOT NULL,
	[Estado]		TINYINT NOT NULL,
	[Titulo]		VARCHAR(200) NOT NULL,
	[Imagen]		VARCHAR(50) NULL,
	[Contenido]		VARCHAR(2000) NOT NULL,
	[FechaInicio]	DATETIME NOT NULL,
	[FechaFin]		DATETIME NOT NULL,
	CONSTRAINT pkNotificacion PRIMARY KEY([IdNotificacion]),
	CONSTRAINT fkNotificacionEstado FOREIGN KEY ([Estado]) REFERENCES [Estado_Objeto]([Estado_Objeto]),
)
