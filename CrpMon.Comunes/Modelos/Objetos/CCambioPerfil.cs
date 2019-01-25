using CrpMon.Comunes.Modelos.Vistas;

namespace CrpMon.Comunes.Modelos.Objetos
{
    public class CCambioPerfil : CInicioSesion
    {
        public string Nombres { get; set; }
        public string Apellidos { get; set; }
        public string Correo { get; set; }
        public string Cartera { get; set; }
    }
}
