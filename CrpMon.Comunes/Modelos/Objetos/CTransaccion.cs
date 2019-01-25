using System;

namespace CrpMon.Comunes.Modelos.Objetos
{
    public class CTransaccion
    {
        private DateTime fIni { get; set; }
        private DateTime fFin { get; set; }

        public long Consecutivo_Interno { get; set; }
        public string Transaccion_Monedero { get; set; }
        public int Monedero { get; set; }
        public byte[] Observacion_1 { get; set; }
        public long ID_Usuario { get; set; }
        public string Monedero_jsonResult { get; set; }
        public System.DateTime Fecha_Hora { get; set; }
        public int Producto { get; set; }
        public byte Estado { get; set; }
        public Nullable<System.DateTime> Fecha_Ini { get; set; }
        public Nullable<System.DateTime> Fecha_Fin { get; set; }
        public string Monedero_Amount { get; set; }
        public Nullable<int> Monedero_TimeOut { get; set; }
        public string Monedero_Status_Url { get; set; }
        public string Monedero_Qrcode_Url { get; set; }
        public string Monedero_Address { get; set; }
        public string TiempoAproximado { get {
                this.fIni = (DateTime)this.Fecha_Ini;
                this.fFin = (DateTime)this.Fecha_Fin;

                string result = (fFin - fIni).ToString();

                return result;
            } set { } }
    }
}
