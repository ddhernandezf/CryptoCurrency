update Producto
   set	Mensaje_Binario = '%',
		Mensaje_Monto = 'ETH',
		Mensaje_Alerta = 'Alertas',
		Mensaje_Dia = 'Dias',
		Mensaje_OutMax = 'Maximo Día';

INSERT INTO Estado_Objeto(Estado_Objeto, Descripcion) VALUES(5, 'Inactivo');

DROP PROCEDURE PA_bsc_Producto_1;