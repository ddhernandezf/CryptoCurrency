using CrpMon.CAD;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace CrpMon.Api.Controllers
{
    public class GananciasController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Consultar(string pUsuario)
        {

            HttpResponseMessage respuesta = null;

            try
            {
                CripMonEntities db = new CripMonEntities();

                PA_Gancias_Usuario_Result data = db.PA_Gancias_Usuario(pUsuario).FirstOrDefault();

                respuesta = Request.CreateResponse(HttpStatusCode.OK, data);

            }
            catch (Exception ex)
            {
                respuesta = Request.CreateErrorResponse(HttpStatusCode.Conflict, (ex.InnerException == null) ? ex.Message : ex.InnerException.Message);
            }

            return respuesta;
        }

        [HttpGet]
        public HttpResponseMessage Porcentajes(string pUsuario, byte pIdioma)
        {

            HttpResponseMessage respuesta = null;

            try
            {
                CripMonEntities db = new CripMonEntities();

                List<PA_bsc_Porcentajes_Result> data = db.PA_bsc_Porcentajes(pUsuario, pIdioma).ToList();

                respuesta = Request.CreateResponse(HttpStatusCode.OK, data);

            }
            catch (Exception ex)
            {
                respuesta = Request.CreateErrorResponse(HttpStatusCode.Conflict, (ex.InnerException == null) ? ex.Message : ex.InnerException.Message);
            }

            return respuesta;
        }
    }
}
