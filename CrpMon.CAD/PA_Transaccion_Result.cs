//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace CrpMon.CAD
{
    using System;
    
    public partial class PA_Transaccion_Result
    {
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
    }
}