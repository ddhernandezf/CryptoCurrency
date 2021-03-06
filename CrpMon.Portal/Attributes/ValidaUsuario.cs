﻿using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

public class ValidaUsuario : AuthorizeAttribute
{
    private HttpContextBase context;
    protected override bool AuthorizeCore(HttpContextBase httpContext)
    {
        this.context = httpContext;

        if (System.Web.HttpContext.Current.Session["USUARIO"] == null)
        {
            return false;
        }
        else
        {
            return true;
        }
    }

    protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
    {
        filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary() {
                {"controller","Seguridad"},
                {"action","IniciarSesion"}
            });
    }
}