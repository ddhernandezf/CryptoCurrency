using CrpMon.CAD;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace CrpMon.Api.Controllers
{
    public class MensajesController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Consultar(byte? pEstado, byte? pUsuario)
        {

            HttpResponseMessage respuesta = null;

            try
            {
                CripMonEntities db = new CripMonEntities();

                List<PA_bsc_Mensaje_Result> data = db.PA_bsc_Mensaje(pEstado, pUsuario).ToList();

                respuesta = Request.CreateResponse(HttpStatusCode.OK, data);

            }
            catch (Exception ex)
            {
                respuesta = Request.CreateErrorResponse(HttpStatusCode.Conflict, (ex.InnerException == null) ? ex.Message : ex.InnerException.Message);
            }

            return respuesta;
        }

        [HttpPost]
        public HttpResponseMessage Leido(PA_bsc_Mensaje_Result modelo)
        {

            HttpResponseMessage respuesta = null;

            try
            {
                CripMonEntities db = new CripMonEntities();

                db.PA_MensajeLeido(modelo.Mensaje);

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
