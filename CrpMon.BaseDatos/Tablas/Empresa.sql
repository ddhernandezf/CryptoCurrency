CREATE TABLE [dbo].[Empresa]
(
	[Empresa]				INT NOT NULL,
	[Nombre]				VARCHAR(50) NOT NULL,
	[Llave_Privada]			VARCHAR(100) NULL,
	[Llave_Publica]			VARCHAR(100) NULL,
	[Correo_Electronico]	VARCHAR(50) NULL,
	[Estado]				TINYINT NOT NULL DEFAULT 1,
	CONSTRAINT pkEmpresa PRIMARY KEY([Empresa])
)
