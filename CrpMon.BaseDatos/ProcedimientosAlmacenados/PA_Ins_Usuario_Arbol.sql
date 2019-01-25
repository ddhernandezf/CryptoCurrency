CREATE PROCEDURE [dbo].[PA_Ins_Usuario_Arbol]
	@pUsuario VARCHAR(50)
AS
	declare
	@vID_Usuario		bigint
	,@vID_Usuario_Padre	bigint
	,@vBit_Value		bit
	,@vNivel			int
	
select
	@vID_Usuario		= T1.ID_Usuario
	,@vID_Usuario_Padre	= dbo.fLast(T1.ID_Usuario_Relacion,T1.Bit_Value)
	,@vBit_Value		= T1.Bit_Value
from
	Usuario	as T1
where
	T1.Usuario = @pUsuario

select
	@vNivel = Nivel + 1
from
	Usuario
where
	ID_Usuario = @vID_Usuario_Padre

insert into Usuario_Arbol
select
	@vID_Usuario
	,@vID_Usuario_Padre
	,@vBit_Value
	,@vNivel
	,getdate()
	,null