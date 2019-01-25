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
    public class CompraController : Controller
    {
        RestfulApi api = new RestfulApi(ConfigurationManager.AppSettings["APIURL"].ToString(),
                                        Convert.ToInt32(ConfigurationManager.AppSettings["GeneralTimeout"].ToString()));

        [ValidaUsuario]
        public ActionResult Index()
        {
            CPersona persona = (CPersona)Session["USUARIO"];

            IRestResponse wsrProd = Task.Run(() => api.Get("Perfil/PaqueteActual", "pUsuario=" + persona.Usuario
                                                                                    + "&pIdioma=" + Convert.ToInt32(Session["IDIOMA"].ToString()))).Result;
            if (wsrProd.StatusCode == HttpStatusCode.OK)
            {
                CProducto producto = JObject.Parse(wsrProd.Content).ToObject<CProducto>();
                ViewBag.MontoProductoActual = producto.Monto;
            }

            return View();
        }

        [HttpGet]
        public JsonResult ListarProductos()
        {
            try
            {
                IRestResponse WSR = Task.Run(() => api.Get("Operaciones/Lista_Producto", "Idioma=" + Convert.ToInt32(Session["IDIOMA"].ToString()))).Result;
                if (WSR.StatusCode == HttpStatusCode.OK)
                {
                    string urlbase = Url.Content("~/CrpMonPortal/Imagenes/Producto/");
                    List<CProducto> resultado = JArray.Parse(WSR.Content).ToObject<List<CProducto>>();
                    resultado.ForEach(x => {
                        x.Img_Url = urlbase + x.Img_Url;
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

        [HttpPost]
        public JsonResult Comprar(CProducto modelo)
        {
            try
            {
                if (modelo != null)
                {
                    CCompra compra = new CCompra()
                    {
                        persona = (CPersona)Session["USUARIO"],
                        producto = modelo
                    };

                    IRestResponse WSR = Task.Run(() => api.Post("Operaciones/Compra", compra)).Result;
                    if (WSR.StatusCode == HttpStatusCode.OK)
                    {
                        return new JsonResult()
                        {
                            Data = JObject.Parse(WSR.Content).ToObject<CTransaccion>(),
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
                else
                {
                    return new JsonResult()
                    {
                        Data = "El modelo viene nulo",
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