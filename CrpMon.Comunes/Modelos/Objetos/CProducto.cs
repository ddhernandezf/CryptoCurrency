using System;

namespace CrpMon.Comunes.Modelos.Objetos
{
    public class CProducto
    {
        public int Producto { get; set; }
        public string Descripcion { get; set; }
        public Nullable<decimal> Monto { get; set; }
        public string Mensaje_Monto { get; set; }
        public Nullable<int> Cantidad_Binario { get; set; }
        public string Mensaje_Binario { get; set; }
        public Nullable<int> Cantidad_Alerta { get; set; }
        public string Mensaje_Alerta { get; set; }
        public Nullable<int> Periodo_Dia { get; set; }
        public string Mensaje_Dia { get; set; }
        public string Img_Url { get; set; }
        public Nullable<decimal> Out_Max { get; set; }
        public string Mensaje_OutMax { get; set; }

    }
}
