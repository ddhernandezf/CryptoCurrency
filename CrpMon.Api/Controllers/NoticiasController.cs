using CrpMon.CAD;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace CrpMon.Api.Controllers
{
    public class NoticiasController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Consultar()
        {

            HttpResponseMessage respuesta = null;

            try
            {
                CripMonEntities db = new CripMonEntities();

                List<PA_bsc_Notificaciones_Result> data = db.PA_bsc_Notificaciones().ToList();

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
