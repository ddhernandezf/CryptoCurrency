CREATE FUNCTION [dbo].[fLast]
(
	@Id int,
	@Bit_Default bit
)
RETURNS varchar(max)
	BEGIN 
		declare
			@vId int
		----------------------------------------------------------------------------------------------------------
		;WITH Bit_Default (Consecutivo,ID_Usuario,ID_Usuario_Padre,Bit_Value,Bit_Default)
		as (
		select
			1
			,ID_Usuario
			,ID_Usuario_Padre
			,cast(Bit_Value as bit)
			,@Bit_Default
		from
			Usuario_Arbol
		where
			ID_Usuario = @Id

		union all
	
		select
			Consecutivo + 1
			,T2.ID_Usuario
			,T2.ID_Usuario_Padre
			,cast(T2.Bit_Value as bit)
			,T2.Bit_Value
		from
			Bit_Default		as T1	join
			Usuario_Arbol	as T2	on	T1.ID_Usuario = T2.ID_Usuario_Padre
										and T2.Bit_Value = @Bit_Default)
		----------------------------------------------------------------------------------------------------------
		select
			@vId = ID_Usuario
		from
			Bit_Default
		where
			Consecutivo = (
							select
								Max(Consecutivo)
							from
								Bit_Default)
		----------------------------------------------------------------------------------------------------------
		if @vId is null
			set @vId = @Id
		----------------------------------------------------------------------------------------------------------
		return @vId
	END
