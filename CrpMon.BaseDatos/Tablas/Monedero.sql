CREATE TABLE [dbo].[Monedero]
(
	[Monedero]	INT NOT NULL,
	[Nombre]	VARCHAR(50) NOT NULL,
	CONSTRAINT pkMonedero PRIMARY KEY([Monedero]),
	CONSTRAINT uqMonedero UNIQUE([Nombre])
)
