CREATE TABLE [dbo].[Usuario]
(
	[ID_Usuario]			BIGINT NOT NULL,
	[Usuario]				VARCHAR(50) NOT NULL,
	[Nombres]				VARCHAR(50) NOT NULL,
	[Apellidos]				VARCHAR(50) NOT NULL,
	[Correo_Electronico]	VARCHAR(50) NOT NULL,
	[Estado]				TINYINT NOT NULL,
	[Fecha_Hora]			DATETIME NOT NULL,
	[M_Fecha_Hora]			DATETIME NULL,
	[Clave]					VARBINARY(128) NOT NULL,
	[ID_Usuario_Padre]		BIGINT NULL,
	[Nivel]					BIGINT NOT NULL,
	[Bit_Default]			BIT NOT NULL,
	[Empresa]				INT NOT NULL DEFAULT 1,
	[Bit_Value]				BIT NOT NULL DEFAULT 1,
	[Cartera_Criptomoneda]	VARCHAR(400) NULL,
	[ID_Usuario_Relacion]	BIGINT NULL,
	CONSTRAINT pkUsuario PRIMARY KEY([ID_Usuario]),
	CONSTRAINT uqUsuario UNIQUE([Usuario]),
	CONSTRAINT fkPersonaEmpresa FOREIGN KEY ([Empresa]) REFERENCES [Empresa]([Empresa]),
	CONSTRAINT fkPersonaEstado FOREIGN KEY ([Estado]) REFERENCES [Estado_Objeto]([Estado_Objeto]),
	CONSTRAINT fkPersonaPatrocinador FOREIGN KEY ([ID_Usuario_Padre]) REFERENCES [Usuario]([ID_Usuario])
)
