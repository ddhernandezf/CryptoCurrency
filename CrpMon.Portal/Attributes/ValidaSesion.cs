using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using CrpMon.Comunes.Modelos.Vistas;

public class ValidaSesion : AuthorizeAttribute
{
    private HttpContextBase context;
    protected override bool AuthorizeCore(HttpContextBase httpContext)
    {
        this.context = httpContext;

        if (HttpContext.Current.Session["USUARIO"] == null)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
    {
        filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary() {
                {"controller","Home"},
                {"action","Index"}
            });
    }
}