using CrpMon.CAD;
using CrpMon.Comunes.Modelos;
using CrpMon.Comunes.Modelos.Objetos;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace CrpMon.Api.Controllers
{
    public class OperacionesController : ApiController
    {
        [HttpGet]
        public HttpResponseMessage Lista_Producto(byte Idioma)
        {

            HttpResponseMessage respuesta = null;

            try
            {
                CripMonEntities db = new CripMonEntities();

                List<PA_bsc_Producto_Result> data = db.PA_bsc_Producto(Idioma).ToList();

                respuesta = Request.CreateResponse(HttpStatusCode.OK, data);

            }
            catch (Exception ex)
            {
                respuesta = Request.CreateErrorResponse(HttpStatusCode.Conflict, (ex.InnerException == null) ? ex.Message : ex.InnerException.Message);
            }

            return respuesta;
        }
        
        [HttpGet]
        public HttpResponseMessage Verifica_Estado_Transaccion(string pUsuario, string pID_Transaccion_Monedero)
        {
            HttpResponseMessage respuesta = null;

            try
            {
                CripMonEntities db = new CripMonEntities();

                PA_bsc_Empresa_Result Empresa = db.PA_bsc_Empresa(Convert.ToInt32(ConfigurationManager.AppSettings["Empresa"].ToString())).FirstOrDefault();

                var coinPayment = new CoinPayments(Empresa.Llave_Privada, Empresa.Llave_Publica);

                string jsonResult = null;

                SortedList<string, string> parms = new SortedList<string, string>();
                parms.Add("txid", pID_Transaccion_Monedero);

                var result = coinPayment.Get_Tx_Info(parms, out jsonResult);

                if (result["error"].ToString() == "ok")
                {

                    var ret = new Dictionary<string, object>();

                    Dictionary<string, object> res = result["result"] as Dictionary<string, object>;

                    string vEstado_Transaccion = res["status_text"].ToString();

                    if (vEstado_Transaccion == "Complete")
                    {

                        db.PA_Actualiza_Estado(pUsuario, pID_Transaccion_Monedero);
                    }

                    respuesta = Request.CreateResponse(HttpStatusCode.OK, vEstado_Transaccion);
                }
            }
            catch (Exception ex)
            {
                respuesta = Request.CreateErrorResponse(HttpStatusCode.Conflict, (ex.InnerException == null) ? ex.Message : ex.InnerException.Message);
            }

            return respuesta;
        }
        
        [HttpPost]
        public HttpResponseMessage Compra(CCompra pModelo)
        {
            HttpResponseMessage respuesta = null;

            try
            {
                CripMonEntities db = new CripMonEntities();
                PA_bsc_Empresa_Result Empresa = db.PA_bsc_Empresa(Convert.ToInt32(ConfigurationManager.AppSettings["Empresa"].ToString())).FirstOrDefault();

                CoinPayments payment = new CoinPayments(Empresa.Llave_Privada, Empresa.Llave_Publica);
                SortedList<string, string> parms = new SortedList<string, string>();
                parms.Add("amount", pModelo.producto.Monto.ToString());
                parms.Add("currency1", "ETH");
                parms.Add("currency2", "ETH");

                string jsonResult = null;
                Dictionary<string, object> result = payment.CreateTransaction(parms, out jsonResult);

                if (result["error"].ToString() == "ok")
                {


                    CCoinPaymentMessage cpRespuesta = (jsonResult == null) ? null : JObject.Parse(jsonResult).ToObject<CCoinPaymentMessage>();

                    PA_Transaccion_Result data = db.PA_Transaccion(cpRespuesta.result.txn_id,
                                                                    Convert.ToInt32(ConfigurationManager.AppSettings["Monedero"].ToString()),
                                                                    null,
                                                                    pModelo.persona.Usuario,
                                                                    jsonResult,
                                                                    pModelo.producto.Producto,
                                                                    cpRespuesta.result.amount,
                                                                    Convert.ToInt32(cpRespuesta.result.timeout),
                                                                    cpRespuesta.result.status_url,
                                                                    cpRespuesta.result.qrcode_url,
                                                                    cpRespuesta.result.address).FirstOrDefault();

                    respuesta = Request.CreateResponse(HttpStatusCode.OK, data);
                }
                else
                {
                    string errResult = null;

                    switch (result["error"].ToString())
                    {
                        case "HMAC signature does not match":
                            errResult = "Cartera no reconocida";
                            break;
                        default:
                            errResult = "El servidor de criptomonedas se encuentra fuera de servicio. Intente nuevamente mas tarde.";
                            break;
                    }

                    respuesta = Request.CreateResponse(HttpStatusCode.Conflict, errResult);
                }
            }
            catch (Exception ex)
            {
                respuesta = Request.CreateErrorResponse(HttpStatusCode.Conflict, (ex.InnerException == null) ? ex.Message : ex.InnerException.Message);
            }

            return respuesta;
        }

        [HttpGet]
        public HttpResponseMessage Lista_Transacciones(string pUsuario)
        {

            HttpResponseMessage respuesta = null;

            try
            {
                CripMonEntities db = new CripMonEntities();

                List<PA_bsc_Transacciones_Result> data = db.PA_bsc_Transacciones(pUsuario).ToList();

                respuesta = Request.CreateResponse(HttpStatusCode.OK, data);

            }
            catch (Exception ex)
            {
                respuesta = Request.CreateErrorResponse(HttpStatusCode.Conflict, (ex.InnerException == null) ? ex.Message : ex.InnerException.Message);
            }

            return respuesta;
        }
    }
}
