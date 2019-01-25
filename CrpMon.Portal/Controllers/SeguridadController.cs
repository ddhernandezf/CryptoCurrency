using System;
using System.Net;
using System.Configuration;
using System.Web.Mvc;
using System.Threading.Tasks;
using System.Collections.Generic;
using CrpMon.Comunes.Modelos.Objetos;
using CrpMon.Comunes.Modelos.Vistas;
using CrpMon.ServiciosWeb;
using RestSharp;
using Newtonsoft.Json.Linq;

namespace CrpMon.Portal.Controllers
{
    [Idioma]
    public class SeguridadController : Controller
    {
        RestfulApi api = new RestfulApi(ConfigurationManager.AppSettings["APIURL"].ToString(),
                                        Convert.ToInt32(ConfigurationManager.AppSettings["GeneralTimeout"].ToString()));

        [ValidaSesion]
        public ActionResult IniciarSesion()
        {
            return View();
        }

        [ValidaUsuario]
        public ActionResult CerrarSesion()
        {
            Session.Clear();
            TempData.Clear();

            return RedirectToAction("Index", "Home");
        }

        [ValidaSesion]
        public ActionResult Registro()
        {
            return View();
        }

        [ValidaUsuario]
        public ActionResult PrimerCompra()
        {
            return View();
        }

        [ValidaUsuario]
        public ActionResult Confirmar()
        {
            return View();
        }

        [HttpPost]
        public JsonResult Autenticar(CInicioSesion modelo)
        {
            CPersona resultado = new CPersona();

            try
            {
                IRestResponse WSR = Task.Run(() => api.Post("Seguridad/Autenticar", modelo)).Result;
                if (WSR.StatusCode == HttpStatusCode.OK)
                {
                    bool bResult;
                    try
                    {
                        resultado = JObject.Parse(WSR.Content).ToObject<CPersona>();
                        Session["USUARIO"] = resultado;
                        Session["LOGIN"] = modelo;
                        bResult = true;
                    }
                    catch (Exception ex)
                    {
                        bResult = false;
                    }

                    return new JsonResult()
                    {
                        Data = bResult,
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
        public JsonResult Registrar(CRegistro modelo)
        {
            try
            {
                if (modelo != null)
                {
                    IRestResponse WSR = Task.Run(() => api.Put("Seguridad/Registrar", modelo)).Result;
                    if (WSR.StatusCode == HttpStatusCode.OK)
                    {
                        bool result = false;
                        bool.TryParse(WSR.Content, out result);
                            
                        Autenticar(new CInicioSesion() { vNombreUsuario = modelo.vNombreUsuario, vContrasena = modelo.vContrasena });

                        return new JsonResult()
                        {
                            Data = result,
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

        [HttpPost]
        public JsonResult Comprar(CProducto modelo)
        {
            try
            {
                if (modelo != null)
                {
                    CCompra compra = new CCompra() {
                        persona = (CPersona)Session["USUARIO"],
                        producto = modelo
                    };

                    IRestResponse WSR = Task.Run(() => api.Put("Registro/Compra", compra)).Result;
                    if (WSR.StatusCode == HttpStatusCode.OK)
                    {
                        bool result = false;
                        bool.TryParse(WSR.Content, out result);

                        Autenticar((CInicioSesion)Session["LOGIN"]);

                        if (result == true)
                        {
                            return new JsonResult()
                            {
                                Data = true,
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

        [ValidaUsuario]
        [HttpPost]
        public JsonResult Menu()
        {
            List<CMenu> data = new List<CMenu>();

            IRestResponse WSR = Task.Run(() => api.Get("Seguridad/Menu", "Idioma=" + Convert.ToInt32(Session["IDIOMA"].ToString()))).Result;
            if (WSR.StatusCode == HttpStatusCode.OK)
            {
                string urlbase = Url.Content("~/CrpMonPortal/Imagenes/Menu/");
                data = JArray.Parse(WSR.Content).ToObject<List<CMenu>>();

                data.ForEach(x => {
                    x.imageUrl = urlbase + x.imageUrl;
                    x.url = Url.Action(x.Accion, x.Controlador);
                });
            }
            
            return new JsonResult()
            {
                Data = data,
                ContentType = "json",
                MaxJsonLength = Int32.MaxValue,
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }

        [ValidaUsuario]
        [HttpPost]
        public JsonResult ValidarTran()
        {
            CInicioSesion login = (CInicioSesion)Session["LOGIN"];
            CTransaccion transaccion = (CTransaccion)Session["TRANSACCION"];

            IRestResponse WSR = Task.Run(() => api.Get("Operaciones/Verifica_EstadoTransaccion", "pUsuario=" + login.vNombreUsuario + "&pID_Transaccion_Monedero=" + transaccion.Transaccion_Monedero)).Result;
            if (WSR.StatusCode == HttpStatusCode.OK)
            {
                if (WSR.Content.ToString().Replace("\"","") == "Complete")
                {
                    Session.Clear();
                    TempData.Clear();

                    Autenticar(login);
                }
            }

            return new JsonResult()
            {
                Data = WSR.Content,
                ContentType = "json",
                MaxJsonLength = int.MaxValue,
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }

        [HttpGet]
        public JsonResult InfoConfirmar()
        {
            CTransaccion data = null;

            if (Session["TRANSACCION"] == null)
            {
                CPersona persona = (CPersona)Session["USUARIO"];

                IRestResponse WSR = Task.Run(() => api.Get("Registro/Transaccion_1_usuario", "pUsuario=" + persona.Usuario)).Result;
                if (WSR.StatusCode == HttpStatusCode.OK)
                {
                    data = JObject.Parse(WSR.Content).ToObject<CTransaccion>();
                    Session["TRANSACCION"] = data;
                }
            }
            else
            {
                data = (CTransaccion)Session["TRANSACCION"];
            }

            return new JsonResult()
            {
                Data = data,
                ContentType = "json",
                MaxJsonLength = int.MaxValue,
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }
    }
}