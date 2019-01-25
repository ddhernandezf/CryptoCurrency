using CrpMon.CAD;
using CrpMon.Comunes.Modelos.Objetos;
using System;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace CrpMon.Api.Controllers
{
    public class PerfilController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage PaqueteActual(string pUsuario, byte pIdioma)
        {

            HttpResponseMessage respuesta = null;

            try
            {
                CripMonEntities db = new CripMonEntities();

                PA_PaqueteActual_Result data = db.PA_PaqueteActual(pUsuario, pIdioma).FirstOrDefault();

                respuesta = Request.CreateResponse(HttpStatusCode.OK, data);

            }
            catch (Exception ex)
            {
                respuesta = Request.CreateErrorResponse(HttpStatusCode.Conflict, (ex.InnerException == null) ? ex.Message : ex.InnerException.Message);
            }

            return respuesta;
        }

        [HttpPost]
        public HttpResponseMessage CambiarDatos(CCambioPerfil modelo)
        {
            HttpResponseMessage respuesta = null;

            try
            {
                CripMonEntities db = new CripMonEntities();
                db.PA_Actualiza_Usuario(modelo.vNombreUsuario, modelo.vContrasena, modelo.Nombres, modelo.Apellidos, modelo.Correo, modelo.Cartera);

                respuesta = Request.CreateResponse(HttpStatusCode.OK, true);
            }
            catch (Exception ex)
            {
                respuesta = Request.CreateErrorResponse(HttpStatusCode.Conflict, (ex.InnerException == null) ? ex.Message : ex.InnerException.Message);
            }

            return respuesta;
        }

        [HttpPut]
        public HttpResponseMessage CambiarPassword(CCambioPassword modelo)
        {
            HttpResponseMessage respuesta = null;

            try
            {
                CripMonEntities db = new CripMonEntities();
                db.PA_Actualiza_Password(modelo.vNombreUsuario, modelo.vContrasena, modelo.NuevaContrasena);

                respuesta = Request.CreateResponse(HttpStatusCode.OK, true);
            }
            catch (Exception ex)
            {
                respuesta = Request.CreateErrorResponse(HttpStatusCode.Conflict, (ex.InnerException == null) ? ex.Message : ex.InnerException.Message);
            }

            return respuesta;
        }
    }
}
