using CrpMon.CAD;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace CrpMon.Api.Controllers
{
    public class UsuarioController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Usuario_Bit_Default(string pUsuario, Boolean pBit_Default)
        {
            HttpResponseMessage respuesta = null;

            try
            {
                CripMonEntities db = new CripMonEntities();

                db.PA_Usuario_Bit_Default(pUsuario, pBit_Default);

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
