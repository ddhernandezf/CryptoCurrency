CREATE PROCEDURE [dbo].[PA_Usuario_Arbol]
	@pUsuario varchar(50)
AS
	SET NOCOUNT ON
	DECLARE	@vID_Usuario BIGINT = (SELECT ID_Usuario from Usuario WHERE Usuario = @pUsuario);
	DECLARE	@Tabla AS TABLE (Id int,Id_Padre int,Nombres varchar(max),Monto varchar(max),[Image] varchar(max),[bit] int, [Des_Estado] varchar(max), [Des_Producto] varchar(max))

	declare @Id_Padre as table (Consecutivo int identity(1,1),Id int)

	declare
		@User			int
		,@Id			int
		,@Ini			int
		,@Fin			int
		,@vIni			int
		,@vFin			int
		,@pIni			int
		,@pFin			int
		,@Nivel			int
		,@Text			varchar(max) = ''
		,@Text1			varchar(max) = ''

	set @User = @vID_Usuario

	insert into @Tabla
	select 
		T5.ID_Usuario
		,T5.ID_Usuario_Padre
		,T1.Usuario
		,0					Monto
		,null				Imagen
		,T5.Bit_Value 
		,T2.Descripcion		Des_Estado
		,T4.Descripcion		Des_Producto
	from	
		Usuario			as T1	join
		Estado_Objeto	as T2	ON	T1.Estado		= T2.Estado_Objeto
								left join
		Transaccion		as T3	ON	T1.ID_Usuario	= T3.ID_Usuario
									and T3.Estado		= 1
								left join
		Producto		as T4	ON	T3.Producto		= T4.Producto
								join
		Usuario_Arbol	as T5	ON	T1.ID_Usuario	= T5.ID_Usuario

----------------------------------------------------------------------------------------------------------
;WITH hierarchy (Id, Id_Padre, Nivel)
as (
    select 
		Id
		,Id_Padre
		,1
    from 
		@Tabla
	where
		Id = @User

    union ALL

    select 
		a.Id
		,a.Id_Padre
		,b.Nivel + 1
    from 
		@Tabla		as a	JOIN 
		hierarchy	as b	ON a.Id_Padre = b.Id)
----------------------------------------------------------------------------------------------------------
select
	Identity(Int,1,1)	as Consecutivo
	,a.Id
	,isnull(a.Id_Padre,0)	as Id_Padre
	,a.Nivel
	,b.[bit]
	,Cast('"nombres": "'+b.Nombres+'",' + char(10)
	+' "monto": "'+b.Monto+'",' + char(10)
	+' "image": '+isnull(b.[Image],'null')+',' + char(10)
	+' "estado": "'+isnull(b.[Des_Estado],'null')+'",' + char(10)
	+' "producto": "'+isnull(b.[Des_Producto],'null')+'",' + char(10)
	+' "monto_diario_L": "'+Cast(Cast([dbo].[fMonedero_Amount](b.Id,0,1) as numeric(18,4)) as varchar(max))+' ETH",' + char(10)
	+' "monto_diario_R": "'+Cast(Cast([dbo].[fMonedero_Amount](b.Id,1,1) as numeric(18,4)) as varchar(max))+' ETH",' + char(10)
	+' "monto_acumulado_L": "'+Cast(Cast([dbo].[fMonedero_Amount](b.Id,0,2) as numeric(18,4)) as varchar(max))+' ETH",' + char(10)
	+' "monto_acumulado_R": "'+Cast(Cast([dbo].[fMonedero_Amount](b.Id,1,2) as numeric(18,4)) as varchar(max))+' ETH",' + char(10)
	+' "monto_directo_L": "'+Cast(Cast([dbo].[fMonedero_Amount](b.Id,0,3) as numeric(18,4)) as varchar(max))+' ETH",' + char(10)
	+' "monto_directo_R": "'+Cast(Cast([dbo].[fMonedero_Amount](b.Id,1,3) as numeric(18,4)) as varchar(max))+' ETH",' + char(10)
	+ '"items": '
	+	isnull((select top 1
			'    '
		from
			@Tabla	as c
		where
			a.Id = c.Id_Padre),'null') + char(10)
	as varchar(max) 
	) + char(10)	as Texto
	,Cast('' as varchar(max))	as [JSON]
into
	#Datos
from 
	hierarchy	as a	join
	@Tabla		as b	on	a.Id = b.Id
----------------------------------------------------------------------------------------------------------
--Completa ramas del arbol
select
	@Id = Max(Id)
from
	#Datos

insert into #Datos
select
	Rank()Over(Order By T1.Id) + @Id	as Id
	,T1.Id
	,T1.Nivel + 1
	,1-isnull(Max(T2.Bit),0)
	,'"nombres": "Disponible",' + char(10)
	+' "monto": null,' + char(10)
	+' "image": null,' + char(10)		
	+' "estado": null,' + char(10)
	+' "producto": null,' + char(10)
	+' "monto_diario_L": null,' + char(10)
	+' "monto_diario_R": null,' + char(10)
	+' "monto_acumulado_L": null,' + char(10)
	+' "monto_acumulado_R": null,' + char(10)
	+' "monto_directo_L": null,' + char(10)
	+' "monto_directo_R": null,' + char(10)
	+ '"items": null' + char(10)
	as Texto
	,Cast('' as varchar(max))	as [JSON]
from
	#Datos	as T1	join
	#Datos	as T2	on	T1.Id = T2.Id_Padre
group by
	T1.Id
	,T1.Nivel
having
	Count(*) = 1

select
	@Ini	= Min(Nivel)
	,@Fin	= Max(Nivel)
from 
	#Datos

while @Ini <= @Fin
	begin
		insert into @Id_Padre
		select
			isnull(Id_Padre,0)
		from
			#Datos
		where
			Nivel = @Fin
		group by
			Id_Padre

		select
			@pIni	= Min(Consecutivo)
			,@pFin	= Max(Consecutivo)
		from
			@Id_Padre

		while @pIni <= @pFin
			begin
				update
					T1
				set
					[JSON]	=	case
									when T1.bit = 0 and T1.Id <> @User
									then '[{'+T1.Texto + isnull(T2.[JSON],'') + isnull(T3.[JSON],'')
									when T1.bit = 1 and T1.Id <> @User
									then '},{'+T1.Texto + isnull(T2.[JSON],'') + isnull(T3.[JSON],'')+'}]'
									when T1.bit = 0
									then '[{'+T1.Texto + isnull(T2.[JSON],'') + isnull(T3.[JSON],'')
									when T1.bit = 1
									then '[{'+T1.Texto + isnull(T2.[JSON],'') + isnull(T3.[JSON],'')
								end
				from
					#Datos		as T1	left join
					#Datos		as T2	on	T1.Id = T2.Id_Padre
											and T2.bit = 0
										left join
					#Datos		as T3	on	T1.Id =	T3.Id_Padre
											and T3.bit = 1
										join
					@Id_Padre	as T4	on	T1.Id_Padre = T4.Id
				where
					T1.Nivel = @Fin
					and T4.Consecutivo = @pIni

				set @pIni = @pIni + 1
			end

		delete from @Id_Padre
		set @Fin = @Fin - 1
	end

select 
	[JSON] + '}]'
from 
	#Datos
where
	Id = @vID_Usuario

drop table #Datos