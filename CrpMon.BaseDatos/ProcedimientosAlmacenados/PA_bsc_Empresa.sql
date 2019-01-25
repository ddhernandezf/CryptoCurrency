CREATE PROCEDURE [dbo].[PA_bsc_Empresa]
	@pEmpresa INT
AS
	select 
         Empresa
        ,Nombre
        ,Llave_Privada
        ,Llave_Publica
        ,Correo_Electronico
        ,Estado 
	from Empresa
	where Empresa = @pEmpresa