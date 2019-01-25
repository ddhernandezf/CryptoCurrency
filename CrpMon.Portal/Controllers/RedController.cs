
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
    public class RedController : Controller
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
                IRestResponse WSR = Task.Run(() => api.Get("Red/Usuario_Arbol", "pUsuario=" + ((CPersona)Session["USUARIO"]).Usuario)).Result;
                if (WSR.StatusCode == HttpStatusCode.OK)
                {
                    List<CArbolBinario> resultado = JArray.Parse(WSR.Content).ToObject<List<CArbolBinario>>();
                    
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

        [HttpGet]
        public JsonResult CambiarPierna(Int32 Pierna)
        {
            bool result = false;
            try
            {
                IRestResponse WSR = Task.Run(() => api.Get("Usuario/Usuario_Bit_Default", "pUsuario=" + ((CPersona)Session["USUARIO"]).Usuario  + "&pBit_Default=" + Convert.ToBoolean(Pierna))).Result;
                if (WSR.StatusCode == HttpStatusCode.OK)
                {
                    CPersona persona = (CPersona)Session["USUARIO"];
                    persona.Bit_Default = Convert.ToBoolean(Pierna);
                    Session["USUARIO"] = persona;

                    result = true;
                }

                return new JsonResult()
                {
                    Data = result,
                    ContentType = "json",
                    MaxJsonLength = int.MaxValue,
                    JsonRequestBehavior = JsonRequestBehavior.AllowGet
                };
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