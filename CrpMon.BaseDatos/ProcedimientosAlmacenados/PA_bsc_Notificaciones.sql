CREATE PROCEDURE [dbo].[PA_bsc_Notificaciones]
AS
	UPDATE	Notificacion
	   SET	Estado = 5
	 WHERE	FechaFin < GETDATE()
	   AND	Estado = 1;

	SELECT	n.IdNotificacion, n.Estado, e.Descripcion[NombreEstado], n.Titulo, n.Contenido, n.FechaInicio, n.FechaFin
	  FROM	Notificacion n INNER JOIN Estado_Objeto e ON n.Estado = e.Estado_Objeto
	 WHERE	Estado = 1;