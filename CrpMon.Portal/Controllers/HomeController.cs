using CrpMon.Comunes.Modelos.Vistas;
using CrpMon.ServiciosWeb;
using System;
using System.Configuration;
using System.Web.Mvc;

namespace CrpMon.Portal.Controllers
{
    [Idioma]
    public class HomeController : Controller
    {
        RestfulApi api = new RestfulApi(ConfigurationManager.AppSettings["APIURL"].ToString(),
                                        Convert.ToInt32(ConfigurationManager.AppSettings["GeneralTimeout"].ToString()));

        [ValidaUsuario]
        public ActionResult Index()
        {
            if (((CPersona)Session["USUARIO"]).Des_Estado == "Pendiente Compra")
            {
                return RedirectToAction("PrimerCompra", "Seguridad");
            }
            else if (((CPersona)Session["USUARIO"]).Des_Estado == "Pendiente Pago")
            {
                return RedirectToAction("Confirmar", "Seguridad");
            }
            else
            {
                return View();
            }
        }

        [ValidaUsuario]
        public ActionResult Dashboard()
        {
            CPersona persona = (CPersona)Session["USUARIO"];

            ViewBag.Link = ConfigurationManager.AppSettings["URLPATROCINIO"].ToString() + "Unete/" + persona.Usuario;
            ViewBag.nombre = persona.Nombres + " " + persona.Apellidos;
            ViewBag.estado = persona.Des_Estado;

            return View();
        }

        public ActionResult UrlRegistro(string patrocinador)
        {
            if (patrocinador == null || string.IsNullOrEmpty(patrocinador) || string.IsNullOrWhiteSpace(patrocinador))
            {
                return RedirectToAction("CerrarSesion", "Seguridad");
            }
            else
            {
                TempData["PATROCINADOR"] = patrocinador;
                return RedirectToAction("Registro", "Seguridad");
            }
        }
    }
}