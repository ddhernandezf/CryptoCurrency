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
    public class RegistroController : ApiController
    {
        [HttpPut]
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

                    db.PA_Transaccion(cpRespuesta.result.txn_id,
                                        Convert.ToInt32(ConfigurationManager.AppSettings["Monedero"].ToString()),
                                        null,
                                        pModelo.persona.Usuario,
                                        jsonResult,
                                        pModelo.producto.Producto,
                                        cpRespuesta.result.amount,
                                        Convert.ToInt32(cpRespuesta.result.timeout),
                                        cpRespuesta.result.status_url,
                                        cpRespuesta.result.qrcode_url,
                                        cpRespuesta.result.address);

                    respuesta = Request.CreateResponse(HttpStatusCode.OK, true);
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
                            errResult = "Error desconocido.";
                            break;
                    }

                    respuesta = Request.CreateResponse(HttpStatusCode.NotImplemented, errResult);
                }
            }
            catch (Exception ex)
            {
                respuesta = Request.CreateErrorResponse(HttpStatusCode.Conflict, (ex.InnerException == null) ? ex.Message : ex.InnerException.Message);
            }

            return respuesta;
        }

        [HttpGet]
        public HttpResponseMessage Transaccion_1_Usuario(string pUsuario)
        {
            HttpResponseMessage respuesta = null;

            try
            {
                CripMonEntities db = new CripMonEntities();
                PA_bsc_Transaccion_1_Usuario_Result Transaccion_1 = db.PA_bsc_Transaccion_1_Usuario(pUsuario).FirstOrDefault();

                respuesta = Request.CreateResponse(HttpStatusCode.OK, Transaccion_1);
            }
            catch (Exception ex)
            {
                respuesta = Request.CreateErrorResponse(HttpStatusCode.Conflict, (ex.InnerException == null) ? ex.Message : ex.InnerException.Message);
            }

            return respuesta;
        }
    }
}
