using CrpMon.CAD;
using CrpMon.Comunes.Modelos;
using CrpMon.Comunes.Modelos.Vistas;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace CrpMon.Api.Controllers
{
    public class SeguridadController : ApiController
    {
        [HttpPost]
        public HttpResponseMessage Autenticar(CInicioSesion pModelo)
        {
            HttpResponseMessage respuesta = null;
            PA_Usuario_Auth_Result resultado = new PA_Usuario_Auth_Result();

            try
            {
                CripMonEntities db = new CripMonEntities();
                resultado = db.PA_Usuario_Auth(pModelo.vNombreUsuario, pModelo.vContrasena).FirstOrDefault();

                respuesta = Request.CreateResponse(HttpStatusCode.OK, resultado);
            }
            catch (Exception ex)
            {
                respuesta = Request.CreateErrorResponse(HttpStatusCode.Conflict, (ex.InnerException == null) ? ex.Message : ex.InnerException.Message);
            }

            return respuesta;
        }

        [HttpPut]
        public HttpResponseMessage Registrar(CRegistro pModelo)
        {
            HttpResponseMessage respuesta = null;
            CCoinPaymentMessage resultado = new CCoinPaymentMessage();

            try
            {
                CripMonEntities db = new CripMonEntities();

                db.PA_Usuario(pModelo.vNombreUsuario,
                                pModelo.vNombres,
                                pModelo.vApellidos,
                                pModelo.vCorreoElectronico,
                                pModelo.vContrasena,
                                pModelo.vPatrocinador,
                                pModelo.vCarteraCryptoMoneda);

                respuesta = Request.CreateResponse(HttpStatusCode.OK, true);
            }
            catch (Exception ex)
            {
                respuesta = Request.CreateErrorResponse(HttpStatusCode.Conflict, (ex.InnerException == null) ? ex.Message : ex.InnerException.Message);
            }

            return respuesta;
        }

        [HttpGet]
        public HttpResponseMessage Menu(byte Idioma)
        {

            HttpResponseMessage respuesta = null;

            try
            {
                CripMonEntities db = new CripMonEntities();

                List<PA_bsc_Menu_Result> data = db.PA_bsc_Menu(Idioma).ToList();

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
