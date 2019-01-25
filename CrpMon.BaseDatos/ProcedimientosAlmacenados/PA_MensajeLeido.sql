CREATE PROCEDURE [dbo].[PA_MensajeLeido]
	@pMensaje	BIGINT
AS
	UPDATE	Mensaje
	   SET	Estado = 7
	 WHERE	Mensaje = @pMensaje;