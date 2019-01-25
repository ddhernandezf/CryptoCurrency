CREATE FUNCTION [dbo].[fMonedero_Amount]
(
	@ID_Usuario int,
	@Bit_Value bit,
	@Opcion int
)
RETURNS numeric(18,9)
AS
BEGIN
	declare
			@Exec_Time	datetime = getdate()
			,@Id		int
			,@Resultado	numeric(18,9)
		----------------------------------------------------------------------------------------------------------
		--@Opcion = 1	->Monto del dia por rama
		--@Opcion = 2	->Monto acumulado por rama
		--@Opcion = 3	->Monto directo acumulado
		----------------------------------------------------------------------------------------------------------
		select
			@Id	= b.ID_Usuario
		from
			Usuario_Arbol	as a	join
			Usuario_Arbol	as b	on	a.ID_Usuario = b.ID_Usuario_Padre
		where
			b.Bit_Value			= @Bit_Value
			and a.ID_Usuario	= @ID_Usuario
		----------------------------------------------------------------------------------------------------------
		if @Opcion in (1,2)
			begin
				;WITH [Tabla] (Id, Id_Padre, Nivel, Bit_Value)
				as (
					select 
						ID_Usuario
						,ID_Usuario_Padre
						,1
						,Bit_Value
					from 
						usuario_arbol
					where
						ID_Usuario = @Id

					union ALL

					select 
						a.ID_Usuario
						,a.ID_Usuario_Padre
						,b.Nivel + 1
						,a.Bit_Value
					from 
						usuario_arbol	as a	JOIN 
						[Tabla]			as b	ON a.ID_Usuario_Padre = b.Id)
				----------------------------------------------------------------------------------------------------------
				select
					@Resultado = Sum(Monedero_Amount)
				from
					(select
						a.Id
						,a.Id_Padre
						,a.Nivel
						,a.Bit_Value
						,(
							select
								Isnull(MAX(Monedero_Amount),0)
							from
								(select
									Consecutivo_Interno
									,Cast(Monedero_Amount as numeric(18,9))	as Monedero_Amount
								from
									Transaccion	as b
								where
									@Exec_Time	between 
														case
															when @Opcion = 1
															then cast(convert(varchar(8),b.Fecha_Hora ,112)+ ' 00:00:00' as datetime)
															else b.Fecha_Hora 
														end
												and 
														case
															when @Opcion = 1
															then cast(convert(varchar(8),b.Fecha_Hora ,112)+ ' 23:59:59' as datetime)
															else dateadd(day,30,b.Fecha_Hora)
														end
									and Estado = 1
									and a.Id = b.ID_Usuario) as TSub1
									)	as Monedero_Amount
					from 
						[Tabla]	as a) as TSub1
			end

		if @Opcion = 3
			begin
				select
					@Resultado = Sum(Monedero_Amount)
				from
					(select
						(select
							Isnull(MAX(Monedero_Amount),0)
						from
							(select
								Consecutivo_Interno
								,Cast(Monedero_Amount as numeric(18,9))	as Monedero_Amount
							from
								Transaccion	as c
							where
								@Exec_Time	between c.Fecha_Hora and dateadd(day,30,c.Fecha_Hora)
								and Estado = 1
								and b.ID_Usuario = c.ID_Usuario) as TSub1
								)	as Monedero_Amount
					from
						Usuario	as a	join
						Usuario	as b	on	a.ID_Usuario = b.ID_Usuario_Relacion
					where
						a.ID_Usuario = @Id) as TSub2
			end

		if @Resultado is null
			set @Resultado = 0

		return @Resultado
END
