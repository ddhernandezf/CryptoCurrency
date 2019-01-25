using CrpMon.Comunes.Modelos.Vistas;

namespace CrpMon.Comunes.Modelos.Objetos
{
    public class CCambioPassword : CInicioSesion
    {
        public string NuevaContrasena { get; set; }
        public string ConfirmaContrasena { get; set; }
    }
}
