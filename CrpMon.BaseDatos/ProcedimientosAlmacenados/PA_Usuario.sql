CREATE PROCEDURE [dbo].[PA_Usuario]
	@pUsuario				VARCHAR(50),
	@pNombres				VARCHAR(50),
	@pApellidos				VARCHAR(50),
	@pCorreo_Electronico	VARCHAR(50),
	@pClave					VARCHAR(100),
	@pUsuario_Padre			VARCHAR(50),
	@pCartera_Criptomoneda	VARCHAR(400)
AS
	IF EXISTS(SELECT * FROM Usuario WHERE Usuario = @pUsuario)
		BEGIN
			RAISERROR ('El nombre de usuario que eligio se encuentra en uso. Por favor cambie su nombre de usuario.', 16, 1);
		END
	ELSE IF NOT EXISTS(SELECT * FROM Usuario WHERE Usuario = @pUsuario_Padre AND Estado = 1)
		BEGIN
			RAISERROR ('El patrocinador con el cual esta registrandose no se encuentra activo.', 16, 1);
		END
	ELSE
		BEGIN
			DECLARE	@vID_Usuario			BIGINT,
					@vID_Usuario_Padre		BIGINT,
					@vID_Usuario_Relacion	BIGINT,
					@vNivel					BIGINT,
					@vEstado				TINYINT	= 2,
					@vBit_Default			BIT		= 0,
					@vEmpresa				INT		= 1,
					@vBit_Default_Padre		BIT;

			SELECT @vID_Usuario = MAX(ID_Usuario)  + 1 FROM Usuario;

			SELECT
				@vID_Usuario_Padre		= dbo.fLast(ID_Usuario,Bit_Default)
				,@vNivel				= ISNULL(Nivel,0) + 1
				,@vID_Usuario_Relacion	= ID_Usuario
			FROM
				Usuario
			WHERE
				Usuario = @pUsuario_Padre;

			select
				@vBit_Default_Padre = Bit_Default
			from
				Usuario
			where
				Usuario = @pUsuario_Padre

			INSERT INTO Usuario(
								[ID_Usuario]
								,[Usuario]
								,[Nombres]
								,[Apellidos]
								,[Correo_Electronico]
								,[Estado]
								,[Fecha_Hora]
								,[M_Fecha_Hora]
								,[Clave]
								,[ID_Usuario_Padre]
								,[Nivel]
								,[Bit_Default]
								,[Empresa]
								,[Bit_Value]
								,[Cartera_Criptomoneda]
								,[ID_Usuario_Relacion])
			select
					@vID_Usuario				as [ID_Usuario]
					,@pUsuario					as [Usuario]
					,@pNombres					as [Nombres]
					,@pApellidos				as [Apellidos]
					,@pCorreo_Electronico		as [Correo_Electronico]
					,@vEstado					as [Estado]
					,GETDATE()					as [Fecha_Hora]
					,null						as [M_Fecha_Hora]
					,ENCRYPTBYPASSPHRASE('Pa55K3y',@pClave)	as [Clave]
					,@vID_Usuario_Padre			as [ID_Usuario_Padre]
					,@vNivel					as [Nivel]
					,@vBit_Default				as [Bit_Default]
					,@vEmpresa					as [Empresa]
					,@vBit_Default_Padre		as [Bit_Value]
					,@pCartera_Criptomoneda		as [Cartera_Criptomoneda]
					,@vID_Usuario_Relacion		as [ID_Usuario_Relacion]
					--);
		END
	
	