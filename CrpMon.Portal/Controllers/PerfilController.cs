using CrpMon.Comunes.Modelos.Vistas;
using CrpMon.Comunes.Modelos.Objetos;
using System;
using System.Web.Mvc;
using RestSharp;
using System.Threading.Tasks;
using System.Net;
using CrpMon.ServiciosWeb;
using System.Configuration;
using Newtonsoft.Json.Linq;

namespace CrpMon.Portal.Controllers
{
    [Idioma]
    public class PerfilController : Controller
    {
        RestfulApi api = new RestfulApi(ConfigurationManager.AppSettings["APIURL"].ToString(),
                                        Convert.ToInt32(ConfigurationManager.AppSettings["GeneralTimeout"].ToString()));

        [ValidaUsuario]
        public ActionResult Index()
        {
            return View();
        }

        public JsonResult Consultar()
        {
            CPersona persona = (CPersona)Session["USUARIO"];
            CProducto producto = new CProducto();

            IRestResponse WSR = Task.Run(() => api.Get("Perfil/PaqueteActual", "pUsuario=" + persona.Usuario
                                                                                + "&pIdioma=" + Convert.ToInt32(Session["IDIOMA"].ToString()))).Result;
            if (WSR.StatusCode == HttpStatusCode.OK)
            {
                string urlbase = Url.Content("~/CrpMonPortal/Imagenes/Producto/");
                producto = JObject.Parse(WSR.Content).ToObject<CProducto>();
                producto.Img_Url = urlbase + producto.Img_Url;
            }

            CPerfil perfil = new CPerfil()
            {
                persona = persona,
                cambiarpassword = new CCambioPassword()
                {
                    vNombreUsuario = persona.Usuario,
                    vContrasena = null,
                    ConfirmaContrasena = null,
                    NuevaContrasena = null,
                },
                cambiarperfil = new CCambioPerfil()
                {
                    vNombreUsuario = persona.Usuario,
                    vContrasena = null,
                    Nombres = persona.Nombres,
                    Apellidos = persona.Apellidos,
                    Cartera = persona.Cartera_Criptomoneda,
                    Correo = persona.Correo_Electronico
                },
                producto = producto
            };

            return new JsonResult()
            {
                Data = perfil,
                ContentType = "json",
                MaxJsonLength = Int32.MaxValue,
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }

        [HttpPost]
        public JsonResult CambiarPassword(CCambioPassword modelo)
        {
            string result = null;
            IRestResponse WSR = Task.Run(() => api.Put("Perfil/CambiarPassword", modelo)).Result;
            if (WSR.StatusCode == HttpStatusCode.OK)
            {
                result = "OK";
            }
            else
            {
                result = WSR.Content.ToString().Replace("\"", "");
            }

            
            return new JsonResult()
            {
                Data = result,
                ContentType = "json",
                MaxJsonLength = Int32.MaxValue,
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }

        [HttpPost]
        public JsonResult CambiarDatos(CCambioPerfil modelo)
        {
            string result = null;
            IRestResponse WSR = Task.Run(() => api.Post("Perfil/CambiarDatos", modelo)).Result;
            if (WSR.StatusCode == HttpStatusCode.OK)
            {
                result = "OK";
                IRestResponse wsrAuth = Task.Run(() => api.Post("Seguridad/Autenticar", modelo)).Result;
                if (wsrAuth.StatusCode == HttpStatusCode.OK)
                {
                    Session["USUARIO"] = JObject.Parse(wsrAuth.Content).ToObject<CPersona>();
                }
            }
            else
            {
                result = WSR.Content.ToString().Replace("\"", "");
            }


            return new JsonResult()
            {
                Data = result,
                ContentType = "json",
                MaxJsonLength = Int32.MaxValue,
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }
    }
}