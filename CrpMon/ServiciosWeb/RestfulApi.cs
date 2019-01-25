using RestSharp;
using System;
using System.Net;

namespace CrpMon.ServiciosWeb
{
    public class RestfulApi
    {
        private String UrlBase { get; set; }

        private Int32 Timeout { get; set; }

        public RestfulApi(String urlbase, Int32 timeout)
        {
            this.UrlBase = urlbase;
            this.Timeout = timeout;
        }

        public IRestResponse Get(String UrlServicio, String Parametros)
        {
            ServicePointManager.ServerCertificateValidationCallback += (sender, certificate, chain, errors) => true;
            RestClient cliente = new RestClient(UrlBase);
            RestRequest request = new RestRequest(UrlServicio + "?" + Parametros, Method.GET);
            request.Timeout = Timeout;
            IRestResponse response = cliente.Execute(request);
            return response;
        }

        public IRestResponse Post(String UrlServicio, Object objeto)
        {
            ServicePointManager.ServerCertificateValidationCallback += (sender, certificate, chain, errors) => true;
            RestClient cliente = new RestClient(UrlBase);
            RestRequest request = new RestRequest(UrlServicio, Method.POST);
            request.Timeout = Timeout;
            request.AddJsonBody(objeto);
            IRestResponse response = cliente.Execute(request);

            return response;
        }

        public IRestResponse Put(String UrlServicio, Object objeto)
        {
            ServicePointManager.ServerCertificateValidationCallback += (sender, certificate, chain, errors) => true;
            RestClient cliente = new RestClient(UrlBase);
            RestRequest request = new RestRequest(UrlServicio, Method.PUT);
            request.Timeout = Timeout;
            request.AddJsonBody(objeto);
            IRestResponse response = cliente.Execute(request);

            return response;
        }

        public IRestResponse Delete(String UrlServicio, Object objeto)
        {
            ServicePointManager.ServerCertificateValidationCallback += (sender, certificate, chain, errors) => true;
            RestClient cliente = new RestClient(UrlBase);
            RestRequest request = new RestRequest(UrlServicio, Method.DELETE);
            request.Timeout = Timeout;
            request.AddJsonBody(objeto);
            IRestResponse response = cliente.Execute(request);

            return response;
        }
    }
}
