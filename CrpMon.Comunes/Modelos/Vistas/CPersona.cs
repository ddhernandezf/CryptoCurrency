using System;

namespace CrpMon.Comunes.Modelos.Vistas
{
    public class CPersona
    {
        public long ID_Usuario { get; set; }
        public string Usuario { get; set; }
        public string Nombres { get; set; }
        public string Apellidos { get; set; }
        public string Correo_Electronico { get; set; }
        public string Cartera_Criptomoneda { get; set; }
        public long Nivel { get; set; }
        public bool Bit_Default { get; set; }
        public string Des_Estado { get; set; }
        public Nullable<long> ID_Usuario_Padre { get; set; }
        public string Patrocinador { get; set; }
    }
}
