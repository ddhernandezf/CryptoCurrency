using System;
using System.Collections.Generic;
using System.Web.Mvc;
using CrpMon.Comunes.Modelos.Vistas;
using CrpMon.Comunes.Modelos.Objetos;
using RestSharp;
using System.Threading.Tasks;
using System.Net;
using CrpMon.ServiciosWeb;
using System.Configuration;
using Newtonsoft.Json.Linq;

namespace CrpMon.Portal.Controllers
{
    [Idioma]
    public class GeneralesController : Controller
    {
        RestfulApi api = new RestfulApi(ConfigurationManager.AppSettings["APIURL"].ToString(),
                                        Convert.ToInt32(ConfigurationManager.AppSettings["GeneralTimeout"].ToString()));

        [HttpGet]
        public JsonResult Idiomas()
        {
            CLenguaje lenguaje = new CLenguaje();

            IRestResponse WSR = Task.Run(() => api.Get("Idiomas/Consultar", "Idioma=" + Convert.ToInt32(Session["IDIOMA"].ToString()))).Result;
            if (WSR.StatusCode == HttpStatusCode.OK)
            {
                List<CIdioma> idiomas = new List<CIdioma>();
                string urlbase = Url.Content("~/CrpMonPortal/Imagenes/Producto/");
                idiomas = JArray.Parse(WSR.Content).ToObject<List<CIdioma>>();

                idiomas.ForEach(x => {
                    x.Imagen = Url.Content("~/CrpMonPortal/Imagenes/Banderas/") + x.Imagen;
                });

                lenguaje.IdiomaSeleccionado = Convert.ToInt32(Session["IDIOMA"].ToString());
                lenguaje.Idiomas = idiomas;
            }
            
            return new JsonResult()
            {
                Data = lenguaje,
                ContentType = "json",
                MaxJsonLength = Int32.MaxValue,
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }

        [HttpGet]
        public JsonResult Vista(string pVista)
        {
            CVista data = new CVista();

            IRestResponse WSR = Task.Run(() => api.Get("Idiomas/Vista", "pVista=" + pVista
                                                                        + "&pIdioma=" + Convert.ToInt32(Session["IDIOMA"].ToString()))).Result;
            if (WSR.StatusCode == HttpStatusCode.OK)
            {
                data = JObject.Parse(WSR.Content).ToObject<CVista>();
            }

            return new JsonResult()
            {
                Data = data,
                ContentType = "json",
                MaxJsonLength = Int32.MaxValue,
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }

        [HttpPost]
        public JsonResult CambiarIdioma(int pIdioma)
        {
            Session["IDIOMA"] = pIdioma;

            return new JsonResult()
            {
                Data = true,
                ContentType = "json",
                MaxJsonLength = Int32.MaxValue,
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }

        [HttpGet]
        public ActionResult IframeView(string url)
        {
            ViewBag.url = url;
            return View();
        }

        [HttpPost]
        public JsonResult ValidarTran(String TransaccionId)
        {
            CInicioSesion login = (CInicioSesion)Session["LOGIN"];

            IRestResponse WSR = Task.Run(() => api.Get("Operaciones/Verifica_EstadoTransaccion", "pUsuario=" + login.vNombreUsuario + "&pID_Transaccion_Monedero=" + TransaccionId)).Result;

            return new JsonResult()
            {
                Data = WSR.Content,
                ContentType = "json",
                MaxJsonLength = int.MaxValue,
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }

        [HttpGet]
        public JsonResult Ganancias()
        {
            CGananciaUsuario data = new CGananciaUsuario();

            IRestResponse WSR = Task.Run(() => api.Get("Ganancias/Consultar", "pUsuario=" + ((CPersona)Session["USUARIO"]).Usuario)).Result;
            if (WSR.StatusCode == HttpStatusCode.OK)
            {
                string urlbase = Url.Content("~/CrpMonPortal/Imagenes/Producto/");
                data = JObject.Parse(WSR.Content).ToObject<CGananciaUsuario>();
            }

            return new JsonResult()
            {
                Data = data,
                ContentType = "json",
                MaxJsonLength = Int32.MaxValue,
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }

        [HttpGet]
        public JsonResult Porcentajes()
        {
            List<CPorcentaje> data = new List<CPorcentaje>();
            CInicioSesion login = (CInicioSesion)Session["LOGIN"];

            IRestResponse WSR = Task.Run(() => api.Get("Ganancias/Porcentajes", "pUsuario=" + login.vNombreUsuario + "&pIdioma=1")).Result;
            if (WSR.StatusCode == HttpStatusCode.OK)
            {
                string urlbase = Url.Content("~/CrpMonPortal/Imagenes/Producto/");
                data = JArray.Parse(WSR.Content).ToObject<List<CPorcentaje>>();
            }

            return new JsonResult()
            {
                Data = data,
                ContentType = "json",
                MaxJsonLength = Int32.MaxValue,
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }
    }
}