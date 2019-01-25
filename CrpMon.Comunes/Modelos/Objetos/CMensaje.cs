using System;

namespace CrpMon.Comunes.Modelos.Objetos
{
    public class CMensaje
    {
        public long Mensaje { get; set; }
        public byte Estado { get; set; }
        public long Usuario { get; set; }
        public string Asunto { get; set; }
        public string Contenido { get; set; }
        public DateTime FechaEmision { get; set; }
        public Nullable<DateTime> FechaLectura { get; set; }
        public byte Estado_Objeto { get; set; }
        public string Descripcion { get; set; }
    }
}
