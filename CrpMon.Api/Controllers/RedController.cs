using CrpMon.CAD;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using CrpMon.Comunes.Modelos.Objetos;
using Newtonsoft.Json.Linq;

namespace CrpMon.Api.Controllers
{
    public class RedController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Usuario_Arbol(String pUsuario)
        {

            HttpResponseMessage respuesta = null;

            try
            {
                CripMonEntities db = new CripMonEntities();
                string data = db.PA_Usuario_Arbol(pUsuario).FirstOrDefault();
                
                List<CArbolBinario> reg = JArray.Parse(data).ToObject<List<CArbolBinario>>();
                
                respuesta = Request.CreateResponse(HttpStatusCode.OK, reg);

            }
            catch (Exception ex)
            {
                respuesta = Request.CreateErrorResponse(HttpStatusCode.Conflict, (ex.InnerException == null) ? ex.Message : ex.InnerException.Message);
            }

            return respuesta;
        }
    }
}
