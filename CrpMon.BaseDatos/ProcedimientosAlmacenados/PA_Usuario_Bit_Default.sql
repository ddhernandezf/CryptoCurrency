CREATE PROCEDURE [dbo].[PA_Usuario_Bit_Default]
	@pUsuario		VARCHAR(50),
	@pBit_Default	BIT
AS
	UPDATE	Usuario
	   SET	Bit_Default = @pBit_Default
	 WHERE	Usuario = @pUsuario;
