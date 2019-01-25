using CrpMon.Comunes.Modelos.Objetos;
using CrpMon.Comunes.Modelos.Vistas;
using CrpMon.ServiciosWeb;
using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Net;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace CrpMon.Portal.Controllers
{
    [Idioma]
    public class TransaccionController : Controller
    {
        RestfulApi api = new RestfulApi(ConfigurationManager.AppSettings["APIURL"].ToString(),
                                        Convert.ToInt32(ConfigurationManager.AppSettings["GeneralTimeout"].ToString()));

        [ValidaUsuario]
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public JsonResult Consultar()
        {
            try
            {
                IRestResponse WSR = Task.Run(() => api.Get("Operaciones/Lista_Transacciones", "pUsuario=" + ((CPersona)Session["USUARIO"]).Usuario)).Result;
                if (WSR.StatusCode == HttpStatusCode.OK)
                {
                    string urlbase = Url.Content("~/CrpMonPortal/Imagenes/Producto/");
                    List<CTransaccionCompra> resultado = JArray.Parse(WSR.Content).ToObject<List<CTransaccionCompra>>();
                    resultado.ForEach(x => {
                        x.ProductoImagen = urlbase + x.ProductoImagen;
                    });

                    return new JsonResult()
                    {
                        Data = resultado,
                        ContentType = "json",
                        MaxJsonLength = int.MaxValue,
                        JsonRequestBehavior = JsonRequestBehavior.AllowGet
                    };
                }
                else
                {
                    return new JsonResult()
                    {
                        Data = WSR.Content,
                        ContentType = "json",
                        MaxJsonLength = int.MaxValue,
                        JsonRequestBehavior = JsonRequestBehavior.AllowGet
                    };
                }
            }
            catch (Exception ex)
            {
                return new JsonResult()
                {
                    Data = ex.Message,
                    ContentType = "json",
                    MaxJsonLength = int.MaxValue,
                    JsonRequestBehavior = JsonRequestBehavior.AllowGet
                };
            }
        }
    }
}