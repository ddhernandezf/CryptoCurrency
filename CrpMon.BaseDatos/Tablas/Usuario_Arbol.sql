CREATE TABLE [dbo].[Usuario_Arbol](
	[Consecutivo_Interno] [bigint] IDENTITY(1,1) NOT NULL,
	[ID_Usuario] [bigint] NULL,
	[ID_Usuario_Padre] [bigint] NULL,
	[Bit_Value] [bit] NULL,
	[Nivel] [bigint] NULL,
	[Fecha_Hora] [datetime] NULL,
	[M_Fecha_Hora] [datetime] NULL
) ON [PRIMARY]