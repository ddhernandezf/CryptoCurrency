using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

public class Idioma : AuthorizeAttribute
{
    protected override bool AuthorizeCore(HttpContextBase httpContext)
    {
        if (System.Web.HttpContext.Current.Session["IDIOMA"] == null)
        {
            System.Web.HttpContext.Current.Session["IDIOMA"] = 1;
        }

        return true;
    }

    protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
    {
        filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary() {
                {"controller","Seguridad"},
                {"action","IniciarSesion"}
            });
    }
}